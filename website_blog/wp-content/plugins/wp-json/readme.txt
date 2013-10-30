# WP-JSON
* Contributors: hising
* Tags: json, feed
* Requires at least: 2.5
* Tested up to: 2.7

## Introduction

WP-JSON Lets you easily syndicate your feed as JSON enabling easy third party JavaScript integration.
 
## Description

WP-JSON is a plugin that easily enables you start syndicating your blog entries using JSON. This enables third party integration with JavaScript solutions cross domain without use of proxy. Supports JSON-callback parameter. Inspired by this [blog post](http://blog.julienviet.com/2008/08/14/json-support-for-wordpress/) but now bundled as a plugin and with support for PHP installations lower than 5.2.0

## Installation
1. Upload the wp-json folder to your plugin directory
2. Activate the WP-JSON plugin in the plugin section of your blog admin interface
3. Test that your blog responds correctly:
* With mod_rewrite enabled: http://yourblog.com/feed/json/?callback=method
* With mod_rewrite disabled: http://yourblog.com/?feed=json&callback=method

## Frequently Asked Questions

### How do I grab the JSON Feed?

* Use http://yourblog.com/[path/]feed/json/?callback=method
* If you do not have mod_rewrite enabled: http://yourblog.com/[path/]?feed=json&callback=method

### Where can I find an example of this in use?

Try [http://frontendbook.com/feed/json/?callback=method](http://frontendbook.com/feed/json/?callback=method) and you should see our feed syndicated in JSON.

	$(function(){
		$("body").append('<div id="wp-json">Loading JSON</div>');
		$("#wp-json").css({
			'position' : 'fixed',
			'right' : '0px',
			'top' : '0px',
			'background' : '#f00'
			});
			$.getJSON('http://frontendbook.com/feed/json/?callback=?', function(json){
				var result = '<ul>';
				$.each(json.items, function(){
					result += '<li><a href="' + this.link + '">' + this.title + '</a></li>';})
				result += '</ul>';
				$("#wp-json").css({
					'background' : '#fff'
				}).html(result);
			});
	});

### Can you recommend any good JavaScript library for reading JSON?
Yes, I can, I prefer using the [jQuery JavaScript Library](http://jquery.com)