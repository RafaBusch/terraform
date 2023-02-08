variable "name" {
  type        = string
  description = "bucket name"
}

variable "acl" {
  type        = string
  description = ""
  default     = "private"
}

variable "policy" {
  type        = string
  description = ""
  default     = "null"
}

variable "tags" {
  type        = map(string)
  description = ""
  default     = {}
}

variable "key_prefix" {
  type    = string
  default = ""
}

variable "files" {
  type    = string
  default = ""
}

variable "website" {
  description = "map containing website config"
  type        = map(string)
  default     = {}
}