
<article markdown="1">

# A basic light follow me

In this introduction we will create a basic light follow me with ICASA. 

## What is a follow me ?

A follow me is a a context-aware application that adapts its behaviour to the movement of a person to trigger a particular action (switch on/off the light, switch on/off a speaker, ...).
Here the goal is to make the light follows the users.

## Step by step follow me 

### Project creation and skeleton generation

You need to create and generate the skeleton of the unique class of your application. To do so follow these steps :

1. Create a new iPOJO project.
![iPOJO project creation](img/basic-follow-me/create_project.png)
2. Create a new component "Follow".
![iPOJO project creation](img/basic-follow-me/new_component.png)
3. Add to service dependencies (required services) multiple and optional :
    - one dependency to BinaryLight, with a field <code>binaryLights</code> and (un)bind method (un)bindBinaryLight
    - one dependency to PresenceSensor with a field <code>presenceSensors</code> and (un)bind method (un)bindPresenceSensor
![iPOJO project creation](img/basic-follow-me/create_required.png)
4. Add to new methods start and validate.
![iPOJO project creation](img/basic-follow-me/create_lifecycle.png)
5. Generate the class. Make sure you add a package. We will use the package follow.me. 
![iPOJO project creation](img/basic-follow-me/generate_class.png)

Hopefully you will have a skeleton like this :

{code}
package follow.me;

import fr.liglab.adele.icasa.device.light.BinaryLight;
import fr.liglab.adele.icasa.device.presence.PresenceSensor;

public class FollowMeImpl {

    /** Bind Method for binaryLights dependency */
    public void bindBinaryLight(BinaryLight binaryLights) {
        // TODO: Add your implementation code here
    }

    /** Unbind Method for binaryLights dependency */
    public void unbindBinaryLight(BinaryLight binaryLights) {
        // TODO: Add your implementation code here
    }

    /** Bind Method for presenceSensors dependency */
    public void bindPresenceSensor(PresenceSensor presenceSensors) {
        // TODO: Add your implementation code here
    }

