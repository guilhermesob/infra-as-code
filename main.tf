provide "aws" {
    region = "us-east-1"
}

variable "bucket_name" {
    type = string
}

resource "aws_s3_bucket" "static_site_bucket" {
    bucekt = "static-site-${var.bucket_name}"

    webiste {
        index_document = "index.html"
        error_document = "404.html"
    }

    tags = {
        Name = "static_site_Bucket"
        Enviroment = "Production"
    }
}

resource "aws_s3_bucket_public_access_block" "static_site_bucket" {
    bucket = aws_s3_bucket.static_site_bucket.id

    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false
}

resource "aws_s3_bucket_ownersnip_controls" "static_site_bucket" {
    bucket = aws-s3_bucket.static_site_bucket.id
    rule {
        object_ownership = "Bucket0wnerPreferred"
    }
}

resource "aws_s3_bucket_acl" "static_site_bucket" {
    depends_on = [
        aws_s3_bucket_public_access_block.static_site_bucket,
        aws_s3_bucket_ownersnip_controls.static_site_bucket
    ]

    bucket = aws_s3_bucket.static_site_bucket.id
    acl    = "public-read"

}