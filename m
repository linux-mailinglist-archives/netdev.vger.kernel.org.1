Return-Path: <netdev+bounces-204792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5745AFC137
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 05:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E877F3BF8EB
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 03:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C8B233D64;
	Tue,  8 Jul 2025 03:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="e7zNxxXM"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB1927455;
	Tue,  8 Jul 2025 03:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751944639; cv=none; b=XYPHMUzsT14IXBCinlcqaoSbHwvbIAYeGdu6Hha/Jbu0TaHcjKVPtWAADHGETNGJ/s/IVqdjBBaRRr5jLjvNFxUZrqESVnUzusyLLui+LdGogiTL83cb55b79VjuLsbsJF+vvoda2iUERomjxZQWbFCH+gYemfjuJ3wCIEEjvv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751944639; c=relaxed/simple;
	bh=yStGgUDYbWBkiH5IdJRndUHQ2yUN1Owjo5N7S/Ai+bU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u93haz214QXZcxNGsfpCaIMD3qx6JYQs/9xeCGmHA8YKAuH3+JRphzodE3uwE4cMTPZP8cfBUwS/k6auMKqdlSZZ4QaH1NnwJAXpi4wEE7KdLln2teb5iCwDWxuGbwp0UbglE82TI9HtZo/PbY3WOjKdPO2M/XZ4eUWn0k2AnqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=e7zNxxXM; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1751944637; x=1783480637;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yStGgUDYbWBkiH5IdJRndUHQ2yUN1Owjo5N7S/Ai+bU=;
  b=e7zNxxXM5l574BNQZecQNqJcwrIsdsur7dJ53b9t/yVoVoPrYad85gpU
   5kvu1tM/Y+B4tomz7FsXsI2Vj6qMeAnw/gac0ufywO9kOxBRuUvfHae3f
   cXIUqt+RdTgJhYeAYagUuz4US2CFl7RbxXaHsYgaPO74kGbCH/BUhZJRF
   eosSsrYKXY+BRRgKjK38tC7PmqAPChnzPqVPcCN9KH+6f52KlpKZB3ISb
   R8Q+2FVi5ISkKM4ugI6k/jTbeWu5YNOm4y8/jbRLWiiIvy3EPG9PLQ5Tj
   yo3u0HUW1T8DtKWGSULusrIsp4gfSipk0TP6JEWnVqw3H8jTXzGCTeeW3
   A==;
X-CSE-ConnectionGUID: cVEISvaDRiehsZPvdpmZNg==
X-CSE-MsgGUID: mMHZchAPTMmH27enKIWLLA==
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; 
   d="scan'208";a="43198300"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jul 2025 20:17:15 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 7 Jul 2025 20:16:45 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Mon, 7 Jul 2025 20:16:45 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Marek Vasut <marex@denx.de>,
	<UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tristram Ha
	<tristram.ha@microchip.com>
Subject: [PATCH net-next 3/6 v2] net: dsa: microchip: Transform register for use with KSZ8463
Date: Mon, 7 Jul 2025 20:16:45 -0700
Message-ID: <20250708031648.6703-4-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708031648.6703-1-Tristram.Ha@microchip.com>
References: <20250708031648.6703-1-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

KSZ8463 uses a byte-enable mechanism to specify 8-bit, 16-bit, and 32-bit
access.  The register is first shifted right by 2 then left by 4.  Extra
4 bits are added.  If the access is 8-bit one of the 4 bits is set.  If
the access is 16-bit two of the 4 bits are set.  If the access is 32-bit
all 4 bits are set.  The SPI command for read or write is then added.

As there are no automatic address increase and continuous SPI transfer
the 64-bit access needs to broken into 2 32-bit accesses.

All common access functions in ksz_common.h are updated to include
register transformation call so that the correct register access is used
for KSZ8463.

