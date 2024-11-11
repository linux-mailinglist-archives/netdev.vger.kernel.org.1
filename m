Return-Path: <netdev+bounces-143635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3361F9C36BB
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 03:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC0752822EA
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 02:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025F2145A07;
	Mon, 11 Nov 2024 02:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="WVIjjnYs"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274AF1448C7;
	Mon, 11 Nov 2024 02:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731293784; cv=none; b=ritaRBmPPgZ9vB6XZIUmhCOrmYrdi2mgzMf2O7BKlTyDxuuqSrsKFqd94psJ3hv5PlR/kTCzmHUlTGso9wWivWMihjyIcnJaexbEZVcyHTus4iMgnOH3MksoNn3+SwbUC/c4OS9Lwos0N3HAgiFm2ySAIkAjWNk80ICEAZsmD8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731293784; c=relaxed/simple;
	bh=6igfrVFofF6rOpqSFbTUsRguKoT1vFakecNmezLPA18=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=skwmjmk9Xt9fABXte41gPVOdaUHS8nRUTE0YipiIFBvUr+nNvd4GamQmqpXd+98KY6rDvsGpXNbsI2uIhrVDh47LSe5eqBEqTa1VizDgl+dGAK3muXvRjJSQxfFmvAp9YulqNZpR0+CokOxvdTez9x56x1uTuABuPoJ1K0YOZ8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=WVIjjnYs; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AB2u5EK11487655, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731293765; bh=6igfrVFofF6rOpqSFbTUsRguKoT1vFakecNmezLPA18=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=WVIjjnYsknA/s+MGpp83O8m/dvD9E14YtJ1QKiWNFXEkESo9OvWAqpEhA2xb2FWWC
	 wuPrIC9ANgEm8lRyNnBBShc8onKK93tIDgg3PzsSZ0/YNgKn2mWIqAOOoBeqJFd4m9
	 GFGVA5zpr9bxuXr8lSHlVGcuA79eoLvQHj4TEx3jOM2hJxqT3MHROhvJnq7Dg05Oyx
	 PgvjpLv4OcIizxOI1OGTllJB4vbjdi8aGBabc4V7f2ga5UlYsVi1fDdiotk4wMsUiy
	 WmC4qVyyDFQ0uLC/gQ5dAXwkYBr9WP36Zy45BHGY9C+wCzS2afmpIpi9FD0TuaPWzd
	 w18w7tpYGbGog==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AB2u5EK11487655
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 10:56:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 11 Nov 2024 10:56:05 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 11 Nov
 2024 10:56:04 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net-next 1/2] rtase: Add support for RTL907XD-VA PCIe port
Date: Mon, 11 Nov 2024 10:55:31 +0800
Message-ID: <20241111025532.291735-2-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241111025532.291735-1-justinlai0215@realtek.com>
References: <20241111025532.291735-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Add RTL907XD-VA hardware version and modify the speed reported by
.get_link_ksettings in ethtool_ops.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 drivers/net/ethernet/realtek/rtase/rtase.h    | 10 +++++--
 .../net/ethernet/realtek/rtase/rtase_main.c   | 26 ++++++++++++++-----
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase.h b/drivers/net/ethernet/realtek/rtase/rtase.h
index 583c33930f88..2bbfcad613ab 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase.h
+++ b/drivers/net/ethernet/realtek/rtase/rtase.h
@@ -9,7 +9,11 @@
 #ifndef RTASE_H
 #define RTASE_H
 
-#define RTASE_HW_VER_MASK 0x7C800000
+#define RTASE_HW_VER_MASK     0x7C800000
+#define RTASE_HW_VER_906X_7XA 0x00800000
+#define RTASE_HW_VER_906X_7XC 0x04000000
+#define RTASE_HW_VER_907XD_V1 0x04800000
+#define RTASE_HW_VER_907XD_VA 0x08000000
 
 #define RTASE_RX_DMA_BURST_256       4
 #define RTASE_TX_DMA_BURST_UNLIMITED 7
@@ -170,7 +174,7 @@ enum rtase_registers {
 	RTASE_INT_MITI_TX = 0x0A00,
 	RTASE_INT_MITI_RX = 0x0A80,
 
-	RTASE_VLAN_ENTRY_0     = 0xAC80,
+	RTASE_VLAN_ENTRY_0 = 0xAC80,
 };
 
 enum rtase_desc_status_bit {
@@ -327,6 +331,8 @@ struct rtase_private {
 	u16 int_nums;
 	u16 tx_int_mit;
 	u16 rx_int_mit;
+
+	u32 hw_ver;
 };
 
 #define RTASE_LSO_64K 64000
diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index f8777b7663d3..73ebdf0bc376 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -1714,10 +1714,22 @@ static int rtase_get_settings(struct net_device *dev,
 			      struct ethtool_link_ksettings *cmd)
 {
 	u32 supported = SUPPORTED_MII | SUPPORTED_Pause | SUPPORTED_Asym_Pause;
+	const struct rtase_private *tp = netdev_priv(dev);
 
 	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
 						supported);
-	cmd->base.speed = SPEED_5000;
+
+	switch (tp->hw_ver) {
+	case RTASE_HW_VER_906X_7XA:
+	case RTASE_HW_VER_906X_7XC:
+		cmd->base.speed = SPEED_5000;
+		break;
+	case RTASE_HW_VER_907XD_V1:
+	case RTASE_HW_VER_907XD_VA:
+		cmd->base.speed = SPEED_10000;
+		break;
+	}
+
 	cmd->base.duplex = DUPLEX_FULL;
 	cmd->base.port = PORT_MII;
 	cmd->base.autoneg = AUTONEG_DISABLE;
@@ -1974,13 +1986,15 @@ static void rtase_init_software_variable(struct pci_dev *pdev,
 
 static bool rtase_check_mac_version_valid(struct rtase_private *tp)
 {
-	u32 hw_ver = rtase_r32(tp, RTASE_TX_CONFIG_0) & RTASE_HW_VER_MASK;
 	bool known_ver = false;
 
-	switch (hw_ver) {
-	case 0x00800000:
-	case 0x04000000:
-	case 0x04800000:
+	tp->hw_ver = rtase_r32(tp, RTASE_TX_CONFIG_0) & RTASE_HW_VER_MASK;
+
+	switch (tp->hw_ver) {
+	case RTASE_HW_VER_906X_7XA:
+	case RTASE_HW_VER_906X_7XC:
+	case RTASE_HW_VER_907XD_V1:
+	case RTASE_HW_VER_907XD_VA:
 		known_ver = true;
 		break;
 	}
-- 
2.34.1


