Return-Path: <netdev+bounces-157062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B66A08CB7
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1828E3AB2BE
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57C7210F4C;
	Fri, 10 Jan 2025 09:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ITy8n5S8"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD6B20FA93;
	Fri, 10 Jan 2025 09:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502058; cv=none; b=IeKsU2LxC6Zz/RyLr+1t7FoyVDww+8eQf3i2838WqI2+mn8qBydgSU4r5C+MYxW0JNuW4agaoySkKJM8bm+MV0mskaXce6g7v/mLhnY5jbrNn/A6MyaOGsoTkhHK0boBvILu6z1dmGCdqa0xUUx9dg1Cjw2CJSdAsXct71LG5/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502058; c=relaxed/simple;
	bh=APmCAOzBAsq+BgXufrBmKnvUqJTpSj9rDWj+RyYurps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XI4HMn9XmN+5JHl2QHXAvQ2DOa2h71oPX3vKVQQ6ChKoUzkGFBaIEy8La3GyEr7q0nDCWmke+VjFH3ZMGSNUuSWWlR/i0YK1NuK+uCRzARxUXQjJJfb8m/RGJ8tQydm0nRKZAmGlmEGhZWgMznTUO/147aWN3AxD5QR8HPvYEak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ITy8n5S8; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C0BEC60013;
	Fri, 10 Jan 2025 09:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736502054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pyahIhK6ZnikhrTX1IKvZvnf0u88gIlvhDiD3CqQUVM=;
	b=ITy8n5S8MaKf7nMpkgymDGcLaM2qWbRgnDVSqkzFduqDy9mgJnm4eGH2pud9qQ3c+bgBLv
	AetODnXLukwoxVLkMjmIiG4AAfMNR0ojsenN4H2wjhDk7CrYkkQ44/xbEXV+OV/FlOVzKq
	gBc1OAiZOVpNXZ6Z53tlaGpvS3XL8Qpcpmvr8fe2E2zAutEUfbyxYzGKyQQaVCaJqugMpZ
	i+cPL2J/bjvth6nmZM7Vc0cXin+XKp/+BYZ5jWhyj+yJMsn9TB8H/zr+0raMGriYDydZBI
	dWifOhE+VFEGJ7zDgTQnNKgMwlEAynuq06+rvIZ6k7JYaoG/Fgt1T6cP94r2Cg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 10 Jan 2025 10:40:31 +0100
Subject: [PATCH net-next v3 12/12] net: pse-pd: Clean ethtool header of PSE
 structures
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-feature_poe_arrange-v3-12-142279aedb94@bootlin.com>
References: <20250110-b4-feature_poe_arrange-v3-0-142279aedb94@bootlin.com>
In-Reply-To: <20250110-b4-feature_poe_arrange-v3-0-142279aedb94@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-Sasl: kory.maincent@bootlin.com

Remove PSE-specific structures from the ethtool header to improve code
modularity, maintain independent headers, and reduce incremental build
time.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v2:
- New patch.
---
 drivers/net/pse-pd/pse_core.c |  1 +
 include/linux/ethtool.h       | 20 --------------------
 include/linux/pse-pd/pse.h    | 22 +++++++++++++++++++++-
 3 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index b0272616a861..4f2a54afc4d0 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -6,6 +6,7 @@
 //
 
 #include <linux/device.h>
+#include <linux/ethtool.h>
 #include <linux/of.h>
 #include <linux/pse-pd/pse.h>
 #include <linux/regulator/driver.h>
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index f711bfd75c4d..843e2557a197 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1303,24 +1303,4 @@ struct ethtool_forced_speed_map {
 
 void
 ethtool_forced_speed_maps_init(struct ethtool_forced_speed_map *maps, u32 size);
-
-/* C33 PSE extended state and substate. */
-struct ethtool_c33_pse_ext_state_info {
-	enum ethtool_c33_pse_ext_state c33_pse_ext_state;
-	union {
-		enum ethtool_c33_pse_ext_substate_error_condition error_condition;
-		enum ethtool_c33_pse_ext_substate_mr_pse_enable mr_pse_enable;
-		enum ethtool_c33_pse_ext_substate_option_detect_ted option_detect_ted;
-		enum ethtool_c33_pse_ext_substate_option_vport_lim option_vport_lim;
-		enum ethtool_c33_pse_ext_substate_ovld_detected ovld_detected;
-		enum ethtool_c33_pse_ext_substate_power_not_available power_not_available;
-		enum ethtool_c33_pse_ext_substate_short_detected short_detected;
-		u32 __c33_pse_ext_substate;
-	};
-};
-
-struct ethtool_c33_pse_pw_limit_range {
-	u32 min;
-	u32 max;
-};
 #endif /* _LINUX_ETHTOOL_H */
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index b5ae3dcee550..c773eeb92d04 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -5,7 +5,6 @@
 #ifndef _LINUX_PSE_CONTROLLER_H
 #define _LINUX_PSE_CONTROLLER_H
 
-#include <linux/ethtool.h>
 #include <linux/list.h>
 #include <uapi/linux/ethtool.h>
 
@@ -16,6 +15,27 @@
 
 struct phy_device;
 struct pse_controller_dev;
+struct netlink_ext_ack;
+
+/* C33 PSE extended state and substate. */
+struct ethtool_c33_pse_ext_state_info {
+	enum ethtool_c33_pse_ext_state c33_pse_ext_state;
+	union {
+		enum ethtool_c33_pse_ext_substate_error_condition error_condition;
+		enum ethtool_c33_pse_ext_substate_mr_pse_enable mr_pse_enable;
+		enum ethtool_c33_pse_ext_substate_option_detect_ted option_detect_ted;
+		enum ethtool_c33_pse_ext_substate_option_vport_lim option_vport_lim;
+		enum ethtool_c33_pse_ext_substate_ovld_detected ovld_detected;
+		enum ethtool_c33_pse_ext_substate_power_not_available power_not_available;
+		enum ethtool_c33_pse_ext_substate_short_detected short_detected;
+		u32 __c33_pse_ext_substate;
+	};
+};
+
+struct ethtool_c33_pse_pw_limit_range {
+	u32 min;
+	u32 max;
+};
 
 /**
  * struct pse_control_config - PSE control/channel configuration.

-- 
2.34.1


