Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command iwr -useb https://raw.githubusercontent.com/Milton797/AutoEmptyStandbyList/master/manager.ps1 | iex" -Verb RunAs
