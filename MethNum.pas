unit MethNum;

interface

uses
  Math, readf0nd;

const
  {�������� �������� ����� (���/�)}
  EARTH_ROT_SPEED = 2*PI/86400;

  {������ ����� � ��}
  EARTH_RAD = 6371;

  {����������� ����� (��������� ���)}
  STANDRD_ERA = 2451545.0;

  {��������� �����, ��� �������� ��������� �������}
  EPS = 10E-12;

  {���-�� ���������� � 1 �.�.}
  AU_KM = 1.49597870691E+8;

  {��������� ��� �������� �������� � ������� � �������}
  RAD = PI/180.0;

  {������ ��������� � �������� (�������)}
  ECL_EQ = 84381.412/3600*rad;


  MU = 2.9591220828559110225E-4;

type
  {�������� ������ ����������: a,e,i,Om,w,v}
  ElementsOfOrbit = record
    a,e,i,Om,w,v: extended;
  end;

  {��������� ���������� � �������� ����������: X,Y,Z,Vx,Vy,Vz}
  DacartCoords = record
    X,Y,Z,Vx,Vy,Vz: extended;
  end;


  {��������������� ��� ������ ��� ���� � �������}
  DateTime = record
    day,month,year,hour,minute: integer;
    second: extended;
  end;

  {�������������� ���������� (������ �����������, ���������)}
  EquatorCoords = record
    alpha,delta: extended;
  end;

  {�������������� ���������� (������, ������ ��� ����������)}
  HorizontalCoords = record
    Az,h: extended;
  end;

  {������������� ���������� (������� � ������)}
  EclipticCoords = record
    lamda,betta: extended;
  end;

  {�������������� ���������� (������� � ������)}
  GeogrCoords = record
    long,lat: extended;
  end;


{========================================================
���� �������� � ������� ��� ������������� � �����.

��� ������������� ���� ��������� ���� ��������� �����������
���������� .emeth � .cmeth, ����� �������� �������� �����������������
�������, �� ����, ������ ������ � ������������ ������� ���
���������� ��������� �����.

.emeth ������ � ���� �������� ������ ������� � ������ ������
� ��������� �������: a,e,i,Om,w,v.
.cmeth ������ � ���� ���������� � �������� � ������ ������ �
��������� �������: X,Y,Z,Vx,Vy,Vz.
�� ������ ������ ����� ������ �������� ���� ���������� �
������� dd mm yy hh mm ss.
� ������ ������ ����� ������ �������� �������������� ����������
������������ ������� � ��������� �������: alpha delta.
� ����������� �� ����, ����� ����������� � ������� ��������
������������, ����� ���������� ������� ��� �����.

��� ������� (��� ��������� � ������������ ��� ���������� ������)
����������� ������. ��������������, �� ����� ����� ���� �������
���� ������ ������, ������ ��� ��� ��� ���.
=========================================================}

{+���� ���������� ��������� �������, ������� ���������� � �������������� ���������}
procedure inputCMeth(filename: String; var meth: DecartCoords; time: DateTime;
          eqCords: EquatorCoords); overload;

{+���� ���������� ��������� ������� � ������� ����������}
procedure inputCMeth(filename: String; var meth: DecartCoords; time: DateTime); overload;

{+���� ���������� ��������� �������}
procedure inputCMeth(filename: String; var meth: DecartCoords); overload;

{+���� ��������� ������ �������, ������� ���������� � �������������� ���������}
procedure inputEMeth(filename: String; var meth: ElementsOfOrbit; time: DateTime;
          eqCords: EquatorCoords); overload;

{+���� ��������� ������ ������� � ������� ��� ����������}
procedure inputEMeth(filename: String; var meth: ElementsOfOrbit; time: DateTime); overload;

{+���� ������ ��������� ������  �������}
procedure inputEMeth(filename: String; var meth: ElementsOfOrbit); overload;

{+������������� ���� � ������� ��� ����������� ������������� �
���������}
function initDateTime(day,month,year,hour,minute,second): DateTime;

