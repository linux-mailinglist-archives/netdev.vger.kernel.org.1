Return-Path: <netdev+bounces-247466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 589E1CFAEF7
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 21:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D3463053791
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 20:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C807311C33;
	Tue,  6 Jan 2026 20:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bTIZW19x"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEA223EAAB
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 20:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767731542; cv=none; b=sKb7uzzr1wUp5fWzS0ZSEJElhvfRvhiXOS5ANas+Mz4CvNNct/05WZ6khvvt5LudaFIQ+3s58btAMj1O50s9fUtKQTT52vgzSe91iE5dizsRgfpD3OaDuhYs7C8N9ynh9F8iCToNXBgIh9BgoNme83Dmd/EVcUFKyxd86cQybj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767731542; c=relaxed/simple;
	bh=yuCe6KIZWXOmhUNaglbcFADADegmZscHJo4Y81rqThk=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=TBcmvhS0O4E89luebvDb31UXN67v3UKkNUJgeB0p4rF6Lt30z3oopMecZz2r+V0WjgzxBha2vZvWyYxJhBSzMUDSpA18815uVOA1I6qKLa+fDTnv7UBCnh0PaFzodZvoX/SrIS0qtABXcehF+nxCb8lWrchYao+I4+VDOQJ7mBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=bTIZW19x; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YdT3N2oZEWNvD9jCGylkO4u0eoIHm0bt3IdBBOUs5bo=; b=bTIZW19xBACjEWsK64PDav8YYq
	/3lW/NjsyO72sotI2xpHjZA1Ya5n9Ky9AlrYTWraw8rdpv/brrDG3orw83VwXsdDZX41qzjJTLK7Y
	STIToY6U8vgRLS6uWA1lIIfqVnLv/SvvATBJyzeQk9mU1/yz3fsU+95O0R9qGItEFJ2eHZAKB7Af1
	PhZd64YXYff+IEV0ndZ1wZRShBzpbZfKzIJZlNXEOWkBDKxgI0nNsEQF1XIlI/6ynkjz5/zTalCXb
	Z5RxiBm+LDDDJjSwT2KeiXYIC6PErPy9/x9wuHz++t68GuIL+EM3t4F6Lyou9i8Xu6yhOOow9ZFDV
	JqsihQGg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:33440 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vdDie-0000000012Z-2S7Y;
	Tue, 06 Jan 2026 20:31:56 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vdDia-00000002E22-1Vd1;
	Tue, 06 Jan 2026 20:31:52 +0000
In-Reply-To: <aV1w9yxPwL990yZJ@shell.armlinux.org.uk>
References: <aV1w9yxPwL990yZJ@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 8/9] net: stmmac: arrange register fields after
 register offsets
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vdDia-00000002E22-1Vd1@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 06 Jan 2026 20:31:52 +0000

Arrange the register fields to be after their corresponding register
offset definitions, which groups all the definitions for a register
together.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac4_dma.h  | 137 +++++++-------
 .../net/ethernet/stmicro/stmmac/dwmac_dma.h   | 169 +++++++++---------
 2 files changed, 154 insertions(+), 152 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
index 42d93cafe7b6..e8f103cb6cd5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
@@ -16,28 +16,22 @@
 #define DMA_CHANNEL_NB_MAX		1
 
 #define DMA_BUS_MODE			0x00001000
-#define DMA_SYS_BUS_MODE		0x00001004
-#define DMA_STATUS			0x00001008
-#define DMA_DEBUG_STATUS_0		0x0000100c
-#define DMA_DEBUG_STATUS_1		0x00001010
-#define DMA_DEBUG_STATUS_2		0x00001014
-#define DMA_AXI_BUS_MODE		0x00001028
-#define DMA_TBS_CTRL			0x00001050
 
-/* DMA Bus Mode bitmap */
 #define DMA_BUS_MODE_DCHE		BIT(19)
 #define DMA_BUS_MODE_INTM_MASK		GENMASK(17, 16)
 #define DMA_BUS_MODE_INTM_MODE1		0x1
 #define DMA_BUS_MODE_SFT_RESET		BIT(0)
 
