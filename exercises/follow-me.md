<article markdown="1">

# Follow Me Exercises

In this first series of exercises, you will build a "follow me" light application. As we already explained in the tutorial, Follow Me is a context-aware application that adapts its behaviour to the movement of a person to trigger a particular action (switch on/off the light, switch on/off a speaker, ...).
Here the goal is to make the light follow the users.

<img src="img/basic-follow-me/light_follow_me.png" width = "60%"/>

The exercises have been designed to build upon each other: they should be followed in the given order. You can refer to the [getting started](article/for-beginners/getting-started) section and the [tutorial](article/for-beginners/basic-follow-me) if you need to.


## Exercise 1: Writing the basic follow me
In this exercise, you will learn how to write a basic "follow me" light. 

<u>Question 1 - Tutorial</u>: Follow the basic binary lights tutorial to implement your first follow me application with binary lights. 

Use "LightFollowMe" as the name of your component and "LightFollowMeImpl" as your implementation class. The package will be "org.example.follow.me"

You can skip the "play with it section" if you would like to. Optionally you can also read the [getting started](/article/for-beginners/getting-started) section as recommended in the tutorial.

<u>Question 2 - react when a light is moved:</u> The current application does not manage the change of light location. Listen to the change of location and change each light state accordingly.

<u>Question 3 - Scripts</u>: You will now test that the application is working correctly. To do so, you will need to use a script.

{note}
### About scripts

