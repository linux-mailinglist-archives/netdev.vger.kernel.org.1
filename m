Return-Path: <netdev+bounces-161372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A07DA20D88
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A13683A7EE6
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 15:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8A41D47B4;
	Tue, 28 Jan 2025 15:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="I+fOel8a"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882BB1D5AAD
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 15:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738079284; cv=none; b=cK4MfCYLKA2OMgEaUnqEZ2vil3P6h7YTywsE/YmCasdRId1VH9V5GSlHqTYBxEh1NiX3ipWexbwqT9no7U7PvBdl6oDuvjhccaYgvPen/ej8DQrkmKWo2fLfk7JDPMVMuafhdWH1C0bumb4wIBLYyXAMW/KQDPjky/Pp+g4TDJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738079284; c=relaxed/simple;
	bh=CuMhmakQHhGdT+HpG2EpR2kiIpdkwsmsjF2TCnjBiiQ=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=j3LjDcRAEzWnKWNPadNiD7TTWdBrDSncSqDhzC47cWakuM7k/iLRRlh6vZiCvL1tyh7MRXIaQqrA7CQgmghR0A23U5OP+hDQLP91MXOlPMZwY8H7RWmsuiz5Xkb+czTOvgecROhTXa0UZ9KR8G/6WWRvLAWP6Vca3CGoMiqZg7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=I+fOel8a; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TekHCCUHCmCERxcU/o0a7msZFaeEFOla/9UtzyX7LR4=; b=I+fOel8aDuz+i6VE549Bd8OkCh
	/K3qCJi8eJ75D2jN69DhjrYWXMsGpZnxEG+cXstAL8qIQ5hyGO16RgifA3qbzdjdOCLLidQCFLzla
	MBZ03Psq5uaoKIxBA70gc5WOrVrVRFCssUx3NwVehjwbouwQgUIvoGOgQsuP46Odt9oWWVbzVNOX6
	rS2vXySdxMwbC64L/K8/JacUemnMKGxU7p+Mk8YAp1wTZpEiMODMCqYk6XZ04KniIRna3y90u3Mjo
	ua5YxEhmNc516LeKgEoByIH5eNwjPz6CjaDOA04hxVh2vFXGRGJ2Au0gbSfvvLQhDehWzsEYNe4By
	MuaK/dqA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42464 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tcnoh-0007VL-1C;
	Tue, 28 Jan 2025 15:47:55 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tcnoO-0037H0-1n; Tue, 28 Jan 2025 15:47:36 +0000
In-Reply-To: <Z5j7yCYSsQ7beznD@shell.armlinux.org.uk>
References: <Z5j7yCYSsQ7beznD@shell.armlinux.org.uk>
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
	Paolo Abeni <pabeni@redhat.com>,
	 Vladimir Oltean <olteanv@gmail.com>,
	 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH RFC net-next 10/22] net: stmmac: use common LPI_CTRL_STATUS
 bit definitions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tcnoO-0037H0-1n@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 28 Jan 2025 15:47:36 +0000

