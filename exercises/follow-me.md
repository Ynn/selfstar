<article markdown="1">

# Follow Me Exercises

In this first series of exercises, you will build a light follow me application. As we already explained in the tutorial, a Follow Me is a context-aware application that adapts its behaviour to the movement of a person to trigger a particular action (switch on/off the light, switch on/off a speaker, ...).
Here the goal is to make the light follows the users.

<img src="img/basic-follow-me/light_follow_me.png" width = "60%"/>

The exercises are dependant and must be followed in the given order. You can refer to the [getting started](article/for-beginners/getting-started) section and the [tutorial](article/for-beginners/basic-follow-m) if you need.


## Exercise 1: Writing the basic follow me
In this exercise, you will learn how to write a basic light follow me. Then you will enhance the tutorial version by managing dimmer lights.

<u>Question 1 - Tutorial</u>: Follow the basic binary light tutorial to implement your first binary light follow me application. You can skip the play with it section. Optionnaly you can also read the getting started section as recommended in the tutorial.

<u>Question 2 - Scripts</u>: You will now test that the application is working correctly. To do so, you will need to use a script.

{note}
### About scripts

The iCASA environnement can be created and modified using scripts. A script is an xml files with a specific extension (.bhv) that contains sequentially executed instructions. The list of available commands can be found in the [iCASA scripts documentation](http://adeleresearchgroup.github.io/iCasa-Simulator/1.0.0/script.html).

To play a script, you need to deploy it in the iCASA **load** directory. Scripts can then be run using the "Script Player" pannel, you then can select and start your script in the "Script" section. At any time, only one script can be played.

{/note}


For beginning and to ease the process of creating scripts, we will provide you a squeleton of a script for testing your light application. You will need to enhanced it, among question, to be able to test your applicaitons.

Download and deploy the following script : [single_bl_light_environment.bhv]() in the load directory of iCASA. 

The script should be now available in the "Script player" in the iCASA GUI. 

Run the script and check that the application is working as expected.

<u>Question 3 - More lights</u>: Note that there is only one light per room. Copy the script and rename the copy to **multiple_lights_environement.bhv**. 

Modify the script to have at least two lights per room. 

{warning}
When creating a new device, you must give it an unique ID. An ID cannot be used twice. The ID is a string and there is no restriction on how to format the device name. We strongly recommand to give it an easily recognizable name.
{/warning}

Stop the running script. Use the reset environnement command in the "Script Pannel" and run your newly created script.

<u>Question 4 - No more that n lights</u>: As you can notice, the present implementation of the follow me is switching all the lights on when a user enter a room. This is obviously not energy friendly.

Change the current implementation so that the number of light per room can be configured.

We strongly recommand to store that maximum number in a member variable (you will have to reuse it later when building administration interfaces) :

{code lang=java} 
/** 
* The maximum number of lights to turn on when a user enter the room :
**/
private int maxLightsToTurnOnPerRoom = 1;
{/code}


<u>Question 5 - Using the dimmer lights</u>: You will now manage a new type of device called dimmer light.
The specification of dimmer lights is given in iCASA documentation. Every Dimmer Lights use the fr.liglab.adele.icasa.device.light.DimmerLight interface.

Modify the application to switch on (0%) and off(100%) the Dimmer Lights (as well as the binary lights) when the user is moving. 

Modify your script so add some dimmer lights in the different rooms. Example :
{code lang=xml}
	<create-device id="DL-A0001W-S" type="iCASA.DimmerLight" />
{/code}

Check your application is working as expected.

## Exercise 2: Providing an administration service

In this exercise, you will create an administration service to allow the configuration of your application. You will also create your first small manager that will automatically configure this service.

<u>Question 1 - Providing an administration service</u>: In the getting started section, we explain [how to provide a service](/article/for-beginners/intro-services). You will now provide a service for configuring your application.

The FollowMeConfiguration service interface is really simple :

{code lang=java}
package org.example.follow.me.configuration;

/**
 * The FollowMeConfiguration service allows to configure the Follow Me
 * application.
 */
public interface FollowMeConfiguration {

	/**
	 * Gets the maximum number of lights to turn on each time an user is
	 * entering a room.
	 * 
	 * @return the maximum number of lights to turn on
	 */
	public void getMaximumNumberOfLightsToTurnOn();

	/**
	 * Sets the maximum number of lights to turn on each time an user is
	 * entering a room.
	 * 
	 * @param maximumNumberOfLightsToTurnOn
	 *            the new maximum number of lights to turn on
	 */
	public void setMaximumNumberOfLightsToTurnOn(int maximumNumberOfLightsToTurnOn);
}
{/code}

Implement the FollowMeConfiguration interface into your main application class.

Provide this interface as a service (follow the instuction given in the getting started section).

Deploy your application and check that your service is provided in the Felix console : [http://localhost:8080/system/console/bundles](http://localhost:8080/system/console/bundles).

Export the package org.example.follow.me.configuration as explained in the [using multiple bundles](http://local.self-star.net:8888/article/for-beginners/multiple-bundles) tutorial.

<u>Question 2 - Implementing a small manager:</u> You will create a very basic manager to adjust the number of lights to turn on in the rooms based on administrator's decisions. 

Your manager will understand (more) "high level goals" such as "High Illuminance", "Medium Illuminance", "Low Illuminance" and configure the number of lights accordingly. 

For begining the interpretation of these goals into according configuration will be hard-coded and hardwired. Of course, this manager is not smart (the manager acts more like an administration wrapper) and the raise of abstraction is limited, but it will show you the basics steps to separate the concerns of your application configuration with the management of more abstract administration goals.

Create a new project "follow.me.manager" and add a main component FollowMeMananger. 

Import the package org.example.follow.me.configuration as explained in the [using multiple bundles](http://local.self-star.net:8888/article/for-beginners/multiple-bundles) tutorial.

Add the dependency to the FollowMeConfiguration configuration and write a manager so that the number of lights is adjusting depending on a targetted goal. 

You can use the following hard-coded values :

{code lang="java"}
package org.example.follow.me.manager;

/**
 * This enum describes the different illuminance goals associated with the
 * manager.
 */
public enum IlluminanceGoal {

	/** The goal associated with soft illuminance. */
	SOFT(1),
	/** The goal associated with medium illuminance. */
	MEDIUM(2),
	/** The goal associated with full illuminance. */
	FULL(3);

	/** The number of lights to turn on. */
	private int numberOfLightsToTurnOn;

	/**
	 * Gets the number of lights.
	 * 
	 * @return the number of lights
	 */
	public int getNumberOfLightsToTurnOn() {
		return numberOfLightsToTurnOn;
	}

	/**
	 * Instantiates a new illuminance goals.
	 * 
	 * @param numberOfLightsToTurnOn
	 *            the number of lights to turn on
	 */
	private IlluminanceGoal(int numberOfLightsToTurnOn) {
		this.numberOfLightsToTurnOn = numberOfLightsToTurnOn;
	}
}
{/code}



## Exercise 3: Adjusting illuminance



## Exercise 5: Dealing with Flopping state

</article>

{section_links}