The iCASA environment can be created and modified using scripts. A script is an XML file with a specific extension (.bhv) that contains sequentially executed instructions. The list of available commands can be found in the [iCASA scripts documentation](http://adeleresearchgroup.github.io/iCasa-Simulator/1.0.0/script.html).

To play a script, you need to deploy it in the iCASA **load** directory. Scripts can then be run using the "Script Player" panel, you then can select and start your script in the "Script" section. At any time, only one script can be played.

{/note}


For beginning and to ease the process of creating scripts, we will provide you a skeleton script for testing your light application. You will need to enhance it to be able to test your applications.

Download and deploy the following script : [single_bl_light_environment.bhv]() in the load directory of iCASA. 
The script should be now available in the "Script player" in the iCASA GUI. 

Run the script and check that the application is working as expected.

## Exercises 2 : Using multiple lights and dimmer lights

Now you will enhance the tutorial version by managing dimmer lights.

<u>Question 1 - More lights</u>: Note that there is only one light per room. Copy the script and rename the copy to **multiple_lights_environment.bhv**. 

Modify the script to have at least two lights per room. 

{warning}
When creating a new device, you must give it an unique ID. An ID cannot be used twice. The ID is a string and there is no restriction on how to format the device name. We strongly recommend to give it an easily recognizable name.
{/warning}

Stop the running script. Use the reset environment command in the "Script Panel" and run your newly created script.

<u>Question 2 - No more than n lights</u>: As you can notice, the present implementation of the follow me is turning all the lights on when a user enter a room. This is obviously not energy friendly.

Change the current implementation so that the number of light per room can be configured.

We strongly recommend you store the maximum number in a member variable (you will have to reuse it later when building the administration interfaces) :

{code lang=java} 
/** 
* The maximum number of lights to turn on when a user enters the room :
**/
private int maxLightsToTurnOnPerRoom = 1;
{/code}


<u>Question 3 - Using the dimmer lights</u>: You will now manage a new type of device called "dimmer light".
The specification of dimmer lights is given in the iCASA documentation. Each dimmer light uses the fr.liglab.adele.icasa.device.light.DimmerLight interface.

Modify the application to switch on (0%) and off(100%) the dimmer lights (as well as the binary lights) when the user is moving. 

Modify your script so add some dimmer lights in the different rooms. Example :
{code lang=xml}
	<create-device id="DL-A0001W-S" type="iCASA.DimmerLight" />
{/code}

Check your application is working as expected.

## Exercise 3: Providing an administration service

In this exercise, you will create an administration service to allow the configuration of your application. You will also create your first small autonomic manager that will automatically configure this service.

<u>Question 1 - Providing a configuration service</u>: In the getting started section, we explain [how to provide a service](/article/for-beginners/intro-services). You will now provide a service for configuring your application.

The FollowMeConfiguration service interface is really simple :

{code lang=java}
package org.example.follow.me.configuration;

/**
 * The FollowMeConfiguration service allows one to configure the Follow Me
 * application.
 */
public interface FollowMeConfiguration {

	/**
	 * Gets the maximum number of lights to turn on each time an user is
	 * entering a room.
	 * 
	 * @return the maximum number of lights to turn on
	 */
	public int getMaximumNumberOfLightsToTurnOn();

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

Provide this interface as a service (follow the instructions given in the getting started section).

Deploy your application and check that your service is provided in the Felix console : [http://localhost:8080/system/console/bundles](http://localhost:8080/system/console/bundles).

Export the package org.example.follow.me.configuration as explained in the [using multiple bundles](http://local.self-star.net:8888/article/for-beginners/multiple-bundles) tutorial.

<u>Question 2 - Implementing a small manager:</u> You will create a very basic manager to adjust the number of lights to turn on in the rooms based on the administrator's decisions. 

Your manager will understand (more) "high level goals" such as "High Illuminance", "Medium Illuminance", "Low Illuminance" and configure the number of lights accordingly. 

Create a new project "follow.me.manager" and add a main component FollowMeManager. The implementation class should be named FollowMeManagerImpl.java and put into the **org.example.follow.me.manager.impl** package.

Import the package org.example.follow.me.configuration as explained in the [using multiple bundles](http://local.self-star.net:8888/article/for-beginners/multiple-bundles) tutorial.

Add the dependency to the FollowMeConfiguration configuration and write a manager so that the number of lights is adjusted depending on a targeted goal. 

![The FollowMeConfiguration service](/img/exercises/follow.me/FollowMeConfigurationService.png)

To begin to interpret these goals the configuration will be hand-coded and hardwired.
You can use the following hand-coded values :

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
	 * Gets the number of lights to turn On.
	 * 
	 * @return the number of lights to turn On.
	 */
	public int getNumberOfLightsToTurnOn() {
		return numberOfLightsToTurnOn;
	}

	/**
	 * Instantiates a new illuminance goal.
	 * 
	 * @param numberOfLightsToTurnOn
	 *            the number of lights to turn on.
	 */
	private IlluminanceGoal(int numberOfLightsToTurnOn) {
		this.numberOfLightsToTurnOn = numberOfLightsToTurnOn;
	}
}
{/code}


<u>Question 3 - providing an administration interface for your manager</u>: Your manager has to provide an administration interface to allow the administrator to express his or her goals. Once again, you will provide a service for that purpose.

![The FollowMeAdministration service](/img/exercises/follow.me/FollowMeAdministration.png)


The service interface will be :

{code lang="java"}

package org.example.follow.me.manager;

/**
 * The Interface FollowMeAdministration allows the administrator to configure
 * its preference regarding the management of the Follow Me application.
 */
public interface FollowMeAdministration {

	/**
	 * Sets the illuminance preference. The manager will try to adjust the
	 * illuminance in accordance with this goal.
	 * 
	 * @param goal
	 *            the new illuminance preference
	 */
	public void setIlluminancePreference(IlluminanceGoal illuminanceGoal);

	/**
	 * Get the current illuminance preference.
	 * 
	 * @return the new illuminance preference
	 */
	public illuminanceGoal getIlluminancePreference();

}
{/code}

Your FollowMeManager class should implement this class and provide it as a service.


<u> Question 4 - providing a command:</u> Now that you can configure your manager, we propose that you build a command line so as to allow administrators to configure your manager.


Once again, you need to create a new component "Follow Me Command" and import and export the package "org.example.follow.me.manager".

![The FollowMeAdministration service](/img/exercises/follow.me/FollowMeCommand.png)


Commands are not currently supported by the IDE. You will need to use [iPOJO annotations](http://felix.apache.org/site/how-to-use-ipojo-annotations.html). Here is an example of command using [iPOJO annotations](http://felix.apache.org/site/how-to-use-ipojo-annotations.html) and a [provided specific handler](http://felix.apache.org/site/how-to-write-your-own-handler.html) for providing commands :



{code lang="java"}
package org.example.follow.me.manager.command;

import org.apache.felix.ipojo.annotations.Component;
import org.apache.felix.ipojo.annotations.Instantiate;
import org.apache.felix.ipojo.annotations.Requires;
import org.example.follow.me.manager.FollowMeAdministration;
import org.example.follow.me.manager.IlluminanceGoal;

import fr.liglab.adele.shell.handler.Command;
import fr.liglab.adele.shell.handler.CommandProvider;

//Define this class as an implementation of a component :
@Component
//Create an instance of the component
@Instantiate(name = "follow.me.mananger.command")
//Use the handler command and declare the command as a command provider. The
//namespace is used to prevent name collision.
@CommandProvider(namespace = "followme")
public class FollowMeManagerCommandImpl {

	// Declare a dependency to a FollowMeAdministration service
	@Requires
	private FollowMeAdministration m_administrationService;


	/**
	 * Felix shell command implementation to sets the illuminance preference.
	 *
	 * @param goal the new illuminance preference ("SOFT", "MEDIUM", "FULL")
	 */

	// Each command should start with a @Command annotation
	@Command
	public void setIlluminancePreference(String goal) {
		// The targeted goal
		IlluminanceGoal illuminanceGoal;

		// TODO : Here you have to convert the goal string into an illuminance
		// goal and fail if the entry is not "SOFT", "MEDIUM" or "HIGH"

		//call the administration service to configure it :
		m_administrationService.setIlluminancePreference(illuminanceGoal);
	}

	@Command
	public void getIlluminancePreference(){
		//TODO : implement the command that print the current value of the goal
		System.out.println("The illuminance goal is "); //...
	}

}
{/code}

As you may notice, the component and the dependency are directly declared in the code. There is no need to do it in the IDE.

Implement the two methods to achieve the conversion of the goal from String to IlluminanceGoal. The command can be then used directly in the Felix shell :
{code lang="bash"}
g! setIlluminancePreference MEDIUM
{/code}


Create a new command getIlluminancePreference :
{code lang="bash"}
g! getIlluminancePreference
The illuminance goal is MEDIUM.
{/code}

<u> Question 5 - test:</u> Using the above command, check that your manager is working.

## Exercice 4: A better energy management

In this exercise, you will try to manage the energy consumption of your system.

<u>Question 1 - Extending the configuration service</u>: Extend the configuration service of your Follow Me application so that it is possible to configure a maximum power per room :

![The FollowMeConfiguration service](/img/exercises/follow.me/FollowMeConfigurationService.png)

{code lang=java}
package org.example.follow.me.configuration;
 
/**
 * The FollowMeConfiguration service allows to configure the Follow Me
 * application.
 */
public interface FollowMeConfiguration {
    public int getMaximumNumberOfLightsToTurnOn();
    public void setMaximumNumberOfLightsToTurnOn(int maximumNumberOfLightsToTurnOn);
 
    /**
     * Gets the maximum allowed energy consumption in Watts in each room
     * 
     * @return the maximum allowed energy consumption in Watts
     */
    public double getMaximumAllowedEnergyInRoom();
 
    /**
     * Sets the maximum allowed energy consumption in Watts in each room
     * 
     * @param maximumEnergy
     *            the maximum allowed energy consumption in Watts in each room
     */
    public void setMaximumAllowedEnergyInRoom(double maximumEnergy);
}
{/code}

Implement this service so that the energy consumption of a room does not exceed the given maximum.
To this end, you should create a new member variable:
{code lang="java"}
/**
* The maximum energy consumption allowed in a room in Watt:
**/
private double maximumEnergyConsumptionAllowedInARoom = 100.0d;
{/code}

Please note that the maximumNumberOfLights (we have introduced earlier) takes precedence over the given maximum power consumption. 

To simplify the implementation you can assume that each light as a default 100Watt consumption and that the lights are binary lights only. In such case the number representing light is given by a simple Euclidean division (N = Target/100)

<u>Question 2 - Test:</u> Create a script to test your application and checks it is working according to the specification (the environment should be composed by binary lights only).

<u>Question 3 - Manager:</u> Extend the FollowMeAdministration interface and your manager implementation to add an energy saving goal :

![The FollowMeAdministration service](/img/exercises/follow.me/FollowMeAdministration.png)

{code lang="java"}
public interface FollowMeAdministration {

    public void setIlluminancePreference(IlluminanceGoal illuminanceGoal);
    public illuminanceGoal getIlluminancePreference();

	/**
	 * Configure the energy saving goal.
	 * @param energySavingEnabled : the targeted energy goal.
	 */
	public void setEnergySavingGoal(EnergyGoal energyGoal);

	/**
	 * Gets the current energy goal.
	 * 
	 * @return the current energy goal.
	 */
	public EnergyGoal getEnergyGoal();

}
{/code}

The different levels of energy could be :
{code lang="java"}
package org.example.follow.me.manager;

/**
 * This enum describes the different energy goals associated with the
 * manager.
 */
public enum EnergyGoal {
	LOW(100d), MEDIUM(200d), HIGH(1000d);

	/**
	 * The corresponding maximum energy in watt
	 */
	private double maximumEnergyInRoom;

	/**
	 * get the maximum energy consumption in each room
	 * 
	 * @return the energy in watt
	 */
	public double getMaximumEnergyInRoom() {
		return maximumEnergyInRoom;
	}

	private EnergyGoal(double powerInWatt) {
		maximumEnergyInRoom = powerInWatt;
	}
} 
{/code}


<u>Question 4 - Command:</u> Write a command to be able to configure the energy saving goal and test your work.

![The FollowMeAdministration service](/img/exercises/follow.me/FollowMeCommand.png)



{code lang="bash"}
g! setEnergyPreference MEDIUM
g! getEnergyPreference
EnergyMode = MEDIUM
{/code}


<u>Question 5 - Using DimmerLights:</u> Change your implementation to take dimmer lights into account.
One way to achieve this is to try to turn on as many binary lights as possible and then turn the DimmerLights to reach the targeted power by adjusting their powers.

<u>Question 6 (optional) - Using heterogeneous lights:</u> In the previous questions, we assumed that all the lights had the same nominal power consumption. 

Now, you can try to write a more generic algorithm to manage heterogeneous lights.

First consider only the problem with BinaryLights. To do that, you might have to test all the combinations of BinaryLights. This can be achieved by solving the [Subset sum problem](https://en.wikipedia.org/wiki/Subset_sum_problem).

The consumption of a light is given by the getMaxPowerLevel() method of the BinaryLight interface.

Here is a very naive implementation of this algorithm (feel free to implement your own) :

{code lang="java"}
package org.example.algorithm;

import java.util.Arrays;
import java.util.BitSet;

/**
 * This class implements an algorithm that use a very naive approach of solving
 * the closest sum subset problem on an array of doubles.
 */
public final class ClosestSumAlgorithm {

	/**
	 * Find the subset of the items whose sum is closest to, without exceeding
	 * maximalSum.
	 * 
	 * Performance are low with doubles. Could largely be improved by using
	 * integers instead. The algorithm is sufficiently effective for 15 lights
	 * or less.
	 * 
	 * @param maximalSum
	 *            the maximal sum of the subset;
	 * @param items
	 *            an array containing the weight of each items. The order of
	 *            element will be preserved to produce the best
	 *            combination.
	 * @return the subset of items whose sum is closest to maximalSum
	 *         without exceeding it. The combination is given in the same order
	 *         as the input array. array[i] contains the value of item[i] if it
	 *         is involved in the computing of the closest-sum, or 0 if not.
	 */
	public static double[] greadySubSetClosestSum(final double maximalSum, final double[] items) {

		// the current best results :
		double bestSum = 0;
		double[] bestCombination = new double[0];

		/*
		 * Generate all the possible combinations. There are 2^N possibilities
		 * that can therefore be represented by a bitset.
		 * The use of bitset is done to reduce the number of line of codes.
		 * The solution is thus far from being optimized.
		 */
		for (int i = 0; i < Math.pow(2, items.length); i++) {
			// Get the current combination 
			double[] currentCombination = multiplyByBitset(convertToBitSet(i), items);
			double currentSum = sum(currentCombination);

			// if we have the best result possible
			if (currentSum == maximalSum) {
				// return it
				return currentCombination;
			}

			// if the current result is better than the previous best result
			if ((currentSum <= maximalSum) && (currentSum > bestSum)) {
				// store it
				bestSum = currentSum;
				bestCombination = currentCombination;
			}
		}

		return bestCombination;
	}

	/**
	 * Sum of the given variables or array.
	 * 
	 * @param variables
	 *            the variables to be summed.
	 * @return the sum of the variables.
	 */
	private static double sum(double... variables) {
		double sum = 0;
		for (double var : variables) {
			sum += var;
		}
		return sum;
	}

	/**
	 * Convert a number into BitSet.
	 * This could be obtained directly in JAVA7 (iCASA is not compatible)
	 * 
	 * @param number
	 *            the number to convert
	 * @return the resulting bit set
	 */
	private static BitSet convertToBitSet(long number) {
		BitSet bits = new BitSet();
		int index = 0;
		while (number != 0L) {
			if ((number % 2L) != 0) {
				bits.set(index);
			}
			++index;
			number = number >>> 1;
		}
		return bits;
	}

	/**
	 * Multiply an array by a bitset
	 * 
	 * @param bitset
	 *            the BitSet
	 * @param array
	 *            the array
	 * @return the resulting array
	 */
	private static double[] multiplyByBitset(BitSet bitset, double[] array) {
		assert (bitset.length() == array.length) : "array and bitset must have the same size";

		double[] result = new double[array.length];
		for (int i = 0; i < array.length; i++) {
			result[i] = bitset.get(i) ? array[i] : 0;
		}
		return result;
	}
}
{/code}

Example of use :
{code lang="java"}
public static void main(String[] args) {
	double[] items = new double[] { 1.5d, 7.4d, 3.4d, 8.3d, 15.233d, 99d, 22d, 76d, 38d, 22d, 7d, 0.10d, 54.9d, 45.9d, 90d, 48.6d, 6.1d, 4.2d, 89.3d };

	// Targeted sum :
	double maxSum = 99.97484;
	// Compute the best combination :
	double[] result = ClosestSumAlgorithm.greadySubSetClosestSum(maxSum, items);
	System.out.println(Arrays.toString(result));
	System.out.println(sum(result));

}
{/code}

Then you may try to find a general solution for environment including some dimmer lights.

## Exercise 5: A better illuminance management.

In this exercise, you will manage the level of illuminance more precisely.

<u>Question 1 - Reaching a targeted illuminance</u> Use the photometers to get the illuminance of each room.
Change your code to keep a targeted illuminance when moving users from one room to another:

{code lang="java"}
/**
* The targeted illuminance in each room
**/
private double targetedIlluminance = 4000.0d;
{/code}

**To simplify, you can assume that there is only one dimmer light per room (and no binary lights).**

The physical model used by iCASA is basic. You can use the following constant to perform your computation :

{code lang="java"}
/**
 * Watt to lumens conversion factor
 * It has been considered that: 1 Watt=680.0 lumens at 555nm.
 */
public final static double ONE_WATT_TO_ONE_LUMEN = 680.0d;
{/code}

The light provided by a DimmerLight depends on the configuration of the dimmer (ranging from 0.0d to 1.0d).
Let:

+ &lambda; be the dimmer configuration
+ &beta; be the watts to lumens factor (value 680.0)
+ R be the area of the room
+ P be the maximum power of the given light
+ I be the illuminance

The illuminance I given by one dimmer light is given by :

![illuminance equation](img/exercises/follow.me/illEquation.png)

It is thus easy to find the &lambda; factor to apply to a given light.

<u>Question 2 - more than one dimmer light:</u> You will now try to manage more than one Dimmer Light.

The general equation of our physical model is :

![illuminance equation](img/exercises/follow.me/generalIllEquation.png)

where :

+ N is the number of available lights.
+ &lambda;(i) and P(i) are the power factor and maximum power of light i. 

To simplify the problem, you can assume that every light has the same maximum power level (P(i)) : P and that the factor &lambda;(i) is the same for every light (&lambda;).


<u>Question 3 (optional) - generic algorithm</u> Try to find a solution for the generic case of heterogeneous lights (binary lights and dimmer lights with different wattage). 

To simplify the problem, you can adopt a test&amp;try approach by turning on the lights and configuring the the dimmer lights  progressively. If you choose this approach, you may cache the result of your configuration for the next time (until the targeted light is changed).


<u>Question 4 - Enhancing the configuration service.</u> Now you will improve your configuration service to allow the configuration of the illuminance value.


![The FollowMeConfiguration service](/img/exercises/follow.me/FollowMeConfigurationService.png)

Implements the following methods :

{code lang="java"}
package org.example.follow.me.configuration;
 
/**
 * The FollowMeConfiguration service allows to configure the Follow Me
 * application.
 */
public interface FollowMeConfiguration {
    public int getMaximumNumberOfLightsToTurnOn();
    public void setMaximumNumberOfLightsToTurnOn(int maximumNumberOfLightsToTurnOn);
    public double getMaximumAllowedEnergyInRoom();
    public void setMaximumAllowedEnergyInRoom(double maximumEnergy);

    /**
     * Gets the targeted illuminance for each room
     * 
     * @return the targeted illuminance in lumens
     */
    public double getTargetedIlluminance();
 
    /**
     * Sets the targeted illuminance for each room
     * 
     * @param illuminance
     * 		 the targeted illuminance in lumens for each room
     */
    public void setTargetedIlluminance(double illuminance);
}
{/code}

<u>Question 5 - Administration interface.</u> Modify the manager IlluminanceGoal to add illuminance configuration :

![The FollowMeAdministration service](/img/exercises/follow.me/FollowMeAdministration.png)

{code lang="java"}
package org.example.follow.me.manager;
 
/**
 * This enum describes the different illuminance goals associated with the
 * manager.
 */
public enum IlluminanceGoal {

    /** The goal associated with soft illuminance. */
    SOFT(1, 500d),
    /** The goal associated with medium illuminance. */
    MEDIUM(2, 2750d),
    /** The goal associated with full illuminance. */
    FULL(3, 4000d);
 

    //... TODO change the enum to take the illuminance into account
}

{/code}
and modify your manager to takes this goal into account.

<u>Question 6 - Test</u> Using the command you have implemented before, test that your application is working as expected.

{code lang="bash"}
g! setIlluminancePreference SOFT
g! setIlluminancePreference MEDIUM
g! setIlluminancePreference FULL
{/code}

In particular, make sure that the lights are correctly reconfigured for each room when the targeted illuminance is reconfigured.


## Exercise 6 : Using user preferences

Now, we will try to adapt the illuminance based on User's preferences. 

In this exercise, we will assume that it is possible to identify who is in a given room. For that purpose we provide a LocationService that provides the ability to get a list of persons in a given room.

The user preferences service (Preferences) is able to store a set of user preferences (via setUserPropertyValue/getUserProperties)

<u> Question 1 - Change the manager implementation to use the Preferences service</u> Instead of having a targeted global illuminance configured globally, we will use the preference service to configure a value per users.

Initially, we will assume that there is only one person in the flat. 

Use the location service to determine who is in the flat. Then use the the Preferences services to get the user preferences regarding illuminance.

![The Manager using location and preferences](/img/exercises/follow.me/preferences.png)

Each person can express a preference. Use the following constant for the illuminance preference.
{code lang="java"}
/**
* User preferences for illuminance
**/
public static final String USER_PROP_ILLUMINANCE = "illuminance";
public static final String USER_PROP_ILLUMINANCE_VALUE_SOFT = "SOFT";
public static final String USER_PROP_ILLUMINANCE_VALUE_SOFT = "MEDIUM";
public static final String USER_PROP_ILLUMINANCE_VALUE_SOFT = "FULL";
{/code}


Example of using the Preferences service :
{code lang="java"}
import fr.liglab.adele.icasa.service.preferences;
//..
public class FollowMeManagerImpl {

	// You have to create a new dependency :
	private Preferences preferencesService; //...

	//same applied for the person location service :
	private PersonLocationService personLocationService; //...


	public void ...{
		String AliceIlm = (String) preferencesServices.getUserPropertyValue("Alice", USER_PROP_ILLUMINANCE);
		//..	
	}

{/code}

You will have to convert the given String "SOFT"/"MEDIUM"/"FULL" into an illuminanceGoal. You have done this before in order to implement your command.

When the person has not expressed any preference, use the previously defined (global) preference.

<u>Question 2 - Writing a command for the preference service </u> Extend your command implementation so as to allow to store user preferences :


{code lang="bash"}
g! setIlluminancePreference Alice SOFT 
g! setIlluminancePreference John MEDIUM
g! setIlluminancePreference Bob FULL
{/code}


![The preferences command](/img/exercises/follow.me/preferencesCommand.png)


Using this command, test that your implementation is working as expected.



<u>Question 3 - More than one person:</u> When more than one person is in the flat, use an average value for the targeted illuminance. You can experiment with this by defining another policy (priority based, user-type based, etc.).



## Exercise 7: Reacting to time events

In this exercise you will learn to react to timed events.

<u>Question 1 - Moment Of The Day Component:</u> We propose to reconfigure the illuminance based on moment of the day. In that purpose you will need to create a new component "MomentOfTheDay" in a new package "org.example.time".

Make sure you export the service as it will be reused by your manager.


The component will provide a service MomentOfTheDayService :

{code lang="java"}
package org.example.time;

/**
 * The MomentOfTheDay service is used to retrieve the moment of the day.
 * It also supports listeners that are notified when the moment of the day
 * change.
 */
public interface MomentOfTheDayService {

	/**
	 * Gets the moment of the day.
	 * 
	 * @return the moment of the day
	 */
	MomentOfTheDay getMomentOfTheDay();


	//...
}
{/code}

A MomentOfTheDay is defined by the following enum :
{code lang="java"}
package org.example.time;

public enum MomentOfTheDay {
	MORNING(6), AFTERNOON(12), EVENING(18), NIGHT(22);

	/**
	 * Gets the moment of the day corresponding to the hour.
	 * 
	 * @param hour
	 *            the given hour
	 * @return the corresponding moment of the day
	 */
	MomentOfTheDay getCorrespondingMoment(int hour) {
		assert ((0 <= startHour) && (startHour <= 24));
		// TODO : if (hour < //..
		return null;
	}

	/**
	 * The hour when the moment start.
	 */
	private final int startHour;

	/**
	 * Build a new moment of the day :
	 * 
	 * @param startHour
	 *            when the moment start.
	 */
	MomentOfTheDay(int startHour) {
		assert ((0 <= startHour) && (startHour <= 24));
		this.startHour = startHour;
	}
}
{/code}


Implement the MomentOfTheDayService. The implementation class should be named "MomentOfTheDayImpl" and will be based on the PeriodicRunnable of the fr.liglab.adele.icasa.service.scheduler package.

The PeriodicRunnable follow [the whiteboard pattern](http://www.osgi.org/wiki/uploads/Links/whiteboard.pdf) (you don't need to understand how it works to implement it). 

Basically you have to provide PeriodicRunnable as a service and implement it into your MomentOfTheDayImpl class. Then iCASA will automatically discover your service and its configuration. Based on the latter (getPeriod), it will call the run() method on a regular basis.

![The moment of the day service implementation](/img/exercises/follow.me/momentOfTheDay.png)

{code lang="java"}

public class MomentOfTheDayImpl implements MomentOfTheDayService, PeriodicRunnable{
	
	/**
	* The current moment of the day :
	**/
	MomentOfTheDay currentMomentOfTheDay;

	// Implementation of the MomentOfTheDayService ....

	MomentOfTheDay getMomentOfTheDay(){

	}

	// Implementation ot the PeriodicRunnable ...

    public long getPeriod(){
    	// The service will be periodically called every hour.
    	return 3600 * 1000;
    }

    public String getGroup(){
    	return "default"; // you don't need to understand this part.
    }


	@Override
	public void run() {
		// The method run is called on a regular basis

		// TODO : do something to check the current time of the day and see if
		// it has changed

		currentMomentOfTheDay = null; // FIXME : change the value
	}

}

{/code}

Complete the code above to work as expected.

<u>Question 2 - Writing a command: </u> You can implement a command to test that your code is working :
![The moment of the day service implementation](/img/exercises/follow.me/momentOfTheDayCommand.png)

{code lang="bash"}
g! getMomentOfTheDay
AFTERNOON
{/code}

<u>Question 3 - Implementing Listeners</u> You will now change your implementation to support listeners.

Here is the new interface of the service :
{code lang="java"}
package org.example.time;

public interface MomentOfTheDayService {

	MomentOfTheDay getMomentOfTheDay();

	/**
	 * Register a listener that will be notified each time the current moment of the day
	 * changed.
	 * 
	 * @param listener
	 *            the listener
	 */
	void register(MomentOfTheDayListener listener);

	/**
	 * Unregister a moment of the day listener.
	 * 
	 * @param listener
	 *            the listener
	 */
	void unregister(MomentOfTheDayListener listener);
}
{/code}
Here is the interface of the Listeners :

{code lang="java"}
package org.example.time;

/**
 * The listener interface for receiving momentOfTheDay events.
 * The class that is interested in processing a momentOfTheDay
 * event implements this interface, and the object created
 * with that class is registered with a component using the
 * MomentOfTheDayService <code>register<code> method. When
 * the momentOfTheDay event occurs, that object's appropriate
 * method (<code>momentOfTheDayHasChanged</code>) is invoked.
 * 
 * When the listener is leaving, it must unregister.
 * 
 */
public interface MomentOfTheDayListener {

	/**
	 * Notify the listener that moment of the day has changed.
	 * 
	 * @param newMomentOfTheDay
	 *            the new moment of the day
	 */
	void momentOfTheDayHasChanged(MomentOfTheDay newMomentOfTheDay);
}
{/code}

Change your implementation to manage listeners. The easiest way to do the that is to maintain a list of listeners and call the momentOfTheDayHasChanged method of each listener every time the moment of the day changes.

To simplify the concurrency management, you can add synchronize before each method (performance greedy but safe). If you are more confident, you can use a lock to prevent concurrent access to the list.

<u> Question 4 - A moment-aware manager:</u> Change your manager implementation to implement the listener.

![The moment of the day listener](/img/exercises/follow.me/momentOfTheDayListener.png)

The idea is to adapt the illuminance based on the moment of the day.

Here are some suggestion of factor you could use to compute the SOFT, MEDIUM, FULL configuration:
{code lang="java"}
// There is no need of full illuminance in the morning 
private double factor MORNING_ILLUMINANCE_FACTOR = 0.5;
// In the afternoon the illuminance can be largely limited
private double factor ATERNOON_ILLUMINANCE_FACTOR = 0.2;
// In the evening, the illuminance should be the best
private double factor EVENING_ILLUMINANCE_FACTOR = 1;
// In the night, there is no need to use the full illuminance
private double factor NIGHT_ILLUMINANCE_FACTOR = 0.8;
{/code}

The new SOFT value would be SOFT = MOMENT_FACTOR * DEFAULT_SOFT where DEFAULT_SOFT is the value you were using before, and MOMENT_FACTOR is one of the FACTOR given above.

{*

## Exercise 8: Dynamic dependency

In this short exercise, you will learn how to create a dynamic filter.

<u>Question 1 - Follow Alice by night </u> Alice has a child (Bob) that cannot be disturbed when she is going to her bedroom.

This goal of this exercise is to show you how a dependency filter can be built to solve such problems.

In your follow me application, create a new dependency on lights (we will only manage binaryLights) :
{code lang="java"}
	private void lightsInAliceRoomButNotInBobRoom;
{/code}

Create a filter associated to that field :

{code lang = "ldap"}
{literal}
(location=${person.alice.location})&(!(location=${person.bob.location}))
{/literal}
{/code}

*}

## Exercise 8: Dealing with state flapping

In this exercise, the goal is too avoid the state of lights to be change on very short periods (i.e., a child run over and over from one room to another causing a large amount of events to deal with)

For this exercise, you will not be guided. The goal is to propose an architecture and a solution for avoiding state flapping (never-ending change due to repeating events).

Hints : 

+ You may use a time-frame and some counters associated to each device as a first approach.
+ It would be a good idea (but more complex) to let the manager manage such case. You may for instance change the configuration interface of your follow me component to allow the configuration of a non-changeable device list. This list would be configured by your manager.

</article>

{section_links}
