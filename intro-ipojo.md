<article markdown="1">

# Introduction to iPOJO

The purpose of this page is to provide a quick introduction to the iPOJO component model. Specifically, it teaches you:

+ The limits of OSGi in term of programming.
+ What is an iPOJO component.
+ How to program an iPOJO component.
+ what is the lifecycle of an iPOJO component.

As for OSGi, knowing the intricacies of iPOJO is NOT mandatory since most complexity is hidden by the IDE. However, understanding the iPOJO principles (modularity, service-orientation, late-binding) is a plus when getting to the exercises. 


## OSGi limits

Managing service-level dependencies is not managed by the platform. This is left to the developer whose code has to capture events emitted by the platform in order to discover, select, use, and change services. This results in pretty complex and error-prone code that can endanger the applications (events can be missed, concurrency must be managed, bad class versions can be called, references can be forgotten, etc.).

Several approaches have been proposed to improve OSGi in terms of dependency management. Among them [iPOJO](https://felix.apache.org/site/apache-felix-ipojo.html) is a solution of choice in the open source world. 

## What is iPOJO

Bundle are both a deployment units and composition units. They are used to make up modular, dynamic applications in Java. Bundles encapsulate Java packages that can be shared or kept hidden.  










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





## Conclusion

In this section, you have learned what a iPOJO component is and how to write your first bundle.

What you should remember is that iPOJO components and bundle are complementary. Bundles deal with *how to hide and share the code* and components deal with *how to instantiate and use the functionalities*.

In the [next section](?p=component-properties&s=introduction), you will learn how to add properties to components and how to configure the instances.

</article>

<aside markdown="1">
### Bibloigraphy

+ iPOJO Web site.
+ Clement Escoffier's PhD thesis (French).

</aside>