-/* DMA SYS Bus Mode bitmap */
+#define DMA_SYS_BUS_MODE		0x00001004
+
 #define DMA_BUS_MODE_SPH		BIT(24)
 #define DMA_BUS_MODE_PBL		BIT(16)
 #define DMA_BUS_MODE_RPBL_MASK		GENMASK(21, 16)
 #define DMA_BUS_MODE_MB			BIT(14)
 #define DMA_BUS_MODE_FB			BIT(0)
 
-/* DMA Interrupt top status */
+#define DMA_STATUS			0x00001008
+
 #define DMA_STATUS_MAC			BIT(17)
 #define DMA_STATUS_MTL			BIT(16)
 #define DMA_STATUS_CHAN7		BIT(7)
@@ -49,11 +43,15 @@
 #define DMA_STATUS_CHAN1		BIT(1)
 #define DMA_STATUS_CHAN0		BIT(0)
 
-/* DMA debug status bitmap */
+#define DMA_DEBUG_STATUS_0		0x0000100c
+#define DMA_DEBUG_STATUS_1		0x00001010
+#define DMA_DEBUG_STATUS_2		0x00001014
+
 #define DMA_DEBUG_STATUS_TS_MASK	0xf
 #define DMA_DEBUG_STATUS_RS_MASK	0xf
 
-/* DMA AXI bitmap */
+#define DMA_AXI_BUS_MODE		0x00001028
+
 #define DMA_AXI_EN_LPI			BIT(31)
 #define DMA_AXI_LPI_XIT_FRM		BIT(30)
 #define DMA_AXI_WR_OSR_LMT		GENMASK(27, 24)
@@ -70,7 +68,8 @@
 					DMA_AXI_BLEN16 | DMA_AXI_BLEN8 | \
 					DMA_AXI_BLEN4)
 
-/* DMA TBS Control */
+#define DMA_TBS_CTRL			0x00001050
+
 #define DMA_TBS_FTOS			GENMASK(31, 8)
 #define DMA_TBS_FTOV			BIT(0)
 #define DMA_TBS_DEF_FTOS		(DMA_TBS_FTOS | DMA_TBS_FTOV)
