Return-Path: <netdev+bounces-213632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE170B25EFF
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 10:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 954591B64796
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 08:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1A22D5C9E;
	Thu, 14 Aug 2025 08:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BpGsJdbl"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72DC254873;
	Thu, 14 Aug 2025 08:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755160321; cv=none; b=Ic+ynC4boVHYHJsdGczwWA9RMVdlI3J7j6G+8L5+T0tWjLO75wWU7sMFwHgA4W69W0QwLQSm/8KpLXCPaxjB55CdsNsOt8VYBYjaTAvgJi87nNNw9cGrCtkmGLcc6TF7pa5aYYEr7zCvem8xmqhIa40SzpxRUCcsDSN3bl+gbWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755160321; c=relaxed/simple;
	bh=Y9RtB1WT5YHRuTvWwKAbMQj7Mad3XJvZ1fC0rWPGG+8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gcbAUAEgCW7Exc81cOAVCLbYk9MMhLrlfXnvR3tjHCx401SHn3ueeEteBR9Pyu0Qw/Svjv5eb+EPFkEg0WpWLRoD84TnyzSmHR5bV8FUf71iPKCe61Y86xqJVKfNhcQRCzcs41DyOKHt5xOKW22UJY7g3bp8al9j2I2agRCoVrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BpGsJdbl; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1755160319; x=1786696319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y9RtB1WT5YHRuTvWwKAbMQj7Mad3XJvZ1fC0rWPGG+8=;
  b=BpGsJdblBGjMpv3Q3Cj5Dhd4fIZRFo4nTus3d94qEAFJCSz9p6jhKZXU
   J7PyQJy4Rrz8l4Mtmlq7Kz82Nmu1RACeb+uEx141t/CRmvLIcqbwlo8FE
   AizaZNadp9qIBpNjmfEYTLR2LRmaxoGyGQTw7V6A2f0XisghqOMub8XcH
   xYZBvNo1SjfWX3/rAh8SD5dSCUDhjrJ7QofnTRB8cuPCsvOOiygdqIXV1
   5hfXuC5vS/sfTFbhmYR8XHz/8yR0gzZNEn3Ta4QXL0FQv+sN8KSwme+Q7
   i+rXfoUOI8G9qMjykbAhOVUWlvbl0cATCwFFtqUXLUeBNSVeQ6x0KgH/K
   Q==;
X-CSE-ConnectionGUID: wuoU55bETYSCuuuNK8jgcQ==
X-CSE-MsgGUID: 8XkOyyBiTgKWnjchjYUxEA==
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="44643954"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Aug 2025 01:31:52 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 14 Aug 2025 01:31:12 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Thu, 14 Aug 2025 01:31:10 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <o.rempel@pengutronix.de>,
	<alok.a.tiwari@oracle.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net-next v4 1/4] net: phy: micrel: Start using PHY_ID_MATCH_MODEL
