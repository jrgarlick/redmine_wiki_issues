Redmine::Plugin.register :redmine_wiki_issues do
  name 'Redmine Wiki Issue plugin'
  author 'Jim Garlick'
  description 'This plugin will automatically create issues out of Markdown checkboxes when you save your wiki pages.'
  version '0.0.1'
  url 'https://github.com/jrgarlick/redmine_wiki_issues'
  author_url 'https://github.com/jrgarlick'

  project_module :redmine_wiki_issues do
    permission :create_wiki_issue, redmine_wiki_issues: :generateIssues
  end
end



