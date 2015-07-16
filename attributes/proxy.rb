default['nginx']['proxy']['cache_enable'] = true
default['nginx']['proxy']['location'] = [
  '/' =>
  {
    'proxy_cache_path' => '/tmp/nginx',
    'proxy_pass' => 'http://127.0.0.1:8000'
  }
]

default['nginx']['proxy']['cache']['proxy_cache_path']['/tmp/nginx'] =  {
    'levels' => '1:2',
    'keys_zone' => "#{node['nginx']['proxy']['proxy_cache']}:10m",
    'inactive' => '60m'
  }
default['nginx']['proxy']['cache']['proxy_cache_key'] = '$scheme$request_method$host$request_uri'
default['nginx']['proxy']['cache']['location'] =  [
    '\.(?:jpg|jpeg|gif|png|ico|cur|gz|svg|svgz|mp4|ogg|ogv|webm|htc)$' =>
    {
      'expires' => '1M',
      'access_log' => 'off',
      'add_header' => 'Cache-Control "public"'
    }
 ]
