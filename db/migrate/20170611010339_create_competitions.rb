class CreateCompetitions < ActiveRecord::Migration[5.0]
  def change
    create_table :competitions do |t|
      t.belongs_to :league, index: true
      t.belongs_to :season, index: true
      t.timestamps
    end
  end
end
