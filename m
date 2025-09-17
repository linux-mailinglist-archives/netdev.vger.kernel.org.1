Return-Path: <netdev+bounces-223987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 309E3B7D2B5
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4B393B32E5
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 11:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D25369989;
	Wed, 17 Sep 2025 11:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2kji8JiE"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBEC3451AE;
	Wed, 17 Sep 2025 11:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758109214; cv=none; b=IanIOQV/RDS4tOrH1HW1tztCz5H0yfbkDZCLtWO7AcH9MhIUD4I6e8a5yluUunSicitGvtNiYTVog1gDm0uM9GlJ/WNsKLdv9pmZCaxxptumxx1YdRFFGHAQDCmU0fJ3+oX8VL0xD4E7WuYlmVT+lITwzlAu/nanhom0SwM3sHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758109214; c=relaxed/simple;
	bh=0CFr4L7/ydIfSU2skwYgtJgnhmnNMA/TEnIk4Hyxj0U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q80Um/KQZ1OoUchnCZneubjTsb+hX9FtuPsVvr/6r3WZeMopeKJmJce1d6suYhqjlOP3CXdzdSRfKIjX4fqVf4xFQl9AG7hWU5/rODIsDNbHaY94vEfp0m2SLYE3+g/kr1C8PrnpuL2B2h25xU5IpBORVObrqv5dHA3QxvQWwBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2kji8JiE; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758109212; x=1789645212;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0CFr4L7/ydIfSU2skwYgtJgnhmnNMA/TEnIk4Hyxj0U=;
  b=2kji8JiEFlo66ByxOR11f6NnZNfrKTEFaLo8VbJdb3MrJxvz898lVXbd
   la3cRh53VTy2Y0PtQxC7p5qC8oFVoHxX1LBTQTEeHvRW8RHJhgLCbpiCB
   wTmhTQzF/aNmDZS17HjlE+RIn/wDtMCuTdPLEW1DhDReMAYj0SroxxKWt
   KbAn4z76p8wYa9zj4qM5ZC1bZ41YKFqonI0fLww/U6kZamiyvkAX3rtPh
   TrQgqjaeNXaOUKGrLogq7cVv8NzlwnsY9U5kGXGvl6UvZAWMxwGD0E3fX
   iCn4z50IrGNJTvqisF7xd9ihgAI77qrpkIx5VnEK2SSm0ZWzycrfYQNCV
   Q==;
X-CSE-ConnectionGUID: k5qsnvPHRd6rN6b8ix7Vog==
X-CSE-MsgGUID: jUuy+zBPTualp0eC8tgmZQ==
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="46619847"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Sep 2025 04:39:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 17 Sep 2025 04:38:09 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 17 Sep 2025 04:38:06 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <vladimir.oltean@nxp.com>,
	<vadim.fedorenko@linux.dev>, <rmk+kernel@armlinux.org.uk>,
	<christophe.jaillet@wanadoo.fr>, <rosenp@gmail.com>,
	<steen.hegelund@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net v2] phy: mscc: Fix PTP for vsc8574 and VSC8572
Date: Wed, 17 Sep 2025 13:33:16 +0200
Message-ID: <20250917113316.3973777-1-horatiu.vultur@microchip.com>
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
v1->v2:
- rename vsc8574_probe to vsc8552_probe and introduce a new probe
  function called vsc8574_probe and make sure that vsc8504 and vsc8552
  will use vsc8552_probe.
---
 drivers/net/phy/mscc/mscc_main.c | 51 +++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index ef0ef1570d392..e9a8dc6096868 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -2253,7 +2253,7 @@ static int vsc8514_probe(struct phy_device *phydev)
 	return vsc85xx_dt_led_modes_get(phydev, default_mode);
 }
 
-static int vsc8574_probe(struct phy_device *phydev)
+static int vsc8552_probe(struct phy_device *phydev)
 {
 	struct vsc8531_private *vsc8531;
 	u32 default_mode[4] = {VSC8531_LINK_1000_ACTIVITY,
@@ -2282,6 +2282,49 @@ static int vsc8574_probe(struct phy_device *phydev)
 	return vsc85xx_dt_led_modes_get(phydev, default_mode);
 }
 
+static int vsc8574_probe(struct phy_device *phydev)
+{
+	struct vsc8531_private *vsc8531;
+	u32 default_mode[4] = {VSC8531_LINK_1000_ACTIVITY,
+	   VSC8531_LINK_100_ACTIVITY, VSC8531_LINK_ACTIVITY,
+	   VSC8531_DUPLEX_COLLISION};
+	int ret;
+
+	vsc8531 = devm_kzalloc(&phydev->mdio.dev, sizeof(*vsc8531), GFP_KERNEL);
+	if (!vsc8531)
+		return -ENOMEM;
+
+	phydev->priv = vsc8531;
+
+	vsc8584_get_base_addr(phydev);
+	ret = devm_phy_package_join(&phydev->mdio.dev, phydev,
+				    vsc8531->base_addr,
+				    sizeof(struct vsc85xx_shared_private));
+	if (ret)
+		return ret;
+
+	vsc8531->nleds = 4;
+	vsc8531->supp_led_modes = VSC8584_SUPP_LED_MODES;
+	vsc8531->hw_stats = vsc8584_hw_stats;
+	vsc8531->nstats = ARRAY_SIZE(vsc8584_hw_stats);
+	vsc8531->stats = devm_kcalloc(&phydev->mdio.dev, vsc8531->nstats,
+				      sizeof(u64), GFP_KERNEL);
+	if (!vsc8531->stats)
+		return -ENOMEM;
+
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
+	return vsc85xx_dt_led_modes_get(phydev, default_mode);
+}
+
 static int vsc8584_probe(struct phy_device *phydev)
 {
 	struct vsc8531_private *vsc8531;
@@ -2426,7 +2469,7 @@ static struct phy_driver vsc85xx_driver[] = {
 	.config_intr    = &vsc85xx_config_intr,
 	.suspend	= &genphy_suspend,
 	.resume		= &genphy_resume,
-	.probe		= &vsc8574_probe,
+	.probe		= &vsc8552_probe,
 	.set_wol	= &vsc85xx_wol_set,
 	.get_wol	= &vsc85xx_wol_get,
 	.get_tunable	= &vsc85xx_get_tunable,
@@ -2573,7 +2616,7 @@ static struct phy_driver vsc85xx_driver[] = {
 	.config_intr    = &vsc85xx_config_intr,
 	.suspend	= &genphy_suspend,
 	.resume		= &genphy_resume,
-	.probe		= &vsc8574_probe,
+	.probe		= &vsc8552_probe,
 	.set_wol	= &vsc85xx_wol_set,
 	.get_wol	= &vsc85xx_wol_get,
 	.get_tunable	= &vsc85xx_get_tunable,
@@ -2648,7 +2691,7 @@ static struct phy_driver vsc85xx_driver[] = {
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


