# PPTXMarkdown

## Getting Started

### Installation

```shell
gem install 'pptx_markdown'
```

## Usage

### to_markdown

Converts .pptx presentation to markdown.

Example:

```shell
pptx_markdown to_markdown path/to/markdown.md path/to/presentation.pptx
```

### to_pptx

Converts markdown document to .pptx presentation.

Example:

```shell
pptx_markdown to_pptx path/to/presentation.pptx path/to/markdown.md
```

### clean

Removes everything but text shapes from presentation.

Example:

```shell
pptx_markdown clean path/to/presentation.pptx path/to/clean_presentation.pptx
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
