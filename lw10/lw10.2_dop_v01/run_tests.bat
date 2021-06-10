@echo off

:check_input
if "%~1" == "" goto error

:run_tests
echo TESTING %~1
for %%T in ("%~n1.*.test") do (
  echo.
  echo CASE: %%T
  "%~1" <%%T
)
goto done

:error
echo usage: run-tests [executable]

:done
