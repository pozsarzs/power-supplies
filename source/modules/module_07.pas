{ +--------------------------------------------------------------------------+ }
{ | Power Supplies v0.4.1 * Power supply calculator                          | }
{ | Copyright (C) 2011-2016 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | module_07.pas                                                            | }
{ | Module (static, fp unit - v0.3+)                                         | }
{ +--------------------------------------------------------------------------+ }

{
  Copyright (C) 2011-2016 Pozsar Zsolt

  This program is free software: you can redistribute it and/or modify
it under the terms of the European Union Public License version 1.1.

  This program is distributed WITHOUT ANY WARRANTY; without even the implied
warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
}

unit module_07;
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
  MODULE_ID='ps07';

Resourcestring
  // Module name
  MESSAGE01='Capacitive divider for serial heater circuit (AC 50Hz)';
  // Active elements
  // Input data
  MESSAGE02='Uin|V|input AC voltage';
  MESSAGE03='Uh|V|full heater voltage';
  MESSAGE04='Ih|A|heater current';
  // Output data
  MESSAGE05='C|uF|serial capacitor';
  // Messages
  MESSAGE06='Calculation error, please check values!';
  
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

Implementation

// Calculation
function Calculate: byte;
var
  // Active elements:
  // Input data:
  Uin, Uh, Ih: real;
  //Output data:
  C: real;
begin
 try
    Uin:=ValueDataIn[0];
    Uh:=ValueDataIn[1];
    Ih:=ValueDataIn[2];
    C:=(3180*Ih)/sqrt((Uin*Uin)-(Uh*Uh));
    ValueDataOut[0]:=C;
  except
    ValueDataOut[0]:=0;
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
  // Module name
  NameModule:=MESSAGE01;
  // Active elements
  // Input data
  NameDataIn[0]:=MESSAGE02;
  NameDataIn[1]:=MESSAGE03;
  NameDataIn[2]:=MESSAGE04;
  // Output data
  NameDataOut[0]:=MESSAGE05;
  // Error messages;
  ErrorMessages[0]:=MESSAGE06;
end.