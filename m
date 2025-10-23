Return-Path: <netdev+bounces-232054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC463C00577
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 11:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3200D189451A
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 09:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CAC2F9DB1;
	Thu, 23 Oct 2025 09:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tNGragor"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D126D257835
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 09:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761212790; cv=none; b=pMMfcbKzn+GgNB+F7KKek0cIRRHZiBkR4Bk3ua0LwGDV1g8OWmJg6DAkA7RASMZxSbadNuUd/nTD7BKacDTpZMuCDOA29o/hlaLbT2OvEPlq2KMLCjx3wZFDt/ifN+whw2JnJigLNkd2RDVDZG8iMbDu4RexVeJRO8qbooOPKNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761212790; c=relaxed/simple;
	bh=0DOX35AD0iUnE10YJEBOdI2E/Po+xjqOh3DeDCdwJns=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=RhB6AFVEltEK/VSYcoLtO4DXPNB5sC7dzR8Ef0+N6XugsGcm4zshCU9UI+tfZXQdXrdEQc4ADRxceQwIiEuZzswCCt1uj78QfMtiq0BS9zq+wYKhhyINEZ0qflESsZeE9ViWJkOyJ062aXQr7BtjaIow+SPSMFp0lO24OhtVQHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=tNGragor; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0aqrrDz/mmHlg0A9Y/lGrOboHeJff2Ziz8bK60ad7pg=; b=tNGragor/J0uEU7qLtbVJ0Z2/y
	T6FjBHKdht2ZpaerYTC/CL6zozW8kCgExfDhWqOlR3vxouRyh+E0FFDyJ2ufCEA+EYqhEh3/h3Gle
	tdDNa4eQaEp8oo6Rod1W59F8ff8Vw6/yHdQWhUMBxdA1mCo1O6Zpxw6B6J6e31c7CuXTBocUBPSc9
	bpuyZC8SBxYbCkt88s1e+ayRpOlBiZMKpGP9bCMZY/dy2CfZKfxn0DYYYTuwNSksanZ3M6qATbtyt
	mrffOZW+p8Prar31lPtPR2JzbehyEOeIy6oP4iyC1dxVOwFpmrVM7g9J+SdzWSNXRqGdn+pxHApQ+
	1GEHGE9w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:60216 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vBrtl-0000000068a-1vRt;
	Thu, 23 Oct 2025 10:46:21 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vBrtk-0000000BMYm-3CV5;
	Thu, 23 Oct 2025 10:46:20 +0100
In-Reply-To: <aPn5YVeUcWo4CW3c@shell.armlinux.org.uk>
References: <aPn5YVeUcWo4CW3c@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 1/2] net: stmmac: add stmmac_mac_irq_modify()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vBrtk-0000000BMYm-3CV5@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 23 Oct 2025 10:46:20 +0100

