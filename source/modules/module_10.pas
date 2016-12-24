{ +--------------------------------------------------------------------------+ }
{ | Power Supplies v0.4.1 * Power supply calculator                          | }
{ | Copyright (C) 2011-2016 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | module_10.pas                                                            | }
{ | Module (static, fp unit - v0.3+)                                         | }
{ +--------------------------------------------------------------------------+ }

{
  Copyright (C) 2011-2016 Pozsar Zsolt

  This program is free software: you can redistribute it and/or modify
it under the terms of the European Union Public License version 1.1.

  This program is distributed WITHOUT ANY WARRANTY; without even the implied
warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
}

unit module_10;
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
  MODULE_ID='ps10';

Resourcestring
  // Module name
  MESSAGE01='Voltage regulator with LM117/LM317/LM237/LM337 integrated circuit';
  // Active elements
  // Input data
  MESSAGE02='R1|Ω|resistor, typically 240 Ω';
  MESSAGE03='R2|Ω|resistor';
  // Output data
  MESSAGE04='Uout|V|output voltage';
  // Messages
  MESSAGE05='Calculation error, please check values!';
  
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
  R1, R2: real;
  //Output data:
  Uout: real;
begin
  try
    R1:=ValueDataIn[0];
    R2:=ValueDataIn[1];
    Uout:=1.25*(1+(R2/R1))+(R2*0.00005);
    ValueDataOut[0]:=Uout;
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
  // Output data
  NameDataOut[0]:=MESSAGE04;
  // Error messages;
  ErrorMessages[0]:=MESSAGE05;
end.
