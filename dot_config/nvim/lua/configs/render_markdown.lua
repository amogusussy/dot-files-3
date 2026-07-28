require('render-markdown').setup({
  latex = {
    -- Turn on / off latex rendering.
    enabled = true,
    -- Additional modes to render latex.
    render_modes = true,
    -- Executable used to convert latex formula to rendered unicode.
    -- If a list is provided the commands run in order until the first success.
    converter = { 'utftex', 'latex2text' },
    -- Highlight for latex blocks.
    highlight = 'RenderMarkdownMath',
    position = 'center',
    -- Number of empty lines above latex blocks.
    top_pad = 0,
    -- Number of empty lines below latex blocks.
    bottom_pad = 0,
  },
})
