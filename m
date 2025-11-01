Return-Path: <netdev+bounces-234811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40679C27578
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 02:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56911407D67
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 01:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EA2261B8C;
	Sat,  1 Nov 2025 01:40:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA0C1FF1A1;
	Sat,  1 Nov 2025 01:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761961200; cv=none; b=MksDLxMfSwtb+WkqkCvVp3qJDjNVZ+mmC1r3AVi+N8G8AZtSXdZpv91Q+7PhsnoHuTkzNxKc184CKVgj2u8ZXQOhyY5QWZv2Dy0WWSLvqWE65pGXGs9WG7YAVD0Fymfv0h5MP0xQstZhmsKqOzqDb4dmD+xtMn8OS7in4XQjo74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761961200; c=relaxed/simple;
	bh=CBbZ/ROGmSxNHzMKWjbM4ozWyO4GnZ4Ou7vZiCVv6Lo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I3tfDAPV692UCzF4eSGMbUidT4/UR76GBXbKrB2mrG0yXH3zxFQdEO8Opk1S+3LgwT5CeBklzc8cmlABQg0UR3BwnhY2gegMnws66czyL3Lu36nE8o+7VmcTKpEo7GOHJ94J2H4Jbo9IXoSUCY+U/kfHe3nfnF2LjJr1Ec9Upho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz9t1761961159tfa9c7820
X-QQ-Originating-IP: DmIGOKHEiOtdXK585+Ifq8245STw+hNQVyA1mmuYcJM=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 01 Nov 2025 09:39:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14165145623999627508
EX-QQ-RecipientCnt: 17
From: Dong Yibo <dong100@mucse.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	andrew+netdev@lunn.ch,
	danishanwar@ti.com,
	vadim.fedorenko@linux.dev,
	geert+renesas@glider.be,
	mpe@ellerman.id.au,
	lorenzo@kernel.org,
	lukas.bulwahn@redhat.com
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH net-next v17 5/5] net: rnpgbe: Add register_netdev
Date: Sat,  1 Nov 2025 09:38:49 +0800
Message-Id: <20251101013849.120565-6-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251101013849.120565-1-dong100@mucse.com>
References: <20251101013849.120565-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: NBZ5vkiDZf+QIXIurRQ5Nppivwp09rpQqPkX2r6pfYtN5/P+AsMVQjVQ
	1mvAweWTpG0/cngJGfc4T73pox/9ij3IIV2oyQbP65imlwlqqpui33202cOiIAT2JqmjJ92
	NIfg3Kq1/UCzapzO7uZAuswCLRmsj7gE1ScBHj61vmRZOkjRgVlnjxM/0wThwfgti7kZ4rL
	uvbdcEOFgVvruSlLYEXxjBpx2kaWUNL6jRqKspNIyQzUxZ2Gwqp7oZAIjtpUoixvNMa/K4A
	bk8wK6ljAkzgqP4MnttQCNMmNcB4Ae0Y6lDDrReELmo07SkxJV2FD8vk05AiFkctJt7ZBxI
	mgXeCYZ+irHC3/YNUcnLRchiux6Lmm5gBvBE6J3s/BbYB9tl3iIJkxkoZThN7NYytvjce0f
	TKYJh5T9APmpO5lzslkBygPnAH5MTzHqvsm4idjx7DmPW/WSpK8jVZRFmip1Wg0CL8mS9Il
	Kb5Se6AgYUIwRzkqtdRvLhfPTJRt6cyHcVn7l833YbpdyDaOyb+m48HBBX0YFlT6Pf5YFft
	oBhwNAs1FGMwR++uSv3GQYl19Z3uWcoqSyWOdGGWX5BFYa1QpcQ37H0Bj0uuTBIKcj2zjzc
	KkUGf3pjPgVE544gTQlxiBAwZzB6Cr/I0yQLuIvzsriynlY56Y1McOcAqvCFj4pcP4umqWs
	9Wb27qpCGzxxvb8LDP8bzDJVX7zDGuSlFw1ZpYKbvaWxthzfbgCZRMh+qaHrdHLoVMybuBo
	ZKp0X6iSx2GWI/Hy+kC4Zoc9R1j8r/cc8VoVJlFGAnHZwdfddHTO3OmGnHOhfJP08mGiD0Z
	kM6HWbRNISS3Zmn3lRJ1gCAqS0nj67X1i89t1M16/jHwJEVrQ7qNXNLje+WhqWEEp1WrwAN
	kmN+qKmcUpWVU6thxP8S9bRvbnrda/n37b4tAa0E+KcLh9p3YqkYiN4/kfPGTdZObsHUqzl
	u0K7NgOhgbvTs4VlFskNd/FaoTvi5A89Nbbjw5KjJEBIZHAAdMTWi6k2bimr012ygp1qeG3
	Wrb0qHw5MzdP/BXDQI/7AoWXzvBv++zO7N9WsiOA==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  22 ++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  73 +++++++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   2 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 119 +++++++++++++++++-
 4 files changed, 214 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 37bd9278beaa..5b024f9f7e17 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -26,18 +26,37 @@ struct mucse_mbx_info {
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
 	struct mucse_mbx_info mbx;
+	int port;
 	u8 pfvfnum;
 };
 
