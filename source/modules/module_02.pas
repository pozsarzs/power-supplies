{ +--------------------------------------------------------------------------+ }
p
{ | Power Supplies v0.4.1 * Power supply calculator                          | }
{ | Copyright (C) 2011-2016 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | LC-circuits v0.4.1 * LC-circuits                                         | }
{ | Copyright (C) 2011-2016 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | module_02.pas                                                            | }
{ | Module (static, fp unit - v0.3+)                                         | }
{ +--------------------------------------------------------------------------+ }

{
  Copyright (C) 2011-2016 Pozsar Zsolt

  This program is free software: you can redistribute it and/or modify
it under the terms of the European Union Public License version 1.1.

  This program is distributed WITHOUT ANY WARRANTY; without even the implied
warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
}

unit module_02;
{$MODE OBJFPC}{$H+}

interface
var
  NameModule: string;                                          // Name of module
  ValueActiveElements: array[0..15] of real;    // Parameters of active elements
  ValueDataIn: array[0..15] of real;                           // Initial values
  ValueDataOut: array[0..15] of real;                           // Result values
  NameActiveElements: array[0..15] of string;           // Description of values
  NameDataIn: array[0..15] of string;                   // Description of values
  NameDataOut: array[0..15] of string;                  // Description of values
  ErrorCode: byte;                                          // Actual error code
  ErrorMessages: array[0..15] of string;                       // Error messages
  HowToSetLinkActive: boolean;            //Enable/disable "How to set it?" link
const
  MODULE_ID='lc02';                                                 // Module ID

Resourcestring
  MESSAGE01='Seefried impedance transformer';
  MESSAGE02='Z1|Ω|input impedance';
  MESSAGE03='Z2|Ω|output impedance';
  MESSAGE04='f|MHz|frequency';
  MESSAGE05='C|pF|capacitor';
  MESSAGE06='L|µH|inductors';
  MESSAGE07='Calculation error, please check values!';
    
function GetName: string;
function GetID: string;
procedure SetActiveElements(num: byte; value: real);
procedure SetDataIn(num: byte; value: real);
function GetDataOut(num: byte): real;
function GetNameActiveElements(num: byte): string;
function GetNameDataIn(num: byte): string;
function GetNameDataOut(num: byte): string;
function GetErrorMessage(num: byte): string;
function GetErrorCode: byte;
function GetHowToSetLinkActive: boolean;
function Calculate: byte;

implementation

// Calculation
function Calculate: byte;
var
  z1, z2, ztr, f, c, l: real;
begin
  try
    z1:=ValueDataIn[0];
    z2:=ValueDataIn[1];
    f:=ValueDataIn[2];
    
    ztr:=sqrt(z1*z2);
    l:=ztr/(2*pi*f);
    c:=1000000/(2*pi*f*ztr);
	
    ValueDataOut[0]:=c;
    ValueDataOut[1]:=l;
  except
    ValueDataOut[0]:=0;
    ValueDataOut[1]:=0;
    ErrorCode:=1;
    Result:=ErrorCode;
    exit;
  end;
  ErrorCode:=0;
  Result:=ErrorCode;
end;

{$I module_commonproc.inc}

initialization
  ErrorCode:=0;
  HowToSetLinkActive:=false;
  NameModule:=MESSAGE01;
  NameDataIn[0]:=MESSAGE02;
  NameDataIn[1]:=MESSAGE03;
  NameDataIn[2]:=MESSAGE04;
  NameDataOut[0]:=MESSAGE05;
  NameDataOut[1]:=MESSAGE06;
  ErrorMessages[0]:=MESSAGE07;
end.
