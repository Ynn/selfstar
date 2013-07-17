<article markdown="1">

# Temperature management

In this first series of exercises, you will build a naive temperature system. Such system is often part of an HVAC (Heating, Ventilating, and Air Conditioning) system. An HVAC system manages the temperature, humidity, air flow and air quality of a given building. In this set of exercices we will solely focus on the temperature management. 

<img src="img/exercises/heater_big.png" width = "60%"/>

Once again, the exercises have been designed to build upon each other: they should be followed in the given order.
We assume that you have completed the set of [follow me exercices](/article/exercises/follow-me) before starting this series.
 You can refer to the [getting started](article/for-beginners/getting-started) section and the [tutorial](article/for-beginners/basic-follow-me) if you need to. 


## Exercise 1: Writing the temperature Controller
In this exercise, you will learn how to write a basic temperature Controller that will adjust the temperature in a given room to a targeted temperature. In that purpose, you will use the following simulated devices:

{code lang="java"}
fr.liglab.adele.icasa.device.temperature.Cooler
fr.liglab.adele.icasa.device.temperature.Thermometer
fr.liglab.adele.icasa.device.temperature.Heater
{/code}

The devices interfaces is described in the [iCASA Heater/Cooler documentation](http://adeleresearchgroup.github.io/iCasa-Simulator/1.1.0/heater.html).

<u>Question 1 - Component</u>: Create a new component nammed "TemperatureController".
Use "TemperatureControllerImpl" as your implementation class. The package will be "org.example.temperature.Controller".

Using the temperature measured by thermometers (you can use the average value when more than one thermometer is available), try to adjust the wattage of Coolers and Heaters to reach a given temperature (say 25°C/77°F/293.15K) into the flat.

You will have to use a consistent unit for temperature (°C/°F or Kelvin). We recommand you to use Kelvin.

We assume you have no idea of the simulated physical temperature model. So you will have to base your system on a test and try approach. To implement such approach, you will probably need to implement and provide as service the PeriodicRunnable interface that will check the temperature periodically (every 10s for instance):

![Implementing the PeriodicRunnable](/img/exercises/hvac/scheduling.png)


It should be stressed the current model is very simplistic and does not take temperature exchange between rooms into account. So don't be surprised if your system quickly reach the targeted temperature.

<u>Question 2 - Scripts</u>: Write a script to check your application is working.

Here are some command you should use :
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

Export the package org.example.temperature.configuration as explained in the [using multiple bundles](http://local.self-star.net:8888/article/for-beginners/multiple-bundles) tutorial.

<u>Question 2 - Implementing a manager:</u> You will now add a "Temperature Manager" component that will be responsible for configuring the service.

The goal is to allow users to express satisfaction. Your manager will have to learned based on user satisfaction which temperature is expected.

Create a new project "temperature.manager" and add a main component TemperatureManager. The implementation class should be named TemperatureManagerImpl.java and put into the **org.example.temperature.manager.impl** package.

Import the package org.example.temperature.configuration as explained in the [using multiple bundles](http://local.self-star.net:8888/article/for-beginners/multiple-bundles) tutorial.

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

Your manager will have to figure out which is the adequate temperature for a given room (minTemperature, maxTemperature) based on user satisfaction. You can try to reduce or increase the temperature by 1 Kelvin so as to reach an adequate temperature.


<u> Question 3 - providing a command:</u> Write a command line that use the TemperatureConfiguration service so as to allow users to express their satisfaction.

Create a new component "Temperature Command" that imports and exports the package "org.example.temperature.manager.administration".

![The FollowMeAdministration service](/img/exercises/hvac/temperatureCommand.png)

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
	 * @param goal the given room
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
g! tempTooHigh
g! tempTooLow
{/code}


<u> Question 4 - test:</u> Using the above command, check that your manager is working.


## Exercice 3 - Tracking users

</article>

{section_links}
