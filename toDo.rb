require 'colorize'
require 'json'

puts "---------------Welcome toDOS------------"

# # create json file where the tasks will be saved
tasks_file = "tasks.json"

# load the file if exist if not create a new one
if File.exist?(tasks_file)
  tasks = JSON.parse(File.read(tasks_file))
else
  tasks = []
end

#  open the file and write it to save it
def save_tasks(tasks, file)
  File.open(file, 'w') do |f|
    f.write(tasks.to_json)
  end
end

# show the principal menu

loop do

puts "select an option: "
puts "1. Show all tasks"
puts "2. Check it as completed"
puts "3. Delete task"
puts "4. Add a new task"
puts "5. Exit"

option =  gets.chomp.to_i
case option
when 1
  #show tasks list
  puts "Task list:".colorize(:yellow)
  tasks.each_with_index do |task, index|
    puts "#{index+1}. #{task["name"]} [#{task['completed'] ? 'Completed'.colorize(:green) : "Pending".colorize(:red)}]"
  end
when 2
# show task as completed
  puts "Introduce the task number to show as completed: "
  task_index = gets.chomp.to_i - 1

  if task_index >=0 && task_index < tasks.length
    tasks[task_index]['completed'] = true
    puts "Tasks #{tasks[task_index]["name"]} to show as completed".colorize(:green)
    save_tasks(tasks, tasks_file)
  else
    puts "Invalid task number"
  end

when 3
  # Delete tasks
  puts "Introduce the number of the task to delete: "
  task_index = gets.chomp.to_i - 1

  if task_index >= 0 && task_index < tasks.length
    task_name = tasks[task_index]['name']
    tasks.delete_at(task_index)
    puts "Task  #{task_name} deleted".colorize(:green)
    save_tasks(tasks, tasks_file)
  else
    puts "Invalid number"
  end
when 4
  # Añadir nueva tarea
  puts "Introduce a new task:"
  task_name = gets.chomp

  task = {
    'name' => task_name,
    'completed' => false
  }
  tasks << task

  puts "Task #{task_name} added".colorize(:green)
  save_tasks(tasks, tasks_file)
when 5
  # Exit
  break
else
  puts "Opción inválida"
 end
end







