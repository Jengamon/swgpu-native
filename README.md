# swgpu

A lame attempt at some Project Panama bindings to wgpu-native
for Java (where my real goal is Scala, thus the name).

To generate the bindings:
1. run `just setup` to get the submodules
2. go into jextract and edit gradle to match a compatible version for your JVM
3. run `just jextract` (with JVM version, JDK home, and LLVM home) to create the jextract tool
4. run `just package` to generate the bindings, build the library, and get it all in a nice zip file ig