Return-Path: <netdev+bounces-219412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1B5B412A1
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 04:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2005702083
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 02:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2A6223339;
	Wed,  3 Sep 2025 02:55:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5AB221721;
	Wed,  3 Sep 2025 02:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756868129; cv=none; b=WVpnmfaRiiCMFi5UZfUgxiUiqZ4yGER/Bzkvqe0PyPTWOSGqi0jmefzcicHk4LIIixCQ86jYVZBkUwMHZObSOiW31PWl+edirBmlAab9bCs22LYcFzyqkuwCHjibJ6nuxIIQ4x0Gc6AppReWC0UBt3HXoCN+Mk8cNtSXbT5kH7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756868129; c=relaxed/simple;
	bh=e6opYFhVojaH9Sx8RFqPHGPIWMMRkKTov8qsVvCkaa8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RNx604dbJVmZNo/GGfxXaDsIbZxq/GG0YaFJhIAXBalHdbO4gwreJ+QQGTvkVuPxukf1bvneObsfHDO9NNjUjAXHXGF+kkNAtGyEGPqakYufe2rXG983TQKD4hYNg5zb5n8vtOKwOUhl+IERvnkxL2miIe2qvbwGdepUIYNZS9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz11t1756868099t2251f2e2
X-QQ-Originating-IP: gy1EKhzwJKWgk6rPuTzo8+IpRk+xDR9RQcBV/tZWzxQ=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 03 Sep 2025 10:54:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10481075631396352496
EX-QQ-RecipientCnt: 28
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
	gustavoars@kernel.org,
	rdunlap@infradead.org,
	vadim.fedorenko@linux.dev
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH net-next v10 5/5] net: rnpgbe: Add register_netdev
Date: Wed,  3 Sep 2025 10:54:30 +0800
Message-Id: <20250903025430.864836-6-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250903025430.864836-1-dong100@mucse.com>
References: <20250903025430.864836-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NYH+ffWV0Wms6a5GcFrFfp7PHrYWalChGKRGqLmAfQrj4YGExFeDXaoA
	wg8z2KS7CXp+Z9DiSWujhG3RmFkca/5ipk7CmuotWBJAPxUy0DHJ//or7SWT6g3Bu0SJFGy
	lB6e0iGaw0QsrE9axTDtwrXpE1iDK50qddrIfV5F0fwGifhQ9ZxSt80Z/nRJkr6eIAzw05B
	2kK7oHtPrsU1wY3/vY26/y9wZOXNJ5oEtm6FWBdwEFywUq7iQTT/W46Ca4u8PIKMBL+rF8d
	g6vNC/Kz/F77ekrvgoAeNWxojqT/SCa9qNNqkeWGLpMcgpCuYr08PwJHHfYnkioHRzJji3u
	zeBv/Ekz1G6qPLJ5TyD37mYsYJQ+AsJwbJI3CDs/ec48xH8XAjJ+8BI4koSttbi+MbCJap1
	rcB1FUgp6eCoQV6MBNjcV5dv03nwnJURZ8+DtgvZBBxAutzwUFap6CXVS0A09sCmsDnzXj/
	QfkNf/Z/aBJ2RtEIl6TwxyDVvlmf01OdKu9VG+3IPIzvTL9i/lCeHeXT0TQyZoDA50Rh1l6
	ZO6pYAsMQaRUHA+Fh7uaYYyXgs0SLl9dwnHe97uABtbv1/TXXiN2l5YfpFXG7krcTVNxGUD
	ztvhiD4smWqIfc1PHEEF0emIEwvz/As6egpCa1bOx1x94fjd48oLC99c1Yq5LxFXLlILRhH
	fbDQPqOUQ+niXUAETfdoLFXQIjKLqyjdS+fFi259XAbRh5X2nFul0lNFJxR8cOum4O74wvA
	yDfZcSObaMtV9AFX8/u2tywcTi+uMkFGt5CQBggkRiqqhCEVECafZ9AbzG7T0QyPZ/f6mmW
	KDgaiot0+vnaM78R98TXkeWo95EvNgg8gKkd5uj94DFGtGxXM1B93cJavc/gfnaQvH37WO/
	5hXw/tc42eE0YTIAK/HEfBp+ves3xNwDGOcoo1/wmrK1l5VjqaeORg8WSgy5pTAIjAT4YGe
	gxJNvVXqIr3rhRga97jSGa5PfK35uLXgT1f1znUqBhXtSTze+azlpC0yMn+d15hcOKfmIqH
	c0ObwOAUVu4Uk59NCi0r3jFKUfkg7aeFfeFiOg/DHc9uA0e6sU
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Initialize get mac from hw, register the netdev.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    | 24 +++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 86 ++++++++++++++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  2 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 89 +++++++++++++++++++
 4 files changed, 201 insertions(+)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 4d2cca59fb23..92bd3ba76c72 100644
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
@@ -47,12 +52,28 @@ struct mucse_mbx_info {
 	u32 fw2pf_mbox_vec;
 };
 
