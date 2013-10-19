<?php

/**
 * 点击数获取与增加
 * Some rights reserved：abc3210.com
 * Contact email:admin@abc3210.com
 */
class HitsAction extends Action {

    //内容模型
    protected $db;
    //模型缓存
    protected $cacheModel;
    //栏目缓存
    protected $cacheCategorys;

    //初始化
    protected function _initialize() {
        $this->cacheModel = F('Model');
        $this->cacheCategorys = F('Category');
    }

    //获取点击数
    public function index() {
        //栏目ID
        $catid = I('get.catid', 0, 'intval');
        //信息ID
        $id = I('get.id', 0, 'intval');
        //模型ID
        $modelid = (int) $this->cacheCategorys[$catid]['modelid'];
        //获取表名
        $tablename = $this->cacheModel[$modelid]['tablename'];
        if (empty($tablename)) {
            exit;
        }
        $this->db = M(ucwords($tablename));
        $r = $this->db->where(array('id' => $id))->field('catid,id,dayviews,monthviews,views,weekviews,yesterdayviews,viewsupdatetime')->find();
        if (empty($r)) {
            exit;
        }
        $r['modelid'] = $modelid;
        //增加点击率
        $this->hits($r);
        echo json_encode($r);
    }

    /**
     * 增加点击数 
     * @param type $r 点击相关数据
     * @return boolean
     */
    private function hits($r) {
        if (empty($r)) {
            return false;
        }
        //当前时间
        $time = time();
        //总点击+1
        $views = $r['views'] + 1;
        //昨日
        $yesterdayviews = (date('Ymd', $r['viewsupdatetime']) == date('Ymd', strtotime('-1 day'))) ? $r['dayviews'] : $r['yesterdayviews'];
        //今日点击
        $dayviews = (date('Ymd', $r['viewsupdatetime']) == date('Ymd', $time)) ? ($r['dayviews'] + 1) : 1;
        //本周点击
        $weekviews = (date('YW', $r['viewsupdatetime']) == date('YW', $time)) ? ($r['weekviews'] + 1) : 1;
        //本月点击
        $monthviews = (date('Ym', $r['viewsupdatetime']) == date('Ym', $time)) ? ($r['monthviews'] + 1) : 1;
        $data = array(
            'views' => $views,
            'yesterdayviews' => $yesterdayviews,
            'dayviews' => $dayviews,
            'weekviews' => $weekviews,
            'monthviews' => $monthviews,
            'viewsupdatetime' => $time
        );
        $status = $this->db->where(array('id' => $r['id']))->save($data);
        return false !== $status ? true : false;
    }

}