<?php

/* * 
 * 数据更新，也就是类似回调吧！
 * Some rights reserved：abc3210.com
 * Contact email:admin@abc3210.com
 */

class content_update {

    //信息ID
    protected $id = 0;
    //栏目ID
    protected $catid = 0;
    //模型ID
    protected $modelid = 0;
    //字段信息
    protected $fields = array();
    //模型缓存
    protected $model = array();
    //数据
    protected $data = array();
    //最近错误信息
    protected $error = '';
    // 数据表名（不包含表前缀）
    protected $tablename = '';

    function __construct($modelid) {
        $this->model = F("Model");
        $this->modelid = $modelid;
        if (empty($this->model[$this->modelid])) {
            $this->error('该模型不存在！');
            return false;
        }
        $this->fields = F("Model_field_" . $this->modelid);
        $this->tablename = trim($this->model[$this->modelid]['tablename']);
    }

    /**
     * 魔术方法，获取配置
     * @param type $name
     * @return type
     */
    public function __get($name) {
        return isset($this->data[$name]) ? $this->data[$name] : (isset($this->$name) ? $this->$name : NULL);
    }

    /**
     *  魔术方法，设置options参数
     * @param type $name
     * @param type $value
     */
    public function __set($name, $value) {
        $this->data[$name] = $value;
    }

    /**
     * 执行更新操作
     * @param type $data
     */
    public function update($data) {
        $info = array();
        $this->data = $data;
        $this->id = (int) $data['id'];
        $this->catid = (int) $data['catid'];
        foreach ($this->fields as $field => $fieldInfo) {
            if (empty($fieldInfo)) {
                continue;
            }
            if (!isset($this->data[$field])) {
                continue;
            }
            //字段类型
            $func = $fieldInfo['formtype'];
            //配置
            $setting = unserialize($fieldInfo['setting']);
            //字段值
            $value = method_exists($this, $func) ? $this->$func($field, $this->data[$field]) : $this->data[$field];
            //字段扩展，可以对字段内容进行再次处理，类似ECMS字段处理函数
            if ($setting['backstagefun'] || $setting['frontfun']) {
                load("@.treatfun");
                $backstagefun = explode("###", $setting['backstagefun']);
                $usfun = $backstagefun[0];
                $usparam = $backstagefun[1];
                //前后台
                if (defined("IN_ADMIN") && IN_ADMIN) {
                    //检查方法是否存在
                    if (function_exists($usfun)) {
                        //判断是入库执行类型
                        if ((int) $setting['backstagefun_type'] >= 2) {
                            //调用自定义函数，参数传入：模型id，栏目ID，信息ID，字段内容，字段名，操作类型，附加参数
                            // 例子 demo($modelid ,$value , $catid , $id, $field ,$action ,$param){}
                            try {
                                $value = call_user_func($usfun, $this->modelid, $this->id, $value, $field, ACTION_NAME, $usparam);
                            } catch (Exception $exc) {
                                //记录日志
                                Log::write("模型id:" . $this->modelid . ",错误信息：调用自定义函数" . $usfun . "出现错误！");
                            }
                        }
                    }
                } else {
                    //前台投稿处理自定义函数处理
                    //判断当前用户组是否拥有使用字段处理函数的权限，该功能暂时木有，以后加上
                    if (true) {
                        $backstagefun = explode("###", $setting['frontfun']);
                        $usfun = $backstagefun[0];
                        $usparam = $backstagefun[1];
                        //检查方法是否存在
                        if (function_exists($usfun)) {
                            //判断是入库执行类型
                            if ((int) $setting['backstagefun_type'] >= 2) {
                                //调用自定义函数，参数传入：模型id，栏目ID，信息ID，字段内容，字段名，操作类型，附加参数
                                // 例子 demo($modelid ,$value , $catid , $id, $field ,$action ,$param){}
                                try {
                                    $value = call_user_func($usfun, $this->modelid, $this->id, $value, $field, ACTION_NAME, $usparam);
                                } catch (Exception $exc) {
                                    //记录日志
                                    Log::write("模型id:" . $this->modelid . ",错误信息：调用自定义函数" . $usfun . "出现错误！");
                                }
                            }
                        }
                    }
                }
            }
            $info[$field] = $value;
        }
        return $info;
    }

    /**
     * 错误信息
     * @param type $message 错误信息
     * @param type $fields 字段
     */
    public function error($message, $fields = false) {
        $this->error = $message;
    }

    /**
     * 获取错误信息
     * @return type
     */
    public function getError() {
        return $this->error;
    }

    ##{字段处理函数}##
}