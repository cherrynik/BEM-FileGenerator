@echo off
SET /P Block=Block name: 
IF NOT DEFINED Block goto nope
SET /P Element=Element name: 
SET /P ModifierBool=Modifier bool (keep line empty for paired modifier defining): 

SET ModifierName=""
SET ModifierState=""
IF NOT DEFINED ModifierBool (
  echo.
  SET /P ModifierName=Modifier name: 
  SET /P ModifierState=Modifier state: 
)

cls
echo Keep line empty for default value only
echo Or you can write like: css js vue jsx...
echo.
echo What file exts create to everywhere? (css = default, js, etc)
SET /P FilesNeeded="> "

@REM Here start block
IF NOT %Block%=="" (
  IF NOT EXIST %Block% MKDIR %Block% && CD ./%Block%/
  IF EXIST %Block% CD %Block%

  IF NOT DEFINED FilesNeeded (
    IF NOT EXIST %Block%.css FSUTIL file createnew %Block%.css 0
  )

  IF DEFINED FilesNeeded (
    FOR %%a IN (%FilesNeeded%) do (
      IF NOT EXIST %Block%.%%a FSUTIL file createnew %Block%.%%a 0
    )
  )
)

@REM Here starts element
IF DEFINED Element (
  IF NOT EXIST "__%Element%/" MKDIR __%Element% && CD ./__%Element%/
  IF EXIST "__%Element%/" CD ./__%Element%/

  IF NOT DEFINED FilesNeeded (
    IF NOT EXIST %Block%__%Element%.css FSUTIL file createnew %Block%__%Element%.css 0
  )

  IF DEFINED FilesNeeded (
    FOR %%a IN (%FilesNeeded%) do (
      IF NOT EXIST %Block%__%Element%.%%a FSUTIL file createnew %Block%__%Element%.%%a 0
    )
  )
)

@REM Here starts modifier bool
IF DEFINED ModifierBool (
  IF NOT EXIST "_%ModifierBool%/" MKDIR _%ModifierBool% && CD ./_%ModifierBool%/
  IF EXIST "_%ModifierBool%/" CD ./_%ModifierBool%/

  IF NOT DEFINED FilesNeeded (
    IF DEFINED Element IF NOT EXIST %Block%__%Element%_%ModifierBool%.css FSUTIL file createnew %Block%__%Element%_%ModifierBool%.css 0
    IF NOT DEFINED Element IF NOT EXIST %Block%_%ModifierBool%.css FSUTIL file createnew %Block%_%ModifierBool%.css 0
  )

  IF DEFINED FilesNeeded (
    FOR %%a IN (%FilesNeeded%) do (
      IF DEFINED Element IF NOT EXIST %Block%__%Element%_%ModifierBool%.%%a FSUTIL file createnew %Block%__%Element%_%ModifierBool%.%%a 0
      IF NOT DEFINED Element IF NOT EXIST %Block%_%ModifierBool%.%%a FSUTIL file createnew %Block%_%ModifierBool%.%%a 0
    )
  )
)

@REM Here starts paired modifier
IF NOT %ModifierName%=="" IF NOT %ModifierState%=="" (
  IF NOT EXIST "_%ModifierName%/" MKDIR _%ModifierName% && CD ./_%ModifierName%/
  IF EXIST "_%ModifierName%/" CD ./_%ModifierName%/

  IF NOT DEFINED FilesNeeded (
    IF DEFINED Element IF NOT EXIST %Block%__%Element%_%ModifierName%_%ModifierState%.css FSUTIL file createnew %Block%__%Element%_%ModifierName%_%ModifierState%.css 0
    IF NOT DEFINED Element IF NOT EXIST %Block%_%ModifierName%_%ModifierState%.css FSUTIL file createnew %Block%_%ModifierName%_%ModifierState%.css 0
  )

  IF DEFINED FilesNeeded (
    FOR %%a IN (%FilesNeeded%) do (
      IF DEFINED Element IF NOT EXIST %Block%__%Element%_%ModifierName%_%ModifierState%.%%a FSUTIL file createnew %Block%__%Element%_%ModifierName%_%ModifierState%.%%a 0
      IF NOT DEFINED Element IF NOT EXIST %Block%_%ModifierName%_%ModifierState%.%%a FSUTIL file createnew %Block%_%ModifierName%_%ModifierState%.%%a 0
    )
  )
)