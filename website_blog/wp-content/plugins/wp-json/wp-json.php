<?
/*
Plugin Name: WP-JSON
Plugin URI: http://frontendbook.com/wordpress/plugins/wp-json
Description: A plugin that easily enables you start syndicating your blog entries using JSON. This enables third party integration with JavaScript solutions cross domain without use of proxy. Supports callback. If mod_rewrite permalinks are enabled call /feed/json/?callback=METHOD and if mod_rewrite is disabled call using ?feed=json&callback=METHOD
Author: Mattias Hising
Author URI: http://frontendbook.com
Version: 1.0
*/

/*
This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

function wp_json_check_url(){
	
	if(preg_match('/\/feed\/json\//', $_SERVER['REQUEST_URI']) || $_REQUEST['feed'] == 'json') {
		header('Content-Type: application/json; charset=' . get_option('blog_charset'), true);

		$items = array();
		
		query_posts("");
		
		while (have_posts())  {
			the_post();
			$item = array(
				"title" => get_the_title_rss(),
				"link" => apply_filters('the_permalink_rss', get_permalink()),
				"description" => apply_filters('the_excerpt_rss', get_the_excerpt())
			);
			$items[] = $item;
		}

		$arr = array(
			'title' => get_bloginfo_rss('name'),
			'link' => get_bloginfo_rss('url'),
			'description' => get_bloginfo_rss('description'),
			'language' => get_option('rss_language'),
			'items' => $items
		);
		if(function_exists('json_encode')) {
			die("".$_REQUEST["callback"]."(".json_encode($arr).");");
		} else {
			//TODO: Add backwards compatibility to before PHP 5.2
			require_once("lib/json.php");
			$json = new Services_JSON();
			die("".$_REQUEST["callback"]."(".$json->encode($arr).");");
			
		}
	}
}

add_action('init','wp_json_check_url');

?>