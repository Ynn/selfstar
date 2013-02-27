

<article  markdown="1">


<section  markdown="1">
#Installing the working environment

This section explains how to set-up your environment. Specifically, you need to :

1. [configure your Java environment](#java) (JDK6).
2. [download and install the provided IDE](#ide) (Eclipse).
3. [download the runtime](#runtime) (OSGI/iPOJO).

</section>

<section id = "java"  markdown="1">
## Configure your Java Environment

Regardless of your operating system, you will need to install some [Java virtual machine (JVM)](http://en.wikipedia.org/wiki/Java_virtual_machine). 
There are several competiting JVM available and iCASA is supported by the majority of them.

{warning}
iCASA requires a Java 6 and does not support Java 7.
{/warning}

This is why, we advise you to download and install a [JDK 6 from Oracle](http://www.oracle.com/technetwork/java/javase/downloads/index.html). [OpenJDK](http://openjdk.java.net/) is also supported.

After installing the JDK, you must set the JAVA_HOME environment variable to point to the JDK installation directory. This is dependant of your operating system. 

</section>

<section id="ide"  markdown="1"/>
##Install iCasa IDE 

The IDE is provided as several Eclipse plugin. You can configure your own Eclipse environment. The IDE supports Juno or greater.

{warning}iCASA requires [Eclipse Juno](http://www.eclipse.org/downloads/) (4.2.1) or greater.{/warning}

To install the plugins in eclipse follow these steps :

1. Run Eclipse and select Help > Install New Software... from the main menu.
![Alt text](img/downloads/download-ide1.png)
2. Click on Add Button and enter a name for the update site (i.e. iCasa Update Site), then enter the update site location {#link_update_site#}, finally click on OK button.
![Alt text](img/downloads/download-ide2.png)
3. Wait for a few seconds until the content of the update site is displayed under combo-box. Select the new update site.
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

+ **iCASA-IDE**: 
	+ [update-site](#update-site)	
+ [**iCASA-runtime**](http://repository-icasa.forge.cloudbees.com/release/fr/liglab/adele/icasa/icasa.teaching.distribution/0.0.1/icasa.teaching.distribution-0.0.1.zip)

</aside>
