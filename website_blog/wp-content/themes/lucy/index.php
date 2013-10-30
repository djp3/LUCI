<?php
/**
 * @package WordPress
 * @subpackage Default_Theme
 */

get_header(); ?>

	<div id="content" class="narrowcolumn" role="main">

	<?php if (have_posts()) : ?>

		<?php while (have_posts()) : the_post(); ?>
			<div <?php post_class() ?> id="post-<?php the_ID(); ?>">
				<h2><a href="<?php the_permalink() ?>" rel="bookmark" title="Permanent Link to <?php the_title_attribute(); ?>">
<?php the_title(); ?></a>
 </h2>
                
            <div class="postFrame test">	
            
				<div class="entry">
					<?php the_content('Read the rest of this entry &raquo;'); ?>
				</div><!--END entry-->


		<!-- recent comment of each post -->
			<?php
				$comment_array = array_reverse(get_approved_comments($wp_query->post->ID));
				$count = 1;
			?>

			<table width="100%" align="center" style="border:solid rgb(200,200,200) 1px;">
			<?php if ($comment_array) { ?>
				<?php foreach($comment_array as $comment){ ?>
					<?php if ($count++ <= 5) { ?>
						<tr>
							<td style="border-right:solid rgb(200,200,200) 1px; border-bottom:solid rgb(200,200,200) 1px;">
								Posted by <?php comment_author_link(); ?>
							</td>
							<td style="border-bottom:solid rgb(200,200,200) 1px;">
								<span class="comment">
				<a href="<?php the_permalink() ?>" rel="bookmark" title="Permanent Link to <?php the_title_attribute(); ?>">
								<?php comment_excerpt(); ?> </a>
								</span>
							</td>
						</tr>
					<?php } ?>
				<?php } ?>
				<?php if ($count > 5) { ?>
					<tr>
						<td></td>
						<td>
						(<a href="<?php the_permalink() ?>" rel="bookmark" title="Permanent Link to <?php the_title_attribute(); ?>"><?php comments_popup_link('Make the First Comment', 'Add Your Comment', 'Read % Comments'); ?></a>)
						</td>
					</tr>
				<?php }?>
			<?php } ?>
			</table>
			<table style="margin-left:auto;margin-right:auto;;color:black;border:solid rgb(86,138,136) 0px">
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
						<?php 
					$customAddThis = array(
    							'size' => '16', // size of the icons.  Either 16 or 32
    							'services' => 'facebook,twitter,google_plusone,email', // the services you want to always appear
    							'preferred' => '3', // the number of auto personalized services
    							'more' => true // if you want to have a more button at the end
					);
					do_action( 'addthis_widget',get_permalink(),get_the_title(),$customAddThis ); ?>
					</td>
				</tr>
			</table>

		<!-- end recent comment-->

			
            </div><!--END postFrame-->
            </div><!--END post-numbner-->

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
		


	<?php else : ?>

		<h2 class="center">Not Found</h2>
		<p class="center">Sorry, but you are looking for something that isn't here.</p>
		<?php get_search_form(); ?>

	<?php endif; ?>

	</div>

<?php get_sidebar(); ?>

<?php get_footer(); ?>