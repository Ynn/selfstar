<article markdown = "1">

# DRAFT

## Bundle Lifecycle :

Bundle have a lifecycle, that means they can change states during their lifetime. The 

![lifecycle]({#img#}/intro-runtime/lifecycle.png)


Let's see briefly the different states of a bundle :

+ INSTALLED : 




{note}
Installation and deployment in our context : 

+ **deployment** : in our context, that only involve copying or uploading the bundle to a directory that the iCASA runtime can access. Deployment is a far more [complex activity](https://en.wikipedia.org/wiki/Software_deployment) that often involves predicting and downloading all the necessary modules before installation. A real deployment system is provided by the [OBR](http://felix.apache.org/site/apache-felix-osgi-bundle-repository.html), a subproject of FELIX. We will not use it for our projects as the number of bundles involved will be limited.
+ **installation** : during the install process the framework will attempt to resolve/check the bundle dependencies. It all the dependencies are available, the bundle state will be RESOLVED and UNREVOLVED if not.
{/note}

</article>
