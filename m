Return-Path: <netdev+bounces-248209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F103D0517F
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 18:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1B0A308AF37
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 17:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B412DC34B;
	Thu,  8 Jan 2026 17:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lDEO7X/u"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E732E0418
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 17:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767893813; cv=none; b=tHBLqvPZZB5wtFEiB1bBFFcIk/BhVH5RpW2IdtFDvl3moenYPVl84YrUr3/IFUlCDMiqrsfQ8x3SiNQiMjoAgNMKIu5/STK0ctxlUe3L5SW75oMzpsIn8oucRnRvEcq3kSp4oCjBUVw7+ZxC03WorajM2D1MV/Es6mCplGIfPyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767893813; c=relaxed/simple;
	bh=ptUP8WgFTEgOBagg7HFhwJh+YtLtWA+pmNJ/d+XwseM=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=J15awBAyq9PYCcWNl0/f+B72G9FdhwsLWUb9hYqvJxvv8jUpH6JB9T4xpVfQiMZmKbWsz1l/hegwR0h78AYtw4FLwwr38h3V7gbqOhc5reGLDb04PvSLeuWHFr8KDrWa7hZ+GGVUuU0XT+MkD9A0zSRg8OYd2svFQ9QfyGmbsfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=lDEO7X/u; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=n8nj4X3SwFjvdmzzsZ9v5lrniTnY9acD+wihfYtJfOg=; b=lDEO7X/ufst0yqdUVQ0knXgs8c
	j+k3ufDGWsofwyApB98KbyRqZMC/4RS6yndoJe/rAZ3eB2tZxb05PF70bwQHvG6hVTLui6o4K1k80
	FBycrBwKRrUH3fAakfzOZrAYy9S5+x7k2Rl3P/N9HwljXBhdz/obtGKc5rgN/rGPHMd/VGm2ewWWL
	rPp8mJriBiz5qtFOspmDEpFZl8fMwtaq+R5MTh33O+GuuT5kr4dDEZGHcGEnXmI1++jMJLecErluJ
	ZLgaEis2jDNOIqt3b5JnDiRZp8VXO7ZfQ6uU7Ms0EH8NQ7MUEt1A8zaD3M2qlJ3E+55iuzjWD+AdM
	v6El7Tdw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:58306 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vdtw4-00000000309-0bYg;
	Thu, 08 Jan 2026 17:36:36 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vdtw2-00000002Gto-3ZPt;
	Thu, 08 Jan 2026 17:36:34 +0000
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
Subject: [PATCH net-next v2 6/9] net: stmmac: descs: remove many xxx_SHIFT
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
Message-Id: <E1vdtw2-00000002Gto-3ZPt@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 08 Jan 2026 17:36:34 +0000

Remove many xxx_SHIFT definitions for descriptors, isntead using
FIELD_PREP(), FIELD_GET(), and u32_replace_bits() as appropriate to
manipulate the bitfields. This avoids potential errors where an
incorrect shift is used with a mask.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/descs.h   |  7 ---
 .../net/ethernet/stmicro/stmmac/descs_com.h   | 32 ++++++-------
 .../ethernet/stmicro/stmmac/dwmac4_descs.c    | 48 +++++++------------
 .../ethernet/stmicro/stmmac/dwmac4_descs.h    |  8 ----
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  9 ----
 .../ethernet/stmicro/stmmac/dwxgmac2_descs.c  | 25 ++++------
 .../net/ethernet/stmicro/stmmac/enh_desc.c    | 17 +++----
 .../net/ethernet/stmicro/stmmac/norm_desc.c   | 17 ++-----
 8 files changed, 55 insertions(+), 108 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/descs.h b/drivers/net/ethernet/stmicro/stmmac/descs.h
index 49d6a866244f..e62e2ebcf273 100644
--- a/drivers/net/ethernet/stmicro/stmmac/descs.h
+++ b/drivers/net/ethernet/stmicro/stmmac/descs.h
@@ -32,13 +32,11 @@
 #define	RDES0_DESCRIPTOR_ERROR	BIT(14)
 #define	RDES0_ERROR_SUMMARY	BIT(15)
 #define	RDES0_FRAME_LEN_MASK	GENMASK(29, 16)
