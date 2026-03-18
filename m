Return-Path: <netdev+bounces-269151-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHQHEPP0ummVdQIAu9opvQ
	(envelope-from <netdev+bounces-269151-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 19:54:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 410492C1A81
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 19:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ED8DF3073DCE
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 18:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC5B3CF697;
	Wed, 18 Mar 2026 18:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UXH24HS2"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DD73BFE33
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 18:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773858407; cv=none; b=u6AcPQTLeJXKOs3JsZC8yWWw4B2Vv9QwC4zNDppJhNB1Ow/Kd8kheVoHy4eQEqvjvaF2WM5lR3FtOFJMbe/3OERxqGnQlEudsFjV/Vg3C6E/1iUbKS/zfBNhB24x5R9F3+bDYP9NUfCl4eLUhT7iHdtn2vchER4hfirq/cMNPU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773858407; c=relaxed/simple;
	bh=WnM7S5G5TPG4f44C9iXPIQgfwGq9oHVh/nsex+A6abE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ZnEYfSbj60qzSpli9mV8STCAWMXBldweewph+sV9P+lGe3krVR7PyrXffKqAQVvMU3wYnniuQhOjQ/BJA9zArFrKkqg7XjAJJNMUrqfL4ANx/B1Pff7Sykf7BClkFF4TDSV093I/vZSw7DhfldhmvG8csvahQ8V2S7Dev28FxLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=UXH24HS2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aG0MZ1FrqlLkIWWb0/pP6zOGbt5rJFmJ6VnrEOyxv8M=; b=UXH24HS24wHx9n3ZrU1w+ZQ/tc
	N7DWsOAZ/Lw6v80LZ0VcxyCkN0SKsC/y1rmvib7tkyTxIIWrO4EmMlOY+U37hm1W4qxp0Zgi80Es4
	uivU+57+tSrmiehBOR+NSM82z/+6mmxagZk67p/+T53qdq+XjaBUVqYt66pU6ZaW+ZMVpnocctxqq
	v6L+ODUUQTDMIXLI06oo+4wTalaWh/RUMLJ9/UxvLjarZYSQJZTmI/+F6XQ2blQL8EYWPEsJ/jjit
	aHMhxacfhFhT9wIxFKecdjPvy5ZwFzeOhij09hCz0K/xO2kFJQbW8J+M9CV4HHLWna+Flp7DE+4o/
	xNLmeCNA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44958 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w2vbL-000000003pF-3WOT;
	Wed, 18 Mar 2026 18:26:39 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w2vbL-0000000DbWW-0PON;
	Wed, 18 Mar 2026 18:26:39 +0000
In-Reply-To: <abruRQpjLyMkoUEP@shell.armlinux.org.uk>
References: <abruRQpjLyMkoUEP@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 2/5] net: stmmac: more mode -> descriptor_mode
 renames
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w2vbL-0000000DbWW-0PON@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 18 Mar 2026 18:26:39 +0000
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269151-lists,netdev=lfdr.de,kernel];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.577];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,armlinux.org.uk:email,rmk-PC.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 410492C1A81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../ethernet/stmicro/stmmac/dwmac4_descs.c    | 12 ++++++-----
 .../ethernet/stmicro/stmmac/dwxgmac2_descs.c  | 12 ++++++-----
 .../net/ethernet/stmicro/stmmac/enh_desc.c    | 20 ++++++++++--------
 drivers/net/ethernet/stmicro/stmmac/hwif.h    | 12 +++++------
 .../net/ethernet/stmicro/stmmac/norm_desc.c   | 21 ++++++++++---------
 5 files changed, 42 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
index d5c003f3fbbc..2994df41ec2c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
@@ -289,12 +289,13 @@ static int dwmac4_wrback_get_rx_timestamp_status(void *desc, void *next_desc,
 }
 
 static void dwmac4_rd_init_rx_desc(struct dma_desc *p, int disable_rx_ic,
-				   int mode, int end, int bfsize)
+				   u8 descriptor_mode, int end, int bfsize)
 {
 	dwmac4_set_rx_owner(p, disable_rx_ic);
 }
 
