<article markdown="1">

# Temperature management

In this first series of exercises, you will build a naive temperature system. Such system is often part of an HVAC (Heating, Ventilating, and Air Conditioning) system. An HVAC system manages the temperature, humidity, air flow and air quality of a given building. In this set of exercises we will solely focus on the temperature management. 

<img src="img/exercises/heater_big.png" width = "60%"/>

Once again, the exercises have been designed to build upon each other: they should be followed in the given order.
We assume that you have completed the set of [follow me exercises](/article/exercises/follow-me) before starting this series.
 You can refer to the [getting started](article/for-beginners/getting-started) section and the [tutorial](article/for-beginners/basic-follow-me) if you need to. 


## Exercise 1: Writing the temperature Controller
In this exercise, you will learn how to write a basic temperature Controller that will adjust the temperature in a given room to a targeted temperature. In that purpose, you will use the following simulated devices:

{code lang="java"}
fr.liglab.adele.icasa.device.temperature.Cooler
fr.liglab.adele.icasa.device.temperature.Thermometer
fr.liglab.adele.icasa.device.temperature.Heater
{/code}

The devices interfaces is described in the [iCASA Heater/Cooler documentation](http://adeleresearchgroup.github.io/iCasa-Simulator/1.1.1/heater.html).

<u>Question 1 - Component</u>: Create a new component nammed "TemperatureController".
Use "TemperatureControllerImpl" as your implementation class. The package will be "org.example.temperature.Controller".

Using the temperature measured by thermometers (you can use the average value when more than one thermometer is available), try to adjust the wattage of Coolers and Heaters to reach a given temperature (say 25°C/77°F/293.15K) into the flat.

You will have to use a consistent unit for temperature (°C/°F or Kelvin). We recommand you to use Kelvin.

We assume you have no idea of the simulated physical temperature model. So you will have to base your system on a test and try approach. To implement such approach, you will probably need to implement and provide as service the PeriodicRunnable interface that will check the temperature periodically (every 10s for instance):

![Implementing the PeriodicRunnable](/img/exercises/hvac/scheduling.png)


<u>Question 2 - Scripts</u>: Write a script to check your application is working.

Here are some command you should use:
{code lang=xml}
<behavior startdate="25/12/2012-00:00:00" factor="1440">

 	<!-- Create the different zones -->
   	<create-zone id="kitchen"  leftX="410" topY="370" width="245" height="210" />	 
	<create-zone id="livingroom" leftX="410" topY="28" width="245" height="350" />
	<create-zone id="bedroom"  leftX="55" topY="370" width="259" height="210" />	
	<create-zone id="bathroom"  leftX="55" topY="20" width="260" height="350" />

    <!-- Creating a Thermometer, a Heater and a Cooler-->
	<create-device id="Ther-A3654Q-S" type="iCASA.Thermometer" />
	<create-device id="Heat-A4894S-S" type="iCASA.Heater" />
	<create-device id="Cool-A7496W-S" type="iCASA.Cooler" />

	<!-- Moving the devices to a given room-->
	<move-device-zone deviceId="Heat-A4894S-S" zoneId="livingroom" />
	<move-device-zone deviceId="Ther-A3654Q-S" zoneId="livingroom" />
	<move-device-zone deviceId="Cool-A7496W-S" zoneId="livingroom" />

	<!-- Configure the temperature in Kelvin for the kitchen -->
	<add-zone-variable zoneId="kitchen" variable="Temperature" />
	<modify-zone-variable zoneId="kitchen" variable="Temperature" value="280.15"/>

	//.. 

</behavior>
{/code}

Try to configure different temperatures for the different rooms (higher, lower or equal than/to 25°C).

Run the script and check that the application is working as expected.

<u>Question 3 - Configuring the temperature per room:</u> Change your implementation to allow the configuration of the temperature for each room.

You can use the following targeted temperatures: 

+ 15°C for the Kitchen
+ 18°C for the Living room
+ 20°C for the Bedroom
+ 23°C for the Bathroom

Check that your application is working as expected.

## Exercise 2: Configuration and management

In this exercise, you will create an administration service to allow the configuration of the targeted temperatures. As in the follow-me exercises, you also will implement an autonomic manager that will configure your application.

<u>Question 1 - Providing a configuration service</u>: Provide a service "TemperatureConfiguration" for configuring your application.

The FollowMeConfiguration service interface is really simple :

{code lang = "java"}
package org.example.temperature.configuration;

/**
 * The TemperatureConfiguration service allows one to configure the temperature
 * controller.
 */
public interface TemperatureConfiguration {

	/**
	 * Configure the controller to reach a given temperature in Kelvin in a
	 * given room.
	 * 
	 * @param targetedRoom
	 *            the targeted room name
	 * @param temperature
	 *            the temperature in Kelvin (>=0)
	 */
	public void setTargetedTemperature(String targetedRoom, float temperature);

	/**
	 * Gets the targetted temperature of a given room.
	 * 
	 * @param room
	 *            the room name
	 * @return the temperature in Kelvin
	 */
	public float getTargetedTemperature(String room);

}
{/code}

Implement the TemperatureConfiguration interface and provide this interface as a service.

Deploy your application and check that your service is provided in the Felix console : [http://localhost:8080/system/console/bundles](http://localhost:8080/system/console/bundles).

Export the package org.example.temperature.configuration as explained in the [using multiple bundles](/article/for-beginners/multiple-bundles) tutorial.

<u>Question 2 - Implementing a manager:</u> You will now add a "Temperature Manager" component that will be responsible for configuring the service.

The goal is to allow users to express satisfaction. Your manager will have to learned based on user satisfaction which temperature is expected.

Create a new project "temperature.manager" and add a main component TemperatureManager. The implementation class should be named TemperatureManagerImpl.java and put it into the **org.example.temperature.manager.impl** package.

Import the package org.example.temperature.configuration as explained in the [using multiple bundles](/article/for-beginners/multiple-bundles) tutorial.

Add the dependency to the TemperatureConfiguration service and write a manager so that the targeted temperature is adjusted depending on user satisfaction. 

![The FollowMeAdministration service](/img/exercises/hvac/temperatureAdministration.png)

To help user to express their satisfaction you will have to implement the TemperatureManagerAdministration interface:

{code lang="java"}
package org.example.temperature.manager.administration;

/**
 * This interface allows to configure the temperature manager responsible for
 * configuring the temperature controller.
 */
public interface TemperatureManagerAdministration {

	/**
	 * This method is called every time a user think the temperature is too high
	 * in a given room.
	 * 
	 * @param roomName
	 *            the room where the temperature should be reconfigured
	 */
	public void temperatureIsTooHigh(String roomName);

	/**
	 * This method is called every time a user think the temperature is too high
	 * in a given room.
	 * 
	 * @param roomName
	 *            the room where the temperature should be reconfigured
	 */
	public void temperatureIsTooLow(String roomName);
}
{/code}

Your manager will have to figure out which is the adequate temperature for a given room (minTemperature, maxTemperature) based on users satisfaction. You can try to reduce or increase the temperature by 1 Kelvin so as to reach an adequate temperature (i.e. when users stop complaining about temperature).

Stabilization could be issue and you have to consider the time factor. Your user might be complaining about the temperature before the actual targeted temperature is reached. Such complained should be ignored or your system might never be stable.

<u> Question 3 - providing a command:</u> Write a command line that use the TemperatureConfiguration service so as to allow users to express their satisfaction.

Create a new component "Temperature Command" that imports and exports the package "org.example.temperature.manager.administration".

![The temperature command service](/img/exercises/hvac/temperatureCommand.png)

Here is a skeleton of the command implementation:

{code lang="java"}
package org.example.temperature.command;

import org.apache.felix.ipojo.annotations.Component;
import org.apache.felix.ipojo.annotations.Instantiate;
import org.apache.felix.ipojo.annotations.Requires;
import org.example.follow.me.manager.FollowMeAdministration;
import org.example.follow.me.manager.IlluminanceGoal;

import fr.liglab.adele.icasa.command.handler.Command;
import fr.liglab.adele.icasa.command.handler.CommandProvider;

//Define this class as an implementation of a component :
@Component
//Create an instance of the component
@Instantiate(name = "temperature.administration.command")
//Use the handler command and declare the command as a command provider. The
//namespace is used to prevent name collision.
@CommandProvider(namespace = "temperature")
public class TemperatureCommandImpl {

	// Declare a dependency to a TemperatureAdministration service
	@Requires
	private TemperatureAdministration m_administrationService;


	/**
	 * Command implementation to express that the temperature is too high in the given room
	 *
	 * @param room the given room
	 */

	// Each command should start with a @Command annotation
	@Command
	public void tempTooHigh(String room) {
		m_administrationService.//...
	}

	@Command
	public void tempTooLow(){
		//...
	}

}
{/code}


Implement the two methods. The commands can be then used directly in the Felix shell :
{code lang="bash"}
g! tempTooHigh kitchen
g! tempTooLow livingRoom
{/code}


<u> Question 4 - test:</u> Using the above command, check that your manager is working.

## Exercise 3 - Room occupancy and Energy Management
In this exercise you will build a RoomOccupancy service that computes statics on room occupancy. You will then use this service to tune the manager behavior.

<u> Question 1 - RoomOccupancy service</u>: Create a new component called "RoomOccupancy" and implement the following service :

{code lang="java"}

package org.example.occupancy;

public interface RoomOccupancy {

	/**
	 * Gets the probability (between 0 and 1) that the given room is occupied
	 * at the given moment of the day. 
	 *
	 * @param hour
	 *            a specific time in the day in minute (between 0 (=00:00) and
	 *            1439 (=23:59))
	 * @param room
	 *            the room name where the occupancy value is required.
	 * @return the room occupancy is a value between 0 and 1 where 0 indicates
	 *         that there the room is always empty and 1 indicates that the room
	 *         is always occupied at the given moment of the day.
	 */
	public double getRoomOccupancy(double minuteOfTheDay, String room);

}

{/code}

The package "org.example.occupancy" must be provided by your component.

The idea is to check periodically (using a PeriodicRunnable) if a room is occupied or not and adjust the 

At the beginning, the default value of room occupancy is 0.

<u> Question 3 - Script and command</u>: Create a script using the command describe in [iCASA documentation](http://adeleresearchgroup.github.io/iCasa-Simulator/1.1.1/script.html) that move one or more users in the different rooms of the flat during 2 days. 

<u> Question 4 - Test</u>: Based on the script you have written, test that your RoomOccupancy service is working as expected. For this purpose you can write a command (provided by the "Room Occupancy" component).

<u> Question 5 - TemperatureConfiguration</u>: Change the TemperatureConfiguration service so that the temperature management can be turn on/off in a given room:

{code lang="java"}
package org.example.temperature;

/**
 * The TemperatureConfiguration service allows one to configure the temperature
 * controller.
 */
public interface TemperatureConfiguration {
 //...

	/**
	 * Turn on the temperature management in the given room
	 * 
	 * @param room
	 *            the given room
	 */
	public void turnOn();

	/**
	 * Turn off the temperature management in the given room
	 * 
	 * @param room
	 *            the given room
	 */
	public void turnOff(String room);

}
{/code}

<u>Question 6 - Energy management</u>: Now you will try to manage the energy.

Your manager will depend on the room occupancy component:
![The room occupancy service](/img/exercises/hvac/roomOccupancy.png)




Add an energy mode to your manager:
{code lang="java"}
/**
 * This interface allows to configure the temperature manager responsible for
 * configuring the temperature controller.
 */
public interface TemperatureManagerAdministration {
	
	//...

	/**
	 * Enable the energy saving mode.
	 */
	public void turnOnEnergySavingMode();

	/**
	 * Disable the energy saving mode.
	 */
	public void turnOffEnergySavingMode();

	/**
	 * Checks if the energy saving mode is enabled.
	 * 
	 * @return true, if the energy saving mode is enabled
	 */
	public boolean isPowerSavingEnabled();

}
{/code}

When the energy saving mode is enabled, you should try to turn off the temperature control in the room with low occupancy (e.g. <0.2). 

The occupancy threshold can be setted statically to start:
{code lang="java"}
public static final double ROOM_OCCUPANCY_THRESHOLD = 0.2;
{/code}

In a second time, You may also reduce the number of watts being used by opting for a higher/lower temperature than the targeted one.

Try to propose a consistent energy management strategy based on the room occupancy.

It would be a good idea to extend the TemperatureManagerAdministration to allow the configuration of the factors you are considering as well as the thresholds - it will depend on your strategy.

Write a command to be able to trigger the energy saving mode:
Add a command to test your work:
{code lang="bash"}
g! temperature:enableEnergySaving
g! temperature:disableEnergySaving
{/code}

<u> Question 7 - maximum amount of power</u>: Finally, you may consider the time factor by reducing the power of the AC. Your system will take more time to reach the targeted temperature but will momentarily use less energy. That is useful if your system is available amount of power at a given time is limited.

Modify the configuration service of your controller so that the maximum amount of available power per room can be configured.

{code lang="java"}
public interface TemperatureConfiguration {

    /**
     * Sets the maximum allowed energy consumption in Watts in each room
     * 
     * @param maximumEnergy
     *            the maximum allowed energy consumption in Watts in each room
     */
    public void setMaximumAllowedEnergyInRoom(double maximumEnergy);
}
{/code}

Modify the administration interface and your manager implementation to allow the expression of an Energy Goal (on the same model as in the follow-me exercises)

![The TemperatureAdministration service](/img/exercises/hvac/temperatureAdministration.png)


Add a command to test your work:
{code lang="bash"}
g! temperature:setEnergyGoal LOW
{/code}
where LOW stands for a given maximum power.


## Exercise 4 - Time and Users dependent preferences

In this exercise, you will try to improve the configuration of the temperature depending on time and user preferences criteria. 

<u>Question 1 - Using moment of the day</u>: Users might prefer a colder temperature during the day than at night. Using the moment of the day component, you have written in the follow-me exercises, try to build different temperature profiles based on the moment of the day.

Your manager will have to register a listener to the MomentOfTheDay service and configure the temperature based on the moment of the day. 

![Configuration based on the moment of the day](/img/exercises/hvac/momentOfTheDay.png)

The configuration of the temperature will now depends on both the location (room) and the moment of the day.

<u>Question 2 - Tracking users</u>: In the following, we will try to base the reasoning not only on time factors but also on user preferences. The idea is to customized the temperature of a room based to the user that are mostly in a given room.

To do so, you need to collect information on which users will be in a room at a given time. This requires to use to location service provided by iCASA to locate users precisely. 

![The room occupancy service](/img/exercises/hvac/roomOccupancy2.png)

Extend the room occupancy service so that you can get the probability of someone to be in a given room at a given time:

{code lang="java"}

package org.example.occupancy;

public interface RoomOccupancy {

	//..

	/**
	 * Gets the probability (between 0 and 1) that the given user will be in the given room
	 * at the given moment of the day. 
	 *
	 * @param hour
	 *            a specific time in the day in minute (between 0 (=00:00) and
	 *            1439 (=23:59)).
	 * @param room
	 *            the room name where the occupancy value is required.
	 * @param user
	 *			  the given user.
	 * @return the room occupancy is a value between 0 and 1 where 0 indicates
	 *         that there the room is always empty and 1 indicates that the room
	 *         is always occupied at the given moment of the day.
	 */
	public double getRoomOccupancy(double minuteOfTheDay, String room, String user);

}

{/code}

You will have to choose the best accuracy of this service so as not to raise memory issues.


<u>Question 3 - Building a User preference based profile</u> We will now assume that each user is connected to as specific device (smartphone, computer, etc.) when configuring the temperature. Modify the command implementation accordingly:

{code lang="bash"}
g! tempTooHigh bathroom Alice
g! tempTooLow bathroom Bob
{/code}

Then modify your manager implementation to support this modification:
{code lang="java"}
package org.example.temperature.manager.administration;

/**
 * This interface allows to configure the temperature manager responsible for
 * configuring the temperature controller.
 */
public interface TemperatureManagerAdministration {

	/**
	 * This method is called every time a user think the temperature is too high
	 * in a given room.
	 * 
	 * @param roomName
	 *            the room where the temperature should be reconfigured
	 * @param userName
	 *            the user who expressed that preference
	 */
	public void temperatureIsTooHigh(String roomName, String username);

	/**
	 * This method is called every time a user think the temperature is too high
	 * in a given room.
	 * 
	 * @param roomName
	 *            the room where the temperature should be reconfigured
	 * @param userName
	 *            the user who expressed that preference
	 */
	public void temperatureIsTooLow(String roomName, String username);
}
{/code}

The temperature preference has too be store for each users. We assume that the set of visitor is stable and limited (e.g., a typical family of 4 or 5 users).

<u>Question 4 - Configuring the temperature based on these multiple sources of information</u> Using the room occupancy service and the user based profiles try to configure the temperature to match the best user preferences at a moment of the day. 

This problem has many solutions. You will have to deal with state flapping when more that one user is in the room. You should find a give some user more priority than an other (the probability of being in a room is one of the factors to consider). 

There is a chance that a temperature might not be perfect for one or more user of a given room. You will probably have to ignore some of their complaints.

</article>

{section_links}