-#define RDES0_FRAME_LEN_SHIFT	16
 #define	RDES0_DA_FILTER_FAIL	BIT(30)
 #define	RDES0_OWN		BIT(31)
 			/* RDES1 */
 #define	RDES1_BUFFER1_SIZE_MASK		GENMASK(10, 0)
 #define	RDES1_BUFFER2_SIZE_MASK		GENMASK(21, 11)
-#define	RDES1_BUFFER2_SIZE_SHIFT	11
 #define	RDES1_SECOND_ADDRESS_CHAINED	BIT(24)
 #define	RDES1_END_RING			BIT(25)
 #define	RDES1_DISABLE_IC		BIT(31)
@@ -53,7 +51,6 @@
 #define	ERDES1_SECOND_ADDRESS_CHAINED	BIT(14)
 #define	ERDES1_END_RING			BIT(15)
 #define	ERDES1_BUFFER2_SIZE_MASK	GENMASK(28, 16)
-#define ERDES1_BUFFER2_SIZE_SHIFT	16
 #define	ERDES1_DISABLE_IC		BIT(31)
 
 /* Normal transmit descriptor defines */
@@ -77,14 +74,12 @@
 /* TDES1 */
 #define	TDES1_BUFFER1_SIZE_MASK		GENMASK(10, 0)
 #define	TDES1_BUFFER2_SIZE_MASK		GENMASK(21, 11)
-#define	TDES1_BUFFER2_SIZE_SHIFT	11
 #define	TDES1_TIME_STAMP_ENABLE		BIT(22)
 #define	TDES1_DISABLE_PADDING		BIT(23)
 #define	TDES1_SECOND_ADDRESS_CHAINED	BIT(24)
 #define	TDES1_END_RING			BIT(25)
 #define	TDES1_CRC_DISABLE		BIT(26)
 #define	TDES1_CHECKSUM_INSERTION_MASK	GENMASK(28, 27)
-#define	TDES1_CHECKSUM_INSERTION_SHIFT	27
 #define	TDES1_FIRST_SEGMENT		BIT(29)
 #define	TDES1_LAST_SEGMENT		BIT(30)
 #define	TDES1_INTERRUPT			BIT(31)
@@ -109,7 +104,6 @@
 #define	ETDES0_SECOND_ADDRESS_CHAINED	BIT(20)
 #define	ETDES0_END_RING			BIT(21)
 #define	ETDES0_CHECKSUM_INSERTION_MASK	GENMASK(23, 22)
-#define	ETDES0_CHECKSUM_INSERTION_SHIFT	22
 #define	ETDES0_TIME_STAMP_ENABLE	BIT(25)
 #define	ETDES0_DISABLE_PADDING		BIT(26)
 #define	ETDES0_CRC_DISABLE		BIT(27)
@@ -120,7 +114,6 @@
 /* TDES1 */
 #define	ETDES1_BUFFER1_SIZE_MASK	GENMASK(12, 0)
 #define	ETDES1_BUFFER2_SIZE_MASK	GENMASK(28, 16)
-#define	ETDES1_BUFFER2_SIZE_SHIFT	16
 
 /* Extended Receive descriptor definitions */
 #define	ERDES4_IP_PAYLOAD_TYPE_MASK	GENMASK(6, 2)
