// ✅ Set the build directory path correctly (as File)
rootProject.buildDir = file("../build")

buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath("com.google.gms:google-services:4.3.10")
        classpath("com.android.tools.build:gradle:7.3.1")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// ✅ Configure subprojects build directory properly
subprojects {
    project.buildDir = file("${rootProject.buildDir}/${project.name}")
    project.evaluationDependsOn(":app")
}
plugins {
  // ...

  // Add the dependency for the Google services Gradle plugin
  id("com.google.gms.google-services") version "4.4.4" apply false

}

// ✅ Clean task
tasks.register<Delete>("clean") {
    delete(rootProject.buildDir)
}