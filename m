Return-Path: <netdev+bounces-223493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2ECEB59536
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 13:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADD371BC8163
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 11:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2ECB2D8797;
	Tue, 16 Sep 2025 11:31:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71DC2E9753;
	Tue, 16 Sep 2025 11:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758022261; cv=none; b=oQq/BsoslQ6uyeaoS2x9snZPHjiMcHei+u7f/OOI5/CnON9XdZZ+IT35IfKgc71Tl3vNikDOujO/wOuc1qnvaV9IvEpibG6EwanQRFyXNipFrc0DYqi9gV1tBqkCKJgVC4u3/NhPcqxzu+rpOTFwavtMBgC3/qP6ZeFGa6Hd7VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758022261; c=relaxed/simple;
	bh=jXKevkqhcx0uEobr3SlGukquHmW07+f+NZ3gXQGqnxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OcfUPSD24/UhEriu9i5G1/oGKWdOtY/yw0yO7Btl2rrq9mrgpI27kNSvgHgcDV2CunfAtvP1475T6F8g0MeOimvrx641S7/Uw40IsjGpJEDnlb4F7MNGHBPJsaWqUskZGpWBK75JQoO7z6UlK4CUNX4SaZLgZUh4aLYikC1zr8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz17t1758022231tbd375955
X-QQ-Originating-IP: AHOsMto06A05fs3q4UWYhinGoxxa9Y2vv4GIE1dnvdo=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 16 Sep 2025 19:30:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1886107155999213277
EX-QQ-RecipientCnt: 29
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
	vadim.fedorenko@linux.dev,
	joerg@jo-so.de
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH net-next v12 5/5] net: rnpgbe: Add register_netdev
Date: Tue, 16 Sep 2025 19:29:52 +0800
Message-Id: <20250916112952.26032-6-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250916112952.26032-1-dong100@mucse.com>
References: <20250916112952.26032-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MgQY1K25Ph0mmG79HVMILE4Gptg5KMQ0l1M/huamHvovc9rKr/LvIE4R
	wIEa4u07dFfHkGNMi5hz9OYnsbCVI+XzDyO4asOIWcsicZKNIp1U02Kx+16ylks6sRCl9MP
	QenpU4YFOjYTosEmgo0xqAunWeANXhMbAwELGdaf70zmRfNFeKmJet05SPI+nA0Hrpo2a5p
	NEIaDDFedeBj29W8Nwn/bUwA0Au70Z472Y2JuAKwr9FyDrvKHE1fB3y+6ngs0rC5OqCy4An
	Yda/Fbxmlwxn7fy+/9O4TIDxPzlZWtBVjUzjTiBJjFGvk5ilbhfqgf9mFg/2B8CmofbzR4H
	Cdim/OhZ3BwLOaKKYPvYjQtswf1a2IuisMWTgZoUnqxuCCNYFJVb8Nwfe2ZCK0waQTnQKzD
	9o2DJzJpEcP3UVJ1xUoh8namDqFbkzbp2EsdFv+hfnNA+oKnmb4onCmv4yibna1NcKsl0h5
	GTHiqIZUsOlEe20IFG6DsGF/KEoibbfyzAJhOWw8UUBbPcqf/kD55Tyi3/GXUYwbDEHfMvD
	uLYTuUwl3ZibBA7EUdKEx+fF6DyHHLTJJyyDB3/a4sCgtuZruikv6cHd19dMMgXELKkymlN
	OGbssoiDaSEWqexzSqFe81DW2yJDiYplDL7sHJh+Nt7qwdxvNde6lkvvsXNFPX+9SXjWvfB
	ff9tTyvOv2DFFVo8jzmpP5dFS5eoUZYhC5LAkigVnvfzFAP3ugYYGRvjD2GtVYVURfyZihy
	tXsRK9liL7xW5gGXljuIbzdTk5LtC6gsIFil8u5C7Kpi8/3Fs1OX4ej4pxBStyspJ+nenRa
	A8MAISiWSHryVsKFq8unIa1QVF3MhVPSFYVfW2IbQ1QhX+Y36xzmgzQIVutYUvLIpBnImss
	UaVmqkR/IkiWp9fZ4K5Z/LntzL4b4rnok0i5JVswczlHfuvEyhiOMUepTHL2g4ujVyA/1ew
	ZowliBTheuWJXMPwI8lhYDJO0OItvVFySJapXmeG/4+I8fQlxienXLfay4d+BEOdpmZKKKX
	noHJp+vdTbG7Z4mbT0zjF/QJ7Usv8=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
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
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  18 +++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  80 ++++++++++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   2 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 103 ++++++++++++++++++
 4 files changed, 203 insertions(+)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 41b580f2168f..4c4b2f13cb4a 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -6,6 +6,7 @@
 
 #include <linux/types.h>
 #include <linux/mutex.h>
