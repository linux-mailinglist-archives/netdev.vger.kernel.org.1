Return-Path: <netdev+bounces-247467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BD4CFAF72
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 21:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15934310B23E
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 20:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6492A33B96E;
	Tue,  6 Jan 2026 20:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="qr8AxN13"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E493723EAAB
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 20:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767731546; cv=none; b=jcbVo3SEj0S/RbPlT38eZFrTc950RSf9Yuig8mLb9z2j263uRByWB3MBtkivZiElDVnAHUGv5ui1QhNycbN9I4gN6bHET0Zl45tFwk5ktIGEclCLIOTjKoyo8ELMF3W1dkJqRYCPBG+c2yHMIqoTqpxicmy4ZNKWDNxib+5mI+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767731546; c=relaxed/simple;
	bh=0qGC8Mbg1F2GT1Jle0tkFpsXkP+5KX12uP23/cNswNE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=An6h5qCRoq5lf0N9/bi0p7L9z6PnRbWPk+8NZrayD9xNABQQ0a0LYWP09WxbbHEY5XypNHTecY1+537DwaxmDTf2B9BCLG7QlAVPopB5mLDhhyWEhBCapD6rFmd1xoHXEalM5ZZchARTROIgH0sn21NjPeJ8FyYMgq4fXWr7BTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=qr8AxN13; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=d5EH9CN/M6xoNGKrm1WaBtVLEC1EjhpBswnHDX8iinE=; b=qr8AxN13eHBoD4TVFJjpyYkmwF
	Hr00Jt6HTI0dW2oF/sKHMaXwJbFqpEhE5p7PUbOAni1c9wIxkDvADfVLh7a95bm/OkmdGRqE2GHGV
	kD1uVdHga8OTi+qc3FoImoqD2cZMJ8xsHFZqNlnDJ3C/RtnogfmhcNdaoyQkTvbPbpI2A0Ll22HMC
	2hlkl7Y6PMZ2XCl3GatmA2Zphal7njNKb7O4wbmYpL0gN8p6dXyf8KUtrrgcXlBe71e0TPRu5ehmK
	nDPf7xPozvUoFk3NI9e1K8DT6zaw09iZEFmhP1zp296y+ZMH+Bg8ViUn2/0F7Rb7ZkZiOJTCJnVmF
	89M9JOXg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:33442 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vdDih-0000000012h-21MF;
	Tue, 06 Jan 2026 20:31:59 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vdDif-00000002E27-239W;
	Tue, 06 Jan 2026 20:31:57 +0000
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
Subject: [PATCH net-next 9/9] net: stmmac: remove unused definitions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vdDif-00000002E27-239W@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 06 Jan 2026 20:31:57 +0000

Potentially unused definitions were discovered using:

$ for m in $(grep '#define ' $header | sed -e 's,#define[  ]*\([^  ]*\)[   ].*,\1,;s,(.*,,'); do if ! grep -q $m *.c; then echo $m; fi; done

Each was verified, and then removed where truly unused.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac100.h    | 29 ----------
 .../net/ethernet/stmicro/stmmac/dwmac1000.h   | 54 +------------------
 .../net/ethernet/stmicro/stmmac/dwmac4_dma.h  | 44 ---------------
 .../net/ethernet/stmicro/stmmac/dwmac_dma.h   | 23 --------
 4 files changed, 1 insertion(+), 149 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac100.h b/drivers/net/ethernet/stmicro/stmmac/dwmac100.h
index eae929955ad7..547863cb982f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac100.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac100.h
@@ -30,59 +30,30 @@
 #define MAC_VLAN2	0x00000024	/* VLAN2 Tag */
 
 /* MAC CTRL defines */
-#define MAC_CONTROL_RA	0x80000000	/* Receive All Mode */
-#define MAC_CONTROL_BLE	0x40000000	/* Endian Mode */
 #define MAC_CONTROL_HBD	0x10000000	/* Heartbeat Disable */
 #define MAC_CONTROL_PS	0x08000000	/* Port Select */
