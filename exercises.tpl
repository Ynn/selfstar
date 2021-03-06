{extends file="templates/layout.tpl"}

{block name=baseref}{$baseref}{/block}

{block name=title}Pervasive Computing in Practice{/block}

{block name=stylesheets append}
<link rel="stylesheet" href="css/home.css">
{/block}

{block name=article}

<div id = "introduction">
<p>
This page presents several exercises sets motivating the introduction of self-management in pervasive applications.
</p>
<p>
Exercises are divided into several themes: light management, heating management, alarm management, etc. For each theme, the progression is the same: we start with basic (non robust!) pervasive applications and we gradually introduce harder requirements demanding autonomic capabilities.</p>
</p>
</div>


<div id="ca-container" class="ca-container">
	<div class="ca-wrapper">
		

		<div class="ca-item" onClick="location.href = '/article/exercises/follow-me';">
			<div class="ca-item-main">
				<div class="ca-icon" style="background-image:url(/img/exercises/light.png);"></div>
				<h3>Follow Me</h3>
				<h4>
					<span> Learn to build a follow me</span>
				</h4>
					<a href="/article/exercises/follow-me" class="inactive-more">Exercises...</a>
			</div>
		</div>


		<div class="ca-item">
			<div class="ca-item-main" onClick="location.href = '/article/exercises/hvac';">
				<div class="ca-icon" style="background-image:url(/img/exercises/heater.png);"></div>
				<h3>Temperature management</h3>
				<h4>
					<span>Maintaining the climate in the rooms</span>
				</h4>
					<a href="/article/exercises/hvac" class="inactive-more">Exercises...</a>			
			</div>
		</div>

				<div class="ca-item">
			<div class="ca-item-main" onClick="location.href = '/article/exercises/various';">
				<div class="ca-icon" style="background-image:url(/img/exercises/alarm.png);"></div>
				<h3>Various <br/>management</h3>
				<h4>
					<span> Various exercises providing less guidance</span>
				</h4>
					<a href="/article/exercises/various" class="inactive-more">Exercises...</a>			
			</div>
		</div>



	</div>

</div>



{/block}


{block name=script}

<script type="text/javascript" src="js/vendor/slider/jquery.easing.1.3.js"></script>
<!-- the jScrollPane script -->
<script type="text/javascript" src="js/vendor/slider/jquery.mousewheel.js"></script>
<script type="text/javascript" src="js/vendor/slider/jquery.contentcarousel.js"></script>
<script type="text/javascript">
	$('#ca-container').contentcarousel({
    // speed for the sliding animation
    sliderSpeed     : 500,
    // easing for the sliding animation
    sliderEasing    : 'easeOutExpo',
    // speed for the item animation (open / close)
    itemSpeed       : 500,
    // easing for the item animation (open / close)
    itemEasing      : 'easeOutExpo',
    // number of items to scroll at a time
    scroll          : 0
});
	</script>
{/block}

