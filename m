Return-Path: <netdev+bounces-36090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 600EC7AD25E
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 09:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id E631F1F24590
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 07:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4F511187;
	Mon, 25 Sep 2023 07:53:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2304F11C96
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 07:53:17 +0000 (UTC)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7826D3
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 00:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695628395; x=1727164395;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SNvL6BCRK4Mz1B+W+0YovcCop6PU/XDx2MDBI222O/Y=;
  b=RBPeoN930UnkTps3RE2cRLJXm9rrHKaBfvem3gtXf0m1/GxuYWsClNMN
   ZaBxR+nAi54t+dmvM5ZPfkzRR1jIVNA9l2FHy5w+GkJ65tYRyiIUGomBd
   F+Ene83v3izaWfczUWPIkaiHxfllZVv/4ZkSmGev/Nh8+0QLRjfZHZJjX
   2HiSBkhvJ1AQypUou1dVHKWN8+1rd5tSOB7jSGgmSaUijjQpX87epTiaT
   L1fvbznyot0/jdqY32rX+GAhZhNyr+upcMattMLxG7IjmWoT4SFkrd9tj
   nwbIm5kYrMA31EN0pT9e1PpDypbfNFbsi1CiirvjJpQue0YJ2HDeTZl4E
   Q==;
X-CSE-ConnectionGUID: Z8nQQlu0QNmF4uGWZaPn0A==
X-CSE-MsgGUID: ZRaBkCuwTJOsPZGC+7TwDA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="173390641"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2023 00:53:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 25 Sep 2023 00:52:34 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 25 Sep 2023 00:52:31 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <Jose.Abreu@synopsys.com>, <linux@armlinux.org.uk>,
	<hkallweit1@gmail.com>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next] net: pcs: xpcs: Add 2500BASE-X case in get state for XPCS drivers
Date: Mon, 25 Sep 2023 13:21:42 +0530
Message-ID: <20230925075142.266026-1-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add DW_2500BASEX case in xpcs_get_state( ) to update speed, duplex and pause
Update the port mode and autonegotiation

Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
 drivers/net/pcs/pcs-xpcs.c | 31 +++++++++++++++++++++++++++++++
 drivers/net/pcs/pcs-xpcs.h |  4 ++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 4dbc21f604f2..4f89dcedf0fc 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1090,6 +1090,30 @@ static int xpcs_get_state_c37_1000basex(struct dw_xpcs *xpcs,
 	return 0;
 }
 
+static int xpcs_get_state_2500basex(struct dw_xpcs *xpcs,
+				    struct phylink_link_state *state)
+{
+	int sts, lpa;
+
+	sts = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_MMD_STS);
+	lpa = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_MMD_LP_BABL);
+	if (sts < 0 || lpa < 0) {
+		state->link = false;
+		return sts;
+	}
+
+	state->link = !!(sts & DW_VR_MII_MMD_STS_LINK_STS);
+	state->an_complete = !!(sts & DW_VR_MII_MMD_STS_AN_CMPL);
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
@@ -1127,6 +1151,13 @@ static void xpcs_get_state(struct phylink_pcs *pcs,
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
index 39a90417e535..92c838f4b251 100644
--- a/drivers/net/pcs/pcs-xpcs.h
+++ b/drivers/net/pcs/pcs-xpcs.h
@@ -55,6 +55,10 @@
 /* Clause 37 Defines */
 /* VR MII MMD registers offsets */
 #define DW_VR_MII_MMD_CTRL		0x0000
+#define DW_VR_MII_MMD_STS		0x0001
+#define DW_VR_MII_MMD_STS_LINK_STS	BIT(2)
+#define DW_VR_MII_MMD_STS_AN_CMPL	BIT(5)
+#define DW_VR_MII_MMD_LP_BABL		0x0005
 #define DW_VR_MII_DIG_CTRL1		0x8000
 #define DW_VR_MII_AN_CTRL		0x8001
 #define DW_VR_MII_AN_INTR_STS		0x8002
-- 
2.34.1


