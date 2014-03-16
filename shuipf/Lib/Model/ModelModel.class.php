<?php

/**
 * 模型管理
 * Some rights reserved：abc3210.com
 * Contact email:admin@abc3210.com
 */
class ModelModel extends CommonModel {

    private $libPath = ''; //当前模块路径

    const mainTableSql = 'Sql/shuipfcms_zhubiao.sql'; //模型主表SQL模板文件
    const sideTablesSql = 'Sql/shuipfcms_zhubiao_data.sql'; //模型副表SQL模板文件
    const modelTablesInsert = 'Sql/shuipfcms_insert.sql'; //可用默认模型字段
    const membershipModelSql = 'Sql/shuipfcms_member.sql'; //会员模型

    //array(验证字段,验证规则,错误提示,[验证条件,附加规则,验证时间])

    protected $_validate = array(
        array('name', 'require', '模型名称不能为空！'),
        array('tablename', 'require', '表名不能为空！'),
        array('name', '', '该模型名称已经存在！', 0, 'unique', 1),
        array('tablename', '', '该表名已经存在！', 0, 'unique', 3),
        array('tablename', 'checkTablesql', '创建模型所需要的SQL文件丢失，创建失败！', 1, 'callback', 3),
        array('tablename', 'checkTablename', '该表名是系统保留或者已经存在，不允许创建！', 0, 'callback', 1),
    );
    //array(填充字段,填充内容,[填充条件,附加规则])
    protected $_auto = array(
        array("disabled", 0),
        array("sort", 0),
        array('addtime', 'time', 1, 'function'),
    );

    protected function _initialize() {
        parent::_initialize();
        $this->libPath = APP_PATH . C('APP_GROUP_PATH') . '/Models/';
    }

    /**
     * 检查需要创建的表名是否为系统保留名称
     * @param type $tablename 表名，不带表前缀
     * @return boolean 存在返回false，不存在返回true
     */
    public function checkTablename($tablename) {
        if (!$tablename) {
            return false;
        }
        //检查是否在保留内
        if (in_array($tablename, array("member_group", "member_content"))) {
            return false;
        }
        //检查该表名是否存在
        if ($this->table_exists($tablename)) {
            return false;
        }

        return true;
    }

    //检查SQL文件是否存在！
    public function checkTablesql() {
        //检查主表结构sql文件是否存在
        if (!is_file($this->libPath . self::mainTableSql)) {
            return false;
        }
        if (!is_file($this->libPath . self::sideTablesSql)) {
            return false;
        }
        if (!is_file($this->libPath . self::modelTablesInsert)) {
            return false;
        }
        if (!is_file($this->libPath . self::membershipModelSql)) {
            return false;
        }
        return true;
    }

    /**
     * 创建会员模型
     * @param type $tableName 模型主表名称（不包含表前缀）
     * @param type $modelId 所属模型id
     * @return boolean
     */
    public function AddModelMember($tableName, $modelId) {
        if (empty($tableName)) {
            return false;
        }
        //表前缀
        $dbPrefix = C("DB_PREFIX");
        //读取会员模型SQL模板
        $membershipModelSql = file_get_contents($this->libPath . self::membershipModelSql);
        //表前缀，表名，模型id替换
        $sqlSplit = str_replace(array('@shuipfcms@', '@zhubiao@', '@modelid@'), array($dbPrefix, $tableName, $modelId), $membershipModelSql);
        return $this->sql_execute($sqlSplit);
    }

    /**
     * 创建模型
     * @param type $data 提交数据
     * @return boolean
     */
    public function addModel($data) {
        if (empty($data)) {
            return false;
        }
        //数据验证
        $data = $this->create($data, 1);
        if ($data) {
            //添加模型记录
            $modelid = $this->add($data);
            if ($modelid) {
                //创建数据表
                if ($this->createModel($data['tablename'], $modelid)) {
                    return $modelid;
                } else {
                    //表创建失败
                    $this->where(array("modelid" => $modelid))->delete();
                    $this->error = '数据表创建失败！';
                    return false;
                }
            } else {
                return false;
            }
        } else {
            return false;
        }
    }

