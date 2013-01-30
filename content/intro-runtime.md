<article  markdown="1">

# Introduction to OSGi

![{#runtime#} in action](img/intro-runtime/console2.png)

The iCASA runtime is based on OSGi (see Chapter 6 - section 4 of the Autonomic Computing book). More precisely, it is a customized version of a popular OSGi implementation called [Felix]({#link_felix#}) with a set of specific components already deployed. 

The purpose of this section is to provide a quick introduction to OSGi and Felix. Specifically, it teaches you to :

+ start and stop the Felix framework,
+ deploy, install and start applications,
+ use the Felix Web Console to manage your applications,
+ use basic commands to get information about the running applications.

This knowledge is NOT absolutely necessary to code and run the examples presented here - most operations are hidden or abstracted by the provided IDE. However, it constitutes a background which can be very useful when trying to understand what's really going on during deployment and execution. 



## What is OSGi ?

<img src="http://felix.apache.org/res/logo.png" style="float:right;width:20%; margin : 1em;"/>

OSGi is an execution framework developed on top of Java. It builds on the Java’s dynamic features (on demand class loading, multiple class loaders, typing verification before loading) to provide a coarse-grained level of modularity. OSGi is a [specification](http://www.osgi.org/Specifications/HomePage) with several popular implementations like [Equinox](http://www.eclipse.org/equinox/), [Felix]({#link_felix#}) or [Knopflerfish](http://www.knopflerfish.org/). 

OSGi supports the dynamic deployment of applications. In short, it means that you can easily install or update an application (or part of an application) at runtime without restarting the whole platform. To do so, OSGi introduces a strong versioning of the different part of the applications so that it is easy to know which version of a component is in use and avoid conflicts between incompatible versions. 

<div style="margin:auto;width : 60%;"/>
<img src="img/intro-runtime/OSGi.png"/>
</div>



## OSGi fundamentals

OSGi relies on the notion of bundle for modularity. Specifically, a bundle is a Java archive containing executable code, resources, and meta-data (name, version, dependencies, etc.). In other words, all the files required to implement a module. 
 
A bundle is both a deployment unit and a composition unit :

+ It is used to package classes and resources so that they can be deployed on one or more execution platforms. 
+ It is also used as building blocks to form modular Java applications. The purpose is to organize Java applications into a set of loosely coupled, highly coherent interacting modules.

An application can then be defined as a set of bundles collaborating to provide a service. The boundaries of an application are often hard to determine since many bundles can be used (and bundles can be shared!). For clarity, we can distinguish the following bundles:

+ System bundles: the bundles provided with the {#runtime#} distribution.
+ Library bundles: the bundles providing a library.
+ Application bundles: the other bundles (i.e the bundle you will create).

<div style="margin:auto;width : 70%;"/>
<img src="img/intro-runtime/OSGi2.png"/>
</div>

Thereafter, an application will mean all the bundles that you have written plus the libraries that are not provided by the framework. In the first exercices, applications are made of one bundle so that simple : the bundle is the application.




## Organize your directories

We advise you to store your workspaces (Eclipse and {#runtime#}) in a "workspaces" directory ({#dir_eclipse_wks#} and {#dir_runtime_wks#}). It is then easier to switch between workspaces and organize your work. In these tutorials, we will be using {#dir_runtime_wks#}.

{note}
**Can i use multiple version of {#runtime#} ?**

Yes, you can. The {#runtime#} is basically just a big zip file containing the files you need. Configuration information is kept in the directory and there is no external configuration (apart from a simple configuration of the {#ide#} that we will introduce later).

In fact, we recommand to have different versions of the framework when creating and testing new applications. This way, the current working environment is preserved and side effects on already installed applications are avoided. You can also copy a working {#runtime#} to keep your configuration and the installed bundles.

Keep the different versions in your {#dir_runtime_wks#} directory.
{/note}

{assign var="workdir" value="{#dir_runtime_wks#}/first-runtime"}

[Donwload]({#link_runtime#}) and unzip the runtime in {#runtime#} directory.
Rename the runtime directory to "first-runtime".

In the rest of this introduction, it is assumed that {$workdir} is the runtime directory.

## Starting the framework 

The framework has to be run from a terminal. 

Open a terminal and navigate to {$workdir}. 
{code lang=bash}
$> cd {$workdir} 
{/code}

Listing the content of the directory might be intimidating at first but you will need to deal with only a substet of it.

To start the framework, simply run the script {#start_script#} (or {#start_script#}.bat if you are on Windows) 
{code lang=bash}
$> ./{#start_script#} 
____________________________
Welcome to Apache Felix Gogo

g!
{/code}

If successful, you will have a greeting from Felix and access to the Felix console.


## Listing bundles

Most of OSGi management is concerned with bundles. Actually, there is no easy way to list the different applications of OSGi (for the reasons given above) but the framework provides facilities to manage the installed bundles. 

### Listing bundles using the Web Management Console

The easy way is to use a GUI. The {#runtime#} is provided with the Apache Felix Web Management Console. This is a very handy tool to perform all the OSGi management from your browser.

Let's see how to get the list of bundles.

Open a browser and go to <{#link_web_console#}/bundles>. If the runtime is started you will be asked for an user and a password. 

The default user is admin and the default passworld is admin.

![The Web Management Console](img/intro-runtime/webconsole.png)

What you get is a long list of all the installed bundles in your OSGi environment. As you have not installed any bundle yet, these bundle are what we call the system bundles. You don't need to understand what they are doing but for some of them, the name give a good indication. For instance *Apache Log4J* is obviously a bundle providing the well-known [log4j](http://logging.apache.org/log4j/1.2/) library.

The console provides a lot of information. Only four of them are really interesting for you :

+ **Name** (or Symbolic Name in OSGi terminology): the name is the name of the bundle. Multiple bundle can have the same name because you can install a bundle multiple time.
+ **ID** : the id is a unique number given to the bundle by the framework when you install it. As you will see it is a convenient way to interact with bundles in command lines. For instance the command *stop 3* will stop the *Apache Log4J*. It is also a way to distinguish to identical bundles installed multiple time.
+ **Status** : will provide you information about the current state of the bundle. Most of the time this value is INSTALLED or RESOLVED when the bundle is installed but not started, ACTIVE when the bundle has been started or UNRESOLVED if something is wrong. The last is often due to a bundle that can not start due to missing dependencies.
+ **Version** : the version is used to identify bundle uniquely. For instance Apache Log4J has the version 1.2.16. Multiple bundle with the same name can be installed granted that the version is different.

### Listing bundles using command line 

You can easily list the installed bundles using the ***lb command*** :

{code lang=bash}
g! lb
START LEVEL 1
   ID|State      |Level|Name
    0|Active     |    0|System Bundle (4.0.3)
    1|Active     |    1|akquinet AutoConf ResourceProcessor (1.0.1.SNAPSHOT)
    2|Active     |    1|ADELE-Common :: autoload.res.processor (1.0.0.SNAPSHOT)
    3|Active     |    1|Apache Log4J (1.2.16)
  ...
{/code}

The result is the same as the one given by the webconsole.




## Install/Uninstall bundles

Now let's see how to install bundles on the {#runtime#}. 

{note}
A bundle is identified uniquely by its name and its version.
A bundle can not be installed twice but you can install two bundle with the same name and different versions.
{/note}


{assign var="hello_jar" value="{$ROOT}/{#bin#}/hello-world/hello.world.jar"}

In the following, we will use a trivial Hello World application made of one bundle that is use in the next section. 
The bundle can be downloaded here : <{$hello_jar}>.

### Using the Web Console :

Download the [Hello-World]({$hello_jar}) bundle and put it in an accessible directory.

To **install the bundle**, open the [web console]({#link_web_console#}) and click Install/Update as shown below : 

![Install using web console]({#img#}/intro-runtime/install-wc.png)

Then select your bundle in the file list and click ok. Note that you can also choose to start it automatically.

Finally, click on "Install or Update".

That's done, you can now check that the bundle is installed by reloading the bundle list (or refreshing the page) :

![The World bundle is installed]({#img#}/intro-runtime/install_done.png)

You can order the list of bundle by ID. A newly installed bundle will always have the highest ID and appear at the end of the list.

To **uninstall the bundle** click on the trash icon :

![Uninstall the bundle]({#img#}/intro-runtime/trash.png)

If you check the bundle list again. You will see that the bundle is not in the list anymore.




### Install/Uninstall using the console

Installation is performed via the command **install**
{code}
install path
{/code}
where ***path*** is the local (begins with file://) or external URL (begins with http:// or ftp://).

You can uninstall the bundle by searching its id with **lb** and then using :
{code}
uninstall id
{/code}
where id is the id of the bundle you want to uninstall of the bundle.



### Practice : Installing from URLs

If you are not behind a proxy, you can try to deploy the jar directr
{code lang=bash}
install {$ROOT}/{#bin#}/hello-world/hello.world.jar
{/code}

Check the bundle has been installed with lb.
{code lang=bash}
g! lb
   55|Active     |    1|iCasa :: script.executor.api (0.0.1.SNAPSHOT)
   56|Active     |    1|iCasa :: device.presence (0.0.1.SNAPSHOT)
   61|Installed  |    1|World (1.0.0.qualifier)
{/code}

Then uninstall the bundle :

{code lang=bash}
uninstall 61
{/code}

And check that the bundle has been uninstalled using lb.

### Practice : Installing from files

Download the [bundle]({#bin#}/hello-world/hello.world.jar) and put it in an accessible directory. 
Then use the install command :

{code lang=bash}
install file://your/path/to/the/hello-world/hello.world.jar
{/code}

The result will be exactly the same than before.






## Starting and Stopping bundles

As explained above, bundles have a lifecycle reflected by the *State* property. Here are the most common states :

+ **installed** : you have just installed the bundle.
+ **resolved/unresolved** : when you first start a bundle, the framework has to check if the dependencies (others modules and necessary packages) are available. If all the dependencies are resolved, the state is RESOLVED, if not, the state is UNRESOLVED.
+ **active** : the bundle has been started.

There also are some transition state such as **starting/stopping/uninstalled** that you can forget.

Do not worry to much about bundle lifecycle. It is being introduced here for you to have a general understanding of OSGi.
Most of the time, you will only need to know if your bundle is ACTIVE or not. The IDE and automatic deployment will manage the lifecycle for you. Moreover, when using iPOJO components described later, the activator will be automatically generate. Just keep in mind that UNRESOLVED state stands for something wrong. 

{note}
**What happens when the bundle becomes ACTIVE ?**

Bundles can be endowed with a small class called an Activator. This activator can be compare to the Main-Class of the bundle. When the bundle is started and is dependencies are OK, the framework tries to find such class and call it if it exists. Reciprocally when the bundle is stopped, this class is called again to allow the bundle to perform cleaning actions (to free resources for instance).
{/note}


### Stop/start using the webconsole :

We will start and stop the "Hello World" bundle we have just installed.

Search your bundle in the list and use the start/stop button on the right :

![The World bundle is installed]({#img#}/intro-runtime/stop-start.png)

If you check on the terminal. When the bundle is started it should print "Hello World !" when the bundle is started and "Good bye World !" when the bundle is stopped. 

Also pay attention to the bundle state which becomes ACTIVE when started and RESOLVED when the bundle is stopped.


### Stop/start using the command line :

To stop an application use the *stop* command :
{code lang=bash}
stop X
{/code}

Where the number X is the bundle with ID=X.

Conversely, to start an application use the *start* command : 
{code lang=bash}
start X
{/code} 

To test that, we will try to stop the Felix Web Management Console. This way you would be able to see that the console is not accessible anymore.

First Use the lb command and search for the "Apache Felix Web Management Console". You will get a line like that : 

{code lang="bash"}
g! lb
   24|Active     |    1|Apache Felix Web Management Console (3.1.6)
{/code}

From this, we see that the webconsole bundle id is 24.

If you have not done it yet, go to the [webconsole]({#link_web_console#}) and check that the site is working.
Then stop the console&nbsp;:

{code lang="bash"}
g! stop 24
{/code}

If you use lb to check the state of the bundle, you will that something has changed :
{code lang="bash"}
g! lb
   24|Resolved   |    1|Apache Felix Web Management Console (3.1.6)
{/code}


Now reload the [webconsole]({#link_web_console#}) again, it should not be working anymore. The reason is that the bundle is now considered inactive by the OSGi framework and does not provides its Java servlet anymore.

Restart the webconsole using start :
{code lang="bash"}
g! start 24
{/code}

All should be now back to normal. Check the [webconsole]({#link_web_console#}) a last time to see that it is working again.


## Automatic deployment, installation and startup :

You have done the things the hard way. iCASA proposes an easier way to install/unsinstall and start/stop bundles. The quickest way to deploy, start and install a bundle is to copy the bundle in the load directory of your iCASA runtime.

### Practice 

Copy the hello-world bundle first-runtime/load directory. 
{code lang=bash}
mv hello.world.jar {$workdir}/load
{/code}

If you look at your console you will see that the bundle as been started.

{code lang=bash}
Hello World !
{/code}

Remove the bundle from the bundle from the load directory : 

{code lang=bash}
rm {$workdir}/load/hello.world.jar 
{/code}

It will be stopped and uninstalled :
{code lang=bash}
Good bye World !
{/code}

That's it, there is nothing more to do.

## Stopping the framework

The OSGi platform is reified by a bundle called the "System Bundle" which always have the 0 id. To stop the framework, you only have to stop that bundle.

Use the command *stop 0* to stop the framework :
{code lang=bash}
stop 0
{/code}

## Conclusion

You have seen that :

+ applications are divided into bundles.
+ bundles are the deployment unit of OSGi. You have learned how to install/start/stop/uninstall them.
+ bundles are identified by their Name and Version. When installed, the framework gives them a single ID.

In the [next section](?s=introduction&p=basic-hello-world), you will learn how to write a simple Hello World bundle.

</article>

<aside  markdown="1">

### Useful Commands Summary

To **start** the framework simply run the script {#start_script#} (or {#start_script#}.bat if you are on Windows).

In {#runtime#}, use 

+ **stop 0**  to stop the framework.
+ **lb** to list the installed bundles.
+ **start x** to start the bundle x.
+ **stop x** to stop the bundle x.
+ **install file** to install the bundle from the file.
+ **install url** to install the bundle from url.

If you want to **install automatically** put the bundle jar in the *load* directory.
If you want unsintall an automatically installed bundle, just remove the bundle.

</aside>

<aside  markdown="1">

### Bibliography

You can find a lot of information on OSGi :

+ [Felix documentation](http://felix.apache.org/site/documentation.html)
+ [the OSGi specification](http://www.osgi.org/Specifications/HomePage)
+ [Felix OSGi tutorials](http://felix.apache.org/site/apache-felix-osgi-tutorial.html)

</aside>
