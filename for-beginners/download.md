

<article  markdown="1">


<section  markdown="1">
#Installing your working environment

The learning environment is made of three integrated tools (see figure):

+ **An Execution platform based on OSGi and iPOJO**. This platform supports the dynamic execution of the Java applications.

+ **An Integrated Development Environment**. This Eclipse-based IDE provides comprehensive facilities for the development in OSGi/iPOJO. Specifically, it includes a source code editor, build automation tools and automated deployment on the execution platform.

+ **A smart home simulator called iCasa**. This simulator allows you to create a wide range of devices that can be used by your OSGi/iPOJO applications. It also permits the definition of scenario that can be played at various speeds. 

<div style="margin:auto;width : 80%;"/>
<img alt="the iCASA environment" src="{#img#}/getting-started/getting-started.png"/>
</div>


The purpose of this section is to explain how to download the tools and set them up. 
Specifically, you need to :

1. [configure your Java environment](#java) (JDK6).
2. [download and install the provided IDE](#ide) (Eclipse).
3. [download the runtime](#runtime) (OSGI/iPOJO).

</section>

<section id = "java"  markdown="1">
## Configure your Java Environment

Regardless of your operating system, you need to install a [Java virtual machine (JVM)](http://en.wikipedia.org/wiki/Java_virtual_machine). Most available JVMs are supported but:

{warning}
Java 6 is required - Java 7 is not supported.
{/warning}

For instance, you may download and install [Oracle JDK 6](http://www.oracle.com/technetwork/java/javase/downloads/index.html) or [OpenJDK](http://openjdk.java.net/).

After the JDK installation, you have to set the JAVA_HOME environment variable to point to the JDK installation directory. This depends on your operating system. 

</section>

<section id="ide"  markdown="1"/>
##Install the IDE (Integrated Development Environment)

Our IDE is based on Eclipse, augmented with a number of specific plugins. 


The IDE is provided as several Eclipse plugin. You can configure your own Eclipse environment. The IDE supports Juno or greater.

{warning}iCASA requires [Eclipse Juno](http://www.eclipse.org/downloads/) (4.2.1) or greater version.{/warning}

This is how to install the plugins:

1. Run Eclipse and select Help > Install New Software... from the main menu.
![Alt text](img/downloads/download-ide1.png)
2. Click on Add Button and enter a name for the update site (i.e. iCasa Update Site), then enter the update site location {#link_update_site#}, finally click on OK button.
![Alt text](img/downloads/download-ide2.png)
3. After a few seconds, the content of the update site is displayed under combo-box. Select the new update site.
4. Selects all features shown in the list.
![Alt text](img/downloads/download-ide3.png)
5. Continue the standard installation procedure and finally restart your Eclipse to apply changes on the platform.

{note}
If you are behind proxies, you may need to configure your [Eclipse network configuration](http://help.eclipse.org/juno/index.jsp?topic=%2Forg.eclipse.platform.doc.user%2Freference%2Fref-net-preferences.htm) before installing.
{/note}

</section>

<section id="runtime"  markdown="1"/>
##Download and configure the iCASA runtime

1. Download and unzip in a your system the [iCASA runtime](http://repository-icasa.forge.cloudbees.com/release/fr/liglab/adele/icasa/icasa.teaching.distribution/0.0.1/icasa.teaching.distribution-0.0.1.zip).
2. Run iCASA-IDE and select Window > Preferences ... from the main menu and go to iPojo preferences section.
3. Click on Browse button and sets the iPojo installation directory using the directory created in step 1.
4. Check "Add iCasa packages ...".
![Alt text](img/downloads/download-icasa1.png)
5. Finally, Click on OK button

</section>

</article>

<aside  markdown="1">
### Download links

+ **IDE**: 
	+ [update-site](#update-site)	
+ [**iCASA-runtime**](http://repository-icasa.forge.cloudbees.com/release/fr/liglab/adele/icasa/icasa.teaching.distribution/0.0.1/icasa.teaching.distribution-0.0.1.zip)

</aside>
