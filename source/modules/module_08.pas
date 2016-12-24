{ +--------------------------------------------------------------------------+ }
{ | Power Supplies v0.4.1 * Power supply calculator                          | }
{ | Copyright (C) 2011-2016 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | module_08.pas                                                            | }
{ | Module (static, fp unit - v0.3+)                                         | }
{ +--------------------------------------------------------------------------+ }

{
  Copyright (C) 2011-2016 Pozsar Zsolt

  This program is free software: you can redistribute it and/or modify
it under the terms of the European Union Public License version 1.1.

  This program is distributed WITHOUT ANY WARRANTY; without even the implied
warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
}

unit module_08;
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
  MODULE_ID='ps08';

Resourcestring
  // Module name
  MESSAGE01='Voltage regulator with Zener-diode';
  // Active elements
  MESSAGE02='D1|Uz|V|Zener voltage';
  MESSAGE03='D1|Izmin|mA|minimal Zener current';
  MESSAGE04='D1|Izmax|mA|maximal Zener current';
  // Input data
  MESSAGE05='Uinmin|V|minimal input voltage';
  MESSAGE06='Uinmax|V|maximal input voltage';
  MESSAGE07='Ioutmin|mA|minimal output current';
  MESSAGE08='Ioutmax|mA|maximal output current';
  // Output data
  MESSAGE09='Rbmin|kΩ|minimal ballast resistor';
  MESSAGE10='Rbmax|kΩ|maximal ballast resistor';
  // Messages
  MESSAGE11='Calculation error, please check values!';
  
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
  D1Uz, D1Izmin, D1Izmax: real;
  // Input data:
  Uinmin, Uinmax, Ioutmin, Ioutmax: real;
  //Output data:
  Rbmin, Rbmax: real;
begin
  try
    D1Uz:=ValueActiveElements[0];
    D1Izmin:=ValueActiveElements[1];
    D1Izmax:=ValueActiveElements[2];
    Uinmin:=ValueDataIn[0];
    Uinmax:=ValueDataIn[1];
    Ioutmin:=ValueDataIn[2];
    Ioutmax:=ValueDataIn[3];
    Rbmin:=(Uinmax-D1Uz)/(D1Izmax+Ioutmin);
    Rbmax:=(Uinmin-D1Uz)/(D1Izmin+Ioutmax);
    ValueDataOut[0]:=Rbmin;
    ValueDataOut[1]:=Rbmax;
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
  // Module name
  NameModule:=MESSAGE01;
  // Active elements
  NameActiveElements[0]:=MESSAGE02;
  NameActiveElements[1]:=MESSAGE03;
  NameActiveElements[2]:=MESSAGE04;
  // Input data
  NameDataIn[0]:=MESSAGE05;
  NameDataIn[1]:=MESSAGE06;
  NameDataIn[2]:=MESSAGE07;
  NameDataIn[3]:=MESSAGE08;
  // Output data
  NameDataOut[0]:=MESSAGE09;
  NameDataOut[1]:=MESSAGE10;
  // Error messages;
  ErrorMessages[0]:=MESSAGE11;
end.
