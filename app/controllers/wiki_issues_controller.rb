class WikiIssuesController < ApplicationController
  def generate_issues(params, wiki_page)
    @wiki_page = wiki_page
    @project = @wiki_page.project

    wiki_content = @wiki_page.content.text
    updated_wiki_content = "";

    lines = wiki_content.split("\n")
    lines.each do |line|
      updated_line = line
      if line.include?("- [ ]")
        issue_title = extract_issue_title(line)
        issue = create_issue(issue_title)
        updated_line = update_wiki_content(line, issue.id);
        Rails.logger.info("  Wiki Issue Created Issue #: #{issue.id} named #{issue_title} tracker #{issue.tracker_id} in project #{issue.project_id}")
        # add_note_to_issue(issue)
      end
      updated_wiki_content += updated_line + "\n"
    end

    update_wiki_page_content(updated_wiki_content)

  end

  private

  def extract_issue_title(line)
    line.gsub(/- \[ \]/, "").strip
  end

  def create_issue(issue_title)
    issue = Issue.new(
      project: @project,
      tracker: @project.trackers.first,
      subject: issue_title,
      author: User.current
    )
    issue.save
    issue
  end

  def update_wiki_content(line, issue_id)
    line.sub!("- [ ]", "- [\##{issue_id}]")
    line
  end

  def update_wiki_page_content(wiki_content)
    @wiki_page.content.text = wiki_content
    @wiki_page.save_with_content(@wiki_page.content)
  end
 
  # def add_note_to_issue(issue)
  #   issue.init_journal(User.current)
  #   issue.current_journal.notes = "This issue was created from the wiki."
  #   issue.current_journal.save
  # end

end
