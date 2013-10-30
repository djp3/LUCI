=== Activity Sparks ===
Contributors: pantsonhead
Tags: widget, plugin, sidebar, activity, graph, google, chart, sparkline, posts, comments
Requires at least: 2.8
Tested up to: 3.2.1
Stable tag: trunk

Display a customizable sparkline graph of post and/or comment activity.

== Description ==

Activity Sparks is a highly customizable widget to display a "sparkline" style graph in your sidebar indicate post and/or comment activity. This plugin leverages Google's Chart API, so does not require the PHP GDI library. Customization options include Title, size, colour, background transparency, caching period, activity granularity and period.


== Installation ==

1. Upload `activitysparks.php` to the `/wp-content/plugins/` directory of your WordPress installation
2. Activate the plugin through the 'Plugins' menu in WordPress
3. The widget can now be configured and used from the Appearance -> Widgets menu


== Screenshots ==

1. Example implementation (3 instances)

== Frequently Asked Questions ==

= Can I use it if I don't want to call a widget in the sidebar? =

Basic template tag support was added in v0.3. The following code checks for plugin activation and renders with the default settings.

		<?php if(function_exists('activitysparks')) {
			activitysparks();	
		} ?>

To change the default settings you must pass an array of the parameters you wish to alter. These are the available parameters and valid values

* dataset = 'posts', 'comments', 'both' or 'legend'
* width_px = positive integer
* height_px = positive integer
* period = 1, 7, 14, 30, etc. (number of days to group by)
* ticks = positive integer (number of periods to display)
* chma = 0 or positive integer (chart margin px)
* bkgrnd = 6 character hex value (e.g. FFFFFF) or 'NONE' for transparency
* posts_color = 6 character hex value (e.g 4D89F9)
* comments_color = 6 character hex value (e.g FF9900)

An example of how to implement parameters is as follows:

		<?php if(function_exists('activitysparks')) {
			activitysparks(array('dataset'=>'legend','width_px'=>480,bkgrnd=>'NONE'));	
		} ?>

Caching is not available for the template tag implementation.

== Changelog ==

= v0.5 2012-10-23 =

* Fixed caching issues.

= v0.4.2 2012-10-05 =

* Fixed issues highlighted by debugging mode.

= v0.4.1 2012-09-18 =

* Tested up to: 3.2.1 

= v0.4 2009-09-02 =

* Added optional category observance
* Fixed ticks bug

= v0.3 2009-08-19 =

* Added color swatches to widget UI
* Added basic template tag support

= v0.2 2009-08-17 =

* Added optional caching (90% faster)

= v0.1 2009-08-14 =

* Initial release