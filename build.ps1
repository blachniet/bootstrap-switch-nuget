function Package-BootstrapSwitch {
    $pkgDir = "pkg\Bootstrap.Switch"
    $nuspec = "Bootstrap.Switch.nuspec"

    mkdir "$pkgDir\Content\Scripts"
    mkdir "$pkgDir\Content\Content\bootstrap-switch"

    cp $nuspec "$pkgDir"
    cp node_modules\bootstrap-switch\build\js\* "$pkgDir\Content\Scripts"
    cp node_modules\bootstrap-switch\build\css\* "$pkgDir\Content\Content\bootstrap-switch" -Recurse

    nuget pack "$pkgDir\$nuspec" -OutputDirectory pkg
}

function Package-BootstrapSwitchLess {
    $pkgDir = "pkg\Bootstrap.Switch.Less"
    $nuspec = "Bootstrap.Switch.Less.nuspec"

    mkdir "$pkgDir\Content\Scripts"
    mkdir "$pkgDir\Content\Content\bootstrap-switch"

    cp $nuspec "$pkgDir"
    cp node_modules\bootstrap-switch\build\js\* "$pkgDir\Content\Scripts"
    cp node_modules\bootstrap-switch\src\less\* "$pkgDir\Content\Content\bootstrap-switch" -Recurse

    nuget pack "$pkgDir\$nuspec" -OutputDirectory pkg
}

function Clean {
    rm node_modules -Recurse -Force -ErrorAction SilentlyContinue
    rm pkg -Recurse -Force -ErrorAction SilentlyContinue
}

function Update {
    nuget update -self
    npm update npm -g
    npm install
}

Clean
Update
Package-BootstrapSwitch
Package-BootstrapSwitchLess
