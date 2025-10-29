Return-Path: <netdev+bounces-233803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C276C18B32
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 08:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB9D43A55B6
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 07:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E457930F929;
	Wed, 29 Oct 2025 07:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Z5FUXwDN"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389B928A3EF;
	Wed, 29 Oct 2025 07:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761722910; cv=none; b=MEbJKQfzbTzcGxRrTW2ko06I3+Y7Z0nvTmyJYQ08Dc87YK5do9bvNaz1+u7Fkrt2ZwifPdwgSjY2iP6rYkHLJhigHoFDNkr2TNtb51PO8U55AyD5h5rc0gXyvq+DxRZRhtPcZusQkrvUdr3Lv9ogjRANLfVossoZZUmrOpwPwcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761722910; c=relaxed/simple;
	bh=yxETgaEVL24wQO0PvJWn2aHDzqmEPcI1ly/KfqUGQ9U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DT41//OGl4jWfkR1LaF0PYwDrQLxS9VceKY03mjtFU324c3Zmb2Gt9NqmHNAkc/qMM01Qs5PMRD5SVfOrhFjEcqwE9ZG2GscyIB6NMzcVrs7f/eRFj12H/zNrlGYOOIe0sgR8Nn2DRcNLY3Vuhivs8HK1fkUujM3txAAz/cAKMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Z5FUXwDN; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1761722909; x=1793258909;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yxETgaEVL24wQO0PvJWn2aHDzqmEPcI1ly/KfqUGQ9U=;
  b=Z5FUXwDNlySNWuijFMzkgIwCSYleQ+taEonuWDsCPRDqDMsRZxPQl15N
   ++BCLm+nOjKYQ2x9NQc/Su9/HCr/mUoEjEzvLM0b0ScRiH1R8FawUBIiD
   NRySVhCIATAjFsE7r7VcYpAeoSoOdnW/t1sg25cxboNPzf9Z00Xd8qnkI
   6LNbAoHYajMrIMmS1F7NIYmKLldYcQdizzJGI1Go3yHkomwuHU++GR/eY
   v4BhNtSEezFbASjA1KT20Ox1sadYf+8XqfGVAeqalS7eyMvul0B0XHnQP
   ODFhVQ1QPlcvjWLIbcK3LmosmdGI0s+121GYm9nEpAy3rA++00Zc9ikI8
   w==;
X-CSE-ConnectionGUID: lh0mYcbFSl+9cvidjQy/DA==
X-CSE-MsgGUID: 755eDHn8Q2Wup5k4y3w1aQ==
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="215747488"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Oct 2025 00:28:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 29 Oct 2025 00:28:17 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 29 Oct 2025 00:28:15 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net v2 2/2] net: phy: micrel: lan8842 errata
Date: Wed, 29 Oct 2025 08:24:56 +0100
Message-ID: <20251029072456.392969-3-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029072456.392969-1-horatiu.vultur@microchip.com>
References: <20251029072456.392969-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add errata for lan8842. The errata document can be found here [1].
This is fixing the module 7 ("1000BASE-T PMA EEE TX wake PHY-side shorted
center taps")

[1] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/Errata/LAN8842-Errata-DS80001172.pdf

Fixes: 5a774b64cd6a ("net: phy: micrel: Add support for lan8842")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/micrel.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 4b526587093c6..d063e77f07f81 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -2835,6 +2835,13 @@ static int ksz886x_cable_test_get_status(struct phy_device *phydev,
  */
 #define LAN8814_PAGE_PCS_DIGITAL 2
 
+/**
+ * LAN8814_PAGE_EEE - Selects Extended Page 3.
+ *
+ * This page contains EEE registers
+ */
+#define LAN8814_PAGE_EEE 3
+
 /**
  * LAN8814_PAGE_COMMON_REGS - Selects Extended Page 4.
  *
@@ -5952,6 +5959,9 @@ static int lan8842_probe(struct phy_device *phydev)
 
 #define LAN8814_POWER_MGMT_VAL5		LAN8814_POWER_MGMT_B_C_D
 
+#define LAN8814_EEE_WAKE_TX_TIMER			0x0e
+#define LAN8814_EEE_WAKE_TX_TIMER_MAX_VAL		0x1f
+
 static int lan8842_erratas(struct phy_device *phydev)
 {
 	int ret;
@@ -6023,9 +6033,16 @@ static int lan8842_erratas(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
-	return lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
-				     LAN8814_POWER_MGMT_MODE_14_100BTX_EEE_TX_RX,
-				     LAN8814_POWER_MGMT_VAL4);
+	ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
+				    LAN8814_POWER_MGMT_MODE_14_100BTX_EEE_TX_RX,
+				    LAN8814_POWER_MGMT_VAL4);
+	if (ret < 0)
+		return ret;
+
+	/* Refresh time Waketx timer */
+	return lanphy_write_page_reg(phydev, LAN8814_PAGE_EEE,
+				     LAN8814_EEE_WAKE_TX_TIMER,
+				     LAN8814_EEE_WAKE_TX_TIMER_MAX_VAL);
 }
 
 static int lan8842_config_init(struct phy_device *phydev)
-- 
2.34.1


