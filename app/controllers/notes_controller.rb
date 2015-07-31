class NotesController < ApplicationController
  def index
    @notes = Note.all
  end

  def new
    put "New Note"
    @note = Note.new
  end

  def create
    begin
      @note = Note.new(note_params)
      if @note.save
        render :json => @note.id
      end
    rescue
      render :json => { :errors => "unknown error"}, :status => 500
    end
  end

  private
    def note_params
      params.require(:note).permit(:text)
    end
end
