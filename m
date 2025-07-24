Return-Path: <netdev+bounces-209873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D944DB11209
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 22:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E7395A7D95
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 20:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B166F24DCE5;
	Thu, 24 Jul 2025 20:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qKNyUqd8"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBF224888C;
	Thu, 24 Jul 2025 20:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753387963; cv=none; b=VQthbrs1gDfro9OApmuyXWdBS/n+LRpdHrgDE5qHodUnj25f12wu7l7sel5IOsrMuX+oNHgTeAZ0/DhYI2d6iE9HTvAYPV2Uy/XRT1YQvuVT64wTGKJhxqKZ1kn1O0PIpjE3zPlj0ljpxC6v4WYZjfnWFrvo7xPDEMUpIbp462I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753387963; c=relaxed/simple;
	bh=SVmFzM9HX1G4W1SR5ohas/J7SBbMjYe1/YYfaD8egpM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PVA7BljVSmIgHmlIvpqwUx7rXRGPMA/boy438xrkm8ncLlGtlFczAQXA9mieO2j3izTLsOsQdhnvBxO8kxz+ddcpi+zpeH1zXiTDgQ9yxUQ7M5nXrsXhMm9k43FlZcvOwkJRst3460t/Z6VNMtJnGkUZZ+vNsL7unVeTqmACzNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qKNyUqd8; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1753387961; x=1784923961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SVmFzM9HX1G4W1SR5ohas/J7SBbMjYe1/YYfaD8egpM=;
  b=qKNyUqd8UiVdzIUeMk9PPaTeAnDAzjEih6VqPhpaIdo6WR2iMPPzGgag
   3NLBPEQt9pp/V/Vdw93ymBVvGQKQLc6DmwqTNG0BzCQZNkLggCrifKEnD
   3GY/a0AV2epy2YA17n/a1bid/36nKU5r0Mf5wfy2W8lDohYQv+I7e9K3p
   VqXKK69SmfkEP5XeQSRiw0MF+VHJwdGGViVgPQ8GICYOq2OstEMDBtUYl
   2Nvw4KETA3cmoev0AGswM89Enr6U9ctj4uHW6Q8KOX9tWVU5jpxSmJS8M
   HT9F+eaX2wr9teCcfcF5OtEhUc0YZiK4Xnbrq2/N2Ow+F2fBATBy4/qHO
   Q==;
