Return-Path: <netdev+bounces-98780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 304E88D2714
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 23:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB75C1F26771
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 21:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CEC17BB03;
	Tue, 28 May 2024 21:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="h4dphgd4"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521E617B421;
	Tue, 28 May 2024 21:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716931996; cv=none; b=QrwG2spE5Raa5DZ+0yhCnSyJjVe/4lnOi6egLuwocmCvcES4XqhAkg5YB1g3LqRkOyziubalQEqbZKLcAe6q9PnGR5ZKPZ5P49e+OCU2HD2ed5EZriR3Gl3RCTW1FUzoUA/KUcdOprr7sEyYnIVQlVfETOoZ+eR3r+KxjDqkrRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716931996; c=relaxed/simple;
	bh=hYhRDwUloKxG4TrkUyEWmGC3yi+nYBz9NqYMmUyJDOs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NM0qfvvglDRuh9N5lWkJfouy+TfoBJZD2pKCrRQyQTyZ2K/mugzkgitLJRqjqQcA9HFBmEWnDo35nFMeZEAMamCJe6rORf+mpnzMuVaEqtit9a6/zDH8reGF/chtyZDr6ZodNWHtOq3QuytqIoM0MNTcUNFNlbvslQP7ztVgjVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=h4dphgd4; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1716931995; x=1748467995;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=hYhRDwUloKxG4TrkUyEWmGC3yi+nYBz9NqYMmUyJDOs=;
  b=h4dphgd4/Zdi+r3cL+YUJIbkDytnM5P/5SmJvVX6sPyr4P/EHdmwftxq
   B0XuTnF+f2qv4vfdN65O5w/1QvXX/qQrRZrnvhfOMZfbHanrVD53ii11P
   eQ+pnZSiFJYnZyEYqksEoJwe8Cw7HIQTMfsxoXcI8IQ9sq7BtYyRu3b7p
   mKp3RKs48Gv4A/HLJoM7w7O3VcIMn7QVcX3jUNaGbqZhUyZ+eIhweiYHX
   mz4cM/GvdnrXBr4ig0nEG7Cs7d6DALJFqit+bD9W41HQkYWPIThVFNqsx
   pN6F2qSOsqhwI7F1X0wAHNl2tUs0/lGhJGBL0f8GXzzPJwaNWPHcNEmFs
   A==;
X-CSE-ConnectionGUID: cQfuOWTzSNG0L+VmDYVXFA==
X-CSE-MsgGUID: jf0yPrT5Rf2LNiXS4YjA0g==
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="27243943"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 May 2024 14:33:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 28 May 2024 14:33:10 -0700
Received: from hat-linux.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 28 May 2024 14:33:10 -0700
From: <Tristram.Ha@microchip.com>
To: Arun Ramadoss <arun.ramadoss@microchip.com>, Woojung Huh
	<woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>, Vivien Didelot
	<vivien.didelot@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>,
	"Vladimir Oltean" <olteanv@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tristram Ha
	<tristram.ha@microchip.com>
Subject: [PATCH net] net: dsa: microchip: fix KSZ9477 set_ageing_time function
Date: Tue, 28 May 2024 14:36:32 -0700
Message-ID: <1716932192-3555-1-git-send-email-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

The aging count is not a simple 11-bit value but comprises a 3-bit
multiplier and an 8-bit second count.  The code tries to find a set of
values with result close to the specifying value.

Note LAN937X has similar operation but provides an option to use
millisecond instead of second so there will be a separate fix in the
future.

Fixes: 2c119d9982b1 ("net: dsa: microchip: add the support for set_ageing_time")
Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
 drivers/net/dsa/microchip/ksz9477.c     | 64 +++++++++++++++++++++----
 drivers/net/dsa/microchip/ksz9477_reg.h |  1 -
 2 files changed, 54 insertions(+), 11 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index f8ad7833f5d9..1af11aee3119 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1099,26 +1099,70 @@ void ksz9477_get_caps(struct ksz_device *dev, int port,
 int ksz9477_set_ageing_time(struct ksz_device *dev, unsigned int msecs)
 {
 	u32 secs = msecs / 1000;
+	u8 first, last, mult, i;
+	int min, ret;
+	int diff[8];
 	u8 value;
 	u8 data;
-	int ret;
 
-	value = FIELD_GET(SW_AGE_PERIOD_7_0_M, secs);
+	/* The aging timer comprises a 3-bit multiplier and an 8-bit second
+	 * value.  Either of them cannot be zero.  The maximum timer is then
+	 * 7 * 255 = 1785.
+	 */
+	if (!secs)
+		secs = 1;
 
-	ret = ksz_write8(dev, REG_SW_LUE_CTRL_3, value);
+	ret = ksz_read8(dev, REG_SW_LUE_CTRL_0, &value);
 	if (ret < 0)
 		return ret;
 
-	data = FIELD_GET(SW_AGE_PERIOD_10_8_M, secs);
+	/* Check whether there is need to update the multiplier. */
+	mult = FIELD_GET(SW_AGE_CNT_M, value);
+	if (mult > 0) {
+		/* Try to use the same multiplier already in the register. */
+		min = secs / mult;
+		if (min <= 0xff && min * mult == secs)
+			return ksz_write8(dev, REG_SW_LUE_CTRL_3, min);
+	}
 
-	ret = ksz_read8(dev, REG_SW_LUE_CTRL_0, &value);
-	if (ret < 0)
-		return ret;
+	/* Return error if too large. */
+	if (secs > 7 * 0xff)
+		return -EINVAL;
+
+	/* Find out which combination of multiplier * value results in a timer
+	 * value close to the specified timer value.
+	 */
+	first = (secs + 0xfe) / 0xff;
+	for (i = first; i <= 7; i++) {
+		min = secs / i;
+		diff[i] = secs - i * min;
+		if (!diff[i]) {
+			i++;
+			break;
+		}
+	}
+
+	last = i;
+	min = 0xff;
+	for (i = last - 1; i >= first; i--) {
+		if (diff[i] < min) {
+			data = i;
+			min = diff[i];
+		}
+		if (!min)
+			break;
+	}
 
-	value &= ~SW_AGE_CNT_M;
-	value |= FIELD_PREP(SW_AGE_CNT_M, data);
+	if (mult != data) {
+		value &= ~SW_AGE_CNT_M;
+		value |= FIELD_PREP(SW_AGE_CNT_M, data);
+		ret = ksz_write8(dev, REG_SW_LUE_CTRL_0, value);
+		if (ret)
+			return ret;
+	}
 
-	return ksz_write8(dev, REG_SW_LUE_CTRL_0, value);
+	value = secs / data;
+	return ksz_write8(dev, REG_SW_LUE_CTRL_3, value);
 }
 
 void ksz9477_port_queue_split(struct ksz_device *dev, int port)
diff --git a/drivers/net/dsa/microchip/ksz9477_reg.h b/drivers/net/dsa/microchip/ksz9477_reg.h
index f3a205ee483f..0c55a540f20d 100644
--- a/drivers/net/dsa/microchip/ksz9477_reg.h
+++ b/drivers/net/dsa/microchip/ksz9477_reg.h
@@ -171,7 +171,6 @@
 #define SW_DROP_INVALID_VID		BIT(6)
 #define SW_AGE_CNT_M			GENMASK(5, 3)
 #define SW_AGE_CNT_S			3
-#define SW_AGE_PERIOD_10_8_M		GENMASK(10, 8)
 #define SW_RESV_MCAST_ENABLE		BIT(2)
 #define SW_HASH_OPTION_M		0x03
 #define SW_HASH_OPTION_CRC		1
-- 
2.34.1


