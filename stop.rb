require 'date'
require 'time'
require 'yaml'
require 'pry'
require 'togglv8'
require 'json'

timesheet_log = File.read('/home/cam/pers_dev/toggl_timer/timesheet.log')
last_id = timesheet_log.split("\n").last
config = YAML.load_file('/home/cam/pers_dev/toggl_timer/config.yml')

toggl_api    = TogglV8::API.new(config["API_TOKEN"])
workspace_id = toggl_api.my_workspaces.last["id"]
begin
  response = toggl_api.stop_time_entry(last_id)
  puts "Toggl timer stopped"
rescue
  puts "No timer active"
end
