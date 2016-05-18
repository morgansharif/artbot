class QuestionsController < ApplicationController
before_action :authenticate_admin!

  def index
    @questions = Question.all
    render :index
  end

  def new
    @art = Art.find(params[:art_id])
    @question = Question.new
    render :new
  end

  def create
    @art = Art.find(params[:art_id])
    @question = Question.create(question_params)
    set_art.questions << @question
    if @question.save
      redirect_to art_path(@art)
    else
      render :new
    end
  end

  def edit
    set_question
    render :edit
  end

  def update
    set_question
    if @question.update(question_params)
      redirect_to questions_path
    else
      render :edit
    end
  end

  def destroy
    question = Question.find(params[:id])
    question.destroy
    redirect_to question_path
  end

  private

  def set_art
    @art = Art.find(params[:art_id])
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:text, :answer, :art_id)
  end

end
