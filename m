Return-Path: <netdev+bounces-153304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D74A89F7911
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 11:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA5C318949A2
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 10:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B73221D8B;
	Thu, 19 Dec 2024 10:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="a95OiD0N"
X-Original-To: netdev@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0951CD15;
	Thu, 19 Dec 2024 10:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734602432; cv=none; b=m0tA+IZndUvTIb5oj83G2VbSWuim+O9nmkOLMpdqWGppwLk+1hQHaVEzUzeDy78tqa/kDE9k4kkTqsJvLgWfi/i5TtTUkzQn+OhavCJnA8F6FvQxBpQCmzyPJjNmbhnanBHl9569gRCl8mS++dvedsJKHIuuNCIKMsY8yieiVY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734602432; c=relaxed/simple;
	bh=Np6CrRrO4PwBJNX9VmrdwvtyvBWt8tpkAqWIuJyRp/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Aos+CZ90zoKsMk3cPoqP6RwUpR+FCCyfhz12bG3p5IXxlp4e5vwcLO+14fdrIFYXb5gg/aXerLKQaUgFATCzo9GG3PoZELdKIowLpjrAjck1h7kTkwZMEzYcHB7I9W968a6nRgrNoNC+O9ymRgvpp5kzr/wIJ9BE3moCjc0Zv2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=a95OiD0N; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734602426;
	bh=Np6CrRrO4PwBJNX9VmrdwvtyvBWt8tpkAqWIuJyRp/Q=;
	h=From:Date:Subject:To:Cc:From;
	b=a95OiD0NRhB8TPfQ4eOliT8/F48lG7gIS4gZ8EL6KLzk+bcDHiq/wUj0uOUj5WeLh
	 jT3ym350Rjiymy6CdzGo/OdPNG+nJoQ9UuwMbJb3a44ulC0Alh8kgOTcIRTpktVysE
	 xP5tkVedSiAMMQ7CGuQnUjTOjBbnc2il37CxDYI0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 19 Dec 2024 11:00:19 +0100
Subject: [PATCH net-next v2] qlcnic: use const 'struct bin_attribute'
 callbacks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241219-sysfs-const-bin_attr-net-v2-1-93bdaece3c90@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIALLuY2cC/3WNzQ6CMBCEX8Xs2TVtU+rPyfcwxEBZ7F6K6VaEE
 N7dSrx6nHwz3ywglJgELrsFEo0sPMQSzH4HPjTxQchdyWCUsdroCmWWXtAPUTK2HO9NzgkjZbT
 dyStFlXPKQpk/E/U8beobfAuRpgx1IYElD2nePke98Z/e/dePGhWSt061Z92bo72+iUXEh1c4l
 ALU67p+AKAhOabPAAAA
X-Change-ID: 20241215-sysfs-const-bin_attr-net-4d8c00e56604
To: Shahed Shaikh <shshaikh@marvell.com>, 
 Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734602425; l=9733;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Np6CrRrO4PwBJNX9VmrdwvtyvBWt8tpkAqWIuJyRp/Q=;
 b=WBqSX39TVvgGPIGnTKrHsPV/A9VTWlD/Y9T1xL4Basu6aM6XG+EvQzQuTBf5XoOqj+CSonxHy
 1uZVTyRNiDeBIBXVGFOrG4Yvje44A98xr16Ef6foHq/twJahCJ+E+nM
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now provides callback variants that explicitly take a
const pointer. Use them so the non-const variants can be removed.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Drop already applied patches
- Drop unnecessary write_new = NULL assignment
- Clarify commit message a bit
- Link to v1: https://lore.kernel.org/r/20241216-sysfs-const-bin_attr-net-v1-0-ec460b91f274@weissschuh.net
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sysfs.c | 69 +++++++++++------------
 1 file changed, 34 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sysfs.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sysfs.c
