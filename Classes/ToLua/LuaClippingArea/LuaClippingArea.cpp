/*
** Lua binding: LuaClippingArea
** Generated automatically by tolua++-1.0.92 on 04/06/14 22:20:43.
*/

/****************************************************************************
 Copyright (c) 2011 cocos2d-x.org

 http://www.cocos2d-x.org

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 ****************************************************************************/

extern "C" {
#include "tolua_fix.h"
}




#include "cocos2d.h"
USING_NS_CC;
#include "LuaClippingArea.h"
#include "UI/ClippingArea/ClippingArea.h"

/* function to release collected object via destructor */
#ifdef __cplusplus

static int tolua_collect_ClippingArea (lua_State* tolua_S)
{
 ClippingArea* self = (ClippingArea*) tolua_tousertype(tolua_S,1,0);
    Mtolua_delete(self);
    return 0;
}

static int tolua_collect_CCRect (lua_State* tolua_S)
{
 CCRect* self = (CCRect*) tolua_tousertype(tolua_S,1,0);
    Mtolua_delete(self);
    return 0;
}

static int tolua_collect_CCSize (lua_State* tolua_S)
{
 CCSize* self = (CCSize*) tolua_tousertype(tolua_S,1,0);
    Mtolua_delete(self);
    return 0;
}
#endif


/* function to register type */
static void tolua_reg_types (lua_State* tolua_S)
{
 tolua_usertype(tolua_S,"ClippingArea");
 tolua_usertype(tolua_S,"CCNode");
 tolua_usertype(tolua_S,"CCSize");
 tolua_usertype(tolua_S,"CCRect");
}

