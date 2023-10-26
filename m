Return-Path: <netdev+bounces-44390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D54F47D7C6B
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 07:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186501C20D85
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 05:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14BEC8F7;
	Thu, 26 Oct 2023 05:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jXH/Owlu"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F520FC07
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 05:44:32 +0000 (UTC)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5765A1A2;
	Wed, 25 Oct 2023 22:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698299064; x=1729835064;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s4XlweU06/WjfxjbPFFYgx9tnnfQIqxKqZo14QClh4k=;
  b=jXH/Owlu8FHKyi8L+J2Gu9tL7qblx2ZsVYe96qT/992wt/1jETunbK3q
   jVPVtFKah/KG9fW6vqjVBiCcFJfjEKYeL3Adp2v55RSeVAfhmoVisXgmG
   Q3J18uSnWepTf8ePGjG2bbP2gMKqTKgVsqKURhA4aXu/cIp0DcjHQ0WSE
   jjHe7c9pMqrwRtoYse41Zs9fWMYptiBj4lWku1AKBA6OayZiWQbRL/qCY
   k2UB37jAej8dTPkXKuyavXYFIDgLJfQZK4TTzMWl0ssSpwYEYEXKQUuoD
   gdr5jtyaw6IMKErq3gEqrwLbhYWqR5yxr3HHQFfSFsx5ByvCfZ00aNoZg
   A==;
X-CSE-ConnectionGUID: Uxd6NvfbRaGg4YfpXPM/Og==
X-CSE-MsgGUID: ryL80tZOSGKD0wcqxcEsyg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="11210278"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Oct 2023 22:44:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 25 Oct 2023 22:44:21 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Wed, 25 Oct 2023 22:44:18 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<andrew@lunn.ch>, <Jose.Abreu@synopsys.com>, <linux@armlinux.org.uk>,
	<fancer.lancer@gmail.com>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next V1] net: pcs: xpcs: Add 2500BASE-X case in get state for XPCS drivers
Date: Thu, 26 Oct 2023 11:13:05 +0530
Message-ID: <20231026054305.336968-1-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add DW_2500BASEX case in xpcs_get_state( ) to update speed, duplex and pause

Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
Change List:
============
V0 -> V1:
  - Remove the auto-negotiation check due to currently the DW_2500BASEX mode 
    doesn't imply any auto-negotiation 

 drivers/net/pcs/pcs-xpcs.c | 29 +++++++++++++++++++++++++++++
 drivers/net/pcs/pcs-xpcs.h |  2 ++
 2 files changed, 31 insertions(+)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 4dbc21f604f2..f5e1dcac9e3e 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1090,6 +1090,28 @@ static int xpcs_get_state_c37_1000basex(struct dw_xpcs *xpcs,
 	return 0;
 }
 
+static int xpcs_get_state_2500basex(struct dw_xpcs *xpcs,
+				    struct phylink_link_state *state)
+{
+	int sts;
+
+	sts = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_MMD_STS);
+
+	state->link = !!(sts & DW_VR_MII_MMD_STS_LINK_STS);
+	if (!state->link) {
+		state->speed = SPEED_UNKNOWN;
+		state->pause = MLO_PAUSE_NONE;
+		state->duplex = DUPLEX_UNKNOWN;
+		return 0;
+	}
+
+	state->speed = SPEED_2500;
+	state->pause |= MLO_PAUSE_TX | MLO_PAUSE_RX;
+	state->duplex = DUPLEX_FULL;
+
+	return 0;
+}
+
 static void xpcs_get_state(struct phylink_pcs *pcs,
 			   struct phylink_link_state *state)
 {
@@ -1127,6 +1149,13 @@ static void xpcs_get_state(struct phylink_pcs *pcs,
 			       ERR_PTR(ret));
 		}
 		break;
+	case DW_2500BASEX:
+		ret = xpcs_get_state_2500basex(xpcs, state);
+		if (ret) {
+			pr_err("xpcs_get_state_2500basex returned %pe\n",
+			       ERR_PTR(ret));
+		}
+		break;
 	default:
 		return;
 	}
diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
index 39a90417e535..96c36b32ca99 100644
--- a/drivers/net/pcs/pcs-xpcs.h
+++ b/drivers/net/pcs/pcs-xpcs.h
@@ -55,6 +55,8 @@
 /* Clause 37 Defines */
 /* VR MII MMD registers offsets */
 #define DW_VR_MII_MMD_CTRL		0x0000
+#define DW_VR_MII_MMD_STS		0x0001
+#define DW_VR_MII_MMD_STS_LINK_STS	BIT(2)
 #define DW_VR_MII_DIG_CTRL1		0x8000
 #define DW_VR_MII_AN_CTRL		0x8001
 #define DW_VR_MII_AN_INTR_STS		0x8002
-- 
2.34.1


