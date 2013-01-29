{config_load file='templates/constants.conf'}

{include file="header.tpl" title="Autonomic Computing in Practice"}

{include file="content/{$page}.md" title="iCasa Simulator" assign="article"}

<div class="main-container">
    <div class="main wrapper clearfix">
		<div id="slides">
			<div class="slides_container">
				<div class="slide">
					<h1>First Slide</h1>
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident.</p>
					<p><a href="#4" class="link">Check out the fourth slide &rsaquo;</a></p>
				</div>
				<div class="slide">
					<h1>Second Slide</h1>
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident.</p>
					<p><a href="#5" class="link">Check out the fifth slide &rsaquo;</a></p>
				</div>
				<div class="slide">
					<h1>Third Slide</h1>
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident.</p>
					<p><a href="#1" class="link">Check out the first slide &rsaquo;</a></p>
				</div>
			</div>
			<a href="#" class="prev"><img src="img/arrow-prev.png" width="24" height="43" alt="Arrow Prev"></a>
			<a href="#" class="next"><img src="img/arrow-next.png" width="24" height="43" alt="Arrow Next"></a>
		</div>
	</div> 
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.min.js"></script>
<script src="js/vendor/slides.min.jquery.js"></script>
<script>
$(function(){
	// Set starting slide to 1
	var startSlide = 1;
	// Get slide number if it exists
	if (window.location.hash) {
		startSlide = window.location.hash.replace('#','');
	}
	// Initialize Slides
	$('#slides').slides({
		preload: true,
		preloadImage: 'img/loading.gif',
		generatePagination: true,
		play: 5000,
		pause: 2500,
		hoverPause: true,
		// Get the starting slide
		start: startSlide,
		animationComplete: function(current){
			// Set the slide number as a hash
			window.location.hash = '#' + current;
		}
	});
});
</script>



