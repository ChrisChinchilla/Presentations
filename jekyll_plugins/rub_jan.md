# Creating a Plugin for Jekyll
_Ruby User Group, Berlin_


## About Me
![](GM-logo-draft.png)

Developer Relations and Technical Writing for hire!

Note: After 15 years of programming, realized I was better at this.


## I am a Roob(?)

Note: Mention years with Drupal, battling against a CMS, I am a content guy, not a ruby Expert.


## What is Jekyll?
![](jekyll_logo.png)

### Static Site Generator

- No Database
- Raw HTML
- Very Fast
- 'Somewhat' Dynamic Sites
- GitHub Pages*

Note: One of the first

### Tom Preston-Werner, 2008
v 3.0.1, 17/11/15

Note: Which is good as development stalled slightly when Tom left GitHub in 2014

### Ruby Gem

```bash
gem install jekyll
jekyll new rubyberlin
cd rubyberlin
jekyll serve
# => Now browse to http://localhost:4000
```

Note: Then a very quick overview of file structure


## Beyond Blogs
### Content Types
Note: Show folder and front matter, show config

### Templating
Note: Liquid, show page code and live


## Jekyll Plugins
\*Not on GitHub Pages

Note: Note

### The Simplest

```bash
cp ./*.rb _plugins
```

### The Rubykll Way

Require in *config.yml*:

```yaml
gems: [jekyll-picture-tag]
```

Install:

```bash
gem install jekyll-picture-tag
```

### The Ruby Way

In _Gemfile_:

```ruby
group :jekyll_plugins do
   gem "jekyll-picture-tag"
end
```

Install:

```bash
bundle install
```


## Make Your Own

### Generator

For creating additional content. Runs after content is catalogued but before site generated.

```ruby
module Jekyll
  class Generator < Jekyll::Generator
    def generate(site)
      # site.pages
      # site.documents
      # etc...
    end
  end
end
```

### Converter

For using new markup languages with a site.

```ruby
module Jekyll
  class PandocConverter < Converter
    safe true
    priority :low

    def matches(ext)
      ext =~ /^\.md$/i
    end

    def output_ext(ext)
      ".pdf"
    end

    def convert(content)
      content.pandoc
    end
  end
end
```

Note:
matches - Does the given extension match this converter’s list of acceptable extensions? Takes one argument: the file’s extension (including the dot). Must return true if it matches, false otherwise.

output_ext- The extension to be given to the output file (including the dot). Usually this will be ".html".

convert - Logic to do the content conversion. Takes one argument: the raw content of the file (without YAML Front Matter). Must return a String.

### Commands

Extending Jekyll executable with sub commands.

_Gemfile_

```ruby
group :jekyll_plugins do
  gem "pdf_plugin"
end
```

_Plugin_

```ruby
class PDFCommand < Jekyll::Command
  class << self
    def init_with_program(prog)
      prog.command(:pdf) do |c|
        c.syntax "new [options]"
        c.description 'Create PDFs of MD files.'
        c.option 'dest', '-d DEST', 'Where the PDFs should go.'
        c.action do |args, options|
          Jekyll::Site.pdf_my_md(options['dest'])
        end
      end
    end
  end
end
```
Note:

init_with_program - This method accepts one parameter, the Mercenary::Program instance, which is the Jekyll program itself. Upon the program, commands may be created using the above syntax. For more details, visit the Mercenary repository on GitHub.com.

### Tags

New Liquid Tags.

```ruby
module Jekyll
  class RenderTimeTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      @text = text
    end

    def render(context)
      "#{@text} #{Time.now}"
    end
  end
end

Liquid::Template.register_tag('render_time', Jekyll::RenderTimeTag)
```

Note:
render - Outputs the content of the tag.
And need Liquid register function

### And More...

- **Liquid Filters**: For Output processing / formatting
- **Flags**: For load priority and marking as `safe`
- **Hooks**: Fine grained control of the build process
- jekyllrb.com/docs/plugins

Note:


## Quick Example
One of my favourite plugins for responsive images:

https://github.com/robwierzbowski/jekyll-picture-tag/blob/master/lib/jekyll-picture-tag.rb


## Thank You!
Chris Ward

@chrischinch

gregariousmammal.com
