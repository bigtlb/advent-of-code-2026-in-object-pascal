#!/usr/bin/env zsh
set -euo pipefail

if (( $# != 1 )) || [[ "$1" != <-> ]]; then
  print -u2 'Usage: zsh scripts/add-day.zsh <day 1-25>'
  exit 2
fi

day_number=$(( 10#$1 ))
if (( day_number < 1 || day_number > 25 )); then
  print -u2 'Day must be a number from 1 to 25.'
  exit 2
fi

script_dir="${0:A:h}"
project_root="${script_dir:h}"
day_name=$(printf 'day%02d' "$day_number")
unit_name=$(printf 'Day%02d' "$day_number")
unit_file="$project_root/src/days/$day_name.pas"
data_dir="$project_root/data/$day_name"
aoc_file="$project_root/src/aoc.pas"

if [[ -e "$unit_file" ]]; then
  print -u2 "$unit_name already exists: $unit_file"
  exit 1
fi

aoc_source=$(<"$aoc_file")
uses_marker='{ ADD-DAY-USES }'
support_marker='{ ADD-DAY-SUPPORT }'
dispatch_marker='{ ADD-DAY-DISPATCH }'
if [[ "$aoc_source" != *"$uses_marker"* ||
      "$aoc_source" != *"$support_marker"* ||
      "$aoc_source" != *"$dispatch_marker"* ]]; then
  print -u2 "Could not find all day-registration markers in $aoc_file."
  exit 1
fi
if [[ "$aoc_source" == *"$unit_name"* ]]; then
  print -u2 "$unit_name is already registered in $aoc_file."
  exit 1
fi

aoc_source=${aoc_source/"$uses_marker"/", $unit_name$uses_marker"}
aoc_source=${aoc_source/"$support_marker"/"    $day_number: Result := True;"$'\n    '"$support_marker"}
aoc_source=${aoc_source/"$dispatch_marker"/"    $day_number:"$'\n'"      if PartNumber = 1 then"$'\n'"        Result := $unit_name.SolvePart1(InputLines)"$'\n'"      else"$'\n'"        Result := $unit_name.SolvePart2(InputLines);"$'\n    '"$dispatch_marker"}

mkdir -p "$project_root/src/days" "$data_dir"
cat > "$unit_file" <<EOF
unit $unit_name;
{\$mode objfpc}{\$H+}

interface

uses
  Classes;

function SolvePart1(const InputLines: TStrings): String;
function SolvePart2(const InputLines: TStrings): String;

implementation

function SolvePart1(const InputLines: TStrings): String;
begin
  Result := 'Not implemented';
end;

function SolvePart2(const InputLines: TStrings): String;
begin
  Result := 'Not implemented';
end;

end.
EOF
printf '%s\n' "$aoc_source" > "$aoc_file"

print "Added $unit_name in src/days/$day_name.pas and registered both parts."
print "Add example and real input files under data/$day_name/."