+struct mucse_hw;
+
+struct mucse_hw_operations {
+	int (*reset_hw)(struct mucse_hw *hw);
+	int (*get_perm_mac)(struct mucse_hw *hw);
+	int (*echo_fw_status)(struct mucse_hw *hw, bool enable, int mode);
+};
+
+enum {
+	mucse_fw_powerup,
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
@@ -72,4 +93,7 @@ struct rnpgbe_info {
 #define PCI_DEVICE_ID_N500_DUAL_PORT 0x8318
 #define PCI_DEVICE_ID_N210 0x8208
 #define PCI_DEVICE_ID_N210L 0x820a
+
+#define rnpgbe_dma_wr32(dma, reg, val) \
+	writel((val), (dma)->dma_base_addr + (reg))
 #endif /* _RNPGBE_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
index f38daef752a3..1c70653545f2 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -1,11 +1,91 @@
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
+ *
+ * rnpgbe_get_permanent_mac tries to get mac from hw.
+ * It use eth_random_addr if failed.
+ *
+ * Return: 0 on success, negative errno on failure
+ **/
+static int rnpgbe_get_permanent_mac(struct mucse_hw *hw)
+{
+	struct device *dev = &hw->pdev->dev;
+	u8 *mac_addr = hw->perm_addr;
+	int err;
+
+	err = mucse_mbx_get_macaddr(hw, hw->pfvfnum, mac_addr, hw->port);
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
+ * Return: 0 on success, negative errno on failure
+ **/
+static int rnpgbe_reset_hw_ops(struct mucse_hw *hw)
+{
+	struct mucse_dma_info *dma = &hw->dma;
+
+	rnpgbe_dma_wr32(dma, RNPGBE_DMA_AXI_EN, 0);
+	return mucse_mbx_reset_hw(hw);
+}
+
+/**
+ * rnpgbe_echo_fw_status_hw_ops - Echo fw status
+ * @hw: hw information structure
+ * @enable: true or false status
+ * @mode: status mode
+ *
+ * Return: 0 on success, negative errno on failure
+ **/
+static int rnpgbe_echo_fw_status_hw_ops(struct mucse_hw *hw,
+					bool enable,
+					int mode)
+{
+	int err;
+
+	switch (mode) {
+	case mucse_fw_powerup:
+		err = mucse_mbx_powerup(hw, enable);
+		break;
+	default:
+		err = -EINVAL;
+	}
+
+	return err;
+}
+
+static const struct mucse_hw_operations rnpgbe_hw_ops = {
+	.reset_hw = &rnpgbe_reset_hw_ops,
+	.get_perm_mac = &rnpgbe_get_permanent_mac,
+	.echo_fw_status = &rnpgbe_echo_fw_status_hw_ops,
+};
 
 /**
  * rnpgbe_init_common - Setup common attribute
@@ -13,10 +93,16 @@
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
index 25b7119d6ecb..4562aeba4a24 100644
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
+ * Return: 0 on success, negative value on failure
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
+ * Return: 0, this is not allowed to fail
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
+ * Return: NETDEV_TX_OK or NETDEV_TX_BUSY
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
@@ -78,6 +129,38 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 
 	hw->hw_addr = hw_addr;
 	info->init(hw);
+	mucse_init_mbx_params_pf(hw);
+	err = hw->ops->echo_fw_status(hw, true, mucse_fw_powerup);
+	if (err) {
+		dev_warn(&pdev->dev, "Send powerup to hw failed %d\n", err);
+		dev_warn(&pdev->dev, "Maybe low performance\n");
+	}
+
+	err = mucse_mbx_sync_fw(hw);
+	if (err) {
+		dev_err(&pdev->dev, "Sync fw failed! %d\n", err);
+		goto err_free_net;
+	}
+	netdev->netdev_ops = &rnpgbe_netdev_ops;
+	netdev->watchdog_timeo = 5 * HZ;
+	err = hw->ops->reset_hw(hw);
+	if (err) {
+		dev_err(&pdev->dev, "Hw reset failed %d\n", err);
+		goto err_free_net;
+	}
+	err = hw->ops->get_perm_mac(hw);
+	if (err == -EINVAL) {
+		dev_warn(&pdev->dev, "Try to use random MAC\n");
+		eth_random_addr(hw->perm_addr);
+	} else if (err) {
+		dev_err(&pdev->dev, "get perm_addr failed %d\n", err);
+		goto err_free_net;
+	}
+	eth_hw_addr_set(netdev, hw->perm_addr);
+	err = register_netdev(netdev);
+	if (err)
+		goto err_free_net;
+
 	return 0;
 
 err_free_net:
@@ -145,12 +228,18 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 static void rnpgbe_rm_adapter(struct pci_dev *pdev)
 {
 	struct mucse *mucse = pci_get_drvdata(pdev);
+	struct mucse_hw *hw = &mucse->hw;
 	struct net_device *netdev;
+	int err;
 
 	if (!mucse)
 		return;
 	netdev = mucse->netdev;
+	unregister_netdev(netdev);
 	mucse->netdev = NULL;
+	err = hw->ops->echo_fw_status(hw, false, mucse_fw_powerup);
+	if (err)
+		dev_warn(&pdev->dev, "Send powerdown to hw failed %d\n", err);
 	free_netdev(netdev);
 }
 
-- 
2.25.1


