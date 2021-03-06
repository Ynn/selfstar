<article markdown = "1"/>
# Getting Started 

The learning environment is made of three integrated tools (see figure):

+ **An Execution platform based on OSGi and iPOJO**. This platform supports the dynamic execution of the Java applications. It also supports the execution of the iCasa simulator mentioned here after. 

+ **An Integrated Development Environment**. This Eclipse-based IDE provides comprehensive facilities for the development in OSGi/iPOJO. Specifically, it includes a source code editor, build automation tools and automated deployment on the execution platform.

+ **A smart home simulator called iCasa**. This simulator allows you to create a wide range of devices that can be used by your OSGi/iPOJO applications. It also permits the definition of scenarios that can be played at various speeds. ICasa GUI can be run on any browser whereas the server part is run on OSGi (on the execution platform).

<div style="margin:auto;width : 80%;"/>
<img alt="the iCASA environment" src="{#img#}/getting-started/getting-started.png"/>
</div>

Developing applications in the environment you have downloaded requires a minimum understanding of OSGi and iPOJO. The following articles contain some basic points that students should consider : 

+ [Basics about OSGi](/article/for-beginners/intro-osgi): This article reminds you of OSGi fundamentals. Specifically, it discusses the notions of bundles and services, which are at the heart of the OSGi dynamism.

+ [Basics about Felix](/article/for-beginners/intro-felix): This article explains how the Apache Felix OSGi platform can be managed through a terminal or through a Web console.

+ [Basics about iPOJO](/article/for-beginners/intro-ipojo): This article presents the iPOJO component model and the associated lifecycle. It shows how to create and deploy components with the IDE and write a basic Hello world component. 

The environment also includes an IDE facilitating the development and deployment of iPOJO applications. The following articles teach you how to use this IDE effectively : 

+ [Your first iPOJO component](/article/for-beginners/ide-hello-world): This article shows how to create and deploy a simple "Hello World" component with IDE. 

+ [iPOJO component instances](/article/for-beginners/component-properties): This article shows how to improve the "Hello World" component through the use of configuration properties, which allows to specialize the behaviour of component instances.

+ [Providing and using services](/article/for-beginners/intro-services): This article shows how to implement a multilingual "Hello world" using services.

+ [Dividing an application into multiple bundles](/article/for-beginners/multiple-bundles): This article elaborates on the  "Hello World" and separates out the component providing services from those using services. It defines three bundles (specification, client and provider) and shows how to configure the dependencies between these bundles.

</article>
{section_links}
