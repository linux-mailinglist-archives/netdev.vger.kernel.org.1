Return-Path: <netdev+bounces-217140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C652B378C5
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 05:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F844171AE1
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 03:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6DE2405E3;
	Wed, 27 Aug 2025 03:45:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7791C5D4B;
	Wed, 27 Aug 2025 03:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756266357; cv=none; b=Az3ENeVJ1SzeSFc+n2QFnU+yn0pXuiWBlWahZS8AbU1kupBVd2CMXXfcLo9+/tNHMlozsNbO6p9kA9N775GLr5g1Oi2QybqOkiXD3zwoC9l45DuM5leHoLGGGv90YIZ8axNohSjxN7Mupb+w1xL4IAORlVm9nLDPT7RPwYQrkGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756266357; c=relaxed/simple;
	bh=8fhzb4bIwKK2zU9G7I2MfQuhrIhOffMr+A41T+liPz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kpB4rlyQur4wv/zP5zB/93mL7KCyOTASU0Rit3Rdm8N4SHV57EtPV7J4/m8n+NzpaEf89CR2CERosEs8eZrvveWKwY6lLJDiSJ/bHwxUeN3l29e2JS/RD8Gn4+pa/rpjmGmh3Gd8y6h0gU3HUwK3pwhgyTcb+o9mPLzxONTDWtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz7t1756266340tff468fac
X-QQ-Originating-IP: QhwbKt2J6tkytR1ITvku5qIGf6s87fl/PQkkvsYSJf0=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 27 Aug 2025 11:45:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8056536568935068755
EX-QQ-RecipientCnt: 26
From: Dong Yibo <dong100@mucse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	gur.stavi@huawei.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	danishanwar@ti.com,
	lee@trager.us,
	gongfan1@huawei.com,
	lorenzo@kernel.org,
	geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com,
	lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com,
	richardcochran@gmail.com,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH net-next v8 5/5] net: rnpgbe: Add register_netdev
Date: Wed, 27 Aug 2025 11:45:09 +0800
Message-Id: <20250827034509.501980-6-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250827034509.501980-1-dong100@mucse.com>
References: <20250827034509.501980-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MoO5eirna1idcPkeHkF/FxDbl4U8rMeB9+lSYFZnDJyBilWYx6i0RL0U
	Pc6+aSv8SRxMsWFRu9vjdAjNg4tp4404pPiTsCiFIh9rrs3x7YdnM3Wb39CtN/Wn5Sdrkie
	4HGKwUc8V0isWxwBhc9EB0GvKiO5Bin5p4uUQS9ytGlk4B5dyPfKc6klQIlvWzHTb1c/mG6
	P/P1wyE1J+q7Nl1w+tu4AK0f5MfNNPbvwXVuhUgbvGcfhbYo6CHqn4f0e28H1wKx6kSN3K/
	OiKXtszC37NOK8RRYw1Ye6AcEmRLbIArIickhdyyLVJPtnqztx+/Ug2XFpdlYI7egLs3F26
	4z+D3c30/6txyvfXd9jswkIa9VeLaIibKyx9aY43bheHPJRGv5strdiKwx+xsF/dj8S66Pl
	GPrNO6nTGcrtHlKdX/8ZgP4wBHzuC0ASW6RXQjugyTz2sPNBhB7sXV5uy54OTrY/Zdd/VKB
	I0FE38qpOOiei2gz+PqUit0RuP/iJvhir4Iy4Dt4iO2QFMD57bFShFWSRQYv5D4l374xRCO
	AWnn2GhUGkCOv9DSVcjzHZbfhwxikEht+pMJWpryINhcABUBqkm5AuFwjk7T6BNkFJtcslT
	PPduJ9eRVvEoxmfp7BBW2gu3nWusm2C65/myLCfQjYJ8xrgvymPaNF17iId8E3bSP6dPtqa
	I/jzNXMkOWrbjx6d/2b78/I6YymIfbCDH09+CdjovrFL63G6wsyQX0lrRGFHRT2A3oNb0GZ
	XHDI8oLmODwmUoSUzVcyCuGB6Ol7Kw8rRpAYsQVJ11ypDAfzoQg3jQwSvNIgTyDaYCCirpq
	zy7UhNaO5TMjRssr7v54ceXaLLwH4MCOCkQlSp9SjAnem3N4aWW44paRZoutTcraOqP4W4d
	rI9Xbp28CzrKBZWXSrdGIOfS/ibRBQgWBJ419VKm1DHHuTqFlcL1IYevAfo8e6h7MyyGros
	QqdkzZnmCyARl9Txdsn17U7HGvHMb/FSBoLQK0YTxP9uDVL5qdovF0ovp7xWHGIpSHo6PPr
	sWrDFHNR6hoaOVY+bPRoBFnEm3AlZvDiAJQLtEUorZkUc2GIONHxKkUujLVAzgSQYoIdZUD
	RW/bbL5uHuJefy09KjKDwmW66hYOUDO1w==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

