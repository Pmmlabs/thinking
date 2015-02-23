unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Unit1, Math;

type
  TForm2 = class(TForm)
    lbl1: TLabel;
    rb1: TRadioButton;
    rb2: TRadioButton;
    rb3: TRadioButton;
    rb4: TRadioButton;
    btn1: TButton;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    procedure btn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.btn1Click(Sender: TObject);
var i:Integer;
begin
 if rb1.Checked then
  begin
   kozyrek[1]:=Colors(RandomRange(1,6));
   repeat kozyrek[2]:=Colors(RandomRange(1,6)) until (kozyrek[1]<>kozyrek[2]);
   repeat kozyrek[3]:=Colors(RandomRange(1,6)) until (kozyrek[1]<>kozyrek[3]) and (kozyrek[2]<>kozyrek[3]);
   repeat kozyrek[4]:=Colors(RandomRange(1,6)) until (kozyrek[1]<>kozyrek[4]) and (kozyrek[2]<>kozyrek[4]) and (kozyrek[3]<>kozyrek[4]);
   repeat kozyrek[shir]:=Colors(RandomRange(1,6)) until (kozyrek[1]<>kozyrek[shir]) and (kozyrek[2]<>kozyrek[shir]) and (kozyrek[3]<>kozyrek[shir]) and (kozyrek[4]<>kozyrek[shir]);
   Form1.Caption:='Размышляй - по первым правилам';
  end
  else
 if rb2.Checked then for i:=1 to shir do
  begin
   kozyrek[i]:=Colors(RandomRange(1,6));
   Form1.Caption:='Размышляй - по вторым правилам';
  end
  else
 if rb3.Checked then
  begin
   for i:=1 to shir do kozyrek[i]:=red;
   kozyrek[Random(3)+1]:=empty;
   if kozyrek[1]<>Empty then kozyrek[1]:=Colors(RandomRange(1,6));
   if kozyrek[2]<>Empty then repeat kozyrek[2]:=Colors(RandomRange(1,6)) until (kozyrek[1]<>kozyrek[2]);
   if kozyrek[3]<>Empty then repeat kozyrek[3]:=Colors(RandomRange(1,6)) until (kozyrek[1]<>kozyrek[3]) and (kozyrek[2]<>kozyrek[3]);
   if kozyrek[4]<>Empty then repeat kozyrek[4]:=Colors(RandomRange(1,6)) until (kozyrek[1]<>kozyrek[4]) and (kozyrek[2]<>kozyrek[4]) and (kozyrek[3]<>kozyrek[4]);
   if kozyrek[shir]<>Empty then repeat kozyrek[shir]:=Colors(RandomRange(1,6)) until (kozyrek[1]<>kozyrek[shir]) and (kozyrek[2]<>kozyrek[shir]) and (kozyrek[3]<>kozyrek[shir]) and (kozyrek[4]<>kozyrek[shir]);
   Form1.Caption:='Размышляй - по третьим правилам';
  end
 else
  begin
   for i:=1 to shir do kozyrek[i]:=Colors(Random(6));
   kozyrek[Random(shir-1)+1]:=empty;
   Form1.Caption:='Размышляй - по четвертым правилам';
  end;
 Form1.Enabled:=True;
 Form1.Show;
 Form2.Hide;
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Application.Terminate;
end;

initialization
 Randomize;
end.