@@ -95,8 +94,22 @@ static inline u32 dma_chanx_base_addr(const struct dwmac4_addrs *addrs,
 #define DMA_CHAN_REG_NUMBER		17
 
 #define DMA_CHAN_CONTROL(addrs, x)	dma_chanx_base_addr(addrs, x)
+
+#define DMA_CONTROL_SPH			BIT(24)
+#define DMA_CONTROL_MSS_MASK		GENMASK(13, 0)
+
 #define DMA_CHAN_TX_CONTROL(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x4)
+
+#define DMA_CONTROL_EDSE		BIT(28)
+#define DMA_CONTROL_TSE			BIT(12)
+#define DMA_CONTROL_OSP			BIT(4)
+#define DMA_CONTROL_ST			BIT(0)
+
 #define DMA_CHAN_RX_CONTROL(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x8)
+
+#define DMA_CONTROL_SR			BIT(0)
+#define DMA_RBSZ_MASK			GENMASK(14, 1)
+
 #define DMA_CHAN_TX_BASE_ADDR_HI(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x10)
 #define DMA_CHAN_TX_BASE_ADDR(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x14)
 #define DMA_CHAN_RX_BASE_ADDR_HI(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x18)
@@ -105,7 +118,49 @@ static inline u32 dma_chanx_base_addr(const struct dwmac4_addrs *addrs,
 #define DMA_CHAN_RX_END_ADDR(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x28)
 #define DMA_CHAN_TX_RING_LEN(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x2c)
 #define DMA_CHAN_RX_RING_LEN(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x30)
+
 #define DMA_CHAN_INTR_ENA(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x34)
+
+#define DMA_CHAN_INTR_ENA_NIE		BIT(16)
+#define DMA_CHAN_INTR_ENA_AIE		BIT(15)
+#define DMA_CHAN_INTR_ENA_NIE_4_10	BIT(15)
+#define DMA_CHAN_INTR_ENA_AIE_4_10	BIT(14)
+#define DMA_CHAN_INTR_ENA_CDE		BIT(13)
+#define DMA_CHAN_INTR_ENA_FBE		BIT(12)
+#define DMA_CHAN_INTR_ENA_ERE		BIT(11)
+#define DMA_CHAN_INTR_ENA_ETE		BIT(10)
+#define DMA_CHAN_INTR_ENA_RWE		BIT(9)
+#define DMA_CHAN_INTR_ENA_RSE		BIT(8)
+#define DMA_CHAN_INTR_ENA_RBUE		BIT(7)
+#define DMA_CHAN_INTR_ENA_RIE		BIT(6)
+#define DMA_CHAN_INTR_ENA_TBUE		BIT(2)
+#define DMA_CHAN_INTR_ENA_TSE		BIT(1)
+#define DMA_CHAN_INTR_ENA_TIE		BIT(0)
+
+#define DMA_CHAN_INTR_NORMAL		(DMA_CHAN_INTR_ENA_NIE | \
+					 DMA_CHAN_INTR_ENA_RIE | \
+					 DMA_CHAN_INTR_ENA_TIE)
+
+#define DMA_CHAN_INTR_ABNORMAL		(DMA_CHAN_INTR_ENA_AIE | \
+					 DMA_CHAN_INTR_ENA_FBE)
+/* DMA default interrupt mask for 4.00 */
+#define DMA_CHAN_INTR_DEFAULT_MASK	(DMA_CHAN_INTR_NORMAL | \
+					 DMA_CHAN_INTR_ABNORMAL)
+#define DMA_CHAN_INTR_DEFAULT_RX	(DMA_CHAN_INTR_ENA_RIE)
+#define DMA_CHAN_INTR_DEFAULT_TX	(DMA_CHAN_INTR_ENA_TIE)
+
+#define DMA_CHAN_INTR_NORMAL_4_10	(DMA_CHAN_INTR_ENA_NIE_4_10 | \
+					 DMA_CHAN_INTR_ENA_RIE | \
+					 DMA_CHAN_INTR_ENA_TIE)
+
+#define DMA_CHAN_INTR_ABNORMAL_4_10	(DMA_CHAN_INTR_ENA_AIE_4_10 | \
+					 DMA_CHAN_INTR_ENA_FBE)
+/* DMA default interrupt mask for 4.10a */
+#define DMA_CHAN_INTR_DEFAULT_MASK_4_10	(DMA_CHAN_INTR_NORMAL_4_10 | \
+					 DMA_CHAN_INTR_ABNORMAL_4_10)
+#define DMA_CHAN_INTR_DEFAULT_RX_4_10	(DMA_CHAN_INTR_ENA_RIE)
+#define DMA_CHAN_INTR_DEFAULT_TX_4_10	(DMA_CHAN_INTR_ENA_TIE)
+
 #define DMA_CHAN_RX_WATCHDOG(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x38)
 #define DMA_CHAN_SLOT_CTRL_STATUS(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x3c)
 #define DMA_CHAN_CUR_TX_DESC(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x44)
