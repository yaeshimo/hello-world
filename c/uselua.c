
// hello from lua!
// clang -l lua ./uselua.c

#include <stdio.h>

#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"

int
main(int argc, char* argv[]) {
  lua_State* L = luaL_newstate();
  // in lua do something

  // push lua stacks
  // lua_push...(lua_State*, type)
  lua_pushthread(L);
  lua_pushboolean(L, 1); // 1 == true
  lua_pushnumber(L, 10.45);
  lua_pushinteger(L, 3);
  lua_pushstring(L, "hello world");
  lua_pushnil(L);

  // get lua stacks
  int stackSize = lua_gettop(L);
  printf("stackSize=%d\n", stackSize);
  int i;
  for ( i = stackSize; i >= 1; i--) {
    int type = lua_type(L, i);
    printf("Stack[%2d-%10s] : ", i, lua_typename(L, type) );

    // use macro and lua_...(lua_State*, index);
    switch ( type ) {
      case LUA_TNIL:
        break;
      case LUA_TSTRING:
        printf("%s", lua_tostring(L, i));
        break;
      case LUA_TNUMBER:
        printf("%f", lua_tonumber(L, i) );
        break;
      case LUA_TBOOLEAN:
        printf("boolean %d", lua_toboolean(L, i) );
        break;
      default:
        printf("%s", lua_typename(L, type) );
        break;
    }

    printf("\n");
  }

  // stack is don't removing: 6
  printf("stackSize=%d\n", lua_gettop(L) );

  // stack manage: 4
  lua_settop(L, lua_gettop(L)-2 );
  printf("stackSize=%d\n", lua_gettop(L) );

  // keep index-2 that means lua_gettop(L)-1: 3
  lua_settop(L, -2);
  printf("stackSize=%d\n", lua_gettop(L) );

  // keep index: 3
  lua_settop(L, lua_gettop(L) );
  printf("stackSize=%d\n", lua_gettop(L) );

  // same: 3
  lua_settop(L, -1 );
  printf("stackSize=%d\n", lua_gettop(L) );

  // modify index to 0 that means all remove: 0
  lua_settop(L, 0 );
  printf("stackSize=%d\n",  0 );

  // use lua from C
  // accept use luas function on C
  luaL_openlibs(L);
  // open lua src: lua_pcall is call and run of lua scripts?
  printf("\n--- CALL LUA SRC BEGIN ---\n");
  fprintf(stderr, "state: ERROR: %s\n\n", lua_tostring(L, -1) );
  if( luaL_loadfile(L, "../lua/hello.lua") || lua_pcall(L, 0, 0, 0) ) {
    printf("can't open lua src\n");
    fprintf(stderr, "ERROR: %s\n", lua_tostring(L, -1) );
    return 1;
  }
  // pcall is don't accept call anymore: poped src
  printf("\nsecand call lua_pcall fail: %d\n", lua_pcall(L,0,0,0));
  fprintf(stderr, "ERROR: %s\n\n", lua_tostring(L, -1) );

  // one more
  printf("one more: OPEN THE LUA SRC\n");
  if( luaL_loadfile(L, "../lua/hello.lua") || lua_pcall(L, 0, 0, 0) ) {
    printf("can't open lua src\n");
    fprintf(stderr, "ERROR: %s\n", lua_tostring(L, -1) );
    return 1;
  }
  // error string is not clear: still staying
  // but second lua_loadfile to lua_pcall is not failing
  fprintf(stderr, "\n\nstate: ERROR: %s\n", lua_tostring(L, -1) );
  printf("\n--- CALL LUA SRC END ---\n");

  // lua_pcall(L, number of args from lua stack, number of results for put lua stack, int errfunc)
  // errfunc is maybe stack index to function* is to failback?

  // maybe:
  // loadfile(src.lua) to pcall(L,0,0,0) is append definition
  // if define function, then accept use here
  // just like in vim :source src ?
  // usage: add lua function to lua stack
  //      : add number of args to lua stack for lua function
  //      : add number of results to lua stack for return from lua function
  //      : add num errfunc
  //      : call lua_pcall(L, nargs, nresults, nerrfunc)
  //      : finally called lua function and append result to lua stack

  lua_close(L);
  return 0;
}
