provider "aws" {
  region = "us-east-1"  # Adjust region as needed
}

resource "aws_wafv2_web_acl" "main" {
  name        = "MyWebACL"
  description = "Web ACL for My API"

  default_action {
    allow {}
  }

  rule {
    name     = "AllowAllTraffic"
    priority = 1

    action {
      allow {}
    }
  }

  rule {
    name     = "BlockSQLInjection"
    priority = 2

    statement {
      managed_rule_group_statement {
        name        = "SQLi-RuleSet"
        vendor_name = "AWS"
      }
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name               = "MyWebACLMetrics"
    sampled_requests_enabled  = true
  }
}

resource "aws_wafv2_rule_group" "managed_rule_group" {
  name        = "SQLi-RuleSet"
  scope       = "REGIONAL"
  capacity    = 1
  description = "Managed rule group for SQL injection"

  rule {
    name     = "SQLInjection_RULE"
    priority = 0

    action {
      block {}
    }

    statement {
      regex_pattern_set_reference_statement {
        name = "SQLiPatterns"
      }
    }
  }

  visibility_config {
    sampled_requests_enabled = true
    cloudwatch_metrics_enabled = true
  }
}

resource "aws_wafv2_regex_pattern_set" "regex_pattern_set" {
  name        = "SQLiPatterns"
  scope       = "REGIONAL"
  description = "Regex patterns for SQL injection"

  regular_expression {
    regex_string = ".*[Ss].*[Qq].*[Ll].*"
  }
}
