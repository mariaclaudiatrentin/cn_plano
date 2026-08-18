data "aws_iam_policy_document" "backup_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["backup.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "backup_role" {
  name               = "${var.project_name}-backup-role"
  assume_role_policy = data.aws_iam_policy_document.backup_assume_role.json
}

resource "aws_iam_role_policy_attachment" "backup_policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
  role       = aws_iam_role.backup_role.name
}

resource "aws_backup_vault" "app_vault" {
  name        = "${var.project_name}-backup-vault"
  
  tags = {
    Name = "${var.project_name}-backup-vault"
  }
}

resource "aws_backup_plan" "daily_backup" {
  name = "${var.project_name}-daily-backup-plan"

  rule {
    rule_name         = "daily-backup-rule"
    target_vault_name = aws_backup_vault.app_vault.name
    schedule          = "cron(0 5 ? * * *)"
    
    lifecycle {
      delete_after = 14
    }
  }

  tags = {
    Name = "${var.project_name}-daily-backup-plan"
  }
}

resource "aws_backup_selection" "app_selection" {
  iam_role_arn = aws_iam_role.backup_role.arn
  name         = "${var.project_name}-backup-selection"
  plan_id      = aws_backup_plan.daily_backup.id

  selection_tag {
    type  = "STRINGEQUALS"
    key   = "Backup"
    value = "true"
  }
}
