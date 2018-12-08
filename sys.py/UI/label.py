# -*- coding: utf-8 -*- 

import pygame

#import base64
#from beeprint import pp
from constants import Width,Height
from util_funcs  import midRect

#UI lib
from skin_manager import MySkinManager
from lang_manager import MyLangManager

class Label:
    _PosX=0
    _PosY=0
    _Width=0
    _Height=0
    _Text=""
    _FontObj=None
    _Color = MySkinManager.GiveColor('Text')
    _CanvasHWND = None
    _TextSurf = None
    def __init__(self):
        pass
    
    def Init(self, text, font_obj, color=MySkinManager.GiveColor('Text')):
        self._Color = color
        self._FontObj = font_obj
        self._Text = text

        my_text = self._FontObj.render(self._Text,True,self._Color)
        self._Width = my_text.get_width()
        self._Height = my_text.get_height()

    def NewCoord(self,x,y):
        self._PosX = x
        self._PosY = y
        
    def SetColor(self,color):
        self._Color = color
    
    def GetText(self):
        return self._Text
    
    def SetText(self,text):
        self._Text = text
        
        my_text = self._FontObj.render(self._Text,True,self._Color)
        self._Width = my_text.get_width()
        self._Height = my_text.get_height()

    def Width(self):
        return self._Width
    
    def SetCanvasHWND(self,_canvashwnd):
        self._CanvasHWND = _canvashwnd

    def DrawCenter(self,bold=False):
        self._FontObj.set_bold(bold) ## avoing same font tangling set_bold to others
        my_text = self._FontObj.render( self._Text,True,self._Color)        
        self._CanvasHWND.blit(my_text,midRect(self._PosX,self._PosY,self._Width,self._Height,Width,Height))
        
    def Draw(self,bold=False):
        self._FontObj.set_bold(bold) ## avoing same font tangling set_bold to others
        my_text = self._FontObj.render( self._Text,True,self._Color)
        
        self._CanvasHWND.blit(my_text,(self._PosX,self._PosY,self._Width,self._Height))
