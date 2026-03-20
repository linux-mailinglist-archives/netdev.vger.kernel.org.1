Return-Path: <netdev+bounces-269978-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yK5CNy+AvWk4+gIAu9opvQ
	(envelope-from <netdev+bounces-269978-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:13:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B142DE603
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54FD3311EBBA
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 16:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285353C8704;
	Fri, 20 Mar 2026 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="qD9K7P4S"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C084B3D47C6
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 16:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025252; cv=none; b=F9hoXdrhX+YgYYCwu8JXOoZwawdaR+gdoMZdBHiGdmQ0exRfVaI3dcpWnDKv8SxdQo/kzTsTU3pxCa4zFKyO7bNwG7nqaBdq5EGMRWa6sP2X4KTr2ELRq6ROVGYNoy6zpAx+fVbYSAUzTtTSyBctZB/lHf4TWGzdSKWq8xYjrkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025252; c=relaxed/simple;
	bh=LNsiehG3iM7w5VAX+ZYLv9IR8F1cz8nruOQQ9GtFpZg=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=g/U4X2O4eG1h5SotF7f0iU6cYUbxceKunDp8Yi7NyaqBhSl7N6dEhJFSixMaV1RDTzQrUYkNc0gkt62eDOS+2BKVw2qTzIxUAWiuwzFMA4JKI2z8f+jVTK/feCoVgnsSGAbOHbNG3GJPp0F4GPUSajphkx5k5suo6XZv++fgDKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=qD9K7P4S; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=77qBooPHVxdAB3nzVkpVFiDsWi/YaVfDJ7kiuL9ABMc=; b=qD9K7P4SzvWc3gu0tzMB7VTkua
	MnBjliKqdpdZD7F/EPIxDiIDVHZkTHRd0c0B93dkg8kysxH6fIUVbzIP0W2TRYTMCK9rebo1B9+T7
	egHx7JRSOtphauZRr67OuFrdnsDLtO0fH/l/mQKRoOhJpRGy84H+t+Tm3wcZIwI52lSYOsakQJ1KI
	qGooNedosxDN24j15h//bowMJJPo5kmA5vEauWRFrDezjq4rlC9b4LRCAcQKj1YfPyl0I1t5aedOq
	0AqOSwlO0h4b9lNLtnPXSLFWCbWfgiogFSpGhvkEDRkAS2qoW+Pr2s1gvZRLubf+QRMS6UZwFYAk0
	CwvvtrAA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:34044 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w3d0N-000000006Lg-0NJp;
	Fri, 20 Mar 2026 16:47:23 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w3d0M-0000000DfLv-1C6S;
	Fri, 20 Mar 2026 16:47:22 +0000
In-Reply-To: <ab15_JvLGFtUH_3x@shell.armlinux.org.uk>
References: <ab15_JvLGFtUH_3x@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 3/6] net: stmmac: move stmmac_xmit() first entry
 index code
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w3d0M-0000000DfLv-1C6S@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 20 Mar 2026 16:47:22 +0000
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269978-lists,netdev=lfdr.de,kernel];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.430];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,rmk-PC.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 96B142DE603
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The handling of the first descriptor index/pointer is split around
the checksum handling which makes no sense. Group this code together.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3d94f632fca6..d5e28ecf9fb4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4735,10 +4735,6 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	/* Check if VLAN can be inserted by HW */
 	has_vlan = stmmac_vlan_insert(priv, skb, tx_q);
 
-	entry = tx_q->cur_tx;
-	first_entry = entry;
-	WARN_ON(tx_q->tx_skbuff[first_entry]);
-
 	csum_insertion = (skb->ip_summed == CHECKSUM_PARTIAL);
 	/* DWMAC IPs can be synthesized to support tx coe only for a few tx
 	 * queues. In that case, checksum offloading for those queues that don't
@@ -4755,6 +4751,10 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 		csum_insertion = !csum_insertion;
 	}
 
+	entry = tx_q->cur_tx;
+	first_entry = entry;
+	WARN_ON(tx_q->tx_skbuff[first_entry]);
+
 	desc = stmmac_get_tx_desc(priv, tx_q, entry);
 	first_desc = desc;
 
-- 
2.47.3


