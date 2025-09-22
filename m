Return-Path: <netdev+bounces-225121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C979B8EB72
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 03:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 545A817C6F5
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 01:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AB71F0E26;
	Mon, 22 Sep 2025 01:42:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447FB1922FB;
	Mon, 22 Sep 2025 01:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758505328; cv=none; b=QrEtG68aSyMOFGdBNsDUOWCSKIzGSPQGV00hYhlEp5sCuXMNkvVrnPyAPggS8uWx48FZU0JQr0nWKQBHQX/j/U5quEXcOBRuIFXeP85TfpoIViaccBBWKN8ZwC3w34KoZLUtkAm6lcw4uNBPCR68BLacd7cBSpvYO+GhBa2L5Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758505328; c=relaxed/simple;
	bh=4WtzDhju0/Edf4JfNRVXi0FmXoL+QRsgOjQGYtcw+6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eWSCjDZlkBy/358J+KxSctVhrui068ZpD0e3tDPhp4+zdV61j5ZqgxNA33HpOrw2i3hDW+eX6tk8GmVenXc5Cq2KAY94/505KimNufQh6glrhZOVuKdvveN0mSWyIXIFXh6woatXTTF2nCobXPGLusNg2N9NtoHbrSZHSArNqkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz16t1758505301ted90ab48
X-QQ-Originating-IP: UwdCZIT79UDOIE/P2orrfyiHpCGmr3s7er80Xm1xUzY=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 22 Sep 2025 09:41:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5174305604080231638
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
Subject: [PATCH net-next v13 5/5] net: rnpgbe: Add register_netdev
Date: Mon, 22 Sep 2025 09:41:11 +0800
Message-Id: <20250922014111.225155-6-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250922014111.225155-1-dong100@mucse.com>
References: <20250922014111.225155-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M5XvDI2tTifr8BOhGFB4XxvpYHZSOnKt8RRivP19J0vp2THabBZ3Hi9e
	QNIfjHTQxnl4DtIUrbLt0/SMsoulAA3HZQS98JlE8F4Y5rh+kQUlqZcF0LEYFi6MzTQYZlZ
	BO7T8PJkJDFQzwFsZBi/NEVKVZO6vMAU4ODiczobGJl6yjORK63W7rTudPOSSdw/RNQn+Tx
	asODSUu5ddu5ERJxavlsg1DWX8yGcasGFObV5h5gm3ty5wXiQkFhdZ9KKMTi+ootZIGxL5G
	ZSB5qJVQAP56a0HdpfkorYbQ6D4yU47P2dUnTewtTC/Rdj3TxVcl+BEfHbjfjiSedXvNvu7
	AF3DQl+lij4tSBx4cD5HVM9IzSPzjR/Gcp2TROF4fA+ZRlk+t7ASKcPaqZF8ZMsZlVszght
	wyfLqzljHPQmSyl/GqkBO3INoFwOYFafguSw2JbSTpXJCtouMw6LsabpSvtgQeNSAFR3Td8
	Qmia+OccI4IGrGHWyAt5BygDMexnnWo2TWgvYMqOmvgloPUvSYVX96/BbG9XNv3S/Q0gBLj
	pp9urNWDykd40ZKkxN3vPbPrQZvn+wj42YKzFnUHM+Mm73HlZTLlN02aPlo9dvjc85ykd47
	rZUZTkjjKxDkwpTAo2BLpUgD932Y+jATCbXqv9wC/TiTv8XTtnHaOOajlK5iucokAwVKkBm
	e1pdre3l6YZ2vHR+z94z3M1Un+/wF6eDW9lLVfv4zDkULiK+GawGB2gv7H8E/zkyfcj+Zxx
	Wjl7xOuqNyiBXKyFBhQWRr4PiLuCz7L2Zxwwx0fKoruWBN/jNY9QR2M2FuIjRaz9UvW3ilv
	ESic39iKX5Vw+OxZIWeUh2LFfJNzTPDIGU3RFFrdNLExzd6iv/t6aqRV1eJmOCjm6Cr87sK
	RyDHy7lh5fMl4fJtEudERVsk/vqS2AxthGSwoilJnex5TPLz75dxWIA13hqYPEf96Dh1gNr
	AcW55ziq6yJ5iY/tUf6obVUblexqHh7ey3L/VqVIjJ86oJNJnD3ZHdPlFYAi1DaGHNj5rMf
	VFgjy8Wo10prnzgHi++0FkFtv12QOE829j0cQNkLPd1Aq3FTrUBD+Q4F83PRQ=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
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
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  21 ++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  80 ++++++++++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   2 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 103 ++++++++++++++++++
 4 files changed, 206 insertions(+)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 794581471b22..c53cf26d8360 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -6,6 +6,7 @@
 
 #include <linux/types.h>
 #include <linux/mutex.h>
+#include <linux/netdevice.h>
 
 enum rnpgbe_boards {
 	board_n500,
@@ -34,12 +35,29 @@ struct mucse_mbx_info {
 	u32 fwpf_ctrl_base;
 };
 
+/* Enum for firmware notification modes,
+ * more modes (e.g., portup, link_report) will be added in future
+ **/
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
@@ -54,4 +72,7 @@ int rnpgbe_init_hw(struct mucse_hw *hw, int board_type);
 #define RNPGBE_DEVICE_ID_N500_DUAL_PORT   0x8318
 #define RNPGBE_DEVICE_ID_N210             0x8208
 #define RNPGBE_DEVICE_ID_N210L            0x820a
+
+#define mucse_hw_wr32(hw, reg, val) \
+	writel((val), (hw)->hw_addr + (reg))
 #endif /* _RNPGBE_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
index 5739db98f12a..c8cb1b805554 100644
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
+	/* Keep switch struct to support more modes in the future */
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
index 268f572936aa..e77e6bc3d3e3 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -11,5 +11,7 @@
 #define MUCSE_N210_FWPF_CTRL_BASE      0x29400
 #define MUCSE_N210_FWPF_SHM_BASE       0x2d900
 
+#define RNPGBE_DMA_AXI_EN              0x0010
+
 #define RNPGBE_MAX_QUEUES 8
 #endif /* _RNPGBE_HW_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index 459b17452e6d..9b4c2e5589c9 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -7,6 +7,7 @@
 
 #include "rnpgbe.h"
 #include "rnpgbe_hw.h"
+#include "rnpgbe_mbx_fw.h"
 
 static const char rnpgbe_driver_name[] = "rnpgbe";
 
@@ -24,6 +25,56 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
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
@@ -64,11 +115,55 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
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
 
@@ -138,11 +233,17 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
 
@@ -173,6 +274,8 @@ static void rnpgbe_dev_shutdown(struct pci_dev *pdev)
 
 	rtnl_lock();
 	netif_device_detach(netdev);
+	if (netif_running(netdev))
+		rnpgbe_close(netdev);
 	rtnl_unlock();
 	pci_disable_device(pdev);
 }
-- 
2.25.1