X-CSE-ConnectionGUID: Vloo96aWRWWEYpPX1eCS2Q==
X-CSE-MsgGUID: dw1dE8HlQKK+Caexc1LEXQ==
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="211826703"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jul 2025 13:12:34 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 24 Jul 2025 13:11:30 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Thu, 24 Jul 2025 13:11:28 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <o.rempel@pengutronix.de>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net-next v2 1/4] net: phy: micrel: Start using PHY_ID_MATCH_MODEL
Date: Thu, 24 Jul 2025 22:08:23 +0200
Message-ID: <20250724200826.2662658-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250724200826.2662658-1-horatiu.vultur@microchip.com>
References: <20250724200826.2662658-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Start using PHY_ID_MATCH_MODEL for all the drivers.
While at this add also PHY_ID_KSZ8041RNLI to micrel_tbl.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/micrel.c | 66 ++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 39 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index f678c1bdacdf0..c6aacf7feb7b0 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -5643,8 +5643,7 @@ static int ksz9131_resume(struct phy_device *phydev)
 
 static struct phy_driver ksphy_driver[] = {
 {
-	.phy_id		= PHY_ID_KS8737,
-	.phy_id_mask	= MICREL_PHY_ID_MASK,
+	PHY_ID_MATCH_MODEL(PHY_ID_KS8737),
 	.name		= "Micrel KS8737",
 	/* PHY_BASIC_FEATURES */
 	.driver_data	= &ks8737_type,
@@ -5685,8 +5684,7 @@ static struct phy_driver ksphy_driver[] = {
 	.suspend	= kszphy_suspend,
 	.resume		= kszphy_resume,
 }, {
-	.phy_id		= PHY_ID_KSZ8041,
-	.phy_id_mask	= MICREL_PHY_ID_MASK,
+	PHY_ID_MATCH_MODEL(PHY_ID_KSZ8041),
 	.name		= "Micrel KSZ8041",
 	/* PHY_BASIC_FEATURES */
 	.driver_data	= &ksz8041_type,
@@ -5701,8 +5699,7 @@ static struct phy_driver ksphy_driver[] = {
 	.suspend	= ksz8041_suspend,
 	.resume		= ksz8041_resume,
 }, {
-	.phy_id		= PHY_ID_KSZ8041RNLI,
-	.phy_id_mask	= MICREL_PHY_ID_MASK,
+	PHY_ID_MATCH_MODEL(PHY_ID_KSZ8041RNLI),
 	.name		= "Micrel KSZ8041RNLI",
 	/* PHY_BASIC_FEATURES */
 	.driver_data	= &ksz8041_type,
@@ -5745,9 +5742,8 @@ static struct phy_driver ksphy_driver[] = {
 	.suspend	= kszphy_suspend,
 	.resume		= kszphy_resume,
 }, {
-	.phy_id		= PHY_ID_KSZ8081,
+	PHY_ID_MATCH_MODEL(PHY_ID_KSZ8081),
 	.name		= "Micrel KSZ8081 or KSZ8091",
-	.phy_id_mask	= MICREL_PHY_ID_MASK,
 	.flags		= PHY_POLL_CABLE_TEST,
 	/* PHY_BASIC_FEATURES */
 	.driver_data	= &ksz8081_type,
@@ -5766,9 +5762,8 @@ static struct phy_driver ksphy_driver[] = {
 	.cable_test_start	= ksz886x_cable_test_start,
 	.cable_test_get_status	= ksz886x_cable_test_get_status,
 }, {
-	.phy_id		= PHY_ID_KSZ8061,
+	PHY_ID_MATCH_MODEL(PHY_ID_KSZ8061),
 	.name		= "Micrel KSZ8061",
-	.phy_id_mask	= MICREL_PHY_ID_MASK,
 	/* PHY_BASIC_FEATURES */
 	.probe		= kszphy_probe,
 	.config_init	= ksz8061_config_init,
@@ -5796,8 +5791,7 @@ static struct phy_driver ksphy_driver[] = {
 	.read_mmd	= genphy_read_mmd_unsupported,
 	.write_mmd	= genphy_write_mmd_unsupported,
 }, {
-	.phy_id		= PHY_ID_KSZ9031,
-	.phy_id_mask	= MICREL_PHY_ID_MASK,
+	PHY_ID_MATCH_MODEL(PHY_ID_KSZ9031),
 	.name		= "Micrel KSZ9031 Gigabit PHY",
 	.flags		= PHY_POLL_CABLE_TEST,
 	.driver_data	= &ksz9021_type,
@@ -5817,8 +5811,7 @@ static struct phy_driver ksphy_driver[] = {
 	.cable_test_get_status	= ksz9x31_cable_test_get_status,
 	.set_loopback	= ksz9031_set_loopback,
 }, {
-	.phy_id		= PHY_ID_LAN8814,
-	.phy_id_mask	= MICREL_PHY_ID_MASK,
+	PHY_ID_MATCH_MODEL(PHY_ID_LAN8814),
 	.name		= "Microchip INDY Gigabit Quad PHY",
 	.flags          = PHY_POLL_CABLE_TEST,
 	.config_init	= lan8814_config_init,
@@ -5836,8 +5829,7 @@ static struct phy_driver ksphy_driver[] = {
 	.cable_test_start	= lan8814_cable_test_start,
 	.cable_test_get_status	= ksz886x_cable_test_get_status,
 }, {
-	.phy_id		= PHY_ID_LAN8804,
-	.phy_id_mask	= MICREL_PHY_ID_MASK,
+	PHY_ID_MATCH_MODEL(PHY_ID_LAN8804),
 	.name		= "Microchip LAN966X Gigabit PHY",
 	.config_init	= lan8804_config_init,
 	.driver_data	= &ksz9021_type,
@@ -5852,8 +5844,7 @@ static struct phy_driver ksphy_driver[] = {
 	.config_intr	= lan8804_config_intr,
 	.handle_interrupt = lan8804_handle_interrupt,
 }, {
-	.phy_id		= PHY_ID_LAN8841,
-	.phy_id_mask	= MICREL_PHY_ID_MASK,
+	PHY_ID_MATCH_MODEL(PHY_ID_LAN8841),
 	.name		= "Microchip LAN8841 Gigabit PHY",
 	.flags		= PHY_POLL_CABLE_TEST,
 	.driver_data	= &lan8841_type,
@@ -5870,8 +5861,7 @@ static struct phy_driver ksphy_driver[] = {
 	.cable_test_start	= lan8814_cable_test_start,
 	.cable_test_get_status	= ksz886x_cable_test_get_status,
 }, {
-	.phy_id		= PHY_ID_KSZ9131,
-	.phy_id_mask	= MICREL_PHY_ID_MASK,
+	PHY_ID_MATCH_MODEL(PHY_ID_KSZ9131),
 	.name		= "Microchip KSZ9131 Gigabit PHY",
 	/* PHY_GBIT_FEATURES */
 	.flags		= PHY_POLL_CABLE_TEST,
@@ -5892,8 +5882,7 @@ static struct phy_driver ksphy_driver[] = {
 	.cable_test_get_status	= ksz9x31_cable_test_get_status,
 	.get_features	= ksz9477_get_features,
 }, {
-	.phy_id		= PHY_ID_KSZ8873MLL,
-	.phy_id_mask	= MICREL_PHY_ID_MASK,
+	PHY_ID_MATCH_MODEL(PHY_ID_KSZ8873MLL),
 	.name		= "Micrel KSZ8873MLL Switch",
 	/* PHY_BASIC_FEATURES */
 	.config_init	= kszphy_config_init,
@@ -5902,8 +5891,7 @@ static struct phy_driver ksphy_driver[] = {
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
 }, {
-	.phy_id		= PHY_ID_KSZ886X,
-	.phy_id_mask	= MICREL_PHY_ID_MASK,
+	PHY_ID_MATCH_MODEL(PHY_ID_KSZ886X),
 	.name		= "Micrel KSZ8851 Ethernet MAC or KSZ886X Switch",
 	.driver_data	= &ksz886x_type,
 	/* PHY_BASIC_FEATURES */
@@ -5923,8 +5911,7 @@ static struct phy_driver ksphy_driver[] = {
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
 }, {
-	.phy_id		= PHY_ID_KSZ9477,
-	.phy_id_mask	= MICREL_PHY_ID_MASK,
+	PHY_ID_MATCH_MODEL(PHY_ID_KSZ9477),
 	.name		= "Microchip KSZ9477",
 	.probe		= kszphy_probe,
 	/* PHY_GBIT_FEATURES */
@@ -5951,22 +5938,23 @@ MODULE_LICENSE("GPL");
 
 static const struct mdio_device_id __maybe_unused micrel_tbl[] = {
 	{ PHY_ID_KSZ9021, 0x000ffffe },
-	{ PHY_ID_KSZ9031, MICREL_PHY_ID_MASK },
-	{ PHY_ID_KSZ9131, MICREL_PHY_ID_MASK },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_KSZ9031) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_KSZ9131) },
 	{ PHY_ID_KSZ8001, 0x00fffffc },
-	{ PHY_ID_KS8737, MICREL_PHY_ID_MASK },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_KS8737) },
 	{ PHY_ID_KSZ8021, 0x00ffffff },
 	{ PHY_ID_KSZ8031, 0x00ffffff },
-	{ PHY_ID_KSZ8041, MICREL_PHY_ID_MASK },
-	{ PHY_ID_KSZ8051, MICREL_PHY_ID_MASK },
-	{ PHY_ID_KSZ8061, MICREL_PHY_ID_MASK },
-	{ PHY_ID_KSZ8081, MICREL_PHY_ID_MASK },
-	{ PHY_ID_KSZ8873MLL, MICREL_PHY_ID_MASK },
-	{ PHY_ID_KSZ886X, MICREL_PHY_ID_MASK },
-	{ PHY_ID_KSZ9477, MICREL_PHY_ID_MASK },
-	{ PHY_ID_LAN8814, MICREL_PHY_ID_MASK },
-	{ PHY_ID_LAN8804, MICREL_PHY_ID_MASK },
-	{ PHY_ID_LAN8841, MICREL_PHY_ID_MASK },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_KSZ8041) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_KSZ8041RNLI) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_KSZ8051) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_KSZ8061) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_KSZ8081) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_KSZ8873MLL) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_KSZ886X) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_KSZ9477) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_LAN8814) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_LAN8804) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_LAN8841) },
 	{ }
 };
 
-- 
2.34.1


