# resource "aws_dynamodb_table" "basic-dynamodb-table" {
#   name           = "NeuefischeExampleTable"
#   hash_key       = "Fisch"
#   read_capacity  = 1
#   write_capacity = 1
#   billing_mode = "PROVISIONED"

#   attribute {
#     name = "Fisch"
#     type = "S"
#   }

#   global_secondary_index {
#     name = "ExampleFisch"
#     hash_key = "Occupation"
#     write_capacity = 1
#     read_capacity = 1
#     projection_type = "ALL"
#   }

#   attribute {
#     name = "Occupation"
#     type = "S"
#   }

#   tags = {
#     Name = "FischTable"
#   }
# }

# resource "aws_dynamodb_table_item" "dynamo_fische_item_1" {
#   table_name = aws_dynamodb_table.basic-dynamodb-table.name
#   hash_key = aws_dynamodb_table.basic-dynamodb-table.hash_key

#   item = <<ITEM
#   {
#     "Fisch": {"S": "An AWS guppi"},
#     "Occupation": {"S": "Develops things"}
#   }
#   ITEM
# }

# resource "aws_dynamodb_table_item" "dynamo_fische_item_2" {
#   table_name = aws_dynamodb_table.basic-dynamodb-table.name
#   hash_key   = aws_dynamodb_table.basic-dynamodb-table.hash_key
  
#   item = <<ITEM
#   {
#     "Fisch": {"S": "An AWS whale"},
#     "Occupation": {"S": "Does mostly Docker things"}
#   }
#   ITEM
# }
