Return-Path: <netdev+bounces-152791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1F19F5C99
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 03:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E7E0188C76B
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 02:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F8A7083A;
	Wed, 18 Dec 2024 02:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RBkuI3e8"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED6A74C08;
	Wed, 18 Dec 2024 02:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734487404; cv=none; b=eSbH0BCEPl2E9VfbSEmfQvQUvX88Kbu/eVDZ77/Y6siKdICVjsEggBx4T6SYnuJ/78mqBqTo17B0eUieCBj36jUAcHN2tTSqh1GIBtus5kPu6LCPYdNsM9uaedNkF3d/1j86M/TRE5pJEGN9qJr+mFN95ZhtJnaLrz0UTPGG324=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734487404; c=relaxed/simple;
	bh=zqVbGieWgsE5SZooSVueB1f4HqPeIXBBsFut2R7aWv8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQr6bAEGZg+7LSXZCtvctnD25lLEoCk5N7DscnRZYWvwfO8hgJTbQMdaB5DfUOAPgfQ9V4P3vVFjeRLCgRXPkUx1UIBeowuClbHOOwBYWiNAzubMY/QzVzWGqXJ8QF4Y2HuvIsUjRsy+Z5h7DAI1IKvB+opE76Wz3Kd9VNIBe5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RBkuI3e8; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734487404; x=1766023404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zqVbGieWgsE5SZooSVueB1f4HqPeIXBBsFut2R7aWv8=;
  b=RBkuI3e8eIAzM9teg3ERODS039ISz/KcSxYq4k28UTcn04a6JSPw2+G5
   HDtVdgBDWu/N4qCyIdIg9h4n8g2mXzaQcAcOrJV9MiX8AUKipEzhU9vPu
   631Sif1ixf4RfQnVp7zgsowXXej949arEYI8bhH1fkcM4Q4rfbXFYo1iE
   OEMB8AusYy2Y0rP6LVdLgfSFDgxS4Ggo3GAoppj+E4KGijPczI3NLK/DY
   bmdobkHDG5pH8MtUSQRvLIm0TIsXZHPn8LLTkAKUIidqn+/fX+U2YEJ6U
   llZSUssGaKbhMzQxNMHfXfUs4VYcib7aJjVczHFyZ6zGEj0PlIheUb1yj
   Q==;
X-CSE-ConnectionGUID: kquVdrzHRm+xTuPtNfefJQ==
X-CSE-MsgGUID: JP8PSzo6Ts2mDNogGxcHmQ==
X-IronPort-AV: E=Sophos;i="6.12,243,1728975600"; 
   d="scan'208";a="266896741"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Dec 2024 19:03:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 17 Dec 2024 19:02:24 -0700
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
Subject: [PATCH net 1/2] net: dsa: microchip: Fix KSZ9477 set_ageing_time function
Date: Tue, 17 Dec 2024 18:02:23 -0800
Message-ID: <20241218020224.70590-2-Tristram.Ha@microchip.com>
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

The aging count is not a simple 11-bit value but comprises a 3-bit
multiplier and an 8-bit second count.  The code tries to use the
original multiplier which is 4 as the second count is still 300 seconds
by default.

Fixes: 2c119d9982b1 ("net: dsa: microchip: add the support for set_ageing_time")
Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
 drivers/net/dsa/microchip/ksz9477.c     | 47 +++++++++++++++++++------
 drivers/net/dsa/microchip/ksz9477_reg.h |  4 +--
 2 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index d16817e0476f..29fe79ea74cd 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -2,7 +2,7 @@
 /*
  * Microchip KSZ9477 switch driver main logic
  *
- * Copyright (C) 2017-2019 Microchip Technology Inc.
+ * Copyright (C) 2017-2024 Microchip Technology Inc.
  */
 
 #include <linux/kernel.h>
@@ -983,26 +983,51 @@ void ksz9477_get_caps(struct ksz_device *dev, int port,
 int ksz9477_set_ageing_time(struct ksz_device *dev, unsigned int msecs)
 {
 	u32 secs = msecs / 1000;
-	u8 value;
-	u8 data;
+	u8 data, mult, value;
+	u32 max_val;
 	int ret;
 
-	value = FIELD_GET(SW_AGE_PERIOD_7_0_M, secs);
+#define MAX_TIMER_VAL	((1 << 8) - 1)
 
-	ret = ksz_write8(dev, REG_SW_LUE_CTRL_3, value);
-	if (ret < 0)
-		return ret;
+	/* The aging timer comprises a 3-bit multiplier and an 8-bit second
+	 * value.  Either of them cannot be zero.  The maximum timer is then
+	 * 7 * 255 = 1785 seconds.
+	 */
+	if (!secs)
+		secs = 1;
 
-	data = FIELD_GET(SW_AGE_PERIOD_10_8_M, secs);
+	/* Return error if too large. */
+	else if (secs > 7 * MAX_TIMER_VAL)
+		return -EINVAL;
 
 	ret = ksz_read8(dev, REG_SW_LUE_CTRL_0, &value);
 	if (ret < 0)
 		return ret;
 
-	value &= ~SW_AGE_CNT_M;
-	value |= FIELD_PREP(SW_AGE_CNT_M, data);
+	/* Check whether there is need to update the multiplier. */
+	mult = FIELD_GET(SW_AGE_CNT_M, value);
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
+		value &= ~SW_AGE_CNT_M;
+		value |= FIELD_PREP(SW_AGE_CNT_M, data);
+		ret = ksz_write8(dev, REG_SW_LUE_CTRL_0, value);
+		if (ret < 0)
+			return ret;
+	}
 
-	return ksz_write8(dev, REG_SW_LUE_CTRL_0, value);
+	value = DIV_ROUND_UP(secs, data);
+	return ksz_write8(dev, REG_SW_LUE_CTRL_3, value);
 }
 
 void ksz9477_port_queue_split(struct ksz_device *dev, int port)
diff --git a/drivers/net/dsa/microchip/ksz9477_reg.h b/drivers/net/dsa/microchip/ksz9477_reg.h
index 04235c22bf40..ff579920078e 100644
--- a/drivers/net/dsa/microchip/ksz9477_reg.h
+++ b/drivers/net/dsa/microchip/ksz9477_reg.h
@@ -2,7 +2,7 @@
 /*
  * Microchip KSZ9477 register definitions
  *
- * Copyright (C) 2017-2018 Microchip Technology Inc.
+ * Copyright (C) 2017-2024 Microchip Technology Inc.
  */
 
 #ifndef __KSZ9477_REGS_H
@@ -165,8 +165,6 @@
 #define SW_VLAN_ENABLE			BIT(7)
 #define SW_DROP_INVALID_VID		BIT(6)
 #define SW_AGE_CNT_M			GENMASK(5, 3)
-#define SW_AGE_CNT_S			3
-#define SW_AGE_PERIOD_10_8_M		GENMASK(10, 8)
 #define SW_RESV_MCAST_ENABLE		BIT(2)
 #define SW_HASH_OPTION_M		0x03
 #define SW_HASH_OPTION_CRC		1
-- 
2.34.1


