# coding: utf-8
# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'securerandom'
JournalType.create!([
                      {name: '支出'},
                      {name: '収入'}
                    ])
spend_id = JournalType.where(name: '支出').first[:id]
income_id = JournalType.where(name: '収入').first[:id]
Journal.create!([
                  {name: '給料', amount: 300000, journal_type_id: income_id },
                  {name: '食費', amount: 1000, journal_type_id: spend_id }
                ])

User.create!([
               {
                 email: 'test1@tmail.com',
                 password: 'testtest',
                 name: 'test1',
                 token: SecureRandom.alphanumeric(45)
               },
               {
                 email: 'test2@tmail.com',
                 password: 'testtest',
                 name: 'test2',
                 token: SecureRandom.alphanumeric(45)
               }
             ])

UserJournal.create!([
                      {
                        user_id: User.find_by(email: 'test1@tmail.com').id,
                        journal_id: Journal.find_by(name: '給料').id
                      },
                      {
                        user_id: User.find_by(email: 'test1@tmail.com').id,
                        journal_id: Journal.find_by(name: '食費').id
                      }
                    ])
