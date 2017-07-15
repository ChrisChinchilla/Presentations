# Agile writing and CI

I am new to this, it's not complete, more a bundle of ideas. Only 20 minutes, more of a brain dump of ideas, so more fully formed than others. *Excuse the bad writing!*

## Why

Documentation comes from a variety of sources, or we are human and don't spot everything. Using CI tools for writing we can make some checks part of a software build process to help us spot mistakes and point them out to other contributors.

As a bonus, we can also use CI tools to automate some common documentation tasks, not just to save us time but again ti help us spot inaccuracies and problems.

## Spelling, Grammar and good writing

### Spelling

At the moment I am using 'markdown-spellcheck', this is mostly for Markdown, there are other similar options for other languages, or at some point ideally I want to use a wrapper around aspell as that's more integrated with desktop clients and people can share a dictionary among the company.

#### Show Codeship simple example

<https://app.codeship.com/projects/157409/configure_tests>

Show how dictionary is a gitsubmodule and how it works.

```bash
mdspell -r -n -a --en-us *.md || true
```

This runs the spell check over all markdown files in report mode (`-r`), ignoring numbers (`-n`) and acronyms (`-a`) with a US English dictionary. There are more configuration options available.

What does `true` mean and other ways of doing this with other CI tools.

Then show the output by forcing a build, mention how this could be improved in the future, and do you want to break the build or not. Ideally a linter is meant as guidance, not punishment.

### Grammar / Writing better

What exactly this means is unclear, but these tools can help you spot potential clarity of writing issues.

My favourite is the 'write-good' linter, but there are others available too.

It works in a similar way to the spellchecker.

```bash
write-good *.md || true
```

The main options are to include or exclude specific tests,

```bash
write-good *.md --weasel --so
```

Or by excluding them with `no-`:

```bash
write-good *.md --no-weasel --no-so
```

Again, show examples and output, same as before really.

## Testing code

Code examples in docs that don't work or are outdated are a poor user experience and there are a variety of ways to test them, that can depend on if it's an API, what programming language etc.

For our API we are currently using Dredd, which is primarily for APIs.

Show examples of API blueprint, then Travis output and hooks examples. Hooks allow you to execute some processing around the tests, clean up, initialisation etc.

Testing inline code is something I'm still trying.

Sphinx handles it for Python, I'm sure we used it for other things.

## Images and Videos

These are getting more interesting, and I haven't completely implemented these myself. Especially with asciinema, this is somewhat hypothetical.

### Images

Most of this is borrowed from plone and I haven't got around to testing this in my documentation yet. Thanks to those folks.

Things like webdrivers, selenium, phantomjs, robot framework.

Also AppleScript, fastlane.

Show example from JetBrains and Plone.

```bash
make screenshots-phantomjs
```

### Videos

The wonderful asciinema records terminal output as json and then embed it into docs. So in theory, using it's JSON format, you could generate this semi-automatically and then embed the result into docs.

Show json file, and can embed.

<script type="text/javascript" src="https://asciinema.org/a/14.js" id="asciicast-14" async="" data-autoplay="true" data-size="big">
</script>


### Code examples

Something else I've been looking into is live code playgrounds and examples, again this is still in progress, but similarly to the videos, the ability to autogenerate the code and then feed into a form of emulator / console gives a lot of flexibility and updateability. Especially JavaScript.

Send to Jupyter, RunKit embed, JSFiddle.

## Wrap up

All this stuff takes time, but it pays off in the end, not just time wasted, but so that mistakes don't get missed as computers are much better at this stuff than us.
