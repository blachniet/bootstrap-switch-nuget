@echo off
.nuget\NuGet.exe install FAKE -OutputDirectory tools -ExcludeVersion
tools\FAKE\tools\FAKE.exe build.fsx %*
pause