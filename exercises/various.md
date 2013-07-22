<article markdown="1">

# Various Exercises

This section contains a set of various exercises that provides less guidance regarding the architecture and the implementation. In a first exercise, you will be propose to build an alarm and presence simulation application. 
Then in a second exercise, you will try to manager of managers. This top-manager will be responsible for managing the different applications on the platform. Finally, you will be asked to modify the follow-me application and the temperature manager to introduce utility functions so as to improve the management.

<img src="img/exercises/alarm_big.png" width = "60%"/>

The exercises are relatively independant but the complexity is progressive.
We assume that you have completed the set of [follow me exercises](/article/exercises/follow-me) and [temperature management exercises](/article/exercises/hvac) before starting this series.

##Exercise 1: Building an occupancy simulation and an alarm application.

Both alarm and occupancy simulation application are two well known proactive/reactive systems for protection against system. 


<u>Question 1 - Alarm application</u>: Based on your previous experiences with building pervasive application, propose an architecture and implement an alarm application. To alert the administrator your alarm can be based on the lights (that you can turn on), the audio system (based on iCASA audio devices), or/and on an Android GUI (that you will develop).

Your system should be able to automatically turn on the alarm when all the users are leaving. You can also disable the system using the location service when legitimate users are entering the house.


<u>Question 2 - Building an occupancy simulation application</u>: Propose an architecture and implement an application for simulating occupancy. The goal is to mimick the users activities by the turning your lights on and off just as if they were in the home.

To this end, it would be a good idea to reuse previously written services (e.g., room occupancy service). It would also be interesting to know which particular device is used at a given moment of the day. 

##Exercise 2: Manager's collaboration

##Exercise 3: Towards using utility functions

</article>

{section_links}
