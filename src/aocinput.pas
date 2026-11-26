unit AocInput;
{$mode objfpc}{$H+}

interface

uses
  Classes;

function LoadInputLines(const FileName: String): TStringList;

implementation

uses
  SysUtils;

function LoadInputLines(const FileName: String): TStringList;
begin
  if not FileExists(FileName) then
    raise Exception.CreateFmt('Input file not found: %s', [FileName]);

  Result := TStringList.Create;
  try
    Result.LoadFromFile(FileName);
  except
    Result.Free;
    raise;
  end;
end;

end.