diff --git a/drivers/net/ethernet/stmicro/stmmac/descs_com.h b/drivers/net/ethernet/stmicro/stmmac/descs_com.h
index cb3bfc1571f9..9d1a94a4fa49 100644
--- a/drivers/net/ethernet/stmicro/stmmac/descs_com.h
+++ b/drivers/net/ethernet/stmicro/stmmac/descs_com.h
@@ -23,9 +23,8 @@ static inline void ehn_desc_rx_set_on_ring(struct dma_desc *p, int end,
 					   int bfsize)
 {
 	if (bfsize == BUF_SIZE_16KiB)
-		p->des1 |= cpu_to_le32((BUF_SIZE_8KiB
-				<< ERDES1_BUFFER2_SIZE_SHIFT)
-			   & ERDES1_BUFFER2_SIZE_MASK);
+		p->des1 |= cpu_to_le32(FIELD_PREP(ERDES1_BUFFER2_SIZE_MASK,
+						  BUF_SIZE_8KiB));
 
 	if (end)
 		p->des1 |= cpu_to_le32(ERDES1_END_RING);
@@ -45,12 +44,13 @@ static inline void enh_set_tx_desc_len_on_ring(struct dma_desc *p, int len)
 	unsigned int buffer1_max_length = BUF_SIZE_4KiB;
 
 	if (unlikely(len > buffer1_max_length)) {
-		p->des1 |= cpu_to_le32((((len - buffer1_max_length)
-					<< ETDES1_BUFFER2_SIZE_SHIFT)
-			    & ETDES1_BUFFER2_SIZE_MASK) | (buffer1_max_length
-			    & ETDES1_BUFFER1_SIZE_MASK));
+		p->des1 |= cpu_to_le32(FIELD_PREP(ETDES1_BUFFER2_SIZE_MASK,
+						  len - buffer1_max_length) |
+				       FIELD_PREP(ETDES1_BUFFER1_SIZE_MASK,
+						  buffer1_max_length));
 	} else {
-		p->des1 |= cpu_to_le32((len & ETDES1_BUFFER1_SIZE_MASK));
+		p->des1 |= cpu_to_le32(FIELD_PREP(ETDES1_BUFFER1_SIZE_MASK,
+						  len));
 	}
 }
 
@@ -61,8 +61,8 @@ static inline void ndesc_rx_set_on_ring(struct dma_desc *p, int end, int bfsize)
 		int bfsize2;
 
 		bfsize2 = min(bfsize - BUF_SIZE_2KiB + 1, BUF_SIZE_2KiB - 1);
-		p->des1 |= cpu_to_le32((bfsize2 << RDES1_BUFFER2_SIZE_SHIFT)
-			    & RDES1_BUFFER2_SIZE_MASK);
+		p->des1 |= cpu_to_le32(FIELD_PREP(RDES1_BUFFER2_SIZE_MASK,
+						  bfsize2));
 	}
 
 	if (end)
