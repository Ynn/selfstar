{extends file="templates/layout.tpl"}

{block name=baseref}{$baseref}{/block}

{block name=title}Pervasive Computing in Practice{/block}

{block name=stylesheets append}
<link rel="stylesheet" href="css/home.css">
{/block}

{block name=article}

<div id = "introduction">
<p>
This Web site comes with our book entitled “Autonomic Computing: Principles, design and implementation”. 
</p>
<p/>
<p>
It defines a set of exercises motivating in a progressive way the introduction of self-management in pervasive applications. It also provides a development environment based on the iPOJO component model and the iCasa simulator allowing an immediate and concrete feedback. 
</p>
<p>
We hope this web environment will grow with the book, learning from the feedback that we receive from practitioners and students alike.
</p>

<p style = "font-family: Courgette; font-size : 16px;text-align : right;">Philippe Lalanda, Julie McCann, Ada Diaconescu</p>
</div>


<div id="ca-container" class="ca-container">
	<div class="ca-wrapper">
		

		<div class="ca-item">
			<div class="ca-item-main">
				<div class="ca-icon" style="background-image:url(/img/book_icon.jpg);"></div>
				<h3>Autonomic Computing book</h3>
				<h4>
					<span> Authored by Philippe Lalanda, Julie McCann and Ada Diaconescu.</span>
				</h4>
					<a href="#" class="ca-more">more...</a>
			</div>
			<div class="ca-content-wrapper">
				<div class="ca-content">
					<h6>Autonomic Computing Book</h6>
					<a href="#" class="ca-close">close</a>
					<div class="ca-content-text">
						<p>
Autonomic computing seeks to render computing systems as self-managed. In other words, its objective is to enable computer systems to manage themselves so as to minimise the need for human input. 
</p>
<p>
Implementing self-managed systems however remains a true challenge today. Thus, beyond giving necessary explanations about the objectives and interests of autonomic computing, this book goes through the different software engineering techniques that are currently available for organizing and developing self-managed software systems.
						</p>
					</div>
					<ul>
						<li><a href="/article/general/about">Read more</a></li>
					</ul>
				</div>
			</div>
		</div>






		<div class="ca-item">
			<div class="ca-item-main">
				<div class="ca-icon" style="background-image:url(../img/home/home.png);"></div>
				<h3>Build pervasive applications with iPOJO</h3>
				<h4>
					<span>Learn how to build pervasive applications step by step using the tutorials and the provided tools.</span>
				</h4>
					<a href="#" class="ca-more">more...</a>
			</div>
			<div class="ca-content-wrapper">
				<div class="ca-content">
					<h6>Learn to build pervasive applications</h6>
					<a href="#" class="ca-close">close</a>
					<div class="ca-content-text">
						<p>We have designed an environment that allows students to progressively develop, execute, and test pervasive and autonomic applications. This environment comprises an IDE, an execution environment based on OSGi/iPOJO and a smart home simulator. 
						</p>
						<p>

OSGi is an execution framework developed on top of Java. It builds on the Java’s dynamic features (classloaders and on demand class loading) to provide a coarse-grained level of modularity.
</p>
<p>
The IDE allows the rapid and simplified development of iPOJO applications. It provides a set of facilities to assist the developer in the creation and deployment of iPOJO components. 
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
				<h3>Test with iCASA simulator</h3>
				<h4>
					<span>This simulator is made of a web-based GUI and simulated devices.</span>
				</h4>
					<a href="#" class="ca-more">more...</a>
			</div>
			<div class="ca-content-wrapper">
				<div class="ca-content">
					<h6>Play with iCASA</h6>
					<a href="#" class="ca-close">close</a>
					<div class="ca-content-text">

<p>
ICasa is a smart home simulator developed in the context of the Medical project (http://medical.imag.fr).
</p>
<p>
ICasa allows the loading of any map, the definition of smart spaces (zones) and the dynamic management of devices lifecyle. ICasa also provides facilities to run scenarios, playing with time and devices. The purpose of the simulator is to provide immediate, concrete feedback to the students developing their applications.
</p>

<p>
Technically speaking, iCasa is based on OSGi and iPOJO and takes advantage of their versatility and dynamism. iCASA is provided as a set of modules and components (e.g. bundles and iPOJO components) that are deployed on a OSGi/iPOJO framework
</p>

					</div>
					<ul>
						<li><a href="/article/for-beginners/getting-started">Read more</a></li>
					</ul>
				</div>
			</div>
		</div>


<!--

		<div class="ca-item">
			<div class="ca-item-main">
				<div class="ca-icon" style="background-image:url(/img/hello-world/Generation.png);"></div>
				<h3>Develop using iCASA-IDE</h3>
				<h4>
					<span>iCASA-IDE includes a source code editor, build automation tools and automated deployment.</span>
				</h4>
					<a href="#" class="ca-more">more...</a>
			</div>
			<div class="ca-content-wrapper">
				<div class="ca-content">
					<h6>Develop using iCASA-IDE</h6>
					<a href="#" class="ca-close">close</a>
					<div class="ca-content-text">
					<p>Learning	OSGi	/	iPOJO	technologies may	take	some	time,	even for	good	JAVA	developers.	Students need	to	get	familiar	with	new	concepts	like	components	or	services but	they	also	have	to	learn	new	development	environments	(including	XML	configuration	files	and annotations).
					</p>
						<p>
						In	order	to	allow	students	to	more	rapidly	focus	on	pervasive and autonomic	concepts,	we	have	developed	an	iPOJO	IDE	(Integrated	Development	Environment)	allowing	the	rapid	and	simplified	development	of	iPOJO	applications.	This	environment	provides	a	set	of	facilities	to	assist	the	developer	in the	creation	and	deployment	of	iPOJO	components.	In	particular,	a	number	of	classes	and	files	are	(partially)	generated.	Also,	deployment	can	be	fully	automated. </p>
											</div>
					<ul>
						<li><a href="/article/for-beginners/getting-started">Read more</a></li>
					</ul>
				</div>
			</div>
		</div>

		<div class="ca-item">
			<div class="ca-item-main">
				<div class="ca-icon" style="background-image:url(/img/home/OSGi.png);"></div>
				<h3>Dynamically deploy on OSGi</h3>
				<h4>
					<span>This platform supports the dynamic execution of the pervasive applications developed by students.</span>
				</h4>
					<a href="#" class="ca-more">more...</a>
			</div>
			<div class="ca-content-wrapper">
				<div class="ca-content">
					<h6>Deploy on a dynamic platform</h6>
					<a href="#" class="ca-close">close</a>
					<div class="ca-content-text">
					<p>Our execution platform is based on OSGi. More precisely, it is a customized version of a popular OSGi implementation called Felix with a set of specific artefacts automatically deployed.</p>
						<p>OSGi is an execution framework developed on top of Java. It builds on the Java’s dynamic features (classloaders and on demand class loading) to provide a coarse-grained level of modularity.</p>
						<p>OSGi supports the dynamic deployment of applications. In short, it means that you can easily install or update an application (or part of an application) at runtime without restarting the whole platform.</p>
					</div>
					<ul>
						<li><a href="/article/for-beginners/getting-started">Read more</a></li>
					</ul>
				</div>
			</div>
		</div>

-->


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