The bit definitions for the LPI control/status register are
identical across all MAC versions, with the exception that some
bits may not be implemented. Provide definitions for bits in this
register in common.h, convert to use them, and remove the core-
specific definitions.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/common.h  | 14 ++++++++++
 .../net/ethernet/stmicro/stmmac/dwmac1000.h   | 13 +--------
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h  | 12 +-------
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c | 28 +++++++++----------
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  9 +-----
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 18 ++++++------
 6 files changed, 40 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index e25db747a81a..55053528e498 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -530,6 +530,20 @@ struct dma_features {
 #define STMMAC_DEFAULT_TWT_LS	0x1E
 #define STMMAC_ET_MAX		0xFFFFF
 
+/* Common LPI register bits */
+#define LPI_CTRL_STATUS_LPITCSE	BIT(21)	/* LPI Tx Clock Stop Enable, gmac4, xgmac2 only */
+#define LPI_CTRL_STATUS_LPIATE	BIT(20)	/* LPI Timer Enable, gmac4 only */
+#define LPI_CTRL_STATUS_LPITXA	BIT(19)	/* Enable LPI TX Automate */
+#define LPI_CTRL_STATUS_PLSEN	BIT(18)	/* Enable PHY Link Status */
+#define LPI_CTRL_STATUS_PLS	BIT(17)	/* PHY Link Status */
+#define LPI_CTRL_STATUS_LPIEN	BIT(16)	/* LPI Enable */
+#define LPI_CTRL_STATUS_RLPIST	BIT(9)	/* Receive LPI state, gmac1000 only? */
+#define LPI_CTRL_STATUS_TLPIST	BIT(8)	/* Transmit LPI state, gmac1000 only? */
+#define LPI_CTRL_STATUS_RLPIEX	BIT(3)	/* Receive LPI Exit */
+#define LPI_CTRL_STATUS_RLPIEN	BIT(2)	/* Receive LPI Entry */
+#define LPI_CTRL_STATUS_TLPIEX	BIT(1)	/* Transmit LPI Exit */
+#define LPI_CTRL_STATUS_TLPIEN	BIT(0)	/* Transmit LPI Entry */
+
 #define STMMAC_CHAIN_MODE	0x1
 #define STMMAC_RING_MODE	0x2
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h b/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
index 600fea8f712f..967a16212faf 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
@@ -59,22 +59,11 @@ enum power_event {
 /* Energy Efficient Ethernet (EEE)
  *
  * LPI status, timer and control register offset
+ * For LPI control and status bit definitions, see common.h.
  */
 #define LPI_CTRL_STATUS	0x0030
 #define LPI_TIMER_CTRL	0x0034
 
-/* LPI control and status defines */
-#define LPI_CTRL_STATUS_LPITXA	0x00080000	/* Enable LPI TX Automate */
-#define LPI_CTRL_STATUS_PLSEN	0x00040000	/* Enable PHY Link Status */
-#define LPI_CTRL_STATUS_PLS	0x00020000	/* PHY Link Status */
-#define LPI_CTRL_STATUS_LPIEN	0x00010000	/* LPI Enable */
-#define LPI_CTRL_STATUS_RLPIST	0x00000200	/* Receive LPI state */
-#define LPI_CTRL_STATUS_TLPIST	0x00000100	/* Transmit LPI state */
-#define LPI_CTRL_STATUS_RLPIEX	0x00000008	/* Receive LPI Exit */
-#define LPI_CTRL_STATUS_RLPIEN	0x00000004	/* Receive LPI Entry */
-#define LPI_CTRL_STATUS_TLPIEX	0x00000002	/* Transmit LPI Exit */
-#define LPI_CTRL_STATUS_TLPIEN	0x00000001	/* Transmit LPI Entry */
-
 /* GMAC HW ADDR regs */
 #define GMAC_ADDR_HIGH(reg)	((reg > 15) ? 0x00000800 + (reg - 16) * 8 : \
 				 0x00000040 + (reg * 8))
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
index 184d41a306af..42fe29a4e300 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
@@ -177,23 +177,13 @@ enum power_event {
 /* Energy Efficient Ethernet (EEE) for GMAC4
  *
  * LPI status, timer and control register offset
+ * For LPI control and status bit definitions, see common.h.
  */
 #define GMAC4_LPI_CTRL_STATUS	0xd0
 #define GMAC4_LPI_TIMER_CTRL	0xd4
 #define GMAC4_LPI_ENTRY_TIMER	0xd8
 #define GMAC4_MAC_ONEUS_TIC_COUNTER	0xdc
 
-/* LPI control and status defines */
-#define GMAC4_LPI_CTRL_STATUS_LPITCSE	BIT(21)	/* LPI Tx Clock Stop Enable */
-#define GMAC4_LPI_CTRL_STATUS_LPIATE	BIT(20) /* LPI Timer Enable */
-#define GMAC4_LPI_CTRL_STATUS_LPITXA	BIT(19)	/* Enable LPI TX Automate */
-#define GMAC4_LPI_CTRL_STATUS_PLS	BIT(17) /* PHY Link Status */
-#define GMAC4_LPI_CTRL_STATUS_LPIEN	BIT(16)	/* LPI Enable */
-#define GMAC4_LPI_CTRL_STATUS_RLPIEX	BIT(3) /* Receive LPI Exit */
-#define GMAC4_LPI_CTRL_STATUS_RLPIEN	BIT(2) /* Receive LPI Entry */
-#define GMAC4_LPI_CTRL_STATUS_TLPIEX	BIT(1) /* Transmit LPI Exit */
-#define GMAC4_LPI_CTRL_STATUS_TLPIEN	BIT(0) /* Transmit LPI Entry */
-
 /* MAC Debug bitmap */
 #define GMAC_DEBUG_TFCSTS_MASK		GENMASK(18, 17)
 #define GMAC_DEBUG_TFCSTS_SHIFT		17
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 17bf836eba7f..c324aaf691e0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -387,11 +387,11 @@ static void dwmac4_set_eee_mode(struct mac_device_info *hw,
 	 * state.
 	 */
 	value = readl(ioaddr + GMAC4_LPI_CTRL_STATUS);
-	value &= ~GMAC4_LPI_CTRL_STATUS_LPIATE;
-	value |= GMAC4_LPI_CTRL_STATUS_LPIEN | GMAC4_LPI_CTRL_STATUS_LPITXA;
+	value &= ~LPI_CTRL_STATUS_LPIATE;
+	value |= LPI_CTRL_STATUS_LPIEN | LPI_CTRL_STATUS_LPITXA;
 
 	if (en_tx_lpi_clockgating)
-		value |= GMAC4_LPI_CTRL_STATUS_LPITCSE;
+		value |= LPI_CTRL_STATUS_LPITCSE;
 
 	writel(value, ioaddr + GMAC4_LPI_CTRL_STATUS);
 }
@@ -402,8 +402,8 @@ static void dwmac4_reset_eee_mode(struct mac_device_info *hw)
 	u32 value;
 
 	value = readl(ioaddr + GMAC4_LPI_CTRL_STATUS);
-	value &= ~(GMAC4_LPI_CTRL_STATUS_LPIATE | GMAC4_LPI_CTRL_STATUS_LPIEN |
-		   GMAC4_LPI_CTRL_STATUS_LPITXA);
+	value &= ~(LPI_CTRL_STATUS_LPIATE | LPI_CTRL_STATUS_LPIEN |
+		   LPI_CTRL_STATUS_LPITXA);
 	writel(value, ioaddr + GMAC4_LPI_CTRL_STATUS);
 }
 
@@ -415,9 +415,9 @@ static void dwmac4_set_eee_pls(struct mac_device_info *hw, int link)
 	value = readl(ioaddr + GMAC4_LPI_CTRL_STATUS);
 
 	if (link)
-		value |= GMAC4_LPI_CTRL_STATUS_PLS;
+		value |= LPI_CTRL_STATUS_PLS;
 	else
-		value &= ~GMAC4_LPI_CTRL_STATUS_PLS;
+		value &= ~LPI_CTRL_STATUS_PLS;
 
 	writel(value, ioaddr + GMAC4_LPI_CTRL_STATUS);
 }
