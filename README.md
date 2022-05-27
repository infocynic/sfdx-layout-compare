# sfdx-layout-compare
Compares standard (aka classic) page layouts to show field presence/absence

# Prerequisites
1. nodeJS (any LTS version should be fine)
1. Powershell (native with Windows, [Mac instructions](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-macos))
1. A copy of the page layout XML from the org in SFDX format downloaded onto your machine (You can use VSCode, not covered here)
1. Optionally a copy of the field XML from the org in SFDX format under the same folder structure as above
1. Excel (you could do some modifications to the sheet template to make it work for Google Sheets probably, feel free to send a PR)

# Instructions for Use
1. Download the ps1 and js files and place them together somewhere easy to reference, e.g. %home%\scripts or something.
1. If jsdom isn't already installed, install it -- open any shell and run `npm i -g jsdom`
1. Open a powershell terminal and navigate to the base path of any the SFDX project
1. Type `./[path]/[to]/parse-sfdx-layouts.ps1` into the powershell terminal and hit enter. If powershell complains about the execution policy, run `Set-ExecutionPolicy -RemoteSigned -Confirm -Scope CurrentUser` and try again. 
     1. Windows users use a backslash to separate your paths. Powershell will help if you use TAB.
1. Wait a few minutes, especially for large orgs
1. Output will be placed into `layoutAnalysis` folder, subfolders for each object
     1. If you want to change this, open the `parseLayout.ps1` file and change the `$outputPath` variable
1. Copy the Excel somewhere (doesn't need to be in that folder, recommend you place it in Teams)
     1. You'll want one Excel per object, so rename to something like `Account Layouts.xlsx`
1. Open the Excel
1. (Note: if you understand what this is doing, you can use faster methods like pasting from Notepad)
   Use the Ribbon -> Data -> From Text/CSV ->
    1. Select the `000 [Object] Fields.txt`, then click Load
    1. On the new sheet, copy the field names. Paste them starting at cell A3 on the Compare sheet.
    1. Select the `001 [Object] Layout Names.txt` then click Load
    1. On the new sheet, copy the layout names. Change to the Compare sheet, place your cursor at cell B2, then click `Paste Special` on the Home Ribbon, and choose `Transpose`
    1. Delete the two extra sheets you just created
    1. In the `Queries` side panel (if you don't see it, click Data -> Queries and Connections in the Ribbon), Delete all the queries, confirming any prompts.
1. Repeat for each layout:
    1. From the Ribbon, click Data -> From Text/CSV
    1. Choose the `Layout name.csv` file
    1. Click Load
    1. In the `Queries` side panel (see 9.6), delete the new query, confirming any prompts.
1. On the Compare sheet, grab the formula in cell B3 and fill down and right to cover the full range.
1. If a field is present on a layout, TRUE appears in the column, else the column is blank.
