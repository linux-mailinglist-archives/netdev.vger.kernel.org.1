Return-Path: <netdev+bounces-248211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C887BD051AE
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 18:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E109305A8E9
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 17:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902962E7BB5;
	Thu,  8 Jan 2026 17:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DkuAULP6"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1872B2D7DE3
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 17:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767893829; cv=none; b=etxk9gUdSFONNPe+f/B9jqE3NzOjf57NgiSxTEWicv8oA1HqPHFSWNA9NlGj1b+ff2mo3SWgSYKindL+r+lsOadFH7o0RAlDa8d8UTF8zTh0K2rMEu/xtFtjjd31Z7VnBnc9/wHnsdpnWh/4HWuzGDPyuDuLtqn4UBIZcxrKCuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767893829; c=relaxed/simple;
	bh=W2bCF4akBsQatFst8qXe91b1eTiWz1M/aHNesKVLy+Y=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ZjrKUp/CYiR8lbuWoVzeyPg0ShripDfbV5myNGFdiJp8F/gmo8DONSBBH4koY2C1wuMXt6Hy7x8beHUTk2RIG33uvGfCypsMtB7pb6wvz/xPh5sFAD/loLWktYyKrySHF+2s8je4aLzHlmaVdx+L1ThXbsHok/utyYSWcIewXbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DkuAULP6; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mhETl9hzqqUbV4hYLqBDIl4voUmZb8JiTro/P5SGzk0=; b=DkuAULP63UvSLt1RKoIKljWI4F
	adhS7Uw9ke8PETGbvqr6p21KOtmT8DFp4goWz0T6/nxn7xtJ1V/4LC0yhMG4hoYjCVtto8i5u5bqJ
	pGHLA7sOwaFj4i4oQp7hxSY8rH9fBkTfUL0NhCLdFU/KuWxMfLpfaQGGduRteZ59alHCcAxcJjtUe
	LVmMVXjAf6dsRh0BiY74yncc+dqzoxp+2k+Ly/+IGDUlJm4BtQ235eWl84+0P+jiYWZUoyVXCNO63
	CKaB6uJJd+DfrRC6AYnfA8obJPtecW+GGSzFJYgxohgpwPhklKLKCo2Cu4XnGGQClnGM3wBimkGp5
	t2PcHS/Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50908 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vdtwC-0000000030R-0Vsv;
	Thu, 08 Jan 2026 17:36:44 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vdtw8-00000002Gtu-0Hyu;
	Thu, 08 Jan 2026 17:36:40 +0000
In-Reply-To: <aV_q2Kneinrk3Z-W@shell.armlinux.org.uk>
References: <aV_q2Kneinrk3Z-W@shell.armlinux.org.uk>
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
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 7/9] net: stmmac: cores: remove many xxx_SHIFT
 definitions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vdtw8-00000002Gtu-0Hyu@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 08 Jan 2026 17:36:40 +0000

We have many xxx_SHIFT definitions along side their corresponding
xxx_MASK definitions for the various cores. Manually using the
shift and mask can be error prone, as shown with the dwmac4 RXFSTS
fix patch.

Convert sites that use xxx_SHIFT and xxx_MASK directly to use
FIELD_GET(), FIELD_PREP(), and u32_replace_bits() as appropriate.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
v2:
- fix missed DMA_BUS_MODE_PBL_SHIFT and DMA_BUS_MODE_RPBL_SHIFT
  usage on dwmac-loongson.c
---
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  |  5 +-
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   |  5 +-
 .../net/ethernet/stmicro/stmmac/dwmac100.h    |  9 +--
 .../net/ethernet/stmicro/stmmac/dwmac1000.h   | 16 +---
 .../ethernet/stmicro/stmmac/dwmac1000_core.c  | 21 +++---
 .../ethernet/stmicro/stmmac/dwmac1000_dma.c   | 16 ++--
 .../ethernet/stmicro/stmmac/dwmac100_core.c   |  2 +-
 .../ethernet/stmicro/stmmac/dwmac100_dma.c    |  3 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h  | 49 ++++--------
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c | 25 +++----
 .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  | 40 +++++-----
 .../net/ethernet/stmicro/stmmac/dwmac4_dma.h  | 11 +--
 .../net/ethernet/stmicro/stmmac/dwmac4_lib.c  |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac_dma.h   | 10 +--
 .../net/ethernet/stmicro/stmmac/dwmac_lib.c   | 10 +--
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    | 31 ++------
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 21 +++---
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    | 75 ++++++++-----------
 18 files changed, 129 insertions(+), 222 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 107a7c84ace8..4f2b5bd6cb31 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -192,9 +192,8 @@ static void loongson_dwmac_dma_init_channel(struct stmmac_priv *priv,
 		value |= DMA_BUS_MODE_MAXPBL;
 
 	value |= DMA_BUS_MODE_USP;
-	value &= ~(DMA_BUS_MODE_PBL_MASK | DMA_BUS_MODE_RPBL_MASK);
-	value |= (txpbl << DMA_BUS_MODE_PBL_SHIFT);
-	value |= (rxpbl << DMA_BUS_MODE_RPBL_SHIFT);
+	value = u32_replace_bits(value, txpbl, DMA_BUS_MODE_PBL_MASK);
+	value = u32_replace_bits(value, rxpbl, DMA_BUS_MODE_RPBL_MASK);
 
 	/* Set the Fixed burst mode */
 	if (dma_cfg->fixed_burst)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index a2b52d2c4eb6..4c8991f3b38d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -367,9 +367,8 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 		.use_nsecs = false,
 	};
 
