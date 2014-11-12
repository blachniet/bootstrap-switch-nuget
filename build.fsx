#r @"tools/FAKE/tools/FakeLib.dll"
open Fake
open Fake.ProcessHelper
open Fake.Git

let npmVersion = "3.2.0"
let nugetVersion = "3.2.0-fake1"
let pkgDir = "./pkg/"
let publish = (getBuildParamOrDefault "publish" "false") = "true"

Target "CleanNpm" (fun _ ->
    CleanDir "node_modules"
)

Target "CleanPkg" (fun _ ->
    CleanDir pkgDir
)

Target "NpmInstall" (fun _ ->
    let npm64 = @"C:\Program Files\nodejs\npm.cmd"
    trace npm64
    let npm86 = combinePaths ProgramFilesX86 @"nodejs\npm.cmd"
    trace npm86
    let npm = if fileExists npm64 then npm64 else npm86
    if (fileExists npm <> true) then failwith "NPM not found"

    let result = ExecProcess (fun info ->
        info.FileName <- npm
        info.Arguments <- "install bootstrap-switch@"+npmVersion) (System.TimeSpan(0, 2, 0))
    match result with
        | OK -> trace "Done building installing node modules"
        | _ -> failwith "Failed to build install node modules"
)

Target "NuGetCss" (fun _ ->
    ensureDirectory pkgDir
    "Bootstrap.Switch.nuspec"
        |> NuGet (fun p -> 
            {p with
                Project = "Bootstrap.Switch"
                WorkingDir = "./"
                OutputPath = pkgDir
                Version = nugetVersion
                Publish = publish
            })
)

Target "NuGetLess" (fun _ ->
    ensureDirectory pkgDir
    "Bootstrap.Switch.Less.nuspec"
        |> NuGet (fun p -> 
            {p with
                Project = "Bootstrap.Switch.Less"
                WorkingDir = "./"
                OutputPath = pkgDir
                Version = nugetVersion
                Publish = publish
            })
)

Target "GitPush" (fun _ ->
    Branches.push "./"
)

Target "GitTag" (fun _ ->
    let tagName = ("v"+nugetVersion)
    Branches.tag "./" tagName
    Branches.pushTag "./" "origin" tagName
)

Target "Clean" DoNothing
Target "Default" DoNothing

"Clean"
    ==> "NpmInstall"
    ==> "NuGetCss"
    ==> "NuGetLess"
    =?> ("GitPush", publish)
    =?> ("GitTag", publish)
    ==> "Default"

"CleanNpm" ==> "CleanPkg" ==> "Clean"

RunTargetOrDefault "Default"