Return-Path: <netdev+bounces-273932-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLmDMKbHzGn5WgYAu9opvQ
	(envelope-from <netdev+bounces-273932-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:22:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A54E9375C5E
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AAD403029C01
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 07:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9492537BE6C;
	Wed,  1 Apr 2026 07:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="GD+4iJgY"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276BB37B012
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 07:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775028116; cv=none; b=tqJ3+9uBxmqSRzLbRW3lqzcaE3KkJKjerQZU+Xx+h3ezm8LsGKfT/eo7wqpk5B7Y61EYPiRVcnrL6wMcDTLE5vfAjDNZ4nIL7n93KpFE+RqVxGCtIztTPH0RvPpeRx3g1HocRWBxbDgZ+mokPshhv2KWYfR4jGZfzyPcJ0kcoCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775028116; c=relaxed/simple;
	bh=6t+RbgpCXnJRh1EpZuOVWPk2LdKFB2287MabgzV/9cE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Vj71bqwwffDEsLE3Yfg5QYm+1mCKD+sKrQLvNCRzAGYhdyqwUmop9RWLF0LZctQ8zT6dSMJ1wAMbvVUULOvbV5il5Y0lL40IpRCTGXYmpADaWOrVo+yze0ZdNaYHP3R9VI1sxNOi1sgCFk7DfTO9GiMh6DtBrlNhQrYjdKSdSO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=GD+4iJgY; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=obyR8ec27qCSiO/J/J/rtAZWsF0bTjTDR8UxLRlkwlA=; b=GD+4iJgY3j7MqFWwgm6hsHb8Qt
	PdOzNsVoknKOQmaXD0WUEv8yJgSs5KRx/O1MIe3MKVotRreYEm9ZVQb9sdnu6idoal9aMPnrEv3Qh
	gsdi8Fi/Zx+wJ/DQ6E2G2PyxuTt1CXLHmwC37K9PSoRdJ5eUkMyRutQejVHtJ8Iv7QSp3mvssw7d5
	vS24aVM3Ii9FCX+u2/AlJwfBPBTlyORwHOalb5NP336oGUP6giO0Af2/+Ye/yTOAMVLshS5/owoQx
	BvVeqhJqHmpGbY0YXxyDnDO7bcA+OhejEYl0RVdz/5hTOk791FMun9ZWgx8dcYzktqzQrTR5KzFVm
	GZvQIgOQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41322 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w7pta-000000002hD-49Kw;
	Wed, 01 Apr 2026 08:21:47 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w7ptY-0000000EatO-42Qv;
	Wed, 01 Apr 2026 08:21:44 +0100
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
Subject: [PATCH net-next v2 07/14] net: stmmac: move TSO VLAN tag insertion to
 core code
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w7ptY-0000000EatO-42Qv@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 01 Apr 2026 08:21:44 +0100
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
	TAGGED_FROM(0.00)[bounces-273932-lists,netdev=lfdr.de,kernel];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.870];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,rmk-PC.armlinux.org.uk:mid,armlinux.org.uk:email]
X-Rspamd-Queue-Id: A54E9375C5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

stmmac_tso_xmit() checks whether the skbuff is trying to offload
vlan tag insertion to hardware, which from the comment in the code
appears to be buggy when the TSO feature is used.

Rather than stmmac_tso_xmit() inserting the VLAN tag, handle this
in stmmac_features_check() which will then use core net code to
handle this. See net/core/dev.c::validate_xmit_skb()

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 23 ++++++++-----------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b4cc34dd0d76..c67f042a90af 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4456,19 +4456,6 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	u8 proto_hdr_len, hdr;
 	dma_addr_t des;
 
-	/* Always insert VLAN tag to SKB payload for TSO frames.
-	 *
-	 * Never insert VLAN tag by HW, since segments split by
-	 * TSO engine will be un-tagged by mistake.
-	 */
-	if (skb_vlan_tag_present(skb)) {
-		skb = __vlan_hwaccel_push_inside(skb);
-		if (unlikely(!skb)) {
-			priv->xstats.tx_dropped++;
-			return NETDEV_TX_OK;
-		}
-	}
-
 	nfrags = skb_shinfo(skb)->nr_frags;
 	queue = skb_get_queue_mapping(skb);
 
@@ -4969,6 +4956,16 @@ static netdev_features_t stmmac_features_check(struct sk_buff *skb,
 		if (!stmmac_tso_channel_permitted(netdev_priv(dev), queue) ||
 		    !stmmac_tso_valid_packet(skb))
 			features &= ~NETIF_F_GSO_MASK;
+
+		/* If we are going to be using hardware TSO, always insert
+		 * VLAN tag to SKB payload for TSO frames.
+		 *
+		 * Never insert VLAN tag by HW, since segments split by
+		 * TSO engine will be un-tagged by mistake.
+		 */
+		if (features & NETIF_F_GSO_MASK)
+			features &= ~(NETIF_F_HW_VLAN_STAG_TX |
+				      NETIF_F_HW_VLAN_CTAG_TX);
 	}
 
 	return vlan_features_check(skb, features);
-- 
2.47.3


