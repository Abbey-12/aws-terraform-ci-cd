resource "aws_api_gateway_rest_api" "main" {
  name        = "MyAPI"
  description = "My API Description"
}

resource "aws_api_gateway_resource" "resource" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_rest_api.main.root_resource_id
  path_part   = "myresource"
}

resource "aws_api_gateway_method" "method" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = "GET"
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = aws_api_gateway_method.method.http_method

  integration_http_method = "GET"
  type                   = "HTTP"
  uri                    = "http://${aws_instance.backend.private_ip}:<your_backend_port>"
}

resource "aws_api_gateway_deployment" "deployment" {
  depends_on      = [aws_api_gateway_integration.integration]
  rest_api_id      = aws_api_gateway_rest_api.main.id
  stage_name       = "prod"
  deployment_stage = {
    description = "Production"
    cache_cluster_enabled = false
    cache_cluster_size    = "0.5"
  }
}

resource "aws_instance" "backend" {
  ami           = "ami-xxxxxxxxxxxxxxxxx"  # Specify the AMI ID of your desired operating system
  instance_type = "t2.micro"  # Adjust instance type as needed

  tags = {
    Name = "MyBackendInstance"
  }

  // Add other necessary configuration options, such as security groups, key_name, etc.
}