    /**
     * 编辑模型
     * @param type $data 提交数据
     * @return boolean
     */
    public function editModel($data, $modelid = 0) {
        if (empty($data)) {
            return false;
        }
        //模型ID
        $modelid = $modelid ? $modelid : (int) $data['modelid'];
        if (!$modelid) {
            $this->error = '模型ID不能为空！';
            return false;
        }
        //查询模型数据
        $info = $this->where(array("modelid" => $modelid))->find();
        if (empty($info)) {
            $this->error = '该模型不存在！';
            return false;
        }
        $data['modelid'] = $modelid;
        //数据验证
        $data = $this->create($data, 2);
        if ($data) {
            //是否更改表名
            if ($info['tablename'] != $data['tablename'] && !empty($data['tablename'])) {
                //检查新表名是否存在
                if ($this->table_exists($data['tablename']) || $this->table_exists($data['tablename'] . '_data')) {
                    $this->error = '该表名已经存在！';
                    return false;
                }
                if (false !== $this->where(array("modelid" => $modelid))->save($data)) {
                    //表前缀
                    $dbPrefix = C("DB_PREFIX");
                    //表名更改
                    if (!$this->sql_execute("RENAME TABLE  `{$dbPrefix}{$info['tablename']}` TO  `{$dbPrefix}{$data['tablename']}` ;")) {
                        $this->error = '数据库修改表名失败！';
                        return false;
                    }
                    //修改副表
                    if (!$this->sql_execute("RENAME TABLE  `{$dbPrefix}{$info['tablename']}_data` TO  `{$dbPrefix}{$data['tablename']}_data` ;")) {
                        //主表已经修改，进行回滚
                        $this->sql_execute("RENAME TABLE  `{$dbPrefix}{$data['tablename']}` TO  `{$dbPrefix}{$info['tablename']}` ;");
                        $this->error = '数据库修改副表表名失败！';
                        return false;
                    }
                    return true;
                } else {
                    $this->error = '模型更新失败！';
                    return false;
                }
            } else {
                if (false !== $this->where(array("modelid" => $modelid))->save($data)) {
                    return true;
                } else {
                    $this->error = '模型更新失败！';
                    return false;
                }
            }
        } else {
            return false;
        }
    }

    /**
     * 创建内容模型
     * @param type $tableName 模型主表名称（不包含表前缀）
     * @param type $modelId 模型id
     * @return boolean
     */
    protected function createModel($tableName, $modelId) {
        if (empty($tableName) || $modelId < 1) {
            return false;
        }
        //表前缀
        $dbPrefix = C("DB_PREFIX");
        //读取模型主表SQL模板
        $mainTableSqll = file_get_contents($this->libPath . self::mainTableSql);
        //副表
        $sideTablesSql = file_get_contents($this->libPath . self::sideTablesSql);
        //字段数据
        $modelTablesInsert = file_get_contents($this->libPath . self::modelTablesInsert);
        //表前缀，表名，模型id替换
        $sqlSplit = str_replace(array('@shuipfcms@', '@zhubiao@', '@modelid@'), array($dbPrefix, $tableName, $modelId), $mainTableSqll . "\n" . $sideTablesSql . "\n" . $modelTablesInsert);

        return $this->sql_execute($sqlSplit);
    }

    /**
     * 删除表
     * $table 不带表前缀
     */
    public function deleteTable($table) {
        if ($this->table_exists($table)) {
            $this->drop_table($table);
        }
        return true;
    }

    /**
     * 根据模型ID删除模型
     * @param type $modelid 模型id
     * @return boolean
     */
    public function deleteModel($modelid) {
        if (empty($modelid)) {
            return false;
        }
        //这里可以根据缓存获取表名
        $modeldata = $this->where(array("modelid" => $modelid))->find();
        if (!$modeldata) {
            return false;
        }
        //表名
        $model_table = $modeldata['tablename'];
        //删除模型数据
        $this->where(array("modelid" => $modelid))->delete();
        //删除所有和这个模型相关的字段
        D("ModelField")->where(array("modelid" => $modelid))->delete();
        //删除主表
        $this->deleteTable($model_table);
        if ((int) $modeldata['type'] == 0) {
            //删除副表
            $this->DeleteTable($model_table . "_data");
        }
        return true;
    }

