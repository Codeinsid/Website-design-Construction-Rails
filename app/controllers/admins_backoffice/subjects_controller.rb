class AdminsBackoffice::SubjectsController < AdminsBackofficeController
  before_action :set_subject, only: [:edit, :update, :destroy]
  
  def index
    @subjects = Subject.all.page(params[:page])
  end

  def new
    @subjects = Subject.new
  end

  def create
    @subjects = Subject.new(params_subject)
    if @subjects.save
      redirect_to admins_backoffice_subjects_path, notice: "Assunto/Área Cadastrado com Sucesso!"
    else
      render :new 
    end
  end

  def edit   
  end

  def update         
    if @subjects.update(params_subject)
      redirect_to admins_backoffice_subjects_path, notice: "Assunto/Área Atualizado com Sucesso!"
    else
      render :edit 
    end
  end

  def destroy
    if @subjects.destroy
      redirect_to admins_backoffice_subjects_path, notice: "Assunto/Área Excluido com Sucesso!"
    else
      render :index
    end
  end


  private

  def params_subject
    params.require(:subject).permit(:description)
  end

  def set_subject
    @subjects = Subject.find(params[:id])
  end

end

