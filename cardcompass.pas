unit cardcompass;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  OpenVG,       {Include the OpenVG unit so we can use the various types and structures}
  VGShapes,     {Include the VGShapes unit to give us access to all the functions}
  VC4;


var

Width:Integer;  {A few variables used by our shapes example}
Height:Integer;


procedure compass(gpsheading,x,y,r:LongWord) ;

implementation



procedure compass(gpsheading,x,y,r:LongWord );
    var
       Ticks:Integer;
       PosDeg:VGfloat;
       PosNum:VGfloat;
       PosT1:VGfloat;
       PosT2:VGfloat;
       Dial:VGfloat;
       Needle:VGfloat;

       Degree: string;

       Degrees:Integer;

       PolyX:array[0..3] of VGfloat;
       PolyY:array[0..3] of VGfloat;

       Fontsize:Integer;

     begin

       Degrees := gpsheading;

       VGShapesTranslate(x,y);
       PosT1:= r / 2 * 0.95;
       PosT2:= r / 2 * 0.90;
       PosDeg:= r / 2 * 0.83;
       PosNum:= r / 2 * 0.65;
       Needle:= r / 2 * 0.92;
       Dial:= r * 1.0;

       VGShapesStrokeWidth(Dial / 30);
       VGShapesStroke(181,166,66,1);
       VGShapesFill(255,255,200,1);
       VGShapesCircle(0,0, Dial);

       VGShapesStrokeWidth(Dial * 0.005);
       VGShapesStroke(0,0,0,1);
       VGShapesFill(255,255,200,1);
       VGShapesCircle(0,0,2 * PosT1);

       VGShapesStrokeWidth(Dial * 0.005);
       VGShapesStroke(0,0,0,1);
       VGShapesFill(255,255,200,1);
       VGShapesCircle(0,0,2 * PosT2);

       Fontsize:= 12;
       VGShapesFill(0,0,0,1);
       //VGShapesTextMid(0,Dial * 0.6,IntToStr(Degrees),VGShapesSerifTypeface,Fontsize);

       Fontsize:=Trunc(Dial * 0.08);

       VGShapesFill(0,0,0,1);
       VGShapesTextMid(0,PosNum,'N',VGShapesSansTypeface,Fontsize);
       VGShapesLine(0,0, 0,PosT2);

       VGShapesRotate(-45);
       VGShapesTextMid(0,PosNum,'NE',VGShapesSansTypeface,Fontsize);

       VGShapesRotate(-45);
       VGShapesTextMid(0,PosNum,'E',VGShapesSansTypeface,Fontsize);
       VGShapesLine(0,0, 0,PosT2);

       VGShapesRotate(-45);
       VGShapesTextMid(0,PosNum,'SE',VGShapesSansTypeface,Fontsize);

       VGShapesRotate(-45);
       VGShapesTextMid(0,PosNum,'S',VGShapesSansTypeface,Fontsize);
       VGShapesLine(0,0, 0,PosT2);

       VGShapesRotate(-45);
       VGShapesTextMid(0,PosNum,'SW',VGShapesSansTypeface,Fontsize);

       VGShapesRotate(-45);
       VGShapesTextMid(0,PosNum,'W',VGShapesSansTypeface,Fontsize);
       VGShapesLine(0,0, 0,PosT2);

       VGShapesRotate(-45);
       VGShapesTextMid(0,PosNum,'NW',VGShapesSansTypeface,Fontsize);

       VGShapesRotate(-45);

       Fontsize:=Trunc(Dial * 0.025);

       for Ticks := 0 to 360 do
           Begin

                if Ticks mod 10 = 0 then
                Begin
                  Degree := IntToStr(Ticks);
                  VGShapesStrokeWidth(Dial * 0.005);
                  VGShapesTextMid(0,PosDeg,Degree,VGShapesSansTypeface,Fontsize);
                end

                else
                   VGShapesStrokeWidth(Dial * 0.001);

                VGShapesLine(0,PosT1, 0,PosT2);
                VGShapesRotate(-1);
          end;

       VGShapesStrokeWidth(Dial * 0.005);
       VGShapesStroke(40,40,40,1);

       VGShapesFill(200,0,0,1);

       PolyX[0]:=Dial * 0.06;
       PolyX[1]:=0;
       PolyX[2]:=-Dial * 0.06;

       PolyY[0]:=0;
       PolyY[1]:=Needle;
       PolyY[2]:=0;

       VGShapesRotate(Degrees * -1);
       VGShapesLine(Dial * 0.06,0, 0, Needle);
       VGShapesLine(-Dial * 0.06,0, 0, Needle);
       VGShapesPolygon(@PolyX,@PolyY,3);
       VGShapesRotate(Degrees * 1);

       VGShapesFill(255,255,255,1);

       PolyX[0]:=Dial * 0.06;
       PolyX[1]:=0;
       PolyX[2]:=-Dial * 0.06;

       PolyY[0]:=0;
       PolyY[1]:=-Needle;
       PolyY[2]:=0;

       VGShapesRotate(Degrees * -1);
       VGShapesLine(Dial * 0.06,0, 0, -Needle);
       VGShapesLine(-Dial * 0.06,0, 0, -Needle);
       VGShapesPolygon(@PolyX,@PolyY,3);
       VGShapesRotate(Degrees * 1);

       VGShapesStroke(90,83,33,1);
       VGShapesFill(181,166,66,1);
       VGShapesCircle(0,0,Dial * 0.08);

       //reset back ot zero position
       VGShapesTranslate(-x,-y);


  end;

end.