@@ -83,13 +83,13 @@ static inline void norm_set_tx_desc_len_on_ring(struct dma_desc *p, int len)
 	unsigned int buffer1_max_length = BUF_SIZE_2KiB - 1;
 
 	if (unlikely(len > buffer1_max_length)) {
-		unsigned int buffer1 = buffer1_max_length &
-				       TDES1_BUFFER1_SIZE_MASK;
-		p->des1 |= cpu_to_le32((((len - buffer1_max_length)
-					<< TDES1_BUFFER2_SIZE_SHIFT)
-				& TDES1_BUFFER2_SIZE_MASK) | buffer1);
+		p->des1 |= cpu_to_le32(FIELD_PREP(TDES1_BUFFER2_SIZE_MASK,
+						  len - buffer1_max_length) |
+				       FIELD_PREP(TDES1_BUFFER1_SIZE_MASK,
+						  buffer1_max_length));
 	} else {
-		p->des1 |= cpu_to_le32((len & TDES1_BUFFER1_SIZE_MASK));
+		p->des1 |= cpu_to_le32(FIELD_PREP(TDES1_BUFFER1_SIZE_MASK,
+						  len));
 	}
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
index cdef27c8043f..e226dc6a1b17 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
@@ -44,8 +44,7 @@ static int dwmac4_wrback_get_tx_status(struct stmmac_extra_stats *x,
 		if (unlikely((tdes3 & TDES3_LATE_COLLISION) ||
 			     (tdes3 & TDES3_EXCESSIVE_COLLISION)))
 			x->tx_collision +=
-			    (tdes3 & TDES3_COLLISION_COUNT_MASK)
-			    >> TDES3_COLLISION_COUNT_SHIFT;
+			    FIELD_GET(TDES3_COLLISION_COUNT_MASK, tdes3);
 
 		if (unlikely(tdes3 & TDES3_EXCESSIVE_DEFERRAL))
 			x->tx_deferred++;
@@ -166,8 +165,7 @@ static int dwmac4_wrback_get_rx_status(struct stmmac_extra_stats *x,
 		x->l3_filter_match++;
 	if (rdes2 & RDES2_L4_FILTER_MATCH)
 		x->l4_filter_match++;
-	if ((rdes2 & RDES2_L3_L4_FILT_NB_MATCH_MASK)
-	    >> RDES2_L3_L4_FILT_NB_MATCH_SHIFT)
+	if (rdes2 & RDES2_L3_L4_FILT_NB_MATCH_MASK)
 		x->l3_l4_filter_no_match++;
 
 	return ret;
@@ -256,12 +254,11 @@ static int dwmac4_rx_check_timestamp(void *desc)
 	u32 rdes0 = le32_to_cpu(p->des0);
 	u32 rdes1 = le32_to_cpu(p->des1);
 	u32 rdes3 = le32_to_cpu(p->des3);
-	u32 own, ctxt;
+	bool own, ctxt;
 	int ret = 1;
 
 	own = rdes3 & RDES3_OWN;
-	ctxt = ((rdes3 & RDES3_CONTEXT_DESCRIPTOR)
-		>> RDES3_CONTEXT_DESCRIPTOR_SHIFT);
+	ctxt = rdes3 & RDES3_CONTEXT_DESCRIPTOR;
 
 	if (likely(!own && ctxt)) {
 		if ((rdes0 == 0xffffffff) && (rdes1 == 0xffffffff))
@@ -335,10 +332,8 @@ static void dwmac4_rd_prepare_tx_desc(struct dma_desc *p, int is_fs, int len,
 	else
 		tdes3 &= ~TDES3_FIRST_DESCRIPTOR;
 
-	if (likely(csum_flag))
-		tdes3 |= (TX_CIC_FULL << TDES3_CHECKSUM_INSERTION_SHIFT);
-	else
-		tdes3 &= ~(TX_CIC_FULL << TDES3_CHECKSUM_INSERTION_SHIFT);
+	tdes3 = u32_replace_bits(tdes3, csum_flag ? TX_CIC_FULL : 0,
+				 TDES3_CHECKSUM_INSERTION_MASK);
 
 	if (ls)
 		tdes3 |= TDES3_LAST_DESCRIPTOR;
@@ -367,18 +362,18 @@ static void dwmac4_rd_prepare_tso_tx_desc(struct dma_desc *p, int is_fs,
 	u32 tdes3 = le32_to_cpu(p->des3);
 
 	if (len1)
-		p->des2 |= cpu_to_le32((len1 & TDES2_BUFFER1_SIZE_MASK));
+		p->des2 |= cpu_to_le32(FIELD_PREP(TDES2_BUFFER1_SIZE_MASK,
+						  len1));
 
 	if (len2)
-		p->des2 |= cpu_to_le32((len2 << TDES2_BUFFER2_SIZE_MASK_SHIFT)
-			    & TDES2_BUFFER2_SIZE_MASK);
+		p->des2 |= cpu_to_le32(FIELD_PREP(TDES2_BUFFER2_SIZE_MASK,
+						  len2));
 
 	if (is_fs) {
 		tdes3 |= TDES3_FIRST_DESCRIPTOR |
 			 TDES3_TCP_SEGMENTATION_ENABLE |
-			 ((tcphdrlen << TDES3_HDR_LEN_SHIFT) &
-			  TDES3_SLOT_NUMBER_MASK) |
-			 ((tcppayloadlen & TDES3_TCP_PKT_PAYLOAD_MASK));
+			 FIELD_PREP(TDES3_SLOT_NUMBER_MASK, tcphdrlen) |
+			 FIELD_PREP(TDES3_TCP_PKT_PAYLOAD_MASK, tcppayloadlen);
 	} else {
 		tdes3 &= ~TDES3_FIRST_DESCRIPTOR;
 	}
@@ -489,9 +484,8 @@ static void dwmac4_clear(struct dma_desc *p)
 
 static void dwmac4_set_sarc(struct dma_desc *p, u32 sarc_type)
 {
-	sarc_type <<= TDES3_SA_INSERT_CTRL_SHIFT;
-
-	p->des3 |= cpu_to_le32(sarc_type & TDES3_SA_INSERT_CTRL_MASK);
+	p->des3 |= cpu_to_le32(FIELD_PREP(TDES3_SA_INSERT_CTRL_MASK,
+					  sarc_type));
 }
 
 static int set_16kib_bfsize(int mtu)
@@ -513,14 +507,9 @@ static void dwmac4_set_vlan_tag(struct dma_desc *p, u16 tag, u16 inner_tag,
 
 	/* Inner VLAN */
 	if (inner_type) {
-		u32 des = inner_tag << TDES2_IVT_SHIFT;
-
-		des &= TDES2_IVT_MASK;
-		p->des2 = cpu_to_le32(des);
-
-		des = inner_type << TDES3_IVTIR_SHIFT;
-		des &= TDES3_IVTIR_MASK;
-		p->des3 = cpu_to_le32(des | TDES3_IVLTV);
+		p->des2 = cpu_to_le32(FIELD_PREP(TDES2_IVT_MASK, inner_tag));
+		p->des3 = cpu_to_le32(FIELD_PREP(TDES3_IVTIR_MASK, inner_type) |
+				      TDES3_IVLTV);
 	}
 
 	/* Outer VLAN */
@@ -532,8 +521,7 @@ static void dwmac4_set_vlan_tag(struct dma_desc *p, u16 tag, u16 inner_tag,
 
 static void dwmac4_set_vlan(struct dma_desc *p, u32 type)
 {
-	type <<= TDES2_VLAN_TAG_SHIFT;
-	p->des2 |= cpu_to_le32(type & TDES2_VLAN_TAG_MASK);
+	p->des2 |= cpu_to_le32(FIELD_PREP(TDES2_VLAN_TAG_MASK, type));
 }
 
 static void dwmac4_get_rx_header_len(struct dma_desc *p, unsigned int *len)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.h
index 806555976496..fb1fea5b0e6e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.h
@@ -18,15 +18,11 @@
 /* TDES2 (read format) */
 #define TDES2_BUFFER1_SIZE_MASK		GENMASK(13, 0)
 #define TDES2_VLAN_TAG_MASK		GENMASK(15, 14)
-#define TDES2_VLAN_TAG_SHIFT		14
 #define TDES2_BUFFER2_SIZE_MASK		GENMASK(29, 16)
-#define TDES2_BUFFER2_SIZE_MASK_SHIFT	16
 #define TDES3_IVTIR_MASK		GENMASK(19, 18)
-#define TDES3_IVTIR_SHIFT		18
 #define TDES3_IVLTV			BIT(17)
 #define TDES2_TIMESTAMP_ENABLE		BIT(30)
 #define TDES2_IVT_MASK			GENMASK(31, 16)
-#define TDES2_IVT_SHIFT			16
 #define TDES2_INTERRUPT_ON_COMPLETION	BIT(31)
 
 /* TDES3 (read format) */
@@ -34,13 +30,10 @@
 #define TDES3_VLAN_TAG			GENMASK(15, 0)
 #define TDES3_VLTV			BIT(16)
 #define TDES3_CHECKSUM_INSERTION_MASK	GENMASK(17, 16)
-#define TDES3_CHECKSUM_INSERTION_SHIFT	16
 #define TDES3_TCP_PKT_PAYLOAD_MASK	GENMASK(17, 0)
 #define TDES3_TCP_SEGMENTATION_ENABLE	BIT(18)
-#define TDES3_HDR_LEN_SHIFT		19
 #define TDES3_SLOT_NUMBER_MASK		GENMASK(22, 19)
 #define TDES3_SA_INSERT_CTRL_MASK	GENMASK(25, 23)
-#define TDES3_SA_INSERT_CTRL_SHIFT	23
 #define TDES3_CRC_PAD_CTRL_MASK		GENMASK(27, 26)
 
 /* TDES3 (write back format) */
@@ -49,7 +42,6 @@
 #define TDES3_UNDERFLOW_ERROR		BIT(2)
 #define TDES3_EXCESSIVE_DEFERRAL	BIT(3)
 #define TDES3_COLLISION_COUNT_MASK	GENMASK(7, 4)
-#define TDES3_COLLISION_COUNT_SHIFT	4
 #define TDES3_EXCESSIVE_COLLISION	BIT(8)
 #define TDES3_LATE_COLLISION		BIT(9)
 #define TDES3_NO_CARRIER		BIT(10)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index fecda3034d36..b07d99a3df1b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -423,32 +423,24 @@
 #define XGMAC_TDES0_LT			GENMASK(7, 0)
 #define XGMAC_TDES1_LT			GENMASK(31, 8)
 #define XGMAC_TDES2_IVT			GENMASK(31, 16)
-#define XGMAC_TDES2_IVT_SHIFT		16
 #define XGMAC_TDES2_IOC			BIT(31)
 #define XGMAC_TDES2_TTSE		BIT(30)
 #define XGMAC_TDES2_B2L			GENMASK(29, 16)
-#define XGMAC_TDES2_B2L_SHIFT		16
 #define XGMAC_TDES2_VTIR		GENMASK(15, 14)
-#define XGMAC_TDES2_VTIR_SHIFT		14
 #define XGMAC_TDES2_B1L			GENMASK(13, 0)
 #define XGMAC_TDES3_OWN			BIT(31)
 #define XGMAC_TDES3_CTXT		BIT(30)
 #define XGMAC_TDES3_FD			BIT(29)
 #define XGMAC_TDES3_LD			BIT(28)
 #define XGMAC_TDES3_CPC			GENMASK(27, 26)
-#define XGMAC_TDES3_CPC_SHIFT		26
 #define XGMAC_TDES3_TCMSSV		BIT(26)
 #define XGMAC_TDES3_SAIC		GENMASK(25, 23)
-#define XGMAC_TDES3_SAIC_SHIFT		23
 #define XGMAC_TDES3_TBSV		BIT(24)
 #define XGMAC_TDES3_THL			GENMASK(22, 19)
-#define XGMAC_TDES3_THL_SHIFT		19
 #define XGMAC_TDES3_IVTIR		GENMASK(19, 18)
-#define XGMAC_TDES3_IVTIR_SHIFT		18
 #define XGMAC_TDES3_TSE			BIT(18)
 #define XGMAC_TDES3_IVLTV		BIT(17)
 #define XGMAC_TDES3_CIC			GENMASK(17, 16)
-#define XGMAC_TDES3_CIC_SHIFT		16
 #define XGMAC_TDES3_TPL			GENMASK(17, 0)
 #define XGMAC_TDES3_VLTV		BIT(16)
 #define XGMAC_TDES3_VT			GENMASK(15, 0)
@@ -461,7 +453,6 @@
 #define XGMAC_RDES3_CDA			BIT(27)
 #define XGMAC_RDES3_RSV			BIT(26)
 #define XGMAC_RDES3_L34T		GENMASK(23, 20)
-#define XGMAC_RDES3_L34T_SHIFT		20
 #define XGMAC_RDES3_ET_LT		GENMASK(19, 16)
 #define XGMAC_L34T_IP4TCP		0x1
 #define XGMAC_L34T_IP4UDP		0x2
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
index b13d24c8b52a..41e5b420a215 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
@@ -173,7 +173,7 @@ static void dwxgmac2_prepare_tx_desc(struct dma_desc *p, int is_fs, int len,
 		tdes3 &= ~XGMAC_TDES3_FD;
 
 	if (csum_flag)
-		tdes3 |= 0x3 << XGMAC_TDES3_CIC_SHIFT;
+		tdes3 |= FIELD_PREP(XGMAC_TDES3_CIC, 0x3);
 	else
 		tdes3 &= ~XGMAC_TDES3_CIC;
 
@@ -206,13 +206,11 @@ static void dwxgmac2_prepare_tso_tx_desc(struct dma_desc *p, int is_fs,
 	if (len1)
 		p->des2 |= cpu_to_le32(len1 & XGMAC_TDES2_B1L);
 	if (len2)
-		p->des2 |= cpu_to_le32((len2 << XGMAC_TDES2_B2L_SHIFT) &
-				XGMAC_TDES2_B2L);
+		p->des2 |= cpu_to_le32(FIELD_PREP(XGMAC_TDES2_B2L, len2));
 	if (is_fs) {
 		tdes3 |= XGMAC_TDES3_FD | XGMAC_TDES3_TSE;
-		tdes3 |= (tcphdrlen << XGMAC_TDES3_THL_SHIFT) &
-			XGMAC_TDES3_THL;
-		tdes3 |= tcppayloadlen & XGMAC_TDES3_TPL;
+		tdes3 |= FIELD_PREP(XGMAC_TDES3_THL, tcphdrlen);
+		tdes3 |= FIELD_PREP(XGMAC_TDES3_TPL, tcppayloadlen);
 	} else {
 		tdes3 &= ~XGMAC_TDES3_FD;
 	}
@@ -278,7 +276,7 @@ static int dwxgmac2_get_rx_hash(struct dma_desc *p, u32 *hash,
 	u32 ptype;
 
 	if (rdes3 & XGMAC_RDES3_RSV) {
-		ptype = (rdes3 & XGMAC_RDES3_L34T) >> XGMAC_RDES3_L34T_SHIFT;
+		ptype = FIELD_GET(XGMAC_RDES3_L34T, rdes3);
 
 		switch (ptype) {
 		case XGMAC_L34T_IP4TCP:
@@ -313,9 +311,7 @@ static void dwxgmac2_set_sec_addr(struct dma_desc *p, dma_addr_t addr, bool is_v
 
 static void dwxgmac2_set_sarc(struct dma_desc *p, u32 sarc_type)
 {
-	sarc_type <<= XGMAC_TDES3_SAIC_SHIFT;
-
-	p->des3 |= cpu_to_le32(sarc_type & XGMAC_TDES3_SAIC);
+	p->des3 |= cpu_to_le32(FIELD_PREP(XGMAC_TDES3_SAIC, sarc_type));
 }
 
 static void dwxgmac2_set_vlan_tag(struct dma_desc *p, u16 tag, u16 inner_tag,
@@ -328,13 +324,11 @@ static void dwxgmac2_set_vlan_tag(struct dma_desc *p, u16 tag, u16 inner_tag,
 
 	/* Inner VLAN */
 	if (inner_type) {
-		u32 des = inner_tag << XGMAC_TDES2_IVT_SHIFT;
+		u32 des = FIELD_PREP(XGMAC_TDES2_IVT, inner_tag);
 
-		des &= XGMAC_TDES2_IVT;
 		p->des2 = cpu_to_le32(des);
 
-		des = inner_type << XGMAC_TDES3_IVTIR_SHIFT;
-		des &= XGMAC_TDES3_IVTIR;
+		des = FIELD_PREP(XGMAC_TDES3_IVTIR, inner_type);
 		p->des3 = cpu_to_le32(des | XGMAC_TDES3_IVLTV);
 	}
 
@@ -347,8 +341,7 @@ static void dwxgmac2_set_vlan_tag(struct dma_desc *p, u16 tag, u16 inner_tag,
 
 static void dwxgmac2_set_vlan(struct dma_desc *p, u32 type)
 {
-	type <<= XGMAC_TDES2_VTIR_SHIFT;
-	p->des2 |= cpu_to_le32(type & XGMAC_TDES2_VTIR);
+	p->des2 |= cpu_to_le32(FIELD_PREP(XGMAC_TDES2_VTIR, type));
 }
 
 static void dwxgmac2_set_tbs(struct dma_edesc *p, u32 sec, u32 nsec)
diff --git a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
index 9263be969c36..d571241e64dd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
@@ -44,7 +44,7 @@ static int enh_desc_get_tx_status(struct stmmac_extra_stats *x,
 		if (unlikely((tdes0 & ETDES0_LATE_COLLISION) ||
 			     (tdes0 & ETDES0_EXCESSIVE_COLLISIONS)))
 			x->tx_collision +=
-				(tdes0 & ETDES0_COLLISION_COUNT_MASK) >> 3;
+				FIELD_GET(ETDES0_COLLISION_COUNT_MASK, tdes0);
 
 		if (unlikely(tdes0 & ETDES0_EXCESSIVE_DEFERRAL))
 			x->tx_deferred++;
@@ -121,7 +121,7 @@ static void enh_desc_get_ext_status(struct stmmac_extra_stats *x,
 	u32 rdes4 = le32_to_cpu(p->des4);
 
 	if (unlikely(rdes0 & ERDES0_RX_MAC_ADDR)) {
-		int message_type = (rdes4 & ERDES4_MSG_TYPE_MASK) >> 8;
+		int message_type = FIELD_GET(ERDES4_MSG_TYPE_MASK, rdes4);
 
 		if (rdes4 & ERDES4_IP_HDR_ERR)
 			x->ip_hdr_err++;
@@ -167,13 +167,13 @@ static void enh_desc_get_ext_status(struct stmmac_extra_stats *x,
 			x->av_pkt_rcvd++;
 		if (rdes4 & ERDES4_AV_TAGGED_PKT_RCVD)
 			x->av_tagged_pkt_rcvd++;
-		if ((rdes4 & ERDES4_VLAN_TAG_PRI_VAL_MASK) >> 18)
+		if (rdes4 & ERDES4_VLAN_TAG_PRI_VAL_MASK)
 			x->vlan_tag_priority_val++;
 		if (rdes4 & ERDES4_L3_FILTER_MATCH)
 			x->l3_filter_match++;
 		if (rdes4 & ERDES4_L4_FILTER_MATCH)
 			x->l4_filter_match++;
-		if ((rdes4 & ERDES4_L3_L4_FILT_NO_MATCH_MASK) >> 26)
+		if (rdes4 & ERDES4_L3_L4_FILT_NO_MATCH_MASK)
 			x->l3_l4_filter_no_match++;
 	}
 }
@@ -324,10 +324,8 @@ static void enh_desc_prepare_tx_desc(struct dma_desc *p, int is_fs, int len,
 	else
 		tdes0 &= ~ETDES0_FIRST_SEGMENT;
 
-	if (likely(csum_flag))
-		tdes0 |= (TX_CIC_FULL << ETDES0_CHECKSUM_INSERTION_SHIFT);
-	else
-		tdes0 &= ~(TX_CIC_FULL << ETDES0_CHECKSUM_INSERTION_SHIFT);
+	tdes0 = u32_replace_bits(tdes0, csum_flag ? TX_CIC_FULL : 0,
+				 ETDES0_CHECKSUM_INSERTION_MASK);
 
 	if (ls)
 		tdes0 |= ETDES0_LAST_SEGMENT;
@@ -363,8 +361,7 @@ static int enh_desc_get_rx_frame_len(struct dma_desc *p, int rx_coe_type)
 	if (rx_coe_type == STMMAC_RX_COE_TYPE1)
 		csum = 2;
 
-	return (((le32_to_cpu(p->des0) & RDES0_FRAME_LEN_MASK)
-				>> RDES0_FRAME_LEN_SHIFT) - csum);
+	return FIELD_GET(RDES0_FRAME_LEN_MASK, le32_to_cpu(p->des0)) - csum;
 }
 
 static void enh_desc_enable_tx_timestamp(struct dma_desc *p)
diff --git a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
index dbfff25947b0..859cb9242a52 100644
--- a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
@@ -40,10 +40,8 @@ static int ndesc_get_tx_status(struct stmmac_extra_stats *x,
 		if (unlikely((tdes0 & TDES0_EXCESSIVE_DEFERRAL) ||
 			     (tdes0 & TDES0_EXCESSIVE_COLLISIONS) ||
 			     (tdes0 & TDES0_LATE_COLLISION))) {
-			unsigned int collisions;
-
-			collisions = (tdes0 & TDES0_COLLISION_COUNT_MASK) >> 3;
-			x->tx_collision += collisions;
+			x->tx_collision +=
+				FIELD_GET(TDES0_COLLISION_COUNT_MASK, tdes0);
 		}
 		ret = tx_err;
 	}
@@ -185,10 +183,8 @@ static void ndesc_prepare_tx_desc(struct dma_desc *p, int is_fs, int len,
 	else
 		tdes1 &= ~TDES1_FIRST_SEGMENT;
 
-	if (likely(csum_flag))
-		tdes1 |= (TX_CIC_FULL) << TDES1_CHECKSUM_INSERTION_SHIFT;
-	else
-		tdes1 &= ~(TX_CIC_FULL << TDES1_CHECKSUM_INSERTION_SHIFT);
+	tdes1 = u32_replace_bits(tdes1, csum_flag ? TX_CIC_FULL : 0,
+				 TDES1_CHECKSUM_INSERTION_MASK);
 
 	if (ls)
 		tdes1 |= TDES1_LAST_SEGMENT;
@@ -222,10 +218,7 @@ static int ndesc_get_rx_frame_len(struct dma_desc *p, int rx_coe_type)
 	if (rx_coe_type == STMMAC_RX_COE_TYPE1)
 		csum = 2;
 
-	return (((le32_to_cpu(p->des0) & RDES0_FRAME_LEN_MASK)
-				>> RDES0_FRAME_LEN_SHIFT) -
-		csum);
-
+	return FIELD_GET(RDES0_FRAME_LEN_MASK, le32_to_cpu(p->des0)) - csum;
 }
 
 static void ndesc_enable_tx_timestamp(struct dma_desc *p)
-- 
2.47.3