@@ -116,20 +171,6 @@ static inline u32 dma_chanx_base_addr(const struct dwmac4_addrs *addrs,
 #define DMA_CHAN_CUR_RX_BUF_ADDR(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x5c)
 #define DMA_CHAN_STATUS(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x60)
 
-/* DMA Control X */
-#define DMA_CONTROL_SPH			BIT(24)
-#define DMA_CONTROL_MSS_MASK		GENMASK(13, 0)
-
-/* DMA Tx Channel X Control register defines */
-#define DMA_CONTROL_EDSE		BIT(28)
-#define DMA_CONTROL_TSE			BIT(12)
-#define DMA_CONTROL_OSP			BIT(4)
-#define DMA_CONTROL_ST			BIT(0)
-
-/* DMA Rx Channel X Control register defines */
-#define DMA_CONTROL_SR			BIT(0)
-#define DMA_RBSZ_MASK			GENMASK(14, 1)
-
 /* Interrupt status per channel */
 #define DMA_CHAN_STATUS_REB		GENMASK(21, 19)
 #define DMA_CHAN_STATUS_REB_SHIFT	19
@@ -168,48 +209,6 @@ static inline u32 dma_chanx_base_addr(const struct dwmac4_addrs *addrs,
 					 DMA_CHAN_STATUS_TI | \
 					 DMA_CHAN_STATUS_MSK_COMMON)
 
-/* Interrupt enable bits per channel */
-#define DMA_CHAN_INTR_ENA_NIE		BIT(16)
-#define DMA_CHAN_INTR_ENA_AIE		BIT(15)
-#define DMA_CHAN_INTR_ENA_NIE_4_10	BIT(15)
-#define DMA_CHAN_INTR_ENA_AIE_4_10	BIT(14)
-#define DMA_CHAN_INTR_ENA_CDE		BIT(13)
-#define DMA_CHAN_INTR_ENA_FBE		BIT(12)
-#define DMA_CHAN_INTR_ENA_ERE		BIT(11)
-#define DMA_CHAN_INTR_ENA_ETE		BIT(10)
-#define DMA_CHAN_INTR_ENA_RWE		BIT(9)
-#define DMA_CHAN_INTR_ENA_RSE		BIT(8)
-#define DMA_CHAN_INTR_ENA_RBUE		BIT(7)
-#define DMA_CHAN_INTR_ENA_RIE		BIT(6)
-#define DMA_CHAN_INTR_ENA_TBUE		BIT(2)
-#define DMA_CHAN_INTR_ENA_TSE		BIT(1)
-#define DMA_CHAN_INTR_ENA_TIE		BIT(0)
-
-#define DMA_CHAN_INTR_NORMAL		(DMA_CHAN_INTR_ENA_NIE | \
-					 DMA_CHAN_INTR_ENA_RIE | \
-					 DMA_CHAN_INTR_ENA_TIE)
-
-#define DMA_CHAN_INTR_ABNORMAL		(DMA_CHAN_INTR_ENA_AIE | \
-					 DMA_CHAN_INTR_ENA_FBE)
-/* DMA default interrupt mask for 4.00 */
-#define DMA_CHAN_INTR_DEFAULT_MASK	(DMA_CHAN_INTR_NORMAL | \
-					 DMA_CHAN_INTR_ABNORMAL)
-#define DMA_CHAN_INTR_DEFAULT_RX	(DMA_CHAN_INTR_ENA_RIE)
-#define DMA_CHAN_INTR_DEFAULT_TX	(DMA_CHAN_INTR_ENA_TIE)
-
-#define DMA_CHAN_INTR_NORMAL_4_10	(DMA_CHAN_INTR_ENA_NIE_4_10 | \
-					 DMA_CHAN_INTR_ENA_RIE | \
-					 DMA_CHAN_INTR_ENA_TIE)
-
-#define DMA_CHAN_INTR_ABNORMAL_4_10	(DMA_CHAN_INTR_ENA_AIE_4_10 | \
-					 DMA_CHAN_INTR_ENA_FBE)
-/* DMA default interrupt mask for 4.10a */
-#define DMA_CHAN_INTR_DEFAULT_MASK_4_10	(DMA_CHAN_INTR_NORMAL_4_10 | \
-					 DMA_CHAN_INTR_ABNORMAL_4_10)
-#define DMA_CHAN_INTR_DEFAULT_RX_4_10	(DMA_CHAN_INTR_ENA_RIE)
-#define DMA_CHAN_INTR_DEFAULT_TX_4_10	(DMA_CHAN_INTR_ENA_TIE)
-
-/* channel 0 specific fields */
 #define DMA_CHAN0_DBG_STAT_TPS		GENMASK(15, 12)
 #define DMA_CHAN0_DBG_STAT_TPS_SHIFT	12
 #define DMA_CHAN0_DBG_STAT_RPS		GENMASK(11, 8)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
index 0b379987d3af..a57ecef098e3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
@@ -13,13 +13,99 @@
 
 /* DMA CRS Control and Status Register Mapping */
 #define DMA_BUS_MODE		0x00001000	/* Bus Mode */
+
+#define DMA_BUS_MODE_SFT_RESET	0x00000001	/* Software Reset */
+
 #define DMA_XMT_POLL_DEMAND	0x00001004	/* Transmit Poll Demand */
 #define DMA_RCV_POLL_DEMAND	0x00001008	/* Received Poll Demand */
 #define DMA_RCV_BASE_ADDR	0x0000100c	/* Receive List Base */
 #define DMA_TX_BASE_ADDR	0x00001010	/* Transmit List Base */
+
 #define DMA_STATUS		0x00001014	/* Status Register */
