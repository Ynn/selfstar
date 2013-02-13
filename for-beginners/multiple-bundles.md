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

### Implement the bundle :
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


### Configuration : Export the package

You need to export the package containing your code. This will allow the other bundles to import and use it.
In that purpose, you will have to edit the MANIFEST of your bundle. The MANIFEST contains bundle metadata such as its name or its version. 

Open the file "META-INF/MANIFEST.MF" using the "Manifest Editor" (default editor).Three panels are interesting for you :

+ **the overview panel** allows to configure the main information (name, vendor name, etc ...). 
+ **the dependency panel** is provided to configure the bundle imported packages (we will use this later).
+ **the runtime panel** gives access to the "import package" configuration. 

Go to the runtime panel and click add next to "Export Packages" as shown below :

![exporting the package]({#img#}/multiple-bundles/exportPackage1.png)

Then select the "org.example.hello.service" package. Eventually, your configuration will look like this :

![exporting the package]({#img#}/multiple-bundles/exportPackage2.png)

### Deployment

You do not need to create any components. Deploy your project using the IDE. 

You can check that the deployment has been successful using the [web console]({#link_web_console#}). If you search carefully, you will see that the "org.example.hello.service" package is exported by the bundle :

![check exported package]({#img#}/multiple-bundles/checkExport.png)

## The english provider bundle
This steps are appromatively the same than when you learned how to [use and provide services](/article/for-beginners/intro-service).


### Import the service package

You will need to import the package before using it. We will do that first. 

Go and edit the "META-INF/MANIFEST.MF" files. 

![import the package]({#img#}/multiple-bundles/importPackage1.png)




Create a new iPOJO project called "hello.english.provider" and the use the same component definition :



## Practice : the french provider

Do the same for the french provider.

## The client bundle


</article>