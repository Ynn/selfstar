<article markdown="1">

# Various Exercises

This section contains a set of various exercises that provides less guidance regarding the architecture and the implementation. In a first exercise, you will be propose to build an alarm and presence simulation application. 
Then in a second exercise, you will try to manager of managers. This manager in chief will be responsible for managing the different applications on the platform. Finally, you will be asked to modify the follow-me application and the temperature manager to introduce utility functions so as to improve the management.

<img src="img/exercises/alarm_big.png" width = "60%"/>

The exercises are relatively independent but the complexity is progressive.
We assume that you have completed the set of [follow me exercises](/article/exercises/follow-me) and [temperature management exercises](/article/exercises/hvac) before starting this series.

##Exercise 1: Building an occupancy simulator and an alarm application.

Both alarm and occupancy simulation applications are two well known proactive/reactive systems for protection against system. 


<u>Question 1 - Alarm application</u>: Based on your previous experiences with building pervasive application, propose an architecture and implement an alarm application. To alert the administrator your alarm can be based on the lights (that you can turn on), the audio system (based on iCASA audio devices), or/and on an Android GUI (that you will develop).

Your system should be able to automatically turn on the alarm when all the users are leaving. You can also disable the system using the location service when legitimate users are entering the house. We assume that the system is able to distinguish between authorized/unauthorized users.


<u>Question 2 - Building an occupancy simulation application</u>: Propose an architecture and implement an application for simulating occupancy. The goal is to mimic the users activities by the turning your lights on and off just as if they were in the home.

To this end, it would be a good idea to reuse previously written services (e.g., room occupancy service). It would also be interesting to know which particular device is used at a given moment of the day. 

You can decouple the activation/deactivation of the occupancy simulation application by building a dedicated autonomic manager that will be able to activate/deactivate the application based on the presence of users. The same applied to the level of energy used by the simulation.

##Exercise 2: Collaboration of managers

The goal of this exercise is to enhance the management of energy by configuring each managers depending on the cost of energy per hours. This requires the collaboration of managers and can be done two ways:

+ hierarchically: you will use a central manager responsible for configuring the other managers and synchronizing their goals.
+ distributively: the managers will exchange some information to adapt their behaviors.

### Hierarchical approach

<u>Question 1 - Cost of energy:</u> Build an external service "EnergyCost" that provides the cost of energy in euros for 1 Watts/hours. Try to use realistic values: generally the cost of energy depends on the moment of the day and the period of year.

<u>Question 2 - Amount of available energy:</u> Based on the cost of energy, build an an autonomic manager (let's call it the general/top/platform manager) that will be able to estimate the cost of the current consumption of energy.

Then the manager should configure the different sub-managers (light/hvac/simulation/alarm managers) so that the global consumption does not exceed a given amount of energy (in watts / hour). This requires determining the amount of energy granted to each subsystem. 

The balance between subsystem (temperature vs light) has to be found and could be, for instance, based on priority. 
The administrator should be able to configure which subsystem has priority in case the amount of overall energy set does not allow to meet the objectives of the subsystems (e.g., in terms of temperature or illumination).In a more advanced implementation, the priority between subsystems should evolve depending on the condition of use and the period of day/year (e.g., day/night or summer/winter).

The manager must provide command line interface or GUI to configure the energy preferences. The preferences should be expressed in term of high-level goals (e.g., HIGH, MEDIUM, LOW) instead of precise value. These values should depend on the moment of the year/day and the cost of energy.

<u>Question 3 - Targeted price:</u> Change your implementation to:

+ provide a prediction of the energy consumption (and cost) based on the previous use (day/month). 
+ allow the configuration of a targeted price for a given period. The cost of consumed energy should not exceed (or should be closed to) the targeted value. Depending on the period (day/month), you will probably have to use prediction to be able to configure the targeted energy of each applications.

### Distributed approach
Based on what you have developed, try to propose a different architecture where the top-manager is no more necessary and where the different managers are able to take the cost of energy into accounts. This may involve collaboration between managers to determine which subsystem takes precedence over another.

##Exercise 3: Towards using utility functions

As an advanced problem, we suggest you to use utility functions to express the goals of the different managers you have already implemented. 

We suggest you to investigate the use of:

+ an utility function to map the illuminance with the satisfaction of users. Each user will provide a function describing its degree of satisfaction regarding a given temperature.  
+ an utility function to map the temperature with the satisfaction of users. Each user will provide a function describing its degree of satisfaction regarding a given temperature.  
+ an utility function describing the degree of satisfaction of the administrator regarding the consumed energy/the cost.

The goal is then to maximize the satisfaction of each users while maintaining an acceptable energy consumption. You will have to use priority between the different concerns to be able to match this goal.


</article>

{section_links}