+struct mucse_stats {
+	u64 tx_dropped;
+};
+
 struct mucse {
 	struct net_device *netdev;
 	struct pci_dev *pdev;
 	struct mucse_hw hw;
+	struct mucse_stats stats;
 };
 
+int rnpgbe_get_permanent_mac(struct mucse_hw *hw, u8 *perm_addr);
+int rnpgbe_reset_hw(struct mucse_hw *hw);
+int rnpgbe_send_notify(struct mucse_hw *hw,
+		       bool enable,
+		       int mode);
 int rnpgbe_init_hw(struct mucse_hw *hw, int board_type);
 
 /* Device IDs */
@@ -46,4 +65,7 @@ int rnpgbe_init_hw(struct mucse_hw *hw, int board_type);
 #define RNPGBE_DEVICE_ID_N500_DUAL_PORT   0x8318
 #define RNPGBE_DEVICE_ID_N210             0x8208
 #define RNPGBE_DEVICE_ID_N210L            0x820a
+
+#define mucse_hw_wr32(hw, reg, val) \
+	writel((val), (hw)->hw_addr + (reg))
 #endif /* _RNPGBE_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
index 5739db98f12a..ebc7b3750157 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -1,11 +1,82 @@
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
+ * @perm_addr: pointer to store perm_addr
+ *
+ * rnpgbe_get_permanent_mac tries to get mac from hw
+ *
+ * Return: 0 on success, negative errno on failure
+ **/
+int rnpgbe_get_permanent_mac(struct mucse_hw *hw, u8 *perm_addr)
+{
+	struct device *dev = &hw->pdev->dev;
+	int err;
+
+	err = mucse_mbx_get_macaddr(hw, hw->pfvfnum, perm_addr, hw->port);
+	if (err) {
+		dev_err(dev, "Failed to get MAC from FW %d\n", err);
+		return err;
+	}
+
+	if (!is_valid_ether_addr(perm_addr)) {
+		dev_err(dev, "Failed to get valid MAC from FW\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * rnpgbe_reset_hw - Do a hardware reset
+ * @hw: hw information structure
+ *
+ * rnpgbe_reset_hw calls fw to do a hardware
+ * reset, and cleans some regs to default.
+ *
+ * Return: 0 on success, negative errno on failure
+ **/
+int rnpgbe_reset_hw(struct mucse_hw *hw)
+{
+	mucse_hw_wr32(hw, RNPGBE_DMA_AXI_EN, 0);
+	return mucse_mbx_reset_hw(hw);
+}
+
+/**
+ * rnpgbe_send_notify - Echo fw status
+ * @hw: hw information structure
+ * @enable: true or false status
+ * @mode: status mode
+ *
+ * Return: 0 on success, negative errno on failure
+ **/
+int rnpgbe_send_notify(struct mucse_hw *hw,
+		       bool enable,
+		       int mode)
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
 
 /**
  * rnpgbe_init_n500 - Setup n500 hw info
@@ -50,6 +121,8 @@ int rnpgbe_init_hw(struct mucse_hw *hw, int board_type)
 {
 	struct mucse_mbx_info *mbx = &hw->mbx;
 
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
index d8aaac79ff4b..316f941629d4 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -7,6 +7,7 @@
 
 #include "rnpgbe.h"
 #include "rnpgbe_hw.h"
+#include "rnpgbe_mbx_fw.h"
 
 static const char rnpgbe_driver_name[] = "rnpgbe";
 
@@ -24,6 +25,58 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
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
+	struct mucse *mucse = netdev_priv(netdev);
+
+	dev_kfree_skb_any(skb);
+	mucse->stats.tx_dropped++;
+
+	return NETDEV_TX_OK;
+}
+
+static const struct net_device_ops rnpgbe_netdev_ops = {
+	.ndo_open       = rnpgbe_open,
+	.ndo_stop       = rnpgbe_close,
+	.ndo_start_xmit = rnpgbe_xmit_frame,
+};
+
 /**
  * rnpgbe_add_adapter - Add netdev for this pci_dev
  * @pdev: PCI device information structure
@@ -39,10 +92,11 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 			      int board_type)
 {
 	struct net_device *netdev;
+	u8 perm_addr[ETH_ALEN];
 	void __iomem *hw_addr;
 	struct mucse *mucse;
 	struct mucse_hw *hw;
-	int err;
+	int err, err_notify;
 
 	netdev = alloc_etherdev_mq(sizeof(struct mucse), RNPGBE_MAX_QUEUES);
 	if (!netdev)
@@ -64,14 +118,67 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
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
+	err_notify = rnpgbe_send_notify(hw, true, mucse_fw_powerup);
+	if (err_notify) {
+		dev_warn(&pdev->dev, "Send powerup to hw failed %d\n",
+			 err_notify);
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
+		goto err_powerdown;
+	}
 
-	return 0;
+	netdev->netdev_ops = &rnpgbe_netdev_ops;
+	err = rnpgbe_reset_hw(hw);
+	if (err) {
+		dev_err(&pdev->dev, "Hw reset failed %d\n", err);
+		goto err_powerdown;
+	}
+
+	err = rnpgbe_get_permanent_mac(hw, perm_addr);
+	if (!err) {
+		eth_hw_addr_set(netdev, perm_addr);
+	} else if (err == -EINVAL) {
+		dev_warn(&pdev->dev, "Using random MAC\n");
+		eth_hw_addr_random(netdev);
+	} else if (err) {
+		dev_err(&pdev->dev, "get perm_addr failed %d\n", err);
+		goto err_powerdown;
+	}
+
+	err = register_netdev(netdev);
+	if (err)
+		goto err_powerdown;
 
+	return 0;
+err_powerdown:
+	/* notify powerdown only powerup ok */
+	if (!err_notify) {
+		err_notify = rnpgbe_send_notify(hw, false, mucse_fw_powerup);
+		if (err_notify)
+			dev_warn(&pdev->dev, "Send powerdown to hw failed %d\n",
+				 err_notify);
+	}
 err_free_net:
 	free_netdev(netdev);
 	return err;
@@ -138,11 +245,17 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
+	err = rnpgbe_send_notify(hw, false, mucse_fw_powerup);
+	if (err)
+		dev_warn(&pdev->dev, "Send powerdown to hw failed %d\n", err);
 	free_netdev(netdev);
 }
 
@@ -173,6 +286,8 @@ static void rnpgbe_dev_shutdown(struct pci_dev *pdev)
 
 	rtnl_lock();
 	netif_device_detach(netdev);
+	if (netif_running(netdev))
+		rnpgbe_close(netdev);
 	rtnl_unlock();
 	pci_disable_device(pdev);
 }
-- 
2.25.1


