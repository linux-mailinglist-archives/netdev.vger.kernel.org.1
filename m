Return-Path: <netdev+bounces-276407-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFIkNqIj1mklBQgAu9opvQ
	(envelope-from <netdev+bounces-276407-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 11:45:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 712913BA0FF
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 11:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B0EB303A137
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 09:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DE03B3887;
	Wed,  8 Apr 2026 09:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="LWVCNGgR"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBF83B27F9
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 09:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775641422; cv=none; b=R7CE9QKha8V1SYHGN6GumkAEeTeFkEf9C+BVFBuucf+EwiTdc5UX3T/rwz16xiEfvIYUHPFf1uBDy0r9FDcuWQq2Fm0R0AmOyukG24kyIWBpKnAdOTR9qgPsdZk8uUJ3tE7S5MvB1WxDi+SWiJNTTPL4jYZgz9aPxhWUFopfJe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775641422; c=relaxed/simple;
	bh=c4FPCC64OLY6uQ7rq6bCkd7CNhC0hCmGm+WzJILpnU8=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=WcHXXI73Kid0uwOSMIfDhMpemTv7aOv6IUOdYV3soBHvzCCaSsWmn6zyPe9AHiowlqgSvKzKIypJidLV86uk+bkKQKPeD3hc8Ztfhg+lqKrb8ApT56u7LTUg43hVfsEAwEicfdwclFWg7/U9EroNSIcoahFi3vOPOWAstBBWXpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=LWVCNGgR; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FhdQTZ4PjxdShoN2GRJESKI6NUEw1EHbjw1nk/1gbzU=; b=LWVCNGgRtCTuIthGvixb61A+O8
	C2GNvXJWZ6kxkTafqTGqfuUL71asdjM1C2FYgZxL8iRhdtav91LuRpZsj/TXI9qZZBkvHrFk1Vj5i
	kbivRDeMv+KpkJm01SUtrvuMNbIS0+Q59yHymN4CAfKBoRgix4wOLmcW7+2gZmX5BimGmv+F8PV3t
	UcIubeLHH3CpwG9f2+lrHiAvC4NNr0YGeCUycptUVkDaa91iXSLScagfulUk1LMfd9H2SE24BsKZI
	x+b+iwzDfF8xqRZ3f6q7CB7HOycps5zd8x/ajUNl0ypsIUIjcAPyFbE5v2f1MlEVu7IzzR6F+syg1
	S+e4yaew==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:33750 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1wAPC8-00000000246-3oVx;
	Wed, 08 Apr 2026 10:27:33 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1wAPC1-0000000F7kl-15YL;
	Wed, 08 Apr 2026 10:27:25 +0100
In-Reply-To: <adYfPBHsXxQUsMyr@shell.armlinux.org.uk>
References: <adYfPBHsXxQUsMyr@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chen-Yu Tsai <wens@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Samuel Holland <samuel@sholland.org>
Subject: [PATCH RFC net-next 09/10] net: stmmac: clean up test for rx_coe
 debug printing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1wAPC1-0000000F7kl-15YL@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 08 Apr 2026 10:27:25 +0100
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276407-lists,netdev=lfdr.de,kernel];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.084];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rmk-PC.armlinux.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 712913BA0FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The test for printing rx_coe as opposed to rx_coe_type[12] and
rxfifo_over_2048 has checked for an XGMAC core or the Synopssys IP
version (snpsver) >= v4.0.

Since the Synopsys IP version depends on the core type, avoid using it.

The GMAC4 core type uses dwmac4_get_hw_feature(), which populates
rx_coe but not rx_coe_type[12] or rxfifo_over_2048. XGMAC is the same
but via dwxgmac2_get_hw_feature().

dwmac-motorcomm populates rx_coe but not the others, and sets the core
type to GMAC4. The Synopsys IP version is likely >= 4, but in any case
printing rx_coe is clearly more correct.

Lastly, dwmac-sun8i is an oddball - it sets rx_coe, but does not set
core_type, leaving it as the defeault DWMAC_CORE_MAC100 since as far
as I can see, none of the .dtsi files for this platform use any of the
versioned snps,gmac-* compatibles. Moreover, sun8i_dwmac_setup() sets
snpsver to zero (which stmmac_get_version() will have already done) so
this has always used the rx_coe_type[12] path.

Change the test to check for GMAC4 or XGMAC which covers the cases
where rx_coe is set from the core hardware features.

Also add a comment for the GMAC to GMAC4+ rx_coe feature translation in
stmmac_hw_init(), and document rx_coe in struct plat_stmmacenet_data.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 11 +++++++++--
 include/linux/stmmac.h                            |  7 +++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index e47321119c83..93c031b3cfd5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6624,11 +6624,15 @@ static int stmmac_dma_cap_show(struct seq_file *seq, void *v)
 	seq_printf(seq, "\tAV features: %s\n", (priv->dma_cap.av) ? "Y" : "N");
 	seq_printf(seq, "\tChecksum Offload in TX: %s\n",
 		   (priv->dma_cap.tx_coe) ? "Y" : "N");
-	if (priv->snpsver >= DWMAC_CORE_4_00 ||
-	    priv->plat->core_type == DWMAC_CORE_XGMAC) {
+	if (dwmac_is_xmac(priv->plat->core_type)) {
+		/* gmac4, xgmac, and motorcomm populate this. */
 		seq_printf(seq, "\tIP Checksum Offload in RX: %s\n",
 			   (priv->dma_cap.rx_coe) ? "Y" : "N");
 	} else {
+		/* only dwmac1000 has these three. sun8i sets rx_coe, but
+		 * sets snpsver to zero and leaves core_Type as MAC100, so
+		 * uses this path.
+		 */
 		seq_printf(seq, "\tIP Checksum Offload (type1) in RX: %s\n",
 			   (priv->dma_cap.rx_coe_type1) ? "Y" : "N");
 		seq_printf(seq, "\tIP Checksum Offload (type2) in RX: %s\n",
@@ -7441,6 +7445,9 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
 		/* In case of GMAC4 rx_coe is from HW cap register. */
 		priv->plat->rx_coe = priv->dma_cap.rx_coe;
 
+		/* GMAC (dwmac1000) has separate bits for the Rx COE type.
+		 * Translate to the GMAC4/XGMAC rx_coe feature code.
+		 */
 		if (priv->dma_cap.rx_coe_type2)
 			priv->plat->rx_coe = STMMAC_RX_COE_TYPE2;
 		else if (priv->dma_cap.rx_coe_type1)
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 4430b967abde..c80d45de0067 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -256,6 +256,13 @@ struct plat_stmmacenet_data {
 	bool force_sf_dma_mode;
 	bool force_thresh_dma_mode;
 	bool riwt_off;
+	/* rx_coe:
+	 * for dwmac100, rx_coe does not appear to be defined.
+	 * for dwmac1000, rx_coe takes one of the STMMAC_RX_COE_* constants,
+	 *  which will be derived from the RXTYP[12]COE hardware feature bits.
+	 * for dwmac4 and xgmac, rx_coe is a boolean from the RXCOESEL hardware
+	 *  feature bit.
+	 */
 	int rx_coe;
 	int max_speed;
 	int maxmtu;
-- 
2.47.3


