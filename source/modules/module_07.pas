{ +--------------------------------------------------------------------------+ }
{ | Power Supplies v0.4.1 * Power supply calculator                          | }
{ | Copyright (C) 2011-2016 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | LC-circuits v0.4.1 * LC-circuits                                         | }
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
  MODULE_ID='lc07';                                                 // Module ID

Resourcestring
  MESSAGE01='Two way crossover filter #5';
  MESSAGE02='f|kHz|crossover frequency';
  MESSAGE03='Z|Ω|impedance';
  MESSAGE04='C1|µF|capacitor';
  MESSAGE05='C1|µF|capacitor';
  MESSAGE06='C2|µF|capacitor';
  MESSAGE07='C3|µF|capacitor';
  MESSAGE08='L1|µH|inductor';
  MESSAGE09='L2|µH|inductor';
  MESSAGE10='L3|µH|inductor';
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

implementation

// Calculation
function Calculate: byte;var
  z, f, c1, c2, c3, l1, l2, l3: real;
begin
  try
    z:=ValueDataIn[1];
    f:=ValueDataIn[0]*1000;

    c1:=2/(2*pi*f*z);
    c2:=(1/1.6)*(1/(2*pi*f*z));
    c3:=1/(2*pi*f*z);
    l1:=(1.6*z)/(2*pi*f);
    l2:=z/(2*pi*f);
    l3:=z/(4*pi*f);

    ValueDataOut[0]:=c1*1000000;
    ValueDataOut[1]:=c2*1000000;
    ValueDataOut[2]:=c3*1000000;
    ValueDataOut[3]:=l1*1000000;
    ValueDataOut[4]:=l2*1000000;
    ValueDataOut[5]:=l3*1000000;
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
  NameModule:=MESSAGE01;
  NameDataIn[0]:=MESSAGE02;
  NameDataIn[1]:=MESSAGE03;
  NameDataOut[0]:=MESSAGE04;
  NameDataOut[1]:=MESSAGE06;
  NameDataOut[2]:=MESSAGE07;
  NameDataOut[3]:=MESSAGE08;
  NameDataOut[4]:=MESSAGE09;
  NameDataOut[5]:=MESSAGE10;
  ErrorMessages[0]:=MESSAGE11;
end.
