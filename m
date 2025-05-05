Return-Path: <netdev+bounces-187673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AECAA8D15
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 09:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096DC1892B2E
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 07:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61BF1DB365;
	Mon,  5 May 2025 07:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PMwr6FOt"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB201AAA1F;
	Mon,  5 May 2025 07:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746430394; cv=none; b=n/qM0mjUcYsWIYPrUTjNC5mJ2YwJWeFJ18pjalUtvZihpsmP3E8b4Usk9wpYw+Nqk+zwI7a8/N61hXr9tsUJFwwSm37KVO0wk5ytuGOphBjD0+LUyJwnDYU6bABmB18CBq/0KoUR+/7Bkt2/gP7GgI6eJrLXBKKZJHgcebmqRQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746430394; c=relaxed/simple;
	bh=AqOHYLAKEMOVfCfoPPUkBYDLm8AEpL2ZvA3H2A6fh7o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cPqqvDGzsAWlHm03hPAKRfd4HnOxT3llLXUCG5f99yI40w7sbGcSv9Z51xxpmHrmD6eW1t44flr0+r28Ryo8x4FQPVJ0V+KfMP1u5tinNo0coIMUHBuC7S7xMJ67yVKUnXC8kW1V8cgU0w72KExUeLvPTf35wcAOgM2fyhkP+gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PMwr6FOt; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1746430393; x=1777966393;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AqOHYLAKEMOVfCfoPPUkBYDLm8AEpL2ZvA3H2A6fh7o=;
  b=PMwr6FOtCo2U6U80S7Yb+R3VqMDSoQroP+2eIEFl0TTp32TGdxIgD9HD
   j71oU/DzCuLwrK/fJ4WmLZwlQ2dUhNW3B0xtGt6QV+q7tI1a37Ag9Go8e
   irx6oZ6c5H0+SexIe05COIz3qI8TOeQ1rsZzqjx3Gl45YrQ1KP0GF5BN7
   Vasvb7awNn0hyDBYIzYt/KpMfQHl9CQYLJA1PqEXcoLXKGciIoI9hJyqk
   HIX6NGD9HF+EA+vI1/X+ECuuO49ZIrWVv7iI1gtRLLP+guKyOVEGxgIki
   IMWQVM0DJdzvDPZajEyZJLJkzLukxo0MK5CtLmFsOrnD3bm6VALA2nSK6
   A==;
X-CSE-ConnectionGUID: we+1GUIsRwCKmoJC4zLVXw==
X-CSE-MsgGUID: 4cOdXlr9QU6G3mdzYA/oQQ==
X-IronPort-AV: E=Sophos;i="6.15,262,1739862000"; 
   d="scan'208";a="41706941"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 May 2025 00:33:06 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 5 May 2025 00:33:01 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 5 May 2025 00:32:58 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <netdev@vger.kernel.org>
CC: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 net-next] net: lan743x: configure interrupt  moderation timers based on speed
Date: Mon, 5 May 2025 12:59:43 +0530
Message-ID: <20250505072943.123943-1-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Configures the interrupt moderation timer value to 64us for 2.5G,
150us for 1G, 330us for 10/100M. Earlier this was 400us for all
speeds. This improvess UDP TX and Bidirectional performance to
2.3Gbps from 1.4Gbps in 2.5G. These values are derived after
experimenting with different values.

Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 61 +++++++++++--------
 drivers/net/ethernet/microchip/lan743x_main.h |  5 +-
 2 files changed, 41 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index e2d6bfb5d693..6d570132f409 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -620,27 +620,6 @@ static int lan743x_intr_open(struct lan743x_adapter *adapter)
 		lan743x_csr_write(adapter, INT_VEC_EN_SET,
 				  INT_VEC_EN_(0));
 
-	if (!(adapter->csr.flags & LAN743X_CSR_FLAG_IS_A0)) {
-		lan743x_csr_write(adapter, INT_MOD_CFG0, LAN743X_INT_MOD);
-		lan743x_csr_write(adapter, INT_MOD_CFG1, LAN743X_INT_MOD);
-		lan743x_csr_write(adapter, INT_MOD_CFG2, LAN743X_INT_MOD);
-		lan743x_csr_write(adapter, INT_MOD_CFG3, LAN743X_INT_MOD);
-		lan743x_csr_write(adapter, INT_MOD_CFG4, LAN743X_INT_MOD);
-		lan743x_csr_write(adapter, INT_MOD_CFG5, LAN743X_INT_MOD);
-		lan743x_csr_write(adapter, INT_MOD_CFG6, LAN743X_INT_MOD);
-		lan743x_csr_write(adapter, INT_MOD_CFG7, LAN743X_INT_MOD);
-		if (adapter->is_pci11x1x) {
-			lan743x_csr_write(adapter, INT_MOD_CFG8, LAN743X_INT_MOD);
-			lan743x_csr_write(adapter, INT_MOD_CFG9, LAN743X_INT_MOD);
-			lan743x_csr_write(adapter, INT_MOD_MAP0, 0x00007654);
-			lan743x_csr_write(adapter, INT_MOD_MAP1, 0x00003210);
-		} else {
-			lan743x_csr_write(adapter, INT_MOD_MAP0, 0x00005432);
-			lan743x_csr_write(adapter, INT_MOD_MAP1, 0x00000001);
-		}
-		lan743x_csr_write(adapter, INT_MOD_MAP2, 0x00FFFFFF);
-	}
-
 	/* enable interrupts */
 	lan743x_csr_write(adapter, INT_EN_SET, INT_BIT_MAS_);
 	ret = lan743x_intr_test_isr(adapter);
