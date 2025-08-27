# Arena Allocator for C

A fast, self-contained memory allocator. Implements a dynamic arena with an internal custom memory system.

## Features
- Dynamic memory blocks
- Bump-pointer allocation
- Reset without freeing
- Full release with one call so no more "damn, i forgot to free"
- Shared library support
- Unix platforms

## API

```c
#include "arena/arena.h"

arena_t arena;
void  arena_init(arena_t* arena, size_t block_size);
void* arena_alloc(arena_t* arena, size_t size);
void  arena_reset(arena_t* arena);
void  arena_free(arena_t* arena);
```

## Integration

Download the [pre-built](https://github.com/makestatic/carena/releases) library for your platform.  

Example with [clang](https://clang.llvm.org/) (works with gcc or others):
```sh
clang main.c \
  -I./x86_64-linux-gnu/include \
  -L./x86_64-linux-gnu -larenaallocator \
  -Wl,-rpath=./x86_64-linux-gnu \
  -o main
```

## License
[GPLv3 or later](LICENSE)

</br>
<sub>This project is for learning purposes. Not intended for production use.</sub>
