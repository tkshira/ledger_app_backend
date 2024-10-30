class TransactionsController < ApplicationController
  before_action :get_transaction, only: [ :show, :update, :destroy ]
  skip_before_action :authorized, include: [ :transaction_by_month ]
  def index
    if @current_user
      transactions = Transaction.where(user_id: @current_user.id)

      render json: transactions
    end
  end

  def show
    if @current_user && @current_user.id == @transaction.user_id
      render json: @transaction
    end
  end

  def create
    if @current_user
      @transaction = Transaction.create(transactions_param)
      @transaction.user_id = @current_user.id

      if @transaction.save
        render json: { message: "Transaction saved" }
      else
        render json: { message: @transaction.errors() }, status: :unprocessable_entity
      end
    end
  end

  def update
    if @current_user && @current_user.id == @transaction.user_id
      if @transaction.update(transactions_param)
        render json: { message: "Transaction updated" }
      else
        render json: { message: @transaction.errors() }, status: :unprocessable_entity
      end
    end
  end

  def destroy
    if @current_user.id == @transaction.user_id
      if @transaction.delete()
        render json: { message: "Transaction deleted" }
      else
        render json: { message: @transaction.errors() }, status: :unprocessable_entity
      end
    end
  end

  def transaction_by_month
    transactions = Transaction.where("user_id = :user_id AND strftime('%m', date) = :month AND strftime('%Y', date) = :year ", {
      user_id: 4,
      # user_id: @current_user.id,
      month: params[:month],
      year: params[:year]
    }).order(:date)

    render json: transactions
  end

  private
    def transactions_param
      params.require(:transaction).permit(:transaction_type_id, :date, :value, :comment)
    end

    def get_transaction
      @transaction = Transaction.find(params[:id])
    end
end
