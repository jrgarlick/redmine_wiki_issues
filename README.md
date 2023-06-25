# Redmine Wiki Issues Generator

** **PROTOTYPE PLUGIN - USE AT YOUR OWN RISK** **

This simple [Redmine](https://www.redmine.org/) plugin automatically generates Issues out of lines in your wiki pages that use the Markdown checkbox notation. As it creates the new issues, it modifies the wiki page and adds the issue's ID link into the location. This makes it very easy to maintain strong tracking for tracking actions during meetings or discussions.

## Supported Redmine Versions

* Currently only tested in Redmine v5.0.5

## Installation
![Alt text](image.png)
1. Simply clone this repository into your Redmine's `plugin/` directory.
2. No database migration is needed.
4. Restart Redmine.
5. After restarting, go into your project's settings and enable the `Redmine wiki issue` module.

## How to Activate

In the "Settings" of each project, check the "Redmie wiki issues" checkbox.

## Using the Plugin

Once the plugin is activated, using it is very simple. When you save your Wiki page, the plugin will automatically scan the content and look for any line that begins with the pattern: `- [ ]`. When it encounters this pattern, the plugin will generate a new issue and replace the space inside the backets with the issue number. 

You just need type in the new issue's text:

![](docs/editing-wiki-task.png)

When you save the wiki, it will create the new issue and replace the space with the issue number:

![Alt text](docs/saved-wiki-task.png)

Redmine already supports hanling creating links out of the issue number automatically. Clicking the link will bring you to the issue. The new issue's title is a combination of the name of the source wiki page and the remainder of the line of text. The description contains a link to the source wiki page.

![Alt text](docs/new-issue.png)

You can now use the issue as you would any other issue.

## Future Enhancement Ideas

* Build Unit tests
* Automatic assignment with the `:assignTo @<email>` notation
* Set Issue Due date with `:due <date>` format
* Link back to Wiki page from Issue to help increase the connection between the Issue and the original note
* Project-level configurations to choose the Tracker for the new Issues
* ~~Name the issue with the Wiki page name prefixed: ('`<wiki name> - <issue title>`')~~

