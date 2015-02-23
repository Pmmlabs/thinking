unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;
const FSize=55;
      shir=5;
type
  TForm1 = class(TForm)
    img1: TImage;
    img2: TImage;
    img3: TImage;
    img4: TImage;
    img5: TImage;
    img6: TImage;
    btn1: TButton;
    btn2: TButton;
    procedure img1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure img1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure img1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure img2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure img3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure img4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure img5MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure img6MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn1Click(Sender: TObject);
    procedure imgMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  Colors = (empty,red,blue,yellow,green,gray,black);
  TVariant = array[1..shir] of Colors;
var
  Form1: TForm1;
  kozyrek: TVariant;
  a: TVariant;
  i,j,row,col,xx,yy:Integer;
  bool:Boolean;
  Popytka:array[1..10,1..shir] of TImage;
  Circles:array[1..10,1..shir] of TShape;
  Infs:array[1..10,1..shir] of TShape;
  current:Colors;
  names:array[Colors] of string = ('пусто ','красный ','синий ','желтый ','зеленый ','серый ','оранжевый ');
implementation

uses Unit2;

{$R *.dfm}
function piceq(var a,b:TImage):Boolean;
Begin
  result:=a.Picture.Bitmap.Canvas.Pixels[a.Width div 2,a.Height div 2]=b.Picture.Bitmap.Canvas.Pixels[b.Width div 2,b.Height div 2];
end;
procedure TForm1.imgMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var p:TPoint;
begin
 if (Button=mbRight) and (col>0) then
  begin
   Popytka[row,col].Free;
   Dec(col);
  end
 else
  begin
   bool:=true;
   GetCursorPos(p);
   a[Popytka[row,col].Left div fsize +1]:=empty;
   xx:=p.X-Form1.Left-5-Popytka[row,col].Left;
   yy:=p.Y-Form1.Top-GetSystemMetrics(sm_cyCaption)-5-Popytka[row,col].Top;
   if piceq(Popytka[row,col],img1) then current:=red
   else if piceq(Popytka[row,col],img2) then current:=blue
   else if piceq(Popytka[row,col],img3) then current:=yellow
   else if piceq(Popytka[row,col],img4) then current:=green
   else if piceq(Popytka[row,col],img5) then current:=gray
   else current:=black;
  end;
end;
procedure MouseD(Sender:TImage;x,y:Integer);
var p:TPoint;
begin
 inc(col);
 if col=shir+1 then col:=shir
  else
   begin
    Popytka[row,col]:=TImage.Create(Form1);
    Popytka[row,col].AutoSize:=True;
    Popytka[row,col].Parent:=Form1;
    Popytka[row,col].Picture:=Sender.Picture;
    Popytka[row,col].Transparent:=True;
    Popytka[row,col].Left:=Sender.Left;
    Popytka[row,col].Top:=Sender.Top;
    Popytka[row,col].OnMouseDown:=Form1.imgMouseDown;
    Popytka[row,col].OnMouseMove:=Form1.img1.OnMouseMove;
    Popytka[row,col].OnMouseUp:=Form1.img1.OnMouseUp;
   end;
 bool:=true;
 GetCursorPos(p);
 xx:=p.X-Form1.Left-5-Sender.Left;
 yy:=p.Y-Form1.Top-GetSystemMetrics(sm_cyCaption)-5-Sender.Top;
end;

procedure TForm1.img1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 MouseD(img1,x,y);
 current:=red;
end;

procedure TForm1.img1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var p:TPoint;
begin
  GetCursorPos(p);
  if bool then with Popytka[row,col] do
  begin
   left:=p.X-Form1.Left-5-xx;
   if Left>shir*fsize-10 then left:=shir*fsize-10;
   if Left<0 then left:=0;
   top:=p.Y-Form1.Top-GetSystemMetrics(sm_cyCaption)-5-yy;
   //if Top < (row-1)*fsize+100 then Top := (row-1)*fsize+100;     //ограничение высоты
  end;
end;

