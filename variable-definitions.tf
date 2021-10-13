# The following are set in terraform.tfvars

variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
  sensitive   = true
}

variable "ssh_key_ids" {
  description = "List of public SSH key IDs to attach to the droplet (~/.ssh/authorized_keys)"
  type        = list(string)
  default     = []
}

variable "mail_verification_record" {
  description = "Text value for Zoho mail TXT DNS verification"
  type        = string
  sensitive   = true
}

variable "mail_spf_record" {
  description = "Text value for SPF mail record"
  type        = string
  sensitive   = true
}
