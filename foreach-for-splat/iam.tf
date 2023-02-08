resource "aws_iam_user" "contas" {
  for_each = toset(["Rafael-22", "Mateus-24", "Joao-24", "Douglas-24"])
  name     = each.key #each.key e each.value are the same for a set
}