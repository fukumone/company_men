class TimeSheetSearchForm
  include ActiveModel::Model

  attr_reader :strategy

  validates :strategy,
            presence: true

  def initialize(strategy)
    @strategy = strategy
  end

  def list
    @strategy.list
  end

  def search
    @strategy.search
  end
end
