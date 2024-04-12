class ss_logstash::config {
  # input pipeline
  logstash::configfile { 'inputs':
    content => template('ss_logstash/inputs.erb'),
  } 

  $graylog_server = $ss_logstash::graylog_server
  $graylog_port = $ss_logstash::port

  # graylog pipeline
  logstash::configfile { 'graylog':
    content => template('ss_logstash/graylog.erb'),
  } 

  $s3_bucket_region = $ss_logstash::s3_bucket_region
  $s3_bucket_name = $ss_logstash::s3_bucket_name
  $s3_time_file = $ss_logstash::s3_time_file
  $s3_size_file = $ss_logstash::s3_size_file

  # S3 pipeline
  logstash::configfile { 's3':
    content => template('ss_logstash/s3.erb'),
  } 
}