-#define MAC_CONTROL_DRO	0x00800000	/* Disable Receive Own */
-#define MAC_CONTROL_EXT_LOOPBACK 0x00400000	/* Reserved (ext loopback?) */
 #define MAC_CONTROL_OM	0x00200000	/* Loopback Operating Mode */
 #define MAC_CONTROL_F	0x00100000	/* Full Duplex Mode */
 #define MAC_CONTROL_PM	0x00080000	/* Pass All Multicast */
 #define MAC_CONTROL_PR	0x00040000	/* Promiscuous Mode */
 #define MAC_CONTROL_IF	0x00020000	/* Inverse Filtering */
-#define MAC_CONTROL_PB	0x00010000	/* Pass Bad Frames */
 #define MAC_CONTROL_HO	0x00008000	/* Hash Only Filtering Mode */
 #define MAC_CONTROL_HP	0x00002000	/* Hash/Perfect Filtering Mode */
-#define MAC_CONTROL_LCC	0x00001000	/* Late Collision Control */
-#define MAC_CONTROL_DBF	0x00000800	/* Disable Broadcast Frames */
-#define MAC_CONTROL_DRTY	0x00000400	/* Disable Retry */
-#define MAC_CONTROL_ASTP	0x00000100	/* Automatic Pad Stripping */
-#define MAC_CONTROL_BOLMT_10	0x00000000	/* Back Off Limit 10 */
-#define MAC_CONTROL_BOLMT_8	0x00000040	/* Back Off Limit 8 */
-#define MAC_CONTROL_BOLMT_4	0x00000080	/* Back Off Limit 4 */
-#define MAC_CONTROL_BOLMT_1	0x000000c0	/* Back Off Limit 1 */
-#define MAC_CONTROL_DC		0x00000020	/* Deferral Check */
-#define MAC_CONTROL_TE		0x00000008	/* Transmitter Enable */
-#define MAC_CONTROL_RE		0x00000004	/* Receiver Enable */
 
 #define MAC_CORE_INIT (MAC_CONTROL_HBD)
 
 /* MAC FLOW CTRL defines */
 #define MAC_FLOW_CTRL_PT_MASK	GENMASK(31, 16)	/* Pause Time Mask */
-#define MAC_FLOW_CTRL_PASS	0x00000004	/* Pass Control Frames */
 #define MAC_FLOW_CTRL_ENABLE	0x00000002	/* Flow Control Enable */
-#define MAC_FLOW_CTRL_PAUSE	0x00000001	/* Flow Control Busy ... */
-
-/* MII ADDR  defines */
-#define MAC_MII_ADDR_WRITE	0x00000002	/* MII Write */
-#define MAC_MII_ADDR_BUSY	0x00000001	/* MII Busy */
 
 /*----------------------------------------------------------------------------
  * 				DMA BLOCK defines
  *---------------------------------------------------------------------------*/
 
 /* DMA Bus Mode register defines */
-#define DMA_BUS_MODE_DBO	0x00100000	/* Descriptor Byte Ordering */
-#define DMA_BUS_MODE_BLE	0x00000080	/* Big Endian/Little Endian */
 #define DMA_BUS_MODE_PBL_MASK	GENMASK(13, 8)	/* Programmable Burst Len */
-#define DMA_BUS_MODE_DSL_MASK	GENMASK(6, 2)	/* Descriptor Skip Length */
-#define DMA_BUS_MODE_BAR_BUS	0x00000002	/* Bar-Bus Arbitration */
 #define DMA_BUS_MODE_DEFAULT	0x00000000
 
