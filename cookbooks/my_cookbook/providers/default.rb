action :create do
	file new_resource.path do
		content "#{new_resource.name} #{new_resource.title}"
		action :create
	end	
end
action :remove do
	file new_resource.path do
		action :delete
	end	
end
