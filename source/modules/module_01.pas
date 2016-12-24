{ +--------------------------------------------------------------------------+ }
{ | Power Supplies v0.4.1 * Power supply calculator                          | }
{ | Copyright (C) 2011-2016 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | LC-circuits v0.4.1 * LC-circuits                                         | }
{ | Copyright (C) 2011-2016 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | module_01.pas                                                            | }
{ | Module (static, fp unit - v0.3+)                                         | }
{ +--------------------------------------------------------------------------+ }

{
  Copyright (C) 2011-2016 Pozsar Zsolt

  This program is free software: you can redistribute it and/or modify
it under the terms of the European Union Public License version 1.1.

  This program is distributed WITHOUT ANY WARRANTY; without even the implied
warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
}

unit module_01;
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
  MODULE_ID='lc01';                                                 // Module ID

Resourcestring
  // Module name
  MESSAGE01='Collins-filter';
  // Input data
  MESSAGE02='Z1|kΩ|input impedance';
  MESSAGE03='Z2|kΩ|output impedance';
  MESSAGE04='f|MHz|frequency';
  MESSAGE05='Q| |quality factor';
  // Output data
  MESSAGE06='C1|pF|capacitor';
  MESSAGE07='C2|pF|capacitor';
  MESSAGE08='L|µH|inductor';
  MESSAGE09='Calculation error, please check values!';

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
  // Input data:
  z1, z2, f, q,
  // Output data:
  c1, c2, l: real;
begin
  try
    // Input data:
    z1:=ValueDataIn[0];
    z2:=ValueDataIn[1];
    if not (z1>=z2) then
    begin
      ErrorCode:=1;
      Result:=ErrorCode;
      exit;
    end;
    f:=ValueDataIn[2];
    q:=ValueDataIn[3];
    
    if q=0 then q:=12;
    c1:=2000/(z1*f);
    c2:=c1/sqrt(z1/z2);
    if (z1>=10*z2) and (q>=10)
      then l:=((13*z1)/f)+((z1*c1*sqrt(z1*z2))/145)
      else l:=((q*z1)+(2*pi*f*c2*z1*z2))/(2*pi*f*((q*q)+1));
    // Output data:
    ValueDataOut[0]:=c1;
    ValueDataOut[1]:=c2;
    ValueDataOut[2]:=l;
  except
    ValueDataOut[0]:=0;
    ValueDataOut[1]:=0;
    ValueDataOut[2]:=0;
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
  // Module name:
  NameModule:=MESSAGE01;
  // Input data:
  NameDataIn[0]:=MESSAGE02;
  NameDataIn[1]:=MESSAGE03;
  NameDataIn[2]:=MESSAGE04;
  NameDataIn[3]:=MESSAGE05;
  // Output data:
  NameDataOut[0]:=MESSAGE06;
  NameDataOut[1]:=MESSAGE07;
  NameDataOut[2]:=MESSAGE08;
  // Error messages:
  ErrorMessages[0]:=MESSAGE09;
end.
