node[:deploy].each do |application, deploy| 

      service "nginx" do
        supports :status => true
        action :nothing
      end

      
      template "setup nginx" do
        path "/etc/nginx/sites-available/#{application}-redirects"
        source "http_redirect.conf.erb"
        owner "root"
        group "root"
        mode 0644
        notifies :restart, "service[nginx]", :delayed
      end   
      
      link "/etc/nginx/sites-enabled/#{application}-redirects" do
        to "/etc/nginx/sites-available/#{application}-redirects"
      end
      
                                
end

