Return-Path: <netdev+bounces-247462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B95A4CFAF57
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 21:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F27C30E64FD
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 20:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CE32D7398;
	Tue,  6 Jan 2026 20:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="v8vNC1tB"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466842D1F40
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 20:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767731513; cv=none; b=Jvwm1b6iFaDm6b1FuwtXwiARtDhdXBj8bahGofeVmA8oZFfZZdPRynHst/iKM3nbAxT2EKKDcwNUku22JNxtxtjPhnWzpUBwRCGMWjP+EYeS7Zo5+D81Z1m+9gvXAUTbx2fqxbXqkDyA5r1cfABsVNurgJLpK3nleh2LWwQDAqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767731513; c=relaxed/simple;
	bh=3slVdGsdQ4q8BLYaAWrM8tKz7c6P3gReoSYofueAfZQ=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Dhdmt6A/MLprZ6VpxnsjvwTGiIUK5T1vX5j66s4Gu7TQFYFbhQaLViHThf9CZYQkAFoqtMOLKuOTLwrb2Xfw8KO3zJ7GyTYGZ3FLhfCGQs9nLy3+qDjKjYAfbHEJ6q88E+Pb6gPLieBs07p7TCbXtAL4IxIA8bVMCXI9T7sZjMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=v8vNC1tB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=93JjdUwF9hjwXTjNo2xkPYag3gxEGcoQouegqZmcKPU=; b=v8vNC1tBCPsY231cqZ11D0SKMA
	/gM1jwfXuUkbRRCtyCmnK30KP2BdQ1vFaPHSmymtzK1soSvJpzeQvfEESryl9H2kbDVYtIwVLb0mE
	HSl0+A02PVX+fVzM+XT+Ms9/IdkUJG8+LeGw/DAUz6GZ2IzV8LLIgDwLnLeZAOxmBUDhaaJkFQV6C
	Bv2l2jBeMhOeOMaJX8hexmbEJihpdZM8AAa0Kxpy2puzhRZcEiUUY4mPUWtHOCSwv33JVhYNDDyqP
	T5/0SUujLeMh1o0dZlcqM9L7DpOF0Myh+DmkD6YyvJuOjx/B4sRlHWl84kChKV7et9rvpP4J1XLmU
	modeWdKA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38094 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vdDiM-0000000011i-18om;
	Tue, 06 Jan 2026 20:31:38 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vdDiK-00000002E1j-3xlF;
	Tue, 06 Jan 2026 20:31:36 +0000
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
Subject: [PATCH net-next 5/9] net: stmmac: descs: use u32 for descriptors
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vdDiK-00000002E1j-3xlF@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 06 Jan 2026 20:31:36 +0000

Use u32 rather than unsigned int for 32-bit descriptor variables.
This will allow the u32 bitfield helpers to be used.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../ethernet/stmicro/stmmac/dwmac4_descs.c    | 20 +++++++++----------
 .../ethernet/stmicro/stmmac/dwxgmac2_descs.c  | 14 ++++++-------
 .../net/ethernet/stmicro/stmmac/enh_desc.c    | 10 +++++-----
 .../net/ethernet/stmicro/stmmac/norm_desc.c   |  8 ++++----
 4 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
