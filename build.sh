#!/bin/bash

# 检查参数数量
if [ "$#" -ne 4 ]; then
    echo "Usage: $0 <font_path> <font_vers> <font_name> <dpkg_name>"
    exit 1
fi

# 获取参数
font_path=fonts/"$1"
font_vers="$2"
font_name="$3"
dpkg_name="lingmo-font-$4"

# 创建包的目录结构
mkdir -p "./cache/${dpkg_name}/DEBIAN"
mkdir -p "./cache/${dpkg_name}/usr/share/fonts/truetype/${dpkg_name}"

# 创建 DEBIAN/control 文件
cat > "./cache/${dpkg_name}/DEBIAN/control" <<EOF
Package: ${dpkg_name}
Version: ${font_vers}
Section: fonts
Priority: optional
Architecture: all
Depends: fontconfig
Maintainer: Lingmo OS <team@lingmo.org>
Description: Lingmo™ OS ${font_name} Fonts
 This package installs the ${font_name} font family.
EOF

cp ${font_path}/* "./cache/${dpkg_name}/usr/share/fonts/truetype/${dpkg_name}/"
# 打包为 .deb 文件
dpkg-deb --build "./cache/${dpkg_name}" "${dpkg_name}.deb"
echo "Package ${dpkg_name}.deb created successfully."