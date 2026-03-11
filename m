Return-Path: <netdev+bounces-266582-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDR7Azc+sWmtswIAu9opvQ
	(envelope-from <netdev+bounces-266582-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:04:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD7F261B41
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 224FF3063EF4
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344BB3B6365;
	Wed, 11 Mar 2026 09:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DxwJOamy"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539D4363C7C;
	Wed, 11 Mar 2026 09:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773222787; cv=none; b=gg1Levd94hYG9X88Oy26Z1sVAKClTgvPjSdiR7W7uAVMY0ly/DI8CDjC4u7ejWpDEth8mPVDK2od+tKoBRueuH2lDbfPCL4qZhwQwarmqAPHWoWvSV1FBaY2QO38Pr/LTnN75OCpAWjGn+Itd2WmjjbSubRzczhvPGcgBla6BiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773222787; c=relaxed/simple;
	bh=PZdHvMr7wL9hFfOIrhq7tR38Vzwj6L2pUcXErWIwcDI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=hZxTGybZnhRi96X/vCmtrUNfW4taqRKQrZ2hnedvGdkWSmoRmdq+bRdRow2dsyrzH4OTftRBthwLBOGO/n5nI6j0RDwY+O5LtorXV44JJ5ydpSVGgSWZIhAr3Xu/dKP7hOjxkCqQ/VOTwqj+cstc+3aTWaSdTN2zizBu6DqTeek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DxwJOamy; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mN5vxj18DEG/GzsK/ZAK4TM2Y4zdJSMNto0z0SCK1Fo=; b=DxwJOamyFQJasiEEGIg6PQGra/
	c3RbdoTkyMuaqpPTiz+DTFczICSEfdmbzPFM5SaMLy17PU/OJSlwJ6KmA6KhQoWBSuk8Oysi2sHvM
	RHlcPomYiCfoOVjL4OE4e4eODtAn3yKlk6NkHZpnjaCejQgHwdjOcOYvHOyyJZlIMeZFwVyEzGfJJ
	FM6uUUSC/Ekmx3s2GNf6xaXIauxiCVQXIvoRcHB9WFGrOTJxFK2SO6IvaOvhmVTUI7j3dhAAZ3jl7
	VUfLcW1Y8dkVmD5AjM2zXkF3xfmPNYGPhJkA9iHgr0KxHFOdumJ7egvm+Jj3YcCbqoRL+CVeQXXDQ
	+3+NtCJQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42730 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w0GFO-0000000069N-0wQd;
	Wed, 11 Mar 2026 09:52:58 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w0GFL-0000000CiTV-1cdM;
	Wed, 11 Mar 2026 09:52:55 +0000
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
Subject: [PATCH net-next 10/15] net: stmmac: simplify
 stmmac_set_queue_rx_buf_size()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w0GFL-0000000CiTV-1cdM@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 11 Mar 2026 09:52:55 +0000
X-Rspamd-Queue-Id: 2CD7F261B41
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266582-lists,netdev=lfdr.de,kernel];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rmk-PC.armlinux.org.uk:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,armlinux.org.uk:email]
X-Rspamd-Action: no action

Clean up the new stmmac_set_queue_rx_buf_size() to simplify the code.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 47b536c15c0e..032ef9fba8b4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -399,16 +399,12 @@ static void stmmac_set_queue_rx_buf_size(struct stmmac_priv *priv,
 {
 	u32 buf_size;
 
-	if (rx_q->xsk_pool && rx_q->buf_alloc_num) {
+	if (rx_q->xsk_pool && rx_q->buf_alloc_num)
 		buf_size = xsk_pool_get_rx_frame_size(rx_q->xsk_pool);
-		stmmac_set_dma_bfsize(priv, priv->ioaddr,
-				      buf_size,
-				      rx_q->queue_index);
-	} else {
-		stmmac_set_dma_bfsize(priv, priv->ioaddr,
-				      priv->dma_conf.dma_buf_sz,
-				      rx_q->queue_index);
-	}
+	else
+		buf_size = priv->dma_conf.dma_buf_sz;
+
+	stmmac_set_dma_bfsize(priv, priv->ioaddr, buf_size, rx_q->queue_index);
 }
 
 /**
-- 
2.47.3


