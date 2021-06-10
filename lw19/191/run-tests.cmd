@echo off

:check_input
if "%~1" == "" goto error

:run_tests
echo TESTING %~1
for %%T in ("%~n1.*.test") do (
  echo.
  echo CASE: %%T
  type %%T
  echo.
  echo *------------------------------*
  "%~1" <%%T
  echo *------------------------------*
)
goto done

:error
echo usage: program-test [executable]

:done
