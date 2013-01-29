<article class="single-column" markdown = "1"/>

# Getting Started

The iCASA environment is based on three tools (as shown on the figure below):

+ **An Integrated Development Environment (iCASA-IDE)** that ease the creation of pervasive application by automating repetitive task such as deployment. This environment also simplify the creation of components by providing an IDE to graphically declare and instantiate components.
+ **An Execution platform based on OSGi and iPOJO**. The Execution platform supports the execution of the pervasive application and is provided with a set of simulated devices.
+ **A graphical interface**, the iCASA simulator GUI, that allows to manage the platform and visualize the action of the applications on the simulated environment.

<div style="margin:auto;width : 80%;"/>
<img alt="the iCASA environment" src="{#img#}/getting-started/getting-started.png"/>
</div>

Developing applications requires some basic knowledge on OSGi and iPOJO. If your are not familiar with OSGi or the iPOJO component model, these knowledge and a presentation of the IDE is provided by these articles :

+ [a short introduction on OSGi and the notion of bundle](?s=introduction&p=intro-runtime) : in this tutorial you learn how to start and stop the iCASA framework and how to manage your application. You will learn that applications are divided into bundles and what a bundle is.
+ [an introduction to iPOJO and how to write a basic Hello world component](?s=introduction&p=basic-hello-world) : in this tutorial, you will learn how to write your first bundle. In that purpose, we will introduce the iPOJO component model. You will learn how to create a component and manage its lifecycle. You will use the IDE to create components.
+ [how to use properties to configure iPOJO component instances](?s=introduction&p=component-properties) : in this section you will improve your "Hello World" component by learning how to add configuration properties to an iPOJO component. This will allow you to specialize the behaviour of your component instances.
+ [Introduction to services](?s=introduction&p=intro-services) (in progress) : in this section, we will introduce the notion of service. Service are at the heart of the dynamism of OSGi platform. You will learn how to implement the multilingual "Hello world" using services.
+ [Dividing your application into multiple bundles](#) (TODO) : this section improves the previous "Hello World" to separate the component that provide services from the components that use services. We will use two bundle, one for the client, one for the consumer and show you how to configure the dependencies between bundles.



</article>
