Employee.find_or_create_by({ first_name: "山田",
                  last_name: "太郎",
                  slack_user_id: SecureRandom.hex(6),
                  slack_user_name: 'test.tarou1' })

Employee.find_or_create_by({ first_name: "",
                  last_name: "",
                  slack_user_id: SecureRandom.hex(6),
                  slack_user_name: 'test.tarou2' })

Employee.find_or_create_by({ first_name: "木村",
                  last_name: "太郎",
                  slack_user_id: SecureRandom.hex(6),
                  slack_user_name: 'test.tarou3' })

Employee.find_or_create_by({ first_name: "森",
                  last_name: "太郎",
                  slack_user_id: SecureRandom.hex(6),
                  slack_user_name: 'test.tarou4' })

Employee.find_or_create_by({ first_name: "山岡",
                  last_name: "太郎",
                  slack_user_id: SecureRandom.hex(6),
                  slack_user_name: 'test.tarou5' })

Employee.find_or_create_by({ first_name: "三田",
                  last_name: "太郎",
                  slack_user_id: SecureRandom.hex(6),
                  slack_user_name: 'test.tarou6' })

Employee.find_or_create_by({ first_name: "原田",
                  last_name: "太郎",
                  slack_user_id: SecureRandom.hex(6),
                  slack_user_name: 'test.tarou7' })

Employee.find_or_create_by({ first_name: "",
                  last_name: "",
                  slack_user_id: SecureRandom.hex(6),
                  slack_user_name: 'test.tarou8' })
