<article markdown = "1">

# Introduction to services

The previous section we have seen how to implement a multilingual "Hello World" using properties. In this section we will re-implement it using services. The purpose of this section is to introduce :

+ what is a service. We already introduce the notion of service in the [introduction of iPOJO](?p=basic-hello-world&s=introduction). Here we give more details about the Service Oriented Programming. How services are provided and how services are discovered and used.
+ how to provide services using iCASA IDE.
+ how to use services in a iPOJO component.

## The concept of service

The notion of service in OSGi is almost the same notion than the service provided by business entities in the real world but in a much standard way. For instance when you go to your bank, your bank will offer you banking services (for instance to accessing your account, ...). 

To put it in the IT context:

{note}
A service is a piece of code that can be accessed in a standard way. It is defined by a **service specification**. This specification describes :

+ **how to interact with the service (the syntax)** : it defines the set of function you can call on the service. In the OSGi world the syntax is defined by a standard Java interface.
+ **some information on the provided service** : these are the service characteristics or properties. In the OSGi word the properties are provided as a Dictionary of (key,values). A Printing service may, for instance, have a location property that will be used to select the closest printer in the area. A spell checker may have a language property that will help finding a dictionary for a given language. 

{/note}

Like in the real word, there are service providers and service consumer. You are the consumer of the banking services provided by your bank. And likewise, there are different providers with different characteristics (interest rate, quality of service, ...). These providers advertised their services (via the yellow page or in the newspaper for instance) so that the consumer can discover and compare them(by phoning them or using internet).

In our context :

{note}
Services are :

+ **provided by service provider**. A provider will implement the specification of the service and declare the properties of the implementation accordingly. The implementation will be hidden to the consumer so that if the implementation change, there will be no consequence on the consumer.
+ **published (*"advertised"*) in a registry** : T
+ used by service consumer.

{/note}

</article>