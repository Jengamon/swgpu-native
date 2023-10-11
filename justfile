jextract := "jextract/build/jextract/bin/jextract"
prefix := if os_family() == "unix" { "lib" } else { "" }
ext := if os() == "linux" { "so" } else if os() == "macos" { "dylib" } else if os() == "windows" { "dll" } else {"XXX"}
library := prefix + "wgpu_native." + ext

setup:
    git submodule update --init --recursive

extract: setup
    {{jextract}} --source -t io.github.jengamon.swgpu wgpu-native/ffi/webgpu-headers/webgpu.h
    {{jextract}} --source -t io.github.jengamon.swgpu wgpu-native/ffi/wgpu.h

build: extract
    cd wgpu-native && cargo build

build-release: extract
    cd wgpu-native && cargo build --release

package: build
    zip -r pkg.zip io wgpu-native/target/debug/{{library}}

package-release: build
    zip -r pkg-release.zip io wgpu-native/target/release/{{library}}

# Manually upgrade the jextract/gradle/gradle.properties for now
jextract jdk_version jdk_home llvm_home:
    cd jextract && sh ./gradlew -Pjdk{{jdk_version}}_home={{jdk_home}} -Pllvm_home={{llvm_home}} clean verify
