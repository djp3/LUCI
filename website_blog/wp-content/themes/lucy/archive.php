<?php
/**
 * @package WordPress
 * @subpackage Default_Theme
 */

get_header();
?>

	<div id="content" class="narrowcolumn" role="main">

		<?php if (have_posts()) : ?>

 	  <?php $post = $posts[0]; // Hack. Set $post so that the_date() works. ?>
 	  <?php /* If this is a category archive */ if (is_category()) { ?>
		<h2 class="pagetitle">Archive for the &#8216;<?php single_cat_title(); ?>&#8217; Category</h2>
 	  <?php /* If this is a tag archive */ } elseif( is_tag() ) { ?>
		<h2 class="pagetitle">Posts Tagged &#8216;<?php single_tag_title(); ?>&#8217;</h2>
 	  <?php /* If this is a daily archive */ } elseif (is_day()) { ?>
		<h2 class="pagetitle">Archive for <?php the_time('F jS, Y'); ?></h2>
 	  <?php /* If this is a monthly archive */ } elseif (is_month()) { ?>
		<h2 class="pagetitle">Archive for <?php the_time('F, Y'); ?></h2>
 	  <?php /* If this is a yearly archive */ } elseif (is_year()) { ?>
		<h2 class="pagetitle">Archive for <?php the_time('Y'); ?></h2>
	  <?php /* If this is an author archive */ } elseif (is_author()) { ?>
		<h2 class="pagetitle">Author Archive</h2>
 	  <?php /* If this is a paged archive */ } elseif (isset($_GET['paged']) && !empty($_GET['paged'])) { ?>
		<h2 class="pagetitle">Blog Archives</h2>
 	  <?php } ?>

		<?php while (have_posts()) : the_post(); ?>
		<div <?php post_class() ?>>
				<h2 id="post-<?php the_ID(); ?>"><a href="<?php the_permalink() ?>" rel="bookmark" title="Permanent Link to <?php the_title_attribute(); ?>"> <?php the_title(); ?> - <?php the_time('F jS, Y') ?>
</a></h2>

				<div class="postFrame">	
                <div class="entry">
					<?php the_content() ?>
				</div><!--END entry-->

			<table style="margin:5px 0px 0px auto ;background-color:rgb(227,178,149);color:black;border:solid rgb(86,138,136) 1px">
				<tr>
					<td colspan="2" style="text-align:center">
						<?php the_tags('Tags: ', ', ', '<br />'); ?>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align:center">
						<span style="color:black">Posted: </span> <a href="<?php the_permalink() ?>" rel="bookmark" title="Permanent Link to <?php the_title_attribute(); ?>"> <?php the_time('n/j/y g:i a T') ?></a> by <?php the_author_posts_link(); ?> <?php edit_post_link('Edit', ' | ', ' | '); ?><?php comments_popup_link('Make the First Comment', 'Add Your Comment', 'Add Your Comment'); ?>
					</td>
				</tr>
				<tr>
					<td width="200px">
						<?php wp_gdsr_render_article_thumbs(49);?>
					</td>
					<td>
						<?php do_action( 'addthis_widget' ); ?> 
					</td>
				</tr>
			</table>
                
                </div><!--END postFrame-->

			</div><!--END post class-->

		<?php endwhile; ?>
		<div class="navigation" style="font-size:x-large">
			<table>
				<tr>
					<td width="40%">
						<div class="alignleft"><?php previous_posts_link('&laquo; Newer Entries') ?></div>
					</td>
					<td>
						<a href="http://luci.ics.uci.edu/blog">Front Page</a>
					</td>
					<td width="40%">
						<div class="alignright"><?php next_posts_link('Older Entries &raquo;') ?></div>
					</td>
				</tr>
			</table>
		</div>
&nbsp;<br/>
&nbsp;<br/>
&nbsp;<br/>
&nbsp;<br/>

	<?php else :

		if ( is_category() ) { // If this is a category archive
			printf("<h2 class='center'>Sorry, but there aren't any posts in the %s category yet.</h2>", single_cat_title('',false));
		} else if ( is_date() ) { // If this is a date archive
			echo("<h2>Sorry, but there aren't any posts with this date.</h2>");
		} else if ( is_author() ) { // If this is a category archive
			$userdata = get_userdatabylogin(get_query_var('author_name'));
			printf("<h2 class='center'>Sorry, but there aren't any posts by %s yet.</h2>", $userdata->display_name);
		} else {
			echo("<h2 class='center'>No posts found.</h2>");
		}
		get_search_form();

	endif;
?>

	</div><!--END content-->

<?php get_sidebar(); ?>

<?php get_footer(); ?>
