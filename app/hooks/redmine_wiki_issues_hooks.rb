class RedmineWikiIssuesHooks < Redmine::Hook::ViewListener
    def controller_wiki_edit_after_save(context = {})
      wiki_page = context[:page]
      params = context[:params]
      project = wiki_page.wiki.project
      wiki_content = wiki_page.content.text
  
      # Check if the plugin is enabled for this project and 
      #  see if we should perform the scanning and processing of the wiki_content
      if plugin_enabled?(project) && wiki_content.include?("- [ ]")
        Rails.logger.info("Checking for Markdown checkmarks in Wiki page: #{wiki_page.title}")
  
        # Instantiate the controller
        controller = WikiIssuesController.new
  
        # Call the generate_issues function
        controller.generate_issues(params, wiki_page)
      end
    end
  
    private
  
    def plugin_enabled?(project)
      project.enabled_modules.exists?(name: 'redmine_wiki_issues')
    end
  
  end