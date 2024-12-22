Return-Path: <netdev+bounces-153976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CE39FA7E3
	for <lists+netdev@lfdr.de>; Sun, 22 Dec 2024 21:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25414165A98
	for <lists+netdev@lfdr.de>; Sun, 22 Dec 2024 20:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7221925BB;
	Sun, 22 Dec 2024 20:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="KnPA4yTj"
X-Original-To: netdev@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AB118F2CF;
	Sun, 22 Dec 2024 20:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734898107; cv=none; b=cf7tAvpoQclPriU39pXEvS1eaE18QSTk+C81nlDwMegiHuvx6tfm0fPUg0GASaP+QWy3Uw3+tLz+DZpAfeHFs0d62+eC7jkCXG3fqBQOTKDduKkZLrcqGrlfX19qyNDWdQfZIhVWSAVqKAK+PrHgslwIMNLF0hH470kS7ZyuPa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734898107; c=relaxed/simple;
	bh=FmtJOo1+d0Tve5YfUUCdo863Y3whanIvIfOCMjcIg0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=udQvJRHnGKWBf2oRxdV2IC271FHeMLeabxmcRQv+nBoUUNybtjXhHC0yXOjaKEocXqmNHj2H77XmwbuKrb3+99e0Ma9pjswTYJWGhMqUYC7q2VxSmLO3oDf1JJybafm39z2r3MSvPmVqHOYj4cJvVTGGOt06U4Q+RGHgDanb5Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=KnPA4yTj; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734898101;
	bh=FmtJOo1+d0Tve5YfUUCdo863Y3whanIvIfOCMjcIg0w=;
	h=From:Date:Subject:To:Cc:From;
	b=KnPA4yTjKiZ//CrOAwwgoXMOMAxqh18LViXbWqqpNvHapFvUndmEOkyxtKbL89vG/
	 YLSARqfMB2ijh3BXjPCRYHcgF8dkOtRensNVq2UVGQ2vzjjxUORFwnKr1mvI5P+tAX
	 E7F6xbj/qUzFDhszeOHQqggveW8LljEEgBeQ4cJQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 22 Dec 2024 21:08:20 +0100
Subject: [PATCH net-next] ptp: ocp: constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241222-sysfs-const-bin_attr-ptp-v1-1-5c1f3ee246fb@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIALNxaGcC/x3MQQqDQAxA0atI1g3UqCi9SikyHaPNJg6TIBbx7
 g4u3+L/A4yzsMGrOiDzJiarFtSPCuIv6MIoUzHQk9qaiND+NhvGVc3xKzoG94zJE/aBYz91TUN
 hgJKnzLPs9/oNyo7Ku8PnPC/CNaxodAAAAA==
X-Change-ID: 20241222-sysfs-const-bin_attr-ptp-7aec7d5332a8
To: Richard Cochran <richardcochran@gmail.com>, 
 Jonathan Lemon <jonathan.lemon@gmail.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734898101; l=3343;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=FmtJOo1+d0Tve5YfUUCdo863Y3whanIvIfOCMjcIg0w=;
 b=+lVeH3P6bb86IGzXafkJW6uMStaWYX+94N8zNpb3F6LtBkV28A2KJkeYIP4eWBNBtcP+Szu9G
 Sh1SgNhlcmVBNrTU2Ex0vd0Wh8/eWLKgcd5NBA6qLehY4iUqbpiftqx
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/ptp/ptp_ocp.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 5feecaadde8e05a2a2bb462094434e47e5336400..7f08c70d81230530fda459eefa9b7098dcbba79f 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -3692,7 +3692,7 @@ DEVICE_FREQ_GROUP(freq4, 3);
 
 static ssize_t
 disciplining_config_read(struct file *filp, struct kobject *kobj,
-			 struct bin_attribute *bin_attr, char *buf,
+			 const struct bin_attribute *bin_attr, char *buf,
 			 loff_t off, size_t count)
 {
 	struct ptp_ocp *bp = dev_get_drvdata(kobj_to_dev(kobj));
@@ -3727,7 +3727,7 @@ disciplining_config_read(struct file *filp, struct kobject *kobj,
 
 static ssize_t
 disciplining_config_write(struct file *filp, struct kobject *kobj,
-			  struct bin_attribute *bin_attr, char *buf,
+			  const struct bin_attribute *bin_attr, char *buf,
 			  loff_t off, size_t count)
 {
 	struct ptp_ocp *bp = dev_get_drvdata(kobj_to_dev(kobj));
@@ -3750,11 +3750,11 @@ disciplining_config_write(struct file *filp, struct kobject *kobj,
 
 	return err;
 }
-static BIN_ATTR_RW(disciplining_config, OCP_ART_CONFIG_SIZE);
+static const BIN_ATTR_RW(disciplining_config, OCP_ART_CONFIG_SIZE);
 
 static ssize_t
 temperature_table_read(struct file *filp, struct kobject *kobj,
-		       struct bin_attribute *bin_attr, char *buf,
+		       const struct bin_attribute *bin_attr, char *buf,
 		       loff_t off, size_t count)
 {
 	struct ptp_ocp *bp = dev_get_drvdata(kobj_to_dev(kobj));
@@ -3789,7 +3789,7 @@ temperature_table_read(struct file *filp, struct kobject *kobj,
 
 static ssize_t
 temperature_table_write(struct file *filp, struct kobject *kobj,
-			struct bin_attribute *bin_attr, char *buf,
+			const struct bin_attribute *bin_attr, char *buf,
 			loff_t off, size_t count)
 {
 	struct ptp_ocp *bp = dev_get_drvdata(kobj_to_dev(kobj));
@@ -3812,7 +3812,7 @@ temperature_table_write(struct file *filp, struct kobject *kobj,
 
 	return err;
 }
-static BIN_ATTR_RW(temperature_table, OCP_ART_TEMP_TABLE_SIZE);
+static const BIN_ATTR_RW(temperature_table, OCP_ART_TEMP_TABLE_SIZE);
 
 static struct attribute *fb_timecard_attrs[] = {
 	&dev_attr_serialnum.attr,
@@ -3867,7 +3867,7 @@ static struct attribute *art_timecard_attrs[] = {
 	NULL,
 };
 
-static struct bin_attribute *bin_art_timecard_attrs[] = {
+static const struct bin_attribute *const bin_art_timecard_attrs[] = {
 	&bin_attr_disciplining_config,
 	&bin_attr_temperature_table,
 	NULL,
@@ -3875,7 +3875,7 @@ static struct bin_attribute *bin_art_timecard_attrs[] = {
 
 static const struct attribute_group art_timecard_group = {
 	.attrs = art_timecard_attrs,
-	.bin_attrs = bin_art_timecard_attrs,
+	.bin_attrs_new = bin_art_timecard_attrs,
 };
 
 static const struct ocp_attr_group art_timecard_groups[] = {

---
base-commit: bcde95ce32b666478d6737219caa4f8005a8f201
change-id: 20241222-sysfs-const-bin_attr-ptp-7aec7d5332a8

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