+#define DMA_STATUS_GLPII	0x40000000	/* GMAC LPI interrupt */
+#define DMA_STATUS_GPI		0x10000000	/* PMT interrupt */
+#define DMA_STATUS_GMI		0x08000000	/* MMC interrupt */
+#define DMA_STATUS_GLI		0x04000000	/* GMAC Line interface int */
+#define DMA_STATUS_EB_MASK	0x00380000	/* Error Bits Mask */
+#define DMA_STATUS_EB_TX_ABORT	0x00080000	/* Error Bits - TX Abort */
+#define DMA_STATUS_EB_RX_ABORT	0x00100000	/* Error Bits - RX Abort */
+#define DMA_STATUS_TS_MASK	GENMASK(22, 20)	/* Transmit Process State */
+#define DMA_STATUS_RS_MASK	GENMASK(19, 17)	/* Receive Process State */
+#define DMA_STATUS_NIS	0x00010000	/* Normal Interrupt Summary */
+#define DMA_STATUS_AIS	0x00008000	/* Abnormal Interrupt Summary */
+#define DMA_STATUS_ERI	0x00004000	/* Early Receive Interrupt */
+#define DMA_STATUS_FBI	0x00002000	/* Fatal Bus Error Interrupt */
+#define DMA_STATUS_ETI	0x00000400	/* Early Transmit Interrupt */
+#define DMA_STATUS_RWT	0x00000200	/* Receive Watchdog Timeout */
+#define DMA_STATUS_RPS	0x00000100	/* Receive Process Stopped */
+#define DMA_STATUS_RU	0x00000080	/* Receive Buffer Unavailable */
+#define DMA_STATUS_RI	0x00000040	/* Receive Interrupt */
+#define DMA_STATUS_UNF	0x00000020	/* Transmit Underflow */
+#define DMA_STATUS_OVF	0x00000010	/* Receive Overflow */
+#define DMA_STATUS_TJT	0x00000008	/* Transmit Jabber Timeout */
+#define DMA_STATUS_TU	0x00000004	/* Transmit Buffer Unavailable */
+#define DMA_STATUS_TPS	0x00000002	/* Transmit Process Stopped */
+#define DMA_STATUS_TI	0x00000001	/* Transmit Interrupt */
+
+#define DMA_STATUS_MSK_COMMON		(DMA_STATUS_NIS | \
+					 DMA_STATUS_AIS | \
+					 DMA_STATUS_FBI)
+
+#define DMA_STATUS_MSK_RX		(DMA_STATUS_ERI | \
+					 DMA_STATUS_RWT | \
+					 DMA_STATUS_RPS | \
+					 DMA_STATUS_RU | \
+					 DMA_STATUS_RI | \
+					 DMA_STATUS_OVF | \
+					 DMA_STATUS_MSK_COMMON)
+
+#define DMA_STATUS_MSK_TX		(DMA_STATUS_ETI | \
+					 DMA_STATUS_UNF | \
+					 DMA_STATUS_TJT | \
+					 DMA_STATUS_TU | \
+					 DMA_STATUS_TPS | \
+					 DMA_STATUS_TI | \
+					 DMA_STATUS_MSK_COMMON)
+
 #define DMA_CONTROL		0x00001018	/* Ctrl (Operational Mode) */
+
+/* DMA Control register defines */
+#define DMA_CONTROL_FTF		0x00100000	/* Flush transmit FIFO */
+#define DMA_CONTROL_ST		0x00002000	/* Start/Stop Transmission */
+#define DMA_CONTROL_SR		0x00000002	/* Start/Stop Receive */
+
 #define DMA_INTR_ENA		0x0000101c	/* Interrupt Enable */
