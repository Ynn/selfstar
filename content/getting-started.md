<article class="single-column" markdown = "1"/>

# Getting Started

The learning environment you have downloaded is made of three complementary tools (see figure below):

+ **An Integrated Development Environment**. This Eclipse-based IDE provides comprehensive facilities for the development of pervasive applications based on OSGi/iPOJO. Specifically, it includes a source code editor, build automation tools and automated deployment on the execution platform.

+ **An Execution platform based on OSGi and iPOJO**. This platform supports the execution of the pervasive applications developed by students.

+ **A home simulator called iCASA**. This simulator is made of two synchronized parts: a GUI that can be run on any Web browser and a set of OSGi components running on the execution platform linked with the pervasive applications. 


<div style="margin:auto;width : 80%;"/>
<img alt="the iCASA environment" src="{#img#}/getting-started/getting-started.png"/>
</div>

Developing applications requires a minimum understanding of OSGi and iPOJO. The following articles contain some basic points that students should consider : 

+ [Basics about OSGi](?s=introduction&p=intro-runtime): This article reminds you of OSGi fundamentals including the notion of bundle and dynamic deployment. It also explains how our OSGi execution platform can be managed (started, stopped, observed, etc.).

+ [Basics about iPOJO](?s=introduction&p=basic-hello-world): This article presents the iPOJO component model and the associated lifecycle. It  shows how to create and deploy components with the IDE and write a basic Hello world component. 

+ [how to use properties to configure iPOJO component instances](?s=introduction&p=component-properties) : in this section you will improve your "Hello World" component by learning how to add configuration properties to an iPOJO component. This will allow you to specialize the behaviour of your component instances.
+ [Introduction to services](?s=introduction&p=intro-services) (in progress) : in this section, we will introduce the notion of service. Service are at the heart of the dynamism of OSGi platform. You will learn how to implement the multilingual "Hello world" using services.
+ [Dividing your application into multiple bundles](#) (TODO) : this section improves the previous "Hello World" to separate the component that provide services from the components that use services. We will use two bundle, one for the client, one for the consumer and show you how to configure the dependencies between bundles.



</article>
