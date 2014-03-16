/*
Navicat MySQL Data Transfer

Source Server         : 本地
Source Server Version : 50041
Source Host           : 127.0.0.1:3306
Source Database       : shuipfcms

Target Server Type    : MYSQL
Target Server Version : 50041
File Encoding         : 65001

Date: 2013-06-22 22:34:19
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `shuipfcms_access`
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_access`;
CREATE TABLE `shuipfcms_access` (
  `role_id` smallint(6) unsigned NOT NULL,
  `g` varchar(20) NOT NULL COMMENT '项目',
  `m` varchar(20) NOT NULL COMMENT '模块',
  `a` varchar(20) NOT NULL COMMENT '方法',
  `status` tinyint(4) default '0' COMMENT '是否有效',
  KEY `role_id` (`role_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shuipfcms_access
-- ----------------------------

-- ----------------------------
-- Table structure for `shuipfcms_admin_panel`
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_admin_panel`;
CREATE TABLE `shuipfcms_admin_panel` (
  `menuid` mediumint(8) unsigned NOT NULL,
  `userid` mediumint(8) unsigned NOT NULL default '0',
  `name` char(32) default NULL,
  `url` char(255) default NULL,
  `datetime` int(10) unsigned default '0',
  UNIQUE KEY `userid` (`menuid`,`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shuipfcms_admin_panel
-- ----------------------------

-- ----------------------------
-- Table structure for `shuipfcms_article`
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_article`;
CREATE TABLE `shuipfcms_article` (
  `id` mediumint(8) unsigned NOT NULL auto_increment,
  `catid` smallint(5) unsigned NOT NULL default '0',
  `typeid` smallint(5) unsigned NOT NULL,
  `title` varchar(160) collate utf8_unicode_ci NOT NULL default '',
  `style` char(24) collate utf8_unicode_ci NOT NULL default '',
  `thumb` varchar(100) collate utf8_unicode_ci NOT NULL default '',
  `keywords` varchar(40) collate utf8_unicode_ci NOT NULL default '',
  `description` mediumtext collate utf8_unicode_ci NOT NULL,
  `url` char(100) collate utf8_unicode_ci NOT NULL,
  `listorder` tinyint(3) unsigned NOT NULL default '0',
  `status` tinyint(2) unsigned NOT NULL default '1',
  `sysadd` tinyint(1) unsigned NOT NULL default '0',
  `islink` tinyint(1) unsigned NOT NULL default '0',
  `username` char(20) collate utf8_unicode_ci NOT NULL,
  `inputtime` int(10) unsigned NOT NULL default '0',
  `updatetime` int(10) unsigned NOT NULL default '0',
  `posid` tinyint(3) unsigned NOT NULL default '0',
  `prefix` varchar(255) collate utf8_unicode_ci NOT NULL default '',
  `tags` varchar(255) collate utf8_unicode_ci NOT NULL default '',
  `views` int(11) NOT NULL DEFAULT '0' COMMENT '点击总数',
  `yesterdayviews` int(11) NOT NULL DEFAULT '0' COMMENT '最日',
  `dayviews` int(10) NOT NULL DEFAULT '0' COMMENT '今日点击数',
  `weekviews` int(10) NOT NULL DEFAULT '0' COMMENT '本周访问数',
  `monthviews` int(10) NOT NULL DEFAULT '0' COMMENT '本月访问',
  `viewsupdatetime` int(10) NOT NULL DEFAULT '0' COMMENT '点击数更新时间',
  PRIMARY KEY  (`id`),
  KEY `status` (`status`,`listorder`,`id`),
  KEY `listorder` (`catid`,`status`,`listorder`,`id`),
  KEY `catid` (`catid`,`status`,`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- ----------------------------
-- Table structure for `shuipfcms_article_data`
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_article_data`;
CREATE TABLE `shuipfcms_article_data` (
  `id` mediumint(8) unsigned default '0',
  `content` mediumtext collate utf8_unicode_ci NOT NULL,
  `paginationtype` tinyint(1) NOT NULL,
  `maxcharperpage` mediumint(6) NOT NULL,
  `template` varchar(30) collate utf8_unicode_ci NOT NULL default '',
  `paytype` tinyint(1) unsigned NOT NULL default '0',
  `allow_comment` tinyint(1) unsigned NOT NULL default '1',
  `relation` varchar(255) collate utf8_unicode_ci NOT NULL default '',
  `copyfrom` varchar(255) collate utf8_unicode_ci NOT NULL default '',
  `albums` mediumtext collate utf8_unicode_ci NOT NULL,
  `download` mediumtext collate utf8_unicode_ci NOT NULL,
  KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- ----------------------------
-- Table structure for `shuipfcms_attachment`
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_attachment`;
CREATE TABLE `shuipfcms_attachment` (
  `aid` int(10) unsigned NOT NULL auto_increment COMMENT '附件ID',
  `module` char(15) NOT NULL COMMENT '模块名称',
  `catid` smallint(5) NOT NULL COMMENT '栏目ID',
  `filename` char(50) NOT NULL COMMENT '上传附件名称',
  `filepath` char(200) NOT NULL COMMENT '附件路径',
  `filesize` int(10) unsigned NOT NULL default '0' COMMENT '附件大小',
  `fileext` char(10) NOT NULL COMMENT '附件扩展名',
  `isimage` tinyint(1) unsigned NOT NULL default '0' COMMENT '是否为图片 1为图片',
  `isthumb` tinyint(1) unsigned NOT NULL default '0' COMMENT '是否为缩略图 1为缩略图',
  `userid` mediumint(8) unsigned NOT NULL default '0' COMMENT '上传用户ID',
  `isadmin` tinyint(1) NOT NULL COMMENT '是否后台用户上传',
  `uploadtime` int(10) unsigned NOT NULL default '0' COMMENT '上传时间',
  `uploadip` char(15) NOT NULL COMMENT '上传ip',
  `status` tinyint(1) NOT NULL default '0' COMMENT '附件使用状态',
  `authcode` char(32) NOT NULL COMMENT '附件路径MD5值',
  PRIMARY KEY  (`aid`),
  KEY `authcode` (`authcode`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for `shuipfcms_attachment_index`
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_attachment_index`;
CREATE TABLE `shuipfcms_attachment_index` (
  `keyid` char(30) NOT NULL COMMENT '关联id',
  `aid` char(10) NOT NULL COMMENT '附件ID',
  KEY `keyid` (`keyid`),
  KEY `aid` (`aid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='附件关系表';

-- ----------------------------
-- Table structure for `shuipfcms_category`
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_category`;
CREATE TABLE `shuipfcms_category` (
  `catid` smallint(5) unsigned NOT NULL auto_increment COMMENT '栏目ID',
  `module` varchar(15) NOT NULL COMMENT '所属模块',
  `type` tinyint(1) unsigned NOT NULL default '0' COMMENT '类别',
  `modelid` smallint(5) unsigned NOT NULL default '0' COMMENT '模型ID',
  `domain` varchar(200) default NULL COMMENT '栏目绑定域名',
  `parentid` smallint(5) unsigned NOT NULL default '0' COMMENT '父ID',
  `arrparentid` varchar(255) NOT NULL COMMENT '所有父ID',
  `child` tinyint(1) unsigned NOT NULL default '0' COMMENT '是否存在子栏目，1存在',
  `arrchildid` mediumtext NOT NULL COMMENT '所有子栏目ID',
  `catname` varchar(30) NOT NULL COMMENT '栏目名称',
  `image` varchar(100) NOT NULL COMMENT '栏目图片',
  `description` mediumtext NOT NULL COMMENT '栏目描述',
  `parentdir` varchar(100) NOT NULL COMMENT '父目录',
  `catdir` varchar(30) NOT NULL COMMENT '栏目目录',
  `url` varchar(100) NOT NULL COMMENT '链接地址',
  `hits` int(10) unsigned NOT NULL default '0' COMMENT '栏目点击数',
  `setting` mediumtext NOT NULL COMMENT '相关配置信息',
  `listorder` smallint(5) unsigned NOT NULL default '0' COMMENT '排序',
  `ismenu` tinyint(1) unsigned NOT NULL default '1' COMMENT '是否显示',
  `sethtml` tinyint(1) unsigned NOT NULL default '0' COMMENT '是否生成静态',
  `letter` varchar(30) NOT NULL COMMENT '栏目拼音',
  PRIMARY KEY  (`catid`),
  KEY `module` (`module`,`parentid`,`listorder`,`catid`),
  KEY `siteid` (`type`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for `shuipfcms_category_priv`
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_category_priv`;
CREATE TABLE `shuipfcms_category_priv` (
  `catid` smallint(5) unsigned NOT NULL default '0',
  `roleid` smallint(5) unsigned NOT NULL default '0' COMMENT '角色或者组ID',
  `is_admin` tinyint(1) unsigned NOT NULL default '0' COMMENT '是否为管理员 1、管理员',
  `action` char(30) NOT NULL COMMENT '动作',
  KEY `catid` (`catid`,`roleid`,`is_admin`,`action`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='栏目权限表';

-- ----------------------------
-- Records of shuipfcms_category_priv
-- ----------------------------

-- ----------------------------
-- Table structure for `shuipfcms_censor_word`
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_censor_word`;
CREATE TABLE `shuipfcms_censor_word` (
  `id` smallint(6) unsigned NOT NULL auto_increment COMMENT '词汇id',
  `admin` varchar(15) NOT NULL default '' COMMENT '添加用户',
  `type` smallint(6) NOT NULL default '1' COMMENT '分类ID',
  `find` varchar(255) NOT NULL default '' COMMENT '不良词语',
  `replacement` varchar(255) NOT NULL default '' COMMENT '不良词语类型',
  `extra` varchar(255) NOT NULL default '' COMMENT '其他',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='词语过滤表';


-- ----------------------------
-- Table structure for `shuipfcms_comments`
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_comments`;
CREATE TABLE `shuipfcms_comments` (
  `id` bigint(20) unsigned NOT NULL auto_increment COMMENT '评论ID',
  `comment_id` char(30) NOT NULL COMMENT '所属文章id',
  `author` tinytext NOT NULL COMMENT '评论者名称',
  `author_email` varchar(100) NOT NULL default '' COMMENT '评论者电邮地址',
  `author_url` varchar(200) NOT NULL default '' COMMENT '评论者网址',
  `author_ip` varchar(100) NOT NULL default '' COMMENT '评论者的IP地址',
  `date` int(11) NOT NULL COMMENT '评论发表时间',
  `approved` varchar(20) NOT NULL default '1' COMMENT '评论状态，0为审核，1为正常',
  `agent` varchar(255) NOT NULL default '' COMMENT '评论者的客户端信息',
  `parent` bigint(20) unsigned NOT NULL default '0' COMMENT '上级评论id',
  `user_id` bigint(20) unsigned NOT NULL default '0' COMMENT '评论对应用户id',
  `stb` varchar(6) NOT NULL COMMENT '存放副表名',
  PRIMARY KEY  (`id`),
  KEY `comment_id` (`comment_id`),
  KEY `approved` (`approved`),
  KEY `parent` (`parent`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='评论表';

-- ----------------------------
-- Table structure for `shuipfcms_comments_data_1`
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_comments_data_1`;
CREATE TABLE `shuipfcms_comments_data_1` (
  `id` bigint(20) unsigned NOT NULL COMMENT '评论id',
  `comment_id` char(30) NOT NULL COMMENT '所属文章Id',
  `content` text NOT NULL COMMENT '评论内容',
  KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='评论副表1';

-- ----------------------------
-- Table structure for `shuipfcms_comments_emotion`
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_comments_emotion`;
CREATE TABLE `shuipfcms_comments_emotion` (
  `emotion_id` int(10) unsigned NOT NULL auto_increment COMMENT '表情ID',
  `emotion_name` varchar(20) NOT NULL default '' COMMENT '表情名称',
  `emotion_icon` varchar(50) NOT NULL default '' COMMENT '表情图标',
  `vieworder` int(10) unsigned NOT NULL default '0' COMMENT '排序',
  `isused` tinyint(3) unsigned NOT NULL default '1' COMMENT '是否使用',
  PRIMARY KEY  (`emotion_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='表情数据表';

-- ----------------------------
-- Records of shuipfcms_comments_emotion
-- ----------------------------

-- ----------------------------
-- Table structure for `shuipfcms_comments_field`
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_comments_field`;
CREATE TABLE `shuipfcms_comments_field` (
  `fid` smallint(6) NOT NULL auto_increment COMMENT '字段id',
  `f` varchar(30) NOT NULL COMMENT '字段名',
  `fname` varchar(30) NOT NULL COMMENT '字段标识',
  `fzs` varchar(255) NOT NULL COMMENT '注释',
  `ftype` varchar(30) NOT NULL COMMENT '字段类型',
  `flen` varchar(20) NOT NULL COMMENT '字段长度',
  `ismust` tinyint(1) NOT NULL COMMENT '1为必填，0为非必填',
  `issystem` tinyint(1) NOT NULL COMMENT '是否添加到主表',
  `regular` varchar(255) NOT NULL COMMENT '数据验证正则',
  `system` tinyint(1) NOT NULL COMMENT '是否系统字段',
  PRIMARY KEY  (`fid`),
  UNIQUE KEY `fname` (`fname`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='评论自定义字段表';

-- ----------------------------
-- Records of shuipfcms_comments_field
-- ----------------------------
INSERT INTO `shuipfcms_comments_field` VALUES ('1', 'author', '昵称', '昵称不能为空！', 'TEXT', '', '1', '1', '', '1');
INSERT INTO `shuipfcms_comments_field` VALUES ('2', 'author_email', '邮箱', '邮箱不能为空！', 'VARCHAR', '100', '1', '1', '/^[\\w\\-\\.]+@[\\w\\-\\.]+(\\.\\w+)+$/', '1');
INSERT INTO `shuipfcms_comments_field` VALUES ('3', 'author_url', '网站地址', '网站地址不能为空！', 'VARCHAR', '200', '0', '1', '/^http:\\/\\//', '1');

-- ----------------------------
-- Table structure for `shuipfcms_comments_setting`
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_comments_setting`;
CREATE TABLE `shuipfcms_comments_setting` (
  `guest` tinyint(1) NOT NULL COMMENT '是否允许游客评论',
  `code` tinyint(1) NOT NULL COMMENT '是否开启验证码',
  `check` tinyint(1) NOT NULL COMMENT '是否需要审核',
  `stb` tinyint(4) NOT NULL COMMENT '存储分表',
  `stbsum` int(4) NOT NULL COMMENT '分表总数',
  `order` varchar(20) NOT NULL COMMENT '排序',
  `strlength` int(5) NOT NULL COMMENT '允许最大字数',
  `status` tinyint(1) NOT NULL COMMENT '关闭/开启评论',
  `expire` int(11) NOT NULL COMMENT '评论间隔时间单位秒'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='评论配置';

-- ----------------------------
-- Records of shuipfcms_comments_setting
-- ----------------------------
INSERT INTO `shuipfcms_comments_setting` VALUES ('1', '0', '0', '1', '1', 'date DESC', '400', '1', '60');

-- ----------------------------
-- Table structure for `shuipfcms_config`
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_config`;
CREATE TABLE `shuipfcms_config` (
  `id` smallint(8) unsigned NOT NULL auto_increment,
  `varname` varchar(20) NOT NULL default '',
  `info` varchar(100) NOT NULL default '',
  `groupid` tinyint(3) unsigned NOT NULL default '1',
  `value` text NOT NULL,
  `type` tinyint(1) unsigned NOT NULL default '1',
  PRIMARY KEY  (`id`),
  KEY `varname` (`varname`)
) ENGINE=MyISAM AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shuipfcms_config
-- ----------------------------
INSERT INTO `shuipfcms_config` VALUES ('1', 'sitename', '网站名称', '2', 'ShuipFCMS内容管理系统', '2');
INSERT INTO `shuipfcms_config` VALUES ('2', 'siteurl', '网站网址', '2', '/', '2');
INSERT INTO `shuipfcms_config` VALUES ('3', 'sitefileurl', '附件地址', '2', '/d/file/', '2');
INSERT INTO `shuipfcms_config` VALUES ('4', 'siteemail', '站点邮箱', '2', 'admin@abc3210.com', '2');
INSERT INTO `shuipfcms_config` VALUES ('6', 'siteinfo', '网站介绍', '2', 'ShuipFCMS网站管理系统,是一款完全开源免费的PHP+MYSQL系统.核心采用了Thinkphp框架等众多开源软件,同时核心功能也作为开源软件发布', '2');
INSERT INTO `shuipfcms_config` VALUES ('7', 'sitekeywords', '网站关键字', '2', '', '2');
INSERT INTO `shuipfcms_config` VALUES ('8', 'uploadmaxsize', '允许上传附件大小', '2', '20240', '1');
INSERT INTO `shuipfcms_config` VALUES ('9', 'uploadallowext', '允许上传附件类型', '2', 'jpg|jpeg|gif|bmp|png|doc|docx|xls|xlsx|ppt|pptx|pdf|txt|rar|zip|swf', '1');
INSERT INTO `shuipfcms_config` VALUES ('10', 'qtuploadmaxsize', '前台允许上传附件大小', '2', '200', '1');
INSERT INTO `shuipfcms_config` VALUES ('11', 'qtuploadallowext', '前台允许上传附件类型', '2', 'jpg|jpeg|gif', '1');
INSERT INTO `shuipfcms_config` VALUES ('12', 'watermarkenable', '是否开启图片水印', '2', '1', '1');
INSERT INTO `shuipfcms_config` VALUES ('13', 'watermarkminwidth', '水印-宽', '2', '300', '1');
INSERT INTO `shuipfcms_config` VALUES ('14', 'watermarkminheight', '水印-高', '2', '100', '1');
INSERT INTO `shuipfcms_config` VALUES ('15', 'watermarkimg', '水印图片', '2', '/statics/images/mark_bai.png', '1');
INSERT INTO `shuipfcms_config` VALUES ('16', 'watermarkpct', '水印透明度', '2', '80', '1');
INSERT INTO `shuipfcms_config` VALUES ('17', 'watermarkquality', 'JPEG 水印质量', '2', '85', '1');
INSERT INTO `shuipfcms_config` VALUES ('18', 'watermarkpos', '水印位置', '2', '7', '1');
INSERT INTO `shuipfcms_config` VALUES ('19', 'indextp', '首页模板', '2', 'index.php', '2');
INSERT INTO `shuipfcms_config` VALUES ('20', 'theme', '主题风格', '2', 'Default', '2');
INSERT INTO `shuipfcms_config` VALUES ('21', 'generate', '是否生成首页', '2', '1', '2');
INSERT INTO `shuipfcms_config` VALUES ('22', 'tagurl', 'TagURL规则', '2', '8', '1');
INSERT INTO `shuipfcms_config` VALUES ('23', 'ftpstatus', 'FTP上传', '2', '0', '2');
INSERT INTO `shuipfcms_config` VALUES ('24', 'ftpuser', 'FTP用户名', '2', '', '2');
INSERT INTO `shuipfcms_config` VALUES ('25', 'ftppassword', 'FTP密码', '2', '', '2');
INSERT INTO `shuipfcms_config` VALUES ('26', 'ftphost', 'FTP服务器地址', '2', '', '2');
INSERT INTO `shuipfcms_config` VALUES ('27', 'ftpport', 'FTP服务器端口', '2', '21', '2');
INSERT INTO `shuipfcms_config` VALUES ('28', 'ftppasv', 'FTP是否开启被动模式', '2', '1', '2');
INSERT INTO `shuipfcms_config` VALUES ('29', 'ftpssl', 'FTP是否使用SSL连接', '2', '0', '2');
INSERT INTO `shuipfcms_config` VALUES ('30', 'ftptimeout', 'FTP超时时间', '2', '10', '2');
INSERT INTO `shuipfcms_config` VALUES ('31', 'ftpuppat', 'FTP上传目录', '2', '/', '2');
INSERT INTO `shuipfcms_config` VALUES ('32', 'mail_type', '邮件发送模式', '2', '1', '2');
INSERT INTO `shuipfcms_config` VALUES ('33', 'mail_server', '邮件服务器', '2', 'smtp.qq.com', '2');
INSERT INTO `shuipfcms_config` VALUES ('34', 'mail_port', '邮件发送端口', '2', '25', '2');
INSERT INTO `shuipfcms_config` VALUES ('35', 'mail_from', '发件人地址', '2', 'admin@abc3210.com', '2');
INSERT INTO `shuipfcms_config` VALUES ('36', 'mail_auth', 'AUTH LOGIN验证', '2', '1', '2');
INSERT INTO `shuipfcms_config` VALUES ('37', 'mail_user', '邮箱用户名', '2', '', '2');
INSERT INTO `shuipfcms_config` VALUES ('38', 'mail_password', '邮箱密码', '2', '', '2');
INSERT INTO `shuipfcms_config` VALUES ('39', 'mail_fname', '发件人名称', '2', 'ShuipFCMS管理员', '2');
INSERT INTO `shuipfcms_config` VALUES ('40', 'fileexclude', '远程下载过滤域名', '2', '', '2');
INSERT INTO `shuipfcms_config` VALUES ('41', 'index_urlruleid', '首页URL规则', '2', '11', '2');
INSERT INTO `shuipfcms_config` VALUES ('42', 'domainaccess', '指定域名访问', '2', '0', '2');

-- ----------------------------
-- Table structure for `shuipfcms_connect`
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_connect`;
CREATE TABLE `shuipfcms_connect` (
  `connectid` mediumint(8) NOT NULL auto_increment,
  `openid` varchar(32) NOT NULL COMMENT '授权标识',
  `uid` mediumint(8) NOT NULL COMMENT '用户ID',
  `app` varchar(10) NOT NULL COMMENT '应用名称',
  `accesstoken` char(50) NOT NULL COMMENT 'access_token',
  `expires` int(10) NOT NULL COMMENT 'token过期时间',
  PRIMARY KEY  (`connectid`),
  KEY `openid` (`openid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='登陆授权';

-- ----------------------------
-- Records of shuipfcms_connect
-- ----------------------------

-- ----------------------------
-- Table structure for `shuipfcms_customtemp`
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_customtemp`;
CREATE TABLE `shuipfcms_customtemp` (
  `tempid` smallint(6) NOT NULL auto_increment COMMENT '模板ID',
  `name` varchar(40) collate utf8_unicode_ci NOT NULL COMMENT '模板名称',
  `tempname` varchar(30) character set utf8 NOT NULL COMMENT '模板完整文件名',
  `temppath` varchar(200) character set utf8 NOT NULL COMMENT '模板生成路径',
  `temptext` mediumtext character set utf8 NOT NULL COMMENT '模板内容',
  PRIMARY KEY  (`tempid`),
  KEY `tempname` (`tempname`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='自定义模板表';

-- ----------------------------
-- Records of shuipfcms_customtemp
-- ----------------------------

-- ----------------------------
-- Table structure for `shuipfcms_links`
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_links`;
CREATE TABLE `shuipfcms_links` (
  `id` mediumint(8) unsigned NOT NULL auto_increment COMMENT '链接id',
  `url` varchar(255) NOT NULL default '' COMMENT '链接地址',
  `name` varchar(255) NOT NULL default '' COMMENT '链接名称',
  `image` varchar(255) NOT NULL default '' COMMENT '链接图片',
  `target` varchar(25) NOT NULL default '' COMMENT '链接打开方式',
  `description` varchar(255) NOT NULL default '' COMMENT '链接描述',
  `visible` tinyint(1) NOT NULL COMMENT '链接是否可见',
  `rating` int(11) NOT NULL default '0' COMMENT '链接等级',
  `updated` int(11) NOT NULL COMMENT '链接最后更新时间',
  `notes` mediumtext NOT NULL COMMENT '链接详细介绍',
  `rss` varchar(255) NOT NULL default '' COMMENT '链接RSS地址',
  `termsid` int(4) NOT NULL COMMENT '分类id',
  PRIMARY KEY  (`id`),
  KEY `visible` (`visible`),
  KEY `termsid` (`termsid`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='友情链接';

-- ----------------------------
-- Table structure for `shuipfcms_locking`
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_locking`;
CREATE TABLE `shuipfcms_locking` (
  `userid` int(11) NOT NULL COMMENT '用户ID',
  `username` varchar(30) NOT NULL COMMENT '用户名',
  `catid` smallint(5) NOT NULL COMMENT '栏目ID',
  `id` mediumint(8) NOT NULL COMMENT '信息ID',
  `locktime` int(10) NOT NULL COMMENT '锁定时间',
  KEY `userid` (`userid`),
  KEY `onlinetime` (`locktime`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='信息锁定';

-- ----------------------------
-- Records of shuipfcms_locking
-- ----------------------------

-- ----------------------------
-- Table structure for `shuipfcms_loginlog`
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_loginlog`;
CREATE TABLE `shuipfcms_loginlog` (
  `loginid` int(11) NOT NULL auto_increment COMMENT '日志ID',
  `username` varchar(30) character set utf8 NOT NULL default '' COMMENT '登录帐号',
  `logintime` datetime NOT NULL COMMENT '登录时间',
  `loginip` varchar(20) character set utf8 NOT NULL default '' COMMENT '登录IP',
  `status` tinyint(1) NOT NULL default '0' COMMENT '状态,1为登录成功，0为登录失败',
  `password` varchar(30) character set utf8 NOT NULL default '' COMMENT '尝试错误密码',
  `info` varchar(255) character set utf8 NOT NULL default '0' COMMENT '其他说明',
  PRIMARY KEY  (`loginid`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=gbk COMMENT='后台登陆日志表';

-- ----------------------------
-- Table structure for `shuipfcms_member`
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_member`;
CREATE TABLE `shuipfcms_member` (
  `userid` mediumint(8) unsigned NOT NULL auto_increment COMMENT '用户id',
  `username` char(20) NOT NULL default '' COMMENT '用户名',
  `password` char(32) NOT NULL default '' COMMENT '密码',
  `encrypt` char(6) NOT NULL COMMENT '随机码',
  `checked` tinyint(1) NOT NULL COMMENT '是否审核',
  `nickname` char(20) NOT NULL COMMENT '昵称',
  `userpic` varchar(200) NOT NULL COMMENT '会员头像',
  `regdate` int(10) unsigned NOT NULL default '0' COMMENT '注册时间',
  `lastdate` int(10) unsigned NOT NULL default '0' COMMENT '最后登录时间',
  `regip` char(15) NOT NULL default '' COMMENT '注册ip',
  `lastip` char(15) NOT NULL default '' COMMENT '上次登录ip',
  `loginnum` smallint(5) unsigned NOT NULL default '0' COMMENT '登陆次数',
  `email` char(32) NOT NULL default '' COMMENT '电子邮箱',
  `groupid` tinyint(3) unsigned NOT NULL default '0' COMMENT '用户组id',
  `areaid` smallint(5) unsigned NOT NULL default '0' COMMENT '地区id',
  `amount` decimal(8,2) unsigned NOT NULL default '0.00' COMMENT '钱金总额',
  `point` smallint(5) unsigned NOT NULL default '0' COMMENT '积分',
  `modelid` smallint(5) unsigned NOT NULL default '0' COMMENT '模型id',
  `message` tinyint(1) unsigned NOT NULL default '0' COMMENT '是否有短消息',
  `islock` tinyint(1) unsigned NOT NULL default '0' COMMENT '是否锁定',
  `vip` tinyint(1) NOT NULL COMMENT 'vip等级',
  `overduedate` int(10) NOT NULL COMMENT 'vip过期时间',
  PRIMARY KEY  (`userid`),
  UNIQUE KEY `username` (`username`),
  KEY `email` (`email`(20))
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='会员表';

-- ----------------------------
-- Records of shuipfcms_member
-- ----------------------------

-- ----------------------------
-- Table structure for `shuipfcms_member_content`
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_member_content`;
CREATE TABLE `shuipfcms_member_content` (
  `id` int(10) NOT NULL auto_increment,
  `catid` smallint(5) NOT NULL COMMENT '栏目ID',
  `content_id` int(10) NOT NULL COMMENT '信息ID',
  `userid` mediumint(8) NOT NULL COMMENT '会员ID',
  `integral` tinyint(1) NOT NULL COMMENT '是否赠送过点数',
  `time` int(10) NOT NULL COMMENT '添加时间',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='会员投稿信息记录表';

-- ----------------------------
-- Records of shuipfcms_member_content
-- ----------------------------

-- ----------------------------
-- Table structure for `shuipfcms_member_detail`
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_member_detail`;
CREATE TABLE `shuipfcms_member_detail` (
  `userid` mediumint(8) unsigned NOT NULL,
  `birthday` int(10) unsigned NOT NULL default '0',
  UNIQUE KEY `userid` (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shuipfcms_member_detail
-- ----------------------------

-- ----------------------------
-- Table structure for `shuipfcms_member_group`
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_member_group`;
CREATE TABLE `shuipfcms_member_group` (
  `groupid` tinyint(3) unsigned NOT NULL auto_increment COMMENT '会员组id',
  `name` char(15) NOT NULL COMMENT '用户组名称',
  `issystem` tinyint(1) unsigned NOT NULL default '0' COMMENT '是否是系统组',
  `starnum` tinyint(2) unsigned NOT NULL COMMENT '会员组星星数',
  `point` smallint(6) unsigned NOT NULL COMMENT '积分范围',
  `allowmessage` smallint(5) unsigned NOT NULL default '0' COMMENT '许允发短消息数量',
  `allowvisit` tinyint(1) unsigned NOT NULL default '0' COMMENT '是否允许访问',
  `allowpost` tinyint(1) unsigned NOT NULL default '0' COMMENT '是否允许发稿',
  `allowpostverify` tinyint(1) unsigned NOT NULL COMMENT '是否投稿不需审核',
  `allowsearch` tinyint(1) unsigned NOT NULL default '0' COMMENT '是否允许搜索',
  `allowupgrade` tinyint(1) unsigned NOT NULL default '1' COMMENT '是否允许自主升级',
  `allowsendmessage` tinyint(1) unsigned NOT NULL COMMENT '允许发送短消息',
  `allowpostnum` smallint(5) unsigned NOT NULL default '0' COMMENT '每天允许发文章数',
  `allowattachment` tinyint(1) NOT NULL COMMENT '是否允许上传附件',
  `icon` char(255) NOT NULL COMMENT '用户组图标',
  `usernamecolor` char(7) NOT NULL COMMENT '用户名颜色',
  `description` char(100) NOT NULL COMMENT '描述',
  `sort` tinyint(3) unsigned NOT NULL default '0' COMMENT '序排',
  `disabled` tinyint(1) unsigned NOT NULL default '0' COMMENT '是否禁用',
  `expand` mediumtext NOT NULL COMMENT '扩展',
  PRIMARY KEY  (`groupid`),
  KEY `disabled` (`disabled`),
  KEY `listorder` (`sort`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='会员组';

-- ----------------------------
-- Records of shuipfcms_member_group
-- ----------------------------
INSERT INTO `shuipfcms_member_group` VALUES ('8', '游客', '1', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '', '', '', '0', '0', '');
INSERT INTO `shuipfcms_member_group` VALUES ('2', '新手上路', '1', '1', '50', '100', '1', '1', '0', '1', '0', '1', '0', '0', '', '', '', '2', '0', '');
INSERT INTO `shuipfcms_member_group` VALUES ('6', '注册会员', '1', '2', '100', '150', '0', '1', '0', '1', '1', '1', '0', '1', '', '', '', '6', '0', '');
INSERT INTO `shuipfcms_member_group` VALUES ('4', '中级会员', '1', '3', '150', '500', '1', '1', '0', '1', '1', '1', '0', '1', '', '', '', '4', '0', '');
INSERT INTO `shuipfcms_member_group` VALUES ('5', '高级会员', '1', '5', '300', '999', '1', '1', '1', '1', '1', '1', '0', '1', '', '', '', '5', '0', '');
INSERT INTO `shuipfcms_member_group` VALUES ('1', '禁止访问', '1', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '', '', '0', '0', '0', '');
INSERT INTO `shuipfcms_member_group` VALUES ('7', '邮件认证', '1', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', 'images/group/vip.jpg', '#000000', '', '7', '0', '');

-- ----------------------------
-- Table structure for `shuipfcms_menu`
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_menu`;
CREATE TABLE `shuipfcms_menu` (
  `id` smallint(6) unsigned NOT NULL auto_increment,
  `parentid` smallint(6) unsigned NOT NULL default '0',
  `app` char(20) NOT NULL COMMENT '应用名称app',
  `model` char(20) NOT NULL default '',
  `action` char(20) NOT NULL default '',
  `data` char(50) NOT NULL default '',
  `type` tinyint(1) NOT NULL default '0',
  `status` tinyint(1) unsigned NOT NULL default '0',
  `name` varchar(50) NOT NULL default '',
  `remark` varchar(255) NOT NULL default '',
  `listorder` smallint(6) unsigned NOT NULL default '0' COMMENT '排序ID',
  PRIMARY KEY  (`id`),
  KEY `status` (`status`),
  KEY `parentid` (`parentid`),
  KEY `model` (`model`)
) ENGINE=MyISAM AUTO_INCREMENT=236 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shuipfcms_menu
-- ----------------------------
INSERT INTO `shuipfcms_menu` VALUES ('35', '0', 'Member', 'Model', 'index', '', '0', '1', '我的面板', '', '1');
INSERT INTO `shuipfcms_menu` VALUES ('2', '0', 'Admin', 'Config', 'index', '', '0', '1', '设置', '网站参数信息设置！', '2');
INSERT INTO `shuipfcms_menu` VALUES ('36', '35', 'Admin', 'Adminmanage', 'myinfo', '', '0', '1', '个人信息', '个人信息', '0');
INSERT INTO `shuipfcms_menu` VALUES ('37', '36', 'Admin', 'Adminmanage', 'myinfo', '', '1', '1', '修改个人信息', '修改个人信息', '0');
INSERT INTO `shuipfcms_menu` VALUES ('8', '2', 'Admin', 'Config', 'index', '', '0', '1', '系统设置', '系统设置', '0');
INSERT INTO `shuipfcms_menu` VALUES ('33', '8', 'Admin', 'Menu', 'index', '', '1', '1', '后台菜单管理', '后台菜单管理', '0');
INSERT INTO `shuipfcms_menu` VALUES ('10', '8', 'Admin', 'Config', 'index', '', '1', '1', '站点配置', '站点配置', '1');
INSERT INTO `shuipfcms_menu` VALUES ('38', '36', 'Admin', 'Adminmanage', 'chanpass', '', '1', '1', '修改密码', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('39', '2', 'Admin', 'Management', 'index', '', '0', '1', '管理员设置', '权限相关管理', '0');
INSERT INTO `shuipfcms_menu` VALUES ('40', '39', 'Admin', 'Management', 'manager', '', '1', '1', '管理员管理', '管理员管理', '0');
INSERT INTO `shuipfcms_menu` VALUES ('41', '39', 'Admin', 'Rbac', 'rolemanage', '', '1', '1', '管理员角色', '管理员角色', '0');
INSERT INTO `shuipfcms_menu` VALUES ('44', '2', 'Admin', 'Logs', 'index', '', '0', '1', '日志管理', '日志管理', '0');
INSERT INTO `shuipfcms_menu` VALUES ('45', '44', 'Admin', 'Logs', 'loginlog', '', '1', '1', '后台登陆日志', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('46', '44', 'Admin', 'Logs', 'index', '', '1', '1', '后台操作日志', '后台操作日志', '0');
INSERT INTO `shuipfcms_menu` VALUES ('51', '0', 'Admin', 'Content', 'index', '', '0', '1', '内容', '', '3');
INSERT INTO `shuipfcms_menu` VALUES ('52', '51', 'Contents', 'Content', 'index', '', '0', '1', '内容发布管理', '内容发布管理', '0');
INSERT INTO `shuipfcms_menu` VALUES ('54', '52', 'Attachment', 'Atadmin', 'index', '', '1', '1', '附件管理', '', '3');
INSERT INTO `shuipfcms_menu` VALUES ('55', '52', 'Comments', 'Comments', 'index', '', '1', '1', '评论管理', '', '2');
INSERT INTO `shuipfcms_menu` VALUES ('56', '51', 'Admin', 'Category', 'index', '', '0', '1', '内容相关设置', '', '2');
INSERT INTO `shuipfcms_menu` VALUES ('57', '56', 'Admin', 'Category', 'index', '', '1', '1', '管理栏目', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('58', '56', 'Models', 'Index', 'index', '', '1', '1', '模型管理', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('59', '52', 'Contents', 'Content', 'index', '', '1', '1', '管理内容', '', '1');
INSERT INTO `shuipfcms_menu` VALUES ('60', '0', 'Template', 'Style', 'index', '', '0', '1', '界面', '', '6');
INSERT INTO `shuipfcms_menu` VALUES ('61', '60', 'Template', 'Style', 'index', '', '0', '1', '模板管理', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('62', '61', 'Template', 'Style', 'index', '', '1', '1', '模板风格', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('63', '56', 'Admin', 'Urlrule', 'index', '', '1', '1', 'URL规则管理', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('64', '51', 'Contents', 'Createhtml', 'index', '', '0', '1', '发布管理', '', '1');
INSERT INTO `shuipfcms_menu` VALUES ('65', '64', 'Contents', 'Createhtml', 'category', '', '1', '1', '批量更新栏目页', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('66', '64', 'Contents', 'Createhtml', 'public_index', '', '1', '1', '生成首页', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('67', '64', 'Contents', 'Createhtml', 'update_urls', '', '1', '1', '批量更新URL', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('68', '64', 'Contents', 'Createhtml', 'update_show', '', '1', '1', '批量更新内容页', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('69', '61', 'Template', 'Theme', 'index', '', '1', '1', '主题管理', '风格管理', '0');
INSERT INTO `shuipfcms_menu` VALUES ('70', '60', 'Template', 'Custompage', 'index', '', '0', '1', '自定义页面', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('71', '70', 'Template', 'Custompage', 'index', '', '1', '1', '自定义页面', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('72', '64', 'Template', 'Custompage', 'createhtml', '', '1', '1', '刷新自定义页面', '刷新自定义页面', '0');
INSERT INTO `shuipfcms_menu` VALUES ('73', '0', 'Admin', 'Index', 'index', '', '0', '1', '模块', '', '5');
INSERT INTO `shuipfcms_menu` VALUES ('74', '73', 'Admin', 'Index', 'index', '', '0', '1', '模块列表', '', '2');
INSERT INTO `shuipfcms_menu` VALUES ('75', '74', 'Comments', 'Comments', 'config', '', '1', '1', '评论设置', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('77', '56', 'Contents', 'Position', 'index', '', '1', '1', '推荐位管理', '推荐位管理', '0');
INSERT INTO `shuipfcms_menu` VALUES ('82', '52', 'Tags', 'Tags', 'index', '', '1', '1', 'Tags管理', 'Tags管理', '4');
INSERT INTO `shuipfcms_menu` VALUES ('84', '73', 'Admin', 'Module', 'index', '', '0', '1', '模块管理', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('85', '0', 'Member', 'Setting', 'index', '', '0', '1', '用户', '', '4');
INSERT INTO `shuipfcms_menu` VALUES ('86', '85', 'Member', 'Member', 'index', '', '0', '1', '会员管理', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('87', '85', 'Member', 'Group', 'index', '', '0', '1', '会员组管理', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('88', '85', 'Member', 'Model', 'index', '', '0', '1', '会员模型管理', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('89', '86', 'Member', 'Member', 'index', '', '1', '1', '会员管理', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('90', '86', 'Member', 'Member', 'userverify', '', '1', '1', '审核会员', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('91', '86', 'Member', 'Setting', 'setting', '', '1', '1', '会员设置', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('92', '87', 'Member', 'Group', 'index', '', '1', '1', '会员组管理', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('93', '88', 'Member', 'Model', 'index', '', '1', '1', '模型管理', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('94', '33', 'Admin', 'Menu', 'add', '', '1', '1', '添加菜单', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('95', '33', 'Admin', 'Menu', 'edit', '', '1', '0', '修改', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('96', '33', 'Admin', 'Menu', 'delete', '', '1', '0', '删除', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('97', '58', 'Models', 'Index', 'add', '', '1', '1', '添加模型', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('98', '58', 'Models', 'Index', 'delete', '', '1', '0', '删除', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('99', '58', 'Models', 'Field', 'index', '', '1', '0', '字段管理', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('100', '58', 'Models', 'Index', 'disabled', '', '1', '0', '模型禁用', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('101', '58', 'Models', 'Index', 'edit', '', '1', '0', '模型修改', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('102', '99', 'Models', 'Field', 'edit', '', '1', '0', '字段修改', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('103', '99', 'Models', 'Field', 'delete', '', '1', '0', '字段删除', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('104', '99', 'Models', 'Field', 'disabled', '', '1', '0', '字段状态', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('105', '10', 'Admin', 'Config', 'mail', '', '1', '1', '邮箱配置', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('106', '10', 'Admin', 'Config', 'attach', '', '1', '1', '附件配置', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('107', '55', 'Comments', 'Comments', 'edit', '', '1', '0', '编辑', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('108', '55', 'Comments', 'Comments', 'delete', '', '1', '0', '删除', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('109', '55', 'Comments', 'Comments', 'check', '', '1', '1', '评论审核', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('110', '55', 'Comments', 'Comments', 'spamcomment', '', '1', '0', '垃圾评论 ', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('111', '55', 'Comments', 'Comments', 'replycomment', '', '1', '0', '回复评论', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('112', '75', 'Comments', 'Comments', 'fenbiao', '', '1', '1', '分表管理', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('113', '112', 'Comments', 'Comments', 'addfenbiao', '', '1', '1', '创建新的分表', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('114', '54', 'Attachment', 'Atadmin', 'delete', '', '1', '0', '删除', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('115', '82', 'Tags', 'Tags', 'edit', '', '1', '0', '修改', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('116', '82', 'Tags', 'Tags', 'delete', '', '1', '0', '删除', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('117', '82', 'Tags', 'Tags', 'create', '', '1', '1', 'Tags重建', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('118', '82', 'Tags', 'Tags', 'listorder', '', '1', '0', '排序', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('119', '57', 'Admin', 'Category', 'add', '', '1', '1', '添加栏目', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('120', '57', 'Admin', 'Category', 'wadd', '', '1', '1', '添加外部链接栏目', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('121', '57', 'Admin', 'Category', 'edit', '', '1', '0', '编辑', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('122', '57', 'Admin', 'Category', 'delete', '', '1', '0', '删除', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('123', '57', 'Admin', 'Category', 'public_cache', '', '1', '1', '更新栏目缓存', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('124', '57', 'Admin', 'Category', 'categoryshux', '', '1', '0', '栏目属性转换', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('125', '57', 'Admin', 'Category', 'listorder', '', '1', '0', '排序', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('126', '63', 'Admin', 'Urlrule', 'add', '', '1', '1', '添加', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('127', '63', 'Admin', 'Urlrule', 'edit', '', '1', '0', '编辑', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('128', '63', 'Admin', 'Urlrule', 'delete', '', '1', '0', '删除', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('129', '77', 'Contents', 'Position', 'public_item', '', '1', '0', '信息管理', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('130', '77', 'Contents', 'Position', 'add', '', '1', '1', '添加推荐位', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('131', '77', 'Contents', 'Position', 'edit', '', '1', '0', '编辑', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('132', '77', 'Contents', 'Position', 'delete', '', '1', '0', '删除推荐位', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('133', '92', 'Member', 'Member_group', 'add', '', '1', '1', '添加会员组', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('134', '92', 'Member', 'Member_group', 'edit', '', '1', '0', '编辑', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('135', '92', 'Member', 'Member_group', 'delete', '', '1', '0', '删除', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('136', '92', 'Member', 'Member_group', 'sort', '', '1', '0', '排序', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('137', '89', 'Member', 'Member', 'add', '', '1', '1', '添加会员', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('138', '89', 'Member', 'Member', 'edit', '', '1', '0', '修改', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('139', '89', 'Member', 'Member', 'delete', '', '1', '0', '删除', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('140', '89', 'Member', 'Member', 'lock', '', '1', '0', '锁定', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('141', '89', 'Member', 'Member', 'unlock', '', '1', '0', '解除锁定', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('142', '89', 'Member', 'Member', 'memberinfo', '', '1', '0', '资料查看', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('143', '91', 'Member', 'Setting', 'myqsl_test', '', '1', '0', 'Ucenter 测试数据库链接', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('144', '93', 'Member', 'Model', 'add', '', '1', '1', '添加模型', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('145', '93', 'Member', 'Model', 'edit', '', '1', '0', '编辑', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('146', '93', 'Member', 'Model', 'delete', '', '1', '0', '删除', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('147', '93', 'Member', 'Model', 'move', '', '1', '0', '移动', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('148', '93', 'Member', 'Field', 'index', '', '1', '0', '字段管理', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('149', '148', 'Member', 'Field', 'edit', '', '1', '0', '编辑', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('150', '148', 'Member', 'Field', 'add', '', '1', '0', '添加字段', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('151', '148', 'Member', 'Field', 'delete', '', '1', '0', '删除字段', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('152', '148', 'Member', 'Field', 'listorder', '', '1', '0', '排序', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('153', '148', 'Member', 'Field', 'disabled', '', '1', '0', '字段启用与禁用', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('160', '62', 'Template', 'Style', 'updatefilename', '', '1', '0', '更新', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('161', '62', 'Template', 'Style', 'add', '', '1', '0', '添加', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('162', '62', 'Template', 'Style', 'delete', '', '1', '0', '删除', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('163', '62', 'Template', 'Style', 'edit_file', '', '1', '0', '编辑文件', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('164', '69', 'Template', 'Theme', 'chose', '', '1', '0', '主题更换', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('165', '71', 'Template', 'Custompage', 'add', '', '1', '1', '添加自定义页面', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('166', '71', 'Template', 'Custompage', 'delete', '', '1', '0', '删除', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('167', '71', 'Template', 'Custompage', 'edit', '', '1', '0', '编辑', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('168', '84', 'Admin', 'Module', 'index', '', '1', '1', '模块管理', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('186', '0', 'Admin', 'Index', 'deletecache', '', '1', '0', '缓存更新', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('176', '40', 'Admin', 'Management', 'adminadd', '', '1', '1', '添加管理', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('177', '40', 'Admin', 'Management', 'edit', '', '1', '0', '编辑管理信息', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('178', '40', 'Admin', 'Management', 'delete', '', '1', '0', '删除管理员', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('179', '41', 'Admin', 'Rbac', 'roleadd', '', '1', '1', '添加角色', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('180', '41', 'Admin', 'Rbac', 'roledelete', '', '1', '0', '删除角色', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('181', '41', 'Admin', 'Rbac', 'roleedit', '', '1', '0', '角色编辑', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('185', '99', 'Models', 'Field', 'priview', '', '1', '0', '模型预览', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('199', '74', 'Links', 'Links', 'index', '', '1', '1', '友情链接', '友情链接', '0');
INSERT INTO `shuipfcms_menu` VALUES ('200', '199', 'Links', 'Links', 'add', '', '1', '1', '添加友情链接', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('201', '199', 'Links', 'Links', 'edit', '', '1', '0', '编辑', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('202', '199', 'Links', 'Links', 'delete', '', '1', '0', '删除', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('203', '199', 'Links', 'Links', 'terms', '', '1', '1', '分类管理', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('204', '75', 'Comments', 'Field', 'index', '', '1', '1', '字段管理', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('205', '204', 'Comments', 'Field', 'add', '', '1', '1', '添加字段', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('206', '204', 'Comments', 'Field', 'delete', '', '1', '0', '删除字段', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('207', '204', 'Comments', 'Field', 'edit', '', '1', '0', '编辑字段', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('208', '38', 'Admin', 'Adminmanage', 'verifypass', '', '1', '0', '密码验证', '密码进行修改的时候，进行旧密码判断', '0');
INSERT INTO `shuipfcms_menu` VALUES ('213', '8', 'Admin', 'Censor', 'index', '', '1', '1', '词语过滤', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('214', '213', 'Admin', 'Censor', 'add', '', '1', '1', '添加', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('215', '213', 'Admin', 'Censor', 'classify', '', '1', '1', '分类管理', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('230', '86', 'Member', 'Member', 'connect', '', '1', '1', '登陆授权管理', '登陆授权管理', '0');
INSERT INTO `shuipfcms_menu` VALUES ('231', '10', 'Admin', 'Config', 'addition', '', '1', '1', '高级配置', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('232', '75', 'Comments', 'Emotion', 'index', '', '1', '1', '表情管理', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('233', '74', 'Search', 'Search', 'index', '', '1', '1', '搜索配置', '搜索配置', '0');
INSERT INTO `shuipfcms_menu` VALUES ('234', '233', 'Search', 'Search', 'create', '', '1', '1', '重建索引', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('235', '233', 'Search', 'Search', 'searchot', '', '1', '1', '热门搜索', '', '0');

-- ----------------------------
-- Table structure for `shuipfcms_model`
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_model`;
CREATE TABLE `shuipfcms_model` (
  `modelid` smallint(5) unsigned NOT NULL auto_increment,
  `name` char(30) NOT NULL COMMENT '模型名称',
  `description` char(100) NOT NULL COMMENT '描述',
  `tablename` char(20) NOT NULL COMMENT '表名',
  `setting` text NOT NULL COMMENT '配置信息',
  `addtime` int(10) unsigned NOT NULL default '0' COMMENT '添加时间',
  `items` smallint(5) unsigned NOT NULL default '0' COMMENT '信息数',
  `enablesearch` tinyint(1) unsigned NOT NULL default '1' COMMENT '是否开启全站搜索',
  `disabled` tinyint(1) unsigned NOT NULL default '0' COMMENT '是否禁用 1禁用',
  `default_style` char(30) NOT NULL COMMENT '风格',
  `category_template` char(30) NOT NULL COMMENT '栏目模板',
  `list_template` char(30) NOT NULL COMMENT '列表模板',
  `show_template` char(30) NOT NULL COMMENT '内容模板',
  `js_template` varchar(30) NOT NULL COMMENT 'JS模板',
  `sort` tinyint(3) NOT NULL COMMENT '排序',
  `type` tinyint(1) NOT NULL COMMENT '模块标识',
  PRIMARY KEY  (`modelid`),
  KEY `type` (`type`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shuipfcms_model
-- ----------------------------
INSERT INTO `shuipfcms_model` VALUES ('1', '文章模型', '文章', 'article', '', '0', '0', '1', '0', '', '', '', '', '', '0', '0');
INSERT INTO `shuipfcms_model` VALUES ('3', '普通会员', '', 'member_detail', '', '0', '0', '1', '0', '', '', '', '', '', '0', '2');

-- ----------------------------
-- Table structure for `shuipfcms_model_field`
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_model_field`;
CREATE TABLE `shuipfcms_model_field` (
  `fieldid` mediumint(8) unsigned NOT NULL auto_increment,
  `modelid` smallint(5) unsigned NOT NULL default '0' COMMENT '模型ID',
  `field` varchar(20) NOT NULL COMMENT '字段名',
  `name` varchar(30) NOT NULL COMMENT '别名',
  `tips` text NOT NULL COMMENT '字段提示',
  `css` varchar(30) NOT NULL COMMENT '表单样式',
  `minlength` int(10) unsigned NOT NULL default '0' COMMENT '最小值',
  `maxlength` int(10) unsigned NOT NULL default '0' COMMENT '最大值',
  `pattern` varchar(255) NOT NULL COMMENT '数据校验正则',
  `errortips` varchar(255) NOT NULL COMMENT '数据校验未通过的提示信息',
  `formtype` varchar(20) NOT NULL COMMENT '字段类型',
  `setting` mediumtext NOT NULL,
  `formattribute` varchar(255) NOT NULL,
  `unsetgroupids` varchar(255) NOT NULL,
  `unsetroleids` varchar(255) NOT NULL,
  `iscore` tinyint(1) unsigned NOT NULL default '0' COMMENT '是否内部字段 1是',
  `issystem` tinyint(1) unsigned NOT NULL default '0' COMMENT '是否系统字段 1 是',
  `isunique` tinyint(1) unsigned NOT NULL default '0' COMMENT '值唯一',
  `isbase` tinyint(1) unsigned NOT NULL default '0' COMMENT '作为基本信息',
  `issearch` tinyint(1) unsigned NOT NULL default '0' COMMENT '作为搜索条件',
  `isadd` tinyint(1) unsigned NOT NULL default '0' COMMENT '在前台投稿中显示',
  `isfulltext` tinyint(1) unsigned NOT NULL default '0' COMMENT '作为全站搜索信息',
  `isposition` tinyint(1) unsigned NOT NULL default '0' COMMENT '是否入库到推荐位',
  `listorder` mediumint(8) unsigned NOT NULL default '0',
  `disabled` tinyint(1) unsigned NOT NULL default '0' COMMENT '1 禁用 0启用',
  `isomnipotent` tinyint(1) unsigned NOT NULL default '0',
  PRIMARY KEY  (`fieldid`),
  KEY `modelid` (`modelid`,`disabled`),
  KEY `field` (`field`,`modelid`)
) ENGINE=MyISAM AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shuipfcms_model_field
-- ----------------------------
INSERT INTO `shuipfcms_model_field` VALUES ('1', '1', 'catid', '栏目', '', '', '1', '6', '/^[0-9]{1,6}$/', '请选择栏目', 'catid', 'a:1:{s:12:\"defaultvalue\";s:0:\"\";}', '', '-99', '-99', '0', '1', '0', '1', '1', '1', '0', '0', '1', '0', '0');
INSERT INTO `shuipfcms_model_field` VALUES ('2', '1', 'typeid', '类别', '', '', '0', '0', '', '', 'typeid', 'a:2:{s:9:\"minnumber\";s:0:\"\";s:12:\"defaultvalue\";s:0:\"\";}', '', '', '', '1', '1', '0', '1', '1', '1', '0', '0', '2', '0', '0');
INSERT INTO `shuipfcms_model_field` VALUES ('3', '1', 'title', '标题', '', 'inputtitle', '1', '160', '', '请输入标题', 'title', 'N;', '', '', '', '0', '1', '0', '1', '1', '1', '1', '1', '3', '0', '0');
INSERT INTO `shuipfcms_model_field` VALUES ('4', '1', 'keywords', '关键词', '多关键词之间用空格隔开', '', '0', '100', '', '', 'keyword', 'a:2:{s:12:\"backstagefun\";s:0:\"\";s:8:\"frontfun\";s:0:\"\";}', '', '', '', '0', '1', '0', '1', '1', '1', '1', '0', '4', '0', '0');
INSERT INTO `shuipfcms_model_field` VALUES ('5', '1', 'description', '摘要', '', '', '0', '0', '', '', 'textarea', 'a:4:{s:5:\"width\";s:2:\"98\";s:6:\"height\";s:3:\"200\";s:12:\"defaultvalue\";s:0:\"\";s:10:\"enablehtml\";s:1:\"0\";}', '', '', '', '0', '1', '0', '1', '0', '1', '1', '1', '6', '0', '0');
INSERT INTO `shuipfcms_model_field` VALUES ('6', '1', 'updatetime', '发布时间', '', '', '0', '0', '', '', 'datetime', 'a:3:{s:9:\"fieldtype\";s:3:\"int\";s:6:\"format\";s:11:\"Y-m-d H:i:s\";s:11:\"defaulttype\";s:1:\"0\";}', '', '', '', '0', '1', '0', '0', '0', '0', '0', '0', '15', '0', '0');
INSERT INTO `shuipfcms_model_field` VALUES ('7', '1', 'content', '内容', '<style type=\"text/css\">\n.content_attr {\n	border: 1px solid #CCC;\n	padding: 5px 8px;\n	background: #FFC;\n	margin-top: 6px\n}\n</style>\n<div class=\"content_attr\">\n<input name=\"add_introduce\" type=\"checkbox\"  value=\"1\" checked> 是否截取内容\n<input type=\"text\" name=\"introcude_length\" class=\"input\" value=\"200\" size=\"3\"> 字符至内容摘要\n<input type=\'checkbox\' name=\'auto_thumb\' value=\"1\" checked> 是否获取内容第\n<input type=\"text\" name=\"auto_thumb_no\" class=\"input\" value=\"1\" size=\"2\" class=\"\"> 张图片作为标题图片\n</div>', '', '1', '999999', '', '内容不能为空', 'editor', 'a:7:{s:7:\"toolbar\";s:4:\"full\";s:9:\"mbtoolbar\";s:5:\"basic\";s:12:\"defaultvalue\";s:0:\"\";s:15:\"enablesaveimage\";s:1:\"1\";s:6:\"height\";s:0:\"\";s:12:\"backstagefun\";s:0:\"\";s:8:\"frontfun\";s:0:\"\";}', '', '', '', '0', '0', '0', '1', '0', '1', '1', '0', '7', '0', '0');
INSERT INTO `shuipfcms_model_field` VALUES ('8', '1', 'thumb', '缩略图', '', '', '0', '100', '', '', 'image', 'a:10:{s:4:\"size\";s:2:\"50\";s:12:\"defaultvalue\";s:0:\"\";s:9:\"show_type\";s:1:\"1\";s:15:\"upload_allowext\";s:20:\"jpg|jpeg|gif|png|bmp\";s:9:\"watermark\";s:1:\"1\";s:13:\"isselectimage\";s:1:\"1\";s:12:\"images_width\";s:0:\"\";s:13:\"images_height\";s:0:\"\";s:12:\"backstagefun\";s:0:\"\";s:8:\"frontfun\";s:0:\"\";}', '', '', '', '0', '1', '0', '0', '0', '1', '0', '1', '8', '0', '0');
INSERT INTO `shuipfcms_model_field` VALUES ('9', '1', 'relation', '相关文章', '', '', '0', '255', '', '', 'omnipotent', 'a:4:{s:8:\"formtext\";s:465:\"<input type=\"hidden\" name=\"info[relation]\" id=\"relation\" value=\"{FIELD_VALUE}\" style=\"50\" >\n<ul class=\"list-dot\" id=\"relation_text\">\n</ul>\n<input type=\"button\" value=\"添加相关\" onClick=\"omnipotent(\'selectid\',GV.DIMAUB+\'index.php?a=public_relationlist&m=Content&g=Contents&modelid={MODELID}\',\'添加相关文章\',1)\" class=\"btn\">\n<span class=\"edit_content\">\n  <input type=\"button\" value=\"显示已有\" onClick=\"show_relation({MODELID},{ID})\" class=\"btn\">\n</span>\";s:9:\"fieldtype\";s:7:\"varchar\";s:12:\"backstagefun\";s:0:\"\";s:8:\"frontfun\";s:0:\"\";}', '', '', '', '0', '0', '0', '0', '0', '0', '1', '0', '12', '0', '0');
INSERT INTO `shuipfcms_model_field` VALUES ('10', '1', 'pages', '分页方式', '', '', '0', '0', '', '', 'pages', '', '', '-99', '-99', '0', '0', '0', '1', '0', '0', '0', '0', '13', '0', '0');
INSERT INTO `shuipfcms_model_field` VALUES ('11', '1', 'inputtime', '真实发布时间', '', '', '0', '0', '', '', 'datetime', 'a:3:{s:9:\"fieldtype\";s:3:\"int\";s:6:\"format\";s:11:\"Y-m-d H:i:s\";s:11:\"defaulttype\";s:1:\"0\";}', '', '', '', '1', '1', '0', '0', '0', '0', '0', '1', '14', '0', '0');
INSERT INTO `shuipfcms_model_field` VALUES ('12', '1', 'url', 'URL', '', '', '0', '100', '', '', 'text', '', '', '', '', '1', '1', '0', '1', '0', '0', '0', '1', '18', '0', '0');
INSERT INTO `shuipfcms_model_field` VALUES ('13', '1', 'listorder', '排序', '', '', '0', '6', '', '', 'number', '', '', '', '', '1', '1', '0', '1', '0', '0', '0', '0', '19', '0', '0');
INSERT INTO `shuipfcms_model_field` VALUES ('14', '1', 'template', '内容页模板', '', '', '0', '30', '', '', 'template', 'N;', '', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '20', '0', '0');
INSERT INTO `shuipfcms_model_field` VALUES ('15', '1', 'allow_comment', '允许评论', '', '', '0', '0', '', '', 'box', 'a:9:{s:7:\"options\";s:33:\"允许评论|1\r\n不允许评论|0\";s:7:\"boxtype\";s:5:\"radio\";s:9:\"fieldtype\";s:7:\"tinyint\";s:9:\"minnumber\";s:1:\"1\";s:5:\"width\";s:2:\"88\";s:4:\"size\";s:0:\"\";s:12:\"defaultvalue\";s:1:\"1\";s:10:\"outputtype\";s:1:\"1\";s:10:\"filtertype\";s:1:\"0\";}', '', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '21', '0', '0');
INSERT INTO `shuipfcms_model_field` VALUES ('16', '1', 'status', '状态', '', '', '0', '2', '', '', 'box', '', '', '', '', '1', '1', '0', '1', '0', '0', '0', '0', '22', '0', '0');
INSERT INTO `shuipfcms_model_field` VALUES ('17', '1', 'username', '用户名', '', '', '0', '20', '', '', 'text', '', '', '', '', '1', '1', '0', '1', '0', '0', '0', '0', '23', '0', '0');
INSERT INTO `shuipfcms_model_field` VALUES ('18', '1', 'islink', '转向链接', '', '', '0', '0', '', '', 'islink', '', '', '', '', '0', '1', '0', '0', '0', '1', '0', '0', '16', '0', '0');
INSERT INTO `shuipfcms_model_field` VALUES ('19', '1', 'copyfrom', '来源', '', '', '0', '0', '', '', 'copyfrom', 'a:1:{s:12:\"defaultvalue\";s:0:\"\";}', '', '', '', '0', '0', '0', '1', '0', '1', '0', '0', '5', '0', '0');
INSERT INTO `shuipfcms_model_field` VALUES ('20', '1', 'albums', '相册图集', '', '', '0', '0', '', '', 'images', 'a:3:{s:15:\"upload_allowext\";s:20:\"gif|jpg|jpeg|png|bmp\";s:13:\"isselectimage\";s:1:\"0\";s:13:\"upload_number\";s:2:\"10\";}', '', '', '', '0', '0', '0', '1', '0', '0', '0', '0', '9', '0', '0');
INSERT INTO `shuipfcms_model_field` VALUES ('21', '1', 'download', '下载', '', '', '0', '0', '', '', 'downfiles', 'a:7:{s:15:\"upload_allowext\";s:31:\"gif|jpg|jpeg|png|bmp|rar|zip|7z\";s:13:\"isselectimage\";s:1:\"0\";s:13:\"upload_number\";s:2:\"20\";s:12:\"downloadlink\";s:1:\"1\";s:12:\"downloadtype\";s:1:\"1\";s:12:\"backstagefun\";s:0:\"\";s:8:\"frontfun\";s:0:\"\";}', '', '', '', '0', '0', '0', '1', '0', '1', '0', '0', '10', '0', '0');
INSERT INTO `shuipfcms_model_field` VALUES ('22', '1', 'posid', '推荐位', '', '', '0', '0', '', '', 'posid', 'a:2:{s:5:\"width\";s:3:\"125\";s:12:\"defaultvalue\";s:0:\"\";}', '', '', '', '0', '1', '0', '1', '0', '0', '0', '0', '11', '0', '0');
INSERT INTO `shuipfcms_model_field` VALUES ('23', '1', 'prefix', '自定义文件名', '', '', '0', '255', '', '', 'text', 'a:5:{s:4:\"size\";s:2:\"27\";s:12:\"defaultvalue\";s:0:\"\";s:10:\"ispassword\";s:1:\"0\";s:12:\"backstagefun\";s:0:\"\";s:8:\"frontfun\";s:0:\"\";}', '', '', '', '0', '1', '0', '0', '0', '1', '1', '0', '17', '0', '0');
INSERT INTO `shuipfcms_model_field` VALUES ('43', '3', 'birthday', '日期', '', '', '1', '0', '', '', 'datetime', 'a:3:{s:9:\"fieldtype\";s:3:\"int\";s:6:\"format\";s:5:\"Y-m-d\";s:11:\"defaulttype\";s:1:\"0\";}', '', '', '', '0', '1', '0', '1', '0', '1', '0', '0', '0', '0', '0');
INSERT INTO `shuipfcms_model_field` VALUES ('44', '1', 'tags', 'TAGS', '多关之间用空格或者“,”隔开', '', '0', '0', '', '', 'tags', 'a:4:{s:12:\"backstagefun\";s:0:\"\";s:17:\"backstagefun_type\";s:1:\"1\";s:8:\"frontfun\";s:0:\"\";s:13:\"frontfun_type\";s:1:\"1\";}', '', '', '', '0', '1', '0', '1', '0', '0', '0', '0', '4', '0', '0');

-- ----------------------------
-- Table structure for `shuipfcms_module`
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_module`;
CREATE TABLE `shuipfcms_module` (
  `module` varchar(15) NOT NULL COMMENT '模块',
  `name` varchar(20) NOT NULL COMMENT '模块名称',
  `url` varchar(50) NOT NULL COMMENT 'url',
  `iscore` tinyint(1) unsigned NOT NULL default '0' COMMENT '内置模块',
  `version` varchar(50) NOT NULL default '' COMMENT '版本',
  `description` varchar(255) NOT NULL COMMENT '描述',
  `setting` mediumtext NOT NULL COMMENT '设置信息',
  `listorder` tinyint(3) unsigned NOT NULL default '0' COMMENT '排序',
  `disabled` tinyint(1) unsigned NOT NULL default '0' COMMENT '是否可用',
  `installdate` date NOT NULL default '0000-00-00' COMMENT '安装时间',
  `updatedate` date NOT NULL default '0000-00-00' COMMENT '更新时间',
  PRIMARY KEY  (`module`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='模块配置信息表';

-- ----------------------------
-- Records of shuipfcms_module
-- ----------------------------
INSERT INTO `shuipfcms_module` VALUES ('Admin', '后台管理模块', '', '1', '1.0', '后台管理', '', '0', '1', '2012-06-21', '2012-06-21');
INSERT INTO `shuipfcms_module` VALUES ('Attachment', '附件模块', '', '1', '1.0', '附件管理', '', '0', '1', '2012-06-21', '2012-06-21');
INSERT INTO `shuipfcms_module` VALUES ('Comments', '评论模块', '', '1', '1.0', '评论管理模块', '', '0', '1', '2012-06-21', '2012-06-21');
INSERT INTO `shuipfcms_module` VALUES ('Contents', '内容模块', '', '1', '1.0', '内容模块', '', '0', '1', '2012-06-21', '2012-06-21');
INSERT INTO `shuipfcms_module` VALUES ('Member', '会员中心', '', '1', '1.0', '会员中心', 'a:31:{s:13:\"allowregister\";s:1:\"1\";s:11:\"choosemodel\";s:1:\"1\";s:14:\"defaultmodelid\";s:1:\"3\";s:15:\"enablemailcheck\";s:1:\"0\";s:14:\"registerverify\";s:1:\"0\";s:12:\"showapppoint\";s:1:\"0\";s:14:\"rmb_point_rate\";s:2:\"10\";s:12:\"defualtpoint\";s:1:\"0\";s:13:\"defualtamount\";s:1:\"0\";s:15:\"showregprotocol\";s:1:\"0\";s:11:\"regprotocol\";s:1755:\"欢迎您注册成为ShuipFCMS用户,请仔细阅读下面的协议，只有接受协议才能继续进行注册。\r\n      1)从中国境内向外传输技术性资料时必须符合中国有关法规。 \r\n　　2)使用网站服务不作非法用途。 \r\n　　3)不干扰或混乱网络服务。 \r\n　　4)不在论坛BBS或留言簿发表任何与政治相关的信息。 \r\n　　5)遵守所有使用网站服务的网络协议、规定、程序和惯例。\r\n　　6)不得利用本站危害国家安全、泄露国家秘密，不得侵犯国家社会集体的和公民的合法权益。\r\n　　7)不得利用本站制作、复制和传播下列信息： \r\n　　　1、煽动抗拒、破坏宪法和法律、行政法规实施的；\r\n　　　2、煽动颠覆国家政权，推翻社会主义制度的；\r\n　　　3、煽动分裂国家、破坏国家统一的；\r\n　　　4、煽动民族仇恨、民族歧视，破坏民族团结的；\r\n　　　5、捏造或者歪曲事实，散布谣言，扰乱社会秩序的；\r\n　　　6、宣扬封建迷信、淫秽、色情、赌博、暴力、凶杀、恐怖、教唆犯罪的；\r\n　　　7、公然侮辱他人或者捏造事实诽谤他人的，或者进行其他恶意攻击的；\r\n　　　8、损害国家机关信誉的；\r\n　　　9、其他违反宪法和法律行政法规的；\r\n　　　10、进行商业广告行为的。\r\n　　用户不能传输任何教唆他人构成犯罪行为的资料；不能传输长国内不利条件和涉及国家安全的资料；不能传输任何不符合当地法规、国家法律和国际法 律的资料。未经许可而非法进入其它电脑系统是禁止的。若用户的行为不符合以上的条款，ShuipFCMS将取消用户服务帐号。 \";s:21:\"registerverifymessage\";s:204:\"欢迎您注册成为ShuipFCMS用户，您的账号需要邮箱认证，点击下面链接进行认证：<a href=\\\"{$url}\\\" title=\\\"激活认证\\\">请点击</a>\r\n或者将网址复制到浏览器：{$url}\";s:14:\"forgetpassword\";s:174:\"ShuipFCMS密码找回，请在一小时内点击下面链接进行操作：<a href=\\\"{$url}\\\" title=\\\"密码找回\\\">请点击</a>\r\n或者将网址复制到浏览器：{$url}\";s:5:\"ucuse\";s:1:\"0\";s:10:\"uc_connect\";s:5:\"mysql\";s:6:\"uc_api\";s:0:\"\";s:5:\"uc_ip\";s:0:\"\";s:9:\"uc_dbhost\";s:9:\"127.0.0.1\";s:9:\"uc_dbuser\";s:0:\"\";s:7:\"uc_dbpw\";s:0:\"\";s:9:\"uc_dbname\";s:0:\"\";s:13:\"uc_dbtablepre\";s:0:\"\";s:12:\"uc_dbcharset\";s:4:\"utf8\";s:8:\"uc_appid\";s:0:\"\";s:6:\"uc_key\";s:0:\"\";s:11:\"sinawb_akey\";s:0:\"\";s:11:\"sinawb_skey\";s:0:\"\";s:9:\"qqwb_akey\";s:0:\"\";s:9:\"qqwb_skey\";s:0:\"\";s:7:\"qq_akey\";s:0:\"\";s:7:\"qq_skey\";s:0:\"\";}', '0', '1', '2012-06-21', '2012-06-21');
INSERT INTO `shuipfcms_module` VALUES ('Models', '模型管理', '', '1', '1.0', '模型管理', '', '0', '1', '2012-06-21', '2012-06-21');
INSERT INTO `shuipfcms_module` VALUES ('Tags', 'TAG标签', '', '1', '1.0', 'TAG标签', '', '0', '1', '2012-06-21', '2012-06-21');
INSERT INTO `shuipfcms_module` VALUES ('Template', '模板管理', '', '1', '1.0', '前台模板管理', '', '0', '1', '2012-06-21', '2012-06-21');
INSERT INTO `shuipfcms_module` VALUES ('Links', '友情链接', '', '0', '1.0', '友情链接模块', '', '0', '1', '2012-07-13', '2012-07-13');
INSERT INTO `shuipfcms_module` VALUES ('Api', 'Api调用', '', '1', '1.0', 'Api调用', '', '0', '1', '2012-06-21', '2012-06-21');
INSERT INTO `shuipfcms_module` VALUES ('Search', '搜索', '', '0', '20130531', '全站搜索', '', '0', '1', '2013-06-22', '2013-06-22');

-- ----------------------------
-- Table structure for `shuipfcms_operationlog`
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_operationlog`;
CREATE TABLE `shuipfcms_operationlog` (
  `id` int(11) NOT NULL auto_increment COMMENT '日志ID',
  `uid` int(11) NOT NULL COMMENT '操作帐号ID',
  `time` datetime NOT NULL COMMENT '操作时间',
  `ip` varchar(20) character set utf8 NOT NULL default '' COMMENT 'IP',
  `status` tinyint(1) NOT NULL default '0' COMMENT '状态,1为写入，2为更新，3为删除',
  `info` text character set utf8 COMMENT '其他说明',
  `data` text character set utf8 COMMENT '数据',
  `options` varchar(255) character set utf8 default NULL COMMENT '条件',
  `get` varchar(255) character set utf8 default NULL COMMENT 'get数据',
  `post` text character set utf8 COMMENT 'post数据',
  PRIMARY KEY  (`id`),
  KEY `status` (`status`),
  KEY `username` (`uid`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=gbk COMMENT='后台操作日志表';

-- ----------------------------
-- Table structure for `shuipfcms_position`
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_position`;
CREATE TABLE `shuipfcms_position` (
  `posid` smallint(5) unsigned NOT NULL auto_increment COMMENT '推荐位id',
  `modelid` smallint(5) unsigned default '0' COMMENT '模型id',
  `catid` smallint(5) unsigned default '0' COMMENT '栏目id',
  `name` char(30) NOT NULL default '' COMMENT '推荐位名称',
  `maxnum` smallint(5) NOT NULL default '20' COMMENT '最大存储数据量',
  `extention` char(100) default NULL,
  `listorder` smallint(5) unsigned NOT NULL default '0' COMMENT '排序',
  PRIMARY KEY  (`posid`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='推荐位';

-- ----------------------------
-- Records of shuipfcms_position
-- ----------------------------
INSERT INTO `shuipfcms_position` VALUES ('1', '0', '0', '首页幻灯片', '10', null, '1');
INSERT INTO `shuipfcms_position` VALUES ('2', '0', '0', '首页文字头条', '10', null, '0');
INSERT INTO `shuipfcms_position` VALUES ('3', '0', '0', '首页站长推荐', '10', null, '0');

-- ----------------------------
-- Table structure for `shuipfcms_position_data`
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_position_data`;
CREATE TABLE `shuipfcms_position_data` (
  `id` mediumint(8) unsigned NOT NULL default '0' COMMENT 'ID',
  `catid` smallint(5) unsigned NOT NULL default '0' COMMENT '栏目ID',
  `posid` smallint(5) unsigned NOT NULL default '0' COMMENT '推荐位ID',
  `module` char(20) default NULL COMMENT '模型',
  `modelid` smallint(6) unsigned default '0' COMMENT '模型ID',
  `thumb` tinyint(1) NOT NULL default '0' COMMENT '是否有缩略图',
  `data` mediumtext COMMENT '数据信息',
  `listorder` mediumint(8) default '0' COMMENT '排序',
  `expiration` int(10) NOT NULL,
  `extention` char(30) default NULL,
  `synedit` tinyint(1) default '0' COMMENT '是否同步编辑',
  KEY `posid` (`posid`),
  KEY `listorder` (`listorder`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='推荐位数据表';

-- ----------------------------
-- Table structure for `shuipfcms_role`
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_role`;
CREATE TABLE `shuipfcms_role` (
  `id` smallint(6) unsigned NOT NULL auto_increment,
  `name` varchar(20) NOT NULL default '角色名称',
  `pid` smallint(6) default NULL COMMENT '父角色ID',
  `status` tinyint(1) unsigned default NULL COMMENT '状态',
  `remark` varchar(255) default NULL COMMENT '备注',
  `create_time` int(11) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL COMMENT '更新时间',
  `listorder` int(3) NOT NULL default '0' COMMENT '排序字段',
  PRIMARY KEY  (`id`),
  KEY `parentId` (`pid`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='角色信息列表';

-- ----------------------------
-- Records of shuipfcms_role
-- ----------------------------
INSERT INTO `shuipfcms_role` VALUES ('1', '超级管理员', null, '1', '拥有网站最高管理员权限！', '1329633709', '1329633709', '0');
INSERT INTO `shuipfcms_role` VALUES ('2', '站点管理员', null, '1', '站点管理员', '1329633722', '1330155227', '0');
INSERT INTO `shuipfcms_role` VALUES ('3', '发布人员', null, '1', '发布人员', '1329633733', '1329637001', '0');

-- ----------------------------
-- Table structure for `shuipfcms_role_user`
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_role_user`;
CREATE TABLE `shuipfcms_role_user` (
  `role_id` mediumint(9) unsigned default NULL,
  `user_id` char(32) default NULL,
  KEY `group_id` (`role_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shuipfcms_role_user
-- ----------------------------

-- ----------------------------
-- Table structure for `shuipfcms_search`
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_search`;
CREATE TABLE `shuipfcms_search` (
  `searchid` int(10) unsigned NOT NULL auto_increment,
  `id` mediumint(8) unsigned NOT NULL default '0' COMMENT '信息id',
  `catid` smallint(5) unsigned NOT NULL default '0' COMMENT '栏目id',
  `modelid` smallint(5) default NULL COMMENT '模型id',
  `adddate` int(10) unsigned NOT NULL COMMENT '添加时间',
  `data` text NOT NULL COMMENT '数据',
  PRIMARY KEY  (`searchid`),
  KEY `id` USING BTREE (`id`,`catid`,`adddate`),
  KEY `modelid` (`modelid`,`catid`),
  FULLTEXT KEY `data` (`data`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='全站搜索数据表';

-- ----------------------------
-- Records of shuipfcms_search
-- ----------------------------

-- ----------------------------
-- Table structure for `shuipfcms_search_keyword`
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_search_keyword`;
CREATE TABLE `shuipfcms_search_keyword` (
  `keyword` char(20) NOT NULL,
  `pinyin` char(20) NOT NULL,
  `searchnums` int(10) unsigned NOT NULL,
  `data` char(20) NOT NULL,
  UNIQUE KEY `keyword` (`keyword`),
  UNIQUE KEY `pinyin` (`pinyin`),
  FULLTEXT KEY `data` (`data`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='搜索关键字表';

-- ----------------------------
-- Records of shuipfcms_search_keyword
-- ----------------------------

-- ----------------------------
-- Table structure for `shuipfcms_tags`
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_tags`;
CREATE TABLE `shuipfcms_tags` (
  `tagid` smallint(5) unsigned NOT NULL auto_increment COMMENT 'tagID',
  `tag` char(20) NOT NULL COMMENT 'tag名称',
  `style` char(5) NOT NULL COMMENT '附加状态码',
  `usetimes` smallint(5) unsigned NOT NULL default '0' COMMENT '信息总数',
  `lastusetime` int(10) unsigned NOT NULL default '0' COMMENT '最后使用时间',
  `hits` mediumint(8) unsigned NOT NULL default '0' COMMENT '点击数',
  `lasthittime` int(10) unsigned NOT NULL default '0' COMMENT '最近访问时间',
  `listorder` tinyint(3) unsigned NOT NULL default '0' COMMENT '排序',
  PRIMARY KEY  (`tagid`),
  UNIQUE KEY `tag` (`tag`),
  KEY `usetimes` (`usetimes`,`listorder`),
  KEY `hits` (`hits`,`listorder`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='tags主表';


-- ----------------------------
-- Table structure for `shuipfcms_tags_content`
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_tags_content`;
CREATE TABLE `shuipfcms_tags_content` (
  `tag` char(20) NOT NULL COMMENT 'tag名称',
  `url` varchar(255) default NULL COMMENT '信息地址',
  `title` varchar(80) default NULL COMMENT '标题',
  `modelid` tinyint(3) unsigned NOT NULL COMMENT '模型ID',
  `contentid` mediumint(8) unsigned NOT NULL default '0' COMMENT '信息ID',
  `catid` smallint(5) unsigned NOT NULL COMMENT '栏目ID',
  `updatetime` int(11) unsigned NOT NULL COMMENT '更新时间',
  KEY `modelid` (`modelid`,`contentid`),
  KEY `tag` (`tag`(10))
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='tags数据表';

-- ----------------------------
-- Records of shuipfcms_tags_content
-- ----------------------------

-- ----------------------------
-- Table structure for `shuipfcms_terms`
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_terms`;
CREATE TABLE `shuipfcms_terms` (
  `id` bigint(20) unsigned NOT NULL auto_increment COMMENT '分类ID',
  `parentid` smallint(5) NOT NULL COMMENT '父ID',
  `name` varchar(200) NOT NULL default '' COMMENT '分类名称',
  `module` varchar(200) NOT NULL default '' COMMENT '所属模块',
  PRIMARY KEY  (`id`),
  KEY `name` (`name`),
  KEY `module` (`module`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='分类表';

-- ----------------------------
-- Records of shuipfcms_terms
-- ----------------------------
INSERT INTO `shuipfcms_terms` VALUES ('1', '0', '文字链接', 'links');

-- ----------------------------
-- Table structure for `shuipfcms_urlrule`
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_urlrule`;
CREATE TABLE `shuipfcms_urlrule` (
  `urlruleid` smallint(5) unsigned NOT NULL auto_increment COMMENT '规则id',
  `module` varchar(15) NOT NULL COMMENT '所属模块',
  `file` varchar(20) NOT NULL COMMENT '所属文件',
  `ishtml` tinyint(1) unsigned NOT NULL default '0' COMMENT '生成静态规则 1 静态',
  `urlrule` varchar(255) NOT NULL COMMENT 'url规则',
  `example` varchar(255) NOT NULL COMMENT '示例',
  PRIMARY KEY  (`urlruleid`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shuipfcms_urlrule
-- ----------------------------
INSERT INTO `shuipfcms_urlrule` VALUES ('1', 'content', 'category', '0', 'index.php?a=lists&catid={$catid}|index.php?a=lists&catid={$catid}&page={$page}', '动态：index.php?a=lists&catid=1&page=1');
INSERT INTO `shuipfcms_urlrule` VALUES ('2', 'content', 'category', '1', '{$categorydir}{$catdir}/index.html|{$categorydir}{$catdir}/index_{$page}.html', '静态：news/china/1000.html');
INSERT INTO `shuipfcms_urlrule` VALUES ('3', 'content', 'show', '1', '{$year}/{$catdir}_{$month}/{$id}.html|{$year}/{$catdir}_{$month}/{$id}_{$page}.html', '静态：2010/catdir_07/1_2.html');
INSERT INTO `shuipfcms_urlrule` VALUES ('4', 'content', 'show', '0', 'index.php?a=shows&catid={$catid}&id={$id}|index.php?a=shows&catid={$catid}&id={$id}&page={$page}', '动态：index.php?m=Index&a=shows&catid=1&id=1');
INSERT INTO `shuipfcms_urlrule` VALUES ('5', 'content', 'category', '1', 'news/{$catid}.html|news/{$catid}-{$page}.html', '静态：news/1.html');
INSERT INTO `shuipfcms_urlrule` VALUES ('6', 'content', 'category', '0', 'list-{$catid}.html|list-{$catid}-{$page}.html', '伪静态：list-1-1.html');
INSERT INTO `shuipfcms_urlrule` VALUES ('7', 'tags', 'tags', '0', 'index.php?g=Tags&tagid={$tagid}|index.php?g=Tags&tagid={$tagid}&page={$page}', '动态：index.php?g=Tags&tagid=1');
INSERT INTO `shuipfcms_urlrule` VALUES ('8', 'tags', 'tags', '0', 'index.php?g=Tags&tag={$tag}|/index.php?g=Tags&tag={$tag}&page={$page}', '动态：index.php?g=Tags&tag=标签');
INSERT INTO `shuipfcms_urlrule` VALUES ('9', 'tags', 'tags', '0', 'tag-{$tag}.html|tag-{$tag}-{$page}.html', '伪静态：tag-标签.html');
INSERT INTO `shuipfcms_urlrule` VALUES ('10', 'tags', 'tags', '0', 'tag-{$tagid}.html|tag-{$tagid}-{$page}.html', '伪静态：tag-1.html');
INSERT INTO `shuipfcms_urlrule` VALUES ('11', 'content', 'index', '1', 'index.html|index_{$page}.html', '静态：index_2.html');
INSERT INTO `shuipfcms_urlrule` VALUES ('12', 'content', 'index', '0', 'index.html|index_{$page}.html', '伪静态：index_2.html');
INSERT INTO `shuipfcms_urlrule` VALUES ('13', 'content', 'index', '0', 'index.php|index.php?page={$page}', '动态：index.php?page=2');

-- ----------------------------
-- Table structure for `shuipfcms_user`
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_user`;
CREATE TABLE `shuipfcms_user` (
  `id` smallint(5) unsigned NOT NULL auto_increment,
  `username` varchar(64) NOT NULL COMMENT '用户名',
  `nickname` varchar(50) NOT NULL COMMENT '昵称/姓名',
  `password` char(32) NOT NULL COMMENT '密码',
  `bind_account` varchar(50) NOT NULL COMMENT '绑定帐户',
  `last_login_time` int(11) unsigned default '0' COMMENT '上次登录时间',
  `last_login_ip` varchar(40) default NULL COMMENT '上次登录IP',
  `verify` varchar(32) default NULL COMMENT '证验码',
  `email` varchar(50) NOT NULL COMMENT '邮箱',
  `remark` varchar(255) NOT NULL COMMENT '备注',
  `create_time` int(11) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL COMMENT '更新时间',
  `status` tinyint(1) NOT NULL default '0' COMMENT '状态',
  `role_id` tinyint(4) unsigned NOT NULL default '0' COMMENT '对应角色ID',
  `info` text NOT NULL COMMENT '信息',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `account` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='后台用户表';
