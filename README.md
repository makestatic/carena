# Arena Allocator in C

A fast, lightweight, self-contained, and easy to integrate arena memory allocator.

## Features
- Dynamic memory blocks
- Bump-pointer allocation
- Reset the arena without freeing each allocation
- Full release with one call — no more “damn, I forgot to free”
- Shared library support


**Supported platforms:** _Unix-based systems only for now_.


## API

```c
#include "arena/arena.h"

arena_t arena;
void  arena_init(arena_t* arena, size_t block_size);
void* arena_alloc(arena_t* arena, size_t size);
void  arena_reset(arena_t* arena);
void  arena_free(arena_t* arena);
```

## Usage

### Downloading
Download the prebuilt shared library for your platform from [releases](https://github.com/makestatic/carena/releases).

### Compiling
Works with [clang](https://clang.llvm.org/), [gcc](https://gcc.gnu.org/), or any other C compiler:

```sh
clang \
    -I./carena-aarch64-linux-gnu/include \
    -L./carena-aarch64-linux-gnu \
    -Wl,-rpath,'$ORIGIN/carena-aarch64-linux-gnu' \
    -o main main.c -larenaallocator
```

## License
[GPLv3](LICENSE)

</br>
<sub>This project is for learning purposes. Not intended for production use.</sub>
