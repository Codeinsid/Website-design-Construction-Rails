namespace :dev do

  DEFAULT_PASSWORD = 123456

  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando Banco de dados..") {%x(rails db:drop:_unsafe)}
      show_spinner("Criando banco") {%x(rails db:create)} 
      show_spinner("Migrando o banco") {%x(rails db:migrate)}
      show_spinner("Cadastrando o administrador padrão..") {%x(rails dev:add_default_admin)}
      show_spinner("Cadastrando  administradores extras..") {%x(rails dev:add_extras_admins)}
      show_spinner("Cadastrando o usuario padrão..") {%x(rails dev:add_default_user)} 
    else
      puts "Você não está em modo de desenvolvimento!"
    end
  end

  desc "Adiciona o administrador padrão"
  task add_default_admin: :environment do
    Admin.create!(
    email: 'admin@admin.com',
    password: DEFAULT_PASSWORD,
    password_confirmation: DEFAULT_PASSWORD
    )
    end

    desc "Adiciona  administradores extras"
    task add_extras_admins: :environment do
      10.times do |i|
      Admin.create!(
        email: Faker::Internet.email,
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD
      )
      end
    end  
  desc "Adiciona o usuário padrão"
  task add_default_user: :environment do
    User.create!(
    email: 'user@user.com',
    password: DEFAULT_PASSWORD,
    password_confirmation: DEFAULT_PASSWORD
    )
    end
    
  private
  
  def show_spinner(msg_start, msg_end = "Concluido")
   spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin # Automatic animation with default interval
     yield
    spinner.success("(#{msg_end})") # Stop animation
  end
end