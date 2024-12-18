Return-Path: <netdev+bounces-152790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFFA9F5C95
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 03:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA8FC1884A31
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 02:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329D6139579;
	Wed, 18 Dec 2024 02:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UxtBzOeZ"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD94450EE;
	Wed, 18 Dec 2024 02:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734487389; cv=none; b=W8IomVlnSHfJmgq0eahoIeZAfz/mWRiZcLmRnMsyCVMkGLmWU0qLKXkVWPVMzF0vQfz9K/HIP1qyTfbTim9zS4qEnE/D3t5xaWGpTritCApABvIY0O1Wu/mOplkr1XdXumbjy9t/L4jvNgGDLr3wH51c/5k8JrOF+NbzCN5GAJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734487389; c=relaxed/simple;
	bh=BVagBaiisBzIAS4MLeneoJzJTAv0WxDuk7NiJyKprws=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C2AhYmaTPvm/dsH+3DmKn0JI1ihp3AOHV6VwFTMPIZsB0H7seUIazC7gQV8bxsOkhd5QgTadGetAF5cWsNg4Z7UD/lw+JoBfv0OTdHAKAYOdDtH6vja7jmeDAnyKc9TQWLsAaxhH8ZjhtQOo2CIcwvJ/1CY1MpBG+o9kDQJGS60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UxtBzOeZ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734487387; x=1766023387;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BVagBaiisBzIAS4MLeneoJzJTAv0WxDuk7NiJyKprws=;
  b=UxtBzOeZuDm5EdHbPNjYBEzjqOwmimLD78F8/ei3xLPO2GOF8qFV/9IJ
   M0+CEAVOfsRLDVwktBhKMvic1HIOkKeVkjwWXN7mxXbKnQupVyI4S+vdz
   5AtrcYZZFQXymoc+/MwIkr3b/Og81fUG7ta38K6GgtfTYlCRvrldzg6VR
   mI/DwsKEcwydQAg7urKOviZEd8CuZkScOhXeqiUzx6vzEFPoFQKm8BS9i
   dSsiFRks0755DGq3e0kkArG+mxKcpSxEq1qsFROE29FsiaKQoE5DOd/se
   W2CVLmvBSVFxHy1MHmSvsMxFALKaU2RNoZNuhRwpEhkiNCzNgkOnSqLlD
   g==;
X-CSE-ConnectionGUID: ISTjjhv+RS2GzfsLd7mNTQ==
X-CSE-MsgGUID: HBXWIT0BRbmObxXBpYVrKQ==
X-IronPort-AV: E=Sophos;i="6.12,243,1728975600"; 
   d="scan'208";a="203135195"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Dec 2024 19:03:04 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 17 Dec 2024 19:02:25 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 17 Dec 2024 19:02:24 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, Arun Ramadoss
	<arun.ramadoss@microchip.com>, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
	<olteanv@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tristram Ha
	<tristram.ha@microchip.com>
Subject: [PATCH net 2/2] net: dsa: microchip: Fix LAN937X set_ageing_time function
Date: Tue, 17 Dec 2024 18:02:24 -0800
Message-ID: <20241218020224.70590-3-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241218020224.70590-1-Tristram.Ha@microchip.com>
References: <20241218020224.70590-1-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

The aging count is not a simple 20-bit value but comprises a 3-bit
multiplier and a 20-bit second time.  The code tries to use the
original multiplier which is 4 as the second count is still 300 seconds
by default.

As the 20-bit number is now too large for practical use there is an option
to interpret it as microseconds instead of seconds.

Fixes: 2c119d9982b1 ("net: dsa: microchip: add the support for set_ageing_time")
Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
 drivers/net/dsa/microchip/lan937x_main.c | 62 ++++++++++++++++++++++--
 drivers/net/dsa/microchip/lan937x_reg.h  |  9 ++--
 2 files changed, 65 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index b7652efd632e..b1ae3b9de3d1 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Microchip LAN937X switch driver main logic
