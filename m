Return-Path: <netdev+bounces-221191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AB1B4F405
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 14:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 17D1F4E2C1A
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 12:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32296335BAA;
	Tue,  9 Sep 2025 12:10:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF74334704;
	Tue,  9 Sep 2025 12:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757419803; cv=none; b=EbBD4TpU04+NwMAWb1IMtdj8y4nukbguuMMr58HsTL/SaYAqY0vGqPehGIsRTg/vTSsJcRj/vTE5+k9fsJMU1fhaV/oT5rg/YrdORMpvk+NjLmk7dcM9f3wLgolZgOjigSZoPtZ9chn3PiZMCFvLRzE3NJkMo6IVi5Y3Iy9PJaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757419803; c=relaxed/simple;
	bh=fb+9nirWQzlNmSVT6DXPZW7dnFkveduyG16VUJZp0Vo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TfQIjpp4+gGbIRytuCh3O1YnzVDyF3Fj5bU+q1ERS8ZnTLXIXprrLYxA6uZV7LlxWOPCuAyURcy4S0nRD+2cbeDx+x2AyBD6xxV74pRHGCus6Rf31C2hrpmGyc8y6zOcvVN0pFzajbehRq/V0J1kdy+EYSzgFnCuZ/OflhDdBGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz6t1757419777tc115d208
X-QQ-Originating-IP: OLjRMUrsZaAfbbJy7epHSYAgn5O1zQVi3D5eUiVsHm0=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 09 Sep 2025 20:09:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8394822052060240261
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
Subject: [PATCH net-next v11 5/5] net: rnpgbe: Add register_netdev
Date: Tue,  9 Sep 2025 20:09:06 +0800
Message-Id: <20250909120906.1781444-6-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250909120906.1781444-1-dong100@mucse.com>
References: <20250909120906.1781444-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OLC9REgaVYQoWfnuDbwzc727RdpjUA7G21o+47soomlkRNiGP53GHW1X
	iaBCYO51ofB+k/XaLKBqgAMUXUJ59T8pYbK3U2b77JdE+k2HtK+E4LXysG8T+zHA6WfjYYk
	Dlf7O4pRaJ9nQUc9LH+NCcTHkKOTj1EseFNMlh6mSfvbwsFgAicTZFhQeCdJNfVion5u5Xh
	btXCZh1R8ejnz3S4CbLgYSObaxLfJ0hCzCDVaryaB2ZpbVUuGEXQVz5stvfJiHX+avKGD/U
	Ulu22E46khTiQzpRmZqpI5HHaXWyPlEvn0fPxoWU3eh+qV4QmFSuRmCTBrkiV2kx1f2NYYp
	4/f5jIPBTgycVEgClQXuB8cxq30xEbB32KnAZCYSYPgDnVV0M3fDSfsT6S+kzSoiw/9+nHc
	4AQbxWJu2iVOSZPe2f7yST5ByMkJ27Uj/Sufrh9c1Y7kOgJf9t8ld+YuSrnrG+mFynX//aX
	QFC0whzRgMn0yUJk4d0k+Y+IYtfh5pz/OzBLasYw40XX+k3jBFokghKq6RbJ0l6YTgF9dgq
	8EfbnefRI2wl0qCY+dIEKMqIDyyBbhNk8WuwNuNSK02oIXhFEgLy6HkH6B6geVv9QLa2g+s
	Dy6dU/eL/aOMtOQJjzJNcYvUVCpiBtlUcEWXPcazUwS3uckkgI/ddJRHiSs1MAL/bfRDM+A
	kRfpUEaTBObknxNhvFO0EKA3boVMEYBqKie1VgmwMh4hQmMmS9KCeqX/dw4Wffe5rCGzKH9
	LztBvfQx5hU9gvNFSoC+rpJcqZPa3un8E208rx03rlhPs6elYsGwPG56Hh16iaQKNm3HGCo
	JY+HuwCmCTPXTi0/T0XO+a86+/HvEvnXoc9VYRALqA/GQOqklxpP7jSbAZIKfRlT4mDBqvb
	LoSF5qCNB6p+ibQ1uWJsgon+YEXd38GmmMmjPLf+2mTZn2DUa4MTubukHkW1lURt5KQSEXv
	tCkFHhxhg3idOBAHkz98KbB7+ij8ZhxsK++zWBds4gL70QixGQNsQq1XN7MJ9WUht1s9Qbx
	UCkRu6QfppNvMf6yLmwWy8Sy4oLlmmV2zVoM+T7w==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

