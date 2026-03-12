Return-Path: <netdev+bounces-266993-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCDSBd2Qsml5NgAAu9opvQ
	(envelope-from <netdev+bounces-266993-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:09:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EB5270190
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 01A24301115B
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195443BFE23;
	Thu, 12 Mar 2026 10:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="EWFj52N/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1ED3BF680;
	Thu, 12 Mar 2026 10:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773310165; cv=none; b=FS/j1ZBYTlhKjJPIx96anJiY1NLpxLdnF6WRUQKD6a/IhnDScklgKeHGOUXOK9zgqfbB0VqrbaOwDWDx6yGLHPzuXG04ujACSYwUVaH4dLVh/ieYBEcT6ywHQtkQeLBKz09bisVWIhfzEZsvTnCwh91UdtWIGZfWS3OVbEbrODQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773310165; c=relaxed/simple;
	bh=hD3sAe18nPWW8oxFsuxTzsfxHAjUYL2Cp4S10XNcD5s=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=c+3o7q9HO+qhp/KEDn8lt3lKdpwVQ+i94QjcH+/WfX+Jr8o2cqWekZ5BJFhd30M669rcRMvkxBf4ukkKnUD2VHMrg3j960DJS5H7Kred1OYi2Ohmi3h8nwJdfQbaBCzOsO5BamnnJ2ZHJHJ51yt8Y1S7IeFF3PGDGQFEIopilNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=EWFj52N/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ImtxcwWXXJt6qxVXIbd5mh51lvJgGcYRDTbE+CXfQNQ=; b=EWFj52N/+n6s8Nh7r9tK8wKQfI
	MCc2kGxvpmzy19Rclw/bqMnBOJmcnRtnOTnbxNxKAzttPyqRQ1cQ1z4qJGy7WUTZmb+waExwgaeyD
	O9TkzWE5Qy+7eJFhjfXD2SQST3RM8z7R0nDK6RFkpdu0ujd7RFAHRmn7ylZSe0pR3NDH4CtbXltub
	n30LUWpkCpV5sbIeLLI9v0LRHR6x8FFweBKk648QaPyXSKqugyRUbTJzfod2WIO2MRTwQe4ZlgW6W
	OCKhiJ+F/SAg9D531Wqppw99hCgzlkAoUupzuGYrcvE0rYaQNU+X00gpNl2BV2TsHVZngZxr3hG3R
	D2cvihhg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:45510 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w0cyh-000000007YE-4C0B;
	Thu, 12 Mar 2026 10:09:16 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w0cyf-0000000CzGG-1LJp;
	Thu, 12 Mar 2026 10:09:13 +0000
In-Reply-To: <abKQWloxp9_4OuJh@shell.armlinux.org.uk>
References: <abKQWloxp9_4OuJh@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH net-next v2 05/15] net: stmmac: add helper to get size of a
 receive descriptor
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w0cyf-0000000CzGG-1LJp@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 12 Mar 2026 10:09:13 +0000
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266993-lists,netdev=lfdr.de,kernel];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.980];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,armlinux.org.uk:email,rmk-PC.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: B4EB5270190
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add and use a helper to get the size of the hardware receive
descriptor.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 24 +++++++++----------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a3dfd3501604..dca62e7b259a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -362,6 +362,14 @@ static inline u32 stmmac_tx_avail(struct stmmac_priv *priv, u32 queue)
 			  priv->dma_conf.dma_tx_size);
 }
 
+static size_t stmmac_get_rx_desc_size(struct stmmac_priv *priv)
+{
+	if (priv->extend_desc)
+		return sizeof(struct dma_extended_desc);
+	else
+		return sizeof(struct dma_desc);
+}
+
 static struct dma_desc *stmmac_get_rx_desc(struct stmmac_priv *priv,
 					   struct stmmac_rx_queue *rx_q,
 					   unsigned int index)
@@ -1432,10 +1440,7 @@ static void stmmac_display_rx_rings(struct stmmac_priv *priv,
 		pr_info("\tRX Queue %u rings\n", queue);
 
 		head_rx = stmmac_get_rx_desc(priv, rx_q, 0);
-		if (priv->extend_desc)
-			desc_size = sizeof(struct dma_extended_desc);
-		else
-			desc_size = sizeof(struct dma_desc);
+		desc_size = stmmac_get_rx_desc_size(priv);
 
 		/* Display RX ring */
 		stmmac_display_ring(priv, head_rx, dma_conf->dma_rx_size, true,
@@ -5412,11 +5417,7 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		void *rx_head = stmmac_get_rx_desc(priv, rx_q, 0);
 
 		netdev_dbg(priv->dev, "%s: descriptor ring:\n", __func__);
-		if (priv->extend_desc) {
-			desc_size = sizeof(struct dma_extended_desc);
-		} else {
-			desc_size = sizeof(struct dma_desc);
-		}
+		desc_size = stmmac_get_rx_desc_size(priv);
 
 		stmmac_display_ring(priv, rx_head, priv->dma_conf.dma_rx_size, true,
 				    rx_q->dma_rx_phy, desc_size);
@@ -5604,10 +5605,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		void *rx_head = stmmac_get_rx_desc(priv, rx_q, 0);
 
 		netdev_dbg(priv->dev, "%s: descriptor ring:\n", __func__);
-		if (priv->extend_desc)
-			desc_size = sizeof(struct dma_extended_desc);
-		else
-			desc_size = sizeof(struct dma_desc);
+		desc_size = stmmac_get_rx_desc_size(priv);
 
 		stmmac_display_ring(priv, rx_head, priv->dma_conf.dma_rx_size, true,
 				    rx_q->dma_rx_phy, desc_size);
-- 
2.47.3


