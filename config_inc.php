<?php

$dsn=$_ENV['DATABASE_URL'];
preg_match( '|([a-z0-9]+)://([^:]*)(:(.*))?@([A-Za-z0-9\.-]*)(:([0-9]*))?(/([0-9a-zA-Z_/\.-]*))|', $dsn, $matches);

$g_hostname             = $matches[5];
$g_db_username          = $matches[2];
$g_db_password          = $matches[4];
$g_database_name        = $matches[9];

$g_db_type              = 'mysql';


define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', ''     );

define('FS_METHOD', 'direct');

#define('WP_HOME','http://usblog.triumph.com');
#define('WP_SITEURL','http://usblog.triumph.com');


$table_prefix  = 'wp_';

define('WP_DEBUG', false);

if ( !defined('ABSPATH') )
  define('ABSPATH', dirname(__FILE__) . '/');

require_once(ABSPATH . 'wp-settings.php');
