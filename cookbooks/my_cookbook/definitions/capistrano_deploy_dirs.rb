define :capistrano_deploy_dirs, :deploy_to => '' do
	Chef::Log.info("name : #{params[:name]}")
	directory "#{params[:deploy_to]}/releases"
	directory "#{params[:deploy_to]}/shared"
	directory "#{params[:deploy_to]}/shared/system"
end

