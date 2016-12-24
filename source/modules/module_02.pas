{ +--------------------------------------------------------------------------+ }
{ | Power Supplies v0.4.1 * Power supply calculator                          | }
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
  MODULE_ID='ps02';

Resourcestring
  // Module name
  MESSAGE01='Full wave rectifier';
  // Active elements
  // Input data
  MESSAGE02='Uout|V|output voltage';
  MESSAGE03='Iout|A|output current';
  MESSAGE04='fin|Hz|freq. of input voltage';
  // Output data
  MESSAGE05='Us|V|secunder voltage';
  MESSAGE06='Is|A|secunder current';
  MESSAGE07='Ur|V|diode reverse voltage';
  MESSAGE08='If|A|diode forward current';
  MESSAGE09='Uh|V|humming voltage';
  MESSAGE10='fh|Hz|humming frequency';
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
  // Input data:
  Uout, Iout, fin: real;
  //Output data:
  Us, Iss, Ur, Iff, Uh, fh: real;
begin
 try
    Uout:=ValueDataIn[0];
    Iout:=ValueDataIn[1];
    fin:=ValueDataIn[2];
    fh:=2*fin;
    Uh:=0.481*Uout;
    Us:=1.11*Uout*1.15;
    Ur:=2*Us*sqrt(2);
    Iff:=0.5*Iout;
    Iss:=0.787*Iout;
    ValueDataOut[0]:=Us;
    ValueDataOut[1]:=Iss;
    ValueDataOut[2]:=Ur;
    ValueDataOut[3]:=Iff;
    ValueDataOut[4]:=Uh;
    ValueDataOut[5]:=fh;
  except
    ValueDataOut[0]:=0;
    ValueDataOut[1]:=0;
    ValueDataOut[2]:=0;
    ValueDataOut[3]:=0;
    ValueDataOut[4]:=0;
    ValueDataOut[5]:=0;
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
  NameDataOut[1]:=MESSAGE06;
  NameDataOut[2]:=MESSAGE07;
  NameDataOut[3]:=MESSAGE08;
  NameDataOut[4]:=MESSAGE09;
  NameDataOut[5]:=MESSAGE10;
  // Error messages;
  ErrorMessages[0]:=MESSAGE11;
end.