Date: Thu, 14 Aug 2025 10:26:21 +0200
Message-ID: <20250814082624.696952-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250814082624.696952-1-horatiu.vultur@microchip.com>
References: <20250814082624.696952-1-horatiu.vultur@microchip.com>
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
index 605b0315b4cb0..e138f208c0e49 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -5645,8 +5645,7 @@ static int ksz9131_resume(struct phy_device *phydev)
 
 static struct phy_driver ksphy_driver[] = {
 {
-	.phy_id		= PHY_ID_KS8737,
-	.phy_id_mask	= MICREL_PHY_ID_MASK,
+	PHY_ID_MATCH_MODEL(PHY_ID_KS8737),
 	.name		= "Micrel KS8737",
 	/* PHY_BASIC_FEATURES */
 	.driver_data	= &ks8737_type,
@@ -5687,8 +5686,7 @@ static struct phy_driver ksphy_driver[] = {
 	.suspend	= kszphy_suspend,
 	.resume		= kszphy_resume,
 }, {
-	.phy_id		= PHY_ID_KSZ8041,
-	.phy_id_mask	= MICREL_PHY_ID_MASK,
+	PHY_ID_MATCH_MODEL(PHY_ID_KSZ8041),
 	.name		= "Micrel KSZ8041",
 	/* PHY_BASIC_FEATURES */
 	.driver_data	= &ksz8041_type,
@@ -5703,8 +5701,7 @@ static struct phy_driver ksphy_driver[] = {
 	.suspend	= ksz8041_suspend,
 	.resume		= ksz8041_resume,
 }, {
-	.phy_id		= PHY_ID_KSZ8041RNLI,
-	.phy_id_mask	= MICREL_PHY_ID_MASK,
+	PHY_ID_MATCH_MODEL(PHY_ID_KSZ8041RNLI),
 	.name		= "Micrel KSZ8041RNLI",
 	/* PHY_BASIC_FEATURES */
 	.driver_data	= &ksz8041_type,
@@ -5747,9 +5744,8 @@ static struct phy_driver ksphy_driver[] = {
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
@@ -5768,9 +5764,8 @@ static struct phy_driver ksphy_driver[] = {
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
@@ -5798,8 +5793,7 @@ static struct phy_driver ksphy_driver[] = {
 	.read_mmd	= genphy_read_mmd_unsupported,
 	.write_mmd	= genphy_write_mmd_unsupported,
 }, {
-	.phy_id		= PHY_ID_KSZ9031,
-	.phy_id_mask	= MICREL_PHY_ID_MASK,
+	PHY_ID_MATCH_MODEL(PHY_ID_KSZ9031),
 	.name		= "Micrel KSZ9031 Gigabit PHY",
 	.flags		= PHY_POLL_CABLE_TEST,
 	.driver_data	= &ksz9021_type,
@@ -5819,8 +5813,7 @@ static struct phy_driver ksphy_driver[] = {
 	.cable_test_get_status	= ksz9x31_cable_test_get_status,
 	.set_loopback	= ksz9031_set_loopback,
 }, {
-	.phy_id		= PHY_ID_LAN8814,
-	.phy_id_mask	= MICREL_PHY_ID_MASK,
+	PHY_ID_MATCH_MODEL(PHY_ID_LAN8814),
 	.name		= "Microchip INDY Gigabit Quad PHY",
 	.flags          = PHY_POLL_CABLE_TEST,
 	.config_init	= lan8814_config_init,
@@ -5838,8 +5831,7 @@ static struct phy_driver ksphy_driver[] = {
 	.cable_test_start	= lan8814_cable_test_start,
 	.cable_test_get_status	= ksz886x_cable_test_get_status,
 }, {
-	.phy_id		= PHY_ID_LAN8804,
-	.phy_id_mask	= MICREL_PHY_ID_MASK,
+	PHY_ID_MATCH_MODEL(PHY_ID_LAN8804),
 	.name		= "Microchip LAN966X Gigabit PHY",
 	.config_init	= lan8804_config_init,
 	.driver_data	= &ksz9021_type,
@@ -5854,8 +5846,7 @@ static struct phy_driver ksphy_driver[] = {
 	.config_intr	= lan8804_config_intr,
 	.handle_interrupt = lan8804_handle_interrupt,
 }, {
-	.phy_id		= PHY_ID_LAN8841,
-	.phy_id_mask	= MICREL_PHY_ID_MASK,
+	PHY_ID_MATCH_MODEL(PHY_ID_LAN8841),
 	.name		= "Microchip LAN8841 Gigabit PHY",
 	.flags		= PHY_POLL_CABLE_TEST,
 	.driver_data	= &lan8841_type,
@@ -5872,8 +5863,7 @@ static struct phy_driver ksphy_driver[] = {
 	.cable_test_start	= lan8814_cable_test_start,
 	.cable_test_get_status	= ksz886x_cable_test_get_status,
 }, {
-	.phy_id		= PHY_ID_KSZ9131,
-	.phy_id_mask	= MICREL_PHY_ID_MASK,
+	PHY_ID_MATCH_MODEL(PHY_ID_KSZ9131),
 	.name		= "Microchip KSZ9131 Gigabit PHY",
 	/* PHY_GBIT_FEATURES */
 	.flags		= PHY_POLL_CABLE_TEST,
@@ -5894,8 +5884,7 @@ static struct phy_driver ksphy_driver[] = {
 	.cable_test_get_status	= ksz9x31_cable_test_get_status,
 	.get_features	= ksz9477_get_features,
 }, {
-	.phy_id		= PHY_ID_KSZ8873MLL,
-	.phy_id_mask	= MICREL_PHY_ID_MASK,
+	PHY_ID_MATCH_MODEL(PHY_ID_KSZ8873MLL),
 	.name		= "Micrel KSZ8873MLL Switch",
 	/* PHY_BASIC_FEATURES */
 	.config_init	= kszphy_config_init,
@@ -5904,8 +5893,7 @@ static struct phy_driver ksphy_driver[] = {
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
 }, {
-	.phy_id		= PHY_ID_KSZ886X,
-	.phy_id_mask	= MICREL_PHY_ID_MASK,
+	PHY_ID_MATCH_MODEL(PHY_ID_KSZ886X),
 	.name		= "Micrel KSZ8851 Ethernet MAC or KSZ886X Switch",
 	.driver_data	= &ksz886x_type,
 	/* PHY_BASIC_FEATURES */
@@ -5925,8 +5913,7 @@ static struct phy_driver ksphy_driver[] = {
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
 }, {
-	.phy_id		= PHY_ID_KSZ9477,
-	.phy_id_mask	= MICREL_PHY_ID_MASK,
+	PHY_ID_MATCH_MODEL(PHY_ID_KSZ9477),
 	.name		= "Microchip KSZ9477",
 	.probe		= kszphy_probe,
 	/* PHY_GBIT_FEATURES */
@@ -5953,22 +5940,23 @@ MODULE_LICENSE("GPL");
 
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


