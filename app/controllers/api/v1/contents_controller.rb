class Api::V1::ContentsController < ApplicationController
  before_action :authenticate_user, except: [:show, :index]

  def index
    #Get all Contents by ID Project
    if Content.exists?
      #Table isn't empty
      resultData = Array.new

      # Iterate over the rows
      @contentQueryResult = Content.where(projectId: params[:id])
      #@contentQueryResult = Content.join(:bar).select(:value_1, :value_2, :value_3)
      #                        .where('bars.table3_id = ?, table3_id_value)

      if @contentQueryResult.present?

        #emailData = Project.where(id: params[:id]).select(:userEmail)
        #userData = User.find_by_email(emailData.userEmail)
        emailData = Project.find_by(id: params[:id])
        userData = User.find_by_email(emailData.userEmail)

        @contentQueryResult.all.each do |myData|
          contentData =
            {
              "id": myData.id,
              "type": "content",
              "attributes": {
                "projectId": myData.projectId,
                "projectOwnerName": userData.firstName+" "+userData.lastName,
                "title": myData.title,
                "body": myData.body,
                "createdAt": myData.created_at,
                "updatedAt": myData.updated_at
              }
            }
          resultData.push(contentData)
        end
        render(json: {"data": resultData}, status: :created)
      else
        render(json: "No Related Content to the Project is unavailable.", status: :unprocessable_entity)
      end

    else
      #Table is empty
      render(json: "Content Table is empty" , status: :unprocessable_entity)

    end

  end


  def show

    contentData =  Content.where(:projectId => params[:id]).find_by(params[:contentId])

    if contentData.present?
      user = User.find_by(params[:id])
      finalData =
         {
            "id": contentData.id,
            "type": "content",
            "attributes": {
              "projectId": contentData.projectId,
              "projectOwnerName": user.firstName+" "+user.lastName,
              "title": contentData.title,
              "body": contentData.body,
              "createdAt": contentData.created_at,
              "updatedAt": contentData.updated_at
            }
         }
      render(json: {"data": finalData} , status: :created)
    else
      render(json: "Requested Content Unavailable." , status: :unprocessable_entity)
    end
  end

  def create

    @checkRightOwner = Project.where(userEmail: current_user.email, id: params[:id])
    if @checkRightOwner.present?

      #insert project ID from url to params
      modify_params
      @content = Content.create!(contents_params)
      if @content.save
        finalMessage = {
            "id": @content.id,
            "type": "content",
            "attributes": {
            "projectId": @content.projectId,
            "projectOwnerName": current_user.firstName+" "+current_user.lastName,
            "title": @content.title,
            "body": @content.body,
            "createdAt": @content.created_at,
            "updatedAt": @content.updated_at
            }
        }
        render(json: {"data": finalMessage}, status: :created)
      end
    else
      render(json: {"data": "Restricted Project"}, status: :unauthorized)
    end
  end

  def update

  end

  def destroy

  end

  private
  def contents_params
    params.permit(:title, :body, :projectId)
  end

  def modify_params

    params.merge!({:projectId => params[:id]})
    params['content'].merge!({:projectId => params[:id]})
  end
end
