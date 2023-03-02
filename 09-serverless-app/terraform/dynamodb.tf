resource "aws_dynamodb_table" "this" {
  hash_key       = "todoid"
  name           = var.service_name
  read_capacity  = 5
  write_capacity = 5

  attribute {
    name = "todoid"
    type = "S"
  }

  tags = local.common_tags
}

resource "aws_dynamodb_table_item" "todo" {
  table_name = aws_dynamodb_table.this.name
  hash_key   = aws_dynamodb_table.this.hash_key

  item = <<ITEM
{
    "todoid": {"S": "1"},
    "Task": {"S": "Aprender Terraform"},
    "Done": {"S": "0"}
}
ITEM

}