{+������������� ��������� ������ �������}
function initElems(a,e,i,Om,w,v: extended): ElementsOfOrbit;

{+������������� ���������� ��������� �������}
function initDecartCoords(X,Y,Z,Vx,Vy,Vz: extended): DecartCoords;

{+������������� �������������� ���������}
function initEquatorCoords(alpha,delta: extended): EquatorCoords;

{+������������� ������������� ���������}
function initEclipticCoords(lamda,betta: extended): EclipticCoords;

{+������������� �������������� ���������}
function initHorizontalCoords(Az,h: extended): HorizontalCoords;

{+������������� ��������������� ���������}
function initGeogrCoords(long,lat: extended): GeogrCoords;

{+����� ���������� � ����}
procedure printCoords(coords: DecartCoords; var fileName: text); overload;

{+����� ��������� �� �����}
procedure printCoords(coords: DecartCoords); overload;

{+����� ��������� � ����}
procedure printVel(coords: DecartCoords; var fileName: text); overload;

{+����� ��������� �� �����}
procedure printVel(coords: DecartCoords); overload;

{+����� ���������� � ��������� � ����}
procedure printCoordsVel(coords: DecartCoords; var fileName: text); overload;

{+����� ��������� � ��������� �� �����}
procedure printCoordsVel(coords: DecartCoords); overload;

{+������� � ���� �������� ������}
procedure printElements(elem: ElementsOfOrbit; var fileName: text); overload;

{+������� �� ����� �������� ������}
procedure printElements(elem: ElementsOfOrbit); overload;

{+����� � ���� �������� ��������� (���������, ��������������)}
procedure printCelCoords(coords: EquatorCoords; var fileName: text); overload;

{+����� � ���� �������� ��������� (���������, ��������������)}
procedure printCelCoords(coords: HorizontalCoords; var fileName: text); overload;

{+����� � ���� �������� ��������� (���������, �������������)}
procedure printCelCoords(coords: EclipticCoords; var fileName: text); overload;

{+����� �� ����� �������� ��������� (���������, ��������������)}
procedure printCelCoords(coords: EquatorCoords); overload;

{+����� �� ����� �������� ��������� (���������, ��������������)}
procedure printCelCoords(coords: HorizontalCoords); overload;

{+����� �� ����� �������� ��������� (���������, �������������)}
procedure printCelCoords(coords: EclipticCoords); overload;


{================================================================
           ����� ����� �������� �������������� � �����
=================================================================}


{=================================================================
���� ��������������� �������� � �������, ��������� � ���������� �� ����� ��
� ������, ���������� �� ��������� ������ � ���������� ����������� � �������,
�����������, ���������� � ��������.
==================================================================}

{������� �������� �� ��������� ������ � ���������� �����������}
function fromOrbitToDecart(elems: ElementsOfOrbit): DecartCoords;

{������� �������� �� ���������� ��������� � ��������� ������}
function fromDecartToOrbit(coord: DecartCoords): ElementsOfOrbit;

{������� ������������� ���� � ���������}
function JDate(dt: DateTime): extended;

{�������� ����� �� ������� ��������� ����}
function siderealTime(year,month,day: integer): extended;

{������ ��������� ������� ������� �������}
function keplerSolution(e,M: extended): extended;

{������� ��������� ���� � �������������}
function grDate(JD: extended): DateTime;

{�������� ����� �� ����� ���� �� ������ �������}
function sidTimeOnLong(date: DateTime; long: extended): extended;

{������� �� �������������� ��������� � ������������� (������ �����)}
function fromEqToEcl(eq: EquatorCoords): EclipticCoords;

{������� �� ������������� ��������� � �������������� (������ �����)}
function fromEclToEq(ecl: EclipticCoords): EquatorCoords;

{������� �� �������������� ��������� � �������������� (������ �����)}
function fromHorToEq(hor: HorizontalCoords): EquatorCoords;

{������� �� �������������� ��������� � �������������� (������ �����)}
function fromEqToHor(eq: EquatorCoords): HorizontalCoords;

