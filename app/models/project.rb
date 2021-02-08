class Project < ApplicationRecord
  #enum type: {in_house: 0, external: 1, international:2 }

  #alias_attribute :projectType, :type
  enum projectType: [:in_house, :external, :international ]

  validates :title, :location, :projectType, presence:true

end