Complete the network device (netdev) registration flow for Mucse Gbe
Ethernet chips, including:
1. Hardware state initialization:
   - Send powerup notification to firmware (via echo_fw_status)
   - Sync with firmware
   - Reset hardware
2. MAC address handling:
   - Retrieve permanent MAC from firmware (via mucse_mbx_get_macaddr)
   - Fallback to random valid MAC (eth_random_addr) if not valid mac
     from Fw

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  25 +++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  85 +++++++++++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   2 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 102 ++++++++++++++++++
 4 files changed, 214 insertions(+)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 3a1ad82c24bd..5278cb1d421e 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -6,12 +6,17 @@
 
 #include <linux/types.h>
 #include <linux/mutex.h>
+#include <linux/netdevice.h>
 
 enum rnpgbe_boards {
 	board_n500,
 	board_n210
 };
 
+struct mucse_dma_info {
+	void __iomem *dma_base_addr;
+};
+
 struct mucse_mbx_stats {
 	u32 msgs_tx; /* Number of messages sent from PF to fw */
 	u32 msgs_rx; /* Number of messages received from fw to PF */
@@ -34,9 +39,26 @@ struct mucse_mbx_info {
 	u32 fwpf_ctrl_base;
 };
 
+struct mucse_hw;
+
+struct mucse_hw_operations {
+	int (*reset_hw)(struct mucse_hw *hw);
+	int (*get_perm_mac)(struct mucse_hw *hw);
+	int (*mbx_send_notify)(struct mucse_hw *hw, bool enable, int mode);
+};
+
+enum {
+	mucse_fw_powerup,
+};
+
 struct mucse_hw {
 	void __iomem *hw_addr;
+	struct pci_dev *pdev;
+	const struct mucse_hw_operations *ops;
+	struct mucse_dma_info dma;
 	struct mucse_mbx_info mbx;
+	int port;
+	u8 perm_addr[ETH_ALEN];
 	u8 pfvfnum;
 };
 
@@ -54,4 +76,7 @@ int rnpgbe_init_hw(struct mucse_hw *hw, int board_type);
 #define PCI_DEVICE_ID_N500_DUAL_PORT 0x8318
 #define PCI_DEVICE_ID_N210 0x8208
 #define PCI_DEVICE_ID_N210L 0x820a
+
+#define rnpgbe_dma_wr32(dma, reg, val) \
+	writel((val), (dma)->dma_base_addr + (reg))
 #endif /* _RNPGBE_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
index 0e277e7557ee..436fb03f9736 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -1,11 +1,90 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2020 - 2025 Mucse Corporation. */
 
+#include <linux/pci.h>
 #include <linux/errno.h>
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
+ * rnpgbe_get_permanent_mac tries to get mac from hw
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
+ * rnpgbe_reset - Do a hardware reset
+ * @hw: hw information structure
+ *
+ * rnpgbe_reset calls fw to do a hardware
+ * reset, and cleans some regs to default.
+ *
+ * Return: 0 on success, negative errno on failure
+ **/
+static int rnpgbe_reset(struct mucse_hw *hw)
+{
+	struct mucse_dma_info *dma = &hw->dma;
+
+	rnpgbe_dma_wr32(dma, RNPGBE_DMA_AXI_EN, 0);
+	return mucse_mbx_reset_hw(hw);
+}
+
+/**
+ * rnpgbe_mbx_send_notify - Echo fw status
+ * @hw: hw information structure
+ * @enable: true or false status
+ * @mode: status mode
+ *
+ * Return: 0 on success, negative errno on failure
+ **/
+static int rnpgbe_mbx_send_notify(struct mucse_hw *hw,
+				  bool enable,
+				  int mode)
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
+	.reset_hw = rnpgbe_reset,
+	.get_perm_mac = rnpgbe_get_permanent_mac,
+	.mbx_send_notify = rnpgbe_mbx_send_notify,
+};
 
 /**
  * rnpgbe_init_n500 - Setup n500 hw info
@@ -48,8 +127,14 @@ static void rnpgbe_init_n210(struct mucse_hw *hw)
  **/
 int rnpgbe_init_hw(struct mucse_hw *hw, int board_type)
 {
+	struct mucse_dma_info *dma = &hw->dma;
 	struct mucse_mbx_info *mbx = &hw->mbx;
 
+	hw->ops = &rnpgbe_hw_ops;
+	hw->port = 0;
+
+	dma->dma_base_addr = hw->hw_addr;
+
 	mbx->pf2fw_mbx_ctrl = MUCSE_GBE_PFFW_MBX_CTRL_OFFSET;
 	mbx->fwpf_mbx_mask = MUCSE_GBE_FWPF_MBX_MASK_OFFSET;
 
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
index 612f0ba65265..00bf7571bf35 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -11,6 +11,8 @@
 #define MUCSE_GBE_FWPF_MBX_MASK_OFFSET 0x5700
 #define MUCSE_N210_FWPF_CTRL_BASE 0x29400
 #define MUCSE_N210_FWPF_SHM_BASE 0x2d900
+/**************** DMA Registers ****************************/
+#define RNPGBE_DMA_AXI_EN 0x0010
 /**************** CHIP Resource ****************************/
 #define RNPGBE_MAX_QUEUES 8
 #endif /* _RNPGBE_HW_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index c6cfb54f7c59..94de1693c4a0 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -7,6 +7,7 @@
 
 #include "rnpgbe.h"
 #include "rnpgbe_hw.h"
+#include "rnpgbe_mbx_fw.h"
 
 static const char rnpgbe_driver_name[] = "rnpgbe";
 
@@ -28,6 +29,55 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
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
@@ -68,11 +118,55 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 	}
 
 	hw->hw_addr = hw_addr;
