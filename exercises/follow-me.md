<article markdown="1">

# Follow Me Exercises

In this first series of exercises, you will build a light follow me application. As we already explained in the tutorial, a Follow Me is a context-aware application that adapts its behaviour to the movement of a person to trigger a particular action (switch on/off the light, switch on/off a speaker, ...).
Here the goal is to make the light follows the users.

<img src="img/basic-follow-me/light_follow_me.png" width = "60%"/>

The exercises are dependant and must be followed in the given order. You can refer to the [getting started](article/for-beginners/getting-started) section and the [tutorial](article/for-beginners/basic-follow-m) if you need.


## Exercise 1: Writing the basic follow me
In this exercise, you will learn how to write a basic light follow me. Then you will enhance the tutorial version by managing dimmer lights.

<u>Question 1 - Tutorial</u>: Follow the basic binary light tutorial to implement your first binary light follow me application. You can skip the play with it section. Optionnaly you can also read the getting started section as recommended in the tutorial.

<u>Question 2 - react when a light is moved:</u> The current application does not manage the change of light location. Listen to the change of location and change the lights state accordingly.

<u>Question 3 - Scripts</u>: You will now test that the application is working correctly. To do so, you will need to use a script.

{note}
### About scripts

The iCASA environnement can be created and modified using scripts. A script is an xml files with a specific extension (.bhv) that contains sequentially executed instructions. The list of available commands can be found in the [iCASA scripts documentation](http://adeleresearchgroup.github.io/iCasa-Simulator/1.0.0/script.html).

To play a script, you need to deploy it in the iCASA **load** directory. Scripts can then be run using the "Script Player" pannel, you then can select and start your script in the "Script" section. At any time, only one script can be played.

{/note}


For beginning and to ease the process of creating scripts, we will provide you a squeleton of a script for testing your light application. You will need to enhanced it, among question, to be able to test your applicaitons.

Download and deploy the following script : [single_bl_light_environment.bhv]() in the load directory of iCASA. 

The script should be now available in the "Script player" in the iCASA GUI. 

Run the script and check that the application is working as expected.

## Exercices 2 : Using multiple lights and dimmer lights

<u>Question 1 - More lights</u>: Note that there is only one light per room. Copy the script and rename the copy to **multiple_lights_environement.bhv**. 

Modify the script to have at least two lights per room. 

{warning}
When creating a new device, you must give it an unique ID. An ID cannot be used twice. The ID is a string and there is no restriction on how to format the device name. We strongly recommand to give it an easily recognizable name.
{/warning}

Stop the running script. Use the reset environnement command in the "Script Pannel" and run your newly created script.

<u>Question 2 - No more than n lights</u>: As you can notice, the present implementation of the follow me is switching all the lights on when a user enter a room. This is obviously not energy friendly.

Change the current implementation so that the number of light per room can be configured.

We strongly recommand to store that maximum number in a member variable (you will have to reuse it later when building administration interfaces) :

{code lang=java} 
/** 
* The maximum number of lights to turn on when a user enter the room :
**/
private int maxLightsToTurnOnPerRoom = 1;
{/code}


<u>Question 3 - Using the dimmer lights</u>: You will now manage a new type of device called dimmer light.
The specification of dimmer lights is given in iCASA documentation. Every Dimmer Lights use the fr.liglab.adele.icasa.device.light.DimmerLight interface.

Modify the application to switch on (0%) and off(100%) the Dimmer Lights (as well as the binary lights) when the user is moving. 

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

Create a new project "follow.me.manager" and add a main component FollowMeManager. The implementation class should be nammed FollowMeManager.java and put into the **org.example.follow.me.manager.impl** package.


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


<u>Question 3 - providing an adminstration interface for your manager</u>: Your manager has to provide an administration interface to allow the administrator to express is goals. Once again, you will provide a service in that purpose.

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


<u> Question 4 - providing a command:</u> Now that you can configure your manager, we propose you to build a command line so as to allow adminstrators to configure your manager.

Commands are not currently supported by the IDE. You will need to use [iPOJO annotations](http://felix.apache.org/site/how-to-use-ipojo-annotations.html). You don't Here is an example of command using [iPOJO annotations](http://felix.apache.org/site/how-to-use-ipojo-annotations.html) and a [specific handler]() for providing commands :

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

Complete this code to perform the conversion of the goal. The command can be used directly in the Felix shell :
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

{code lang=java}
package org.example.follow.me.configuration;
 
/**
 * The FollowMeConfiguration service allows to configure the Follow Me
 * application.
 */
public interface FollowMeConfiguration {
    public void getMaximumNumberOfLightsToTurnOn();
    public void setMaximumNumberOfLightsToTurnOn(int maximumNumberOfLightsToTurnOn);
 
    /**
     * Gets the maximum allowed energy consumption in Watts in each room
     * 
     * @return the maximum allowed energy consumption in Watts
     */
    public void getMaximumAllowedEnergyInRoom();
 
    /**
     * Sets the maximum allowed energy consumption in Watts in each room
     * 
     * @param maximumNumberOfLightsToTurnOn
     *            the new maximum number of lights to turn on
     */
    public void setMaximumAllowedEnergyInRoom(int maximumNumberOfLightsToTurnOn);
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

This maximumNumberOfLights has precedence over the given maximum power consumption. 

At first, to simplify the implementation you can consider that each light as a 100Watt default consumption and that the lights are binary lights only. In such case the number of light is given by a simple Euclidean division.

<u>Question 2 - Test:</u> Create a script (the environment should be composed by binary lights only) to test your application and checks it is working according to the specification.

<u>Question 3 - Manager:</u> Extend the FollowMeAdministration and your manager to add an energy saving mode :

{code lang="java"}
public interface FollowMeAdministration {

    public void setIlluminancePreference(IlluminanceGoal illuminanceGoal);
    public illuminanceGoal getIlluminancePreference();

	/**
	 * Configure the energy saving mode
	 * @param energySavingEnabled : the targeted energy mode.
	 */
	public void setEnergySaving(EnergyGoal energyGoal);

	/**
	 * Check if the energy saving mode is enabled.
	 * 
	 * @return the current energy mode.
	 */
	public EnergyGoal isInEnergySavingMode();

}
{/code}

The different level of energy could be :
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


<u>Question 4 - Command:</u> Extend your command to be able to trigger the energy saving mode and test your work.

{code lang="bash"}
g! setEnergyPreference MEDIUM
g! getEnergyPreference
EnergyMode = MEDIUM
{/code}


<u>Question 5 - Using DimmerLights:</u> Change your implementation to take dimmer lights into account.
One way to achieve it, is to try to turn on as many BinaryLight as possible and then turn the DimmerLights to reach the targeted power by adjusting their powers.

<u>Question 6 (optional) - Using heterogeneous lights:</u> In the previous questions, we assumed that the lights all have the same nominal consumption. Try to write a more generic algorithm to manage heterogeneous lights.

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
	Arrays.sort(items);
	// force the algorithm to explore all the possibilities
	double maxSum = 99.97484;
	double[] result = ClosestSumAlgorithm.greadySubSetClosestSum(maxSum, items);
	System.out.println(Arrays.toString(result));
	System.out.println(sum(result));

}
{/code}


## Exercise 4: A better illuminance management.

Question 1 



## Exercise 5: Reacting to time events


## Exercise 6: Dealing with Flopping state

</article>

{section_links}
