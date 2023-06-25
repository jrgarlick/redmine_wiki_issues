# Redmine Wiki Issues Generator

** **PROTOTYPE PLUGIN - USE AT YOUR OWN RISK** **

This simple [Redmine](https://www.redmine.org/) plugin automatically generates Issues out of lines in your wiki pages that use the Markdown checkbox notation. As it creates the new issues, it modifies the wiki page and adds the issue's ID link into the location. This makes it very easy to maintain strong tracking for tracking actions during meetings or discussions.

## Installation

1. Simply clone this repository into your Redmine's `plugin/` directory.
2. 
3. No database migration is needed.
4. Restart Redmine.
5. After restarting, go into your project's settings and enable the `Redmine wiki issue` module.

## Future Enhancement Ideas

* Build Unit tests
* Automatic assignment with the `:assignTo @<email>` notation
* Set Issue Due date with `:due <date>` format
* Link back to Wiki page from Issue to help increase the connection between the Issue and the original note



