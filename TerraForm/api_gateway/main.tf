provider "aws" { region = "us-east-2" }

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "lambda.py"
  output_path = "lambda.zip"
}

resource "aws_lambda_function" "lambda" {
  for_each      = toset(["reader", "writer"])
  function_name = each.value

  filename = "lambda.zip"
  role     = aws_iam_role.iam_for_lambda.arn
  handler  = "lambda.handler"
  runtime  = "python3.9"

  source_code_hash = data.archive_file.lambda.output_base64sha256
}

resource "aws_api_gateway_rest_api" "x" {
  name = "test"
}

resource "aws_api_gateway_method" "root" {
  rest_api_id   = aws_api_gateway_rest_api.x.id
  resource_id   = aws_api_gateway_rest_api.x.root_resource_id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "root" {
  rest_api_id = aws_api_gateway_rest_api.x.id
  resource_id = aws_api_gateway_method.root.resource_id
  http_method = aws_api_gateway_method.root.http_method

  integration_http_method = "POST"

  type = "AWS_PROXY"
  uri  = aws_lambda_function.lambda.invoke_arn
}

resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.x.id
  parent_id   = aws_api_gateway_rest_api.x.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy" {
  rest_api_id   = aws_api_gateway_rest_api.x.id
  resource_id   = aws_api_gateway_resource.proxy.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda" {
  rest_api_id = aws_api_gateway_rest_api.x.id
  resource_id = aws_api_gateway_method.proxy.resource_id
  http_method = aws_api_gateway_method.proxy.http_method

  integration_http_method = "POST"

  type = "AWS_PROXY"
  uri  = aws_lambda_function.lambda.invoke_arn
}

resource "aws_api_gateway_deployment" "deploy" {
  depends_on = [
    aws_api_gateway_integration.lambda,
    aws_api_gateway_integration.root,
  ]

  rest_api_id = aws_api_gateway_rest_api.x.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_rest_api.x.body,
    ]))
  }
}

resource "aws_api_gateway_stage" "deploy" {
  deployment_id = aws_api_gateway_deployment.deploy.id
  rest_api_id   = aws_api_gateway_rest_api.x.id
  stage_name    = "test"
}
