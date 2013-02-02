{* Variables(DO NOT DELETE): *}
{assign var="workdir" value="{#dir_runtime_wks#}/first-runtime"}

<article  markdown="1">

# Introduction to Felix

The purpose of this page is to provide a quick introduction to OSGi/Felix. Specifically, it teaches you to:

+ start and stop the Felix framework.
+ deploy, install and start applications.
+ use the Felix Web Console.
+ use basic commands to get information about the running applications.



## Starting the framework 

The framework has to be run from a terminal. 

Open a terminal and navigate to {$workdir}. 
{code lang=bash}
$> cd {$workdir} 
{/code}

Now, start the Felix framework. You simply have to run the script {#start_script#} (or {#start_script#}.bat on Windows) 
{code lang=bash}
$> ./{#start_script#} 
____________________________
Welcome to Apache Felix Gogo

g!
{/code}

If successful, you have a greeting from Felix and access to the Felix console.


## Listing the bundles

OSGi provides facilities to manage installed bundles. The {#runtime#} comes with the Apache Felix Web Console, a very handy tool to manage the bundles from your Web browser.

Let's see how to get the list of bundles with this console.

First, open a browser and go to <{#link_web_console#}/bundles>. You have then to provide a username and a password (admin and admin by default!).

![The Web Management Console](img/intro-runtime/webconsole.png)

You get the (long) list of the bundles installed in your OSGi environment. There is no bundle of your own so far: all these bundles are system bundles.

The console provides detailed information about bundles, including the following attributes:

+ **Name** is the symbolic name of the bundle (Apache Log4J for instance).

+ **ID** is a unique number created by the framework when installing a bundle. Using this id is a convenient way to manage bundles in command lines. For instance the command *stop 3* will stop the *Apache Log4J* bundle.

+ **Status** provides information about the current state of a bundle. This value is set to INSTALLED or RESOLVED when the bundle is installed but not started, ACTIVE when the bundle has been started, UNRESOLVED if there is something wrong (generally some dependencies are missing).

+ **Version** is used to uniquely identify a bundle . For instance Apache Log4J has the version 1.2.16. Multiple bundles with a same name can be installed granted that the version is different.

You can also list the installed bundles directly from a terminal, using the ***lb command*** :

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

Now let's see how to install and uninstall bundles. 

{note}
Reminder: A bundle is uniquely identified by its name and its version.
A bundle can not be installed twice but you can install two bundles with the same name and different versions.
{/note}


{assign var="hello_jar" value="{$ROOT}/{#bin#}/hello-world/hello.world.jar"}

In the following, we will use a trivial Hello World application made of one bundle. 
The bundle can be downloaded here : <{$hello_jar}>.

### Using the Felix Web console

First, download the [Hello-World]({$hello_jar}) bundle and store it in an accessible directory. Then, to install the bundle, open the [web console]({#link_web_console#}) and click Install/Update as shown below : 

![Install using web console]({#img#}/intro-runtime/install-wc.png)

Select your bundle in the appropriate directory and click "Install or Update" (note that you can click a check box to also start the bundle). When done, you can check that the bundle is correctly installed by refreshing the bundle list (or loading the page):

![The World bundle is installed]({#img#}/intro-runtime/install_done.png)

Bundles are generally ordered according to their id. A newly installed bundle will always have the highest id and appear at the end of the list.

To **uninstall a bundle** click on the trash icon:

![Uninstall the bundle]({#img#}/intro-runtime/trash.png)

You can refresh the bundle list to make sure the bundle is gone!

### Using a terminal

As for the listing command, Install/Uninstall commands can be set directly in a terminal. Installation is performed with the **install** command:

{code}
install path
{/code}
where ***path*** is a local (begins with file://) or external URL (begins with http:// or ftp://).

You can uninstall the bundle by searching its id with **lb** and then using :
{code}
uninstall id
{/code}


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


</article>

<aside  markdown="1">

### Useful Commands Summary

To start the framework, run the script:

+ **{#start_script#}** on Unix
+ **{#start_script#}.bat** on Windows

In {#runtime#}, use 

+ **stop 0**  to stop the framework.
+ **lb** to list the installed bundles.
+ **start x** to start bundle x.
+ **stop x** to stop bundle x.
+ **install file** to install a bundle from file.
+ **install url** to install a bundle from url.
+ **automatic install** put the bundle jar in the *load* directory
+ **uninstall** an automatically installed bundle, just remove the bundle

</aside>

<aside  markdown="1">

### Bibliography

More information about OSGi/Felix can be found in:

+ [Felix documentation](http://felix.apache.org/site/documentation.html)
+ [Felix OSGi tutorials](http://felix.apache.org/site/apache-felix-osgi-tutorial.html)

</aside>