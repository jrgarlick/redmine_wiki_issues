class WikiIssuesController < ApplicationController
  def generate_issues(params, wiki_page)
    @wiki_page = wiki_page
    @project = @wiki_page.project

    wiki_content = @wiki_page.content.text
    updated_wiki_content = "";
    parent_issue_id = nil

    lines = wiki_content.split("\n")

    if lines.length > 0
      parent_issue_id = extract_project_id_number(lines[0])
      Rails.logger.info("  Wiki Issue Using Parent Issue #: #{parent_issue_id}")
    end

    lines.each do |line|
      updated_line = line
      if line.include?("- [ ]")
        issue_title = extract_issue_title(line)
        issue = create_issue(@wiki_page.title, issue_title, parent_issue_id)
        updated_line = update_wiki_content(line, issue.id);
        Rails.logger.info("  Wiki Issue Created Issue #: #{issue.id} named #{issue_title} tracker #{issue.tracker_id} in project #{issue.project_id}")
      end
      updated_wiki_content += updated_line + "\n"
    end

    if wiki_content == updated_wiki_content
      Rails.logger.info("  Saving updated Wiki Content")
      update_wiki_page_content(updated_wiki_content)
    end

  end

  private

  def extract_issue_title(line)
    line.gsub(/- \[ \]/, "").strip
  end

  def create_issue(wiki_title, issue_title, parent_id=nil)
    issue = Issue.new(
      parent_issue_id: parent_id,
      project: @project,
      tracker: @project.trackers.first,
      subject: "#{wiki_title} - #{issue_title}",
      description: "Created from Wiki Page: [[#{wiki_title}]]",
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

  def extract_project_id_number(string)
    match = string.match(/#(\d+)/)
    if match
      return match[1].to_i
    else
      return nil
    end
  end

end
