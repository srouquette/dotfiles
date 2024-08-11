:: src: {{ .src }}
:: hash: {{ .src | include | sha256sum }}

@echo off

set SRCFILE={{ joinPath "%CHEZMOI_SOURCE_DIR%" .src | osClean }}
set DSTFILE={{ .dst | osClean }}

:: Skip if application has not been installed.
IF NOT EXIST "{{ osDir .dst }}" (
    exit 0
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
