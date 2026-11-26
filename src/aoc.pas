program Aoc2026;
{$mode objfpc}{$H+}

uses
  Classes,
  SysUtils,
  AocInput,
  Day01 { ADD-DAY-USES };

  procedure PrintUsage;
  begin
    WriteLn(ErrOutput, 'Usage: aoc <day> <part> [--example|--input]');
    WriteLn(ErrOutput, 'The real input is used when no input option is supplied.');
  end;

  function IsDayAdded(const DayNumber: integer): boolean;
  begin
    case DayNumber of
      1: Result := True;
        { ADD-DAY-SUPPORT }
      else
        Result := False;
    end;
  end;

  function SolveDay(const DayNumber, PartNumber: integer;
  const InputLines: TStrings): string;
  begin
    case DayNumber of
      1:
        if PartNumber = 1 then
          Result := Day01.SolvePart1(InputLines)
        else
          Result := Day01.SolvePart2(InputLines);
        { ADD-DAY-DISPATCH }
      else
        raise Exception.CreateFmt('Day %d has not been added yet.', [DayNumber]);
    end;
  end;

var
  DayNumber: integer;
  PartNumber: integer;
  InputName: string;
  InputPath: string;
  ProjectRoot: string;
  InputLines: TStringList;
  Answer: string;
begin
  if (ParamCount < 2) or (ParamCount > 3) then
  begin
    PrintUsage;
    Halt(2);
  end;

  if not TryStrToInt(ParamStr(1), DayNumber) or not
    TryStrToInt(ParamStr(2), PartNumber) then
  begin
    PrintUsage;
    Halt(2);
  end;

  if (DayNumber < 1) or (PartNumber < 1) or (PartNumber > 2) then
  begin
    PrintUsage;
    Halt(2);
  end;

  InputName := 'input.txt';
  if ParamCount = 3 then
  begin
    if ParamStr(3) = '--example' then
      InputName := 'example.txt'
    else if ParamStr(3) <> '--input' then
    begin
      PrintUsage;
      Halt(2);
    end;
  end;

  if not IsDayAdded(DayNumber) then
  begin
    WriteLn(ErrOutput, 'Day ', DayNumber, ' has not been added yet.');
    Halt(2);
  end;

  ProjectRoot := ExtractFileDir(ExtractFileDir(ExpandFileName(ParamStr(0))));
  InputPath := IncludeTrailingPathDelimiter(ProjectRoot) + 'data' +
    PathDelim + 'day' + Format('%.2d', [DayNumber]) + PathDelim + InputName;

  try
    InputLines := LoadInputLines(InputPath);
    try
      Answer := SolveDay(DayNumber, PartNumber, InputLines);
      WriteLn('Day ', Format('%.2d', [DayNumber]), ', Part ', PartNumber, ': ', Answer);
    finally
      InputLines.Free;
    end;
  except
    on Error: Exception do
    begin
      WriteLn(ErrOutput, Error.Message);
      Halt(1);
    end;
  end;
end.
