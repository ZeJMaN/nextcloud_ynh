ownCloud for YunoHost
---------------------

*This is a work-in-progress package rework to update ownCloud to 9.x
and make use of new YunoHost facilities - e.g. helpers - coming with 2.3.x.*

ownCloud gives you freedom and control over your own data. A personal cloud
which run on your own server. With owncloud you can synchronize your files
over your devices.

**Shipped version:** 9.0.0

![](https://github.com/owncloud/screenshots/blob/master/files/sidebar_1.png)

## Installation

While it's merged to the official application list, you can install it in order
to try - or use it with caution! - either from the command line:

    $ sudo yunohost app install https://github.com/jeromelebleu/owncloud_ynh/tree/testing

or from the Web administration:

  * Go to *Applications*
  * Click on *Install*
  * Scroll to the bottom of the page and put `https://github.com/jeromelebleu/owncloud_ynh/tree/testing`
    under **Install custom app**.

## TODO

 * Test the upgrade from the current official package
 * Develop an app to integrate SSOwat logout - see
   [here](https://doc.owncloud.org/server/9.0/developer_manual/app/hooks.html#session)
 * Update the external storage plugin configuration - see
   [here](https://doc.owncloud.org/server/9.0/admin_manual/configuration_server/occ_command.html#files-external-label)
 * Rescan filesystem at upgrade and restoration - see
   [here](https://doc.owncloud.org/server/9.0/admin_manual/configuration_server/occ_command.html#file-operations)
 * Add a *clean* argument to the remove script to delete data folder?
 * ...

## Links ##

**ownCloud**: https://owncloud.org/

**YunoHost**: https://yunohost.org/