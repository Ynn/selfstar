{assign var="workdir" value="{#dir_runtime_wks#}/iCASA"}

<article markdown="1">

# Quick Start : Writing a follow me
In this introduction we will create a basic light follow me with ICASA. 

This tutorial assumes that you have basic knowledge on OSGi, Felix and iPOJO. You can read the [background section](/article/for-beginners/getting-started) for a refresher.


## What is a follow me ?

A follow me is a a context-aware application that adapts its behaviour to the movement of a person to trigger a particular action (switch on/off the light, switch on/off a speaker, ...).
Here the goal is to make the light follows the users.

This project uses the iCASA simulated binary lights.


## Step by step follow me 

### Installation and configuration

First [install and set-up your environment](/article/general/download). 

Then copy the iCASA runtime into an accessible directory. In this tutorial, we assume that you will use {$workdir}.

You will need to configure the IDE to work with that particular distribution (see [how to configure iCASA IDE](/article/general/download#ide))


### Project creation and skeleton generation

Open the iCASA-IDE.

This application will contains an unique class. To generate the skeleton of the class follow these steps :

1. Create a new iPOJO project called BinaryLightFollowMe.
![iPOJO project creation](img/basic-follow-me/create_project.png)

2. Open the metadata.xml file with the iPOJO Metadata Editor. The IDE is described in details in the [background section](/article/for-beginners/getting-started). See for instance [the hello world example](/for-beginners/basic-hello-world)
![iPOJO project creation](img/basic-follow-me/metadataxml.png)


3. Create a new component BinaryFollowMe. Open the metadata.xml file with the iPOJO Metadata Editor. To do so, click add then rename the component.
![iPOJO project creation](img/basic-follow-me/new_component.png)

4. Add to service dependencies (required services) multiple and optional (see [iPOJO introduction](/article/for-beginners/intro-ipojo) and [how to use services](/article/for-beginners/intro-services) to learn more on dependencies):
    - one dependency to BinaryLight, with a field <code>binaryLights</code> and (un)bindBinaryLight methods
![iPOJO project creation](img/basic-follow-me/bindBinaryLights.png)    
    - one dependency to PresenceSensor with a field <code>presenceSensors</code> and (un)bindPresenceSensor methods
![iPOJO project creation](img/basic-follow-me/create_required.png)

5. Add to new methods start and validate.
![iPOJO project creation](img/basic-follow-me/create_lifecycle.png)

6. Generate the class. Make sure you add a package. We will use the package follow.me. 
![iPOJO project creation](img/basic-follow-me/generate_class.png)

Hopefully you will have a skeleton like this :

{code}
package com.example.binary.follow.me;

import fr.liglab.adele.icasa.device.light.BinaryLight;
import fr.liglab.adele.icasa.device.presence.PresenceSensor;
import java.util.Map;

public class BinaryLightFollowMeImpl {

  /** Field for binaryLights dependency */
  private BinaryLight[] binaryLights;

  /** Field for presenceSensors dependency */
  private PresenceSensor[] presenceSensors;

  /** Bind Method for null dependency */
  public void bindBinaryLight(BinaryLight binaryLight, Map properties) {
     // TODO: Add your implementation code here
  }

  /** Unbind Method for null dependency */
  public void unbindBinaryLight(BinaryLight binaryLight, Map properties) {
     // TODO: Add your implementation code here
  }

  /** Bind Method for null dependency */
  public void bindPresenceSensor(PresenceSensor presenceSensor, Map properties) {
     // TODO: Add your implementation code here
  }

  /** Unbind Method for null dependency */
  public void unbindPresenceSensor(PresenceSensor presenceSensor,
    Map properties) {
     // TODO: Add your implementation code here
  }

  /** Component Lifecycle Method */
  public void stop() {
     // TODO: Add your implementation code here
  }

  /** Component Lifecycle Method */
  public void start() {
     // TODO: Add your implementation code here
  }
}
{/code}

### Managing the lists of devices 

First we need to add the fields binaryLights and presenceSensors :

{code lang="java"}
{literal}
/** List containing all the lights in the house */
private List listBinaryLights;

/** Map containing all the presenceSensors in the house (SerialNumber/PresenceSensor) */
private Map mapPresenceSensors;
{/literal}
{/code}


Now we can complete the code of binding and unbinding methods by adding or removing devices from their respective collection.

{code lang="java"}
{literal}        
/** Bind Method for null dependency */
public void bindBinaryLight(BinaryLight binaryLight, Map properties) {
   System.out.println("bind binary light "+ binaryLight.getSerialNumber());
   listBinaryLights.add(binaryLight);
}

/** Unbind Method for null dependency */
public void unbindBinaryLight(BinaryLight binaryLight, Map properties) {
   System.out.println("unbind binary light "+ binaryLight.getSerialNumber());
   listBinaryLights.remove(binaryLight);
}

/** Bind Method for null dependency */
public void bindPresenceSensor(PresenceSensor presenceSensor, Map properties) {
   System.out.println("bind presence sensor "+ presenceSensor.getSerialNumber());
   mapPresenceSensors.put(presenceSensor.getSerialNumber(), presenceSensor);
}

/** Unbind Method for null dependency */
public void unbindPresenceSensor(PresenceSensor presenceSensor,
    Map properties) {
   System.out.println("Unbind presence sensor "+ presenceSensor.getSerialNumber());
   mapPresenceSensors.remove(presenceSensor.getSerialNumber());
}
{/literal}
{/code}

### Lifecycle methods

The map and the list will be initialized/reseted in the lifecycle methods. See the [hello world tutorial](/article/for-beginners/basic-hello-world) to learn more on lifecycle methods.

Moreover, to check an instance of our component is created, we add to message in the lifecyle methods : start and stop.

{code lang="java"}
{literal} 
/** Component Lifecycle Method */
public void stop() {
   System.out.println("Component is stopping...");
   listBinaryLights = null;
   mapPresenceSensors = null;
}

/** Component Lifecycle Method */
public void start() {
   System.out.println("Component is starting...");
   listBinaryLights = new ArrayList();
   mapPresenceSensors = new HashMap();
}
{/literal}
{/code}



Hopefully we will see these messages when starting and stopping the application.

### Create an instance

Let's create our first component instance. 

Go to "Component Configuration" and create an instance for your "Follow" components. You can change the name by default. Let's call it "my.first.follow.me"

![create an instance](img/basic-follow-me/create_instance.png)
     	
Now we can test that this very basic project is working

+ Run iCASA.
+ Click on project > iCASA> Bundle Deployment.
![create an instance](img/basic-follow-me/deploy.png)
+ Check that the bundle is correctly deployed (using lb).
{code}
g!lb
...
   61|Active     |    1|iCasa :: environment.api (0.0.1.SNAPSHOT)
   62|Active     |    1|Follow_Me (1.0.0.qualifier)
g! 
{/code}

+ Start your component (using start) and stop it. You should see the message we put in the lifecycles methods.

{warning}
If you don't see the lifecycle messages, you must have done something wrong. Retry the preceding steps.
{/warning}

Now we can check the binding/unbinding methods :

+ Put the SetupEnvironmentsBinaryFollowMe.bhv file in the load directory of your iCASA runtime.
+ Start iCASA runtime and the simulator
+ Go to <http://localhost:9000> 
+ Click on "Scenarios and Scripts" then "install" in "iCASA Scenarios".
+ Check that the application has seen the light. It should start writing message in the console.

{warning}
If the applications prints no message when adding the devices, check your code again.
{/warning}


### Manage notifications and detect modifications

So let us get down to the substance.

We will try to be notified when something is modified.

#### The DeviceListener interface

Let's start with the sensors. 

In order to be notified when something is modified in the environment, we must implement a DeviceListener.

{note}
**DeviceListener :** The DeviceListener interface allows to get notification when a device change.
{/note}


There is four ways to implement it. 

First, you can make the main class (BinaryLightFollowMeImpl) implements the interface :

{code lang="java"}
{literal}     
public class BinaryLightFollowMeImpl implements DeviceListener{ //..
{/literal}
{/code}

This solution is suitable when your main class is small.


Second, you can define a new private inner class.
 
{code lang="java"}
{literal}          
public class BinaryLightFollowMeImpl {
...
public class PresenceSensorListener implements DeviceListener{

    @Override
	public void devicePropertyModified(GenericDevice device, String propertyName, Object oldValue) {
		/...
    }
...
}
{/literal}
{/code}

Third, you can use a anonymous class. This solution lets less control but ensure that there will be only one listener instance.

Finally, you can create a separate class but this class will need to have access to the device lists. It requires a little more code to work. This solution is suitable if your main class is big and you don't want to add more code.

        	
In the following we will use the first solution.

{code lang="java"}
{literal} 
public class BinaryLightFollowMeImpl implements DeviceListener
{/literal}
{/code}

To start, we can print something when a presence sensor detects something (presence or not) :

{code lang="java"}
{literal}    
public void devicePropertyModified(GenericDevice device, String propertyName, Object oldValue) {
    //We are only interested by presence sensors :
    if(device instanceof PresenceSensor) {
        //get the presence sensor :
        PresenceSensor activSensor = mapPresenceSensors.get(device.getSerialNumber());
        //if the sensor is active 
	        if(activSensor != null){
	        	//and the presence sensor has detected something :
		        if(propertyName.equals(PresenceSensor.PRESENCE_SENSOR_SENSED_PRESENCE)){
		        	System.out.println("The device with the serial number"
						+activSensor.getSerialNumber()+" has changed");
					System.out.println("This sensor is in the room :"
						+ activSensor..getPropertyValue("location"));	
		        }
	        }
    }
}
{/literal}
{/code}

The PRESENCE_SENSOR_SENSED_PRESENCE property value change every time the detection change from detected to undetected and reciprocally


Each type device has a different set of properties. The value of these properties can be set or retrieved by using a key string (e.g, "location"). This work exactly like service properties. This mechanism allow each type of devices to define their own properties. 

To avoid magic string, some of the properties are defined directly by the interface (e.g., PRESENCE_SENSOR_SENSED_PRESENCE is defined in the PresenceSensor interface). Some are not (e.g., location).

In the following, we  define a constant LOCATIONPROPERTYNAME for the "location" property :
{code lang="java"}
{literal} 
public static String LOCATIONPROPERTYNAME = "Location";
{/literal}
{/code}

#### Registering the listener

{note}
A DeviceListener has to be attached to a device in order to receive notification.
{/note}

We thus need to attach this new listener to the interesting devices (in our case all the presence sensors). 
This is done in the bind method of presence sensors :

{code lang="java"}
{literal}     
/** Bind Method for null dependency */
public void bindPresenceSensor(PresenceSensor presenceSensor, Map properties) {
   //register the listener :
   presenceSensor.addListener(this);
   mapPresenceSensors.put(presenceSensor.getSerialNumber(), presenceSensor);
}
{/literal}
{/code}

We can also unregister the listener when the sensor is leaving :

{code lang="java"}
{literal}      
/** Unbind Method for null dependency */
public void unbindPresenceSensor(PresenceSensor presenceSensor,
    Map properties) {
   //unregister the listener :
   presenceSensor.removeListener(this);
   mapPresenceSensors.remove(presenceSensor.getSerialNumber());
}
{/literal}
{/code}

You could think that in this particular case, this is not really mandatory. Indeed, the device is leaving and thus the listener will be unregistered anyway. However it is a good practice to always unregister the listeners. 

#### Testing that we get the notifications

Now we can test that the notifications work :
        
+ deploy the project.
+ create a simulated user and then place it in a room using the select box.
+ move the user in a room where there is a detector.
+ If all is ok, you see a message like this one :          
{code lang=bash}
The device with the serial number SekuSensor-AAA-20119215-S has changed.
This sensor is in the room : kitchen
{/code}

{warning}
If this don't work, check that your listener is correctly registered and created. Also check that there is a presence sensor in the room.
{/warning}
    
#### Finding the lights in the same room

To be able to switch on or off the light, we need to find the light in the rooms where a presence has been detected.

To do so, we implement a search method :

{code lang="java"}
{literal} 
/**
Return all the binary lights from a given location
@param location
@return List of BinaryLights
*/
private List<BinaryLight> getBinaryLightFromLocation(String location) {
	List<BinaryLight> binaryLightsLocation = new ArrayList<BinaryLight>();
	for(BinaryLight binaryLight : listBinaryLights) {
	   if(binaryLight.getPropertyValue(LOCATIONPROPERTYNAME).equals(location)) {
	       binaryLightsLocation.add(binaryLight);
	   }
	}
	return binaryLightsLocation;
}
{/literal}
{/code}

#### Modifying the state of lights


Finally we will test the state of the sensor (presence or not) and change the lights accordingly :

{code lang="java"}
{literal} 
public void devicePropertyModified(GenericDevice device, String propertyName, Object oldValue) {
    if(device instanceof PresenceSensor) {
        PresenceSensor activSensor = mapPresenceSensors.get(device.getSerialNumber());
        if(activSensor != null){
        	if(propertyName.equals(PresenceSensor.PRESENCE_SENSOR_SENSED_PRESENCE)){
	            String detectorLocation = (String) activSensor
	            					.getPropertyValue(LOCATION_PROPERTY_NAME);
	            
	            //check the location exist :
	            if(!detectorLocation.equals(LOCATION_UNKNOW)) {
	                List sameLocationLights = getBinaryLightFromLocation(detectorLocation);
	                for(BinaryLight binaryLight : sameLocationLights) {
	                    //change the value of the light :
	                    binaryLight.setPowerStatus(!(Boolean) oldValue);
	                }
	            }
	        }
        }
    }
}
{/literal}
{/code}

Now you can test your application by moving the user.
Hopefully, the lights will change as desired.
 
## Play with it

Now you can play with your application and add new devices and see what happens when the you move your user.
 
To add new sensors in the iCASA interface:

+ Go to "Device List"
+ Select the type PrecenseSensor in the list.
+ Give it a unique name.
+ Activate it in the list of devices.
+ Move it to the desired room.
    
More to do :

+ This code does not manage the concurrency. Try to implement it. 

</article>

<aside markdown="1">
### Download the follow me project

+ Download the [project](bin/BinaryFollowMe_V1.0.zip)

</aside>

<aside  markdown="1">
### Download iCASA
+ [iCASA-IDE website](http://adeleresearchgroup.github.com/iCasa-IDE/)
+ [iCASA-runtime website](http://adeleresearchgroup.github.com/iCasa-Simulator/1.0.0/download.html)
</aside>

{section_links}



