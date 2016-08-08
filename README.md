# docker-rust-emscripten

Dockerfile for rust-emscripten image

# Compiling Rust to JS

```
docker run -v `pwd`:/work likr/rust-emscripten rustc --target=asmjs-unknown-emscripten hello.rs
```

# Building image

```
git clone https://github.com/likr/docker-rust-emscripten.git
cd docker-rust-emscripten
docker build -t my-rust-emscripten .
```