/* method: create of class  ClippingArea */
#ifndef TOLUA_DISABLE_tolua_LuaClippingArea_ClippingArea_create00
static int tolua_LuaClippingArea_ClippingArea_create00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"ClippingArea",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  {
   ClippingArea* tolua_ret = (ClippingArea*)  ClippingArea::create();
    int nID = (tolua_ret) ? (int)tolua_ret->m_uID : -1;
    int* pLuaID = (tolua_ret) ? &tolua_ret->m_nLuaID : NULL;
    toluafix_pushusertype_ccobject(tolua_S, nID, pLuaID, (void*)tolua_ret,"ClippingArea");
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'create'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: create of class  ClippingArea */
#ifndef TOLUA_DISABLE_tolua_LuaClippingArea_ClippingArea_create01
static int tolua_LuaClippingArea_ClippingArea_create01(lua_State* tolua_S)
{
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"ClippingArea",0,&tolua_err) ||
     !tolua_isusertype(tolua_S,2,"CCNode",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
 {
  CCNode* stencil = ((CCNode*)  tolua_tousertype(tolua_S,2,0));
  {
   ClippingArea* tolua_ret = (ClippingArea*)  ClippingArea::create(stencil);
    int nID = (tolua_ret) ? (int)tolua_ret->m_uID : -1;
    int* pLuaID = (tolua_ret) ? &tolua_ret->m_nLuaID : NULL;
    toluafix_pushusertype_ccobject(tolua_S, nID, pLuaID, (void*)tolua_ret,"ClippingArea");
  }
 }
 return 1;
tolua_lerror:
 return tolua_LuaClippingArea_ClippingArea_create00(tolua_S);
}
#endif //#ifndef TOLUA_DISABLE

/* method: delete of class  ClippingArea */
#ifndef TOLUA_DISABLE_tolua_LuaClippingArea_ClippingArea_delete00
static int tolua_LuaClippingArea_ClippingArea_delete00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"ClippingArea",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  ClippingArea* self = (ClippingArea*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'delete'", NULL);
#endif
  Mtolua_delete(self);
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'delete'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: init of class  ClippingArea */
#ifndef TOLUA_DISABLE_tolua_LuaClippingArea_ClippingArea_init00
static int tolua_LuaClippingArea_ClippingArea_init00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"ClippingArea",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  ClippingArea* self = (ClippingArea*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'init'", NULL);
#endif
  {
   bool tolua_ret = (bool)  self->init();
   tolua_pushboolean(tolua_S,(bool)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'init'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: init of class  ClippingArea */
#ifndef TOLUA_DISABLE_tolua_LuaClippingArea_ClippingArea_init01
static int tolua_LuaClippingArea_ClippingArea_init01(lua_State* tolua_S)
{
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"ClippingArea",0,&tolua_err) ||
     !tolua_isusertype(tolua_S,2,"CCNode",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
 {
  ClippingArea* self = (ClippingArea*)  tolua_tousertype(tolua_S,1,0);
  CCNode* stencil = ((CCNode*)  tolua_tousertype(tolua_S,2,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'init'", NULL);
#endif
  {
   bool tolua_ret = (bool)  self->init(stencil);
   tolua_pushboolean(tolua_S,(bool)tolua_ret);
  }
 }
 return 1;
tolua_lerror:
 return tolua_LuaClippingArea_ClippingArea_init00(tolua_S);
}
#endif //#ifndef TOLUA_DISABLE

/* method: setStencil of class  ClippingArea */
#ifndef TOLUA_DISABLE_tolua_LuaClippingArea_ClippingArea_setStencil00
static int tolua_LuaClippingArea_ClippingArea_setStencil00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"ClippingArea",0,&tolua_err) ||
     !tolua_isusertype(tolua_S,2,"CCNode",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  ClippingArea* self = (ClippingArea*)  tolua_tousertype(tolua_S,1,0);
  CCNode* stencil = ((CCNode*)  tolua_tousertype(tolua_S,2,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'setStencil'", NULL);
#endif
  {
   self->setStencil(stencil);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'setStencil'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: getStencil of class  ClippingArea */
#ifndef TOLUA_DISABLE_tolua_LuaClippingArea_ClippingArea_getStencil00
static int tolua_LuaClippingArea_ClippingArea_getStencil00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"const ClippingArea",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  const ClippingArea* self = (const ClippingArea*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'getStencil'", NULL);
#endif
  {
   CCNode* tolua_ret = (CCNode*)  self->getStencil();
    tolua_pushusertype(tolua_S,(void*)tolua_ret,"CCNode");
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'getStencil'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: setClippingSize of class  ClippingArea */
#ifndef TOLUA_DISABLE_tolua_LuaClippingArea_ClippingArea_setClippingSize00
static int tolua_LuaClippingArea_ClippingArea_setClippingSize00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"ClippingArea",0,&tolua_err) ||
     (tolua_isvaluenil(tolua_S,2,&tolua_err) || !tolua_isusertype(tolua_S,2,"CCSize",0,&tolua_err)) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  ClippingArea* self = (ClippingArea*)  tolua_tousertype(tolua_S,1,0);
  CCSize size = *((CCSize*)  tolua_tousertype(tolua_S,2,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'setClippingSize'", NULL);
#endif
  {
   self->setClippingSize(size);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'setClippingSize'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: getClippingSize of class  ClippingArea */
#ifndef TOLUA_DISABLE_tolua_LuaClippingArea_ClippingArea_getClippingSize00
static int tolua_LuaClippingArea_ClippingArea_getClippingSize00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"ClippingArea",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  ClippingArea* self = (ClippingArea*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'getClippingSize'", NULL);
#endif
  {
   const CCSize tolua_ret = (const CCSize)  self->getClippingSize();
   {
#ifdef __cplusplus
    void* tolua_obj = Mtolua_new((CCSize)(tolua_ret));
     tolua_pushusertype(tolua_S,tolua_obj,"const CCSize");
    tolua_register_gc(tolua_S,lua_gettop(tolua_S));
#else
    void* tolua_obj = tolua_copy(tolua_S,(void*)&tolua_ret,sizeof(const CCSize));
     tolua_pushusertype(tolua_S,tolua_obj,"const CCSize");
    tolua_register_gc(tolua_S,lua_gettop(tolua_S));
#endif
   }
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'getClippingSize'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: convertStencilToWorldRect of class  ClippingArea */
#ifndef TOLUA_DISABLE_tolua_LuaClippingArea_ClippingArea_convertStencilToWorldRect00
static int tolua_LuaClippingArea_ClippingArea_convertStencilToWorldRect00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"ClippingArea",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  ClippingArea* self = (ClippingArea*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'convertStencilToWorldRect'", NULL);
#endif
  {
   const CCRect tolua_ret = (const CCRect)  self->convertStencilToWorldRect();
   {
#ifdef __cplusplus
    void* tolua_obj = Mtolua_new((CCRect)(tolua_ret));
     tolua_pushusertype(tolua_S,tolua_obj,"const CCRect");
    tolua_register_gc(tolua_S,lua_gettop(tolua_S));
#else
    void* tolua_obj = tolua_copy(tolua_S,(void*)&tolua_ret,sizeof(const CCRect));
     tolua_pushusertype(tolua_S,tolua_obj,"const CCRect");
    tolua_register_gc(tolua_S,lua_gettop(tolua_S));
#endif
   }
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'convertStencilToWorldRect'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: setClippingEnabled of class  ClippingArea */
#ifndef TOLUA_DISABLE_tolua_LuaClippingArea_ClippingArea_setClippingEnabled00
static int tolua_LuaClippingArea_ClippingArea_setClippingEnabled00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"ClippingArea",0,&tolua_err) ||
     !tolua_isboolean(tolua_S,2,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  ClippingArea* self = (ClippingArea*)  tolua_tousertype(tolua_S,1,0);
  bool enabled = ((bool)  tolua_toboolean(tolua_S,2,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'setClippingEnabled'", NULL);
#endif
  {
   self->setClippingEnabled(enabled);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'setClippingEnabled'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: isClipping of class  ClippingArea */
#ifndef TOLUA_DISABLE_tolua_LuaClippingArea_ClippingArea_isClipping00
static int tolua_LuaClippingArea_ClippingArea_isClipping00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"ClippingArea",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  ClippingArea* self = (ClippingArea*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'isClipping'", NULL);
#endif
  {
   bool tolua_ret = (bool)  self->isClipping();
   tolua_pushboolean(tolua_S,(bool)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'isClipping'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: visit of class  ClippingArea */
#ifndef TOLUA_DISABLE_tolua_LuaClippingArea_ClippingArea_visit00
static int tolua_LuaClippingArea_ClippingArea_visit00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"ClippingArea",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  ClippingArea* self = (ClippingArea*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'visit'", NULL);
#endif
  {
   self->visit();
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'visit'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: beforeDraw of class  ClippingArea */
#ifndef TOLUA_DISABLE_tolua_LuaClippingArea_ClippingArea_beforeDraw00
static int tolua_LuaClippingArea_ClippingArea_beforeDraw00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"ClippingArea",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  ClippingArea* self = (ClippingArea*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'beforeDraw'", NULL);
#endif
  {
   self->beforeDraw();
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'beforeDraw'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: afterDraw of class  ClippingArea */
#ifndef TOLUA_DISABLE_tolua_LuaClippingArea_ClippingArea_afterDraw00
static int tolua_LuaClippingArea_ClippingArea_afterDraw00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"ClippingArea",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  ClippingArea* self = (ClippingArea*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'afterDraw'", NULL);
#endif
  {
   self->afterDraw();
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'afterDraw'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* Open function */
TOLUA_API int tolua_LuaClippingArea_open (lua_State* tolua_S)
{
 tolua_open(tolua_S);
 tolua_reg_types(tolua_S);
 tolua_module(tolua_S,NULL,0);
 tolua_beginmodule(tolua_S,NULL);
  #ifdef __cplusplus
  tolua_cclass(tolua_S,"ClippingArea","ClippingArea","CCNode",tolua_collect_ClippingArea);
  #else
  tolua_cclass(tolua_S,"ClippingArea","ClippingArea","CCNode",NULL);
  #endif
  tolua_beginmodule(tolua_S,"ClippingArea");
   tolua_function(tolua_S,"create",tolua_LuaClippingArea_ClippingArea_create00);
   tolua_function(tolua_S,"create",tolua_LuaClippingArea_ClippingArea_create01);
   tolua_function(tolua_S,"delete",tolua_LuaClippingArea_ClippingArea_delete00);
   tolua_function(tolua_S,"init",tolua_LuaClippingArea_ClippingArea_init00);
   tolua_function(tolua_S,"init",tolua_LuaClippingArea_ClippingArea_init01);
   tolua_function(tolua_S,"setStencil",tolua_LuaClippingArea_ClippingArea_setStencil00);
   tolua_function(tolua_S,"getStencil",tolua_LuaClippingArea_ClippingArea_getStencil00);
   tolua_function(tolua_S,"setClippingSize",tolua_LuaClippingArea_ClippingArea_setClippingSize00);
   tolua_function(tolua_S,"getClippingSize",tolua_LuaClippingArea_ClippingArea_getClippingSize00);
   tolua_function(tolua_S,"convertStencilToWorldRect",tolua_LuaClippingArea_ClippingArea_convertStencilToWorldRect00);
   tolua_function(tolua_S,"setClippingEnabled",tolua_LuaClippingArea_ClippingArea_setClippingEnabled00);
   tolua_function(tolua_S,"isClipping",tolua_LuaClippingArea_ClippingArea_isClipping00);
   tolua_function(tolua_S,"visit",tolua_LuaClippingArea_ClippingArea_visit00);
   tolua_function(tolua_S,"beforeDraw",tolua_LuaClippingArea_ClippingArea_beforeDraw00);
   tolua_function(tolua_S,"afterDraw",tolua_LuaClippingArea_ClippingArea_afterDraw00);
  tolua_endmodule(tolua_S);
 tolua_endmodule(tolua_S);
 return 1;
}


#if defined(LUA_VERSION_NUM) && LUA_VERSION_NUM >= 501
 TOLUA_API int luaopen_LuaClippingArea (lua_State* tolua_S) {
 return tolua_LuaClippingArea_open(tolua_S);
};
#endif

