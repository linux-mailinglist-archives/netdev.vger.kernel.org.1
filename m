Return-Path: <netdev+bounces-96519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE798C64CD
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 12:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFD3C2814FD
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 10:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3E75BAFC;
	Wed, 15 May 2024 10:09:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A955A116
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 10:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715767760; cv=none; b=c3yNlUbSVK18YVIfFX2OES8NYI30Mcvu8vzo96KXJ8W5Ai0+8xuqTq5iqrU8scGEdO2jMCWehAwL3vQZCkqHAyfQV9dtc7FdP7m+LYF7yaZ4UF13ZqjXh8lMAl8xqePbzu8CZM0iSDUubWge5vxEajDoo5yMDHdTAs83w1Vk0jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715767760; c=relaxed/simple;
	bh=UZUQKmuckmWGpJndXj/baW67bVORYeufoLNGK5cTcfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TgzZcRWlDw183W+UAR+qWNeSY6MvLrpb0Tyx2Cz74vz6DBQid+2QfvefQMLIkFZXojXMuloCjGW+tDq1kQ909AXPWT6sQpMxAiiyCvGlx0efWo3Y3BX1TS8wHXBBMNzVCSgbsZo0BbEuWCYUq3ZFflqtgjB4KDQ6cnneppxELd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp80t1715767747t7uolpq9
X-QQ-Originating-IP: WyamMs5k+cdTQuAgZk+mjmCdDDM34XuuFdNXE5t2BZc=
Received: from localhost.localdomain ( [125.120.144.133])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 15 May 2024 18:09:06 +0800 (CST)
X-QQ-SSF: 01400000000000O0Z000000A0000000
X-QQ-FEAT: lp8jUtqYSiDQB4i6obXdp2nxiBOedkW1GzL/Ai9Lutv0pQGGrmnu3ORY6E8Ny
	TWJXEEUjwZxxXHdB+jMpaswWbXz62pMk8Et00YSTC32nX9eqzmNRfaXdOVX7PYxnNOzEbDx
	QVBOv5sgPhwmDoyA57xDFCRXgeymEPbr8txNtClEUaN3ApNMr3Cu4gKasf7jLGny+Bj96BH
	jEfBEsfUpXvX9K31nU+Q9QwNnPJN3szEhQ0sGRxbr41ZaVszcSniwoOhHz6N/Gq6RmQu/gx
	WfAhiVDOntIKHtmemFhdPtP3uurjpTnvr+UWfEr4KOAr53QUVrChHy1A6Ba0VU+IHFS0ADa
	HqgV+07SSkTqpqU0hroHqQNjeaGYcj9TRBhghrD6u2L75by3agmdctd5vJWndBmTFVpb7ed
	gpXl3VtV6woZFkE5RZ0hiRs/BTHPge8A
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 16234684506209606088
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v3 6/6] net: txgbe: add sriov function support
Date: Wed, 15 May 2024 17:50:09 +0800
Message-ID: <C3073177CFE74964+20240515100830.32920-7-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240515100830.32920-1-mengyuanlou@net-swift.com>
References: <20240515100830.32920-1-mengyuanlou@net-swift.com>
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
Add ndo_vf_ops for txgbe netdev ops.
Add mailbox handler wx_msg_task for txgbe.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 47 +++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_sriov.h |  1 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  1 +
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    | 25 ++++++++--
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 24 ++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |  8 ++++
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  4 +-
 7 files changed, 106 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
index be1426c6407f..8f7a39d5cc54 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
@@ -1004,3 +1004,50 @@ void wx_ping_all_vfs_with_link_status(struct wx *wx, bool link_up)
 		wx_write_mbx_pf(wx, msgbuf, 2, i);
 }
 EXPORT_SYMBOL(wx_ping_all_vfs_with_link_status);
+
+/**
+ * wx_set_vf_link_state - Set link state
+ * @wx: Pointer to adapter struct
+ * @vf: VF identifier
+ * @state: required link state
+ *
+ * Set a link force state on/off a single vf
+ **/
+static void wx_set_vf_link_state(struct wx *wx, int vf, int state)
+{
+	wx->vfinfo[vf].link_state = state;
+	switch (state) {
+	case IFLA_VF_LINK_STATE_AUTO:
+		if (netif_running(wx->netdev))
+			wx->vfinfo[vf].link_enable = true;
+		else
+			wx->vfinfo[vf].link_enable = false;
+		break;
+	case IFLA_VF_LINK_STATE_ENABLE:
+		wx->vfinfo[vf].link_enable = true;
+		break;
+	case IFLA_VF_LINK_STATE_DISABLE:
+		wx->vfinfo[vf].link_enable = false;
+		break;
+	}
+	/* restart the VF */
+	wx->vfinfo[vf].clear_to_send = false;
+	wx_ping_vf(wx, vf);
+
+	wx_set_vf_rx_tx(wx, vf);
+}
+
+/**
+ * wx_set_all_vfs - update vfs queues
+ * @wx: Pointer to wx struct
+ *
+ * Update setting transmit and receive queues for all vfs
+ **/
+void wx_set_all_vfs(struct wx *wx)
+{
+	int i;
+
+	for (i = 0 ; i < wx->num_vfs; i++)
+		wx_set_vf_link_state(wx, i, wx->vfinfo[i].link_state);
+}
+EXPORT_SYMBOL(wx_set_all_vfs);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.h b/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
index 7e45b3f71a7b..122d9c561ff5 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
@@ -9,5 +9,6 @@ int wx_pci_sriov_configure(struct pci_dev *pdev, int num_vfs);
 void wx_msg_task(struct wx *wx);
 void wx_disable_vf_rx_tx(struct wx *wx);
 void wx_ping_all_vfs_with_link_status(struct wx *wx, bool link_up);
+void wx_set_all_vfs(struct wx *wx);
 
 #endif /* _WX_SRIOV_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 2f4dc535d720..31c5e0a86a28 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1048,6 +1048,7 @@ struct vf_data_storage {
 	u16 vf_mc_hashes[WX_MAX_VF_MC_ENTRIES];
 	u16 num_vf_mc_hashes;
 	u16 vlan_count;
+	int link_state;
 };
 
 struct vf_macvlans {
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
index bd4624d14ca0..022f3622f92b 100644
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
 
@@ -694,6 +716,7 @@ static void txgbe_remove(struct pci_dev *pdev)
 	struct net_device *netdev;
 
 	netdev = wx->netdev;
+	wx_disable_sriov(wx);
 	unregister_netdev(netdev);
 
 	txgbe_remove_phy(txgbe);
@@ -715,6 +738,7 @@ static struct pci_driver txgbe_driver = {
 	.probe    = txgbe_probe,
 	.remove   = txgbe_remove,
 	.shutdown = txgbe_shutdown,
+	.sriov_configure = wx_pci_sriov_configure,
 };
 
 module_pci_driver(txgbe_driver);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index 5f502265f0a6..76635d4366e4 100644
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


