nuget update -self
npm update npm -g
npm install

rm *.nupkg

$pkgDir = "pkg\Bootstrap.Switch"
if (Test-Path "$pkgDir" -PathType Container) {
	rm "$pkgDir" -Recurse -Force -ErrorAction SilentlyContinue
}

mkdir "$pkgDir\Content\Scripts"
mkdir "$pkgDir\Content\Content\bootstrap-switch"

cp Bootstrap.Switch.nuspec "$pkgDir"
cp node_modules\bootstrap-switch\build\js\* "$pkgDir\Content\Scripts"
cp node_modules\bootstrap-switch\build\css\bootstrap* "$pkgDir\Content\Content\bootstrap-switch" -Recurse

nuget pack "$pkgDir\Bootstrap.Switch.nuspec"