-static void dwmac4_rd_init_tx_desc(struct dma_desc *p, int mode, int end)
+static void dwmac4_rd_init_tx_desc(struct dma_desc *p, u8 descriptor_mode,
+				   int end)
 {
 	p->des0 = 0;
 	p->des1 = 0;
@@ -303,8 +304,9 @@ static void dwmac4_rd_init_tx_desc(struct dma_desc *p, int mode, int end)
 }
 
 static void dwmac4_rd_prepare_tx_desc(struct dma_desc *p, int is_fs, int len,
-				      bool csum_flag, int mode, bool tx_own,
-				      bool ls, unsigned int tot_pkt_len)
+				      bool csum_flag, u8 descriptor_mode,
+				      bool tx_own, bool ls,
+				      unsigned int tot_pkt_len)
 {
 	u32 tdes3 = le32_to_cpu(p->des3);
 
@@ -381,7 +383,7 @@ static void dwmac4_rd_prepare_tso_tx_desc(struct dma_desc *p, int is_fs,
 	p->des3 = cpu_to_le32(tdes3);
 }
 
-static void dwmac4_release_tx_desc(struct dma_desc *p, int mode)
+static void dwmac4_release_tx_desc(struct dma_desc *p, u8 descriptor_mode)
 {
 	p->des0 = 0;
 	p->des1 = 0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
index 1009ef436a1e..b5f200a87484 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
@@ -130,12 +130,13 @@ static int dwxgmac2_get_rx_timestamp_status(void *desc, void *next_desc,
 }
 
 static void dwxgmac2_init_rx_desc(struct dma_desc *p, int disable_rx_ic,
-				  int mode, int end, int bfsize)
+				  u8 descriptor_mode, int end, int bfsize)
 {
 	dwxgmac2_set_rx_owner(p, disable_rx_ic);
 }
 
-static void dwxgmac2_init_tx_desc(struct dma_desc *p, int mode, int end)
+static void dwxgmac2_init_tx_desc(struct dma_desc *p, u8 descriptor_mode,
+				  int end)
 {
 	p->des0 = 0;
 	p->des1 = 0;
@@ -144,8 +145,9 @@ static void dwxgmac2_init_tx_desc(struct dma_desc *p, int mode, int end)
 }
 
 static void dwxgmac2_prepare_tx_desc(struct dma_desc *p, int is_fs, int len,
-				     bool csum_flag, int mode, bool tx_own,
-				     bool ls, unsigned int tot_pkt_len)
+				     bool csum_flag, u8 descriptor_mode,
+				     bool tx_own, bool ls,
+				     unsigned int tot_pkt_len)
 {
 	u32 tdes3 = le32_to_cpu(p->des3);
 
@@ -219,7 +221,7 @@ static void dwxgmac2_prepare_tso_tx_desc(struct dma_desc *p, int is_fs,
 	p->des3 = cpu_to_le32(tdes3);
 }
 
-static void dwxgmac2_release_tx_desc(struct dma_desc *p, int mode)
+static void dwxgmac2_release_tx_desc(struct dma_desc *p, u8 descriptor_mode)
 {
 	p->des0 = 0;
 	p->des1 = 0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
index ead468f4b645..051253601225 100644
--- a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
@@ -245,7 +245,7 @@ static int enh_desc_get_rx_status(struct stmmac_extra_stats *x,
 }
 
 static void enh_desc_init_rx_desc(struct dma_desc *p, int disable_rx_ic,
-				  int mode, int end, int bfsize)
+				  u8 descriptor_mode, int end, int bfsize)
 {
 	int bfsize1;
 
@@ -254,7 +254,7 @@ static void enh_desc_init_rx_desc(struct dma_desc *p, int disable_rx_ic,
 	bfsize1 = min(bfsize, BUF_SIZE_8KiB);
 	p->des1 |= cpu_to_le32(bfsize1 & ERDES1_BUFFER1_SIZE_MASK);
 
-	if (mode == STMMAC_CHAIN_MODE)
+	if (descriptor_mode == STMMAC_CHAIN_MODE)
 		ehn_desc_rx_set_on_chain(p);
 	else
 		ehn_desc_rx_set_on_ring(p, end, bfsize);
@@ -263,10 +263,11 @@ static void enh_desc_init_rx_desc(struct dma_desc *p, int disable_rx_ic,
 		p->des1 |= cpu_to_le32(ERDES1_DISABLE_IC);
 }
 
-static void enh_desc_init_tx_desc(struct dma_desc *p, int mode, int end)
+static void enh_desc_init_tx_desc(struct dma_desc *p, u8 descriptor_mode,
+				  int end)
 {
 	p->des0 &= cpu_to_le32(~ETDES0_OWN);
-	if (mode == STMMAC_CHAIN_MODE)
+	if (descriptor_mode == STMMAC_CHAIN_MODE)
 		enh_desc_end_tx_desc_on_chain(p);
 	else
 		enh_desc_end_tx_desc_on_ring(p, end);
@@ -282,24 +283,25 @@ static void enh_desc_set_rx_owner(struct dma_desc *p, int disable_rx_ic)
 	p->des0 |= cpu_to_le32(RDES0_OWN);
 }
 
-static void enh_desc_release_tx_desc(struct dma_desc *p, int mode)
+static void enh_desc_release_tx_desc(struct dma_desc *p, u8 descriptor_mode)
 {
 	int ter = (le32_to_cpu(p->des0) & ETDES0_END_RING) >> 21;
 
 	memset(p, 0, offsetof(struct dma_desc, des2));
-	if (mode == STMMAC_CHAIN_MODE)
+	if (descriptor_mode == STMMAC_CHAIN_MODE)
 		enh_desc_end_tx_desc_on_chain(p);
 	else
 		enh_desc_end_tx_desc_on_ring(p, ter);
 }
 
 static void enh_desc_prepare_tx_desc(struct dma_desc *p, int is_fs, int len,
-				     bool csum_flag, int mode, bool tx_own,
-				     bool ls, unsigned int tot_pkt_len)
+				     bool csum_flag, u8 descriptor_mode,
+				     bool tx_own,  bool ls,
+				     unsigned int tot_pkt_len)
 {
 	u32 tdes0 = le32_to_cpu(p->des0);
 
-	if (mode == STMMAC_CHAIN_MODE)
+	if (descriptor_mode == STMMAC_CHAIN_MODE)
 		enh_set_tx_desc_len_on_chain(p, len);
 	else
 		enh_set_tx_desc_len_on_ring(p, len);
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 010b4d32484a..e6317b94fff7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -38,21 +38,21 @@ struct dma_edesc;
 /* Descriptors helpers */
 struct stmmac_desc_ops {
 	/* DMA RX descriptor ring initialization */
-	void (*init_rx_desc)(struct dma_desc *p, int disable_rx_ic, int mode,
-			int end, int bfsize);
+	void (*init_rx_desc)(struct dma_desc *p, int disable_rx_ic,
+			     u8 descriptor_mode, int end, int bfsize);
 	/* DMA TX descriptor ring initialization */
-	void (*init_tx_desc)(struct dma_desc *p, int mode, int end);
+	void (*init_tx_desc)(struct dma_desc *p, u8 descriptor_mode, int end);
 	/* Invoked by the xmit function to prepare the tx descriptor */
 	void (*prepare_tx_desc)(struct dma_desc *p, int is_fs, int len,
-			bool csum_flag, int mode, bool tx_own, bool ls,
-			unsigned int tot_pkt_len);
+			bool csum_flag, u8 descriptor_mode, bool tx_own,
+			bool ls, unsigned int tot_pkt_len);
 	void (*prepare_tso_tx_desc)(struct dma_desc *p, int is_fs, int len1,
 			int len2, bool tx_own, bool ls, unsigned int tcphdrlen,
 			unsigned int tcppayloadlen);
 	/* Set/get the owner of the descriptor */
 	void (*set_tx_owner)(struct dma_desc *p);
 	/* Clean the tx descriptor as soon as the tx irq is received */
-	void (*release_tx_desc)(struct dma_desc *p, int mode);
+	void (*release_tx_desc)(struct dma_desc *p, u8 descriptor_mode);
 	/* Clear interrupt on tx frame completion. When this bit is
 	 * set an interrupt happens as soon as the frame is transmitted */
 	void (*set_tx_ic)(struct dma_desc *p);
diff --git a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
index 7c3a818c33c1..c4b613564f87 100644
--- a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
@@ -108,8 +108,8 @@ static int ndesc_get_rx_status(struct stmmac_extra_stats *x,
 	return ret;
 }
 
-static void ndesc_init_rx_desc(struct dma_desc *p, int disable_rx_ic, int mode,
-			       int end, int bfsize)
+static void ndesc_init_rx_desc(struct dma_desc *p, int disable_rx_ic,
+			       u8 descriptor_mode, int end, int bfsize)
 {
 	int bfsize1;
 
@@ -118,7 +118,7 @@ static void ndesc_init_rx_desc(struct dma_desc *p, int disable_rx_ic, int mode,
 	bfsize1 = min(bfsize, BUF_SIZE_2KiB - 1);
 	p->des1 |= cpu_to_le32(bfsize1 & RDES1_BUFFER1_SIZE_MASK);
 
-	if (mode == STMMAC_CHAIN_MODE)
+	if (descriptor_mode == STMMAC_CHAIN_MODE)
 		ndesc_rx_set_on_chain(p, end);
 	else
 		ndesc_rx_set_on_ring(p, end, bfsize);
@@ -127,10 +127,10 @@ static void ndesc_init_rx_desc(struct dma_desc *p, int disable_rx_ic, int mode,
 		p->des1 |= cpu_to_le32(RDES1_DISABLE_IC);
 }
 
-static void ndesc_init_tx_desc(struct dma_desc *p, int mode, int end)
+static void ndesc_init_tx_desc(struct dma_desc *p, u8 descriptor_mode, int end)
 {
 	p->des0 &= cpu_to_le32(~TDES0_OWN);
-	if (mode == STMMAC_CHAIN_MODE)
+	if (descriptor_mode == STMMAC_CHAIN_MODE)
 		ndesc_tx_set_on_chain(p);
 	else
 		ndesc_end_tx_desc_on_ring(p, end);
@@ -146,20 +146,21 @@ static void ndesc_set_rx_owner(struct dma_desc *p, int disable_rx_ic)
 	p->des0 |= cpu_to_le32(RDES0_OWN);
 }
 
-static void ndesc_release_tx_desc(struct dma_desc *p, int mode)
+static void ndesc_release_tx_desc(struct dma_desc *p, u8 descriptor_mode)
 {
 	int ter = (le32_to_cpu(p->des1) & TDES1_END_RING) >> 25;
 
 	memset(p, 0, offsetof(struct dma_desc, des2));
-	if (mode == STMMAC_CHAIN_MODE)
+	if (descriptor_mode == STMMAC_CHAIN_MODE)
 		ndesc_tx_set_on_chain(p);
 	else
 		ndesc_end_tx_desc_on_ring(p, ter);
 }
 
 static void ndesc_prepare_tx_desc(struct dma_desc *p, int is_fs, int len,
-				  bool csum_flag, int mode, bool tx_own,
-				  bool ls, unsigned int tot_pkt_len)
+				  bool csum_flag, u8 descriptor_mode,
+				  bool tx_own, bool ls,
+				  unsigned int tot_pkt_len)
 {
 	u32 tdes1 = le32_to_cpu(p->des1);
 
@@ -176,7 +177,7 @@ static void ndesc_prepare_tx_desc(struct dma_desc *p, int is_fs, int len,
 
 	p->des1 = cpu_to_le32(tdes1);
 
-	if (mode == STMMAC_CHAIN_MODE)
+	if (descriptor_mode == STMMAC_CHAIN_MODE)
 		norm_set_tx_desc_len_on_chain(p, len);
 	else
 		norm_set_tx_desc_len_on_ring(p, len);
-- 
2.47.3


