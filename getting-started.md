<article markdown = "1"/>

# Getting Started

The learning environment you have downloaded is made of three complementary tools (see figure below):

+ **An Integrated Development Environment**. This Eclipse-based IDE provides comprehensive facilities for the development of pervasive applications based on OSGi/iPOJO. Specifically, it includes a source code editor, build automation tools and automated deployment on the execution platform.

+ **An Execution platform based on OSGi and iPOJO**. This platform supports the execution of the pervasive applications developed by students.

+ **A home simulator called iCASA**. This simulator is made of two synchronized parts: a GUI that can be run on any Web browser and a set of OSGi components running on the execution platform linked with the pervasive applications. 


<div style="margin:auto;width : 80%;"/>
<img alt="the iCASA environment" src="{#img#}/getting-started/getting-started.png"/>
</div>

Developing applications requires a minimum understanding of OSGi and iPOJO. The following articles contain some basic points that students should consider : 

+ [Basics about OSGi](?s=introduction&p=intro-runtime): This article reminds you of OSGi fundamentals. It also explains how our OSGi execution platform can be managed (started, stopped, observed, etc.).

+ [Basics about iPOJO](?s=introduction&p=basic-hello-world): This article presents the iPOJO component model and the associated lifecycle. It shows how to create and deploy components with the IDE and write a basic Hello world component. 

+ [iPOJO component instances](?s=introduction&p=component-properties): This article shows how to improve the "Hello World" component through the use of configuration properties, which allows to specialize the behaviour of component instances.

+ [Introduction to services](?s=introduction&p=intro-services): This article introduces the notion of service, which is at the heart of OSGi dynamism. It shows how to implement a multilingual "Hello world" using services.

+ [Dividing an application into multiple bundles](#): This article elaborates on the  "Hello World" example and separates out the component providing services from the components using the services. It defines two bundles (client and consumer) and shows how to configure the dependencies between these bundles.



</article>

<aside  markdown="1">

### Summary of links

Basics: 

+ OSGi 
+ iPOJO 
+ Sercice-oriented programming 

IPOJO IDE:

+ Component properties
+ Multiple bundles

ICASA simualtor:

+ blabla
+ blabla

</aside>