+#include <linux/netdevice.h>
 
 enum rnpgbe_boards {
 	board_n500,
@@ -34,12 +35,26 @@ struct mucse_mbx_info {
 	u32 fwpf_ctrl_base;
 };
 
+enum {
+	mucse_fw_powerup,
+};
+
 struct mucse_hw {
 	void __iomem *hw_addr;
+	struct pci_dev *pdev;
+	const struct mucse_hw_operations *ops;
 	struct mucse_mbx_info mbx;
+	int port;
+	u8 perm_addr[ETH_ALEN];
 	u8 pfvfnum;
 };
 
+struct mucse_hw_operations {
+	int (*reset_hw)(struct mucse_hw *hw);
+	int (*get_perm_mac)(struct mucse_hw *hw);
+	int (*mbx_send_notify)(struct mucse_hw *hw, bool enable, int mode);
+};
+
 struct mucse {
 	struct net_device *netdev;
 	struct pci_dev *pdev;
@@ -54,4 +69,7 @@ int rnpgbe_init_hw(struct mucse_hw *hw, int board_type);
 #define PCI_DEVICE_ID_N500_DUAL_PORT 0x8318
 #define PCI_DEVICE_ID_N210 0x8208
 #define PCI_DEVICE_ID_N210L 0x820a
+
+#define mucse_hw_wr32(hw, reg, val) \
+	writel((val), (hw)->hw_addr + (reg))
 #endif /* _RNPGBE_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
index 86f1c75796b0..667e372387a2 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -1,11 +1,88 @@
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
+	mucse_hw_wr32(hw, RNPGBE_DMA_AXI_EN, 0);
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
@@ -50,6 +127,9 @@ int rnpgbe_init_hw(struct mucse_hw *hw, int board_type)
 {
 	struct mucse_mbx_info *mbx = &hw->mbx;
 
+	hw->ops = &rnpgbe_hw_ops;
+	hw->port = 0;
+
 	mbx->pf2fw_mbx_ctrl = MUCSE_GBE_PFFW_MBX_CTRL_OFFSET;
 	mbx->fwpf_mbx_mask = MUCSE_GBE_FWPF_MBX_MASK_OFFSET;
 
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
index aad4cb2f4164..8d0f6352a251 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -11,5 +11,7 @@
 #define MUCSE_N210_FWPF_CTRL_BASE 0x29400
 #define MUCSE_N210_FWPF_SHM_BASE 0x2d900
 
+#define RNPGBE_DMA_AXI_EN 0x0010
+
 #define RNPGBE_MAX_QUEUES 8
 #endif /* _RNPGBE_HW_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index c6cfb54f7c59..d8b9e7e3b01c 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -7,6 +7,7 @@
 
 #include "rnpgbe.h"
 #include "rnpgbe_hw.h"
+#include "rnpgbe_mbx_fw.h"
 
 static const char rnpgbe_driver_name[] = "rnpgbe";
 
@@ -28,6 +29,56 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
 	{0, },
 };
 
+/**
+ * rnpgbe_open - Called when a network interface is made active
+ * @netdev: network interface device structure
+ *
+ * The open entry point is called when a network interface is made
+ * active by the system (IFF_UP).
+ *
+ * Return: 0
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
+ * Return: NETDEV_TX_OK
+ **/
+static netdev_tx_t rnpgbe_xmit_frame(struct sk_buff *skb,
+				     struct net_device *netdev)
+{
+	dev_kfree_skb_any(skb);
+	netdev->stats.tx_dropped++;
+
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
@@ -68,11 +119,55 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
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
 
@@ -141,11 +236,17 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
 
@@ -176,6 +277,8 @@ static void rnpgbe_dev_shutdown(struct pci_dev *pdev)
 
 	rtnl_lock();
 	netif_device_detach(netdev);
+	if (netif_running(netdev))
+		rnpgbe_close(netdev);
 	rtnl_unlock();
 	pci_disable_device(pdev);
 }
-- 
2.25.1


