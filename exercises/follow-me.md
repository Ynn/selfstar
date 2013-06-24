<article markdown="1">

# Follow Me Exercises

In this first series of exercises, you will build a light follow me application. As we already explained in the tutorial, a Follow Me is a context-aware application that adapts its behaviour to the movement of a person to trigger a particular action (switch on/off the light, switch on/off a speaker, ...).
Here the goal is to make the light follows the users.

<img src="img/basic-follow-me/light_follow_me.png" width = "60%"/>

The exercises are dependent and must be followed in the given order. You can refer to the [getting started](article/for-beginners/getting-started) section and the [tutorial](article/for-beginners/basic-follow-m) if you need.


## Exercise 1: Writing the basic follow me
In this exercise, you will learn how to write a basic light follow me. 

<u>Question 1 - Tutorial</u>: Follow the basic binary light tutorial to implement your first binary light follow me application. You can skip the "play with it section". Optionally you can also read the [getting started](/article/for-beginners/getting-started) section as recommended in the tutorial.

<u>Question 2 - react when a light is moved:</u> The current application does not manage the change of light location. Listen to the change of location and change each light state accordingly.

<u>Question 3 - Scripts</u>: You will now test that the application is working correctly. To do so, you will need to use a script.

{note}
### About scripts

The iCASA environment can be created and modified using scripts. A script is an XML file with a specific extension (.bhv) that contains sequentially executed instructions. The list of available commands can be found in the [iCASA scripts documentation](http://adeleresearchgroup.github.io/iCasa-Simulator/1.0.0/script.html).

To play a script, you need to deploy it in the iCASA **load** directory. Scripts can then be run using the "Script Player" panel, you then can select and start your script in the "Script" section. At any time, only one script can be played.

{/note}


For beginning and to ease the process of creating scripts, we will provide you a skeleton of a script for testing your light application. You will need to enhanced it to be able to test your applications.

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

We strongly recommend to store that maximum number in a member variable (you will have to reuse it later when building administration interfaces) :

{code lang=java} 
/** 
* The maximum number of lights to turn on when a user enter the room :
**/
private int maxLightsToTurnOnPerRoom = 1;
{/code}


<u>Question 3 - Using the dimmer lights</u>: You will now manage a new type of device called dimmer light.
The specification of dimmer lights is given in iCASA documentation. Each dimmer light use the fr.liglab.adele.icasa.device.light.DimmerLight interface.

Modify the application to switch on (0%) and off(100%) the dimmer lights (as well as the binary lights) when the user is moving. 

Modify your script so add some dimmer lights in the different rooms. Example :
{code lang=xml}
	<create-device id="DL-A0001W-S" type="iCASA.DimmerLight" />
{/code}

Check your application is working as expected.

## Exercise 3: Providing an administration service

In this exercise, you will create an administration service to allow the configuration of your application. You will also create your first small manager that will automatically configure this service.

<u>Question 1 - Providing a configuration service</u>: In the getting started section, we explain [how to provide a service](/article/for-beginners/intro-services). You will now provide a service for configuring your application.

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

Provide this interface as a service (follow the instruction given in the getting started section).

Deploy your application and check that your service is provided in the Felix console : [http://localhost:8080/system/console/bundles](http://localhost:8080/system/console/bundles).

Export the package org.example.follow.me.configuration as explained in the [using multiple bundles](http://local.self-star.net:8888/article/for-beginners/multiple-bundles) tutorial.

<u>Question 2 - Implementing a small manager:</u> You will create a very basic manager to adjust the number of lights to turn on in the rooms based on administrator's decisions. 

Your manager will understand (more) "high level goals" such as "High Illuminance", "Medium Illuminance", "Low Illuminance" and configure the number of lights accordingly. 

Create a new project "follow.me.manager" and add a main component FollowMeManager. The implementation class should be named FollowMeManager.java and put into the **org.example.follow.me.manager.impl** package.

Import the package org.example.follow.me.configuration as explained in the [using multiple bundles](http://local.self-star.net:8888/article/for-beginners/multiple-bundles) tutorial.

Add the dependency to the FollowMeConfiguration configuration and write a manager so that the number of lights is adjusted depending on a targeted goal. 

![The FollowMeConfiguration service](/img/exercises/follow.me/followMeConfigurationService.png)

For beginning the interpretation of these goals into according configuration will be hard-coded and hardwired.
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


<u>Question 3 - providing an administration interface for your manager</u>: Your manager has to provide an administration interface to allow the administrator to express his goals. Once again, you will provide a service in that purpose.

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


<u> Question 4 - providing a command:</u> Now that you can configure your manager, we propose you to build a command line so as to allow administrators to configure your manager.


One again, you need to create a new component "Follow Me Command" and import and export the package "org.example.follow.me.manager".

![The FollowMeAdministration service](/img/exercises/follow.me/FollowMeCommand.png)


Commands are not currently supported by the IDE. You will need to use [iPOJO annotations](http://felix.apache.org/site/how-to-use-ipojo-annotations.html). You don't Here is an example of command using [iPOJO annotations](http://felix.apache.org/site/how-to-use-ipojo-annotations.html) and a [provided specific handler](http://felix.apache.org/site/how-to-write-your-own-handler.html) for providing commands :



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
	 * @param goal the new illuminance preference ("SOFT", "MEDIUM", "HIGH")
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

As you can notice, the component and the dependency are directly declared in the code. There is no need to do it in the IDE.

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

In this exercise, you will try to add to manage the energy consumption of your system.

<u>Question 1 - Extending the configuration service</u>: Extend the configuration service of your Follow Me application so that it is possible to configure a maximum power per room :

![The FollowMeConfiguration service](/img/exercises/follow.me/followMeConfigurationService.png)

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

Implements this service so that the energy consumption of a room does not exceed the given maximum.
In that purpose, you should create a new member variable :
{code lang="java"}
/**
* The maximum energy consumption allowed in a room in Watt:
**/
private double maximumEnergyConsumptionAllowedInARoom = 100.0d;
{/code}

Please note that the maximumNumberOfLights (we have introduced earlier) takes precedence over the given maximum power consumption. 

To simplify the implementation you can assume that each light as a 100Watt default consumption and that the lights are binary lights only. In such case the number of light is given by a simple Euclidean division.

<u>Question 2 - Test:</u> Create a script (the environment should be composed by binary lights only) to test your application and checks it is working according to the specification.

<u>Question 3 - Manager:</u> Extend the FollowMeAdministration and your manager to add an energy saving goal :

![The FollowMeAdministration service](/img/exercises/follow.me/followMeAdministration.png)

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


<u>Question 4 - Command:</u> Extend your command to be able to configure the energy saving goal and test your work.

![The FollowMeAdministration service](/img/exercises/follow.me/followMeCommand.png)


{code lang="bash"}
g! setEnergyPreference MEDIUM
g! getEnergyPreference
EnergyMode = MEDIUM
{/code}


<u>Question 5 - Using DimmerLights:</u> Change your implementation to take dimmer lights into account.
One way to achieve this is to try to turn on as many binary lights as possible and then turn the DimmerLights to reach the targeted power by adjusting their powers.

<u>Question 6 (optional) - Using heterogeneous lights:</u> In the previous questions, we assumed that all the lights had the same nominal consumption. Try to write a more generic algorithm to manage heterogeneous lights.

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
			// Note that the sum could be calculated without using the bitset
			// (less clear but more memory efficient)
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

Then you may try to solve the problem for environment including some dimmer lights.

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
Let's call :

+ &lambda; the dimmer configuration
+ &beta; the watts to lumens factor (value 680.0)
+ R the area of the room
+ P the maximum power of the given light
+ I the illuminance

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


<u>Question 3 (optional) - generic algorithm</u> Try to find a solution for the generic case : heterogeneous lights (binary lights and dimmer lights with different wattage). 

To simplify the problem, you can adopt a test&amp;try approach by turning on the lights and configuring the the dimmer lights  progressively. If you choose this approach, you may cache the result of your configuration for the next time (until the targeted light is changed).


<u>Question 4 - Enhancing the configuration service.</u> Now you will improve your configuration service to allow the configuration of the illuminance value.


![The FollowMeConfiguration service](/img/exercises/follow.me/followMeConfigurationService.png)

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

![The FollowMeAdministration service](/img/exercises/follow.me/followMeAdministration.png)

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
and modify your manager to takes this goal into account.

<u>Question 6 - Test</u> Using the command you have implemented before, test that your application is working as expected.

{code lang="bash"}
g! setIlluminancePreference SOFT
g! setIlluminancePreference MEDIUM
g! setIlluminancePreference FULL
{/code}






## Exercise 5: Reacting to time events


## Exercise 6: Dealing with Flopping state

</article>

{section_links}
