Bootstrap Switch for NuGet
=============================

This project is responsible for creating the [bootstrap-switch](https://www.nuget.org/packages/Bootstrap.Switch/) package on NuGet for the [Bootstrap Switch](http://www.bootstrap-switch.org/) project.

Installation
--------------

To install bootstrap-switch, run the following command in the [Package Manager Console](http://docs.nuget.org/docs/start-here/using-the-package-manager-console)

    PM> Install-Package Bootstrap.Switch

Issues
--------

- Report [Bootstrap Switch](http://www.bootstrap-switch.org/) issues [here](https://github.com/nostalgiaz/bootstrap-switch/issues)
- Report NuGet package issues [here](https://github.com/blachniet/bootstrap-switch-nuget/issues)

Building The Package
----------------------

### Requirements

- [npm](https://www.npmjs.org/)

### Steps

1. Set the version of `npmVersion` and `nugetVersion` in [build.fsx]
2. `.\build.cmd publish=true`

License
----------

* [This Repo's License](LICENSE)
* [Bootstrap Switch License](https://github.com/nostalgiaz/bootstrap-switch/blob/master/LICENSE)