Initialize get mac from hw, register the netdev.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    | 23 ++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 82 +++++++++++++++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  2 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 75 +++++++++++++++++
 4 files changed, 182 insertions(+)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 4d2cca59fb23..33ee6f05e9b8 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -6,6 +6,7 @@
 
 #include <linux/types.h>
 #include <linux/mutex.h>
+#include <linux/netdevice.h>
 
 extern const struct rnpgbe_info rnpgbe_n500_info;
 extern const struct rnpgbe_info rnpgbe_n210_info;
@@ -24,6 +25,10 @@ enum rnpgbe_hw_type {
 	rnpgbe_hw_unknown
 };
 
+struct mucse_dma_info {
+	void __iomem *dma_base_addr;
+};
+
 struct mucse_mbx_stats {
 	u32 msgs_tx;
 	u32 msgs_rx;
@@ -47,12 +52,27 @@ struct mucse_mbx_info {
 	u32 fw2pf_mbox_vec;
 };
 
+struct mucse_hw;
+
+struct mucse_hw_operations {
+	int (*reset_hw)(struct mucse_hw *hw);
+	void (*driver_status)(struct mucse_hw *hw, bool enable, int mode);
+};
+
+enum {
+	mucse_driver_insmod,
+};
+
 struct mucse_hw {
 	void __iomem *hw_addr;
 	struct pci_dev *pdev;
 	enum rnpgbe_hw_type hw_type;
 	u8 pfvfnum;
+	const struct mucse_hw_operations *ops;
+	struct mucse_dma_info dma;
 	struct mucse_mbx_info mbx;
+	int port;
+	u8 perm_addr[ETH_ALEN];
 };
 
 struct mucse {
@@ -72,4 +92,7 @@ struct rnpgbe_info {
 #define PCI_DEVICE_ID_N500_DUAL_PORT 0x8318
 #define PCI_DEVICE_ID_N210 0x8208
 #define PCI_DEVICE_ID_N210L 0x820a
+
+#define rnpgbe_dma_wr32(dma, reg, val) \
+	writel((val), (dma)->dma_base_addr + (reg))
 #endif /* _RNPGBE_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
index f38daef752a3..40c29411fe09 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -1,11 +1,87 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2020 - 2025 Mucse Corporation. */
 
+#include <linux/pci.h>
 #include <linux/string.h>
+#include <linux/etherdevice.h>
 
 #include "rnpgbe.h"
 #include "rnpgbe_hw.h"
 #include "rnpgbe_mbx.h"
+#include "rnpgbe_mbx_fw.h"
+
+/**
+ * rnpgbe_get_permanent_mac - Get permanent mac
+ * @hw: hw information structure
+ * @mac_addr: pointer to store mac
+ *
+ * rnpgbe_get_permanent_mac tries to get mac from hw.
+ * It use eth_random_addr if failed.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int rnpgbe_get_permanent_mac(struct mucse_hw *hw,
+				    u8 *mac_addr)
+{
+	struct device *dev = &hw->pdev->dev;
+	int err;
+
+	err = mucse_fw_get_macaddr(hw, hw->pfvfnum, mac_addr, hw->port);
+	if (err) {
+		dev_err(dev, "Failed to get MAC from FW %d\n", err);
+		return err;
+	}
+
+	if (!is_valid_ether_addr(mac_addr)) {
+		dev_err(dev, "Failed to get valid MAC from FW\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * rnpgbe_reset_hw_ops - Do a hardware reset
+ * @hw: hw information structure
+ *
+ * rnpgbe_reset_hw_ops calls fw to do a hardware
+ * reset, and cleans some regs to default.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int rnpgbe_reset_hw_ops(struct mucse_hw *hw)
+{
+	struct mucse_dma_info *dma = &hw->dma;
+	int err;
+
+	rnpgbe_dma_wr32(dma, RNPGBE_DMA_AXI_EN, 0);
+	err = mucse_mbx_fw_reset_phy(hw);
+	if (err)
+		return err;
+	return rnpgbe_get_permanent_mac(hw, hw->perm_addr);
+}
+
+/**
+ * rnpgbe_driver_status_hw_ops - Echo driver status to hw
+ * @hw: hw information structure
+ * @enable: true or false status
+ * @mode: status mode
+ **/
+static void rnpgbe_driver_status_hw_ops(struct mucse_hw *hw,
+					bool enable,
+					int mode)
+{
+	switch (mode) {
+	case mucse_driver_insmod:
+		mucse_mbx_ifinsmod(hw, enable);
+		break;
+	}
+}
+
+static const struct mucse_hw_operations rnpgbe_hw_ops = {
+	.reset_hw = &rnpgbe_reset_hw_ops,
+	.driver_status = &rnpgbe_driver_status_hw_ops,
+};
 
 /**
  * rnpgbe_init_common - Setup common attribute
@@ -13,10 +89,16 @@
  **/
 static void rnpgbe_init_common(struct mucse_hw *hw)
 {
+	struct mucse_dma_info *dma = &hw->dma;
 	struct mucse_mbx_info *mbx = &hw->mbx;
 
+	dma->dma_base_addr = hw->hw_addr;
+
 	mbx->pf2fw_mbox_ctrl = GBE_PF2FW_MBX_MASK_OFFSET;
 	mbx->fw_pf_mbox_mask = GBE_FWPF_MBX_MASK;
+
+	hw->ops = &rnpgbe_hw_ops;
+	hw->port = 0;
 }
 
 /**
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
index 746dca78f1df..0ab2c328c9e9 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -11,6 +11,8 @@
 #define GBE_FWPF_MBX_MASK 0x5700
 #define N210_FW2PF_MBX_VEC_OFFSET 0x29400
 #define N210_FWPF_SHM_BASE_OFFSET 0x2d900
+/**************** DMA Registers ****************************/
+#define RNPGBE_DMA_AXI_EN 0x0010
 /**************** CHIP Resource ****************************/
 #define RNPGBE_MAX_QUEUES 8
 #endif /* _RNPGBE_HW_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index dacb097424c9..e94b0562f3d7 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -9,6 +9,8 @@
 
 #include "rnpgbe.h"
 #include "rnpgbe_hw.h"
+#include "rnpgbe_mbx.h"
+#include "rnpgbe_mbx_fw.h"
 
 static const char rnpgbe_driver_name[] = "rnpgbe";
 static const struct rnpgbe_info *rnpgbe_info_tbl[] = {
@@ -35,6 +37,55 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
 	{0, },
 };
 
+/**
+ * rnpgbe_open - Called when a network interface is made active
+ * @netdev: network interface device structure
+ *
+ * The open entry point is called when a network interface is made
+ * active by the system (IFF_UP).
+ *
+ * @return: 0 on success, negative value on failure
+ **/
+static int rnpgbe_open(struct net_device *netdev)
+{
+	return 0;
+}
+
+/**
+ * rnpgbe_close - Disables a network interface
+ * @netdev: network interface device structure
+ *
+ * The close entry point is called when an interface is de-activated
+ * by the OS.
+ *
+ * @return: 0, this is not allowed to fail
+ **/
+static int rnpgbe_close(struct net_device *netdev)
+{
+	return 0;
+}
+
+/**
+ * rnpgbe_xmit_frame - Send a skb to driver
+ * @skb: skb structure to be sent
+ * @netdev: network interface device structure
+ *
+ * @return: NETDEV_TX_OK or NETDEV_TX_BUSY
+ **/
+static netdev_tx_t rnpgbe_xmit_frame(struct sk_buff *skb,
+				     struct net_device *netdev)
+{
+	dev_kfree_skb_any(skb);
+	netdev->stats.tx_dropped++;
+	return NETDEV_TX_OK;
+}
+
+static const struct net_device_ops rnpgbe_netdev_ops = {
+	.ndo_open = rnpgbe_open,
+	.ndo_stop = rnpgbe_close,
+	.ndo_start_xmit = rnpgbe_xmit_frame,
+};
+
 /**
  * rnpgbe_add_adapter - Add netdev for this pci_dev
  * @pdev: PCI device information structure
@@ -78,6 +129,27 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 
 	hw->hw_addr = hw_addr;
 	info->init(hw);
+	mucse_init_mbx_params_pf(hw);
+	/* echo fw driver insmod to control hw */
+	hw->ops->driver_status(hw, true, mucse_driver_insmod);
+	err = mucse_mbx_get_capability(hw);
+	if (err) {
+		dev_err(&pdev->dev,
+			"mucse_mbx_get_capability failed! %d\n",
+			err);
+		goto err_free_net;
+	}
+	netdev->netdev_ops = &rnpgbe_netdev_ops;
+	netdev->watchdog_timeo = 5 * HZ;
+	err = hw->ops->reset_hw(hw);
+	if (err) {
+		dev_err(&pdev->dev, "Hw reset failed %d\n", err);
+		goto err_free_net;
+	}
+	eth_hw_addr_set(netdev, hw->perm_addr);
+	err = register_netdev(netdev);
+	if (err)
+		goto err_free_net;
 	return 0;
 
 err_free_net:
@@ -145,12 +217,15 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 static void rnpgbe_rm_adapter(struct pci_dev *pdev)
 {
 	struct mucse *mucse = pci_get_drvdata(pdev);
+	struct mucse_hw *hw = &mucse->hw;
 	struct net_device *netdev;
 
 	if (!mucse)
 		return;
 	netdev = mucse->netdev;
+	unregister_netdev(netdev);
 	mucse->netdev = NULL;
+	hw->ops->driver_status(hw, false, mucse_driver_insmod);
 	free_netdev(netdev);
 }
 
-- 
2.25.1


