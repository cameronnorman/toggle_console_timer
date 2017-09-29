require 'togglv8'
require 'json'
require 'yaml'
require 'pry'

task_description = ARGV[0].to_s
config = YAML.load_file('/home/cam/pers_dev/toggl_timer/config.yml')
# config = YAML.load_file('config.yml')
directory = `pwd`
directory = directory.gsub("\n", '')

open('/home/cam/pers_dev/toggl_timer/timesheet.log', 'a') do |file|
  toggl_api    = TogglV8::API.new(config["API_TOKEN"])
  projects = toggl_api.my_projects
  workspace_id = toggl_api.my_workspaces.last["id"]
  begin
    config_project_name = config["projects"].find{|p| p["directory"] == directory}["toggl_project"] rescue nil
    project_id = projects.find{|project| project["name"] == config_project_name}["id"] rescue nil
    file << "#{toggl_api.start_time_entry({'description'=>task_description, 'wid' => workspace_id, 'pid' => project_id})["id"]}\n"
    puts "Toggl timer started"
  rescue
    puts "Problem occurred while starting Toggl timer"
  end
end
