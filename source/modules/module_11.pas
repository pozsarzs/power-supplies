{ +--------------------------------------------------------------------------+ }
{ | Power Supplies v0.4.1 * Power supply calculator                          | }
{ | Copyright (C) 2011-2016 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | module_11.pas                                                            | }
{ | Module (static, fp unit - v0.3+)                                         | }
{ +--------------------------------------------------------------------------+ }

{
  Copyright (C) 2011-2016 Pozsar Zsolt

  This program is free software: you can redistribute it and/or modify
it under the terms of the European Union Public License version 1.1.

  This program is distributed WITHOUT ANY WARRANTY; without even the implied
warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
}

unit module_11;
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
  MODULE_ID='ps11';

Resourcestring
  // Module name
  MESSAGE01='Current regulator with LM117/LM317/LM237/LM337 integrated circuit';
  // Active elements
  // Input data
  MESSAGE02='Iout|mA|maximal output current';
  // Output data
  MESSAGE03='R|Ω|resistor';
  // Messages
  MESSAGE04='Calculation error, please check values!';
  MESSAGE05='R must not be less than 0.8 Ω!';
  MESSAGE06='R must not be more than 120 Ω!';
  
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
  Iout: real;
  //Output data:
  R: real;
begin
  try
    Iout:=ValueDataIn[0];
    R:=1.25/(Iout/1000);
	if R<0.8 then
    begin
      ErrorCode:=2;
      Result:=ErrorCode;
      exit;
    end; 
	if R>120 then
    begin
      ErrorCode:=2;
      Result:=ErrorCode;
      exit;
    end; 
    ValueDataOut[0]:=R;
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
  // Output data
  NameDataOut[0]:=MESSAGE03;
  // Error messages;
  ErrorMessages[0]:=MESSAGE04;
  ErrorMessages[1]:=MESSAGE05;
  ErrorMessages[2]:=MESSAGE06;
end.
