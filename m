Return-Path: <netdev+bounces-236209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E93C39C1D
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 10:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F2C43ADE92
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 09:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7978730AD1F;
	Thu,  6 Nov 2025 09:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vUuSQeML"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22D730B502;
	Thu,  6 Nov 2025 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762420116; cv=none; b=nwcKjV1+SmYrSPUaXIFbgWioFFgqRYn1Ga0XvrafKwHqldbS3euzXJ4w62TXxuLIzLCCYJcWjXefuR9pseNMIpf9GWIL7+L60ihMXslmAZwrywvkRpDpaFYyTDzZtQhfz7LrPoTinr2jedG+AIg7WKe7D5pQJv3lS1MTSIwRfIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762420116; c=relaxed/simple;
	bh=iGpmSdSo2yJmtaqehnE/3eeou3gMSExG+9UWDLALvQQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uBNM6uKx+Kss4136Rpu2n5rieFLO+r0UkA+/7Qoj/sTvfD4PS5LtQZwpQAFxldq0YNyG8gSy+FRH9tAonmJNcapF1buUMm69lr1y8vMBLszQbC+O7AbycOYI+s4OGtHqPNh9d6CPx+YKGJVJAEpihTIDS2Dgur0kzHu6hBoUiik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vUuSQeML; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1762420114; x=1793956114;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iGpmSdSo2yJmtaqehnE/3eeou3gMSExG+9UWDLALvQQ=;
  b=vUuSQeMLhbBM4DMqaRN8PIcX2BQBnWEguVGXmg80lMJ5+/q82Lczu7ru
   x+A3mO9bPtNo/Nnr2qASuVjEFLuJS2R+0bNQA6UtepOdw3q9mzFxR3QtD
   LVScwyjJWaVvxfCLRLcFDBw3ADz7DB0s/6Njurt1ogAUgHRaC5Q5sGFRL
   2squLG/FF1SL7lAcKlgjM8pGIBg/bXrpPOUrrW56YXGKIRMVBgHVokYn5
   RPZQS9Lh7qmHrqVXpfjcjjqFtVBpOfFQ/vG8OHW6rAT3gFkGlrpr+jU4P
   /SDyvKlisGct4Msa6EFUZ6VaSTB6XJeJvDRutyTGAwCt2YnLBG8vu73bB
   A==;
X-CSE-ConnectionGUID: CANT/SDnQx+xGnm7qABWrg==
X-CSE-MsgGUID: nflLaY7aT0G9AuxRj3jTmw==
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="55143432"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 02:08:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Thu, 6 Nov 2025 02:08:15 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 6 Nov 2025 02:08:13 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Divya.Koppera@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net] net: phy: micrel: lan8814 fix reset of the QSGMII interface
Date: Thu, 6 Nov 2025 10:06:37 +0100
Message-ID: <20251106090637.2030625-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The lan8814 is a quad-phy and it is using QSGMII towards the MAC.
The problem is that everytime when one of the ports is configured then
the PCS is reseted for all the PHYs. Meaning that the other ports can
loose traffic until the link is establish again.
To fix this, do the reset one time for the entire PHY package.

Fixes: ece19502834d ("net: phy: micrel: 1588 support for LAN8814 phy")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/micrel.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 6a1a424e3b30f..01c87c9b77020 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -4380,12 +4380,6 @@ static int lan8814_config_init(struct phy_device *phydev)
 {
 	struct kszphy_priv *lan8814 = phydev->priv;
 
-	/* Reset the PHY */
-	lanphy_modify_page_reg(phydev, LAN8814_PAGE_COMMON_REGS,
-			       LAN8814_QSGMII_SOFT_RESET,
-			       LAN8814_QSGMII_SOFT_RESET_BIT,
-			       LAN8814_QSGMII_SOFT_RESET_BIT);
-
 	/* Disable ANEG with QSGMII PCS Host side */
 	lanphy_modify_page_reg(phydev, LAN8814_PAGE_PORT_REGS,
 			       LAN8814_QSGMII_PCS1G_ANEG_CONFIG,
@@ -4471,6 +4465,12 @@ static int lan8814_probe(struct phy_device *phydev)
 			      addr, sizeof(struct lan8814_shared_priv));
 
 	if (phy_package_init_once(phydev)) {
+		/* Reset the PHY */
+		lanphy_modify_page_reg(phydev, LAN8814_PAGE_COMMON_REGS,
+				       LAN8814_QSGMII_SOFT_RESET,
+				       LAN8814_QSGMII_SOFT_RESET_BIT,
+				       LAN8814_QSGMII_SOFT_RESET_BIT);
+
 		err = lan8814_release_coma_mode(phydev);
 		if (err)
 			return err;
-- 
2.34.1


