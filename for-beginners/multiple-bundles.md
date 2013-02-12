<article markdown="1">

#Building an application from multiple bundles

In the previous tutorial, you have learned how to provide and use services. All the services were provided and used by the same bundle. This has several drawbacks as you can not provide new services without redeploying and restarting the bundle. In this tutorial, you will learn how to use the bundles to separate providers from client.

We will use (at least) three bundles :

+ one bundle containing **the service interface**. This bundle will be the most stable as the service interface should not change too much.
+ one or two bundle containing **the providers**.
+ one bundle containing **the client**.

This way we will be able to change each bundle without restarting the whole application (so as to add new providers for instance).


## The specification bundle

## The english provider bundle

## The client bundle


</article>