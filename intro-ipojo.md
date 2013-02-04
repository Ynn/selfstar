<article markdown="1">

# Introduction to iPOJO

The purpose of this page is to provide a quick introduction to the iPOJO component model. Specifically, it reminds you:

+ The limits of OSGi in term of programming.
+ What is an iPOJO component.
+ How to program an iPOJO component.
+ what is the lifecycle of an iPOJO component.

As for OSGi, knowing the intricacies of iPOJO is NOT mandatory since most complexity is hidden by the IDE. However, understanding the iPOJO principles (modularity, service-orientation, late-binding) is a plus when getting to the exercises. 


## OSGi limits

In OSGi,service management is entirely left to applications programmers. That is, programmers have to insert specific instructions in their code in order to follow the arrival and departure of services of interest and to react accordingly. This code is complex and highly error-prone (events can be missed, synchronisations can be forgotten, bad class versions can be called, stale references can be left, etc.).

Several approaches have been proposed to improve OSGi in terms of dependency management. Among them [iPOJO](https://felix.apache.org/site/apache-felix-ipojo.html) is a solution of choice in the open source world. 

## What is iPOJO

<img src="img/hello-world/ipojo.png" style ="float:right;width:20%; margin : 1em;"/>

iPOJO is a component model: its purpose is to provide programming facilities in order to lower business code complexity. Specifically, an iPOJO component is a “plain old Java object” (A Java class!) enriched with meta-data. Meta-data is used to **generate** complex code implementing non functional properties. This code is actually injected at compilation time by the ipojo framework.

In particular, code is injected in order to manage all the service-­oriented interactions: service publication, service instantiation, service selection, service discovery. This is based on meta-data specifying  services provided by a component and services required by the component, along with the resolution politics. Services are merely expressed as Java class interfaces. 


To make it more concrete, look at the [felix implementation of client for a DictionnaryService](https://felix.apache.org/site/apache-felix-tutorial-example-4.html). As you can see, even this simple task requires a long piece of code to manage the dynamism. 

The same declaration in iPOJO would require the declaration of the service in the component class (let's call it DictionnaryClient.java) and the use of annotations to describe iPOJO meta-data. Here the meta-data informs iPOJO that the class is a component and that m_dictionnaryService is a service to be injected.

{code lang=java}
@Component
public class DictionnaryClient {
	// This service is injected at runtime when a service is availlable :
	@requires
	private DictionaryService m_dictionnaryService; //**
{/code}

{note}
**Alternative XML syntax**
For those who don't want to use annotations for meta-data, so as to separate class implementation from service declaration, iPOJO also supports an XML syntax (in a metadata.xml file) :

{code lang=xml}
<component classname="org.example.DictionnaryClient" name="DictionnaryClient">
	<requires specification="org.example.DictionaryService" field="m_dictionnaryService"/>
</component>
{/code}

The [iCASA-IDE](/article/for-beginners/ide-hello-world) uses the XML syntax.
{/note}

The service can then be used as is (the dynamism is managed by iPOJO) : 

{code lang=java}	
public checkword(String word){
	if(m_dictionnaryService.checkWord(word)){
        System.out.println("Correct.");
	}else{
		System.out.println("Incorrect.");
	}
}
{/code}

Once implemented the component can be instanciated, whether programatically, whether using the XML&nbsp;:
{code lang=xml}
 <instance component="DictionnaryClient" name="myDictionnaryClient">
{/code}



At compilation time, the ipojo framework also creates bundles containing iPOJO components (code and metadata). Bundles are used as the deployment unit and to resolve package dependencies, as it is usually done in OSGi.

## iPOJO applications

An application is made of a number of interacting iPOJO components. These components are linked at runtime, throuh service interactions, by the execution framework. An application can be run only when all service dependencies are resolved.


{note}
**Bundles and iPOJO Components**

Bundles are concerned with *code packaging* and *code dependencies*.

Components are concerned with *provided and required services* and *code instantiation*.

{/note}

Components have actually been introduced to allow developers to think in term of functionality instead of code. Let us take an example to illustrate that statement. 
Imagine that we have a word processor that use a spellchecker. 

When using modules, we will most likely have :

+ **a word processor module** with several packages and classes. This module provides the class org.example.EnglishSpellCheckerworld processor and depends on the package org.example.english.spellchecker. 
+ **a spellchecker module** that provides an org.example.english.spellchecker containing the class EnglishSpellChecker and some utility classes. The spellchecker specifies that it provides this package. 

If for a reason or another (code refactoring, product renaming, conflict in libraries) you need to change the name of packages, you will have to change the dependencies since dependencies are direct references to the code itself.

When using components, we will have :

+ **a word processor** component depending on a SpellChecking service. 
+ **a spellchecker component** providing this service. 

The service "Spellchecking" will be described by an interface Spellchecking.java and some meta-information ("english" as a language for instance). Package names here are not important. If you change the name of a package or of an implementation class, there will be no consequence on the component dependencies. 

As bundles and iPOJO components are complementary, we will use both. Each bundle will contains one or more components as shown above.

<div style="margin:auto;width : 70%;"/>
<img src="{#img#}/hello-world/OSGIpojo.png"/>
</div>


## Dependency management

One core functionality of iPOJO is the dependency management. This section gives a brief overview of iPOJO functionalities.

### Required services :
The most difficult task managed by iPOJO is the service requirement.
The service providing is described in details in the [iPOJO service requiring documentation](http://felix.apache.org/site/service-requirement-handler.html). In short a dependency can be :

+ **mandatory**/**optional**  : When the dependency is mandatory, iPOJO don't start the component until one matching service is found. If the service leaves, the component is stopped until a substitute can be found. Conversely, some service may be declared optional (e.g. a log service). In such case, when no service is found, the injected value is null (or a Nullable object) but the component lifecycle is not affected.
+ **simple/multiple** : When the dependency is simple, only one service is provided to the component. This dependency will remain the same until it leaves (dynamic policy) or a better substitute is found (dynamic-priority policy). When the dependency is multiple, iPOJO provides the component with the list of matching services.

iPOJO supports different policies for injecting dependencies :

+ **dynamic** (*default behavior*): the service is injected until it leaves. When leaving, a substitute is provided when possible. 
+ **dynamic-priority** : same as dynamic but iPOJO inject the best service available each time a service is used. That means that the service in used can be substituted for a better one anytime. 
+ **static** : the same service is used during all the component lifetime. If the service leaves, the component is disabled and can not be restarted.

{note}
**How do iPOJO know that a service is better ?**

Service selection is based on service properties. Each services are ranked based on these properties. By default the ranking is random. But you can modify the ranking is performed by providing a standard java [Comparator](http://docs.oracle.com/javase/6/docs/api/java/util/Comparator.html) :

{code lang=xml}
<requires field="m_dictionnaryService" policy="dynamic-priority" comparator="dict.MyComparator"/>
{/code}

Each time a service is discovered, iPOJO will try to compare it to the other using this comparator. If the service is better that the one in use, it will be automatically substituted.

{/note}
### Provided services :
In iPOJO providing a service is simply implementing an interface :

{code lang=java}
{literal}
@Component
@Provides(specifications={DictionnaryService.class})
public class DictionnaryImpl implements DictionnaryService { // ...
{/literal}
{/code}

Different policies may be applied for the creation of a service :

+ **shared** (*default behaviour*): the service is created once and is shared by all the users.
+ **service** : the service is shared by all the components of the same bundle. That means that two bundles won't have the same service. A new service will be created each time a new bundle ask for it.
+ **instance** : the service is never shared. A new service will be created each time the service is required.
+ **customized** : you can provide a class extending the CreationStrategy one so as to customized the way the instance are created. 

More details on the service requirement can be found in the [iPOJO service providing documentation](http://felix.apache.org/site/providing-osgi-services.html).

## Conclusion

In this section, you have learned what a iPOJO component is and how to write your first bundle.

What you should remember is that iPOJO components and bundle are complementary. Bundles deal with *how to hide and share the code* and components deal with *how to instantiate and use the functionalities*.

In the [next section](?p=component-properties&s=introduction), you will learn how to add properties to components and how to configure the instances.


</article>

<aside markdown="1">
### Bibliography

+ iPOJO Web site.
+ Clement Escoffier's PhD thesis (French).

</aside>

