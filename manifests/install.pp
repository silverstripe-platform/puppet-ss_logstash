class ss_logstash::install {
  class { 'logstash':
    jvm_options => [
      '-Djava.net.preferIPv4Stack=true',
      "-Xms${ss_logstash::ls_heap_size}",
      "-Xmx${ss_logstash::ls_heap_size}"
    ],
    startup_options => {
      'LS_OPTS' => "--path.settings=\${LS_SETTINGS_DIR} ${ss_logstash::ls_opts}",
      'LS_NICE' => "${ss_logstash::ls_nice}"
    },
    pipelines => [
      {
        "pipeline.id" => "inputs",
        "path.config" =>  "/etc/logstash/conf.d/inputs.conf",
      },
      {
        "pipeline.id" => "graylog",
        "path.config" =>  "/etc/logstash/conf.d/graylog.conf",
      },
      {
        "pipeline.id" => "S3",
        "path.config" =>  "/etc/logstash/conf.d/s3.conf",
      },
    ]
  }

  logstash::plugin { 'logstash-input-lumberjack': }
  logstash::plugin { 'logstash-input-beats': }
  logstash::plugin { 'logstash-input-gelf': }
  logstash::plugin { 'logstash-output-gelf': }
}