procedure TForm1.img1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 //Прилипание
 if Popytka[row,col].Left+(Popytka[row,col].Width div 2) < 10+fsize+(fsize div 2) then Popytka[row,col].Left:=FSize
 else if Popytka[row,col].Left+(Popytka[row,col].Width div 2) < 10+2*fsize+(fsize div 2) then Popytka[row,col].Left:=2*FSize
 else if Popytka[row,col].Left+(Popytka[row,col].Width div 2) < 10+3*fsize+(fsize div 2) then Popytka[row,col].Left:=3*FSize
 else if Popytka[row,col].Left+(Popytka[row,col].Width div 2) < 10+4*fsize+(fsize div 2) then Popytka[row,col].Left:=4*FSize
 else Popytka[row,col].Left:=shir*FSize;
 Popytka[row,col].Left:=Popytka[row,col].Left-10;
 bool:=false;
 a[Popytka[row,col].Left div fsize +1]:=current;
end;

procedure TForm1.FormCreate(Sender: TObject);
var i,j:Integer;
begin
 Height:=Screen.Height;
 Top:=0;
 Width:=fsize*(shir+1);
 DoubleBuffered:=True;
   for i:=1 to 10 do
   for j:=1 to shir do
    begin
     Circles[i,j]:=TShape.Create(Form1);
     Circles[i,j].Parent:=Form1;
     Circles[i,j].Shape:=stCircle;
     Circles[i,j].Left:=fsize*j;
     Circles[i,j].Top:=fsize*i+100;
     Circles[i,j].Width:=10;
     Circles[i,j].Height:=10;
    end;
end;

procedure TForm1.img2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
MouseD(img2,x,y);
current:=blue;
end;

procedure TForm1.img3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 MouseD(img3,x,y);
 current:=yellow;
end;

procedure TForm1.img4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 MouseD(img4,x,y);
 current:=green;
end;

procedure TForm1.img5MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 MouseD(img5,x,y);
 current:=gray;
end;

procedure TForm1.img6MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 MouseD(img6,x,y);
 current:=black;
end;

procedure TForm1.btn1Click(Sender: TObject);
var j:Integer;
    win:Boolean;
begin
 win:=True;
  for j:=1 to shir do
    begin
     Infs[row,j]:=TShape.Create(Form1);
     Infs[row,j].Parent:=Form1;
     Infs[row,j].Shape:=stRectangle;
     Infs[row,j].Left:=fsize*j-(fsize div 2);
     Infs[row,j].Top:=fsize*row+100+10;
     Infs[row,j].Width:=50;
     Infs[row,j].Height:=10;
     Infs[row,j].Pen.Color:=clGreen;
     if a[j]=kozyrek[j] then
      begin
       Infs[row,j].Brush.Color:=clWhite;
       win:=win and True;
      end
     else
      begin
        if (a[j]=kozyrek[1]) or (a[j]=kozyrek[2]) or (a[j]=kozyrek[3]) or (a[j]=kozyrek[4]) or (a[j]=kozyrek[shir])
        then Infs[row,j].Brush.Color:=clGray
        else Infs[row,j].Brush.Color:=clBlack;
       win:=False;
      end;
    end;
  if win then
   begin
    ShowMessage('Я снимаю шляпу! Вы выиграли!');
    btn2.Click;
   end
  else
   begin
    Inc(row);
    if row=11 then
     begin
      ShowMessage('Вы проиграли! Под козырьком: '+names[kozyrek[1]]+names[kozyrek[2]]+names[kozyrek[3]]+names[kozyrek[4]]+names[kozyrek[shir]]);
      btn2.Click;
     end;
    col:=0;
    for j:=1 to shir do a[j]:=empty;
   end;
end;

procedure TForm1.btn2Click(Sender: TObject);
var i,j:Integer;
begin
 for i:=1 to shir do a[i]:=empty;
 row:=1;
 col:=0;
 for i:=1 to 10 do
  for j:=1 to shir do
   begin
    if Popytka[i,j]<>nil then Popytka[i,j].hide;
    if Infs[i,j]<> nil then Infs[i,j].Hide;
   end;
 Form1.OnCreate(Self);
 Enabled:=False;
 Form2.Show;
 Form2.SetFocus;
end;

initialization
 for i:=1 to shir do a[i]:=empty;
 row:=1;
 col:=0;
end.
