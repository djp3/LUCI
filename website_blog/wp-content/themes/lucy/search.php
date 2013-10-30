<?php
/**
 * @package WordPress
 * @subpackage Default_Theme
 */

get_header(); ?>

	<div id="content" class="narrowcolumn" role="main">

	<?php if (have_posts()) : ?>

		<h2 class="pagetitle">Search Results</h2>

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


		<?php while (have_posts()) : the_post(); ?>

			<div <?php post_class() ?> id="post-<?php the_ID(); ?>">
				<h2><a href="<?php the_permalink() ?>" rel="bookmark" title="Permanent Link to <?php the_title_attribute(); ?>"> <?php the_title(); ?></a>
				<div class="postFrame">

			<table style="margin:5px 0px 0px auto ;background-color:rgb(227,178,149);color:black;border:solid rgb(86,138,136) 1px">
				<tr>
					<td colspan="2" style="text-align:center">
						<?php the_tags('Tags: ', ', ', '<br />'); ?>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align:center">
						<span style="color:black">Posted: </span> <a href="<?php the_permalink() ?>" rel="bookmark" title="Permanent Link to <?php the_title_attribute(); ?>"> <?php the_time('n/j/y g:i a T') ?></a> by <?php the_author_posts_link(); ?> 
					</td>
				</tr>
			</table>
				</div>
			</div>

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

	<?php else : ?>

		<h2 class="center">No posts found. Try a different search?</h2>
		<?php get_search_form(); ?>

	<?php endif; ?>

	</div>

<?php get_sidebar(); ?>

<?php get_footer(); ?>
