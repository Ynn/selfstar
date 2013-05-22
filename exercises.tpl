{extends file="templates/layout.tpl"}

{block name=baseref}{$baseref}{/block}

{block name=title}Pervasive Computing in Practice{/block}

{block name=stylesheets append}
<link rel="stylesheet" href="css/home.css">
{/block}

{block name=article}

<div id = "introduction" style = "background : white; margin : 2em; padding : 10px 40px 10px 40px;font-family : 'Short Stack'">
<p>
Exercices blahblah
</p>

</div>


<div id="ca-container" class="ca-container">
	<div class="ca-wrapper">
		

		<div class="ca-item">
			<div class="ca-item-main">
				<div class="ca-icon" style="background-image:url(/img/exercices/light.jpg);"></div>
				<h3>Follow Me</h3>
				<h4>
					<span> Learn to build a follow me</span>
				</h4>
					<a href="#" class="ca-more">more...</a>
			</div>
			<div class="ca-content-wrapper">
				<div class="ca-content">
					<h6>Follow Me</h6>
					<a href="#" class="ca-close">close</a>
					<div class="ca-content-text">
						<p>
						blahblah
						</p>
					</div>
					<ul>
						<li><a href="/article/for-beginners/getting-started">Read more</a></li>
					</ul>
				</div>
			</div>
		</div>

		<div class="ca-item">
			<div class="ca-item-main">
				<div class="ca-icon" style="background-image:url(/img/home/simulator.png);"></div>
				<h3>Follow Me</h3>
				<h4>
					<span> Learn to build a follow me</span>
				</h4>
					<a href="#" class="ca-more">more...</a>
			</div>
			<div class="ca-content-wrapper">
				<div class="ca-content">
					<h6>Follow Me</h6>
					<a href="#" class="ca-close">close</a>
					<div class="ca-content-text">
						<p>
						blahblah
						</p>
					</div>
					<ul>
						<li><a href="/article/for-beginners/getting-started">Read more</a></li>
					</ul>
				</div>
			</div>
		</div>

				<div class="ca-item">
			<div class="ca-item-main">
				<div class="ca-icon" style="background-image:url(/img/home/simulator.png);"></div>
				<h3>Follow Me</h3>
				<h4>
					<span> Learn to build a follow me</span>
				</h4>
					<a href="#" class="ca-more">more...</a>
			</div>
			<div class="ca-content-wrapper">
				<div class="ca-content">
					<h6>Follow Me</h6>
					<a href="#" class="ca-close">close</a>
					<div class="ca-content-text">
						<p>
						blahblah
						</p>
					</div>
					<ul>
						<li><a href="/article/for-beginners/getting-started">Read more</a></li>
					</ul>
				</div>
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
	$('#ca-container').contentcarousel();
</script>

{/block}

