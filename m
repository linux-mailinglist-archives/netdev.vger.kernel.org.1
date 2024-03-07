Return-Path: <netdev+bounces-78343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E8C874BC0
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 11:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A811281E15
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 10:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5738562D;
	Thu,  7 Mar 2024 09:58:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg156.qq.com (smtpbg156.qq.com [15.184.82.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9341A85288
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 09:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.82.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805517; cv=none; b=Qu1srt/06R8AwUyBHbln4cVVRbBiCCedU66OzxrhJ3bi8nZPQiTSOowfFc1I+GXAhRa6c3UyQ1qWNKyCZlfIax9gWWOIDpAoPUUK7qOGnlOrdsfJ1qc5ZX9CRuu8LpS+vUCfDBYHziaaddFigDV9diGWS71Lbns/beiq5qxyR6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805517; c=relaxed/simple;
	bh=K8zz6tgOXM6F0foJkrRPPkbfUsLEGErbxYhcsLqbM6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HV2ux/+L1T+NuGVyQ15x4jLlKjEXnwPacJXmb6CtK1XGnbHaW3Yfhtakq3hQabYCk85jvOTlU3YB7h0q3BvvfXlktHv7G3Z64qt1R5hzSsa+hVKFGR3VA1bkOUkzrPp7QkT8exK3mayaFQGdVrnXGkbhHp/VNDwfKoKFY3gr+/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=15.184.82.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp87t1709805506tsb7322a
X-QQ-Originating-IP: V/IfdNHBYct3MOdpt1pkbzsuEfU0WGbLT5STb+Oz+Uo=
Received: from localhost.localdomain ( [220.184.149.201])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 07 Mar 2024 17:58:24 +0800 (CST)
X-QQ-SSF: 01400000000000O0Z000000A0000000
X-QQ-FEAT: tSQw27OYC22I5oirikSoNk6cB9/hcOctBn5aukkst59XGgvWReTbSvQ0JFBCi
	wPElsQmm/WXj3437pn5t+2DuhwWcR19h8+6Vm+T1UKr6tZ1UteRtMUF0it5/LUOGoxKmBP9
	F5TN+o3/DU/FuNlzZ9Dyy+hrpZEyTauPMSu9LP8RQq6+dYZsKZqBNeTGi8MUGW9p9aY8Y87
	wyQvV/SQtibkjTBMvwaKJMXZrG27k25Z416IVj4iYhkwcaejdYa6rA0Rx9xd9Haf2dmRT6k
	qR24XiVPmO7CoW2DbRcFrJohc7ZEL+fSPGFxxS02CgDjs/UexuQyJH2gWXghSMO2FU85K1c
	e0rvApBduh7cp16W3/Wpj4t14itNe1BwwapUOxso2BxyQCdGAq/wn5DwBuBpEA+leg/7dPJ
	eNCzuzcl01usg9Rtfhyn1JqfnZ2uV2nH
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 1328032972463655884
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next 5/5] net: txgbe: add sriov ops support
Date: Thu,  7 Mar 2024 17:55:00 +0800
Message-ID: <9EE1617D3660870B+20240307095755.7130-6-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240307095755.7130-1-mengyuanlou@net-swift.com>
References: <20240307095755.7130-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrgz:qybglogicsvrgz6a-1

Add sriov_configure for driver ops.
Add ndo_set_vf_spoofchk and ndo_set_vf_link_state for
txgbe netdev ops.
Add mailbox handler wx_msg_task for txgbe.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    | 25 +++++++++++++++---
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 26 +++++++++++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |  8 ++++++
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  4 ++-
 4 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
index b3e3605d1edb..e6be98865c2d 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
@@ -7,6 +7,7 @@
 #include "../libwx/wx_type.h"
 #include "../libwx/wx_lib.h"
 #include "../libwx/wx_hw.h"
+#include "../libwx/wx_sriov.h"
 #include "txgbe_type.h"
 #include "txgbe_phy.h"
 #include "txgbe_irq.h"
@@ -176,6 +177,24 @@ static const struct irq_domain_ops txgbe_misc_irq_domain_ops = {
 	.map = txgbe_misc_irq_domain_map,
 };
 
+static irqreturn_t txgbe_irq_handler(int irq, void *data)
+{
+	struct txgbe *txgbe = data;
+	struct wx *wx = txgbe->wx;
+	u32 eicr;
+
+	eicr = wx_misc_isb(wx, WX_ISB_MISC) & TXGBE_PX_MISC_IEN_MASK;
+	if (!eicr)
+		return IRQ_NONE;
+	txgbe->eicr = eicr;
+	if (eicr & TXGBE_PX_MISC_IC_VF_MBOX) {
+		wx_msg_task(txgbe->wx);
+		wx_intr_enable(wx, TXGBE_INTR_MISC);
+	}
+
+	return IRQ_WAKE_THREAD;
+}
+
 static irqreturn_t txgbe_misc_irq_handle(int irq, void *data)
 {
 	struct txgbe *txgbe = data;
@@ -184,7 +203,7 @@ static irqreturn_t txgbe_misc_irq_handle(int irq, void *data)
 	unsigned int sub_irq;
 	u32 eicr;
 
-	eicr = wx_misc_isb(wx, WX_ISB_MISC);
+	eicr = txgbe->eicr;
 	if (eicr & TXGBE_PX_MISC_GPIO) {
 		sub_irq = irq_find_mapping(txgbe->misc.domain, TXGBE_IRQ_GPIO);
 		handle_nested_irq(sub_irq);
@@ -226,7 +245,7 @@ int txgbe_setup_misc_irq(struct txgbe *txgbe)
 	struct wx *wx = txgbe->wx;
 	int hwirq, err;
 
-	txgbe->misc.nirqs = 2;
+	txgbe->misc.nirqs = TXGBE_IRQ_MAX;
 	txgbe->misc.domain = irq_domain_add_simple(NULL, txgbe->misc.nirqs, 0,
 						   &txgbe_misc_irq_domain_ops, txgbe);
 	if (!txgbe->misc.domain)
@@ -241,7 +260,7 @@ int txgbe_setup_misc_irq(struct txgbe *txgbe)
 	else
 		txgbe->misc.irq = wx->pdev->irq;
 
-	err = request_threaded_irq(txgbe->misc.irq, NULL,
+	err = request_threaded_irq(txgbe->misc.irq, txgbe_irq_handler,
 				   txgbe_misc_irq_handle,
 				   IRQF_ONESHOT,
 				   wx->netdev->name, txgbe);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index bd4624d14ca0..fffbb92acdb2 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -14,6 +14,8 @@
 #include "../libwx/wx_type.h"
 #include "../libwx/wx_lib.h"
 #include "../libwx/wx_hw.h"
+#include "../libwx/wx_mbx.h"
+#include "../libwx/wx_sriov.h"
 #include "txgbe_type.h"
 #include "txgbe_hw.h"
 #include "txgbe_phy.h"
@@ -99,6 +101,12 @@ static void txgbe_up_complete(struct wx *wx)
 
 	/* enable transmits */
 	netif_tx_start_all_queues(netdev);
+
+	/* Set PF Reset Done bit so PF/VF Mail Ops can work */
+	wr32m(wx, WX_CFG_PORT_CTL, WX_CFG_PORT_CTL_PFRSTD,
+	      WX_CFG_PORT_CTL_PFRSTD);
+	/* update setting rx tx for all active vfs */
+	wx_set_all_vfs(wx);
 }
 
 static void txgbe_reset(struct wx *wx)
@@ -144,6 +152,16 @@ static void txgbe_disable_device(struct wx *wx)
 		wx_err(wx, "%s: invalid bus lan id %d\n",
 		       __func__, wx->bus.func);
 
+	if (wx->num_vfs) {
+		/* Clear EITR Select mapping */
+		wr32(wx, WX_PX_ITRSEL, 0);
+		/* Mark all the VFs as inactive */
+		for (i = 0 ; i < wx->num_vfs; i++)
+			wx->vfinfo[i].clear_to_send = 0;
+		/* update setting rx tx for all active vfs */
+		wx_set_all_vfs(wx);
+	}
+
 	if (!(((wx->subsystem_device_id & WX_NCSI_MASK) == WX_NCSI_SUP) ||
 	      ((wx->subsystem_device_id & WX_WOL_MASK) == WX_WOL_SUP))) {
 		/* disable mac transmiter */
@@ -269,6 +287,10 @@ static int txgbe_sw_init(struct wx *wx)
 	wx->tx_work_limit = TXGBE_DEFAULT_TX_WORK;
 	wx->rx_work_limit = TXGBE_DEFAULT_RX_WORK;
 
+	wx->mbx.size = WX_VXMAILBOX_SIZE;
+	wx->setup_tc = txgbe_setup_tc;
+	set_bit(0, &wx->fwd_bitmask);
+
 	return 0;
 }
 
@@ -433,6 +455,8 @@ static const struct net_device_ops txgbe_netdev_ops = {
 	.ndo_get_stats64        = wx_get_stats64,
 	.ndo_vlan_rx_add_vid    = wx_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid   = wx_vlan_rx_kill_vid,
+	.ndo_set_vf_spoofchk    = wx_ndo_set_vf_spoofchk,
+	.ndo_set_vf_link_state	= wx_ndo_set_vf_link_state,
 };
 
 /**
@@ -694,6 +718,7 @@ static void txgbe_remove(struct pci_dev *pdev)
 	struct net_device *netdev;
 
 	netdev = wx->netdev;
+	wx_disable_sriov(wx);
 	unregister_netdev(netdev);
 
 	txgbe_remove_phy(txgbe);
@@ -715,6 +740,7 @@ static struct pci_driver txgbe_driver = {
 	.probe    = txgbe_probe,
 	.remove   = txgbe_remove,
 	.shutdown = txgbe_shutdown,
+	.sriov_configure = wx_pci_sriov_configure,
 };
 
 module_pci_driver(txgbe_driver);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index 93295916b1d2..22402a6d2f50 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -16,6 +16,7 @@
 #include "../libwx/wx_type.h"
 #include "../libwx/wx_lib.h"
 #include "../libwx/wx_hw.h"
+#include "../libwx/wx_sriov.h"
 #include "txgbe_type.h"
 #include "txgbe_phy.h"
 #include "txgbe_hw.h"
@@ -179,6 +180,9 @@ static void txgbe_mac_link_down(struct phylink_config *config,
 	struct wx *wx = phylink_to_wx(config);
 
 	wr32m(wx, WX_MAC_TX_CFG, WX_MAC_TX_CFG_TE, 0);
+	wx->speed = 0;
+	/* ping all the active vfs to let them know we are going down */
+	wx_ping_all_vfs_with_link_status(wx, false);
 }
 
 static void txgbe_mac_link_up(struct phylink_config *config,
@@ -215,6 +219,10 @@ static void txgbe_mac_link_up(struct phylink_config *config,
 	wr32(wx, WX_MAC_PKT_FLT, WX_MAC_PKT_FLT_PR);
 	wdg = rd32(wx, WX_MAC_WDG_TIMEOUT);
 	wr32(wx, WX_MAC_WDG_TIMEOUT, wdg);
+
+	wx->speed = speed;
+	/* ping all the active vfs to let them know we are going up */
+	wx_ping_all_vfs_with_link_status(wx, true);
 }
 
 static int txgbe_mac_prepare(struct phylink_config *config, unsigned int mode,
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 1b4ff50d5857..28717788c348 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -71,12 +71,13 @@
 #define TXGBE_PX_MISC_ETH_LK                    BIT(18)
 #define TXGBE_PX_MISC_ETH_AN                    BIT(19)
 #define TXGBE_PX_MISC_INT_ERR                   BIT(20)
+#define TXGBE_PX_MISC_IC_VF_MBOX                BIT(23)
 #define TXGBE_PX_MISC_GPIO                      BIT(26)
 #define TXGBE_PX_MISC_IEN_MASK                            \
 	(TXGBE_PX_MISC_ETH_LKDN | TXGBE_PX_MISC_DEV_RST | \
 	 TXGBE_PX_MISC_ETH_EVENT | TXGBE_PX_MISC_ETH_LK | \
 	 TXGBE_PX_MISC_ETH_AN | TXGBE_PX_MISC_INT_ERR |   \
-	 TXGBE_PX_MISC_GPIO)
+	 TXGBE_PX_MISC_IC_VF_MBOX | TXGBE_PX_MISC_GPIO)
 
 /* Port cfg registers */
 #define TXGBE_CFG_PORT_ST                       0x14404
@@ -195,6 +196,7 @@ struct txgbe {
 	struct gpio_chip *gpio;
 	unsigned int gpio_irq;
 	unsigned int link_irq;
+	u32 eicr;
 };
 
 #endif /* _TXGBE_TYPE_H_ */
-- 
2.43.2


