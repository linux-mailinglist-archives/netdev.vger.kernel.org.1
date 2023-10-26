Return-Path: <netdev+bounces-44456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD35C7D807F
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 12:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28416B2127D
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 10:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4692D040;
	Thu, 26 Oct 2023 10:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jSQlX4Pa"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7F410E3
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 10:18:21 +0000 (UTC)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F96183;
	Thu, 26 Oct 2023 03:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698315500; x=1729851500;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tiJ94SMzePm8CGLJQBB+8e5vPbI81y2Nzad4KmqiHC8=;
  b=jSQlX4Pas5qiXz/UFXotqzGb+0Utk6S3HIDQN3d7uKf8p9sH5+l8llS4
   C0NyfUAFq7XP7Zlk4sWlvbR3soCw2oZDV/lFnyWldtMnAnvJo7uB+0Hbf
   fBPUg6STxGGSH/K8vOKckg1tITADWHBJKn07N2WiuMej461HC0sZ+pJp6
   EBnqpaNXATFj9MUF0iglPQlK+uv2LPPp2vngyt3IPV4P6v5ixUa88A7PJ
   VTly7En72O7mU7IKcennNdpPVVgqLb85B51l32XTmh3JrrR4NAC3Ts8+t
   8KG/rr629IcVCKzfUG7GWLQRR4vpom5UWRnzYgrPVOu0HrRjESaG3HGLS
   w==;
X-CSE-ConnectionGUID: qDRF6jxKTUqq7Gfds2wdJQ==
X-CSE-MsgGUID: fqVwy8rsRWKUZd5aGAleNQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="10631784"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Oct 2023 03:18:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 26 Oct 2023 03:17:54 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 26 Oct 2023 03:17:51 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<andrew@lunn.ch>, <Jose.Abreu@synopsys.com>, <linux@armlinux.org.uk>,
	<fancer.lancer@gmail.com>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next V2] net: pcs: xpcs: Add 2500BASE-X case in get state for XPCS drivers
Date: Thu, 26 Oct 2023 15:46:42 +0530
Message-ID: <20231026101642.3913-1-Raju.Lakkaraju@microchip.com>
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
V1 -> V2:
  - Remove the default initialization of speed, pause and duplex

V0 -> V1:                                                                       
  - Remove the auto-negotiation check due to currently the DW_2500BASEX mode    
    doesn't imply any auto-negotiation 

 drivers/net/pcs/pcs-xpcs.c | 25 +++++++++++++++++++++++++
 drivers/net/pcs/pcs-xpcs.h |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 4dbc21f604f2..392aaad2d412 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1090,6 +1090,24 @@ static int xpcs_get_state_c37_1000basex(struct dw_xpcs *xpcs,
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
+	if (!state->link)
+		return 0;
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
@@ -1127,6 +1145,13 @@ static void xpcs_get_state(struct phylink_pcs *pcs,
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