Add a function to allow interrupts to be enabled and disabled in a
core independent manner.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/common.h    |  5 +++++
 .../ethernet/stmicro/stmmac/dwmac1000_core.c    | 15 +++++++++++++++
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c   | 17 +++++++++++++++++
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 16 ++++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/hwif.c      |  2 ++
 drivers/net/ethernet/stmicro/stmmac/hwif.h      |  4 ++++
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.c    |  3 +++
 7 files changed, 62 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 31254ba525d5..553a8897b005 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -611,6 +611,11 @@ struct mac_device_info {
 	u8 vlan_fail_q;
 	bool hw_vlan_en;
 	bool reverse_sgmii_enable;
+
+	/* This spinlock protects read-modify-write of the interrupt
+	 * mask/enable registers.
+	 */
+	spinlock_t irq_ctrl_lock;
 };
 
 struct stmmac_rx_routing {
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index 571e48362444..2ca94bfd3f71 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -61,6 +61,20 @@ static void dwmac1000_core_init(struct mac_device_info *hw,
 #endif
 }
 
+static void dwmac1000_irq_modify(struct mac_device_info *hw, u32 disable,
+				 u32 enable)
+{
+	void __iomem *int_mask = hw->pcsr + GMAC_INT_MASK;
+	unsigned long flags;
+	u32 value;
+
+	spin_lock_irqsave(&hw->irq_ctrl_lock, flags);
+	value = readl(int_mask) | disable;
+	value &= ~enable;
+	writel(value, int_mask);
+	spin_unlock_irqrestore(&hw->irq_ctrl_lock, flags);
+}
+
 static int dwmac1000_rx_ipc_enable(struct mac_device_info *hw)
 {
 	void __iomem *ioaddr = hw->pcsr;
@@ -445,6 +459,7 @@ static void dwmac1000_set_mac_loopback(void __iomem *ioaddr, bool enable)
 const struct stmmac_ops dwmac1000_ops = {
 	.pcs_init = dwmac1000_pcs_init,
 	.core_init = dwmac1000_core_init,
+	.irq_modify = dwmac1000_irq_modify,
 	.set_mac = stmmac_set_mac,
 	.rx_ipc = dwmac1000_rx_ipc_enable,
 	.dump_regs = dwmac1000_dump_regs,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 0b785389b7ef..6269407d70cd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -57,6 +57,20 @@ static void dwmac4_core_init(struct mac_device_info *hw,
 		init_waitqueue_head(&priv->tstamp_busy_wait);
 }
 
+static void dwmac4_irq_modify(struct mac_device_info *hw, u32 disable,
+			      u32 enable)
+{
+	void __iomem *int_mask = hw->pcsr + GMAC_INT_EN;
+	unsigned long flags;
+	u32 value;
+
+	spin_lock_irqsave(&hw->irq_ctrl_lock, flags);
+	value = readl(int_mask) & ~disable;
+	value |= enable;
+	writel(value, int_mask);
+	spin_unlock_irqrestore(&hw->irq_ctrl_lock, flags);
+}
+
 static void dwmac4_update_caps(struct stmmac_priv *priv)
 {
 	if (priv->plat->tx_queues_to_use > 1)
@@ -885,6 +899,7 @@ static int dwmac4_config_l4_filter(struct mac_device_info *hw, u32 filter_no,
 const struct stmmac_ops dwmac4_ops = {
 	.pcs_init = dwmac4_pcs_init,
 	.core_init = dwmac4_core_init,
+	.irq_modify = dwmac4_irq_modify,
 	.update_caps = dwmac4_update_caps,
 	.set_mac = stmmac_set_mac,
 	.rx_ipc = dwmac4_rx_ipc_enable,
@@ -920,6 +935,7 @@ const struct stmmac_ops dwmac4_ops = {
 const struct stmmac_ops dwmac410_ops = {
 	.pcs_init = dwmac4_pcs_init,
 	.core_init = dwmac4_core_init,
+	.irq_modify = dwmac4_irq_modify,
 	.update_caps = dwmac4_update_caps,
 	.set_mac = stmmac_dwmac4_set_mac,
 	.rx_ipc = dwmac4_rx_ipc_enable,
@@ -957,6 +973,7 @@ const struct stmmac_ops dwmac410_ops = {
 const struct stmmac_ops dwmac510_ops = {
 	.pcs_init = dwmac4_pcs_init,
 	.core_init = dwmac4_core_init,
+	.irq_modify = dwmac4_irq_modify,
 	.update_caps = dwmac4_update_caps,
 	.set_mac = stmmac_dwmac4_set_mac,
 	.rx_ipc = dwmac4_rx_ipc_enable,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 0430af27da40..b40b3ea50e25 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -28,6 +28,20 @@ static void dwxgmac2_core_init(struct mac_device_info *hw,
 	writel(XGMAC_INT_DEFAULT_EN, ioaddr + XGMAC_INT_EN);
 }
 
+static void dwxgmac2_irq_modify(struct mac_device_info *hw, u32 disable,
+				u32 enable)
+{
+	void __iomem *int_mask = hw->pcsr + XGMAC_INT_EN;
+	unsigned long flags;
+	u32 value;
+
+	spin_lock_irqsave(&hw->irq_ctrl_lock, flags);
+	value = readl(int_mask) & ~disable;
+	value |= enable;
+	writel(value, int_mask);
+	spin_unlock_irqrestore(&hw->irq_ctrl_lock, flags);
+}
+
 static void dwxgmac2_update_caps(struct stmmac_priv *priv)
 {
 	if (!priv->dma_cap.mbps_10_100)
@@ -1411,6 +1425,7 @@ static void dwxgmac2_set_arp_offload(struct mac_device_info *hw, bool en,
 
 const struct stmmac_ops dwxgmac210_ops = {
 	.core_init = dwxgmac2_core_init,
+	.irq_modify = dwxgmac2_irq_modify,
 	.update_caps = dwxgmac2_update_caps,
 	.set_mac = dwxgmac2_set_mac,
 	.rx_ipc = dwxgmac2_rx_ipc,
@@ -1466,6 +1481,7 @@ static void dwxlgmac2_rx_queue_enable(struct mac_device_info *hw, u8 mode,
 
 const struct stmmac_ops dwxlgmac2_ops = {
 	.core_init = dwxgmac2_core_init,
+	.irq_modify = dwxgmac2_irq_modify,
 	.set_mac = dwxgmac2_set_mac,
 	.rx_ipc = dwxgmac2_rx_ipc,
 	.rx_queue_enable = dwxlgmac2_rx_queue_enable,
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 00083ce52549..41a7e1841227 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -333,6 +333,8 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
 	if (!mac)
 		return -ENOMEM;
 
+	spin_lock_init(&mac->irq_ctrl_lock);
+
 	/* Fallback to generic HW */
 	for (i = ARRAY_SIZE(stmmac_hw) - 1; i >= 0; i--) {
 		entry = &stmmac_hw[i];
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 82cfb6bec334..cb8fc09caf86 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -319,6 +319,8 @@ struct stmmac_ops {
 	void (*core_init)(struct mac_device_info *hw, struct net_device *dev);
 	/* Update MAC capabilities */
 	void (*update_caps)(struct stmmac_priv *priv);
+	/* Change the interrupt enable setting. Enable takes precedence. */
+	void (*irq_modify)(struct mac_device_info *hw, u32 disable, u32 enable);
 	/* Enable the MAC RX/TX */
 	void (*set_mac)(void __iomem *ioaddr, bool enable);
 	/* Enable and verify that the IPC module is supported */
@@ -421,6 +423,8 @@ struct stmmac_ops {
 	stmmac_do_void_callback(__priv, mac, core_init, __args)
 #define stmmac_mac_update_caps(__priv) \
 	stmmac_do_void_callback(__priv, mac, update_caps, __priv)
+#define stmmac_mac_irq_modify(__priv, __args...) \
+	stmmac_do_void_callback(__priv, mac, irq_modify, (__priv)->hw, __args)
 #define stmmac_mac_set(__priv, __args...) \
 	stmmac_do_void_callback(__priv, mac, set_mac, __args)
 #define stmmac_rx_ipc(__priv, __args...) \
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
index 75b470ee621a..c54c70224351 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
@@ -70,8 +70,10 @@ static void stmmac_fpe_configure_pmac(struct ethtool_mmsv *mmsv, bool pmac_enabl
 	struct stmmac_priv *priv = container_of(cfg, struct stmmac_priv, fpe_cfg);
 	const struct stmmac_fpe_reg *reg = cfg->reg;
 	void __iomem *ioaddr = priv->ioaddr;
+	unsigned long flags;
 	u32 value;
 
+	spin_lock_irqsave(&priv->hw->irq_ctrl_lock, flags);
 	value = readl(ioaddr + reg->int_en_reg);
 
 	if (pmac_enable) {
@@ -86,6 +88,7 @@ static void stmmac_fpe_configure_pmac(struct ethtool_mmsv *mmsv, bool pmac_enabl
 	}
 
 	writel(value, ioaddr + reg->int_en_reg);
+	spin_unlock_irqrestore(&priv->hw->irq_ctrl_lock, flags);
 }
 
 static void stmmac_fpe_send_mpacket(struct ethtool_mmsv *mmsv,
-- 
2.47.3


