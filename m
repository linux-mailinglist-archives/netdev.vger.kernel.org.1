Return-Path: <netdev+bounces-267702-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDyyIZAutWkXxQAAu9opvQ
	(envelope-from <netdev+bounces-267702-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 10:46:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E42FD28C7F0
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 10:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2917E3068F28
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 09:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4192934404F;
	Sat, 14 Mar 2026 09:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="O/5ZPE2M"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56B9318B85;
	Sat, 14 Mar 2026 09:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773481362; cv=none; b=KWSDBwEzSE2i2HDPhBCTSQERutLJ4ec8UEuLcFKUuDY1nC2yx1S/LS1Q5buNrqkthNVn/RajYBAFulQTMiXb+MDT+eD1T3DBrjpFSOo8+MR/McVRYTYAIIBvwaOREKeLiA6rYUmpMF8/evBBAMJN2eYh5Xvy+m8SQGOzzvqyRsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773481362; c=relaxed/simple;
	bh=qbxEzDjTq8HPyB1USGf7av5jbb5T/ZQfAV8b5W/QnjY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=rWvc0JrZCNYf3tlmz50oD4VAcJnmfJ0EX4uk5MSF3pd3W53m4nrfIS6AaPrqrE2IGrifAOPoqwTC6XNPzrFcgpGtsUY4Q4+T69BIGZmIKdRGAqL649l3ah0eXOrY8EhT11hTutYdlnBK7W/e/cht7TGXBUSqicPh502KEhXgzrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=O/5ZPE2M; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9p0rSsXOHVPiLPE9YB/i36bApTaz8+E8i1mIA/i01iU=; b=O/5ZPE2MQBZy2DZSZ0kji2V5uE
	fr0WlsXQItHihf5Q24iJ5+yW9oFxHMdPl/DzcdpzW3SlO19kOvdz1W1OG2zGcGjbcfvjt4qmHeJSd
	gK2scYL1jJEmim7fS2xAXBnBsi0pEickw4noJToNS3RXcvOZ8ujNa+H+XttqS7QFdGCbxQ4dVBuy8
	uwuuH+DaNry4gaY8TrFol5GLagui/ZY3Gli0VgqGUJjmVEcbpr35GsflDVRH1Lzm00cegDbK9MRtE
	3GVnXZwx1XVpAW0pL2a5kl70NM3NV1NU7otJnLg9eqhNh67bQRRFtVht08v9/gNf+s8njDME/sUr0
	i8GSzdTA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:34378 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w1LW0-0000000020F-0RLR;
	Sat, 14 Mar 2026 09:42:36 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w1LVz-0000000DGRx-0v9B;
	Sat, 14 Mar 2026 09:42:35 +0000
In-Reply-To: <abUtGH9KB03PH5Ne@shell.armlinux.org.uk>
References: <abUtGH9KB03PH5Ne@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v4 03/15] net: stmmac: clean up
 stmmac_clear_rx_descriptors()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w1LVz-0000000DGRx-0v9B@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sat, 14 Mar 2026 09:42:35 +0000
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267702-lists,netdev=lfdr.de,kernel];
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
	NEURAL_HAM(-0.00)[-0.981];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:email,rmk-PC.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: E42FD28C7F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The two paths calling stmmac_init_rx_desc() are identical apart from
the way the pointer to the descriptor is fetched. Split this out.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c  | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 0dcf4a31e314..765b168df50d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1514,20 +1514,20 @@ static void stmmac_clear_rx_descriptors(struct stmmac_priv *priv,
 					u32 queue)
 {
 	struct stmmac_rx_queue *rx_q = &dma_conf->rx_queue[queue];
+	struct dma_desc *desc;
 	int i;
 
 	/* Clear the RX descriptors */
-	for (i = 0; i < dma_conf->dma_rx_size; i++)
+	for (i = 0; i < dma_conf->dma_rx_size; i++) {
 		if (priv->extend_desc)
-			stmmac_init_rx_desc(priv, &rx_q->dma_erx[i].basic,
-					priv->use_riwt, priv->mode,
-					(i == dma_conf->dma_rx_size - 1),
-					dma_conf->dma_buf_sz);
+			desc = &rx_q->dma_erx[i].basic;
 		else
-			stmmac_init_rx_desc(priv, &rx_q->dma_rx[i],
-					priv->use_riwt, priv->mode,
-					(i == dma_conf->dma_rx_size - 1),
-					dma_conf->dma_buf_sz);
+			desc = &rx_q->dma_rx[i];
+
+		stmmac_init_rx_desc(priv, desc, priv->use_riwt, priv->mode,
+				    (i == dma_conf->dma_rx_size - 1),
+				    dma_conf->dma_buf_sz);
+	}
 }
 
 /**
-- 
2.47.3


