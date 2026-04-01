Return-Path: <netdev+bounces-273929-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFAfKY3HzGn5WgYAu9opvQ
	(envelope-from <netdev+bounces-273929-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:21:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51468375C2C
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA9463029C01
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 07:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A76E37BE62;
	Wed,  1 Apr 2026 07:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="K9A/RUO5"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D9D37A486
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 07:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775028100; cv=none; b=jGeKs3VfSpBHT5lnXbJcwnRXeVSaBUwQc5iq8ipvdWMeEfV2ME9NzT4mlfEYUdtD1jD6Yc1pqvipKhok47zCX/GXXcYBCqTvoUWO2sOKAK9Nox50NXRHXKCJ5wOEBPaA0g/JRC06CW1MZACUcGg1fY5z2m7DPJuaP3J2vCPobg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775028100; c=relaxed/simple;
	bh=jMmeyJTVKs12zKfxpx9e23+qBZAXZHoQrtSeWaMySR0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=QdyIVchzeQ1ZWBhh2GdV2p33eOeaO3LZkw6EIVxV+jp8TF4xPLLph3maElE8cv0pRYLB0r7PB+G0UeBohn+g3yej8UURrAoAmm+oOvJbZdPfLJIKkuYMcNTDFcfdr8ATZyagvIB3fZvQOj1luNQ05xY8dxloOKQdKtqtzCFJ5XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=K9A/RUO5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fUdV/Cp/qxe1fQKowTisXB34L6Mv5w3TPP0xHN1PcWs=; b=K9A/RUO5iQ35wYDtpWxiOnWZc0
	iSgtMaObbdEcvD/LsOV2XELiLf3kVSnblbB3w+FiB2GmTsAw55VomPzFCFc7pSl5hNNOJ7++qAY48
	0A8w9ecRSS+q/17DEX6GHmDAjXVrpaK93xbcfAtaWU7MRHris6bWdHlUz0Mx9Vug+yp2rTUIwg0Tn
	9yKZXsNr+hvmyo7GTVlZdsXwCik6wmL5bQfg1+PynfB5Bw7WNeRYBggcZYAJwRmVd7lNGMDAkzGQA
	sRoXVvw6vCrNFs70tbcWWRpKgJjWNXPjpv2532MCVxmGAR6rtvO8iG8YsTJdi/Uecv5bABzvsEVx9
	3N+vBYbw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35430 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w7ptK-000000002gJ-2aWD;
	Wed, 01 Apr 2026 08:21:30 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w7ptJ-0000000Eat5-2ZlA;
	Wed, 01 Apr 2026 08:21:29 +0100
In-Reply-To: <aczHVF04LIGq_lYO@shell.armlinux.org.uk>
References: <aczHVF04LIGq_lYO@shell.armlinux.org.uk>
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
	Ong Boon Leong <boon.leong.ong@intel.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 04/14] net: stmmac: add stmmac_tso_header_size()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w7ptJ-0000000Eat5-2ZlA@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 01 Apr 2026 08:21:29 +0100
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273929-lists,netdev=lfdr.de,kernel];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.877];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,rmk-PC.armlinux.org.uk:mid,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 51468375C2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We will need to compute the size of the protocol headers in two places,
so move this into a separate function.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 20 ++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 890a1efb8733..2b5bccc727a5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4373,6 +4373,18 @@ static void stmmac_flush_tx_descriptors(struct stmmac_priv *priv, int queue)
 	stmmac_set_queue_tx_tail_ptr(priv, tx_q, queue, tx_q->cur_tx);
 }
 
+static size_t stmmac_tso_header_size(struct sk_buff *skb)
+{
+	size_t size;
+
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4)
+		size = skb_transport_offset(skb) + sizeof(struct udphdr);
+	else
+		size = skb_tcp_all_headers(skb);
+
+	return size;
+}
+
 /**
  *  stmmac_tso_xmit - Tx entry point of the driver for oversized frames (TSO)
  *  @skb : the socket buffer
@@ -4444,13 +4456,11 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	first_tx = tx_q->cur_tx;
 
 	/* Compute header lengths */
-	if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) {
-		proto_hdr_len = skb_transport_offset(skb) + sizeof(struct udphdr);
+	proto_hdr_len = stmmac_tso_header_size(skb);
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4)
 		hdr = sizeof(struct udphdr);
-	} else {
-		proto_hdr_len = skb_tcp_all_headers(skb);
+	else
 		hdr = tcp_hdrlen(skb);
-	}
 
 	/* Desc availability based on threshold should be enough safe */
 	if (unlikely(stmmac_tx_avail(priv, queue) <
-- 
2.47.3


