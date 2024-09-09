Return-Path: <netdev+bounces-126415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 199349711FE
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 10:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE54428579A
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 08:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B79F1B3B34;
	Mon,  9 Sep 2024 08:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="T8K+SztF"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11B71B1D7E;
	Mon,  9 Sep 2024 08:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725870413; cv=none; b=LDqwHiTWysXaIJJdp60SPkHcGwcjEq/rIW2kgnJzPWOcvNWeKAR8ojIbrZULsn++CkqqGlF9fEdY1Uca+2TsNqIyvinJ22IthPu9toeGOiflO34eFSU9ONwRl97tOwK854GfCtrU66AanaRbF26Cz8lP1a9Nf64rlv4LnPYSoM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725870413; c=relaxed/simple;
	bh=6gPhNMCVkjsYb/iNe1vnvKXCmETz6HU3IFpjijceye8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GokuYnP7i/SBm9VMkibG0KSAHEQPVo6HbcrCFQ0EugS2lUUdNoXXlNX75tZXHAjwczB1I28L+ZLUa43mbt4ECpc3TcdIbClg0Itt+SdrHc1xt0jJI1OWOCaupZKvqZYLq40nGqBwmwmL4sN531dw4hzmtwzWRF9zP8T4kz/9oSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=T8K+SztF; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725870412; x=1757406412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6gPhNMCVkjsYb/iNe1vnvKXCmETz6HU3IFpjijceye8=;
  b=T8K+SztFncB/ZWn/IhZxA/umkNDSTUK0kJYpqy+YKMkFu/rz7rv/pGGG
   eX9KlkNSWkviFePtjo5CuWQ+6jim9hIX8mjBpdNUSTz5vcUwlwB1iMXGf
   qCCzT4Ga3KAFxZVfUyX2RNtE33kB6PnNbmSkR1cNYobzdo6EkoKnl7VPE
   WQtwoZF8uz1eEpgb0WUNzTLozZSROXRRwbN0sC62DRlGa0LYEPsBfCgJt
   Uvl2/nsnbt38a3H/dh9Ux92AX+qihqIytF89uOOBU67hRhBm+Nwo2sfKI
   VOd383i3u7ztjy+UfPN6zQG77m0LiYESqHnzGijF4GsoQ1mGap5PaVSyA
   Q==;
X-CSE-ConnectionGUID: IaT2qUr8REyxuKsTOysLmw==
X-CSE-MsgGUID: xMJxFVp+SCm5j6scvTDsYw==
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="262470616"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2024 01:26:51 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 9 Sep 2024 01:26:43 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 9 Sep 2024 01:26:33 -0700
From: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <andrew@lunn.ch>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <horatiu.vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <steen.hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>
CC: <parthiban.veerasooran@microchip.com>, <masahiroy@kernel.org>,
	<alexanderduyck@fb.com>, <krzk+dt@kernel.org>, <robh@kernel.org>,
	<rdunlap@infradead.org>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>,
	<Nicolas.Ferre@microchip.com>, <benjamin.bigler@bernformulastudent.ch>,
	<linux@bigler.io>, <markku.vorne@kempower.com>, Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next v8 07/14] net: phy: microchip_t1s: add c45 direct access in LAN865x internal PHY
Date: Mon, 9 Sep 2024 13:55:07 +0530
Message-ID: <20240909082514.262942-8-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240909082514.262942-1-Parthiban.Veerasooran@microchip.com>
References: <20240909082514.262942-1-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch adds c45 registers direct access support in Microchip's
LAN865x internal PHY.

OPEN Alliance 10BASE-T1x compliance MAC-PHYs will have both C22 and C45
registers space. If the PHY is discovered via C22 bus protocol it assumes
it uses C22 protocol and always uses C22 registers indirect access to
access C45 registers. This is because, we don't have a clean separation
between C22/C45 register space and C22/C45 MDIO bus protocols. Resulting,
PHY C45 registers direct access can't be used which can save multiple SPI
bus access. To support this feature, set .read_mmd/.write_mmd in the PHY
driver to call .read_c45/.write_c45 in the OPEN Alliance framework
drivers/net/ethernet/oa_tc6.c

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 drivers/net/phy/microchip_t1s.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index 534ca7d1b061..3614839a8e51 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -268,6 +268,34 @@ static int lan86xx_read_status(struct phy_device *phydev)
 	return 0;
 }
 
+/* OPEN Alliance 10BASE-T1x compliance MAC-PHYs will have both C22 and
+ * C45 registers space. If the PHY is discovered via C22 bus protocol it assumes
+ * it uses C22 protocol and always uses C22 registers indirect access to access
+ * C45 registers. This is because, we don't have a clean separation between
+ * C22/C45 register space and C22/C45 MDIO bus protocols. Resulting, PHY C45
+ * registers direct access can't be used which can save multiple SPI bus access.
+ * To support this feature, set .read_mmd/.write_mmd in the PHY driver to call
+ * .read_c45/.write_c45 in the OPEN Alliance framework
+ * drivers/net/ethernet/oa_tc6.c
+ */
+static int lan865x_phy_read_mmd(struct phy_device *phydev, int devnum,
+				u16 regnum)
+{
+	struct mii_bus *bus = phydev->mdio.bus;
+	int addr = phydev->mdio.addr;
+
+	return __mdiobus_c45_read(bus, addr, devnum, regnum);
+}
+
+static int lan865x_phy_write_mmd(struct phy_device *phydev, int devnum,
+				 u16 regnum, u16 val)
+{
+	struct mii_bus *bus = phydev->mdio.bus;
+	int addr = phydev->mdio.addr;
+
+	return __mdiobus_c45_write(bus, addr, devnum, regnum, val);
+}
+
 static struct phy_driver microchip_t1s_driver[] = {
 	{
 		PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVB1),
@@ -285,6 +313,8 @@ static struct phy_driver microchip_t1s_driver[] = {
 		.features           = PHY_BASIC_T1S_P2MP_FEATURES,
 		.config_init        = lan865x_revb0_config_init,
 		.read_status        = lan86xx_read_status,
+		.read_mmd           = lan865x_phy_read_mmd,
+		.write_mmd          = lan865x_phy_write_mmd,
 		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
 		.set_plca_cfg	    = genphy_c45_plca_set_cfg,
 		.get_plca_status    = genphy_c45_plca_get_status,
-- 
2.34.1


