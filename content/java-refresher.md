
<article  markdown="1">
#Basic Java and Eclipse Refresher

This section covers some necessary knowledge on Java and Eclipse. 
We assume that you have good knowledge in java but you forgot some of the particularities of Java due to a lack of practice.

{note}
This is a reference section, you can skip reading it and refers to it if later.
{/note}

<section  markdown="1">
## Java refresher


### Classes, Abstract Classes and interfaces.

### Constructors

Classes always have at least one constructor.
Classes with no explicit constructors have a no-argument constructor automatically generated (ClassName()) *unless you define another constructor*.
{warning}That implies that **if you define a constructor there will be no default constructor.**{/warning}

### Constants

Constant in java can be declared like this :

{code lang=java}
	public static final String SOME_CONST = "constant value"; 
{/code}

The keyword **static** is use to avoid duplication among classes instances. Most constants are declared public but there are [legitimate reasons](#modifiers) not to expose the variable.

{note}
Avoid using [magic numbers](http://en.wikipedia.org/wiki/Magic_number_(programming)).
{/note}


<h3 id="modifiers"> Access Modifiers </h3> 

There are [four access modifiers](http://docs.oracle.com/javase/tutorial/java/javaOO/accesscontrol.html) controlling the access from (class, class of the same package, subclass or the rest of the classes (world)). You should use them in the following order :

+ **private** means only *accessible from class* : you should use private everytime a member or a class must not be accessible from outside. This is the most common visibility.
+ **no modifier** means *only accessible from class and packages*. This should be the default visibility of classes unless you want a class to be accessible from another package.
+ **protected**  means *accessible from class, package and subclass*. You should use it when a subclass needs to override or use a method or a field from its superclass.
+ **public** means *accessible by every classes*. You should avoid public unless you are implementing an interface or want to expose a method or class that really needs to be accessed from outside. 


{note}
Always use the most restrictive modifier.

Use the no-modifier. The access modifier "no-modifier" is often ignored by students but is usefull to prevent classes from being accessed from outside the package.  Using public as the default visibility for classes is often unnecessary.

{/note}

### Packages 

Java packages are a mechanism to organise the code and control [the visibilty](#modifiers) of classes. Packages are at the core of the OSGi modularity and therefore iCASA. If you are not familiar with using package you should read the [Java package tutorial](http://docs.oracle.com/javase/tutorial/java/package/packages.html).

In short:

+ **a package matches to a directory** (in a hierarchy of directories) containing classes and a javadoc file describing the package.
+ **the naming convention** is <code>dir.subdir.subsubdir</code>. For instance a package <code> org.example </code> matches to the physical directory org/example and a package <code>org.example.test</code> matches to the directory <code></a>org/example/test</code>.

+ **a package defines a unique namespaces** : A class is fully qualified by its package plus its class name. For instance the fully qualified name of a class <code>Hello</code> in the package <code>org.example</code> is <code>org.example.Hello</code>. That implies that you can have two classes with the same name in two different packages.

+ **packages are not logically nested** : even if packages are organised hiearchically and packages are made of nested directory, they are not logically nested. This has an important consequence on visibility. For instance although <code>org.apache.felix</code> is not logically nested into <code>org.apache.</code>. That means that a class of the former cannot access a class of the latter if its modifier is the [default-modifier](#modifiers) .

+ **there is a default package** : when no package is defined, classes belong to the default package

{warning}
**Do not use the default package** : Using the default package leads to poor modularity and is a very bad practice.
{/warning}

{note}
**Packages are versionned in OSGi** : Java offers no-package versionning but OSGi does. 
{/note}

## Concurrency


</section>

<section  markdown="1">
## Refreshing Eclipse
</section>

</article>