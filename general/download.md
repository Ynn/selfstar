

<article  markdown="1">


<section  markdown="1">
#Installing your working environment

The purpose of this section is to explain how to download the tools and set them up. 
Specifically, you need to :

1. [configure your Java environment](/article/general/download#java) (JDK6).
2. [download the runtime](/article/general/download#runtime) (OSGI/iPOJO + iCasa server).
3. [download and install the provided IDE](/article/general/download#ide) (Eclipse).

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

</section>

<section id="runtime"  markdown="1"/>
## Download and configure the iCASA runtime


### Download the runtime

Download and unzip the [iCASA runtime teaching distribution](http://adeleresearchgroup.github.io/iCasa-Simulator/1.1.1/). You can rename the directory if you want.

iCASA runtime is a customized felix distribution. To start the framework, use the start scripts. See [the introduction to felix](/article/for-beginners/intro-felix) to learn more on felix.

{note}
You can have and use as many iCASA distributions as you want. You only need to rename the directory.
However, *you should not run two instance of iCASA at the same time* on the same computer. There will be network conflicts otherwise.
{/note}


### How to run iCASA gateway ?

Go to the root of your iCASA runtime directory.

Run the startGateway script (.sh on UNIX, .bat on WINDOWS).

### How to run the Web Server Part ?

Even if the gateway does not need the GUI part to run, we strongly advise you to use the GUI to get a feedback from the simulator.

Go to the root of your iCASA runtime directory.

Execute startGUI.sh script on Unix systems or startGUI.bat script on Windows systems.

By default, the web server port is set to 9000. The simulator home page is available at <http://localhost:9000/> using your browser (Firefox is strongly recommanded).

</section>

<section id="ide"  markdown="1"/>
##Install the iCASA IDE (Integrated Development Environment)

### Installation
iCASA IDE is based on Eclipse, augmented with a number of specific plugins. 

{warning}iCASA IDE requires [Eclipse Juno](http://www.eclipse.org/downloads/) (4.2.1) or greater version.{/warning}

This is how to install the plugins:

1. Run Eclipse and select Help > Install New Software... from the main menu.
![Alt text](img/downloads/download-ide1.png)
2. Click on Add Button and enter a name for the update site (i.e. iCasa Update Site), then enter the update site location http://adeleresearchgroup.github.com/iCasa-IDE/distributions/update-site/, finally click on OK button.
![Alt text](img/downloads/download-ide2.png)
3. After a few seconds, the content of the update site is displayed. Select the new update site.
4. Select all features shown in the list.
![Alt text](img/downloads/download-ide3.png)
5. Continue the standard installation procedure and restart your Eclipse to apply changes.

{note}
If you are behind proxies, you may need to configure your [Eclipse network configuration](http://help.eclipse.org/juno/index.jsp?topic=%2Forg.eclipse.platform.doc.user%2Freference%2Fref-net-preferences.htm) before installing.
{/note}

###Configuration

1. Run iCASA-IDE and select Window > Preferences ... from the main menu and go to iPojo preferences section.
2. Click on Browse button and sets the iCASA runtime root directory (the directory where you unzipped iCASA)
3. Check "Add iCasa packages ...".
![Alt text](img/downloads/download-icasa1.png)
4. Finally, Click on OK button

{note}
The configuration is associated to one workspace. 

If you use different distribution of iCASA (or the same version but in different directories), you will have to reconfigure your workspace and restart Eclipse.s
{/note}

</section>

</article>

<aside  markdown="1">
### Download iCASA 
Download last releases:

+ [iCASA-IDE website](http://adeleresearchgroup.github.com/iCasa-IDE/distributions/update-site/)
+ [iCASA-runtime](http://adeleresearchgroup.github.io/iCasa-Simulator/1.1.1/)

Documentation:

+ [iCASA doc](http://adeleresearchgroup.github.io/iCasa-Simulator/1.1.0/index.html) 

</aside>
