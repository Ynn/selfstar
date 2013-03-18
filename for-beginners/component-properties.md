<article markdown = "1">
# Using component properties to configure instances

![Component properties]({#img#}/component-properties/logo.png)


In this section, we will introduce the notion of component properties. Properties are used to configure each instance and to separate the configuration from the code. 

This follows directly the previous section. You can continue your work or download the ["Hello World"]({#bin#}/hello-world/hello.world.zip) project to start.
We will try to use component properties to distinguish our instance. We will create a multilingual "Hello World" component that can use english or french depending on its lang property.

## Add a property to the component definition

Go to the "Component Definition" and add the property lang in the "Component Properties". Use the field *m_field* and the default value "en".

![Component properties]({#img#}/component-properties/newProperty.png)

{note}
**Difference between property field and property name**

When you create a new property, you have to give it a name and you can associate a field. 

The **property name** is the external name of the property. The name will be used when creating the instance. This is use whether using the GUI, in the metadata file that describe the component, or programmatically. The name is what the other developers will see when instantiating your component.

The **property field** is the internal representation of the property. This field belongs to your implementation class. When the component is instantiated, this field the value of the property will be injected. If no value is specified the default value will be used.

The Field and the name can be different. Here we follow the [Apache Felix guideline](http://felix.apache.org/site/coding-standards.html) by naming our prefixing our field name with *m_*. You are free to use your own convention.
{/note}

## Use the property in the code

Once again, the IDE can help you to generate the necessary code. As you have already created the HelloWorldImpl class, you will need to *synchronize* the class with the component definition.

Right-click on the component and select "Synchronize implementation class"

![Component properties]({#img#}/hello-world/Synchronize.png)

If you go to your class, you will see that a new field has been created :

{code lang=java}
	/** Injected field for the component property m_lang */
	private String m_lang;
{/code}

You can now use this field to change the message depending on the component instance configuration :

{code lang=java}
package org.example.hello;

public class HelloWorldImpl {

	/** Injected field for the component property m_lang */
	private String m_lang;

	/** Component Lifecycle Method */
	public void stop() {
		if("fr".equals(m_lang)){
			System.out.println("Au revoir le monde !");
		}else{
			System.out.println("Good bye World !");
		}
	}

	/** Component Lifecycle Method */
	public void start() {
		if("fr".equals(m_lang)){
			System.out.println("Bonjour le monde !");
		}else{
			System.out.println("Hello World !");
		}
	}
}
{/code}

## Configure the property for each instance

Go to your instance configuration and change the configuration of the one of the two instance you have created in your previous project (if you have only one instance create one).

In the first instance configure the property "lang" to "fr" as shown below :

![Component properties]({#img#}/component-properties/instanceConf.png)

This value will be injected when the instance is created.

Don't modify the second instance, the default value will be "en".


## Deploy and test

Now deploy your bundle and check that your two instance speak a different language :

{code lang=bash}
Bonjour le monde !
Hello World !
{/code}

As you can see, the first instance is configured to speak french and thus speaks Molière's tongue.
The second instance has a default "en" (english) value for the property lang and consequently speaks the Shakespeare ones.

## Conclusion

Properties provides an handy way to configure the different component instances. In the [next section](/article/for-beginners/intro-services) we will introduce the services and see how we could have implement this example using services.


</article>

<aside markdown="1">
### Download

+ The hello world lang [project]({#bin#}/hello-world/hello.world.lang.zip).
+ The hello world lang [bundle]({#bin#}/hello-world/hello.world.lang.jar).

</aside>