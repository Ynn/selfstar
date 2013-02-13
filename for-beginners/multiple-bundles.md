<article markdown="1">

#Building an application from multiple bundles

In the [previous tutorial](/article/for-beginners/intro-services), you have learned how to provide and use services. All the services were provided and used by the same bundle. This has several drawbacks as you can not provide new services without redeploying and restarting the bundle. In this tutorial, you will learn how to use the bundles to separate providers from client.


## Decoupling

The main advantage of using multiple bundles is the capability of adding new classes and packages to the application. This possibility largely depends on how you divide the application. You should have two things in mind when creating bundles :

First, you have to define how many bundle you will use. If you split your application into two many blocks, then it will quickly become unmaintainable and resource-intensive. So you will have to find the good balance between maintainability and dynamism.

Second, and corollary, you will have to define the good division. A poor subdivision will induce a poor dynamism. When you decouple client from providers you have to consider how often classes are changed. Bundles are coupled by their packages and classes. If a bundle depends on a package or a class that is changed at runtime, then the bundle will have to be restarted to take the modification into account. 

A good practice is to always separate the interface from the client and from the providers. In that purpose, we will use (at least) three bundles :

+ one bundle containing **the service interface**. This bundle will be the most stable as the service interface should not change too much.
+ one or two bundle containing **the providers**.
+ one bundle containing **the client**.

This way we will be able to change each bundle without restarting the whole application (so as to add new providers for instance).


## The specification bundle

The first bundle will only contains the service interface for the reason explains above. The interface is less likely to change but is used by both clients and providers. It is a good idea to separate it from them.

Create a new project called "hello.service" and then add the interface :

{code lang=java}
package org.example.hello.service;

public interface Hello {
	/**
	* The property lang defines the language used by the service. 
	**/
	public static final String PROP_LANG = "lang";

	void sayHello(String name);
}
{/code}

Pay attention to the package name (org.example.hello.service). You will have to import it inside the other bundles.

You do not need to create any components. Deploy your project and that is all. 

![exporting the package]({#img#}/multiple-bundles/exportPackage1.png)

## The english provider bundle

## The client bundle


</article>