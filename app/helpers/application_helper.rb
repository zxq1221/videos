#coding: utf-8
module ApplicationHelper

  def video_time(time)
    if time.to_i >= 60
      return "#{time.to_i / 60} 分钟"
    else
      return "#{time.to_i} 秒"
    end
  end

  def symbol_truncate(string)
    symbol = ['」','】','》','}']
    symbol.each do |item|
      if string.to_s.include?(item)
        return (/.*(」|】|}|》)(.*)/im.match string)[2] if (/.*(」|】|}|》)(.*)/im.match string).present?
      end
    end
    return string
  end

  def rank_picture(user)
    num = user.sign_in_count
    if num < 5 #10
      return '/images/rank/rank-1.png'
    elsif num >= 5 && num < 15 # 20
      return '/images/rank/rank-2.png'
    elsif num >= 15 && num < 30 #40
      return '/images/rank/rank-3.png'
    elsif num >= 30 && num < 50 #80
      return '/images/rank/rank-4.png'
    elsif num >= 50 && num < 75 #160
      return '/images/rank/rank-5.png'
    elsif num >= 75 && num < 100 #320
      return '/images/rank/rank-6.png'
    elsif num >= 100
      return '/images/rank/rank-7.png'
    end
  end

  def rank_name(user)
    num = user.sign_in_count
    if num < 5 #5
      return '「英勇黄铜」'
    elsif num >= 5 && num < 15 # 10
      return '「不屈白银」'
    elsif num >= 15 && num < 30 #15
      return '「荣耀黄金」'
    elsif num >= 30 && num < 50 #20
      return '「华贵铂金」'
    elsif num >= 50 && num < 75 #25
      return '「璀璨钻石」'
    elsif num >= 75 && num < 100 #30
      return '「超凡大师」'
    elsif num >= 100
      return '「最强王者」'
    end
  end

  def rand_rank_picture(num)
    if num < 5 #10
      return '/images/rank/rank-1.png'
    elsif num >= 5 && num < 15 # 20
      return '/images/rank/rank-2.png'
    elsif num >= 15 && num < 30 #40
      return '/images/rank/rank-3.png'
    elsif num >= 30 && num < 50 #80
      return '/images/rank/rank-4.png'
    elsif num >= 50 && num < 75 #160
      return '/images/rank/rank-5.png'
    elsif num >= 75 && num < 100 #320
      return '/images/rank/rank-6.png'
    elsif num >= 100
      return '/images/rank/rank-7.png'
    end
  end

  def rand_rank_name(num)
    if num < 5 #5
      return '「英勇黄铜」'
    elsif num >= 5 && num < 15 # 10
      return '「不屈白银」'
    elsif num >= 15 && num < 30 #15
      return '「荣耀黄金」'
    elsif num >= 30 && num < 50 #20
      return '「华贵铂金」'
    elsif num >= 50 && num < 75 #25
      return '「璀璨钻石」'
    elsif num >= 75 && num < 100 #30
      return '「超凡大师」'
    elsif num >= 100
      return '「最强王者」'
    end
  end

  def user_ip_city(user)
    user_ip = user.current_sign_in_ip.to_s
    if user_ip != '127.0.0.1'
      baidu_json = $baidu_api.get do |req|
        req.url '/location/ip'
        req.params['ip'] = user_ip
        req.params['ak'] = '5PELDwT7pnzGDOjTjrV5oGq8'
      end
      body = JSON.parse(baidu_json.body)
      if body['status'] == 0
        return "#{body['content']['address']}"
      else
        return '登录地异常'
      end
    else
      return '北京,海淀区,中关村'
    end
  end

  #根据视频类型返回相应的播放链接
  def code_type_to_url(code,type)
    return "http://v.youku.com/v_show/id_#{code}.html"if type.to_i == 0 #优酷
    return code if type.to_i == 1
    return code if type.to_i == 2
    return "#{Settings.qiniu_cdn_host}vcd_#{code}.mp4"if type.to_i == 3 #源文件
  end

  #通过视频的频道编号返回其中文名称
  def video_to_column_name(video)
    Column.find(video).name
  end

end
