{* Variables(DO NOT DELETE): *}
{assign var="workdir" value="{#dir_runtime_wks#}/first-runtime"}

<article  markdown="1">

# Introduction to OSGi

Our execution platform is based on OSGi. More precisely, it is a customized version of a popular OSGi implementation called [Felix]({#link_felix#}) with a set of specific artefacts automatically deployed. 

The purpose of this page is to provide a quick introduction to OSGi. This knowledge is NOT absolutely necessary to code and run the examples presented here - most operations are hidden or abstracted by the provided IDE. However, it constitutes a background which can be very useful when trying to understand what's really going on during deployment and execution. 



## What is OSGi ?

<img src="http://felix.apache.org/res/logo.png" style="float:right;width:20%; margin : 1em;"/>

OSGi is an execution framework developed on top of Java. It builds on the Java’s dynamic features ([classloaders](http://docs.oracle.com/javase/6/docs/api/java/lang/ClassLoader.html) and [on demand class loading](https://en.wikipedia.org/wiki/Dynamic_loading)) to provide a coarse-grained level of modularity. OSGi is a [specification](http://www.osgi.org/Specifications/HomePage) with several popular implementations like [Equinox](http://www.eclipse.org/equinox/), [Felix]({#link_felix#}) or [Knopflerfish](http://www.knopflerfish.org/). 

OSGi supports the dynamic deployment of applications. In short, it means that you can easily install or update an application (or part of an application) at runtime without restarting the whole platform. 

OSGi relies on the notions of bundles and services, described hereafter.

## The notion of bundle

OSGi relies on the notion of bundle for modularity. Specifically, a bundle is a Java archive containing executable code, resources, and meta-data (name, version, dependencies to other bundles, etc.). In other words, all the files required to implement a module.

<div style="margin:auto;width : 70%;"/>
<img src="img/intro-runtime/OSGi2.png"/>
</div>


A bundle is both a deployment unit and a composition unit :

+ It is used to package classes and resources so that they can be deployed on one or more execution platforms. 
+ It is also used as building blocks to form modular and dynamic Java applications. The purpose is to organize Java applications into a set of loosely coupled, highly coherent interacting modules.

An application can then be defined as a set of bundles collaborating to provide a service. The boundaries of an application are often hard to determine since many bundles can be used (and bundles can be shared!). For clarity, we distinguish the system bundles (already installed in our case) and the application bundles. An application then means all the bundles that you have written plus the libraries that are not provided by the framework. 


## The notion of service

OSGi allows the dynamic management of bundles. This dynamicity only concerns classes and does not imply the dynamic management of applications. As a remedy, a bundle exposes its functions (services) to the other bundles and, conversely, is able to use functions (services) offered by the other bundles. Functions are concerned with the instance level: they correspond to running classes.

OSGi relies on the definition of a service register containing the services available on the platform at a given time. Regarding service provision, a bundle has to provide the following elements to the registry:

+ A description of the provided service (Java interface).
+ A reference to the implementation class.
+ The non-­‐functional properties.

To use a service, a consumer has to look for it. Two modes are available to do this: active mode and the passive one. In active mode, the potential consumer explicitly accesses the register to get one or several references to services running at that moment. In passive mode, the consumer subscribes to events corresponding to the arrival, departure or modification of specific services. Thus, a consumer can discover, select, and invoke a service when it becomes available.

Code example:

{code lang=java}
//Ask the registry to notify a listener when services matching the filter change.
context.addServiceListener(this, filter); //...

//Implement the listener logic :
public void serviceChanged(ServiceEvent event) { //...
	switch (event.getType()) {
		//if a new service is found :
		case ServiceEvent.REGISTERED:
			//get a reference to the service so as to use it later.
			ServiceReference serviceRef = event.getServiceReference(); //...
{/code}

There are multiple events associated with services. If you want to know more on the topic, you can follow [the Felix tutorial](https://felix.apache.org/site/apache-felix-osgi-tutorial.html). Nonetheless, managing all events and the dynamism easily becomes cumbersome and error-prone. This is the main reason of the introduction of the development of component model such as [Declarative Services](http://wiki.osgi.org/wiki/Declarative_Services) or [iPOJO](http://felix.apache.org/site/apache-felix-ipojo.html) that will be presented [later](/article/for-beginners/intro-ipojo).

## Conclusion

OSGi is one of the few robust platforms explicitly designed to run dynamic applications. It is based on the notions of bundles (modules) and services.  

OSGi tackles the two main challenges of dynamic applications: the integration of code in both the execution environment and in the running application. Bundles are used to dynamically integrate code on the platform through the advanced use of class loaders while services are used to dynamically upgrade applications.

However, managing dynamism at the application level is hard and result in complex code (reacting to multiple events, dealing with concurrency and synchronisation, etc.). IPOJO, the Apache service-oriented component model, has been designed to deal with that.

</article>

{section_links}

<aside  markdown="1">

### Bibliography

More information about OSGi can be found in:

+ OSGi in action by R. Hall, K. Pauls, S. McCulloch, D. Savaga, Manning, 2012.
+ [the OSGi specification](http://www.osgi.org/Specifications/HomePage)

</aside>