    /** Unbind Method for presenceSensors dependency */
    public void unbindPresenceSensor(PresenceSensor presenceSensors) {
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

/**
 * A list containing all the light in the Home :
 */
List<BinaryLight> binaryLights = new ArrayList<BinaryLight>();

/**
 * A list containing all the presence sensors in the Home :
 */
List<PresenceSensor> presenceSensors = new ArrayList<PresenceSensor>();


{/literal}
{/code}


Now we can complete the code of binding and unbinding methods by adding or removing devices from their respective lists.

{code lang="java"}
{literal}        

/** Bind Method for binaryLights dependency */
public void bindBinaryLight(BinaryLight binaryLight) {
	//Add the light to the list of lights :
	binaryLights.add(binaryLight);	
	System.out.println("Add the light "+ binaryLight);
}

/** Unbind Method for binaryLights dependency */
public void unbindBinaryLight(BinaryLight binaryLight) {
    //Remove the light from the list of lights :
	binaryLights.remove(binaryLight);
    System.out.println("Remove the light "+ binaryLight);
}

/** Bind Method for presenceSensors dependency */
public void bindPresenceSensor(PresenceSensor presenceSensor) {
    //Add the sensor to the list of sensors :
	presenceSensors.add(presenceSensor);
	System.out.println("Add the sensor "+ presenceSensor);
}

/** Unbind Method for presenceSensors dependency */
public void unbindPresenceSensor(PresenceSensor presenceSensor) {
    //Remove from the sensor to the list of sensors :
	presenceSensors.remove(presenceSensor);
	System.out.println("Remove the sensor "+ presenceSensor);
}
  
{/literal}
{/code}

### Lifecycle methods

To check an instance of our component is created, we add to message in the lifecyle methods : start and stop.

{code lang="java"}
{literal} 
/** Component Lifecycle Method */
public void stop() {
	System.out.println("The follow me is stopping");
}

/** Component Lifecycle Method */
public void start() {
	System.out.println("The follow me is starting");
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

+ Start it again
+ Go to <http://localhost:8080/simulator> 
+ Click on "Scenarios and Scripts" then "install" in "iCASA Scenarios".
+ Check that the application has seen the light. It should start writing message in the console.

{warning}
If the applications prints no message when adding the devices, check your code again.
{/warning}


### Master notifications and detect the changes

So let us get down to the substance.

We will try to be notified when something is modified.

#### The DeviceListener interface

Let's start with the sensors. We will implement a DeviceListener.

{note}
**DeviceListener :** The DeviceListener interface allows to get notification when a device change.
{/note}


There is four ways to implement it. 

First, you can make the main class (FollowMeImpl) implements the interface :

{code lang="java"}
{literal}     
             public class FollowMeImpl implements DeviceListener{
{/literal}
{/code}

This solution is suitable when your main class is small.


Second, you can define a new private inner class.
 
{code lang="java"}
{literal}          
public class FollowMeImpl {
...
public class PresenceSensorListener implements DeviceListener{

    @Override
    public void notifyDeviceEvent(String serialNumber) {

    }
...
}
{/literal}
{/code}

Third, you can use a anonymous class. This solution lets less control but ensure that there will be only one listener instance.

Finally, you can create a separate class but this class will need to have access to the device lists. It requires a little more code to work. This solution is suitable if your main class is big and you don't want to add more code.

        	
In the following we will use an inner class. Let's start by printing something when a sensor changes its state :

{code lang="java"}
{literal} 
public static class PresenceSensorListener implements DeviceListener{

    @Override
    public void notifyDeviceEvent(String deviceSerialNumber) {
    	System.out.println("The device with the serial number "+ deviceSerialNumber+ " has changed");
    }

}
{/literal}
{/code}

Now we can create a new listener field and instantiate it. 

{code lang="java"}
{literal}     
            private final PresenceSensorListener presenceSensorListener = new PresenceSensorListener();
 {/literal}
{/code}

#### Managing presence sensors' notification

We need to attach this new listener to the interesting devices (in our case all the presence sensors). 
This is done in the bind method :

{code lang="java"}
{literal}     
/** Bind Method for presenceSensors dependency */
public void bindPresenceSensor(PresenceSensor presenceSensor) {
	//Add the sensor to the sensors list
	presenceSensors.add(presenceSensor);
	System.out.println("Add the sensor "+ presenceSensor);
	
	//Add the listener :
	presenceSensor.addListener(presenceSensorListener);
}
{/literal}
{/code}

We can also unregister the listener when the sensor is leaving :

{code lang="java"}
{literal}      
/** Unbind Method for presenceSensors dependency */
public void unbindPresenceSensor(PresenceSensor presenceSensor) {
	//Remove the sensor from the list of sensors
	presenceSensors.remove(presenceSensor);
	System.out.println("Remove the sensor"+ presenceSensor);
	
	presenceSensor.removeListener(presenceSensorListener);
}
{/literal}
{/code}

In this particular case, this is not really mandatory because the device is leaving and the listener will be unregisterd anyway.
However it is a good practice to do it. 

#### Testing that we get the notifications

Now we can test that the notifications work :
        
+ deploy the project.
+ create a simulated user and then place it in a room using the select box.
+ move the user in a room where there is a detector.
+ If all is ok, you see a message like this one :          
{code}
The device with the serial number SekuSensor-AAA-20119215-S has changed
{/code}

{warning}
If this don't work, check that your listener is correctly registered and created. Also check that there is a presence sensor in the room.
{/warning}
    
### Managing the lights

Now that we can get notifications, we can modify the state of the lights.

But before that we need to get the corresponding presence sensor. To do so we need to implement a method to get notifications :


#### Finding the corresponding presence sensor
{code lang="java"}
{literal}    
/**
 * Get the presence sensor with the given serial number
 * @param deviceSerialNumber : the given serial number
 * @return the corresponding presence sensor or null if not found.
 */
public PresenceSensor getPresenceSensor(String deviceSerialNumber){
	for (PresenceSensor sensor : presenceSensors) {
		if (sensor.getSerialNumber().equals(deviceSerialNumber)){
			return sensor;
		}
	}
	return null;
}
{/literal}
{/code}


Then we can use this method in the PresenceSensorListener :

{code lang="java"}
{literal}  
@Override
public void notifyDeviceEvent(String deviceSerialNumber) {
    System.out.println("The device with the serial number "+ deviceSerialNumber+ " has changed");

    PresenceSensor sensor = getPresenceSensor(deviceSerialNumber);
    if(sensor!=null){
    	String location = sensor.getLocation();
    	System.out.println("This sensor is in the room : " + sensor.getLocation());
    }
}
{/literal}
{/code}


If you test again, you should have a result like this one:
 
 {code}           
            The device with the serial number SekuSensor-AAA-20119215-S has changed
            This sensor is in the room : kitchen
 {/code}

#### Finding the lights in the same room

Here again we need to implement a search method :

{code lang="java"}
{literal} 
/**
 * Return the lights in the given location 
 * @param location :  the given location
 * @return the lights of this location
 */
public List<BinaryLight> getBinaryLightFromLocation(String location){
	List<BinaryLight> ligths = new ArrayList<BinaryLight>();
	for (BinaryLight binaryLight : binaryLights) {
		if(binaryLight.getLocation().equals(location)){
			ligths.add(binaryLight);
		}
	}
	return ligths;
}
{/literal}
{/code}

We can now print a message showing the number of lights in the room :

{code lang="java"}
{literal} 
System.out.println("The device with the serial number "+ deviceSerialNumber+ " has changed");
PresenceSensor sensor = getPresenceSensor(deviceSerialNumber);
if(sensor!=null){
	String location = sensor.getLocation();
    System.out.println("This sensor is in the room : " + sensor.getLocation());
	List<BinaryLight> ligths = getBinaryLightFromLocation(location);	
	System.out.println("There are "+ ligths.size()+ " lights in "+ location);
}
{/literal}
{/code}

You can test if it works.

#### Modifying the state of lights


Finally we will test the state of the sensor (presence or not) and change the lights accordingly :

{code lang="java"}
{literal} 
public class PresenceSensorListener implements DeviceListener{

		@Override
		public void notifyDeviceEvent(String deviceSerialNumber) {
            System.out.println("The device with the serial number "+ deviceSerialNumber+ " has changed");
			PresenceSensor sensor = getPresenceSensor(deviceSerialNumber);
			if(sensor!=null){
				String location = sensor.getLocation();
                System.out.println("This sensor is in the room : " + sensor.getLocation());
				List<BinaryLight> ligths = getBinaryLightFromLocation(location);	
                System.out.println("There are "+ ligths.size()+ " lights in "+ location);
				
				//Check of the sensor :
				System.out.println("Presence ? " + sensor.getSensedPresence());
				if(sensor.getSensedPresence()){
					//If the user is in the room :
					for (BinaryLight binaryLight : ligths) {
						//switch on the lights
						binaryLight.setPowerStatus(true);
						System.out.println("switch on "+ binaryLight.getSerialNumber());
					}
				}else{
					//else if the user left the room:
					for (BinaryLight binaryLight : ligths) {
						//switch off the lights :
						binaryLight.setPowerStatus(false);
						System.out.println("switch off "+ binaryLight.getSerialNumber());
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

+ This code does not manage the concurrency. Try to implement it. You can check the [correction](#TODO) [TODO] if needed.


</article>

{section_links}

<aside markdown="1">
### Download

+ Download the [workspace](bin/eclipse-32-linux.tar.gz)

</aside>

