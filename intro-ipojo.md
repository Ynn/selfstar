<article markdown="1">

# Introduction to iPOJO

The purpose of this page is to provide a quick introduction to the iPOJO component model. Specifically, it teaches you:

+ The limits of OSGi in term of programming.
+ What is an iPOJO component.
+ How to program an iPOJO component.
+ what is the lifecycle of an iPOJO component.

As for OSGi, knowing the intricacies of iPOJO is NOT mandatory since most complexity is hidden by the IDE. However, understanding the iPOJO principles (modularity, service-orientation, late-binding) is a plus when getting to the exercises. 


## OSGi limits

In OSGi,service management is entirely left to applications programmers. That is, programmers have to insert specific instructions in their code in order to follow the arrival and departure of services of interest and to react accordingly. This code is complex and highly error-prone (events can be missed, synchronisations can be forgotten, bad class versions can be called, stale references can be left, etc.).

Several approaches have been proposed to improve OSGi in terms of dependency management. Among them [iPOJO](https://felix.apache.org/site/apache-felix-ipojo.html) is a solution of choice in the open source world. 

## What is iPOJO

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

Components are concerned with *provided and required services* and *code is instantiation*.

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

The service "Spellchecking" will be described by an interface Spellchecking.java and some meta-information ("english" as a language for instance). Package names here are not important. If you change the name of a package or of an ipmplementation classe, there will be no consequence on the component dependencies. 

As bundles and iPOJO components are complementary, we will use both. Each bundle will contains one or more components as shown above.

<div style="margin:auto;width : 70%;"/>
<img src="{#img#}/hello-world/OSGIpojo.png"/>
</div>


## Dependency management

Yoann : peux-tu ici expliquer les dépendances de services : les mots-clés, les différentes politiques, etc. enfin, tout ce que l'on va retrouver dans l'IDE.



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

