class CreateDiagnoses < ActiveRecord::Migration[5.0]
  def change
    create_table :diagnoses do |t|
      t.string :name
      t.string :_cve_cie10
      t.date :diagnose_day

      t.timestamps
    end
  end
end