-/* DMA Control register defines */
-#define DMA_CONTROL_SF		0x00200000	/* Store And Forward */
-
 /* Transmit Threshold Control */
 enum ttc_control {
 	DMA_CONTROL_TTC_DEFAULT = 0x00000000,	/* Threshold is 32 DWORDS */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h b/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
index 17e013e97607..b3135df0a359 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
@@ -20,15 +20,11 @@
 #define GMAC_FLOW_CTRL		0x00000018	/* Flow Control */
 #define GMAC_VLAN_TAG		0x0000001c	/* VLAN Tag */
 #define GMAC_DEBUG		0x00000024	/* GMAC debug register */
-#define GMAC_WAKEUP_FILTER	0x00000028	/* Wake-up Frame Filter */
 
 #define GMAC_INT_STATUS		0x00000038	/* interrupt status register */
-#define GMAC_INT_STATUS_PMT	BIT(3)
-#define GMAC_INT_STATUS_MMCIS	BIT(4)
 #define GMAC_INT_STATUS_MMCRIS	BIT(5)
 #define GMAC_INT_STATUS_MMCTIS	BIT(6)
 #define GMAC_INT_STATUS_MMCCSUM	BIT(7)
-#define GMAC_INT_STATUS_TSTAMP	BIT(9)
 #define GMAC_INT_STATUS_LPIIS	BIT(10)
 
 /* interrupt mask register */
@@ -89,8 +85,6 @@ enum power_event {
 
 /* GMAC Configuration defines */
 #define GMAC_CONTROL_2K 0x08000000	/* IEEE 802.3as 2K packets */
-#define GMAC_CONTROL_TC	0x01000000	/* Transmit Conf. in RGMII/SGMII */
-#define GMAC_CONTROL_WD	0x00800000	/* Disable Watchdog on receive */
 #define GMAC_CONTROL_JD	0x00400000	/* Jabber disable */
 #define GMAC_CONTROL_BE	0x00200000	/* Frame Burst Enable */
 #define GMAC_CONTROL_JE	0x00100000	/* Jumbo frame */
@@ -102,41 +96,25 @@ enum inter_frame_gap {
 #define GMAC_CONTROL_DCRS	0x00010000	/* Disable carrier sense */
 #define GMAC_CONTROL_PS		0x00008000	/* Port Select 0:GMI 1:MII */
 #define GMAC_CONTROL_FES	0x00004000	/* Speed 0:10 1:100 */
-#define GMAC_CONTROL_DO		0x00002000	/* Disable Rx Own */
 #define GMAC_CONTROL_LM		0x00001000	/* Loop-back mode */
 #define GMAC_CONTROL_DM		0x00000800	/* Duplex Mode */
 #define GMAC_CONTROL_IPC	0x00000400	/* Checksum Offload */
-#define GMAC_CONTROL_DR		0x00000200	/* Disable Retry */
-#define GMAC_CONTROL_LUD	0x00000100	/* Link up/down */
-#define GMAC_CONTROL_ACS	0x00000080	/* Auto Pad/FCS Stripping */
-#define GMAC_CONTROL_DC		0x00000010	/* Deferral Check */
-#define GMAC_CONTROL_TE		0x00000008	/* Transmitter Enable */
-#define GMAC_CONTROL_RE		0x00000004	/* Receiver Enable */
 
 #define GMAC_CORE_INIT (GMAC_CONTROL_JD | GMAC_CONTROL_PS | \
 			GMAC_CONTROL_BE | GMAC_CONTROL_DCRS)
 
 /* GMAC Frame Filter defines */
 #define GMAC_FRAME_FILTER_PR	0x00000001	/* Promiscuous Mode */
-#define GMAC_FRAME_FILTER_HUC	0x00000002	/* Hash Unicast */
 #define GMAC_FRAME_FILTER_HMC	0x00000004	/* Hash Multicast */
-#define GMAC_FRAME_FILTER_DAIF	0x00000008	/* DA Inverse Filtering */
 #define GMAC_FRAME_FILTER_PM	0x00000010	/* Pass all multicast */
-#define GMAC_FRAME_FILTER_DBF	0x00000020	/* Disable Broadcast frames */
 #define GMAC_FRAME_FILTER_PCF	0x00000080	/* Pass Control frames */
-#define GMAC_FRAME_FILTER_SAIF	0x00000100	/* Inverse Filtering */
-#define GMAC_FRAME_FILTER_SAF	0x00000200	/* Source Address Filter */
 #define GMAC_FRAME_FILTER_HPF	0x00000400	/* Hash or perfect Filter */
 #define GMAC_FRAME_FILTER_RA	0x80000000	/* Receive all mode */
-/* GMII ADDR  defines */
-#define GMAC_MII_ADDR_WRITE	0x00000002	/* MII Write */
-#define GMAC_MII_ADDR_BUSY	0x00000001	/* MII Busy */
 /* GMAC FLOW CTRL defines */
 #define GMAC_FLOW_CTRL_PT_MASK	GENMASK(31, 16)	/* Pause Time Mask */
 #define GMAC_FLOW_CTRL_UP	0x00000008	/* Unicast pause frame enable */
 #define GMAC_FLOW_CTRL_RFE	0x00000004	/* Rx Flow Control Enable */
 #define GMAC_FLOW_CTRL_TFE	0x00000002	/* Tx Flow Control Enable */
-#define GMAC_FLOW_CTRL_FCB_BPA	0x00000001	/* Flow Control Busy ... */
 
 /* DEBUG Register defines */
 /* MTL TxStatus FIFO */
@@ -145,14 +123,12 @@ enum inter_frame_gap {
 #define GMAC_DEBUG_TWCSTS	BIT(22) /* MTL Tx FIFO Write Controller */
 /* MTL Tx FIFO Read Controller Status */
 #define GMAC_DEBUG_TRCSTS_MASK	GENMASK(21, 20)
-#define GMAC_DEBUG_TRCSTS_IDLE	0
 #define GMAC_DEBUG_TRCSTS_READ	1
 #define GMAC_DEBUG_TRCSTS_TXW	2
 #define GMAC_DEBUG_TRCSTS_WRITE	3
 #define GMAC_DEBUG_TXPAUSED	BIT(19) /* MAC Transmitter in PAUSE */
 /* MAC Transmit Frame Controller Status */
 #define GMAC_DEBUG_TFCSTS_MASK	GENMASK(18, 17)
-#define GMAC_DEBUG_TFCSTS_IDLE	0
 #define GMAC_DEBUG_TFCSTS_WAIT	1
 #define GMAC_DEBUG_TFCSTS_GEN_PAUSE	2
 #define GMAC_DEBUG_TFCSTS_XFER	3
@@ -176,9 +152,6 @@ enum inter_frame_gap {
 
 /*--- DMA BLOCK defines ---*/
 /* DMA Bus Mode register defines */
-#define DMA_BUS_MODE_DA		0x00000002	/* Arbitration scheme */
-#define DMA_BUS_MODE_DSL_MASK	0x0000007c	/* Descriptor Skip Length */
-#define DMA_BUS_MODE_DSL_SHIFT	2		/*   (in DWORDS)      */
 /* Programmable burst length (passed thorugh platform)*/
 #define DMA_BUS_MODE_PBL_MASK	GENMASK(13, 8)	/* Programmable Burst Len */
 #define DMA_BUS_MODE_ATDS	0x00000080	/* Alternate Descriptor Size */
@@ -197,16 +170,9 @@ enum rx_tx_priority_ratio {
 #define DMA_BUS_MODE_AAL	0x02000000
 
 /* DMA CRS Control and Status Register Mapping */
-#define DMA_HOST_TX_DESC	  0x00001048	/* Current Host Tx descriptor */
-#define DMA_HOST_RX_DESC	  0x0000104c	/* Current Host Rx descriptor */
-/*  DMA Bus Mode register defines */
-#define DMA_BUS_PR_RATIO_MASK	  0x0000c000	/* Rx/Tx priority ratio */
-#define DMA_BUS_PR_RATIO_SHIFT	  14
-#define DMA_BUS_FB	  	  0x00010000	/* Fixed Burst */
 
 /* DMA operation mode defines (start/stop tx/rx are placed in common header)*/
 /* Disable Drop TCP/IP csum error */
-#define DMA_CONTROL_DT		0x04000000
 #define DMA_CONTROL_RSF		0x02000000	/* Receive Store and Forward */
 #define DMA_CONTROL_DFF		0x01000000	/* Disaable flushing */
 /* Threshold for Activating the FC */
@@ -238,8 +204,6 @@ enum ttc_control {
 #define DMA_CONTROL_TC_TX_MASK	0xfffe3fff
 
 #define DMA_CONTROL_EFC		0x00000100
-#define DMA_CONTROL_FEF		0x00000080
-#define DMA_CONTROL_FUF		0x00000040
 
 /* Receive flow control activation field
  * RFA field in DMA control register, bits 23,10:9
@@ -276,20 +240,8 @@ enum ttc_control {
  */
 
 #define RFA_FULL_MINUS_1K	0x00000000
-#define RFA_FULL_MINUS_2K	0x00000200
-#define RFA_FULL_MINUS_3K	0x00000400
-#define RFA_FULL_MINUS_4K	0x00000600
-#define RFA_FULL_MINUS_5K	0x00800000
-#define RFA_FULL_MINUS_6K	0x00800200
-#define RFA_FULL_MINUS_7K	0x00800400
-
-#define RFD_FULL_MINUS_1K	0x00000000
+
 #define RFD_FULL_MINUS_2K	0x00000800
-#define RFD_FULL_MINUS_3K	0x00001000
-#define RFD_FULL_MINUS_4K	0x00001800
-#define RFD_FULL_MINUS_5K	0x00400000
-#define RFD_FULL_MINUS_6K	0x00400800
-#define RFD_FULL_MINUS_7K	0x00401000
 
 enum rtc_control {
 	DMA_CONTROL_RTC_64 = 0x00000000,
@@ -302,10 +254,6 @@ enum rtc_control {
 #define DMA_CONTROL_OSF	0x00000004	/* Operate on second frame */
 
 /* MMC registers offset */
-#define GMAC_MMC_CTRL      0x100
-#define GMAC_MMC_RX_INTR   0x104
-#define GMAC_MMC_TX_INTR   0x108
-#define GMAC_MMC_RX_CSUM_OFFLOAD   0x208
 #define GMAC_EXTHASH_BASE  0x500
 
 /* PTP and timestamping registers */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
index e8f103cb6cd5..5f1e2916f099 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
@@ -24,7 +24,6 @@
 
 #define DMA_SYS_BUS_MODE		0x00001004
 
-#define DMA_BUS_MODE_SPH		BIT(24)
 #define DMA_BUS_MODE_PBL		BIT(16)
 #define DMA_BUS_MODE_RPBL_MASK		GENMASK(21, 16)
 #define DMA_BUS_MODE_MB			BIT(14)
@@ -32,24 +31,6 @@
 
 #define DMA_STATUS			0x00001008
 
-#define DMA_STATUS_MAC			BIT(17)
-#define DMA_STATUS_MTL			BIT(16)
-#define DMA_STATUS_CHAN7		BIT(7)
-#define DMA_STATUS_CHAN6		BIT(6)
-#define DMA_STATUS_CHAN5		BIT(5)
-#define DMA_STATUS_CHAN4		BIT(4)
-#define DMA_STATUS_CHAN3		BIT(3)
-#define DMA_STATUS_CHAN2		BIT(2)
-#define DMA_STATUS_CHAN1		BIT(1)
-#define DMA_STATUS_CHAN0		BIT(0)
-
-#define DMA_DEBUG_STATUS_0		0x0000100c
-#define DMA_DEBUG_STATUS_1		0x00001010
-#define DMA_DEBUG_STATUS_2		0x00001014
-
-#define DMA_DEBUG_STATUS_TS_MASK	0xf
-#define DMA_DEBUG_STATUS_RS_MASK	0xf
-
 #define DMA_AXI_BUS_MODE		0x00001028
 
 #define DMA_AXI_EN_LPI			BIT(31)
@@ -58,16 +39,10 @@
 #define DMA_AXI_RD_OSR_LMT		GENMASK(19, 16)
 
 #define DMA_SYS_BUS_MB			BIT(14)
-#define DMA_AXI_1KBBE			BIT(13)
 #define DMA_SYS_BUS_AAL			DMA_AXI_AAL
 #define DMA_SYS_BUS_EAME		BIT(11)
 #define DMA_SYS_BUS_FB			BIT(0)
 
-#define DMA_BURST_LEN_DEFAULT		(DMA_AXI_BLEN256 | DMA_AXI_BLEN128 | \
-					DMA_AXI_BLEN64 | DMA_AXI_BLEN32 | \
-					DMA_AXI_BLEN16 | DMA_AXI_BLEN8 | \
-					DMA_AXI_BLEN4)
-
 #define DMA_TBS_CTRL			0x00001050
 
 #define DMA_TBS_FTOS			GENMASK(31, 8)
@@ -91,12 +66,9 @@ static inline u32 dma_chanx_base_addr(const struct dwmac4_addrs *addrs,
 	return addr;
 }
 
-#define DMA_CHAN_REG_NUMBER		17
-
 #define DMA_CHAN_CONTROL(addrs, x)	dma_chanx_base_addr(addrs, x)
 
 #define DMA_CONTROL_SPH			BIT(24)
-#define DMA_CONTROL_MSS_MASK		GENMASK(13, 0)
 
 #define DMA_CHAN_TX_CONTROL(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x4)
 
@@ -125,16 +97,8 @@ static inline u32 dma_chanx_base_addr(const struct dwmac4_addrs *addrs,
 #define DMA_CHAN_INTR_ENA_AIE		BIT(15)
 #define DMA_CHAN_INTR_ENA_NIE_4_10	BIT(15)
 #define DMA_CHAN_INTR_ENA_AIE_4_10	BIT(14)
-#define DMA_CHAN_INTR_ENA_CDE		BIT(13)
 #define DMA_CHAN_INTR_ENA_FBE		BIT(12)
-#define DMA_CHAN_INTR_ENA_ERE		BIT(11)
-#define DMA_CHAN_INTR_ENA_ETE		BIT(10)
-#define DMA_CHAN_INTR_ENA_RWE		BIT(9)
-#define DMA_CHAN_INTR_ENA_RSE		BIT(8)
-#define DMA_CHAN_INTR_ENA_RBUE		BIT(7)
 #define DMA_CHAN_INTR_ENA_RIE		BIT(6)
-#define DMA_CHAN_INTR_ENA_TBUE		BIT(2)
-#define DMA_CHAN_INTR_ENA_TSE		BIT(1)
 #define DMA_CHAN_INTR_ENA_TIE		BIT(0)
 
 #define DMA_CHAN_INTR_NORMAL		(DMA_CHAN_INTR_ENA_NIE | \
@@ -173,9 +137,6 @@ static inline u32 dma_chanx_base_addr(const struct dwmac4_addrs *addrs,
 
 /* Interrupt status per channel */
 #define DMA_CHAN_STATUS_REB		GENMASK(21, 19)
-#define DMA_CHAN_STATUS_REB_SHIFT	19
-#define DMA_CHAN_STATUS_TEB		GENMASK(18, 16)
-#define DMA_CHAN_STATUS_TEB_SHIFT	16
 #define DMA_CHAN_STATUS_NIS		BIT(15)
 #define DMA_CHAN_STATUS_AIS		BIT(14)
 #define DMA_CHAN_STATUS_CDE		BIT(13)
@@ -209,11 +170,6 @@ static inline u32 dma_chanx_base_addr(const struct dwmac4_addrs *addrs,
 					 DMA_CHAN_STATUS_TI | \
 					 DMA_CHAN_STATUS_MSK_COMMON)
 
-#define DMA_CHAN0_DBG_STAT_TPS		GENMASK(15, 12)
-#define DMA_CHAN0_DBG_STAT_TPS_SHIFT	12
-#define DMA_CHAN0_DBG_STAT_RPS		GENMASK(11, 8)
-#define DMA_CHAN0_DBG_STAT_RPS_SHIFT	8
-
 int dwmac4_dma_reset(void __iomem *ioaddr);
 void dwmac4_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
 			   u32 chan, bool rx, bool tx);
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
index a57ecef098e3..e1c37ac2c99d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
@@ -22,13 +22,9 @@
 #define DMA_TX_BASE_ADDR	0x00001010	/* Transmit List Base */
 
 #define DMA_STATUS		0x00001014	/* Status Register */
-#define DMA_STATUS_GLPII	0x40000000	/* GMAC LPI interrupt */
 #define DMA_STATUS_GPI		0x10000000	/* PMT interrupt */
 #define DMA_STATUS_GMI		0x08000000	/* MMC interrupt */
 #define DMA_STATUS_GLI		0x04000000	/* GMAC Line interface int */
-#define DMA_STATUS_EB_MASK	0x00380000	/* Error Bits Mask */
-#define DMA_STATUS_EB_TX_ABORT	0x00080000	/* Error Bits - TX Abort */
-#define DMA_STATUS_EB_RX_ABORT	0x00100000	/* Error Bits - RX Abort */
 #define DMA_STATUS_TS_MASK	GENMASK(22, 20)	/* Transmit Process State */
 #define DMA_STATUS_RS_MASK	GENMASK(19, 17)	/* Receive Process State */
 #define DMA_STATUS_NIS	0x00010000	/* Normal Interrupt Summary */
@@ -79,9 +75,7 @@
 /* DMA Normal interrupt */
 #define DMA_INTR_ENA_NIE 0x00010000	/* Normal Summary */
 #define DMA_INTR_ENA_TIE 0x00000001	/* Transmit Interrupt */
-#define DMA_INTR_ENA_TUE 0x00000004	/* Transmit Buffer Unavailable */
 #define DMA_INTR_ENA_RIE 0x00000040	/* Receive Interrupt */
-#define DMA_INTR_ENA_ERE 0x00004000	/* Early Receive */
 
 #define DMA_INTR_NORMAL	(DMA_INTR_ENA_NIE | DMA_INTR_ENA_RIE | \
 			DMA_INTR_ENA_TIE)
@@ -89,14 +83,7 @@
 /* DMA Abnormal interrupt */
 #define DMA_INTR_ENA_AIE 0x00008000	/* Abnormal Summary */
 #define DMA_INTR_ENA_FBE 0x00002000	/* Fatal Bus Error */
-#define DMA_INTR_ENA_ETE 0x00000400	/* Early Transmit */
-#define DMA_INTR_ENA_RWE 0x00000200	/* Receive Watchdog */
-#define DMA_INTR_ENA_RSE 0x00000100	/* Receive Stopped */
-#define DMA_INTR_ENA_RUE 0x00000080	/* Receive Buffer Unavailable */
 #define DMA_INTR_ENA_UNE 0x00000020	/* Tx Underflow */
-#define DMA_INTR_ENA_OVE 0x00000010	/* Receive Overflow */
-#define DMA_INTR_ENA_TJE 0x00000008	/* Transmit Jabber */
-#define DMA_INTR_ENA_TSE 0x00000002	/* Transmit Stopped */
 
 #define DMA_INTR_ABNORMAL	(DMA_INTR_ENA_AIE | DMA_INTR_ENA_FBE | \
 				DMA_INTR_ENA_UNE)
@@ -128,8 +115,6 @@ static inline u32 dma_chan_base_addr(u32 base, u32 chan)
 #define DMA_CHAN_STATUS(chan)	dma_chan_base_addr(DMA_STATUS, chan)
 #define DMA_CHAN_CONTROL(chan)	dma_chan_base_addr(DMA_CONTROL, chan)
 #define DMA_CHAN_INTR_ENA(chan)	dma_chan_base_addr(DMA_INTR_ENA, chan)
-#define DMA_CHAN_MISSED_FRAME_CTR(chan)	\
-				dma_chan_base_addr(DMA_MISSED_FRAME_CTR, chan)
 #define DMA_CHAN_RX_WATCHDOG(chan)	\
 				dma_chan_base_addr(DMA_RX_WATCHDOG, chan)
 
@@ -145,14 +130,6 @@ static inline u32 dma_chan_base_addr(u32 base, u32 chan)
 #define DMA_AXI_WR_OSR_LMT	GENMASK(23, 20)
 #define DMA_AXI_RD_OSR_LMT	GENMASK(19, 16)
 
-#define DMA_AXI_OSR_MAX		0xf
-#define DMA_AXI_MAX_OSR_LIMIT ((DMA_AXI_OSR_MAX << DMA_AXI_WR_OSR_LMT_SHIFT) | \
-			       (DMA_AXI_OSR_MAX << DMA_AXI_RD_OSR_LMT_SHIFT))
-#define DMA_BURST_LEN_DEFAULT	(DMA_AXI_BLEN256 | DMA_AXI_BLEN128 | \
-				 DMA_AXI_BLEN64 | DMA_AXI_BLEN32 | \
-				 DMA_AXI_BLEN16 | DMA_AXI_BLEN8 | \
-				 DMA_AXI_BLEN4)
-
 #define	DMA_AXI_1KBBE		BIT(13)
 
 #define DMA_AXI_UNDEF		BIT(0)
-- 
2.47.3


