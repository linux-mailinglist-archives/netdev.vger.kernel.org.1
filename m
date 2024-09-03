Return-Path: <netdev+bounces-124488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E5B969AAC
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 12:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11455286041
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 10:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FDC1D86CD;
	Tue,  3 Sep 2024 10:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1AzPoW4e"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB23C1C987B;
	Tue,  3 Sep 2024 10:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360539; cv=none; b=rXCHGhvXnYvqaQ22BfOKIOzB+Os3upBAZKDHTSi+Xxn9SDz5drqO2CF6pnMe44V/Sr0ZpZCeGZ6M4dsidFOkCgERty6y2gcUFpwhorPuJbrp9lA27B7oV+hMZCv63iwKA6TEmoERbEjXgo0jprvksJu6IgwLgx3ZAgvbwWTXWNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360539; c=relaxed/simple;
	bh=6gPhNMCVkjsYb/iNe1vnvKXCmETz6HU3IFpjijceye8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Za4Khdou4YkIzhdEahIYYOp8urJ27z7Ak0TqtYo3L3ZMFSMw7PF6k4rGopK57gYU/zDIH0eEVXciTqMiW7w4gSM7M6R1W3vuJJjA3WkFpLoZokwhmxb6IglefurB/fVbHB+IwLExNOKvhTFoMQSXeIebw9zj2JjFjMrvSB89kZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1AzPoW4e; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725360538; x=1756896538;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6gPhNMCVkjsYb/iNe1vnvKXCmETz6HU3IFpjijceye8=;
  b=1AzPoW4epF6sqZZVjLTYTrcMfi9KzO1KN8pm8XSFuL4/SpHj/Z9Yx+45
   oF4nfnUrparn/MZtEBMOLkWSgRh/yUr8grmAKPknaQcfdcn1DGQeTzVs7
   E+euqLxI06IVMRKbrTVn8iCRAdmnRkgpV0ReLw1j12Llb4r5EC4CLfMHz
   5iV+oqLzKF9ENbjlQQ7qrRyNidgVdBRKUlIgEUMj5VqFzmUc57q9qM+LF
   reI5Cl9tzX6EwVZVUUenXNRRsnnuEOi8JB4zKte+9OlyjpnsyHQD4lwIA
   xbT/VT3ZEUrDLh34ENXeC2pwq/pNlDjQCor6v4GMoTr45jbjIcHtEUV3k
   g==;
X-CSE-ConnectionGUID: fThCcpFNTJeS1Hu2CWwLdA==
X-CSE-MsgGUID: uCB7InSOSgOd6VeRSWD3Vw==
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="262184324"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Sep 2024 03:48:56 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 3 Sep 2024 03:48:39 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 3 Sep 2024 03:48:29 -0700
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
Subject: [PATCH net-next v7 07/14] net: phy: microchip_t1s: add c45 direct access in LAN865x internal PHY
Date: Tue, 3 Sep 2024 16:16:58 +0530
Message-ID: <20240903104705.378684-8-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903104705.378684-1-Parthiban.Veerasooran@microchip.com>
References: <20240903104705.378684-1-Parthiban.Veerasooran@microchip.com>
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


