{extends file="templates/layout.tpl"}
{block name=baseref}{$baseref}{/block}
{block name=title}Pervasive Computing in Practice{/block}

{block name=stylesheets append}
<link rel="stylesheet" href="css/home.css">
{/block}

{block name=article}

<!--

{assign var=sectionNames value=["for-beginners","first-applications"]}


<div id="ca-container" class="ca-container">
	<div class="ca-wrapper">
		{foreach $sectionNames as $section}

		{xml var="xml"}
		{include file="content/$section/section.md"}
		{/xml}


		<div class="ca-item ca-item-1">
			<div class="ca-item-main">
				<div class="ca-icon" style="background-image:url('/{$xml.section.icon[0]}');"></div>
				<h3>{$xml.section.title[0]}</h3>
				<h4>
					<span>{$xml.section.description[0]}</span>
				</h4>
					<a href="#" class="ca-more">more...</a>
			</div>
			<div class="ca-content-wrapper">
				<div class="ca-content">
					<h6>{$xml.section.title[0]}</h6>
					<a href="#" class="ca-close">close</a>
					<div class="ca-content-text">
						{$xml.section.toc[0]|markdown}
					</div>
					<ul>
						<li><a href="{$xml.section.link[0]}">Read more</a></li>
					</ul>
				</div>
			</div>
		</div>

		{/foreach}
	</div>
</div>


-->

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