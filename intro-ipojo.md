<article markdown="1">

# Introduction to iPOJO

![Project Name](img/hello-world/Logo.png)

The purpose of this page is to provide a quick introduction to the iPOJO component model. Specifically, it teaches you:

+ The limits of OSGi in term of programming.
+ what is an iPOJO component.
+ what is the lifecycle of an iPOJO component.

As for OSGi, knowing the intricacies of iPOJO is NOT mandatory. However, a basic understanding of the iPOJO principles (modularity, late-binding) is a plus when getting to the exercises. 


## OSGi limits

Managing service-level dependencies is not managed by the platform. This is left to the developer whose code has to capture events emitted by the platform in order to discover, select, use, and change services. This results in pretty complex and error-prone code that can endanger the applications (events can be missed, concurrency must be managed, bad class versions can be called, references can be forgotten, etc.).

Several approaches have been proposed to improve OSGi in terms of dependency management. Among them [iPOJO](https://felix.apache.org/site/apache-felix-ipojo.html) is a solution of choice in the open source world. 



## What is iPOJO

As explained in the OSGi introduction, a bundle is a deployment unit but also a composition unit used to make up modular, dynamic applications in Java. Bundles are thus used to encapsulate code packages (in the Java sense) that can be shared or kept hidden. This allows two bundles to have a package with a same name without conflicts. When they are shared, packages are versioned (each package has also a version number). 




<div style="margin:auto;width : 70%;"/>
<img src="img/intro-runtime/OSGi2.png"/>
</div>

iPOJO introduces the notion of **service oriented component** that you will use all the time when writing an application. Application are divided (once again) into iPOJO components. This naturally raises the question : 

{note}
**What is the difference between a Bundle and an iPOJO Component ?**

The main purpose of the **module (bundle)** is to deal with code dependencies and packaging. It is not concerned by *what the code is doing* (the functionality) but just by *what code it depends*. 

As you guess the notion of service-oriented component is complementary. Components are concerned by *what service is provided*, *what service is required* and *how the code is instantiated*.

**What is a service ?**

The service is related to *what the code is doing*. It is basically the same notion than in the real world (your bank provides banking services). For instance a spell checker will provide a "spell checking" service, a logger will provide a "logging" service, etc ...

**How a service is described ?**

The components needs standard way of describing and use services from other components. As you will see later, in OSGi a service is described by a java interface and some meta information.

{/note}

These two notions are almost orthogonal. You can have components without modules and reciprocally. The whole concept of components has been introduced to allow developers to think in term of functionality instead of code. 

Let's make it more concrete and take an example. Imagine that we have a word processor that use a spellchecker. 

When using modules, we will most likely have :

+ **a word processor module** with several packages and classes. The world processor will depend on the package org.example.english.spellchecker and use the class org.example.EnglishSpellChecker. 
+ **a spellchecker module** that will provide a org.example.english.spellchecker containing the class EnglishSpellChecker and some other utility classes. The spellchecker will explain that it provides this package. 

If for a reason or another (code refactoring, product renaming, conflict in libraries) you need to change the name of packages, you will have to change the dependencies since dependencies are direct reference to the code itself.

When using components, we will have :

+ **a word processor** component that will depend on a SpellChecking service. 
+ **a spellchecker component** that will provide this service. 

The service "Spellchecking" will be described by an interface Spellchecking.java and some meta-information ("english" as a language for instance). How the packages are named is not relevant, the only important thing is what functionality you need and who provides it. If you change the name of the package or classes of the implementation, there will be no consequence on the component dependencies. 

Using high-level concept instead of code makes easy to change the implementation. For instance, it is easy to change the spellchecker component by another.

As bundles and iPOJO components are complementary, we will use both. Each bundle will contains one or more components as shown above.

<div style="margin:auto;width : 70%;"/>
<img src="{#img#}/hello-world/OSGIpojo.png"/>
</div>


## A basic Hello World

In this simple tutorial, we will have one bundle containing one iPOJO component. The project is very basic and we will not use service in this first attempt. The goal is to show how to create an iPOJO component and how to react to lifecycle events : react to the starting and stopping of the bundle.


### Project Creation

Install the iCASA ide and configure it as explain in [the download section](?p=download&s=introduction). We will use first-runtime as our runtime directory (the same runtime than before). 

Open the project wizard and create a new iPOJO project as shown on the picture below :

![Project Creation](img/hello-world/NewProject.png)

Enter "hello.world" as the name of the project. Then click next and finish.

![Project Name](img/hello-world/ProjectName.png)

Each project corresponds to a bundle. So your hello.world project will be packaged as a hello.world.jar bundle.

### Component type definition


Once created, the IDE will open the "iPOJO metadata Editor". You can also access the metadata editor by double-clicking on the metadata.xml file.

Now let's create the component. The Hello World bundle will only contains one components. 
The first tab is the "Component type definition tab".

![The metadata editor](img/hello-world/MetadataEditor.png)

{note}
A **component type** is a declaration of a component, its dependencies, its properties and the service it provides. A component type is associated with one unique implementation class. This can be compared to classes in the Object Oriented Programming. Like a class, a component type can be instantiated many times with different configuration.

For a component type you often have many **component instances**. For each component instance, there is a implementation class instance. Instances have different variables and different configurations. 
{/note}

In the metadata editor click add and name your component. Let's call it "HelloWorld". Click on the component newComponent and in the component details enter "HelloWorld" as Component Name then save (ctrl+s).

![Component Name](img/hello-world/ComponentName.png)

Our component will have no properties, nor dependencies (We will explain that part when introducing services) but we will declare lifecycle method. These method are called when the component is validate or invalidate. To put it simple :

+ **the validate method** is called when the component dependencies are ok and the component instance start.
+ **the invalidate method** is called when the component instance dependencies are not ok anymore or if the bundle is stopped.

As we have no service dependencies, validate(invalidate) is called when the bundle is started(stopped).

Put "start" in the validate field and "stop" in the invalidate field.

![Project Generation](img/hello-world/Lifecycle.png)

One advantage of using the IDE is that it can generate a skeleton of the class based on the component declaration. To do so right-click on the component and then click "Generate implementation class" :

![Project Generation](img/hello-world/Generation.png)

During the generation don't forget to give the class a package. We will use org.example.hello.

![Project Generation](img/hello-world/PackageName.png)

Hopefully, the generator will generate this simple skeleton :

{code lang=java}
package org.example.hello;

import java.util.Map;

public class HelloWorldImpl {

	/** Component Lifecycle Method */
	public void stop(){
	// TODO: Add your implementation code here
	}

	/** Component Lifecycle Method */
	public void start(){
	// TODO: Add your implementation code here
	}
}
{/code}

You have your two methods stop and start that you have declared as lifecycle methods.

The next step is to do something when the component is started and something when it is stopped.

We suggest to put a greeting message. Change the code to the following :


{code lang=java}

/** Component Lifecycle Method */
public void stop(){
	System.out.println("Hello World !");
}

/** Component Lifecycle Method */
public void start(){
	System.out.println("Good bye World !");
}

{/code}

This will print "Hello world !" each time the component is started and "Good bye World !" each time it is stopped.

### Instance declaration 

As we explained, the component type is just the declaration and implementation of the component. To use it, you need to instantiate it.

Go to the "Component Configuration" tab and right-click on the "HelloWorld" component type.
Then click on "New instance declaration".

![Deployment](img/hello-world/newInstance.png)

We did not declare any property for our components. The only available property is the component name.

Change the name to "Hello" and save.

![Deployment](img/hello-world/newInstanceName.png)

Our work is now done. The instance of the component will be created when the bundle is started. 

### Deployment 

Make sure your {#runtime#} is started as explained in [the previous section](?p=intro-runtime&s=introduction).

To test your work, right-click on the project and select "iCASA Bundle Deployment" in the iCASA submenu.

![Deployment](img/hello-world/Deployment.png)


You can now check that the bundle is installed by using the [webconsole]({#link_web_console#}).
![The World bundle is installed]({#img#}/intro-runtime/install_done.png)

Now go to the terminal and check that your bundle has been deployed on the platform and started.
You should have a greeting :

{code lang=bash}
Hello World !
{/code}

Try to start and stop your components to see the alternate greetings :

{code lang=bash}
Hello World !
Good bye World !
Hello World !
{/code}

## Creating a new instance

Go to the "Component Configuration" tab and right-click on the "HelloWorld" component type.
Then click on "New instance declaration" and add a second instance "Hello2".

Deploy your bundle again and check that you have two greetings :
{code lang=bash}
Hello World !
Hello World !
{/code}

There is one greeting by instance.

If you stop your bundle you will also have two greetings :
{code lang=bash}
Good bye World !
Good bye World !
{/code}

## Conclusion

In this section, you have learned what a iPOJO component is and how to write your first bundle.

What you should remember is that iPOJO components and bundle are complementary. Bundles deal with *how to hide and share the code* and components deal with *how to instantiate and use the functionalities*.

In the [next section](?p=component-properties&s=introduction), you will learn how to add properties to components and how to configure the instances.

</article>

<aside markdown="1">
### Download

+ The hello world [project]({#bin#}/hello-world/hello.world.zip).
+ The hello world [bundle]({#bin#}/hello-world/hello.world.jar).

</aside>

