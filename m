Return-Path: <netdev+bounces-266586-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GP5vEMxDsWlCtAIAu9opvQ
	(envelope-from <netdev+bounces-266586-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:28:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A6E262297
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33E8E3275772
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09D23B47F1;
	Wed, 11 Mar 2026 09:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vw80s27O"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D809532BF41;
	Wed, 11 Mar 2026 09:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773222810; cv=none; b=DvqVB7ufqVi3DhkYmf2Sjn6oVpU+Mk7fcNCHUedluhQbEbeRPovyPJEHV0jR7MSQAaB1O70LXPE1cjRwJlmIEDKYl7NaRQq+M1uQqy+EYkX/Utv2XToiNRunLJiTuUGj9bPQCGtanahoojN3CO+cC4t56VgU43o+oBQSbEpSpok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773222810; c=relaxed/simple;
	bh=I1vxZBeAYePlmaNdX5KUzzlbvvDYAbB+OLK9C7muN8M=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=jPbizu0i+rgTTEfDr4l0b6dbLxDM0u4Z350SkuHj1fbxxXqBraBv0Xd7cqVsYkXjEN35lZRs0zhsT65+9tHQiUnh+BTq02cyzTb17+LVflB4BYbYBx7DPAcviyFOxM7xeaKg0A5BdWsXK67+XEaGUmZ4DlN721gyK0XKI0lc9Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=vw80s27O; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7M4qvN4KUZhWeHz0+r2If9XfOaCaAnmKNLe00xCAwms=; b=vw80s27OGrWSBdMS28kVJqhLXm
	8+nQEnaK/rCF2wiVCRhlquXaD7PX04vMo4XnQZOCgyMjZFVnz97rd41Dq4CVhhWAknumt2/GXaN52
	zoboaY7LPOgF0USIvhgL3bM0/38MwI98akbGnXroHK8daDyOCMmGs2z1ru7CvOQ/WEQ40FTJ3ptQj
	XRm0zi/oNHFeXaQl/VxpeDnbOduOZMSYq1iv91ViB2MIHNk9Cd5mIdwBb5G4uWeg8hzIk921lUe8Q
	/pZ4fIq3Ye59DeoNaQcV+RExH8R8wqqajTR29O7hyaJ5SBBkz1w3rVs5GbOFukctO338Bvgut8WqF
	GUCudibg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:37994 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w0GFj-000000006Ap-0alh;
	Wed, 11 Mar 2026 09:53:19 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w0GFf-0000000CiTt-3qMB;
	Wed, 11 Mar 2026 09:53:15 +0000
In-Reply-To: <abE7LWj04-JNxgS2@shell.armlinux.org.uk>
References: <abE7LWj04-JNxgS2@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 14/15] net: stmmac: remove tx_tail_addr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w0GFf-0000000CiTt-3qMB@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 11 Mar 2026 09:53:15 +0000
X-Rspamd-Queue-Id: A3A6E262297
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266586-lists,netdev=lfdr.de,kernel];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,armlinux.org.uk:email,rmk-PC.armlinux.org.uk:mid]
X-Rspamd-Action: no action

There is only one place where tx_q->tx_tail_addr is used - the new
stmmac_set_queue_tx_tail_ptr(). Make this a local variable and remove
it from struct stmmac_tx_queue.

This commit does not change the semantics - the hardware relies upon
the descriptor ring not crossing a 4GiB boundary as the high address
bits are programmed into a separate register via stmmac_init_tx_chan().
Hence, truncating the DMA address to 32-bit is fine as the register it
will be programmed into is 32-bit, and the high bits are handled
elsewhere.

Also change the type of desc_size to size_t, as this variable is
initialised from sizeof().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      | 1 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 ++++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index d1f8383d1c04..7cc5967aecd7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -79,7 +79,6 @@ struct stmmac_tx_queue {
 	unsigned int cur_tx;
 	unsigned int dirty_tx;
 	dma_addr_t dma_tx_phy;
-	dma_addr_t tx_tail_addr;
 	u32 mss;
 };
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 4521469c5e1d..55b79e9e637f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -389,12 +389,13 @@ static void stmmac_set_queue_tx_tail_ptr(struct stmmac_priv *priv,
 					 struct stmmac_tx_queue *tx_q,
 					 unsigned int chan, unsigned int index)
 {
-	int desc_size;
+	size_t desc_size;
+	u32 tx_tail_addr;
 
 	desc_size = stmmac_get_tx_desc_size(priv, tx_q);
 
-	tx_q->tx_tail_addr = tx_q->dma_tx_phy + index * desc_size;
-	stmmac_set_tx_tail_ptr(priv, priv->ioaddr, tx_q->tx_tail_addr, chan);
+	tx_tail_addr = tx_q->dma_tx_phy + index * desc_size;
+	stmmac_set_tx_tail_ptr(priv, priv->ioaddr, tx_tail_addr, chan);
 }
 
 static size_t stmmac_get_rx_desc_size(struct stmmac_priv *priv)
-- 
2.47.3