index c84b26d51760..cdef27c8043f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
@@ -17,11 +17,9 @@ static int dwmac4_wrback_get_tx_status(struct stmmac_extra_stats *x,
 				       struct dma_desc *p,
 				       void __iomem *ioaddr)
 {
-	unsigned int tdes3;
+	u32 tdes3 = le32_to_cpu(p->des3);
 	int ret = tx_done;
 
-	tdes3 = le32_to_cpu(p->des3);
-
 	/* Get tx owner first */
 	if (unlikely(tdes3 & TDES3_OWN))
 		return tx_dma_own;
@@ -73,9 +71,9 @@ static int dwmac4_wrback_get_tx_status(struct stmmac_extra_stats *x,
 static int dwmac4_wrback_get_rx_status(struct stmmac_extra_stats *x,
 				       struct dma_desc *p)
 {
-	unsigned int rdes1 = le32_to_cpu(p->des1);
-	unsigned int rdes2 = le32_to_cpu(p->des2);
-	unsigned int rdes3 = le32_to_cpu(p->des3);
+	u32 rdes1 = le32_to_cpu(p->des1);
+	u32 rdes2 = le32_to_cpu(p->des2);
+	u32 rdes3 = le32_to_cpu(p->des3);
 	int message_type;
 	int ret = good_frame;
 
@@ -255,9 +253,9 @@ static inline void dwmac4_get_timestamp(void *desc, u32 ats, u64 *ts)
 static int dwmac4_rx_check_timestamp(void *desc)
 {
 	struct dma_desc *p = (struct dma_desc *)desc;
-	unsigned int rdes0 = le32_to_cpu(p->des0);
-	unsigned int rdes1 = le32_to_cpu(p->des1);
-	unsigned int rdes3 = le32_to_cpu(p->des3);
+	u32 rdes0 = le32_to_cpu(p->des0);
+	u32 rdes1 = le32_to_cpu(p->des1);
+	u32 rdes3 = le32_to_cpu(p->des3);
 	u32 own, ctxt;
 	int ret = 1;
 
@@ -327,7 +325,7 @@ static void dwmac4_rd_prepare_tx_desc(struct dma_desc *p, int is_fs, int len,
 				      bool csum_flag, int mode, bool tx_own,
 				      bool ls, unsigned int tot_pkt_len)
 {
-	unsigned int tdes3 = le32_to_cpu(p->des3);
+	u32 tdes3 = le32_to_cpu(p->des3);
 
 	p->des2 |= cpu_to_le32(len & TDES2_BUFFER1_SIZE_MASK);
 
@@ -366,7 +364,7 @@ static void dwmac4_rd_prepare_tso_tx_desc(struct dma_desc *p, int is_fs,
 					  bool ls, unsigned int tcphdrlen,
 					  unsigned int tcppayloadlen)
 {
-	unsigned int tdes3 = le32_to_cpu(p->des3);
+	u32 tdes3 = le32_to_cpu(p->des3);
 
 	if (len1)
 		p->des2 |= cpu_to_le32((len1 & TDES2_BUFFER1_SIZE_MASK));
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
index a2980482fcce..b13d24c8b52a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
@@ -12,7 +12,7 @@
 static int dwxgmac2_get_tx_status(struct stmmac_extra_stats *x,
 				  struct dma_desc *p, void __iomem *ioaddr)
 {
-	unsigned int tdes3 = le32_to_cpu(p->des3);
+	u32 tdes3 = le32_to_cpu(p->des3);
 	int ret = tx_done;
 
 	if (unlikely(tdes3 & XGMAC_TDES3_OWN))
@@ -26,7 +26,7 @@ static int dwxgmac2_get_tx_status(struct stmmac_extra_stats *x,
 static int dwxgmac2_get_rx_status(struct stmmac_extra_stats *x,
 				  struct dma_desc *p)
 {
-	unsigned int rdes3 = le32_to_cpu(p->des3);
+	u32 rdes3 = le32_to_cpu(p->des3);
 
 	if (unlikely(rdes3 & XGMAC_RDES3_OWN))
 		return dma_own;
@@ -114,7 +114,7 @@ static inline void dwxgmac2_get_timestamp(void *desc, u32 ats, u64 *ts)
 static int dwxgmac2_rx_check_timestamp(void *desc)
 {
 	struct dma_desc *p = (struct dma_desc *)desc;
-	unsigned int rdes3 = le32_to_cpu(p->des3);
+	u32 rdes3 = le32_to_cpu(p->des3);
 	bool desc_valid, ts_valid;
 
 	dma_rmb();
@@ -135,7 +135,7 @@ static int dwxgmac2_get_rx_timestamp_status(void *desc, void *next_desc,
 					    u32 ats)
 {
 	struct dma_desc *p = (struct dma_desc *)desc;
-	unsigned int rdes3 = le32_to_cpu(p->des3);
+	u32 rdes3 = le32_to_cpu(p->des3);
 	int ret = -EBUSY;
 
 	if (likely(rdes3 & XGMAC_RDES3_CDA))
@@ -162,7 +162,7 @@ static void dwxgmac2_prepare_tx_desc(struct dma_desc *p, int is_fs, int len,
 				     bool csum_flag, int mode, bool tx_own,
 				     bool ls, unsigned int tot_pkt_len)
 {
-	unsigned int tdes3 = le32_to_cpu(p->des3);
+	u32 tdes3 = le32_to_cpu(p->des3);
 
 	p->des2 |= cpu_to_le32(len & XGMAC_TDES2_B1L);
 
@@ -201,7 +201,7 @@ static void dwxgmac2_prepare_tso_tx_desc(struct dma_desc *p, int is_fs,
 					 bool ls, unsigned int tcphdrlen,
 					 unsigned int tcppayloadlen)
 {
-	unsigned int tdes3 = le32_to_cpu(p->des3);
+	u32 tdes3 = le32_to_cpu(p->des3);
 
 	if (len1)
 		p->des2 |= cpu_to_le32(len1 & XGMAC_TDES2_B1L);
@@ -274,7 +274,7 @@ static void dwxgmac2_clear(struct dma_desc *p)
 static int dwxgmac2_get_rx_hash(struct dma_desc *p, u32 *hash,
 				enum pkt_hash_types *type)
 {
-	unsigned int rdes3 = le32_to_cpu(p->des3);
+	u32 rdes3 = le32_to_cpu(p->des3);
 	u32 ptype;
 
 	if (rdes3 & XGMAC_RDES3_RSV) {
diff --git a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
index 937b7a0466fc..9263be969c36 100644
--- a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
@@ -15,7 +15,7 @@
 static int enh_desc_get_tx_status(struct stmmac_extra_stats *x,
 				  struct dma_desc *p, void __iomem *ioaddr)
 {
-	unsigned int tdes0 = le32_to_cpu(p->des0);
+	u32 tdes0 = le32_to_cpu(p->des0);
 	int ret = tx_done;
 
 	/* Get tx owner first */
@@ -117,8 +117,8 @@ static int enh_desc_coe_rdes0(int ipc_err, int type, int payload_err)
 static void enh_desc_get_ext_status(struct stmmac_extra_stats *x,
 				    struct dma_extended_desc *p)
 {
-	unsigned int rdes0 = le32_to_cpu(p->basic.des0);
-	unsigned int rdes4 = le32_to_cpu(p->des4);
+	u32 rdes0 = le32_to_cpu(p->basic.des0);
+	u32 rdes4 = le32_to_cpu(p->des4);
 
 	if (unlikely(rdes0 & ERDES0_RX_MAC_ADDR)) {
 		int message_type = (rdes4 & ERDES4_MSG_TYPE_MASK) >> 8;
@@ -181,7 +181,7 @@ static void enh_desc_get_ext_status(struct stmmac_extra_stats *x,
 static int enh_desc_get_rx_status(struct stmmac_extra_stats *x,
 				  struct dma_desc *p)
 {
-	unsigned int rdes0 = le32_to_cpu(p->des0);
+	u32 rdes0 = le32_to_cpu(p->des0);
 	int ret = good_frame;
 
 	if (unlikely(rdes0 & RDES0_OWN))
@@ -312,7 +312,7 @@ static void enh_desc_prepare_tx_desc(struct dma_desc *p, int is_fs, int len,
 				     bool csum_flag, int mode, bool tx_own,
 				     bool ls, unsigned int tot_pkt_len)
 {
-	unsigned int tdes0 = le32_to_cpu(p->des0);
+	u32 tdes0 = le32_to_cpu(p->des0);
 
 	if (mode == STMMAC_CHAIN_MODE)
 		enh_set_tx_desc_len_on_chain(p, len);
diff --git a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
index 68a7cfcb1d8f..dbfff25947b0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
@@ -15,8 +15,8 @@
 static int ndesc_get_tx_status(struct stmmac_extra_stats *x,
 			       struct dma_desc *p, void __iomem *ioaddr)
 {
-	unsigned int tdes0 = le32_to_cpu(p->des0);
-	unsigned int tdes1 = le32_to_cpu(p->des1);
+	u32 tdes0 = le32_to_cpu(p->des0);
+	u32 tdes1 = le32_to_cpu(p->des1);
 	int ret = tx_done;
 
 	/* Get tx owner first */
@@ -69,8 +69,8 @@ static int ndesc_get_tx_len(struct dma_desc *p)
 static int ndesc_get_rx_status(struct stmmac_extra_stats *x,
 			       struct dma_desc *p)
 {
+	u32 rdes0 = le32_to_cpu(p->des0);
 	int ret = good_frame;
-	unsigned int rdes0 = le32_to_cpu(p->des0);
 
 	if (unlikely(rdes0 & RDES0_OWN))
 		return dma_own;
@@ -178,7 +178,7 @@ static void ndesc_prepare_tx_desc(struct dma_desc *p, int is_fs, int len,
 				  bool csum_flag, int mode, bool tx_own,
 				  bool ls, unsigned int tot_pkt_len)
 {
-	unsigned int tdes1 = le32_to_cpu(p->des1);
+	u32 tdes1 = le32_to_cpu(p->des1);
 
 	if (is_fs)
 		tdes1 |= TDES1_FIRST_SEGMENT;
-- 
2.47.3