index 74125188beb82515f57a20ae24dcd526943d05ee..c0f20464fd1e0123b06c128a67f4091a5ba973eb 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sysfs.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sysfs.c
@@ -264,7 +264,7 @@ static int qlcnic_sysfs_validate_crb(struct qlcnic_adapter *adapter,
 }
 
 static ssize_t qlcnic_sysfs_read_crb(struct file *filp, struct kobject *kobj,
-				     struct bin_attribute *attr, char *buf,
+				     const struct bin_attribute *attr, char *buf,
 				     loff_t offset, size_t size)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -281,7 +281,7 @@ static ssize_t qlcnic_sysfs_read_crb(struct file *filp, struct kobject *kobj,
 }
 
 static ssize_t qlcnic_sysfs_write_crb(struct file *filp, struct kobject *kobj,
-				      struct bin_attribute *attr, char *buf,
+				      const struct bin_attribute *attr, char *buf,
 				      loff_t offset, size_t size)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -310,7 +310,7 @@ static int qlcnic_sysfs_validate_mem(struct qlcnic_adapter *adapter,
 }
 
 static ssize_t qlcnic_sysfs_read_mem(struct file *filp, struct kobject *kobj,
-				     struct bin_attribute *attr, char *buf,
+				     const struct bin_attribute *attr, char *buf,
 				     loff_t offset, size_t size)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -332,7 +332,7 @@ static ssize_t qlcnic_sysfs_read_mem(struct file *filp, struct kobject *kobj,
 }
 
 static ssize_t qlcnic_sysfs_write_mem(struct file *filp, struct kobject *kobj,
-				      struct bin_attribute *attr, char *buf,
+				      const struct bin_attribute *attr, char *buf,
 				      loff_t offset, size_t size)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -396,7 +396,7 @@ static int validate_pm_config(struct qlcnic_adapter *adapter,
 
 static ssize_t qlcnic_sysfs_write_pm_config(struct file *filp,
 					    struct kobject *kobj,
-					    struct bin_attribute *attr,
+					    const struct bin_attribute *attr,
 					    char *buf, loff_t offset,
 					    size_t size)
 {
@@ -446,7 +446,7 @@ static ssize_t qlcnic_sysfs_write_pm_config(struct file *filp,
 
 static ssize_t qlcnic_sysfs_read_pm_config(struct file *filp,
 					   struct kobject *kobj,
-					   struct bin_attribute *attr,
+					   const struct bin_attribute *attr,
 					   char *buf, loff_t offset,
 					   size_t size)
 {
@@ -539,7 +539,7 @@ static int validate_esw_config(struct qlcnic_adapter *adapter,
 
 static ssize_t qlcnic_sysfs_write_esw_config(struct file *file,
 					     struct kobject *kobj,
-					     struct bin_attribute *attr,
+					     const struct bin_attribute *attr,
 					     char *buf, loff_t offset,
 					     size_t size)
 {
@@ -623,7 +623,7 @@ static ssize_t qlcnic_sysfs_write_esw_config(struct file *file,
 
 static ssize_t qlcnic_sysfs_read_esw_config(struct file *file,
 					    struct kobject *kobj,
-					    struct bin_attribute *attr,
+					    const struct bin_attribute *attr,
 					    char *buf, loff_t offset,
 					    size_t size)
 {
@@ -675,7 +675,7 @@ static int validate_npar_config(struct qlcnic_adapter *adapter,
 
 static ssize_t qlcnic_sysfs_write_npar_config(struct file *file,
 					      struct kobject *kobj,
-					      struct bin_attribute *attr,
+					      const struct bin_attribute *attr,
 					      char *buf, loff_t offset,
 					      size_t size)
 {
@@ -722,7 +722,7 @@ static ssize_t qlcnic_sysfs_write_npar_config(struct file *file,
 
 static ssize_t qlcnic_sysfs_read_npar_config(struct file *file,
 					     struct kobject *kobj,
-					     struct bin_attribute *attr,
+					     const struct bin_attribute *attr,
 					     char *buf, loff_t offset,
 					     size_t size)
 {
@@ -769,7 +769,7 @@ static ssize_t qlcnic_sysfs_read_npar_config(struct file *file,
 
 static ssize_t qlcnic_sysfs_get_port_stats(struct file *file,
 					   struct kobject *kobj,
-					   struct bin_attribute *attr,
+					   const struct bin_attribute *attr,
 					   char *buf, loff_t offset,
 					   size_t size)
 {
@@ -804,7 +804,7 @@ static ssize_t qlcnic_sysfs_get_port_stats(struct file *file,
 
 static ssize_t qlcnic_sysfs_get_esw_stats(struct file *file,
 					  struct kobject *kobj,
-					  struct bin_attribute *attr,
+					  const struct bin_attribute *attr,
 					  char *buf, loff_t offset,
 					  size_t size)
 {
@@ -839,7 +839,7 @@ static ssize_t qlcnic_sysfs_get_esw_stats(struct file *file,
 
 static ssize_t qlcnic_sysfs_clear_esw_stats(struct file *file,
 					    struct kobject *kobj,
-					    struct bin_attribute *attr,
+					    const struct bin_attribute *attr,
 					    char *buf, loff_t offset,
 					    size_t size)
 {
@@ -868,7 +868,7 @@ static ssize_t qlcnic_sysfs_clear_esw_stats(struct file *file,
 
 static ssize_t qlcnic_sysfs_clear_port_stats(struct file *file,
 					     struct kobject *kobj,
-					     struct bin_attribute *attr,
+					     const struct bin_attribute *attr,
 					     char *buf, loff_t offset,
 					     size_t size)
 {
@@ -898,7 +898,7 @@ static ssize_t qlcnic_sysfs_clear_port_stats(struct file *file,
 
 static ssize_t qlcnic_sysfs_read_pci_config(struct file *file,
 					    struct kobject *kobj,
-					    struct bin_attribute *attr,
+					    const struct bin_attribute *attr,
 					    char *buf, loff_t offset,
 					    size_t size)
 {
@@ -938,7 +938,7 @@ static ssize_t qlcnic_sysfs_read_pci_config(struct file *file,
 
 static ssize_t qlcnic_83xx_sysfs_flash_read_handler(struct file *filp,
 						    struct kobject *kobj,
-						    struct bin_attribute *attr,
+						    const struct bin_attribute *attr,
 						    char *buf, loff_t offset,
 						    size_t size)
 {
@@ -1115,7 +1115,7 @@ static int qlcnic_83xx_sysfs_flash_write(struct qlcnic_adapter *adapter,
 
 static ssize_t qlcnic_83xx_sysfs_flash_write_handler(struct file *filp,
 						     struct kobject *kobj,
-						     struct bin_attribute *attr,
+						     const struct bin_attribute *attr,
 						     char *buf, loff_t offset,
 						     size_t size)
 {
@@ -1195,64 +1195,63 @@ static const struct device_attribute dev_attr_beacon = {
 static const struct bin_attribute bin_attr_crb = {
 	.attr = { .name = "crb", .mode = 0644 },
 	.size = 0,
-	.read = qlcnic_sysfs_read_crb,
-	.write = qlcnic_sysfs_write_crb,
+	.read_new = qlcnic_sysfs_read_crb,
+	.write_new = qlcnic_sysfs_write_crb,
 };
 
 static const struct bin_attribute bin_attr_mem = {
 	.attr = { .name = "mem", .mode = 0644 },
 	.size = 0,
-	.read = qlcnic_sysfs_read_mem,
-	.write = qlcnic_sysfs_write_mem,
+	.read_new = qlcnic_sysfs_read_mem,
+	.write_new = qlcnic_sysfs_write_mem,
 };
 
 static const struct bin_attribute bin_attr_npar_config = {
 	.attr = { .name = "npar_config", .mode = 0644 },
 	.size = 0,
-	.read = qlcnic_sysfs_read_npar_config,
-	.write = qlcnic_sysfs_write_npar_config,
+	.read_new = qlcnic_sysfs_read_npar_config,
+	.write_new = qlcnic_sysfs_write_npar_config,
 };
 
 static const struct bin_attribute bin_attr_pci_config = {
 	.attr = { .name = "pci_config", .mode = 0644 },
 	.size = 0,
-	.read = qlcnic_sysfs_read_pci_config,
-	.write = NULL,
+	.read_new = qlcnic_sysfs_read_pci_config,
 };
 
 static const struct bin_attribute bin_attr_port_stats = {
 	.attr = { .name = "port_stats", .mode = 0644 },
 	.size = 0,
-	.read = qlcnic_sysfs_get_port_stats,
-	.write = qlcnic_sysfs_clear_port_stats,
+	.read_new = qlcnic_sysfs_get_port_stats,
+	.write_new = qlcnic_sysfs_clear_port_stats,
 };
 
 static const struct bin_attribute bin_attr_esw_stats = {
 	.attr = { .name = "esw_stats", .mode = 0644 },
 	.size = 0,
-	.read = qlcnic_sysfs_get_esw_stats,
-	.write = qlcnic_sysfs_clear_esw_stats,
+	.read_new = qlcnic_sysfs_get_esw_stats,
+	.write_new = qlcnic_sysfs_clear_esw_stats,
 };
 
 static const struct bin_attribute bin_attr_esw_config = {
 	.attr = { .name = "esw_config", .mode = 0644 },
 	.size = 0,
-	.read = qlcnic_sysfs_read_esw_config,
-	.write = qlcnic_sysfs_write_esw_config,
+	.read_new = qlcnic_sysfs_read_esw_config,
+	.write_new = qlcnic_sysfs_write_esw_config,
 };
 
 static const struct bin_attribute bin_attr_pm_config = {
 	.attr = { .name = "pm_config", .mode = 0644 },
 	.size = 0,
-	.read = qlcnic_sysfs_read_pm_config,
-	.write = qlcnic_sysfs_write_pm_config,
+	.read_new = qlcnic_sysfs_read_pm_config,
+	.write_new = qlcnic_sysfs_write_pm_config,
 };
 
 static const struct bin_attribute bin_attr_flash = {
 	.attr = { .name = "flash", .mode = 0644 },
 	.size = 0,
-	.read = qlcnic_83xx_sysfs_flash_read_handler,
-	.write = qlcnic_83xx_sysfs_flash_write_handler,
+	.read_new = qlcnic_83xx_sysfs_flash_read_handler,
+	.write_new = qlcnic_83xx_sysfs_flash_write_handler,
 };
 
 #ifdef CONFIG_QLCNIC_HWMON

---
base-commit: 8503810115fbff903f626adc0788daa048302bc0
change-id: 20241215-sysfs-const-bin_attr-net-4d8c00e56604

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