+
+/* DMA Normal interrupt */
+#define DMA_INTR_ENA_NIE 0x00010000	/* Normal Summary */
+#define DMA_INTR_ENA_TIE 0x00000001	/* Transmit Interrupt */
+#define DMA_INTR_ENA_TUE 0x00000004	/* Transmit Buffer Unavailable */
+#define DMA_INTR_ENA_RIE 0x00000040	/* Receive Interrupt */
+#define DMA_INTR_ENA_ERE 0x00004000	/* Early Receive */
+
+#define DMA_INTR_NORMAL	(DMA_INTR_ENA_NIE | DMA_INTR_ENA_RIE | \
+			DMA_INTR_ENA_TIE)
+
+/* DMA Abnormal interrupt */
+#define DMA_INTR_ENA_AIE 0x00008000	/* Abnormal Summary */
+#define DMA_INTR_ENA_FBE 0x00002000	/* Fatal Bus Error */
+#define DMA_INTR_ENA_ETE 0x00000400	/* Early Transmit */
+#define DMA_INTR_ENA_RWE 0x00000200	/* Receive Watchdog */
+#define DMA_INTR_ENA_RSE 0x00000100	/* Receive Stopped */
+#define DMA_INTR_ENA_RUE 0x00000080	/* Receive Buffer Unavailable */
+#define DMA_INTR_ENA_UNE 0x00000020	/* Tx Underflow */
+#define DMA_INTR_ENA_OVE 0x00000010	/* Receive Overflow */
+#define DMA_INTR_ENA_TJE 0x00000008	/* Transmit Jabber */
+#define DMA_INTR_ENA_TSE 0x00000002	/* Transmit Stopped */
+
+#define DMA_INTR_ABNORMAL	(DMA_INTR_ENA_AIE | DMA_INTR_ENA_FBE | \
+				DMA_INTR_ENA_UNE)
+
+/* DMA default interrupt mask */
+#define DMA_INTR_DEFAULT_MASK	(DMA_INTR_NORMAL | DMA_INTR_ABNORMAL)
+#define DMA_INTR_DEFAULT_RX	(DMA_INTR_ENA_RIE)
+#define DMA_INTR_DEFAULT_TX	(DMA_INTR_ENA_TIE)
+
 #define DMA_MISSED_FRAME_CTR	0x00001020	/* Missed Frame Counter */
 
 /* Following DMA defines are channels oriented */
@@ -47,8 +133,6 @@ static inline u32 dma_chan_base_addr(u32 base, u32 chan)
 #define DMA_CHAN_RX_WATCHDOG(chan)	\
 				dma_chan_base_addr(DMA_RX_WATCHDOG, chan)
 
-/* SW Reset */
-#define DMA_BUS_MODE_SFT_RESET	0x00000001	/* Software Reset */
 
 /* Rx watchdog register */
 #define DMA_RX_WATCHDOG		0x00001024
@@ -77,87 +161,6 @@ static inline u32 dma_chan_base_addr(u32 base, u32 chan)
 #define DMA_CUR_RX_BUF_ADDR	0x00001054	/* Current Host Rx Buffer */
 #define DMA_HW_FEATURE		0x00001058	/* HW Feature Register */
 
