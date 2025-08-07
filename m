Return-Path: <netdev+bounces-211999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C9FB1CFF0
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 02:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0E05169D23
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 00:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEFF146585;
	Thu,  7 Aug 2025 00:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2f/xx+PJ"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96CF4A0C;
	Thu,  7 Aug 2025 00:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754528141; cv=none; b=S4Rnci1CNakYviVVlUwIvjTwQcthlr3w79AE0O5PReVuPt2wsCw9VYtIDQ38Geh6mIL3MbMahALAk+xzCwCzv2V3t3Yn95sE/W6jxhi/0DaAso2hZ/KOctJQdJTUYXrJ5AD9z3M5iXT3Q7FRgrQNszIdtSe8Cp3dxg91QyZCF84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754528141; c=relaxed/simple;
	bh=6UDp6ozVYCM4PD7sXSo99vjzdP2NDeO1Zs4T6K+25wA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C0Ykd2CQmAW/6VKpjnqVEvGq4FKNySbSnoHAZ4MZd3GJ2dzAsTXGn/qA7O1vMmmJernhcpfWP8yoXn2Bdveokx/sjZvyYHJkzOH4knG6xPSRClfdq9h2JwYP+msFqnV2GxdatJWZFqcZhyC37sNVCWCu4yjnwyJg1SibOAHqhgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2f/xx+PJ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1754528140; x=1786064140;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6UDp6ozVYCM4PD7sXSo99vjzdP2NDeO1Zs4T6K+25wA=;
  b=2f/xx+PJcaQmRdi611EQuAxCPoYIZcrjD7+JxVjLvF5eqoHO9lZpZtIf
   Z1bTgUBbHMlCrxS0mNMFeTk9+xiWVW6m0pe2pMcZMF0J7YZOAy3Dd8O8L
   yDahfcZEvsR1eGWATt+MqcXhQfeiFflWBb0BhVw+7dQO6ki+qthy+qj1O
   QQciOqUEh5Z8/45m+U2hJTXbSdbeI2+AN4x0qa0/BIpUYEA3fnz4Ee8Cj
   rfxIr0hQUQB1QltAW4hFrR2q3+GNR7AOAqBHww4ZrI4SKGnva9veU1DVs
   DFQZY7JU6qF9i+JdPdEq31Qh6V4QripkSSLuQBI7gt3iUO5Ix/cv+EEzM
   w==;
X-CSE-ConnectionGUID: 7LOKy0sWSJKnXbfoletQiw==
X-CSE-MsgGUID: zasE8l7LTBqWpxKu/sO9Ag==
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="45500050"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Aug 2025 17:55:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 6 Aug 2025 17:54:52 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Wed, 6 Aug 2025 17:54:51 -0700
From: <Tristram.Ha@microchip.com>
To: Oleksij Rempel <linux@rempel-privat.de>, Woojung Huh
	<woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
	<olteanv@gmail.com>
CC: Maxime Chevallier <maxime.chevallier@bootlin.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Tristram Ha <tristram.ha@microchip.com>
Subject: [PATCH net v2] net: dsa: microchip: Fix KSZ8863 reset problem
Date: Wed, 6 Aug 2025 17:54:53 -0700
Message-ID: <20250807005453.8306-1-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

ksz8873_valid_regs[] was added for register access for KSZ8863/KSZ8873
switches, but the reset register is not in the list so
ksz8_reset_switch() does not take any effect.

Replace regmap_update_bits() using ksz_regmap_8 with ksz_rmw8() so that
an error message will be given if the register is not defined.

A side effect of not resetting the switch is the static MAC table is not
cleared.  Further additions to the table will show write error as there
are only 8 entries in the table.

Fixes: d0dec3333040 ("net: dsa: microchip: Add register access control for KSZ8873 chip")
Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
v2
- Use ksz_rmw8() to display error message

 drivers/net/dsa/microchip/ksz8.c       | 20 +++++++++++---------
 drivers/net/dsa/microchip/ksz_common.c |  1 +
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 76e490070e9c..c354abdafc1b 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -36,15 +36,14 @@
 
 static void ksz_cfg(struct ksz_device *dev, u32 addr, u8 bits, bool set)
 {
-	regmap_update_bits(ksz_regmap_8(dev), addr, bits, set ? bits : 0);
+	ksz_rmw8(dev, addr, bits, set ? bits : 0);
 }
 
 static void ksz_port_cfg(struct ksz_device *dev, int port, int offset, u8 bits,
 			 bool set)
 {
-	regmap_update_bits(ksz_regmap_8(dev),
-			   dev->dev_ops->get_port_addr(port, offset),
-			   bits, set ? bits : 0);
+	ksz_rmw8(dev, dev->dev_ops->get_port_addr(port, offset), bits,
+		 set ? bits : 0);
 }
 
 /**
@@ -1955,16 +1954,19 @@ int ksz8_setup(struct dsa_switch *ds)
 	ksz_cfg(dev, S_LINK_AGING_CTRL, SW_LINK_AUTO_AGING, true);
 
 	/* Enable aggressive back off algorithm in half duplex mode. */
-	regmap_update_bits(ksz_regmap_8(dev), REG_SW_CTRL_1,
-			   SW_AGGR_BACKOFF, SW_AGGR_BACKOFF);
+	ret = ksz_rmw8(dev, REG_SW_CTRL_1, SW_AGGR_BACKOFF, SW_AGGR_BACKOFF);
+	if (ret)
+		return ret;
 
 	/*
 	 * Make sure unicast VLAN boundary is set as default and
 	 * enable no excessive collision drop.
 	 */
-	regmap_update_bits(ksz_regmap_8(dev), REG_SW_CTRL_2,
-			   UNICAST_VLAN_BOUNDARY | NO_EXC_COLLISION_DROP,
-			   UNICAST_VLAN_BOUNDARY | NO_EXC_COLLISION_DROP);
+	ret = ksz_rmw8(dev, REG_SW_CTRL_2,
+		       UNICAST_VLAN_BOUNDARY | NO_EXC_COLLISION_DROP,
+		       UNICAST_VLAN_BOUNDARY | NO_EXC_COLLISION_DROP);
+	if (ret)
+		return ret;
 
 	ksz_cfg(dev, S_REPLACE_VID_CTRL, SW_REPLACE_VID, false);
 
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 7292bfe2f7ca..4cb14288ff0f 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -1447,6 +1447,7 @@ static const struct regmap_range ksz8873_valid_regs[] = {
 	regmap_reg_range(0x3f, 0x3f),
 
 	/* advanced control registers */
+	regmap_reg_range(0x43, 0x43),
 	regmap_reg_range(0x60, 0x6f),
 	regmap_reg_range(0x70, 0x75),
 	regmap_reg_range(0x76, 0x78),
-- 
2.34.1