- * Copyright (C) 2019-2022 Microchip Technology Inc.
+ * Copyright (C) 2019-2024 Microchip Technology Inc.
  */
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -461,10 +461,66 @@ int lan937x_change_mtu(struct ksz_device *dev, int port, int new_mtu)
 
 int lan937x_set_ageing_time(struct ksz_device *dev, unsigned int msecs)
 {
-	u32 secs = msecs / 1000;
-	u32 value;
+	u8 data, mult, value8;
+	bool in_msec = false;
+	u32 max_val, value;
+	u32 secs = msecs;
 	int ret;
 
+#define MAX_TIMER_VAL	((1 << 20) - 1)
+
+	/* The aging timer comprises a 3-bit multiplier and a 20-bit second
+	 * value.  Either of them cannot be zero.  The maximum timer is then
+	 * 7 * 1048575 = 7340025 seconds.  As this value is too large for
+	 * practical use it can be interpreted as microseconds, making the
+	 * maximum timer 7340 seconds with finer control.  This allows for
+	 * maximum 122 minutes compared to 29 minutes in KSZ9477 switch.
+	 */
+	if (msecs % 1000)
+		in_msec = true;
+	else
+		secs /= 1000;
+	if (!secs)
+		secs = 1;
+
+	/* Return error if too large. */
+	else if (secs > 7 * MAX_TIMER_VAL)
+		return -EINVAL;
+
+	/* Configure how to interpret the number value. */
+	ret = ksz_rmw8(dev, REG_SW_LUE_CTRL_2, SW_AGE_CNT_IN_MICROSEC,
+		       in_msec ? SW_AGE_CNT_IN_MICROSEC : 0);
+	if (ret < 0)
+		return ret;
+
+	ret = ksz_read8(dev, REG_SW_LUE_CTRL_0, &value8);
+	if (ret < 0)
+		return ret;
+
+	/* Check whether there is need to update the multiplier. */
+	mult = FIELD_GET(SW_AGE_CNT_M, value8);
+	max_val = MAX_TIMER_VAL;
+	if (mult > 0) {
+		/* Try to use the same multiplier already in the register as
+		 * the hardware default uses multiplier 4 and 75 seconds for
+		 * 300 seconds.
+		 */
+		max_val = DIV_ROUND_UP(secs, mult);
+		if (max_val > MAX_TIMER_VAL || max_val * mult != secs)
+			max_val = MAX_TIMER_VAL;
+	}
+
+	data = DIV_ROUND_UP(secs, max_val);
+	if (mult != data) {
+		value8 &= ~SW_AGE_CNT_M;
+		value8 |= FIELD_PREP(SW_AGE_CNT_M, data);
+		ret = ksz_write8(dev, REG_SW_LUE_CTRL_0, value8);
+		if (ret < 0)
+			return ret;
+	}
+
+	secs = DIV_ROUND_UP(secs, data);
+
 	value = FIELD_GET(SW_AGE_PERIOD_7_0_M, secs);
 
 	ret = ksz_write8(dev, REG_SW_AGE_PERIOD__1, value);
diff --git a/drivers/net/dsa/microchip/lan937x_reg.h b/drivers/net/dsa/microchip/lan937x_reg.h
index 4ec93e421da4..72042fd64e5b 100644
--- a/drivers/net/dsa/microchip/lan937x_reg.h
+++ b/drivers/net/dsa/microchip/lan937x_reg.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Microchip LAN937X switch register definitions
- * Copyright (C) 2019-2021 Microchip Technology Inc.
+ * Copyright (C) 2019-2024 Microchip Technology Inc.
  */
 #ifndef __LAN937X_REG_H
 #define __LAN937X_REG_H
@@ -56,8 +56,7 @@
 
 #define SW_VLAN_ENABLE			BIT(7)
 #define SW_DROP_INVALID_VID		BIT(6)
-#define SW_AGE_CNT_M			0x7
-#define SW_AGE_CNT_S			3
+#define SW_AGE_CNT_M			GENMASK(5, 3)
 #define SW_RESV_MCAST_ENABLE		BIT(2)
 
 #define REG_SW_LUE_CTRL_1		0x0311
@@ -70,6 +69,10 @@
 #define SW_FAST_AGING			BIT(1)
 #define SW_LINK_AUTO_AGING		BIT(0)
 
+#define REG_SW_LUE_CTRL_2		0x0312
+
+#define SW_AGE_CNT_IN_MICROSEC		BIT(7)
+
 #define REG_SW_AGE_PERIOD__1		0x0313
 #define SW_AGE_PERIOD_7_0_M		GENMASK(7, 0)
 
-- 
2.34.1


