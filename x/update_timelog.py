#!/usr/bin/env python

import argparse
from datetime import datetime
from pathlib import Path


class LoggedHoursUpdater:
    """Simple tool to update logged hours on an Obsidian Markdown note."""

    def __init__(self):
        args = self._parse_args()

        file_path = Path(args.file_path)
        if not file_path.exists():
            raise FileNotFoundError(f"File path does not exist: {file_path}")
        self._file_path = file_path

    @staticmethod
    def _parse_args() -> None:
        parser = argparse.ArgumentParser()
        parser.add_argument(
                "file_path",
                type=str,
                help="Path of markdown note file"
        )
        return parser.parse_args()

    def run(self) -> None:
        if not self._is_daily_note(self._file_path):
            print(f"File {self._file_path.name} does not appear to be a daily note")
            return
        self.update_total_logged_hours(self._file_path)

    def _is_daily_note(self, file_path: Path) -> bool:
        """Checks if file appears to be a daily note."""
        if file_path.suffix != ".md":
            return False
        try:
            datetime.strptime(file_path.stem, "%Y-%m-%d")
        except ValueError:
            return False
        return True

    def update_total_logged_hours(self, file_path: Path) -> None:
        """Updates the logged hours in a .md file."""
        hours_total = self.calculate_hour_sum(file_path)
        self._write_hours(file_path, hours_total)

    def calculate_hour_sum(self, file_path: Path) -> float:
        """Calculates the sum of total logged hours."""
        hour_sum = 0.0
        with file_path.open() as f:
            lines = f.readlines()
            logged_hours = [self._parse_hours_logged_in_line(line) for line in lines]

        return round(sum(logged_hours), 2)

    @staticmethod
    def _parse_hours_logged_in_line(line: str) -> float:
        """Returns number of hours that are logged in a line of text."""
        line = line.strip()
        if not line.startswith("- ["):
            return 0.0  # line is not a checkbox, i.e. no logged hours

        line = line[len("- [ ] "):]
        time = line.split()[0]
        print(time)

        try:
            hour_part, min_part = time.split("h")
            if not min_part:  # minutes not given
                min_part = "0"
        except ValueError:  # only minutes given, or not a time entry
            hour_part = 0
            min_part = time

        try:
            hours = int(hour_part)
            mins = int(min_part.removesuffix("m")) / 60
        except ValueError:  # line has a task that is not a time entry
            return 0

        return round(hours + mins, 2)

    @staticmethod
    def _write_hours(file_path: Path, hours_total: float) -> None:
        """Writes total logged hours to markdown file heading."""
        with file_path.open() as f:
            lines = f.readlines()

        for log_line_idx, line in enumerate(lines):
            if line.strip().startswith("## log"):
                break

        hours = int(hours_total)
        mins = round((hours_total - hours) * 60)

        time_logged_string = f"## log {hours}h"
        if mins:  # only write minutes if not even hours
            time_logged_string += f"{mins}m"
        time_logged_string += "\n"

        lines[log_line_idx] = time_logged_string

        with file_path.open(mode="w", encoding="utf-8") as f:
            f.writelines(lines)


if __name__ == "__main__":
    LoggedHoursUpdater().run()