{������� �� �������������� ��������� � �������������� (�������� ������)}
function fromEqToEclDecart(eq: DecatrCoords): DecartCoords;

{������� �� ������������� ��������� � �������������� (�������� ������)}
function fromEclToEqDecart(ecl: DecartCoords): DecartCoords;

{���������� ������� �������}
function getRadiant(meth: DecartCoords): extended;


{=====================================================================
            ����� ����� ��������������� �������� � �������
======================================================================}


{=====================================================================
���� �������������� �������� � �������. �������� ������ ���������,
������ ��������, ������� ����� ������ � ������.
======================================================================}

{������� ������� ��������� ������ ��� � �� ���� angle (� ��������)}
function rotateSCX(angle: extended; dc: DecartCoords): DecartCoords;

{������� ������� ��������� ������ ��� Y �� ���� angle (� ��������)}
function rotateSCY(angle: extended; dc: DecartCoords): DecartCoords;

{������� ������� ��������� ������ ��� Z �� ���� angle (� ��������)}
function rotateSCZ(angle: extended; dc: DecartCoords): DecartCoords;

{������� �� ���������� ��������� � �����������}
procedure fromDecartToSphere(A: DecartCoords; var fi,lam: extended);

function fromSphereToDecart(fi,lam,r: extended): DecartCoords;

{����� ���� �������� (� ���������, � ���������)}
function sumOfVectors(A,B: DecartCoords): DecartCoords;

{�������� ���� �������� (� ���������, � ���������)}
function differenceOfVectors(A,B: DecartCoords): DecartCoords;

{������ ������� ��������� (�����, ���������� �� ����������)}
function moduleOfCoords(A: DecartCoords): extended;

{������ ������� �������� (�����, ���������� �� ��������)}
function moduleOfVelocity(A: DecartCoords): extended;

{������� � ������������� ������� � ���� ���������� �����}
function timeToDotTime(t: DateTime): extended;

{������� � ����������� ������������� ������� (����, ������, �������) ��
���� ����������� ����� (���� ���������� �� ���� ����� ����)}
function dotTimeToTime(t: extended): DateTime;

{������� �������� � �������}
function toRadians(x: extended): extended;

{������� ������ � �������}
function toDegree(x: extended): extended;

{������� ���������� � ��������������� �������}
function toAu(x: extended): extended;

{������� ��������������� ������ � ���������}
function toKm(x: extended): extended;

{������� �������� � ����}
function toHour(x: extended): extended;

{������� ����� � �������}
function toDegFromHour(x: extended): extended;

{=====================================================================
            ����� ����� �������������� �������� � �������
======================================================================}


{=====================================================================
   ���� �������� � �������, ���������� �� �������� �������.
   ����� ������ � ������� ������� ������. �� ���������� � �������������
   ��������� ��������� ����� �����������.
======================================================================}

{�������� ���������� ����� �� 430 ����� ������� ������}
function getEarthCoords(): DecartCoords;

{=====================================================================
    ����� ����� �������� � �������, ���������� �� �������� �������
======================================================================}

implementation

{=============================================================================}

procedure inputCMeth(filename: String; var meth: DecartCoords; time: DateTime;
          eqCoords: EquatorCoords); overload;
var infile: text;
begin
  try
    Assign(infile,filename);
    Reset(infile);
  except
    Writeln('���� �� ������. ��������� ������������ ����.');
    Readln;
    Halt;
  end;

  try
    Readln(infile,meth.X,meth.Y,meth.Z,meth.Vx,meth.Vy,meth.Vz);
  except
    Writeln('���������� ������� ����������. ��������� ������������ �����.');
    Readln;
    Halt;
  end;

  try
    Readln(infile,time.day,time.month,time.year,time.hour,time.minute,time.second);
  except
    Writeln('���������� ������� ����. ��������� ������������ �����.');
    Readln;
    Halt;
  end;

  try
    Readln(infile,eqCoords.alpha,eqCoords.delta);
  except
    Writeln('���������� ������� �������������� ����������. ��������� ������������ �����.');
    Readln;
    Halt;
  end;

  Close(infile);
