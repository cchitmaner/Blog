# node环境镜像
FROM node:latest AS blog
# 创建hexo-blog文件夹且设置成工作文件夹
RUN mkdir -p /usr/hexo-blog
WORKDIR /usr/hexo-blog
# 复制当前文件夹下面的所有文件到hexo-blog中
COPY . .
# 安装 hexo-cli
RUN npm --registry=https://registry.npm.taobao.org install hexo-cli -g && npm install
RUN npm install hexo-wordcount --save && npm install hexo-generator-json-content --save && npm install hexo-generator-feed --save && npm install hexo-generator-sitemap --save && npm install hexo-generator-baidu-sitemap --save && npm install hexo-neat --save && npm install hexo-translate-title --save
# 生成静态文件
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && hexo clean && hexo g
CMD hexo server
EXPOSE 4000