KSZ8463/KSZ8795/KSZ8863/KSZ8895 common code for switch access is updated
to include the register transformation function if common access
functions in ksz_common.h are not used.  In addition PORT_CTRL_ADDR is
replaced with the get_port_addr helper function as KSZ8463 has different
port register arrangement.

Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
 drivers/net/dsa/microchip/ksz8.c       | 10 ++--
 drivers/net/dsa/microchip/ksz_common.c |  5 +-
 drivers/net/dsa/microchip/ksz_common.h | 71 +++++++++++++++++++++-----
 3 files changed, 67 insertions(+), 19 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 92a720ee1f71..f0c6049afe51 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -36,13 +36,15 @@
 
 static void ksz_cfg(struct ksz_device *dev, u32 addr, u8 bits, bool set)
 {
-	regmap_update_bits(ksz_regmap_8(dev), addr, bits, set ? bits : 0);
+	regmap_update_bits(ksz_regmap_8(dev), reg8(dev, addr), bits,
+			   set ? bits : 0);
 }
 
 static void ksz_port_cfg(struct ksz_device *dev, int port, int offset, u8 bits,
 			 bool set)
 {
-	regmap_update_bits(ksz_regmap_8(dev), PORT_CTRL_ADDR(port, offset),
+	regmap_update_bits(ksz_regmap_8(dev),
+			   reg8(dev, dev->dev_ops->get_port_addr(port, offset)),
 			   bits, set ? bits : 0);
 }
 
@@ -1888,14 +1890,14 @@ int ksz8_setup(struct dsa_switch *ds)
 	ksz_cfg(dev, S_LINK_AGING_CTRL, SW_LINK_AUTO_AGING, true);
 
 	/* Enable aggressive back off algorithm in half duplex mode. */
-	regmap_update_bits(ksz_regmap_8(dev), REG_SW_CTRL_1,
+	regmap_update_bits(ksz_regmap_8(dev), reg8(dev, REG_SW_CTRL_1),
 			   SW_AGGR_BACKOFF, SW_AGGR_BACKOFF);
 
 	/*
 	 * Make sure unicast VLAN boundary is set as default and
 	 * enable no excessive collision drop.
 	 */
-	regmap_update_bits(ksz_regmap_8(dev), REG_SW_CTRL_2,
+	regmap_update_bits(ksz_regmap_8(dev), reg8(dev, REG_SW_CTRL_2),
 			   UNICAST_VLAN_BOUNDARY | NO_EXC_COLLISION_DROP,
 			   UNICAST_VLAN_BOUNDARY | NO_EXC_COLLISION_DROP);
 
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 095e647b3897..5261747b7753 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2991,7 +2991,8 @@ static int ksz_setup(struct dsa_switch *ds)
 
 	ds->num_tx_queues = dev->info->num_tx_queues;
 
-	regmap_update_bits(ksz_regmap_8(dev), regs[S_MULTICAST_CTRL],
+	regmap_update_bits(ksz_regmap_8(dev),
+			   reg8(dev, regs[S_MULTICAST_CTRL]),
 			   MULTICAST_STORM_DISABLE, MULTICAST_STORM_DISABLE);
 
 	ksz_init_mib_timer(dev);
@@ -3051,7 +3052,7 @@ static int ksz_setup(struct dsa_switch *ds)
 		goto out_ptp_clock_unregister;
 
 	/* start switch */
-	regmap_update_bits(ksz_regmap_8(dev), regs[S_START_CTRL],
+	regmap_update_bits(ksz_regmap_8(dev), reg8(dev, regs[S_START_CTRL]),
 			   SW_START, SW_START);
 
 	return 0;
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 3ffca7054983..cdf89e50238a 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -485,10 +485,36 @@ static inline struct regmap *ksz_regmap_32(struct ksz_device *dev)
 	return dev->regmap[KSZ_REGMAP_32];
 }
 
+static inline bool ksz_is_ksz8463(struct ksz_device *dev)
+{
+	return dev->chip_id == KSZ8463_CHIP_ID;
+}
+
+static inline u32 reg8(struct ksz_device *dev, u32 reg)
+{
+	if (ksz_is_ksz8463(dev))
+		return ((reg >> 2) << 4) | (1 << (reg & 3));
+	return reg;
+}
+
+static inline u32 reg16(struct ksz_device *dev, u32 reg)
+{
+	if (ksz_is_ksz8463(dev))
+		return ((reg >> 2) << 4) | (reg & 2 ? 0x0c : 0x03);
+	return reg;
+}
+
+static inline u32 reg32(struct ksz_device *dev, u32 reg)
+{
+	if (ksz_is_ksz8463(dev))
+		return ((reg >> 2) << 4) | 0xf;
+	return reg;
+}
+
 static inline int ksz_read8(struct ksz_device *dev, u32 reg, u8 *val)
 {
 	unsigned int value;
-	int ret = regmap_read(ksz_regmap_8(dev), reg, &value);
+	int ret = regmap_read(ksz_regmap_8(dev), reg8(dev, reg), &value);
 
 	if (ret)
 		dev_err(dev->dev, "can't read 8bit reg: 0x%x %pe\n", reg,
@@ -501,7 +527,7 @@ static inline int ksz_read8(struct ksz_device *dev, u32 reg, u8 *val)
 static inline int ksz_read16(struct ksz_device *dev, u32 reg, u16 *val)
 {
 	unsigned int value;
-	int ret = regmap_read(ksz_regmap_16(dev), reg, &value);
+	int ret = regmap_read(ksz_regmap_16(dev), reg16(dev, reg), &value);
 
 	if (ret)
 		dev_err(dev->dev, "can't read 16bit reg: 0x%x %pe\n", reg,
@@ -514,7 +540,7 @@ static inline int ksz_read16(struct ksz_device *dev, u32 reg, u16 *val)
 static inline int ksz_read32(struct ksz_device *dev, u32 reg, u32 *val)
 {
 	unsigned int value;
-	int ret = regmap_read(ksz_regmap_32(dev), reg, &value);
+	int ret = regmap_read(ksz_regmap_32(dev), reg32(dev, reg), &value);
 
 	if (ret)
 		dev_err(dev->dev, "can't read 32bit reg: 0x%x %pe\n", reg,
@@ -529,7 +555,17 @@ static inline int ksz_read64(struct ksz_device *dev, u32 reg, u64 *val)
 	u32 value[2];
 	int ret;
 
-	ret = regmap_bulk_read(ksz_regmap_32(dev), reg, value, 2);
+	if (ksz_is_ksz8463(dev)) {
+		int i;
+
+		for (i = 0; i < 2; i++)
+			ret = regmap_read(ksz_regmap_32(dev),
+					  reg32(dev, reg + i * 4),
+					  &value[i]);
+		*val = (u64)value[0] << 32 | value[1];
+		return ret;
+	}
+	ret = regmap_bulk_read(ksz_regmap_32(dev), reg32(dev, reg), value, 2);
 	if (ret)
 		dev_err(dev->dev, "can't read 64bit reg: 0x%x %pe\n", reg,
 			ERR_PTR(ret));
@@ -543,7 +579,7 @@ static inline int ksz_write8(struct ksz_device *dev, u32 reg, u8 value)
 {
 	int ret;
 
-	ret = regmap_write(ksz_regmap_8(dev), reg, value);
+	ret = regmap_write(ksz_regmap_8(dev), reg8(dev, reg), value);
 	if (ret)
 		dev_err(dev->dev, "can't write 8bit reg: 0x%x %pe\n", reg,
 			ERR_PTR(ret));
@@ -555,7 +591,7 @@ static inline int ksz_write16(struct ksz_device *dev, u32 reg, u16 value)
 {
 	int ret;
 
-	ret = regmap_write(ksz_regmap_16(dev), reg, value);
+	ret = regmap_write(ksz_regmap_16(dev), reg16(dev, reg), value);
 	if (ret)
 		dev_err(dev->dev, "can't write 16bit reg: 0x%x %pe\n", reg,
 			ERR_PTR(ret));
@@ -567,7 +603,7 @@ static inline int ksz_write32(struct ksz_device *dev, u32 reg, u32 value)
 {
 	int ret;
 
-	ret = regmap_write(ksz_regmap_32(dev), reg, value);
+	ret = regmap_write(ksz_regmap_32(dev), reg32(dev, reg), value);
 	if (ret)
 		dev_err(dev->dev, "can't write 32bit reg: 0x%x %pe\n", reg,
 			ERR_PTR(ret));
@@ -580,7 +616,7 @@ static inline int ksz_rmw16(struct ksz_device *dev, u32 reg, u16 mask,
 {
 	int ret;
 
-	ret = regmap_update_bits(ksz_regmap_16(dev), reg, mask, value);
+	ret = regmap_update_bits(ksz_regmap_16(dev), reg16(dev, reg), mask, value);
 	if (ret)
 		dev_err(dev->dev, "can't rmw 16bit reg 0x%x: %pe\n", reg,
 			ERR_PTR(ret));
@@ -593,7 +629,7 @@ static inline int ksz_rmw32(struct ksz_device *dev, u32 reg, u32 mask,
 {
 	int ret;
 
-	ret = regmap_update_bits(ksz_regmap_32(dev), reg, mask, value);
+	ret = regmap_update_bits(ksz_regmap_32(dev), reg32(dev, reg), mask, value);
 	if (ret)
 		dev_err(dev->dev, "can't rmw 32bit reg 0x%x: %pe\n", reg,
 			ERR_PTR(ret));
@@ -610,14 +646,22 @@ static inline int ksz_write64(struct ksz_device *dev, u32 reg, u64 value)
 	val[0] = swab32(value & 0xffffffffULL);
 	val[1] = swab32(value >> 32ULL);
 
-	return regmap_bulk_write(ksz_regmap_32(dev), reg, val, 2);
+	if (ksz_is_ksz8463(dev)) {
+		int i, ret;
+
+		for (i = 0; i < 2; i++)
+			ret = regmap_write(ksz_regmap_32(dev),
+					   reg32(dev, reg + i * 4), val[i]);
+		return ret;
+	}
+	return regmap_bulk_write(ksz_regmap_32(dev), reg32(dev, reg), val, 2);
 }
 
 static inline int ksz_rmw8(struct ksz_device *dev, int offset, u8 mask, u8 val)
 {
 	int ret;
 
-	ret = regmap_update_bits(ksz_regmap_8(dev), offset, mask, val);
+	ret = regmap_update_bits(ksz_regmap_8(dev), reg8(dev, offset), mask, val);
 	if (ret)
 		dev_err(dev->dev, "can't rmw 8bit reg 0x%x: %pe\n", offset,
 			ERR_PTR(ret));
@@ -710,12 +754,13 @@ static inline bool ksz_is_8895_family(struct ksz_device *dev)
 static inline bool is_ksz8(struct ksz_device *dev)
 {
 	return ksz_is_ksz87xx(dev) || ksz_is_ksz88x3(dev) ||
-	       ksz_is_8895_family(dev);
+	       ksz_is_8895_family(dev) || ksz_is_ksz8463(dev);
 }
 
 static inline bool is_ksz88xx(struct ksz_device *dev)
 {
-	return ksz_is_ksz88x3(dev) || ksz_is_8895_family(dev);
+	return ksz_is_ksz88x3(dev) || ksz_is_8895_family(dev) ||
+	       ksz_is_ksz8463(dev);
 }
 
 static inline bool is_ksz9477(struct ksz_device *dev)
-- 
2.34.1


