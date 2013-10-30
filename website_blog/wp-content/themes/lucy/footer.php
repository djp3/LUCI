<?php
/**
 * @package WordPress
 * @subpackage Default_Theme
 */
?>

	<hr />
     <div class="clear"></div>
    </div><!--END page-->
    
   
    
	<div id="footer" role="contentinfo">
    <div id="footer-wrap">
    	<div class="leftAligned">
        	<a href="http://djp3-pc2.ics.uci.edu/LUCI_blog/contrib.php" target="_blank"><img src="<?php bloginfo('stylesheet_directory'); ?>/images/footer_submit_your_stories.jpg" class="inFooter"/></a>
        </div><!--END leftAligned-->
        
        <div id="footerText" class="centerAligned">
        	<p>Copyright 2010 - all rights reserved</p>
        </div><!--END centerAligned-->
        
        <div class="rightAligned">
        	<img src="<?php bloginfo('stylesheet_directory'); ?>/images/footer_follow_us_on.jpg" class="inFooter" id="follow_us_on"/>
            <a href="http://twitter.com/LUCI_at_UCI" target="_blank"><img src="<?php bloginfo('stylesheet_directory'); ?>/images/footer_twiter_logo.jpg" class="footerIco"/></a>
            <a href="http://www.facebook.com/pages/LUCI-The-Laboratory-for-Ubiquitous-Computing-and-Interaction-a/119724564723161?v=wall" target="_blank"><img src="<?php bloginfo('stylesheet_directory'); ?>/images/footer_facebook_logo.jpg" class="footerIco"/></a>
            <a href="http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewPodcast?id=320997099" target="_blank"><img src="<?php bloginfo('stylesheet_directory'); ?>/images/footer_music_logo.jpg" class="footerIco"/></a>
            <a href="<?php bloginfo('rss2_url'); ?>" target="_blank"><img src="<?php bloginfo('stylesheet_directory'); ?>/images/footer_rss_logo.jpg" class="footerIco"/></a>
            <a href="?page_id=442"><img src="<?php bloginfo('stylesheet_directory'); ?>/images/footer_envelope_logo.jpg" class="inFooter" id="envelope"/></a>
        </div><!--END rightAligned-->
        
        
	
	</div><!--END footer-wrap-->
    </div><!--END footer-->
    

	<script type="text/javascript"> 
		Cufon.set('fontFamily', 'DIN 30640 Std').replace('.post h2');
		Cufon.now(); 
    </script>

		<?php wp_footer(); ?>
</body>
</html>