end;

procedure inputCMeth(filename: String; var meth: DecartCoords; time: DateTime); overload;
var infile: text;
begin
  try
    Assign(infile,filename);
    Reset(infile);
  except
    Writeln('���� �� ������. ��������� ������������ ����.');
    Readln;
    Halt;
  end;

  try
    Readln(infile,meth.X,meth.Y,meth.Z,meth.Vx,meth.Vy,meth.Vz);
  except
    Writeln('���������� ������� ����������. ��������� ������������ �����.');
    Readln;
    Halt;
  end;

  try
    Readln(infile,time.day,time.month,time.year,time.hour,time.minute,time.second);
  except
    Writeln('���������� ������� ����. ��������� ������������ �����.');
    Readln;
    Halt;
  end;

  Close(infile);
end;

procedure inputCMeth(filename: String; var meth: DecartCoords); overload;
var infile: text;
begin
  try
    Assign(infile,filename);
    Reset(infile);
  except
    Writeln('���� �� ������. ��������� ������������ ����.');
    Readln;
    Halt;
  end;

  try
    Readln(infile,meth.X,meth.Y,meth.Z,meth.Vx,meth.Vy,meth.Vz);
  except
    Writeln('���������� ������� ����������. ��������� ������������ �����.');
    Readln;
    Halt;
  end;

  Close(infile);
end;


procedure inputEMeth(filename: String; var meth: ElementsOfOrbit; time: DateTime;
          eqCords: EquatorCoords); overload;
var infile: text;
begin
  try
    Assign(infile,filename);
    Reset(infile);
  except
    Writeln('���� �� ������. ��������� ������������ ����.');
    Readln;
    Halt;
  end;

  try
    Readln(infile,meth.a,meth.e,meth.i,meth.Om,meth.w,meth.v);
  except
    Writeln('���������� ������� ����������. ��������� ������������ �����.');
    Readln;
    Halt;
  end;

  try
    Readln(infile,time.day,time.month,time.year,time.hour,time.minute,time.second);
  except
    Writeln('���������� ������� ����. ��������� ������������ �����.');
    Readln;
    Halt;
  end;

  try
    Readln(infile,eqCoords.alpha,eqCoords.delta);
  except
    Writeln('���������� ������� �������������� ����������. ��������� ������������ �����.');
    Readln;
    Halt;
  end;

  Close(infile);
end;


procedure inputEMeth(filename: String; var meth: ElementsOfOrbit; time: DateTime); overload;
var infile: text;
begin
  try
    Assign(infile,filename);
    Reset(infile);
  except
    Writeln('���� �� ������. ��������� ������������ ����.');
    Readln;
    Halt;
  end;

  try
    Readln(infile,meth.a,meth.e,meth.i,meth.Om,meth.w,meth.v);
  except
    Writeln('���������� ������� ����������. ��������� ������������ �����.');
    Readln;
    Halt;
  end;

  try
    Readln(infile,time.day,time.month,time.year,time.hour,time.minute,time.second);
  except
    Writeln('���������� ������� ����. ��������� ������������ �����.');
    Readln;
    Halt;
  end;

  Close(infile);
end;


procedure inputEMeth(filename: String; var meth: ElementsOfOrbit); overload;
var infile: text;
begin
  try
    Assign(infile,filename);
    Reset(infile);
  except
    Writeln('���� �� ������. ��������� ������������ ����.');
    Readln;
    Halt;
  end;

  try
    Readln(infile,meth.a,meth.e,meth.i,meth.Om,meth.w,meth.v);
  except
    Writeln('���������� ������� ����������. ��������� ������������ �����.');
    Readln;
    Halt;
  end;

  Close(infile);
end;


function initDateTime(day,month,year,hour,minute,second): DateTime;
var t: DateTime;
begin
  t.day := day;
  t.month := month;
  t.year := year;
  t.hour := hour;
  t.minute := minute;
  t.second := second;

  result := t;
