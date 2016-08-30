class VotesController < ApplicationController

before_action :data, only:[:index]

  def index
    if params[:movie]
      find_movie
      value = vote_value(@movie)
    elsif params[:comment]
      find_comment
      value = vote_value(@comment)
    else params[:review]
      find_review
      value = vote_value(@review)
    end
      return render json: value
  end

  def upvote
    if params[:movie]
      find_movie
      type = "Movie"
      create_upvote(type)
      value = vote_value(@movie)
    elsif params[:comment]
      find_comment
      type = "Comment"
      create_upvote(type)
      value = vote_value(@comment)
    else params[:review]
      find_review
      type = "Review"
      create_upvote(type)
      value = vote_value(@review)
    end
      return render json: value
  end

  def downvote
    if params[:movie]
      find_movie
      type = "Movie"
      create_downvote(type)
      value = vote_value(@movie)
    elsif params[:comment]
      find_comment
      type = "Comment"
      create_downvote(type)
      value = vote_value(@comment)
    else params[:review]
      find_review
      type = "Review"
      create_downvote(type)
      value = vote_value(@review)
    end
      return render json: value
  end

  def create
  end

private
  def data
    params.permit(:movie)
    params.permit(:comment)
    params.permit(:review)
  end

  def vote_value(voteable)
    up_count = voteable.votes.where(up?: true).length
    down_count = voteable.votes.where(up?: false).length
    return up_count - down_count
  end

  def find_movie
    @movie = Movie.find(params[:movie][:id])
  end

  def find_comment
    @comment = Comment.find(params[:comment][:id])
  end

  def find_review
    @review = Review.find(params[:review][:id])
  end

  def create_upvote(type)
    Vote.create(user_id: current_user.id, up?: true, voteable_type: type, voteable_id: params[:movie][:id] )
  end

  def create_downvote(type)
    Vote.create(user_id: current_user.id, up?: true, voteable_type: type,voteable_id: params[:movie][:id])
  end
end
