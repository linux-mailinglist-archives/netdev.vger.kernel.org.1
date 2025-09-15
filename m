Return-Path: <netdev+bounces-222940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C245B5727F
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 10:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94CF71A2044C
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 08:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEEE2EA476;
	Mon, 15 Sep 2025 08:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jjmz3yV5"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFB72E9EC7;
	Mon, 15 Sep 2025 08:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923531; cv=none; b=ic5zhmMxWgqEMYD5E2TRTwGqbkFLLKeitTMHIQGYpgimFZs3IkAxo6/Vf+cWGqjPxcEOIpEqG34o1QhWhB2jbMRUbiq0BnHGNW882wYc/rcjeKqVofN3LDF4cKcUdr+L9tKVHXZSBlRgee7xerCXYRXftf5fCcIblf8kgrMA14I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923531; c=relaxed/simple;
	bh=B74HX5e+TfRygmN6Og4POXNipS2VHQDoP8es2YE1kNc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u38sQARDITpaQXxVpGktCbCbgwvuHylxgokXX6T/kNKpEaBOYzJ/sItnP5c00XnHmC4D+yWvK5wfmGKYO0aHBFPNoG0jVO93CDWr6lFFRTND6VfMYCfpYVDcs2ZGj82m6vMpzowmaX9x3bUycDSbU1uBsM+c7cElFdcYC2Z0sRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jjmz3yV5; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1757923529; x=1789459529;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B74HX5e+TfRygmN6Og4POXNipS2VHQDoP8es2YE1kNc=;
  b=jjmz3yV5k4P8OXl/Km9t6DejuYxQoVdef6j4H/qGmewvXbkpjqiyPsoW
   UeZmlUdAquR2YzSxUafXOyZYYFMUe48kzvWNA4yO05TQL8t19BZ6f9BjB
   9R8NkbY8qlk5ZU7P/0M76GkOYi8Ild+N4sV15Q3P8WeyLAyvNGa9EUNiT
   WNqBUV2ZKivq1OGP0hpfnYekZ2IoCZ71Y6/hBF0iMEl6rS7OJQRFtPfG8
   6JZ5RdAjX6ND9bVxBslJIegU0kT2lsYSHTt+GsocuyfJ5apLMurCaZCyB
   Z3uqctM16f92FWlac8S9Bg+R5e5I8D5MQEEQDlLaeXrwEyuVTMAxKwMLy
   g==;
X-CSE-ConnectionGUID: ewY7/e+gQ0WFS+nyOvSX4A==
X-CSE-MsgGUID: 824WDI+DT/Wt1juxykZo1A==
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="213889417"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Sep 2025 01:05:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 15 Sep 2025 01:05:14 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 15 Sep 2025 01:05:11 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <vladimir.oltean@nxp.com>,
	<vadim.fedorenko@linux.dev>, <rosenp@gmail.com>,
	<rmk+kernel@armlinux.org.uk>, <christophe.jaillet@wanadoo.fr>,
	<steen.hegelund@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net] phy: mscc: Fix PTP for vsc8574 and VSC8572
Date: Mon, 15 Sep 2025 10:01:12 +0200
Message-ID: <20250915080112.3531170-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

When trying to enable PTP on vsc8574 and vsc8572 it is not working even
if the function vsc8584_ptp_init it says that it has support for PHY
timestamping. It is not working because there is no PTP device.
So, to fix this make sure to create a PTP device also for this PHYs as
they have the same PTP IP as the other vsc PHYs.

Fixes: 774626fa440e ("net: phy: mscc: Add PTP support for 2 more VSC PHYs")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/mscc/mscc_main.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index ef0ef1570d392..89b5cd96e8720 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -2259,6 +2259,7 @@ static int vsc8574_probe(struct phy_device *phydev)
 	u32 default_mode[4] = {VSC8531_LINK_1000_ACTIVITY,
 	   VSC8531_LINK_100_ACTIVITY, VSC8531_LINK_ACTIVITY,
 	   VSC8531_DUPLEX_COLLISION};
+	int ret;
 
 	vsc8531 = devm_kzalloc(&phydev->mdio.dev, sizeof(*vsc8531), GFP_KERNEL);
 	if (!vsc8531)
@@ -2267,8 +2268,11 @@ static int vsc8574_probe(struct phy_device *phydev)
 	phydev->priv = vsc8531;
 
 	vsc8584_get_base_addr(phydev);
-	devm_phy_package_join(&phydev->mdio.dev, phydev,
-			      vsc8531->base_addr, 0);
+	ret = devm_phy_package_join(&phydev->mdio.dev, phydev,
+				    vsc8531->base_addr,
+				    sizeof(struct vsc85xx_shared_private));
+	if (ret)
+		return ret;
 
 	vsc8531->nleds = 4;
 	vsc8531->supp_led_modes = VSC8584_SUPP_LED_MODES;
@@ -2279,6 +2283,16 @@ static int vsc8574_probe(struct phy_device *phydev)
 	if (!vsc8531->stats)
 		return -ENOMEM;
 
+	if (phy_package_probe_once(phydev)) {
+		ret = vsc8584_ptp_probe_once(phydev);
+		if (ret)
+			return ret;
+	}
+
+	ret = vsc8584_ptp_probe(phydev);
+	if (ret)
+		return ret;
+
 	return vsc85xx_dt_led_modes_get(phydev, default_mode);
 }
 
@@ -2648,7 +2662,7 @@ static struct phy_driver vsc85xx_driver[] = {
 	.config_aneg    = &vsc85xx_config_aneg,
 	.aneg_done	= &genphy_aneg_done,
 	.read_status	= &vsc85xx_read_status,
-	.handle_interrupt = vsc85xx_handle_interrupt,
+	.handle_interrupt = vsc8584_handle_interrupt,
 	.config_intr    = &vsc85xx_config_intr,
 	.suspend	= &genphy_suspend,
 	.resume		= &genphy_resume,
-- 
2.34.1