-	num_snapshot = (readl(ioaddr + XGMAC_TIMESTAMP_STATUS) &
-			XGMAC_TIMESTAMP_ATSNS_MASK) >>
-			XGMAC_TIMESTAMP_ATSNS_SHIFT;
+	num_snapshot = FIELD_GET(XGMAC_TIMESTAMP_ATSNS_MASK,
+				 readl(ioaddr + XGMAC_TIMESTAMP_STATUS));
 
 	/* Repeat until the timestamps are from the FIFO last segment */
 	for (i = 0; i < num_snapshot; i++) {
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac100.h b/drivers/net/ethernet/stmicro/stmmac/dwmac100.h
index 7ab791c8d355..eae929955ad7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac100.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac100.h
@@ -59,8 +59,7 @@
 #define MAC_CORE_INIT (MAC_CONTROL_HBD)
 
 /* MAC FLOW CTRL defines */
-#define MAC_FLOW_CTRL_PT_MASK	0xffff0000	/* Pause Time Mask */
-#define MAC_FLOW_CTRL_PT_SHIFT	16
+#define MAC_FLOW_CTRL_PT_MASK	GENMASK(31, 16)	/* Pause Time Mask */
 #define MAC_FLOW_CTRL_PASS	0x00000004	/* Pass Control Frames */
 #define MAC_FLOW_CTRL_ENABLE	0x00000002	/* Flow Control Enable */
 #define MAC_FLOW_CTRL_PAUSE	0x00000001	/* Flow Control Busy ... */
@@ -76,10 +75,8 @@
 /* DMA Bus Mode register defines */
 #define DMA_BUS_MODE_DBO	0x00100000	/* Descriptor Byte Ordering */
 #define DMA_BUS_MODE_BLE	0x00000080	/* Big Endian/Little Endian */
-#define DMA_BUS_MODE_PBL_MASK	0x00003f00	/* Programmable Burst Len */
-#define DMA_BUS_MODE_PBL_SHIFT	8
-#define DMA_BUS_MODE_DSL_MASK	0x0000007c	/* Descriptor Skip Length */
-#define DMA_BUS_MODE_DSL_SHIFT	2	/*   (in DWORDS)      */
+#define DMA_BUS_MODE_PBL_MASK	GENMASK(13, 8)	/* Programmable Burst Len */
+#define DMA_BUS_MODE_DSL_MASK	GENMASK(6, 2)	/* Descriptor Skip Length */
 #define DMA_BUS_MODE_BAR_BUS	0x00000002	/* Bar-Bus Arbitration */
 #define DMA_BUS_MODE_DEFAULT	0x00000000
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h b/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
index 697bba641e05..17e013e97607 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
@@ -76,7 +76,6 @@ enum power_event {
 /* SGMII/RGMII status register */
 #define GMAC_RGSMIIIS_LNKMODE		BIT(0)
 #define GMAC_RGSMIIIS_SPEED		GENMASK(2, 1)
-#define GMAC_RGSMIIIS_SPEED_SHIFT	1
 #define GMAC_RGSMIIIS_LNKSTS		BIT(3)
 #define GMAC_RGSMIIIS_JABTO		BIT(4)
 #define GMAC_RGSMIIIS_FALSECARDET	BIT(5)
@@ -133,8 +132,7 @@ enum inter_frame_gap {
 #define GMAC_MII_ADDR_WRITE	0x00000002	/* MII Write */
 #define GMAC_MII_ADDR_BUSY	0x00000001	/* MII Busy */
 /* GMAC FLOW CTRL defines */
-#define GMAC_FLOW_CTRL_PT_MASK	0xffff0000	/* Pause Time Mask */
-#define GMAC_FLOW_CTRL_PT_SHIFT	16
+#define GMAC_FLOW_CTRL_PT_MASK	GENMASK(31, 16)	/* Pause Time Mask */
 #define GMAC_FLOW_CTRL_UP	0x00000008	/* Unicast pause frame enable */
 #define GMAC_FLOW_CTRL_RFE	0x00000004	/* Rx Flow Control Enable */
 #define GMAC_FLOW_CTRL_TFE	0x00000002	/* Tx Flow Control Enable */
@@ -147,7 +145,6 @@ enum inter_frame_gap {
 #define GMAC_DEBUG_TWCSTS	BIT(22) /* MTL Tx FIFO Write Controller */
 /* MTL Tx FIFO Read Controller Status */
 #define GMAC_DEBUG_TRCSTS_MASK	GENMASK(21, 20)
-#define GMAC_DEBUG_TRCSTS_SHIFT	20
 #define GMAC_DEBUG_TRCSTS_IDLE	0
 #define GMAC_DEBUG_TRCSTS_READ	1
 #define GMAC_DEBUG_TRCSTS_TXW	2
@@ -155,7 +152,6 @@ enum inter_frame_gap {
 #define GMAC_DEBUG_TXPAUSED	BIT(19) /* MAC Transmitter in PAUSE */
 /* MAC Transmit Frame Controller Status */
 #define GMAC_DEBUG_TFCSTS_MASK	GENMASK(18, 17)
-#define GMAC_DEBUG_TFCSTS_SHIFT	17
 #define GMAC_DEBUG_TFCSTS_IDLE	0
 #define GMAC_DEBUG_TFCSTS_WAIT	1
 #define GMAC_DEBUG_TFCSTS_GEN_PAUSE	2
@@ -163,13 +159,11 @@ enum inter_frame_gap {
 /* MAC GMII or MII Transmit Protocol Engine Status */
 #define GMAC_DEBUG_TPESTS	BIT(16)
 #define GMAC_DEBUG_RXFSTS_MASK	GENMASK(9, 8) /* MTL Rx FIFO Fill-level */
-#define GMAC_DEBUG_RXFSTS_SHIFT	8
 #define GMAC_DEBUG_RXFSTS_EMPTY	0
 #define GMAC_DEBUG_RXFSTS_BT	1
 #define GMAC_DEBUG_RXFSTS_AT	2
 #define GMAC_DEBUG_RXFSTS_FULL	3
 #define GMAC_DEBUG_RRCSTS_MASK	GENMASK(6, 5) /* MTL Rx FIFO Read Controller */
-#define GMAC_DEBUG_RRCSTS_SHIFT	5
 #define GMAC_DEBUG_RRCSTS_IDLE	0
 #define GMAC_DEBUG_RRCSTS_RDATA	1
 #define GMAC_DEBUG_RRCSTS_RSTAT	2
@@ -177,7 +171,6 @@ enum inter_frame_gap {
 #define GMAC_DEBUG_RWCSTS	BIT(4) /* MTL Rx FIFO Write Controller Active */
 /* MAC Receive Frame Controller FIFO Status */
 #define GMAC_DEBUG_RFCFCSTS_MASK	GENMASK(2, 1)
-#define GMAC_DEBUG_RFCFCSTS_SHIFT	1
 /* MAC GMII or MII Receive Protocol Engine Status */
 #define GMAC_DEBUG_RPESTS	BIT(0)
 
@@ -187,8 +180,7 @@ enum inter_frame_gap {
 #define DMA_BUS_MODE_DSL_MASK	0x0000007c	/* Descriptor Skip Length */
 #define DMA_BUS_MODE_DSL_SHIFT	2		/*   (in DWORDS)      */
 /* Programmable burst length (passed thorugh platform)*/
-#define DMA_BUS_MODE_PBL_MASK	0x00003f00	/* Programmable Burst Len */
-#define DMA_BUS_MODE_PBL_SHIFT	8
+#define DMA_BUS_MODE_PBL_MASK	GENMASK(13, 8)	/* Programmable Burst Len */
 #define DMA_BUS_MODE_ATDS	0x00000080	/* Alternate Descriptor Size */
 
 enum rx_tx_priority_ratio {
@@ -199,8 +191,7 @@ enum rx_tx_priority_ratio {
 
 #define DMA_BUS_MODE_FB		0x00010000	/* Fixed burst */
 #define DMA_BUS_MODE_MB		0x04000000	/* Mixed burst */
-#define DMA_BUS_MODE_RPBL_MASK	0x007e0000	/* Rx-Programmable Burst Len */
-#define DMA_BUS_MODE_RPBL_SHIFT	17
+#define DMA_BUS_MODE_RPBL_MASK	GENMASK(22, 17)	/* Rx-Programmable Burst Len */
 #define DMA_BUS_MODE_USP	0x00800000
 #define DMA_BUS_MODE_MAXPBL	0x01000000
 #define DMA_BUS_MODE_AAL	0x02000000
@@ -320,7 +311,6 @@ enum rtc_control {
 /* PTP and timestamping registers */
 
 #define GMAC3_X_ATSNS       GENMASK(29, 25)
-#define GMAC3_X_ATSNS_SHIFT 25
 
 #define GMAC_PTP_TCR_ATSFC	BIT(24)
 #define GMAC_PTP_TCR_ATSEN0	BIT(25)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index a2ae136d2c0e..1673a272a27e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -242,7 +242,7 @@ static void dwmac1000_flow_ctrl(struct mac_device_info *hw, unsigned int duplex,
 
 	if (duplex) {
 		pr_debug("\tduplex mode: PAUSE %d\n", pause_time);
-		flow |= (pause_time << GMAC_FLOW_CTRL_PT_SHIFT);
+		flow |= FIELD_PREP(GMAC_FLOW_CTRL_PT_MASK, pause_time);
 	}
 
 	writel(flow, ioaddr + GMAC_FLOW_CTRL);
@@ -378,8 +378,8 @@ static void dwmac1000_debug(struct stmmac_priv *priv, void __iomem *ioaddr,
 	if (value & GMAC_DEBUG_TWCSTS)
 		x->mmtl_fifo_ctrl++;
 	if (value & GMAC_DEBUG_TRCSTS_MASK) {
-		u32 trcsts = (value & GMAC_DEBUG_TRCSTS_MASK)
-			     >> GMAC_DEBUG_TRCSTS_SHIFT;
+		u32 trcsts = FIELD_GET(GMAC_DEBUG_TRCSTS_MASK, value);
+
 		if (trcsts == GMAC_DEBUG_TRCSTS_WRITE)
 			x->mtl_tx_fifo_read_ctrl_write++;
 		else if (trcsts == GMAC_DEBUG_TRCSTS_TXW)
@@ -392,8 +392,7 @@ static void dwmac1000_debug(struct stmmac_priv *priv, void __iomem *ioaddr,
 	if (value & GMAC_DEBUG_TXPAUSED)
 		x->mac_tx_in_pause++;
 	if (value & GMAC_DEBUG_TFCSTS_MASK) {
-		u32 tfcsts = (value & GMAC_DEBUG_TFCSTS_MASK)
-			      >> GMAC_DEBUG_TFCSTS_SHIFT;
+		u32 tfcsts = FIELD_GET(GMAC_DEBUG_TFCSTS_MASK, value);
 
 		if (tfcsts == GMAC_DEBUG_TFCSTS_XFER)
 			x->mac_tx_frame_ctrl_xfer++;
@@ -407,8 +406,7 @@ static void dwmac1000_debug(struct stmmac_priv *priv, void __iomem *ioaddr,
 	if (value & GMAC_DEBUG_TPESTS)
 		x->mac_gmii_tx_proto_engine++;
 	if (value & GMAC_DEBUG_RXFSTS_MASK) {
-		u32 rxfsts = (value & GMAC_DEBUG_RXFSTS_MASK)
-			     >> GMAC_DEBUG_RRCSTS_SHIFT;
+		u32 rxfsts = FIELD_GET(GMAC_DEBUG_RXFSTS_MASK, value);
 
 		if (rxfsts == GMAC_DEBUG_RXFSTS_FULL)
 			x->mtl_rx_fifo_fill_level_full++;
@@ -420,8 +418,7 @@ static void dwmac1000_debug(struct stmmac_priv *priv, void __iomem *ioaddr,
 			x->mtl_rx_fifo_fill_level_empty++;
 	}
 	if (value & GMAC_DEBUG_RRCSTS_MASK) {
-		u32 rrcsts = (value & GMAC_DEBUG_RRCSTS_MASK) >>
-			     GMAC_DEBUG_RRCSTS_SHIFT;
+		u32 rrcsts = FIELD_GET(GMAC_DEBUG_RRCSTS_MASK, value);
 
 		if (rrcsts == GMAC_DEBUG_RRCSTS_FLUSH)
 			x->mtl_rx_fifo_read_ctrl_flush++;
@@ -435,8 +432,8 @@ static void dwmac1000_debug(struct stmmac_priv *priv, void __iomem *ioaddr,
 	if (value & GMAC_DEBUG_RWCSTS)
 		x->mtl_rx_fifo_ctrl_active++;
 	if (value & GMAC_DEBUG_RFCFCSTS_MASK)
-		x->mac_rx_frame_ctrl_fifo = (value & GMAC_DEBUG_RFCFCSTS_MASK)
-					    >> GMAC_DEBUG_RFCFCSTS_SHIFT;
+		x->mac_rx_frame_ctrl_fifo = FIELD_GET(GMAC_DEBUG_RFCFCSTS_MASK,
+						      value);
 	if (value & GMAC_DEBUG_RPESTS)
 		x->mac_gmii_rx_proto_engine++;
 }
@@ -534,7 +531,7 @@ void dwmac1000_timestamp_interrupt(struct stmmac_priv *priv)
 	if (!(priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN))
 		return;
 
-	num_snapshot = (ts_status & GMAC3_X_ATSNS) >> GMAC3_X_ATSNS_SHIFT;
+	num_snapshot = FIELD_GET(GMAC3_X_ATSNS, ts_status);
 
 	for (i = 0; i < num_snapshot; i++) {
 		read_lock_irqsave(&priv->ptp_lock, flags);
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
index 5877fec9f6c3..a62f1271b6ea 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
@@ -28,13 +28,10 @@ static void dwmac1000_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
 	if (axi->axi_xit_frm)
 		value |= DMA_AXI_LPI_XIT_FRM;
 
-	value &= ~DMA_AXI_WR_OSR_LMT;
-	value |= (axi->axi_wr_osr_lmt & DMA_AXI_WR_OSR_LMT_MASK) <<
-		 DMA_AXI_WR_OSR_LMT_SHIFT;
-
-	value &= ~DMA_AXI_RD_OSR_LMT;
-	value |= (axi->axi_rd_osr_lmt & DMA_AXI_RD_OSR_LMT_MASK) <<
-		 DMA_AXI_RD_OSR_LMT_SHIFT;
+	value = u32_replace_bits(value, axi->axi_wr_osr_lmt,
+				 DMA_AXI_WR_OSR_LMT);
+	value = u32_replace_bits(value, axi->axi_rd_osr_lmt,
+				 DMA_AXI_RD_OSR_LMT);
 
 	/* Depending on the UNDEF bit the Master AXI will perform any burst
 	 * length according to the BLEN programmed (by default all BLEN are
@@ -64,9 +61,8 @@ static void dwmac1000_dma_init_channel(struct stmmac_priv *priv,
 	if (dma_cfg->pblx8)
 		value |= DMA_BUS_MODE_MAXPBL;
 	value |= DMA_BUS_MODE_USP;
-	value &= ~(DMA_BUS_MODE_PBL_MASK | DMA_BUS_MODE_RPBL_MASK);
-	value |= (txpbl << DMA_BUS_MODE_PBL_SHIFT);
-	value |= (rxpbl << DMA_BUS_MODE_RPBL_SHIFT);
+	value = u32_replace_bits(value, txpbl, DMA_BUS_MODE_PBL_MASK);
+	value = u32_replace_bits(value, rxpbl, DMA_BUS_MODE_RPBL_MASK);
 
 	/* Set the Fixed burst mode */
 	if (dma_cfg->fixed_burst)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
index 14e847c0e1a9..dbc0c1019ed5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
@@ -132,7 +132,7 @@ static void dwmac100_flow_ctrl(struct mac_device_info *hw, unsigned int duplex,
 	unsigned int flow = MAC_FLOW_CTRL_ENABLE;
 
 	if (duplex)
-		flow |= (pause_time << MAC_FLOW_CTRL_PT_SHIFT);
+		flow |= FIELD_PREP(MAC_FLOW_CTRL_PT_MASK, pause_time);
 	writel(flow, ioaddr + MAC_FLOW_CTRL);
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
index 82957db47c99..12b2bf2d739a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
@@ -22,7 +22,8 @@ static void dwmac100_dma_init(void __iomem *ioaddr,
 			      struct stmmac_dma_cfg *dma_cfg)
 {
 	/* Enable Application Access by writing to DMA CSR0 */
-	writel(DMA_BUS_MODE_DEFAULT | (dma_cfg->pbl << DMA_BUS_MODE_PBL_SHIFT),
+	writel(DMA_BUS_MODE_DEFAULT |
+	       FIELD_PREP(DMA_BUS_MODE_PBL_MASK, dma_cfg->pbl),
 	       ioaddr + DMA_BUS_MODE);
 
 	/* Mask interrupts by writing to CSR7 */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
index 3da6891b9df7..d797d936aee1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
@@ -95,7 +95,7 @@
 
 /* MAC Flow Control TX */
 #define GMAC_TX_FLOW_CTRL_TFE		BIT(1)
-#define GMAC_TX_FLOW_CTRL_PT_SHIFT	16
+#define GMAC_TX_FLOW_CTRL_PT_MASK	GENMASK(31, 16)
 
 /*  MAC Interrupt bitmap*/
 #define GMAC_INT_RGSMIIS		BIT(0)
@@ -142,23 +142,19 @@ enum power_event {
 
 /* MAC Debug bitmap */
 #define GMAC_DEBUG_TFCSTS_MASK		GENMASK(18, 17)
-#define GMAC_DEBUG_TFCSTS_SHIFT		17
 #define GMAC_DEBUG_TFCSTS_IDLE		0
 #define GMAC_DEBUG_TFCSTS_WAIT		1
 #define GMAC_DEBUG_TFCSTS_GEN_PAUSE	2
 #define GMAC_DEBUG_TFCSTS_XFER		3
 #define GMAC_DEBUG_TPESTS		BIT(16)
 #define GMAC_DEBUG_RFCFCSTS_MASK	GENMASK(2, 1)
-#define GMAC_DEBUG_RFCFCSTS_SHIFT	1
 #define GMAC_DEBUG_RPESTS		BIT(0)
 
 /* MAC config */
 #define GMAC_CONFIG_ARPEN		BIT(31)
 #define GMAC_CONFIG_SARC		GENMASK(30, 28)
-#define GMAC_CONFIG_SARC_SHIFT		28
 #define GMAC_CONFIG_IPC			BIT(27)
 #define GMAC_CONFIG_IPG			GENMASK(26, 24)
-#define GMAC_CONFIG_IPG_SHIFT		24
 #define GMAC_CONFIG_2K			BIT(22)
 #define GMAC_CONFIG_ACS			BIT(20)
 #define GMAC_CONFIG_BE			BIT(18)
@@ -166,7 +162,6 @@ enum power_event {
 #define GMAC_CONFIG_JE			BIT(16)
 #define GMAC_CONFIG_PS			BIT(15)
 #define GMAC_CONFIG_FES			BIT(14)
-#define GMAC_CONFIG_FES_SHIFT		14
 #define GMAC_CONFIG_DM			BIT(13)
 #define GMAC_CONFIG_LM			BIT(12)
 #define GMAC_CONFIG_DCRS		BIT(9)
@@ -175,11 +170,9 @@ enum power_event {
 
 /* MAC extended config */
 #define GMAC_CONFIG_EIPG		GENMASK(29, 25)
-#define GMAC_CONFIG_EIPG_SHIFT		25
 #define GMAC_CONFIG_EIPG_EN		BIT(24)
 #define GMAC_CONFIG_HDSMS		GENMASK(22, 20)
-#define GMAC_CONFIG_HDSMS_SHIFT		20
-#define GMAC_CONFIG_HDSMS_256		(0x2 << GMAC_CONFIG_HDSMS_SHIFT)
+#define GMAC_CONFIG_HDSMS_256		FIELD_PREP_CONST(GMAC_CONFIG_HDSMS, 0x2)
 
 /* MAC HW features0 bitmap */
 #define GMAC_HW_FEAT_SAVLANINS		BIT(27)
@@ -242,7 +235,6 @@ enum power_event {
 
 /* MAC HW ADDR regs */
 #define GMAC_HI_DCS			GENMASK(18, 16)
-#define GMAC_HI_DCS_SHIFT		16
 #define GMAC_HI_REG_AE			BIT(31)
 
 /* L3/L4 Filters regs */
@@ -257,7 +249,6 @@ enum power_event {
 #define GMAC_L3SAM0			BIT(2)
 #define GMAC_L3PEN0			BIT(0)
 #define GMAC_L4DP0			GENMASK(31, 16)
-#define GMAC_L4DP0_SHIFT		16
 #define GMAC_L4SP0			GENMASK(15, 0)
 
 /* MAC Timestamp Status */
@@ -314,39 +305,32 @@ static inline u32 mtl_chanx_base_addr(const struct dwmac4_addrs *addrs,
 #define MTL_OP_MODE_TSF			BIT(1)
 
 #define MTL_OP_MODE_TQS_MASK		GENMASK(24, 16)
-#define MTL_OP_MODE_TQS_SHIFT		16
 
-#define MTL_OP_MODE_TTC_MASK		0x70
-#define MTL_OP_MODE_TTC_SHIFT		4
-
-#define MTL_OP_MODE_TTC_32		0
-#define MTL_OP_MODE_TTC_64		(1 << MTL_OP_MODE_TTC_SHIFT)
-#define MTL_OP_MODE_TTC_96		(2 << MTL_OP_MODE_TTC_SHIFT)
-#define MTL_OP_MODE_TTC_128		(3 << MTL_OP_MODE_TTC_SHIFT)
-#define MTL_OP_MODE_TTC_192		(4 << MTL_OP_MODE_TTC_SHIFT)
-#define MTL_OP_MODE_TTC_256		(5 << MTL_OP_MODE_TTC_SHIFT)
-#define MTL_OP_MODE_TTC_384		(6 << MTL_OP_MODE_TTC_SHIFT)
-#define MTL_OP_MODE_TTC_512		(7 << MTL_OP_MODE_TTC_SHIFT)
+#define MTL_OP_MODE_TTC_MASK		GENMASK(6, 4)
+#define MTL_OP_MODE_TTC_32		FIELD_PREP(MTL_OP_MODE_TTC_MASK, 0)
+#define MTL_OP_MODE_TTC_64		FIELD_PREP(MTL_OP_MODE_TTC_MASK, 1)
+#define MTL_OP_MODE_TTC_96		FIELD_PREP(MTL_OP_MODE_TTC_MASK, 2)
+#define MTL_OP_MODE_TTC_128		FIELD_PREP(MTL_OP_MODE_TTC_MASK, 3)
+#define MTL_OP_MODE_TTC_192		FIELD_PREP(MTL_OP_MODE_TTC_MASK, 4)
+#define MTL_OP_MODE_TTC_256		FIELD_PREP(MTL_OP_MODE_TTC_MASK, 5)
+#define MTL_OP_MODE_TTC_384		FIELD_PREP(MTL_OP_MODE_TTC_MASK, 6)
+#define MTL_OP_MODE_TTC_512		FIELD_PREP(MTL_OP_MODE_TTC_MASK, 7)
 
 #define MTL_OP_MODE_RQS_MASK		GENMASK(29, 20)
-#define MTL_OP_MODE_RQS_SHIFT		20
 
 #define MTL_OP_MODE_RFD_MASK		GENMASK(19, 14)
-#define MTL_OP_MODE_RFD_SHIFT		14
 
 #define MTL_OP_MODE_RFA_MASK		GENMASK(13, 8)
-#define MTL_OP_MODE_RFA_SHIFT		8
 
 #define MTL_OP_MODE_EHFC		BIT(7)
 #define MTL_OP_MODE_DIS_TCP_EF		BIT(6)
 
 #define MTL_OP_MODE_RTC_MASK		GENMASK(1, 0)
-#define MTL_OP_MODE_RTC_SHIFT		0
 
-#define MTL_OP_MODE_RTC_32		(1 << MTL_OP_MODE_RTC_SHIFT)
-#define MTL_OP_MODE_RTC_64		0
-#define MTL_OP_MODE_RTC_96		(2 << MTL_OP_MODE_RTC_SHIFT)
-#define MTL_OP_MODE_RTC_128		(3 << MTL_OP_MODE_RTC_SHIFT)
+#define MTL_OP_MODE_RTC_32		FIELD_PREP(MTL_OP_MODE_RTC_MASK, 1)
+#define MTL_OP_MODE_RTC_64		FIELD_PREP(MTL_OP_MODE_RTC_MASK, 0)
+#define MTL_OP_MODE_RTC_96		FIELD_PREP(MTL_OP_MODE_RTC_MASK, 2)
+#define MTL_OP_MODE_RTC_128		FIELD_PREP(MTL_OP_MODE_RTC_MASK, 3)
 
 /* MTL ETS Control register */
 #define MTL_ETS_CTRL_BASE_ADDR		0x00000d10
@@ -451,7 +435,6 @@ static inline u32 mtl_low_credx_base_addr(const struct dwmac4_addrs *addrs,
 
 /* MTL debug: Tx FIFO Read Controller Status */
 #define MTL_DEBUG_TRCSTS_MASK		GENMASK(2, 1)
-#define MTL_DEBUG_TRCSTS_SHIFT		1
 #define MTL_DEBUG_TRCSTS_IDLE		0
 #define MTL_DEBUG_TRCSTS_READ		1
 #define MTL_DEBUG_TRCSTS_TXW		2
@@ -465,7 +448,6 @@ static inline u32 mtl_low_credx_base_addr(const struct dwmac4_addrs *addrs,
 #define MTL_DEBUG_RXFSTS_AT		2
 #define MTL_DEBUG_RXFSTS_FULL		3
 #define MTL_DEBUG_RRCSTS_MASK		GENMASK(2, 1)
-#define MTL_DEBUG_RRCSTS_SHIFT		1
 #define MTL_DEBUG_RRCSTS_IDLE		0
 #define MTL_DEBUG_RRCSTS_RDATA		1
 #define MTL_DEBUG_RRCSTS_RSTAT		2
@@ -490,7 +472,6 @@ static inline u32 mtl_low_credx_base_addr(const struct dwmac4_addrs *addrs,
 #define GMAC_PHYIF_CTRLSTATUS_SMIDRXS		BIT(4)
 #define GMAC_PHYIF_CTRLSTATUS_LNKMOD		BIT(16)
 #define GMAC_PHYIF_CTRLSTATUS_SPEED		GENMASK(18, 17)
-#define GMAC_PHYIF_CTRLSTATUS_SPEED_SHIFT	17
 #define GMAC_PHYIF_CTRLSTATUS_LNKSTS		BIT(19)
 #define GMAC_PHYIF_CTRLSTATUS_JABTO		BIT(20)
 #define GMAC_PHYIF_CTRLSTATUS_FALSECARDET	BIT(21)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index bd5f48d0b9fc..2176039dd8af 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -572,8 +572,8 @@ static void dwmac4_flow_ctrl(struct mac_device_info *hw, unsigned int duplex,
 			flow = GMAC_TX_FLOW_CTRL_TFE;
 
 			if (duplex)
-				flow |=
-				(pause_time << GMAC_TX_FLOW_CTRL_PT_SHIFT);
+				flow |= FIELD_PREP(GMAC_TX_FLOW_CTRL_PT_MASK,
+						   pause_time);
 
 			writel(flow, ioaddr + GMAC_QX_TX_FLOW_CTRL(queue));
 		}
@@ -681,8 +681,8 @@ static void dwmac4_debug(struct stmmac_priv *priv, void __iomem *ioaddr,
 		if (value & MTL_DEBUG_TWCSTS)
 			x->mmtl_fifo_ctrl++;
 		if (value & MTL_DEBUG_TRCSTS_MASK) {
-			u32 trcsts = (value & MTL_DEBUG_TRCSTS_MASK)
-				     >> MTL_DEBUG_TRCSTS_SHIFT;
+			u32 trcsts = FIELD_GET(MTL_DEBUG_TRCSTS_MASK, value);
+
 			if (trcsts == MTL_DEBUG_TRCSTS_WRITE)
 				x->mtl_tx_fifo_read_ctrl_write++;
 			else if (trcsts == MTL_DEBUG_TRCSTS_TXW)
@@ -712,8 +712,7 @@ static void dwmac4_debug(struct stmmac_priv *priv, void __iomem *ioaddr,
 				x->mtl_rx_fifo_fill_level_empty++;
 		}
 		if (value & MTL_DEBUG_RRCSTS_MASK) {
-			u32 rrcsts = (value & MTL_DEBUG_RRCSTS_MASK) >>
-				     MTL_DEBUG_RRCSTS_SHIFT;
+			u32 rrcsts = FIELD_GET(MTL_DEBUG_RRCSTS_MASK, value);
 
 			if (rrcsts == MTL_DEBUG_RRCSTS_FLUSH)
 				x->mtl_rx_fifo_read_ctrl_flush++;
@@ -732,8 +731,7 @@ static void dwmac4_debug(struct stmmac_priv *priv, void __iomem *ioaddr,
 	value = readl(ioaddr + GMAC_DEBUG);
 
 	if (value & GMAC_DEBUG_TFCSTS_MASK) {
-		u32 tfcsts = (value & GMAC_DEBUG_TFCSTS_MASK)
-			      >> GMAC_DEBUG_TFCSTS_SHIFT;
+		u32 tfcsts = FIELD_GET(GMAC_DEBUG_TFCSTS_MASK, value);
 
 		if (tfcsts == GMAC_DEBUG_TFCSTS_XFER)
 			x->mac_tx_frame_ctrl_xfer++;
@@ -747,8 +745,8 @@ static void dwmac4_debug(struct stmmac_priv *priv, void __iomem *ioaddr,
 	if (value & GMAC_DEBUG_TPESTS)
 		x->mac_gmii_tx_proto_engine++;
 	if (value & GMAC_DEBUG_RFCFCSTS_MASK)
-		x->mac_rx_frame_ctrl_fifo = (value & GMAC_DEBUG_RFCFCSTS_MASK)
-					    >> GMAC_DEBUG_RFCFCSTS_SHIFT;
+		x->mac_rx_frame_ctrl_fifo = FIELD_GET(GMAC_DEBUG_RFCFCSTS_MASK,
+						      value);
 	if (value & GMAC_DEBUG_RPESTS)
 		x->mac_gmii_rx_proto_engine++;
 }
@@ -769,8 +767,7 @@ static void dwmac4_sarc_configure(void __iomem *ioaddr, int val)
 {
 	u32 value = readl(ioaddr + GMAC_CONFIG);
 
-	value &= ~GMAC_CONFIG_SARC;
-	value |= val << GMAC_CONFIG_SARC_SHIFT;
+	value = u32_replace_bits(value, val, GMAC_CONFIG_SARC);
 
 	writel(value, ioaddr + GMAC_CONFIG);
 }
@@ -878,9 +875,9 @@ static int dwmac4_config_l4_filter(struct mac_device_info *hw, u32 filter_no,
 	writel(value, ioaddr + GMAC_L3L4_CTRL(filter_no));
 
 	if (sa) {
-		value = match & GMAC_L4SP0;
+		value = FIELD_PREP(GMAC_L4SP0, match);
 	} else {
-		value = (match << GMAC_L4DP0_SHIFT) & GMAC_L4DP0;
+		value = FIELD_PREP(GMAC_L4DP0, match);
 	}
 
 	writel(value, ioaddr + GMAC_L4_ADDR(filter_no));
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
index 7b513324cfb0..7036beccfc85 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
@@ -27,13 +27,10 @@ static void dwmac4_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
 	if (axi->axi_xit_frm)
 		value |= DMA_AXI_LPI_XIT_FRM;
 
-	value &= ~DMA_AXI_WR_OSR_LMT;
-	value |= (axi->axi_wr_osr_lmt & DMA_AXI_OSR_MAX) <<
-		 DMA_AXI_WR_OSR_LMT_SHIFT;
-
-	value &= ~DMA_AXI_RD_OSR_LMT;
-	value |= (axi->axi_rd_osr_lmt & DMA_AXI_OSR_MAX) <<
-		 DMA_AXI_RD_OSR_LMT_SHIFT;
+	value = u32_replace_bits(value, axi->axi_wr_osr_lmt,
+				 DMA_AXI_WR_OSR_LMT);
+	value = u32_replace_bits(value, axi->axi_rd_osr_lmt,
+				 DMA_AXI_RD_OSR_LMT);
 
 	/* Depending on the UNDEF bit the Master AXI will perform any burst
 	 * length according to the BLEN programmed (by default all BLEN are
@@ -55,7 +52,7 @@ static void dwmac4_dma_init_rx_chan(struct stmmac_priv *priv,
 	u32 rxpbl = dma_cfg->rxpbl ?: dma_cfg->pbl;
 
 	value = readl(ioaddr + DMA_CHAN_RX_CONTROL(dwmac4_addrs, chan));
-	value = value | (rxpbl << DMA_BUS_MODE_RPBL_SHIFT);
+	value = value | FIELD_PREP(DMA_BUS_MODE_RPBL_MASK, rxpbl);
 	writel(value, ioaddr + DMA_CHAN_RX_CONTROL(dwmac4_addrs, chan));
 
 	if (IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT) && likely(dma_cfg->eame))
@@ -76,7 +73,7 @@ static void dwmac4_dma_init_tx_chan(struct stmmac_priv *priv,
 	u32 txpbl = dma_cfg->txpbl ?: dma_cfg->pbl;
 
 	value = readl(ioaddr + DMA_CHAN_TX_CONTROL(dwmac4_addrs, chan));
-	value = value | (txpbl << DMA_BUS_MODE_PBL_SHIFT);
+	value = value | FIELD_PREP(DMA_BUS_MODE_PBL, txpbl);
 
 	/* Enable OSP to get best performance */
 	value |= DMA_CONTROL_OSP;
@@ -151,10 +148,9 @@ static void dwmac4_dma_init(void __iomem *ioaddr,
 
 	value = readl(ioaddr + DMA_BUS_MODE);
 
-	if (dma_cfg->multi_msi_en) {
-		value &= ~DMA_BUS_MODE_INTM_MASK;
-		value |= (DMA_BUS_MODE_INTM_MODE1 << DMA_BUS_MODE_INTM_SHIFT);
-	}
+	if (dma_cfg->multi_msi_en)
+		value = u32_replace_bits(value, DMA_BUS_MODE_INTM_MODE1,
+					 DMA_BUS_MODE_INTM_MASK);
 
 	if (dma_cfg->dche)
 		value |= DMA_BUS_MODE_DCHE;
@@ -264,7 +260,7 @@ static void dwmac4_dma_rx_chan_op_mode(struct stmmac_priv *priv,
 	}
 
 	mtl_rx_op &= ~MTL_OP_MODE_RQS_MASK;
-	mtl_rx_op |= rqs << MTL_OP_MODE_RQS_SHIFT;
+	mtl_rx_op |= FIELD_PREP(MTL_OP_MODE_RQS_MASK, rqs);
 
 	/* Enable flow control only if each channel gets 4 KiB or more FIFO and
 	 * only if channel is not an AVB channel.
@@ -295,11 +291,10 @@ static void dwmac4_dma_rx_chan_op_mode(struct stmmac_priv *priv,
 			break;
 		}
 
-		mtl_rx_op &= ~MTL_OP_MODE_RFD_MASK;
-		mtl_rx_op |= rfd << MTL_OP_MODE_RFD_SHIFT;
-
-		mtl_rx_op &= ~MTL_OP_MODE_RFA_MASK;
-		mtl_rx_op |= rfa << MTL_OP_MODE_RFA_SHIFT;
+		mtl_rx_op = u32_replace_bits(mtl_rx_op, rfd,
+					     MTL_OP_MODE_RFD_MASK);
+		mtl_rx_op = u32_replace_bits(mtl_rx_op, rfa,
+					     MTL_OP_MODE_RFA_MASK);
 	}
 
 	writel(mtl_rx_op, ioaddr + MTL_CHAN_RX_OP_MODE(dwmac4_addrs, channel));
@@ -354,8 +349,8 @@ static void dwmac4_dma_tx_chan_op_mode(struct stmmac_priv *priv,
 		mtl_tx_op |= MTL_OP_MODE_TXQEN;
 	else
 		mtl_tx_op |= MTL_OP_MODE_TXQEN_AV;
-	mtl_tx_op &= ~MTL_OP_MODE_TQS_MASK;
-	mtl_tx_op |= tqs << MTL_OP_MODE_TQS_SHIFT;
+
+	mtl_tx_op = u32_replace_bits(mtl_tx_op, tqs, MTL_OP_MODE_TQS_MASK);
 
 	writel(mtl_tx_op, ioaddr +  MTL_CHAN_TX_OP_MODE(dwmac4_addrs, channel));
 }
@@ -496,8 +491,7 @@ static void dwmac4_set_bfsize(struct stmmac_priv *priv, void __iomem *ioaddr,
 	const struct dwmac4_addrs *dwmac4_addrs = priv->plat->dwmac4_addrs;
 	u32 value = readl(ioaddr + DMA_CHAN_RX_CONTROL(dwmac4_addrs, chan));
 
-	value &= ~DMA_RBSZ_MASK;
-	value |= (bfsize << DMA_RBSZ_SHIFT) & DMA_RBSZ_MASK;
+	value = u32_replace_bits(value, bfsize, DMA_RBSZ_MASK);
 
 	writel(value, ioaddr + DMA_CHAN_RX_CONTROL(dwmac4_addrs, chan));
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
index f27126f05551..42d93cafe7b6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
@@ -27,15 +27,13 @@
 /* DMA Bus Mode bitmap */
 #define DMA_BUS_MODE_DCHE		BIT(19)
 #define DMA_BUS_MODE_INTM_MASK		GENMASK(17, 16)
-#define DMA_BUS_MODE_INTM_SHIFT		16
 #define DMA_BUS_MODE_INTM_MODE1		0x1
 #define DMA_BUS_MODE_SFT_RESET		BIT(0)
 
 /* DMA SYS Bus Mode bitmap */
 #define DMA_BUS_MODE_SPH		BIT(24)
 #define DMA_BUS_MODE_PBL		BIT(16)
-#define DMA_BUS_MODE_PBL_SHIFT		16
-#define DMA_BUS_MODE_RPBL_SHIFT		16
+#define DMA_BUS_MODE_RPBL_MASK		GENMASK(21, 16)
 #define DMA_BUS_MODE_MB			BIT(14)
 #define DMA_BUS_MODE_FB			BIT(0)
 
@@ -59,13 +57,7 @@
 #define DMA_AXI_EN_LPI			BIT(31)
 #define DMA_AXI_LPI_XIT_FRM		BIT(30)
 #define DMA_AXI_WR_OSR_LMT		GENMASK(27, 24)
-#define DMA_AXI_WR_OSR_LMT_SHIFT	24
 #define DMA_AXI_RD_OSR_LMT		GENMASK(19, 16)
-#define DMA_AXI_RD_OSR_LMT_SHIFT	16
-
-#define DMA_AXI_OSR_MAX			0xf
-#define DMA_AXI_MAX_OSR_LIMIT ((DMA_AXI_OSR_MAX << DMA_AXI_WR_OSR_LMT_SHIFT) | \
-				(DMA_AXI_OSR_MAX << DMA_AXI_RD_OSR_LMT_SHIFT))
 
 #define DMA_SYS_BUS_MB			BIT(14)
 #define DMA_AXI_1KBBE			BIT(13)
@@ -137,7 +129,6 @@ static inline u32 dma_chanx_base_addr(const struct dwmac4_addrs *addrs,
 /* DMA Rx Channel X Control register defines */
 #define DMA_CONTROL_SR			BIT(0)
 #define DMA_RBSZ_MASK			GENMASK(14, 1)
-#define DMA_RBSZ_SHIFT			1
 
 /* Interrupt status per channel */
 #define DMA_CHAN_STATUS_REB		GENMASK(21, 19)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
index 57c03d491774..c098047a3bff 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
@@ -234,7 +234,7 @@ void stmmac_dwmac4_set_mac_addr(void __iomem *ioaddr, const u8 addr[6],
 	 * bit that has no effect on the High Reg 0 where the bit 31 (MO)
 	 * is RO.
 	 */
-	data |= (STMMAC_CHAN0 << GMAC_HI_DCS_SHIFT);
+	data |= FIELD_PREP(GMAC_HI_DCS, STMMAC_CHAN0);
 	writel(data | GMAC_HI_REG_AE, ioaddr + high);
 	data = (addr[3] << 24) | (addr[2] << 16) | (addr[1] << 8) | addr[0];
 	writel(data, ioaddr + low);
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
index 054ecb20ce3f..0b379987d3af 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
@@ -59,11 +59,7 @@ static inline u32 dma_chan_base_addr(u32 base, u32 chan)
 #define DMA_AXI_EN_LPI		BIT(31)
 #define DMA_AXI_LPI_XIT_FRM	BIT(30)
 #define DMA_AXI_WR_OSR_LMT	GENMASK(23, 20)
-#define DMA_AXI_WR_OSR_LMT_SHIFT	20
-#define DMA_AXI_WR_OSR_LMT_MASK	0xf
 #define DMA_AXI_RD_OSR_LMT	GENMASK(19, 16)
-#define DMA_AXI_RD_OSR_LMT_SHIFT	16
-#define DMA_AXI_RD_OSR_LMT_MASK	0xf
 
 #define DMA_AXI_OSR_MAX		0xf
 #define DMA_AXI_MAX_OSR_LIMIT ((DMA_AXI_OSR_MAX << DMA_AXI_WR_OSR_LMT_SHIFT) | \
@@ -123,10 +119,8 @@ static inline u32 dma_chan_base_addr(u32 base, u32 chan)
 #define DMA_STATUS_EB_MASK	0x00380000	/* Error Bits Mask */
 #define DMA_STATUS_EB_TX_ABORT	0x00080000	/* Error Bits - TX Abort */
 #define DMA_STATUS_EB_RX_ABORT	0x00100000	/* Error Bits - RX Abort */
-#define DMA_STATUS_TS_MASK	0x00700000	/* Transmit Process State */
-#define DMA_STATUS_TS_SHIFT	20
-#define DMA_STATUS_RS_MASK	0x000e0000	/* Receive Process State */
-#define DMA_STATUS_RS_SHIFT	17
+#define DMA_STATUS_TS_MASK	GENMASK(22, 20)	/* Transmit Process State */
+#define DMA_STATUS_RS_MASK	GENMASK(19, 17)	/* Receive Process State */
 #define DMA_STATUS_NIS	0x00010000	/* Normal Interrupt Summary */
 #define DMA_STATUS_AIS	0x00008000	/* Abnormal Interrupt Summary */
 #define DMA_STATUS_ERI	0x00004000	/* Early Receive Interrupt */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
index 97a803d68e3a..a0383f9486c2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
@@ -97,10 +97,7 @@ void dwmac_dma_stop_rx(struct stmmac_priv *priv, void __iomem *ioaddr, u32 chan)
 #ifdef DWMAC_DMA_DEBUG
 static void show_tx_process_state(unsigned int status)
 {
-	unsigned int state;
-	state = (status & DMA_STATUS_TS_MASK) >> DMA_STATUS_TS_SHIFT;
-
-	switch (state) {
+	switch (FIELD_GET(DMA_STATUS_TS_MASK, status)) {
 	case 0:
 		pr_debug("- TX (Stopped): Reset or Stop command\n");
 		break;
@@ -128,10 +125,7 @@ static void show_tx_process_state(unsigned int status)
 
 static void show_rx_process_state(unsigned int status)
 {
-	unsigned int state;
-	state = (status & DMA_STATUS_RS_MASK) >> DMA_STATUS_RS_SHIFT;
-
-	switch (state) {
+	switch (FIELD_GET(DMA_STATUS_RS_MASK, status)) {
 	case 0:
 		pr_debug("- RX (Stopped): Reset or Stop command\n");
 		break;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index b07d99a3df1b..b5c91c109c43 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -24,17 +24,15 @@
 #define XGMAC_CONFIG_SS_2500		(0x6 << XGMAC_CONFIG_SS_OFF)
 #define XGMAC_CONFIG_SS_10_MII		(0x7 << XGMAC_CONFIG_SS_OFF)
 #define XGMAC_CONFIG_SARC		GENMASK(22, 20)
-#define XGMAC_CONFIG_SARC_SHIFT		20
 #define XGMAC_CONFIG_JD			BIT(16)
 #define XGMAC_CONFIG_TE			BIT(0)
 #define XGMAC_CORE_INIT_TX		(XGMAC_CONFIG_JD)
 #define XGMAC_RX_CONFIG			0x00000004
 #define XGMAC_CONFIG_ARPEN		BIT(31)
 #define XGMAC_CONFIG_GPSL		GENMASK(29, 16)
-#define XGMAC_CONFIG_GPSL_SHIFT		16
 #define XGMAC_CONFIG_HDSMS		GENMASK(14, 12)
 #define XGMAC_CONFIG_HDSMS_SHIFT	12
-#define XGMAC_CONFIG_HDSMS_256		(0x2 << XGMAC_CONFIG_HDSMS_SHIFT)
+#define XGMAC_CONFIG_HDSMS_256		FIELD_PREP(XGMAC_CONFIG_HDSMS, 0x2)
 #define XGMAC_CONFIG_S2KP		BIT(11)
 #define XGMAC_CONFIG_LM			BIT(10)
 #define XGMAC_CONFIG_IPC		BIT(9)
@@ -44,8 +42,10 @@
 #define XGMAC_CONFIG_CST		BIT(2)
 #define XGMAC_CONFIG_ACS		BIT(1)
 #define XGMAC_CONFIG_RE			BIT(0)
-#define XGMAC_CORE_INIT_RX		(XGMAC_CONFIG_GPSLCE | XGMAC_CONFIG_WD | \
-					 (XGMAC_JUMBO_LEN << XGMAC_CONFIG_GPSL_SHIFT))
+#define XGMAC_CORE_INIT_RX		(XGMAC_CONFIG_GPSLCE | \
+					 XGMAC_CONFIG_WD | \
+					 FIELD_PREP(XGMAC_CONFIG_GPSL, \
+						    XGMAC_JUMBO_LEN))
 #define XGMAC_PACKET_FILTER		0x00000008
 #define XGMAC_FILTER_RA			BIT(31)
 #define XGMAC_FILTER_IPFE		BIT(20)
@@ -90,7 +90,6 @@
 #define XGMAC_INT_DEFAULT_EN		(XGMAC_LPIIE | XGMAC_PMTIE)
 #define XGMAC_Qx_TX_FLOW_CTRL(x)	(0x00000070 + (x) * 4)
 #define XGMAC_PT			GENMASK(31, 16)
-#define XGMAC_PT_SHIFT			16
 #define XGMAC_TFE			BIT(1)
 #define XGMAC_RX_FLOW_CTRL		0x00000090
 #define XGMAC_RFE			BIT(0)
@@ -180,12 +179,11 @@
 #define XGMAC_ADDR_MAX			32
 #define XGMAC_AE			BIT(31)
 #define XGMAC_DCS			GENMASK(19, 16)
-#define XGMAC_DCS_SHIFT			16
 #define XGMAC_ADDRx_LOW(x)		(0x00000304 + (x) * 0x8)
 #define XGMAC_L3L4_ADDR_CTRL		0x00000c00
 #define XGMAC_IDDR			GENMASK(16, 8)
-#define XGMAC_IDDR_SHIFT		8
-#define XGMAC_IDDR_FNUM			4
+#define XGMAC_IDDR_FNUM_MASK		GENMASK(7, 4)	/* FNUM within IDDR */
+#define XGMAC_IDDR_REG_MASK		GENMASK(3, 0)	/* REG within IDDR */
 #define XGMAC_TT			BIT(1)
 #define XGMAC_XB			BIT(0)
 #define XGMAC_L3L4_DATA			0x00000c04
@@ -204,7 +202,6 @@
 #define XGMAC_L3PEN0			BIT(0)
 #define XGMAC_L4_ADDR			0x1
 #define XGMAC_L4DP0			GENMASK(31, 16)
-#define XGMAC_L4DP0_SHIFT		16
 #define XGMAC_L4SP0			GENMASK(15, 0)
 #define XGMAC_L3_ADDR0			0x4
 #define XGMAC_L3_ADDR1			0x5
@@ -224,7 +221,6 @@
 #define XGMAC_RSS_DATA			0x00000c8c
 #define XGMAC_TIMESTAMP_STATUS		0x00000d20
 #define XGMAC_TIMESTAMP_ATSNS_MASK	GENMASK(29, 25)
-#define XGMAC_TIMESTAMP_ATSNS_SHIFT	25
 #define XGMAC_TXTSC			BIT(15)
 #define XGMAC_TXTIMESTAMP_NSEC		0x00000d30
 #define XGMAC_TXTSSTSLO			GENMASK(30, 0)
@@ -290,13 +286,9 @@
 #define XGMAC_DPP_DISABLE		BIT(0)
 #define XGMAC_MTL_TXQ_OPMODE(x)		(0x00001100 + (0x80 * (x)))
 #define XGMAC_TQS			GENMASK(25, 16)
-#define XGMAC_TQS_SHIFT			16
 #define XGMAC_Q2TCMAP			GENMASK(10, 8)
-#define XGMAC_Q2TCMAP_SHIFT		8
 #define XGMAC_TTC			GENMASK(6, 4)
-#define XGMAC_TTC_SHIFT			4
 #define XGMAC_TXQEN			GENMASK(3, 2)
-#define XGMAC_TXQEN_SHIFT		2
 #define XGMAC_TSF			BIT(1)
 #define XGMAC_MTL_TCx_ETS_CONTROL(x)	(0x00001110 + (0x80 * (x)))
 #define XGMAC_MTL_TCx_QUANTUM_WEIGHT(x)	(0x00001118 + (0x80 * (x)))
@@ -310,16 +302,12 @@
 #define XGMAC_ETS			(0x2 << 0)
 #define XGMAC_MTL_RXQ_OPMODE(x)		(0x00001140 + (0x80 * (x)))
 #define XGMAC_RQS			GENMASK(25, 16)
-#define XGMAC_RQS_SHIFT			16
 #define XGMAC_EHFC			BIT(7)
 #define XGMAC_RSF			BIT(5)
 #define XGMAC_RTC			GENMASK(1, 0)
-#define XGMAC_RTC_SHIFT			0
 #define XGMAC_MTL_RXQ_FLOW_CONTROL(x)	(0x00001150 + (0x80 * (x)))
 #define XGMAC_RFD			GENMASK(31, 17)
-#define XGMAC_RFD_SHIFT			17
 #define XGMAC_RFA			GENMASK(15, 1)
-#define XGMAC_RFA_SHIFT			1
 #define XGMAC_MTL_QINTEN(x)		(0x00001170 + (0x80 * (x)))
 #define XGMAC_RXOIE			BIT(16)
 #define XGMAC_MTL_QINT_STATUS(x)	(0x00001174 + (0x80 * (x)))
@@ -333,9 +321,7 @@
 #define XGMAC_SWR			BIT(0)
 #define XGMAC_DMA_SYSBUS_MODE		0x00003004
 #define XGMAC_WR_OSR_LMT		GENMASK(29, 24)
-#define XGMAC_WR_OSR_LMT_SHIFT		24
 #define XGMAC_RD_OSR_LMT		GENMASK(21, 16)
-#define XGMAC_RD_OSR_LMT_SHIFT		16
 #define XGMAC_EN_LPI			BIT(15)
 #define XGMAC_LPI_XIT_PKT		BIT(14)
 #define XGMAC_AAL			DMA_AXI_AAL
@@ -370,15 +356,12 @@
 #define XGMAC_DMA_CH_TX_CONTROL(x)	(0x00003104 + (0x80 * (x)))
 #define XGMAC_EDSE			BIT(28)
 #define XGMAC_TxPBL			GENMASK(21, 16)
-#define XGMAC_TxPBL_SHIFT		16
 #define XGMAC_TSE			BIT(12)
 #define XGMAC_OSP			BIT(4)
 #define XGMAC_TXST			BIT(0)
 #define XGMAC_DMA_CH_RX_CONTROL(x)	(0x00003108 + (0x80 * (x)))
 #define XGMAC_RxPBL			GENMASK(21, 16)
-#define XGMAC_RxPBL_SHIFT		16
 #define XGMAC_RBSZ			GENMASK(14, 1)
-#define XGMAC_RBSZ_SHIFT		1
 #define XGMAC_RXST			BIT(0)
 #define XGMAC_DMA_CH_TxDESC_HADDR(x)	(0x00003110 + (0x80 * (x)))
 #define XGMAC_DMA_CH_TxDESC_LADDR(x)	(0x00003114 + (0x80 * (x)))
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index b40b3ea50e25..311ff9753ac8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -369,7 +369,7 @@ static void dwxgmac2_flow_ctrl(struct mac_device_info *hw, unsigned int duplex,
 			u32 value = XGMAC_TFE;
 
 			if (duplex)
-				value |= pause_time << XGMAC_PT_SHIFT;
+				value |= FIELD_PREP(XGMAC_PT, pause_time);
 
 			writel(value, ioaddr + XGMAC_Qx_TX_FLOW_CTRL(i));
 		}
@@ -1226,8 +1226,7 @@ static void dwxgmac2_sarc_configure(void __iomem *ioaddr, int val)
 {
 	u32 value = readl(ioaddr + XGMAC_TX_CONFIG);
 
-	value &= ~XGMAC_CONFIG_SARC;
-	value |= val << XGMAC_CONFIG_SARC_SHIFT;
+	value = u32_replace_bits(value, val, XGMAC_CONFIG_SARC);
 
 	writel(value, ioaddr + XGMAC_TX_CONFIG);
 }
@@ -1247,14 +1246,16 @@ static int dwxgmac2_filter_read(struct mac_device_info *hw, u32 filter_no,
 				u8 reg, u32 *data)
 {
 	void __iomem *ioaddr = hw->pcsr;
-	u32 value;
+	u32 value, iddr;
 	int ret;
 
 	ret = dwxgmac2_filter_wait(hw);
 	if (ret)
 		return ret;
 
-	value = ((filter_no << XGMAC_IDDR_FNUM) | reg) << XGMAC_IDDR_SHIFT;
+	iddr = FIELD_PREP(XGMAC_IDDR_FNUM_MASK, filter_no) |
+	       FIELD_PREP(XGMAC_IDDR_REG_MASK, reg);
+	value = FIELD_PREP(XGMAC_IDDR, iddr);
 	value |= XGMAC_TT | XGMAC_XB;
 	writel(value, ioaddr + XGMAC_L3L4_ADDR_CTRL);
 
@@ -1270,7 +1271,7 @@ static int dwxgmac2_filter_write(struct mac_device_info *hw, u32 filter_no,
 				 u8 reg, u32 data)
 {
 	void __iomem *ioaddr = hw->pcsr;
-	u32 value;
+	u32 value, iddr;
 	int ret;
 
 	ret = dwxgmac2_filter_wait(hw);
@@ -1279,7 +1280,9 @@ static int dwxgmac2_filter_write(struct mac_device_info *hw, u32 filter_no,
 
 	writel(data, ioaddr + XGMAC_L3L4_DATA);
 
-	value = ((filter_no << XGMAC_IDDR_FNUM) | reg) << XGMAC_IDDR_SHIFT;
+	iddr = FIELD_PREP(XGMAC_IDDR_FNUM_MASK, filter_no) |
+	       FIELD_PREP(XGMAC_IDDR_REG_MASK, reg);
+	value = FIELD_PREP(XGMAC_IDDR, iddr);
 	value |= XGMAC_XB;
 	writel(value, ioaddr + XGMAC_L3L4_ADDR_CTRL);
 
@@ -1388,13 +1391,13 @@ static int dwxgmac2_config_l4_filter(struct mac_device_info *hw, u32 filter_no,
 		return ret;
 
 	if (sa) {
-		value = match & XGMAC_L4SP0;
+		value = FIELD_PREP(XGMAC_L4SP0, match);
 
 		ret = dwxgmac2_filter_write(hw, filter_no, XGMAC_L4_ADDR, value);
 		if (ret)
 			return ret;
 	} else {
-		value = (match << XGMAC_L4DP0_SHIFT) & XGMAC_L4DP0;
+		value = FIELD_PREP(XGMAC_L4DP0, match);
 
 		ret = dwxgmac2_filter_write(hw, filter_no, XGMAC_L4_ADDR, value);
 		if (ret)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index cc1bdc0975d5..9bb547f3c3c9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -55,8 +55,7 @@ static void dwxgmac2_dma_init_rx_chan(struct stmmac_priv *priv,
 	u32 value;
 
 	value = readl(ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
-	value &= ~XGMAC_RxPBL;
-	value |= (rxpbl << XGMAC_RxPBL_SHIFT) & XGMAC_RxPBL;
+	value = u32_replace_bits(value, rxpbl, XGMAC_RxPBL);
 	writel(value, ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
 
 	writel(upper_32_bits(phy), ioaddr + XGMAC_DMA_CH_RxDESC_HADDR(chan));
@@ -72,9 +71,7 @@ static void dwxgmac2_dma_init_tx_chan(struct stmmac_priv *priv,
 	u32 value;
 
 	value = readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
-	value &= ~XGMAC_TxPBL;
-	value |= (txpbl << XGMAC_TxPBL_SHIFT) & XGMAC_TxPBL;
-	value |= XGMAC_OSP;
+	value = u32_replace_bits(value, txpbl, XGMAC_TxPBL);
 	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
 
 	writel(upper_32_bits(phy), ioaddr + XGMAC_DMA_CH_TxDESC_HADDR(chan));
@@ -90,13 +87,8 @@ static void dwxgmac2_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
 	if (axi->axi_xit_frm)
 		value |= XGMAC_LPI_XIT_PKT;
 
-	value &= ~XGMAC_WR_OSR_LMT;
-	value |= (axi->axi_wr_osr_lmt << XGMAC_WR_OSR_LMT_SHIFT) &
-		XGMAC_WR_OSR_LMT;
-
-	value &= ~XGMAC_RD_OSR_LMT;
-	value |= (axi->axi_rd_osr_lmt << XGMAC_RD_OSR_LMT_SHIFT) &
-		XGMAC_RD_OSR_LMT;
+	value = u32_replace_bits(value, axi->axi_wr_osr_lmt, XGMAC_WR_OSR_LMT);
+	value = u32_replace_bits(value, axi->axi_rd_osr_lmt, XGMAC_RD_OSR_LMT);
 
 	if (!axi->axi_fb)
 		value |= XGMAC_UNDEF;
@@ -127,23 +119,24 @@ static void dwxgmac2_dma_rx_mode(struct stmmac_priv *priv, void __iomem *ioaddr,
 {
 	u32 value = readl(ioaddr + XGMAC_MTL_RXQ_OPMODE(channel));
 	unsigned int rqs = fifosz / 256 - 1;
+	unsigned int rtc;
 
 	if (mode == SF_DMA_MODE) {
 		value |= XGMAC_RSF;
 	} else {
 		value &= ~XGMAC_RSF;
-		value &= ~XGMAC_RTC;
 
 		if (mode <= 64)
-			value |= 0x0 << XGMAC_RTC_SHIFT;
+			rtc = 0x0;
 		else if (mode <= 96)
-			value |= 0x2 << XGMAC_RTC_SHIFT;
+			rtc = 0x2;
 		else
-			value |= 0x3 << XGMAC_RTC_SHIFT;
+			rtc = 0x3;
+
+		value = u32_replace_bits(value, rtc, XGMAC_RTC);
 	}
 
-	value &= ~XGMAC_RQS;
-	value |= (rqs << XGMAC_RQS_SHIFT) & XGMAC_RQS;
+	value = u32_replace_bits(value, rqs, XGMAC_RQS);
 
 	if ((fifosz >= 4096) && (qmode != MTL_QUEUE_AVB)) {
 		u32 flow = readl(ioaddr + XGMAC_MTL_RXQ_FLOW_CONTROL(channel));
@@ -172,11 +165,8 @@ static void dwxgmac2_dma_rx_mode(struct stmmac_priv *priv, void __iomem *ioaddr,
 			break;
 		}
 
-		flow &= ~XGMAC_RFD;
-		flow |= rfd << XGMAC_RFD_SHIFT;
-
-		flow &= ~XGMAC_RFA;
-		flow |= rfa << XGMAC_RFA_SHIFT;
+		flow = u32_replace_bits(flow, rfd, XGMAC_RFD);
+		flow = u32_replace_bits(flow, rfa, XGMAC_RFA);
 
 		writel(flow, ioaddr + XGMAC_MTL_RXQ_FLOW_CONTROL(channel));
 	}
@@ -189,40 +179,41 @@ static void dwxgmac2_dma_tx_mode(struct stmmac_priv *priv, void __iomem *ioaddr,
 {
 	u32 value = readl(ioaddr + XGMAC_MTL_TXQ_OPMODE(channel));
 	unsigned int tqs = fifosz / 256 - 1;
+	unsigned int ttc, txqen;
 
 	if (mode == SF_DMA_MODE) {
 		value |= XGMAC_TSF;
 	} else {
 		value &= ~XGMAC_TSF;
-		value &= ~XGMAC_TTC;
 
 		if (mode <= 64)
-			value |= 0x0 << XGMAC_TTC_SHIFT;
+			ttc = 0x0;
 		else if (mode <= 96)
-			value |= 0x2 << XGMAC_TTC_SHIFT;
+			ttc = 0x2;
 		else if (mode <= 128)
-			value |= 0x3 << XGMAC_TTC_SHIFT;
+			ttc = 0x3;
 		else if (mode <= 192)
-			value |= 0x4 << XGMAC_TTC_SHIFT;
+			ttc = 0x4;
 		else if (mode <= 256)
-			value |= 0x5 << XGMAC_TTC_SHIFT;
+			ttc = 0x5;
 		else if (mode <= 384)
-			value |= 0x6 << XGMAC_TTC_SHIFT;
+			ttc = 0x6;
 		else
-			value |= 0x7 << XGMAC_TTC_SHIFT;
+			ttc = 0x7;
+
+		value = u32_replace_bits(value, ttc, XGMAC_TTC);
 	}
 
 	/* Use static TC to Queue mapping */
-	value |= (channel << XGMAC_Q2TCMAP_SHIFT) & XGMAC_Q2TCMAP;
+	value |= FIELD_PREP(XGMAC_Q2TCMAP, channel);
 
-	value &= ~XGMAC_TXQEN;
 	if (qmode != MTL_QUEUE_AVB)
-		value |= 0x2 << XGMAC_TXQEN_SHIFT;
+		txqen = 0x2;
 	else
-		value |= 0x1 << XGMAC_TXQEN_SHIFT;
+		txqen = 0x1;
 
-	value &= ~XGMAC_TQS;
-	value |= (tqs << XGMAC_TQS_SHIFT) & XGMAC_TQS;
+	value = u32_replace_bits(value, txqen, XGMAC_TXQEN);
+	value = u32_replace_bits(value, tqs, XGMAC_TQS);
 
 	writel(value, ioaddr +  XGMAC_MTL_TXQ_OPMODE(channel));
 }
@@ -526,16 +517,17 @@ static void dwxgmac2_qmode(struct stmmac_priv *priv, void __iomem *ioaddr,
 {
 	u32 value = readl(ioaddr + XGMAC_MTL_TXQ_OPMODE(channel));
 	u32 flow = readl(ioaddr + XGMAC_RX_FLOW_CTRL);
+	unsigned int txqen;
 
-	value &= ~XGMAC_TXQEN;
 	if (qmode != MTL_QUEUE_AVB) {
-		value |= 0x2 << XGMAC_TXQEN_SHIFT;
+		txqen = 0x2;
 		writel(0, ioaddr + XGMAC_MTL_TCx_ETS_CONTROL(channel));
 	} else {
-		value |= 0x1 << XGMAC_TXQEN_SHIFT;
+		txqen = 0x1;
 		writel(flow & (~XGMAC_RFE), ioaddr + XGMAC_RX_FLOW_CTRL);
 	}
 
+	value = u32_replace_bits(value, txqen, XGMAC_TXQEN);
 	writel(value, ioaddr +  XGMAC_MTL_TXQ_OPMODE(channel));
 }
 
@@ -545,8 +537,7 @@ static void dwxgmac2_set_bfsize(struct stmmac_priv *priv, void __iomem *ioaddr,
 	u32 value;
 
 	value = readl(ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
-	value &= ~XGMAC_RBSZ;
-	value |= bfsize << XGMAC_RBSZ_SHIFT;
+	value = u32_replace_bits(value, bfsize, XGMAC_RBSZ);
 	writel(value, ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
 }
 
-- 
2.47.3