    //兼容方法...
    public function delete_model($modelid) {
        return $this->deleteModel($modelid);
    }

    /**
     * 执行SQL
     * @param type $sqls SQL语句
     * @return boolean
     */
    protected function sql_execute($sqls) {
        $sqls = $this->sql_split($sqls);
        if (is_array($sqls)) {
            foreach ($sqls as $sql) {
                if (trim($sql) != '') {
                    $this->execute($sql, true);
                }
            }
        } else {
            $this->execute($sqls, true);
        }
        return true;
    }

    /**
     * SQL语句预处理
     * @param type $sql
     * @return type
     */
    public function sql_split($sql) {
        if (mysql_get_server_info() > '4.1' && C('DB_CHARSET')) {
            $sql = preg_replace("/TYPE=(InnoDB|MyISAM|MEMORY)( DEFAULT CHARSET=[^; ]+)?/", "ENGINE=\\1 DEFAULT CHARSET=" . C('DB_CHARSET'), $sql);
        }
        if (C("DB_PREFIX") != "shuipfcms_") {
            $sql = str_replace("shuipfcms_", C("DB_PREFIX"), $sql);
        }
        $sql = str_replace("\r", "\n", $sql);
        $ret = array();
        $num = 0;
        $queriesarray = explode(";\n", trim($sql));
        unset($sql);
        foreach ($queriesarray as $query) {
            $ret[$num] = '';
            $queries = explode("\n", trim($query));
            $queries = array_filter($queries);
            foreach ($queries as $query) {
                $str1 = substr($query, 0, 1);
                if ($str1 != '#' && $str1 != '-')
                    $ret[$num] .= $query;
            }
            $num++;
        }
        return $ret;
    }

    /**
     * 根据模型类型取得数据用于缓存
     * @param type $type
     * @return type
     */
    public function Cache($type = null) {
        $where = array("disabled" => 0);
        if (!is_null($type)) {
            $where['type'] = $type;
        }
        $data = $this->where($where)->select();
        $Cache = array();
        foreach ($data as $v) {
            $Cache[$v['modelid']] = $v;
        }
        return $Cache;
    }

    /**
     * 生成模型缓存，以模型ID为下标的数组 
     * @return boolean
     */
    public function model_cache() {
        $modelData = $this->Cache();
        $modelType = array();
        //对模型进行分类
        foreach ($modelData as $mid => $info) {
            $modelType[$info['type']][$info['modelid']] = $info;
        }
        F("Model", $modelData);
        D("Model_field")->model_field_cache();
        //按模型类型生成模型缓存
        foreach ($modelType as $type => $model) {
            F("ModelType_{$type}", $model);
        }
        return true;
    }

    /**
     * 生成会员模型缓存 
     * @return boolean
     */
    public function MemberModelCache() {
        F("Model_Member", $this->Cache(2));
        //会员模型配置信息
        $setting = M("Module")->where(array("module" => "Member"))->getField("setting");
        F("Member_Config", unserialize($setting));
        return true;
    }

    /**
     * 后台有更新则删除缓存
     * @param type $data
     */
    public function _before_write($data) {
        parent::_before_write($data);
        F("Model", NULL);
    }

    //删除操作时删除缓存
    public function _after_delete($data, $options) {
        parent::_after_delete($data, $options);
        $this->model_cache();
    }

    //更新数据后更新缓存
    public function _after_update($data, $options) {
        parent::_after_update($data, $options);
        $this->model_cache();
    }

    //插入数据后更新缓存
    public function _after_insert($data, $options) {
        parent::_after_insert($data, $options);
        $this->model_cache();
    }

}

?>
