module Quickbuild::Config

  FAKE_CONFIG_ID = '100'

  FAKE_CONFIG_PATHS = {
    '1' => 'root',
    '2' => 'root/level-1',
    '3' => 'root/level-1/level-2',
    '4' => 'root/level-1-2'
  }

  FAKE_CONFIG_LIST_RESPONSE = <<RESPONSE
<?xml version="1.0" encoding="UTF-8"?>
<list>
  <com.pmease.quickbuild.model.Configuration>
    <id>1</id>
    <disabled>false</disabled>
    <name>#{FAKE_CONFIG_PATHS['1']}</name>
  </com.pmease.quickbuild.model.Configuration>
  <com.pmease.quickbuild.model.Configuration>
    <id>2</id>
    <disabled>false</disabled>
    <name>#{FAKE_CONFIG_PATHS['2']}</name>
    <parent>1</parent>
  </com.pmease.quickbuild.model.Configuration>
  <com.pmease.quickbuild.model.Configuration>
    <id>3</id>
    <disabled>false</disabled>
    <name>#{FAKE_CONFIG_PATHS['3']}</name>
    <parent>2</parent>
  </com.pmease.quickbuild.model.Configuration>
  <com.pmease.quickbuild.model.Configuration>
    <id>4</id>
    <disabled>false</disabled>
    <name>#{FAKE_CONFIG_PATHS['4']}</name>
    <parent>1</parent>
  </com.pmease.quickbuild.model.Configuration>
</list>
RESPONSE

end
