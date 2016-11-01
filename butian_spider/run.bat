mode con cols=50 lines=12
@color B
@echo ----------------------------------------
@echo.
@echo [It's running]......
@echo.
@echo [Please read the log.txt]
@echo.
@echo ----------------------------------------

@python butian.py > log.txt

@start log.txt

@pause
