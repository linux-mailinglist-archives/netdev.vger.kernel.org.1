Return-Path: <netdev+bounces-156634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1087A072DC
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 11:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB64F168607
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 10:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E989215F70;
	Thu,  9 Jan 2025 10:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XeB5g4g4"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A067A215798;
	Thu,  9 Jan 2025 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736417948; cv=none; b=QbLUxnZAFkRHnAW49WOEGzWurb8As5Hkdw62kNG38VCtgFCJV5qbR979yBxH5tOIySLy0cM8kJdLWKBi+7CRq4H31DvAHs5ITBXJrcSgRu+8eGjHA2JaBeYaGSFGk1zx5FXQ0LEYzJzqCR7dXGQ1iD2wKffk4ayJXtohsagqwHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736417948; c=relaxed/simple;
	bh=BgmI5+f007NY5MqD0r01vDQ+FUmwMv2BXyDMGcXeHKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Md1xdQ6iSC7supTWtJ4Q+l2JbgwN6yTFbwqFnZloqhvZsJoHz8SrR2YIgJNz4bolr8MFowOmkrnEWjcYaE40pbLkcCoG1npJDeOTXfKuDxH4QTVdTdmpQyT5CMb3H/oSnMzku3cXU+85M925b4iu4148de45iI+g+EyvVmHpNqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XeB5g4g4; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 76565E0007;
	Thu,  9 Jan 2025 10:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736417940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HqfcEwFHnXLFfj7PAufEvNIFPEEn0o3jJJxQOZR4YCY=;
	b=XeB5g4g4w/LE2a7HhfO9zVE+CdnHDTRRrnPL0hTF0aKU8fWX7/pG/7R/Bc8yYe1n2tuuMD
	U1JhQKEA4LCkhfQKEfKeitnCOCbrxJYdI/brqwr5wgnI2RvjU7pdzndxggy1xD652VmTzR
	LCeS2bAjeJcc385HohL/bXWYI8cV5AnOVH+8Td4DhDDbcb1pnEpmlQP/rRW/n9kJbOnAC2
	KJvTvPquTGy+/3GYl+/BI91/4CxSHDHFbwH8qTeMEQchhOO5O7Fcx7dfjkSSNn2DTW03wq
	qFFxWgE37VaDXkLY0v2+JE8dpRI9Uytv7CF9MumsrXVp7UGgIGYnlmJC1rmxWQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 09 Jan 2025 11:18:09 +0100
Subject: [PATCH net-next v2 15/15] net: pse-pd: Clean ethtool header of PSE
 structures
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-b4-feature_poe_arrange-v2-15-55ded947b510@bootlin.com>
References: <20250109-b4-feature_poe_arrange-v2-0-55ded947b510@bootlin.com>
In-Reply-To: <20250109-b4-feature_poe_arrange-v2-0-55ded947b510@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

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
index be56b3f5425c..e907543824d6 100644
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
index be877dea6a11..1452ed7ca6d7 100644
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