end;


function initElems(a,e,i,Om,w,v: extended): ElementsOfOrbit;
var el: ElementsOfOrbit;
begin
  el.a := a;
  el.e := e;
  el.i := i;
  el.Om := Om;
  el.a := w;
  el.a := v;

  result := el;
end;


function initDecartCoords(X,Y,Z,Vx,Vy,Vz: extended): DecartCoords;
var coord: DecartCoords;
begin
  coord.X := X;
  coord.Y := Y;
  coord.Z := Z;
  coord.Vx := Vx;
  coord.Vy := Vy;
  coord.Vz := Vz;

  result := coord;
end;


function initEquatorCoords(alpha,delta: extended): EquatorCoords;
var coor: EquatorCoords;
begin
  coor.alpha := alpha;
  coor.delta := delta;

  result := coor;
end;


function initEclipticCoords(lamda,betta: extended): EclipticCoords;
var coor: EclipticCoords;
begin
  coor.lamda := lamda;
  coor.betta := betta;

  result := coor;
end;


function initHorizontalCoords(Az,h: extended): HorizontalCoords;
var coor: HorizontalCoords;
begin
  coor.alpha := Az;
  coor.delta := h;

  result := coor;
end;


function initGeogrCoords(long,lat: extended): GeogrCoords;
var coor: GeogrCoords;
begin
  coor.long := long;
  coor.lat := lat;

  result := coor;
end;


procedure printCoords(coords: DecartCoords; var fileName: text); overload;
begin
  Writeln(fileName,coords.X,' ',coords.Y,' ',cords.Z);
end;


procedure printCoords(coords: DecartCoords); overload;
begin
  Writeln(coords.X,' ',coords.Y,' ',cords.Z);
end;


procedure printVel(coords: DecartCoords; var fileName: text); overload;
begin
  Writeln(fileName,coords.Vx,' ',coords.Vy,' ',cords.Vz);
end;


procedure printVel(coords: DecartCoords); overload;
begin
  Writeln(coords.Vx,' ',coords.Vy,' ',cords.Vz);
end;


procedure printCoordsVel(coords: DecartCoords; var fileName: text); overload;
begin
  Writeln(fileName, coords.X,' ',coords.Y,' ',cords.Z,' ',coords.Vx,' ',
          coords.Vy,' ',coords.Vz);
end;


procedure printCoordsVel(coords: DecartCoords); overload;
begin
  Writeln(coords.X,' ',coords.Y,' ',cords.Z,' ',coords.Vx,' ',coords.Vy,
          ' ',coords.Vz);
end;


procedure printElements(elem: ElementsOfOrbit; var fileName: text); overload;
begin
  with elem do begin
    Writeln(fileName,a,' ',e,' ',i,' ',Om,' ',w,' ',v);
  end;
end;


procedure printElements(elem: ElementsOfOrbit); overload;
begin
  with elem do begin
    Writeln(a,' ',e,' ',i,' ',Om,' ',w,' ',v);
  end;
end;


procedure printCelCoords(coords: EquatorCoords; var fileName: text); overload;
begin
  Writeln(fileName,coords.alpha,' ',coords.delta);
end;


procedure printCelCoords(coords: HorizontalCoords; var fileName: text); overload;
begin
  Writeln(fileName,coords.Az,' ',coords.h);
end;


procedure printCelCoords(coords: EclipticCoords; var fileName: text); overload;
begin
  Writeln(fileName,coords.lamda,' ',coords.betta);
end;


procedure printCelCoords(coords: EquatorCoords); overload;
begin
  Writeln(coords.alpha,' ',coords.delta);
end;


procedure printCelCoords(coords: HorizontalCoords); overload;
begin
  Writeln(coords.Az,' ',coords.h);
end;


procedure printCelCoords(coords: EclipticCoords); overload;
begin
  Writeln(coords.lamda,' ',coords.betta);
end;
{=============================================================================}
end.
