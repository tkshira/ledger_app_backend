class TransactionTypesController < ApplicationController
  def index
    @user = current_user
    if @user
      @types = TransactionType.where(user_id: @user.id)

      render json: @types
    end
  end

  def show
    @user = current_user
    if @user
      @transactiontype = TransactionType.find(params[:id])
      if @transactiontype.user_id == @user.id
        render json: @transactiontype
      end
    end
  end

  def create
    @user = current_user
    if @user
      @type = TransactionType.create(transactiontype_params)
      @type.user_id = user.id

      if @type.save
        render "Transaction Type saved successfully"
      else
        render json: user.errors, status: :unprocessable_entity
      end
    end
  end

  private
    def transactiontype_params
      params.require(:transaction_type).permit(:name, :direction)
    end
end
