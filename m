Return-Path: <netdev+bounces-272825-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oH/lMRRKyGlVjgUAu9opvQ
	(envelope-from <netdev+bounces-272825-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 22:37:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AA8350089
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 22:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02B31302C346
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 21:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8927343D86;
	Sat, 28 Mar 2026 21:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tlTxbXa0"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A12D359A75
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 21:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774733827; cv=none; b=boOOYHNC9J30aXXBgldwdNU3iSEaYW4zLGRIn+0phzZIv0qovdR8FNA6NuxKb4oRQKTw8qOjEiCLmF3zsQLLl5ESAFgAULM4/G4OfpmUpeOWDV0S2ilQ9N6c5JeItiWUwxS+MIXqJ27zUE4oE/v0Se/wmthvYxb6ylTOew9uY9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774733827; c=relaxed/simple;
	bh=C837YuOHF2/+bkANG/bZeWLT+UZej/PnxWk3LzwvHKs=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ixPmO/uL5WCTnwQN6tf25hIQxwXWKRSDyeVJyo/R23QTQJqHmc0G/5FBSmEe82NTOiMz5PMHE+a/T4QXlnbk8Sxj2lj+LdQBxEFdFsjAIM/JppYKgkzkv+M4irohzkOVgXWxtdeMeh7UKAxiI1z+oEuwnbxrgIMrCVyYUDIe8qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=tlTxbXa0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rmtvPeRClGsN+/hlvuBTyHk3INo2YZVmRU3ck+rUhCs=; b=tlTxbXa0QYHZ1gRYH1n8rWFkla
	8FOMQMbZPMJKiefnidsY+JnRN4bRYh/8VlBq90q6rjd1kN0PxgwiY4AAgHBJK9Cw42qy/Nggabzmo
	JqJSzLhTvE7iUA6ijyryeNg+iSpFgfu2xTfVw+rD5rA5BVK+B1i1IVFa87PcPI67YjZUMvxVPw4CK
	n9Exc8lvm/xJWGnF+glcd7eaJYknBl/Lbo7lxhKPFwyCuf/m//kaUM4FMvt5+3+gd/CxtBEBweB2a
	V3HCJAoeKgcJbDn3qqIajwlYvT2rWxtqGZQWM6N+F6VDXbl63OhnISKzwUqR1DJKee951eMzWhqf/
	mftjyjyw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:33096 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w6bL0-000000007SS-1u9s;
	Sat, 28 Mar 2026 21:36:58 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w6bKz-0000000ELtx-0rYr;
	Sat, 28 Mar 2026 21:36:57 +0000
In-Reply-To: <achJ1dfeT6Q8rBuX@shell.armlinux.org.uk>
References: <achJ1dfeT6Q8rBuX@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 04/10] net: stmmac: always enable channel TSO when
 supported
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w6bKz-0000000ELtx-0rYr@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sat, 28 Mar 2026 21:36:57 +0000
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272825-lists,netdev=lfdr.de,kernel];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,rmk-PC.armlinux.org.uk:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 27AA8350089
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Rather than configuring the channels depending on whether GSO/TSO is
currently enabled by the user, always enable if the hardware has
TSO support and the platform wants TSO to be enabled.

This avoids TSO being disabled on a channel over a suspend/resume
when the user has disabled TSO features, and then the hardware
misbehaves when TSO is re-enabled.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index ed3e9515cf25..f500fcc17ce5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3712,7 +3712,7 @@ static int stmmac_hw_setup(struct net_device *dev)
 	stmmac_set_rings_length(priv);
 
 	/* Enable TSO */
-	if (priv->tso) {
+	if (priv->dma_cap.tsoen && priv->plat->flags & STMMAC_FLAG_TSO_EN) {
 		for (chan = 0; chan < tx_cnt; chan++) {
 			if (!stmmac_channel_tso_permitted(priv, chan))
 				continue;
-- 
2.47.3