@@ -433,12 +433,12 @@ static void dwmac4_set_eee_lpi_entry_timer(struct mac_device_info *hw, u32 et)
 
 	/* Enable/disable LPI entry timer */
 	regval = readl(ioaddr + GMAC4_LPI_CTRL_STATUS);
-	regval |= GMAC4_LPI_CTRL_STATUS_LPIEN | GMAC4_LPI_CTRL_STATUS_LPITXA;
+	regval |= LPI_CTRL_STATUS_LPIEN | LPI_CTRL_STATUS_LPITXA;
 
 	if (et)
-		regval |= GMAC4_LPI_CTRL_STATUS_LPIATE;
+		regval |= LPI_CTRL_STATUS_LPIATE;
 	else
-		regval &= ~GMAC4_LPI_CTRL_STATUS_LPIATE;
+		regval &= ~LPI_CTRL_STATUS_LPIATE;
 
 	writel(regval, ioaddr + GMAC4_LPI_CTRL_STATUS);
 }
@@ -851,17 +851,17 @@ static int dwmac4_irq_status(struct mac_device_info *hw,
 		/* Clear LPI interrupt by reading MAC_LPI_Control_Status */
 		u32 status = readl(ioaddr + GMAC4_LPI_CTRL_STATUS);
 
-		if (status & GMAC4_LPI_CTRL_STATUS_TLPIEN) {
+		if (status & LPI_CTRL_STATUS_TLPIEN) {
 			ret |= CORE_IRQ_TX_PATH_IN_LPI_MODE;
 			x->irq_tx_path_in_lpi_mode_n++;
 		}
-		if (status & GMAC4_LPI_CTRL_STATUS_TLPIEX) {
+		if (status & LPI_CTRL_STATUS_TLPIEX) {
 			ret |= CORE_IRQ_TX_PATH_EXIT_LPI_MODE;
 			x->irq_tx_path_exit_lpi_mode_n++;
 		}
-		if (status & GMAC4_LPI_CTRL_STATUS_RLPIEN)
+		if (status & LPI_CTRL_STATUS_RLPIEN)
 			x->irq_rx_path_in_lpi_mode_n++;
-		if (status & GMAC4_LPI_CTRL_STATUS_RLPIEX)
+		if (status & LPI_CTRL_STATUS_RLPIEX)
 			x->irq_rx_path_exit_lpi_mode_n++;
 	}
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 20027d3c25a7..a03f5d771566 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -112,14 +112,7 @@
 #define XGMAC_MGKPKTEN			BIT(1)
 #define XGMAC_PWRDWN			BIT(0)
 #define XGMAC_LPI_CTRL			0x000000d0
-#define XGMAC_TXCGE			BIT(21)
-#define XGMAC_LPITXA			BIT(19)
-#define XGMAC_PLS			BIT(17)
-#define XGMAC_LPITXEN			BIT(16)
-#define XGMAC_RLPIEX			BIT(3)
-#define XGMAC_RLPIEN			BIT(2)
-#define XGMAC_TLPIEX			BIT(1)
-#define XGMAC_TLPIEN			BIT(0)
+/* For definitions, see LPI_CTRL_STATUS_xxx in common.h */
 #define XGMAC_LPI_TIMER_CTRL		0x000000d4
 #define XGMAC_HW_FEATURE0		0x0000011c
 #define XGMAC_HWFEAT_EDMA		BIT(31)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 9a60a6e8f633..19cfb1dcb332 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -316,17 +316,17 @@ static int dwxgmac2_host_irq_status(struct mac_device_info *hw,
 	if (stat & XGMAC_LPIIS) {
 		u32 lpi = readl(ioaddr + XGMAC_LPI_CTRL);
 
-		if (lpi & XGMAC_TLPIEN) {
+		if (lpi & LPI_CTRL_STATUS_TLPIEN) {
 			ret |= CORE_IRQ_TX_PATH_IN_LPI_MODE;
 			x->irq_tx_path_in_lpi_mode_n++;
 		}
-		if (lpi & XGMAC_TLPIEX) {
+		if (lpi & LPI_CTRL_STATUS_TLPIEX) {
 			ret |= CORE_IRQ_TX_PATH_EXIT_LPI_MODE;
 			x->irq_tx_path_exit_lpi_mode_n++;
 		}
-		if (lpi & XGMAC_RLPIEN)
+		if (lpi & LPI_CTRL_STATUS_RLPIEN)
 			x->irq_rx_path_in_lpi_mode_n++;
-		if (lpi & XGMAC_RLPIEX)
+		if (lpi & LPI_CTRL_STATUS_RLPIEX)
 			x->irq_rx_path_exit_lpi_mode_n++;
 	}
 
@@ -433,9 +433,9 @@ static void dwxgmac2_set_eee_mode(struct mac_device_info *hw,
 
 	value = readl(ioaddr + XGMAC_LPI_CTRL);
 
-	value |= XGMAC_LPITXEN | XGMAC_LPITXA;
+	value |= LPI_CTRL_STATUS_LPIEN | LPI_CTRL_STATUS_LPITXA;
 	if (en_tx_lpi_clockgating)
-		value |= XGMAC_TXCGE;
+		value |= LPI_CTRL_STATUS_LPITCSE;
 
 	writel(value, ioaddr + XGMAC_LPI_CTRL);
 }
@@ -446,7 +446,7 @@ static void dwxgmac2_reset_eee_mode(struct mac_device_info *hw)
 	u32 value;
 
 	value = readl(ioaddr + XGMAC_LPI_CTRL);
-	value &= ~(XGMAC_LPITXEN | XGMAC_LPITXA | XGMAC_TXCGE);
+	value &= ~(LPI_CTRL_STATUS_LPIEN | LPI_CTRL_STATUS_LPITXA | LPI_CTRL_STATUS_LPITCSE);
 	writel(value, ioaddr + XGMAC_LPI_CTRL);
 }
 
@@ -457,9 +457,9 @@ static void dwxgmac2_set_eee_pls(struct mac_device_info *hw, int link)
 
 	value = readl(ioaddr + XGMAC_LPI_CTRL);
 	if (link)
-		value |= XGMAC_PLS;
+		value |= LPI_CTRL_STATUS_PLS;
 	else
-		value &= ~XGMAC_PLS;
+		value &= ~LPI_CTRL_STATUS_PLS;
 	writel(value, ioaddr + XGMAC_LPI_CTRL);
 }
 
-- 
2.30.2


