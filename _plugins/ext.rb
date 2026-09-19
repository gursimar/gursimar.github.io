require "jekyll/scholar"
require "bibtex/entry"

# Compatibility for bibtex-ruby 4.x on Ruby 3. Apply this while plugins are
# loaded: Jekyll 3 does not run the site pre_render hook used previously.
module BibTeXRuby3BibliographyEach
  def each(&block)
    return to_enum unless block

    data.each(&block)
    self
  end
end

module BibTeXRuby3EntryEach
  def each(&block)
    return to_enum unless block

    fields.each(&block)
    self
  end
end

BibTeX::Bibliography.prepend(BibTeXRuby3BibliographyEach)
BibTeX::Entry.prepend(BibTeXRuby3EntryEach)

Jekyll::Hooks.register :site, :post_read do
  BibTeX::Bibliography.prepend(BibTeXRuby3BibliographyEach) unless BibTeX::Bibliography < BibTeXRuby3BibliographyEach
  BibTeX::Entry.prepend(BibTeXRuby3EntryEach) unless BibTeX::Entry < BibTeXRuby3EntryEach
end
