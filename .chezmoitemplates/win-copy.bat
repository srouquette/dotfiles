@echo off

:: refresh ? {{ get . "refresh" }}
set SRCFILE={{ template "win-expandenv.bat" .src | osClean }}
set DSTFILE={{ template "win-expandenv.bat" .dst | osClean }}

:: Skip if application has not been installed.
FOR %%A in ("%DSTFILE%") do (
    IF NOT EXIST "%%~pA" (
        echo "exit on exists %%~pA"
        exit 0
    )
)

:: Skip if destination is a symbolic link.
dir "%DSTFILE%" | find "<SYMLINK>" > nul
IF %errorlevel% == 0 (
    exit 0
)

:: Skip if configuration files are identical.
fc /b "%SRCFILE%" "%DSTFILE%" > nul
IF %errorlevel% == 0 (
    exit 0
)

:: Copy source file to destination.
xcopy /fvy "%SRCFILE%" "%DSTFILE%*"