+	hw->pdev = pdev;
+
 	err = rnpgbe_init_hw(hw, board_type);
 	if (err) {
 		dev_err(&pdev->dev, "Init hw err %d\n", err);
 		goto err_free_net;
 	}
+	/* Step 1: Send power-up notification to firmware (no response expected)
+	 * This informs firmware to initialize hardware power state, but
+	 * firmware only acknowledges receipt without returning data. Must be
+	 * done before synchronization as firmware may be in low-power idle
+	 * state initially.
+	 */
+	err = hw->ops->mbx_send_notify(hw, true, mucse_fw_powerup);
+	if (err) {
+		dev_warn(&pdev->dev, "Send powerup to hw failed %d\n", err);
+		dev_warn(&pdev->dev, "Maybe low performance\n");
+	}
+	/* Step 2: Synchronize mailbox communication with firmware (requires
+	 * response) After power-up, confirm firmware is ready to process
+	 * requests with responses. This ensures subsequent request/response
+	 * interactions work reliably.
+	 */
+	err = mucse_mbx_sync_fw(hw);
+	if (err) {
+		dev_err(&pdev->dev, "Sync fw failed! %d\n", err);
+		goto err_free_net;
+	}
+
+	netdev->netdev_ops = &rnpgbe_netdev_ops;
+	err = hw->ops->reset_hw(hw);
+	if (err) {
+		dev_err(&pdev->dev, "Hw reset failed %d\n", err);
+		goto err_free_net;
+	}
+
+	err = hw->ops->get_perm_mac(hw);
+	if (err == -EINVAL) {
+		dev_warn(&pdev->dev, "Using random MAC\n");
+		eth_random_addr(hw->perm_addr);
+	} else if (err) {
+		dev_err(&pdev->dev, "get perm_addr failed %d\n", err);
+		goto err_free_net;
+	}
+
+	eth_hw_addr_set(netdev, hw->perm_addr);
+	err = register_netdev(netdev);
+	if (err)
+		goto err_free_net;
 
 	return 0;
 
@@ -141,11 +235,17 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
+	err = hw->ops->mbx_send_notify(hw, false, mucse_fw_powerup);
+	if (err)
+		dev_warn(&pdev->dev, "Send powerdown to hw failed %d\n", err);
 	free_netdev(netdev);
 }
 
@@ -176,6 +276,8 @@ static void rnpgbe_dev_shutdown(struct pci_dev *pdev)
 
 	rtnl_lock();
 	netif_device_detach(netdev);
+	if (netif_running(netdev))
+		rnpgbe_close(netdev);
 	rtnl_unlock();
 	pci_disable_device(pdev);
 }
-- 
2.25.1


