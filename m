Return-Path: <netdev+bounces-84345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09377896A83
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 11:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DD97B24E2F
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 09:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A1B131E21;
	Wed,  3 Apr 2024 09:28:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EE0134CDC
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712136488; cv=none; b=qslHxrbdfuaWRT8Oy0xmp51vnTFj0GAzHlajAe93VW+0Ot8nkCbm6za7dF+fn9KF0ItrLoVTTY5pItlwkS3XKQTP5RFi/Nr8/jZnSk5VXUd8OE3bmI6owv8D5YZCTL2qYuizIvak52Quni2L/yVmc1fB15k5VCaoNJz0XxNHx6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712136488; c=relaxed/simple;
	bh=/FKzdRndG3GR39QbAZN+2IzzAjuy+MexTqCMauxzGcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1JsjWcOl3njkszlqeW1/dCHygPyazV9JxsaEFg1qRxtktfLr+qOqYUVz9roBNob7xJ5udqPIT5xvSDGfExdLoxHoMVuZQEZx4pU5giaai4LmH8W+/jsaVBcZLJthn5Wqb0rewsvZn83iRvVR7rYwvtUd8w4W8fS70O0ceubWBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtpsz9t1712136479t3cqu59
X-QQ-Originating-IP: GUJ8MnxM+odFWYXXw4nLudiBPd1KIMIFPlG/gLjiFnQ=
Received: from localhost.localdomain ( [36.24.97.137])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 03 Apr 2024 17:27:58 +0800 (CST)
X-QQ-SSF: 01400000000000O0Z000000A0000000
X-QQ-FEAT: 4hWLySrfH+so+2CLD5SRKhyHII6A+yF5BuuCoC1iK6CYjGJepFqAEtncDfF/1
	eTIwumUMAa1B951XSh52Jff12xT9rIuL7Pj9f4oxlRIr/BcVcYRAy4+wBNgY1M9w8+4G4lj
	E/6hnjzjs/RwWCMDO2eeGcKra/OPukJ2NqmYnnK6NK/bWymFMyMvKPNotCeA9Vtd90TgJWh
	VGgtZD/N/eqx4bLzeNlRQ46wiwp0vEJaWop6xwMIkNCfQyt84KczH/BkvuQqJu7mLVXJeUi
	ANapSUmvXef++0EGbiWd1g1ydm93FUNfilCgcJT6JJupvjG7dO2hKsXgjCbuABufOUOCm96
	rLo/xualLmLb/2D4/hkITu2Lfz57/NQMsWk4SDlSIKq/UYzdoS1Jrl9I1PArRagVzymCfnC
	jPyxc4kNBykvvcl1N07Bhg==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 8283467365420937512
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v2 7/7] net: txgbe: add sriov function support
Date: Wed,  3 Apr 2024 17:10:04 +0800
Message-ID: <BDE9D80ABE699DA7+20240403092714.3027-8-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240403092714.3027-1-mengyuanlou@net-swift.com>
References: <20240403092714.3027-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz6a-1

Add sriov_configure for driver ops.
Add ndo_vf_ops for txgbe netdev ops.
Add mailbox handler wx_msg_task for txgbe.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 15 ++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_sriov.h |  1 +
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    | 25 ++++++++++++++--
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 29 +++++++++++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |  8 +++++
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  4 ++-
 6 files changed, 78 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
index e7bb523ced95..6a8976b2e7f0 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
@@ -1227,3 +1227,18 @@ void wx_ping_all_vfs_with_link_status(struct wx *wx, bool link_up)
 		wx_write_mbx_pf(wx, msgbuf, 2, i);
 }
 EXPORT_SYMBOL(wx_ping_all_vfs_with_link_status);
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
index d92f7ceb0bed..50762daab805 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
@@ -14,5 +14,6 @@ int wx_ndo_set_vf_link_state(struct net_device *netdev, int vf, int state);
 void wx_msg_task(struct wx *wx);
 void wx_disable_vf_rx_tx(struct wx *wx);
 void wx_ping_all_vfs_with_link_status(struct wx *wx, bool link_up);
+void wx_set_all_vfs(struct wx *wx);
 
 #endif /* _WX_SRIOV_H_ */
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
index bd4624d14ca0..9d703321bb97 100644
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
 
@@ -433,6 +455,11 @@ static const struct net_device_ops txgbe_netdev_ops = {
 	.ndo_get_stats64        = wx_get_stats64,
 	.ndo_vlan_rx_add_vid    = wx_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid   = wx_vlan_rx_kill_vid,
+	.ndo_set_vf_spoofchk    = wx_ndo_set_vf_spoofchk,
+	.ndo_set_vf_link_state	= wx_ndo_set_vf_link_state,
+	.ndo_get_vf_config      = wx_ndo_get_vf_config,
+	.ndo_set_vf_vlan        = wx_ndo_set_vf_vlan,
+	.ndo_set_vf_mac         = wx_ndo_set_vf_mac,
 };
 
 /**
@@ -694,6 +721,7 @@ static void txgbe_remove(struct pci_dev *pdev)
 	struct net_device *netdev;
 
 	netdev = wx->netdev;
+	wx_disable_sriov(wx);
 	unregister_netdev(netdev);
 
 	txgbe_remove_phy(txgbe);
@@ -715,6 +743,7 @@ static struct pci_driver txgbe_driver = {
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