-/* DMA Control register defines */
-#define DMA_CONTROL_ST		0x00002000	/* Start/Stop Transmission */
-#define DMA_CONTROL_SR		0x00000002	/* Start/Stop Receive */
-
-/* DMA Normal interrupt */
-#define DMA_INTR_ENA_NIE 0x00010000	/* Normal Summary */
-#define DMA_INTR_ENA_TIE 0x00000001	/* Transmit Interrupt */
-#define DMA_INTR_ENA_TUE 0x00000004	/* Transmit Buffer Unavailable */
-#define DMA_INTR_ENA_RIE 0x00000040	/* Receive Interrupt */
-#define DMA_INTR_ENA_ERE 0x00004000	/* Early Receive */
-
-#define DMA_INTR_NORMAL	(DMA_INTR_ENA_NIE | DMA_INTR_ENA_RIE | \
-			DMA_INTR_ENA_TIE)
-
-/* DMA Abnormal interrupt */
-#define DMA_INTR_ENA_AIE 0x00008000	/* Abnormal Summary */
-#define DMA_INTR_ENA_FBE 0x00002000	/* Fatal Bus Error */
-#define DMA_INTR_ENA_ETE 0x00000400	/* Early Transmit */
-#define DMA_INTR_ENA_RWE 0x00000200	/* Receive Watchdog */
-#define DMA_INTR_ENA_RSE 0x00000100	/* Receive Stopped */
-#define DMA_INTR_ENA_RUE 0x00000080	/* Receive Buffer Unavailable */
-#define DMA_INTR_ENA_UNE 0x00000020	/* Tx Underflow */
-#define DMA_INTR_ENA_OVE 0x00000010	/* Receive Overflow */
-#define DMA_INTR_ENA_TJE 0x00000008	/* Transmit Jabber */
-#define DMA_INTR_ENA_TSE 0x00000002	/* Transmit Stopped */
-
-#define DMA_INTR_ABNORMAL	(DMA_INTR_ENA_AIE | DMA_INTR_ENA_FBE | \
-				DMA_INTR_ENA_UNE)
-
-/* DMA default interrupt mask */
-#define DMA_INTR_DEFAULT_MASK	(DMA_INTR_NORMAL | DMA_INTR_ABNORMAL)
-#define DMA_INTR_DEFAULT_RX	(DMA_INTR_ENA_RIE)
-#define DMA_INTR_DEFAULT_TX	(DMA_INTR_ENA_TIE)
-
-/* DMA Status register defines */
-#define DMA_STATUS_GLPII	0x40000000	/* GMAC LPI interrupt */
-#define DMA_STATUS_GPI		0x10000000	/* PMT interrupt */
-#define DMA_STATUS_GMI		0x08000000	/* MMC interrupt */
-#define DMA_STATUS_GLI		0x04000000	/* GMAC Line interface int */
-#define DMA_STATUS_EB_MASK	0x00380000	/* Error Bits Mask */
-#define DMA_STATUS_EB_TX_ABORT	0x00080000	/* Error Bits - TX Abort */
-#define DMA_STATUS_EB_RX_ABORT	0x00100000	/* Error Bits - RX Abort */
-#define DMA_STATUS_TS_MASK	GENMASK(22, 20)	/* Transmit Process State */
-#define DMA_STATUS_RS_MASK	GENMASK(19, 17)	/* Receive Process State */
-#define DMA_STATUS_NIS	0x00010000	/* Normal Interrupt Summary */
-#define DMA_STATUS_AIS	0x00008000	/* Abnormal Interrupt Summary */
-#define DMA_STATUS_ERI	0x00004000	/* Early Receive Interrupt */
-#define DMA_STATUS_FBI	0x00002000	/* Fatal Bus Error Interrupt */
-#define DMA_STATUS_ETI	0x00000400	/* Early Transmit Interrupt */
-#define DMA_STATUS_RWT	0x00000200	/* Receive Watchdog Timeout */
-#define DMA_STATUS_RPS	0x00000100	/* Receive Process Stopped */
-#define DMA_STATUS_RU	0x00000080	/* Receive Buffer Unavailable */
-#define DMA_STATUS_RI	0x00000040	/* Receive Interrupt */
-#define DMA_STATUS_UNF	0x00000020	/* Transmit Underflow */
-#define DMA_STATUS_OVF	0x00000010	/* Receive Overflow */
-#define DMA_STATUS_TJT	0x00000008	/* Transmit Jabber Timeout */
-#define DMA_STATUS_TU	0x00000004	/* Transmit Buffer Unavailable */
-#define DMA_STATUS_TPS	0x00000002	/* Transmit Process Stopped */
-#define DMA_STATUS_TI	0x00000001	/* Transmit Interrupt */
-#define DMA_CONTROL_FTF		0x00100000	/* Flush transmit FIFO */
-
-#define DMA_STATUS_MSK_COMMON		(DMA_STATUS_NIS | \
-					 DMA_STATUS_AIS | \
-					 DMA_STATUS_FBI)
-
-#define DMA_STATUS_MSK_RX		(DMA_STATUS_ERI | \
-					 DMA_STATUS_RWT | \
-					 DMA_STATUS_RPS | \
-					 DMA_STATUS_RU | \
-					 DMA_STATUS_RI | \
-					 DMA_STATUS_OVF | \
-					 DMA_STATUS_MSK_COMMON)
-
-#define DMA_STATUS_MSK_TX		(DMA_STATUS_ETI | \
-					 DMA_STATUS_UNF | \
-					 DMA_STATUS_TJT | \
-					 DMA_STATUS_TU | \
-					 DMA_STATUS_TPS | \
-					 DMA_STATUS_TI | \
-					 DMA_STATUS_MSK_COMMON)
-
 #define NUM_DWMAC100_DMA_REGS	9
 #define NUM_DWMAC1000_DMA_REGS	23
 #define NUM_DWMAC4_DMA_REGS	27
-- 
2.47.3


