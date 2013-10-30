<?php
/**
 * @package WordPress
 * @subpackage Default_Theme
 */

get_header();
?>

	<div id="content" class="narrowcolumn" role="main">    

	<?php if (have_posts()) : while (have_posts()) : the_post(); ?>
    
    <div <?php post_class() ?> id="post-<?php the_ID(); ?>">
    
    <h2><?php the_title(); ?></h2>
    
    <div class="postFrame">		
			
			<div class="entry">
				<?php the_content('<p class="serif">Read the rest of this entry &raquo;</p>'); ?>

				<?php wp_link_pages(array('before' => '<p><strong>Pages:</strong> ', 'after' => '</p>', 'next_or_number' => 'number')); ?>
			</div><!--END entry-->
			<?php similar_posts('prefix=<div class="similar_container"><h3>Similar Posts:</h3><ul class="similar_posts">&suffix=</ul></div>'); ?>

			<table style="margin-left:auto;margin-right:auto;background-color:rgb(227,178,149);color:black;border:solid rgb(86,138,136) 1px">
				<tr>
					<td colspan="2" style="text-align:center">
						<?php the_tags('Tags: ', ', ', '<br />'); ?>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align:center">
						<span style="color:black">Posted: </span> <a href="<?php the_permalink() ?>" rel="bookmark" title="Permanent Link to <?php the_title_attribute(); ?>"> <?php the_time('n/j/y g:i a T') ?></a> by <?php the_author_posts_link(); ?> (<a href="<?php echo get_the_author_meta('user_url'); ?>">g+</a>) <?php edit_post_link('Edit', ' | ', ' | '); ?><?php comments_popup_link('Make the First Comment', 'Add Your Comment', 'Add Your Comment'); ?>
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
<hr style="border:color:rgb(86,138,136) 1px ;color:rgb(86,138,136);background-color:rgb(86,138,136)"/>
        
	<?php comments_template(); ?>    
    
	</div><!--END postFrame-->
    
    </div><!--END post-number-->
    
		<div class="navigation" style="font-size:large">
<!--
			<div class="alignleft"><?php previous_post_link('&laquo; %link') ?></div>
			<div class="alignright"><?php next_post_link('%link &raquo;') ?></div>-->
		<table>
			<tr>
				<td width="40%">
					<div class="alignright"><?php next_post() ?></div>
				</td>
				<td>
					<a href="http://luci.ics.uci.edu/blog">Front Page</a>
				</td>
				<td width="40%">
					<div class="alignleft"><?php previous_post() ?></div>
				</td>
			</tr>
		</table>
		</div><!--END navigation-->


	<?php endwhile; else: ?>

		<p>Sorry, no posts matched your criteria.</p>

<?php endif; ?>

		
	</div><!--END content-->
    
<?php get_sidebar(); ?>

<?php get_footer(); ?>