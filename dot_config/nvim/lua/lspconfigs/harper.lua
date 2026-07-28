vim.lsp.config("harper_ls", {
  filetypes = {
    "typst"
  },
  settings = {
    ["harper-ls"] = {
      userDictPath = "",
      workspaceDictPath = "",
      fileDictPath = "",
      linters = {
        SpellCheck = true,
        SpelledNumbers = true,
        AnA = true,
        SentenceCapitalization = true,
        UnclosedQuotes = true,
        WrongQuotes = true,
        LongSentences = true,
        RepeatedWords = true,
        Spaces = true,
        Matcher = true,
        CorrectNumberSuffix = true
      },
      diagnosticSeverity = "hint",
      isolateEnglish = false,
      dialect = "British",
      maxFileLength = 120000,
      ignoredLintsPath = {
      }
    }
  }
})

vim.lsp.enable({"harper_ls"})
