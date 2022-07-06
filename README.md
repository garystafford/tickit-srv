[![Quarkus Native CI](https://github.com/garystafford/tickit-srv/actions/workflows/build-test.yml/badge.svg)](https://github.com/garystafford/tickit-srv/actions/workflows/build-test.yml)

[![Quarkus Native Docker Build, Push, Deploy](https://github.com/garystafford/tickit-srv/actions/workflows/docker-build-push.yml/badge.svg)](https://github.com/garystafford/tickit-srv/actions/workflows/docker-build-push.yml)

# Quarkus Microservice Application Demonstration

Source code for the post [Building and Deploying Cloud-Native Quarkus Applications to Kubernetes](https://garystafford.medium.com/building-and-deploying-cloud-native-quarkus-applications-to-kubernetes-a4c494e3a843).

This project uses Quarkus, the 'Supersonic Subatomic Java' Framework.

If you want to learn more about Quarkus, please visit its website: https://quarkus.io/ .

## Running the application in dev mode

You can run your application in dev mode that enables live coding using:

```shell script
./gradlew quarkusDev
./gradlew --console=plain quarkusDev
```

> **_NOTE:_**  Quarkus now ships with a Dev UI, which is available in dev mode only at http://localhost:8080/q/dev/.

## Packaging and running the application

The application can be packaged using:

```shell script
./gradlew build
```

It produces the `quarkus-run.jar` file in the `build/quarkus-app/` directory.
Be aware that it’s not an _über-jar_ as the dependencies are copied into the `build/quarkus-app/lib/` directory.

The application is now runnable using `java -jar build/quarkus-app/quarkus-run.jar`.

If you want to build an _über-jar_, execute the following command:

```shell script
./gradlew build -Dquarkus.package.type=uber-jar
```

The application, packaged as an _über-jar_, is now runnable using `java -jar build/*-runner.jar`.

## Creating a native executable

You can create a native executable using:

```shell script
./gradlew build -Dquarkus.package.type=native
```

Or, if you don't have GraalVM installed, you can run the native executable build in a container using:

```shell script
./gradlew build -Dquarkus.package.type=native -Dquarkus.native.container-build=true
```

You can then execute your native executable with: `./build/tickit-srv-1.0.0-runner`

If you want to learn more about building native executables, please consult https://quarkus.io/guides/gradle-tooling.

## Related Guides

- Reactive PostgreSQL client ([guide](https://quarkus.io/guides/reactive-sql-clients)): Connect to the PostgreSQL
  database using the reactive pattern

## Provided Code

### RESTEasy Reactive

Easily start your Reactive RESTful Web Services

[Related guide section...](https://quarkus.io/guides/getting-started-reactive#reactive-jax-rs-resources)

---

<i>The contents of this repository represent my viewpoints and not of my past or current employers, including Amazon Web
Services (AWS). All third-party libraries, modules, plugins, and SDKs are the property of their respective owners. The author(s) assumes no responsibility or liability for any errors or omissions in the content of this site. The information contained in this site is provided on an "as is" basis with no guarantees of completeness, accuracy, usefulness or timeliness.</i>
