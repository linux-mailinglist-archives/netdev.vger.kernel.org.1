Return-Path: <netdev+bounces-130443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9ED98A879
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 17:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BBCF28401E
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9721991A4;
	Mon, 30 Sep 2024 15:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ec9HNwXx"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1091990C6;
	Mon, 30 Sep 2024 15:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727710116; cv=none; b=V4Fuz24kkYgcoeBP5UEh2XgqmzdyExsiOfDGAMLYyVmqlO4qP+stcTVzaRMTsnqd6B4ZU/q/vpaq1lyZ3Ky3w2+4rIeuGHkX4CO5mpMTvUYC5gguWogjN/0iV8UaTZRwEcLMPhxRCU2g+0cAuZAhg5fk1frRHD4EE65pFOEguGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727710116; c=relaxed/simple;
	bh=zPMycqcaQFSH5qmCiQibqp0JXKgtnY3HstC3yy+e+SM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UEdwg2HLt4VMtQpVcfqx3Lh2Z9ztqSKq90EaL3Jf3RxljXczVLSJ8qxcuaIphPgF4kZt1uZD4wv6fSOvnkmLjFtut5PbmkToVo1Rmeyp+SgTWEgcXRTJd/sCTjn4rH9n2UhCtPodlPBMsG8Y9tRjtWt08wTOj5KafrTf7tB59Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ec9HNwXx; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727710113; x=1759246113;
  h=from:to:subject:date:message-id:mime-version;
  bh=zPMycqcaQFSH5qmCiQibqp0JXKgtnY3HstC3yy+e+SM=;
  b=ec9HNwXxsO7uhUYe6hjgB7RhPh0NyCluqGKDWLqADmyDRwg7AQPwYgHi
   l8EaDHwP33OaybB7RAHHYDwD8RA5SA2y82+s4yyIJx+V0OQP6H20eKYgG
   HFGShSn/pp7V/vHJDFl8w/wcutU4uhIOZhotMOEKfvrxmQXEnCvGRpK26
   v6HKQh01B+zeM709Q80B0ByO13zQKk/QWvvYip/5BeF03vrBumGyr0ox+
   a8YB11Xu/j7OTKttiq2NAhyxD5wlBeOv9BIYVO5ulOsC5z6D84TFE9uRz
   E3VEK4M+sMGgKyENDbkuaLRDc+1fRO20OUU3WtK/aoSfLlCrWvFOW/A+S
   A==;
X-CSE-ConnectionGUID: hMfDavZxTaa5IPYiElDNIw==
X-CSE-MsgGUID: GaIvNzJrRKiok6NmfF/qvA==
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="32263931"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Sep 2024 08:28:30 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 30 Sep 2024 08:28:23 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 30 Sep 2024 08:28:19 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <arun.ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] net: phy: microchip_t1: Interrupt support for lan887x
Date: Mon, 30 Sep 2024 21:04:23 +0530
Message-ID: <20240930153423.16893-1-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Add support for link up and link down interrupts in lan887x.

Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
---
 drivers/net/phy/microchip_t1.c | 63 ++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t1.c
index a5ef8fe50704..383050a5b0ed 100644
--- a/drivers/net/phy/microchip_t1.c
+++ b/drivers/net/phy/microchip_t1.c
@@ -226,6 +226,18 @@
 #define MICROCHIP_CABLE_MAX_TIME_DIFF	\
 	(MICROCHIP_CABLE_MIN_TIME_DIFF + MICROCHIP_CABLE_TIME_MARGIN)
 
+#define LAN887X_INT_STS				0xf000
+#define LAN887X_INT_MSK				0xf001
+#define LAN887X_INT_MSK_T1_PHY_INT_MSK		BIT(2)
+#define LAN887X_INT_MSK_LINK_UP_MSK		BIT(1)
+#define LAN887X_INT_MSK_LINK_DOWN_MSK		BIT(0)
+
+#define LAN887X_MX_CHIP_TOP_LINK_MSK	(LAN887X_INT_MSK_LINK_UP_MSK |\
+					 LAN887X_INT_MSK_LINK_DOWN_MSK)
+
+#define LAN887X_MX_CHIP_TOP_ALL_MSK	(LAN887X_INT_MSK_T1_PHY_INT_MSK |\
+					 LAN887X_MX_CHIP_TOP_LINK_MSK)
+
 #define DRIVER_AUTHOR	"Nisar Sayed <nisar.sayed@microchip.com>"
 #define DRIVER_DESC	"Microchip LAN87XX/LAN937x/LAN887x T1 PHY driver"
 
@@ -1474,6 +1486,7 @@ static void lan887x_get_strings(struct phy_device *phydev, u8 *data)
 		ethtool_puts(&data, lan887x_hw_stats[i].string);
 }
 
+static int lan887x_config_intr(struct phy_device *phydev);
 static int lan887x_cd_reset(struct phy_device *phydev,
 			    enum cable_diag_state cd_done)
 {
@@ -1504,6 +1517,10 @@ static int lan887x_cd_reset(struct phy_device *phydev,
 		if (rc < 0)
 			return rc;
 
+		rc = lan887x_config_intr(phydev);
+		if (rc < 0)
+			return rc;
+
 		rc = lan887x_phy_reconfig(phydev);
 		if (rc < 0)
 			return rc;
@@ -1830,6 +1847,50 @@ static int lan887x_cable_test_get_status(struct phy_device *phydev,
 	return lan887x_cable_test_report(phydev);
 }
 
+static int lan887x_config_intr(struct phy_device *phydev)
+{
+	int ret;
+
+	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
+		/* Clear the interrupt status before enabling interrupts */
+		ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, LAN887X_INT_STS);
+		if (ret < 0)
+			return ret;
+
+		/* Unmask for enabling interrupt */
+		ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, LAN887X_INT_MSK,
+				    (u16)~LAN887X_MX_CHIP_TOP_ALL_MSK);
+	} else {
+		ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, LAN887X_INT_MSK,
+				    GENMASK(15, 0));
+		if (ret < 0)
+			return ret;
+
+		ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, LAN887X_INT_STS);
+	}
+
+	return ret < 0 ? ret : 0;
+}
+
+static irqreturn_t lan887x_handle_interrupt(struct phy_device *phydev)
+{
+	int ret = IRQ_NONE;
+	int irq_status;
+
+	irq_status = phy_read_mmd(phydev, MDIO_MMD_VEND1, LAN887X_INT_STS);
+	if (irq_status < 0) {
+		phy_error(phydev);
+		return IRQ_NONE;
+	}
+
+	if (irq_status & LAN887X_MX_CHIP_TOP_LINK_MSK) {
+		phy_trigger_machine(phydev);
+		ret = IRQ_HANDLED;
+	}
+
+	return ret;
+}
+
 static struct phy_driver microchip_t1_phy_driver[] = {
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_LAN87XX),
@@ -1881,6 +1942,8 @@ static struct phy_driver microchip_t1_phy_driver[] = {
 		.read_status	= genphy_c45_read_status,
 		.cable_test_start = lan887x_cable_test_start,
 		.cable_test_get_status = lan887x_cable_test_get_status,
+		.config_intr    = lan887x_config_intr,
+		.handle_interrupt = lan887x_handle_interrupt,
 	}
 };
 
-- 
2.17.1