@@ -3035,6 +3014,31 @@ static void lan743x_phylink_mac_link_down(struct phylink_config *config,
 	netif_tx_stop_all_queues(netdev);
 }
 
+static void lan743x_config_int_mod(struct lan743x_adapter *adapter, u32 int_mod)
+{
+	if (!(adapter->csr.flags & LAN743X_CSR_FLAG_IS_A0)) {
+		lan743x_csr_write(adapter, INT_MOD_CFG0, int_mod);
+		lan743x_csr_write(adapter, INT_MOD_CFG1, int_mod);
+		lan743x_csr_write(adapter, INT_MOD_CFG2, int_mod);
+		lan743x_csr_write(adapter, INT_MOD_CFG3, int_mod);
+		lan743x_csr_write(adapter, INT_MOD_CFG4, int_mod);
+		lan743x_csr_write(adapter, INT_MOD_CFG5, int_mod);
+		lan743x_csr_write(adapter, INT_MOD_CFG6, int_mod);
+		lan743x_csr_write(adapter, INT_MOD_CFG7, int_mod);
+		if (adapter->is_pci11x1x) {
+			lan743x_csr_write(adapter, INT_MOD_CFG8, int_mod);
+			lan743x_csr_write(adapter, INT_MOD_CFG9, int_mod);
+
+			lan743x_csr_write(adapter, INT_MOD_MAP0, 0x00007654);
+			lan743x_csr_write(adapter, INT_MOD_MAP1, 0x00003210);
+		} else {
+			lan743x_csr_write(adapter, INT_MOD_MAP0, 0x00005432);
+			lan743x_csr_write(adapter, INT_MOD_MAP1, 0x00000001);
+		}
+		lan743x_csr_write(adapter, INT_MOD_MAP2, 0x00FFFFFF);
+	}
+}
+
 static void lan743x_phylink_mac_link_up(struct phylink_config *config,
 					struct phy_device *phydev,
 					unsigned int link_an_mode,
@@ -3044,6 +3048,7 @@ static void lan743x_phylink_mac_link_up(struct phylink_config *config,
 {
 	struct net_device *netdev = to_net_dev(config->dev);
 	struct lan743x_adapter *adapter = netdev_priv(netdev);
+	u32 int_mod;
 	int mac_cr;
 	u8 cap;
 
@@ -3052,15 +3057,23 @@ static void lan743x_phylink_mac_link_up(struct phylink_config *config,
 	 * Resulting value corresponds to SPEED_10
 	 */
 	mac_cr &= ~(MAC_CR_CFG_H_ | MAC_CR_CFG_L_);
-	if (speed == SPEED_2500)
+	if (speed == SPEED_2500) {
 		mac_cr |= MAC_CR_CFG_H_ | MAC_CR_CFG_L_;
-	else if (speed == SPEED_1000)
+		int_mod = LAN743X_INT_MOD_2_5G;
+	} else if (speed == SPEED_1000) {
 		mac_cr |= MAC_CR_CFG_H_;
-	else if (speed == SPEED_100)
+		int_mod = LAN743X_INT_MOD_1G;
+	} else if (speed == SPEED_100) {
 		mac_cr |= MAC_CR_CFG_L_;
+		int_mod = LAN743X_INT_MOD_100M;
+	} else {
+		int_mod = LAN743X_INT_MOD_10M;
+	}
 
 	lan743x_csr_write(adapter, MAC_CR, mac_cr);
 
+	lan743x_config_int_mod(adapter, int_mod);
+
 	lan743x_ptp_update_latency(adapter, speed);
 
 	/* Flow Control operation */
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index db5fc73e41cc..189d979356a0 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -860,7 +860,10 @@ struct lan743x_adapter;
 #define LAN743X_USED_RX_CHANNELS	(4)
 #define LAN743X_USED_TX_CHANNELS	(1)
 #define PCI11X1X_USED_TX_CHANNELS	(4)
-#define LAN743X_INT_MOD	(400)
+#define LAN743X_INT_MOD_2_5G		(64)
+#define LAN743X_INT_MOD_1G		(150)
+#define LAN743X_INT_MOD_100M		(330)
+#define LAN743X_INT_MOD_10M		(330)
 
 #if (LAN743X_USED_RX_CHANNELS > LAN743X_MAX_RX_CHANNELS)
 #error Invalid LAN743X_USED_RX_CHANNELS
-- 
2.25.1


