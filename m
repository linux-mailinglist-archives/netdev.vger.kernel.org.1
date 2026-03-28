Return-Path: <netdev+bounces-272823-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCcXNvtJyGlVjgUAu9opvQ
	(envelope-from <netdev+bounces-272823-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 22:36:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8075535004F
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 22:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E576530090BB
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 21:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FAF33F8D4;
	Sat, 28 Mar 2026 21:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1oF8aeq+"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC3C2264A8
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 21:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774733815; cv=none; b=UiEK0Bzf+oYqd1TvFyHIo4pO/nczmybx8OQh2f/oEX8aAjxLG0JKLC2TG7X7Fq5plnhqlz3ouK2Feay8khjlHvY+mOU6EDeIRFDSOO5OLbeLcq+zE/lscbR+/4S0fv9oORgtYBUbs1bSt6AQi1aTmOZdnRuMoGZKYCnyFNiy0mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774733815; c=relaxed/simple;
	bh=548jtmyTprGZ+JnQffA6rHUYIjoL1/H50v5gcVRArQw=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=jJLiqDQZgQhPuPt9OtqgJD2pW+vfYUIAaIL8pFog6lrYC8AjDZyrw+D90d704kEkJAE46TI0MAoTIHss86POcuX7SF9uBmf2hjEp1+0F/Rj3BaY+d1Fj4tzpNAGSsMERqV9v4W8tlk+qjSVzbVo4/hGq3PT5XwMvyrlLbeHv4JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=1oF8aeq+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0c0lfEh5H8seUCOVI74FNjnlV4nffYfL9v87bxvlRaw=; b=1oF8aeq+jv/m19MfNDxOhVk4hs
	OXO3ZWCMwmRnKTT9PyTeS096XzFlj9pCz6fjgXKa/j0/JS435XY3/fJT4rLwvfx1GAXaCAswPn5Yz
	A7hX4asgm8eWhSR+9MW+cuXslWKvLS0DmakkfCAk7jPT8oOR67vtxkuzoi3M/BLzJUHefmYProquQ
	L0pfnCWVoYm0Wwak6KsqxEMD59LYgyMrncxXwN/sU0/EydolILzUqang+qX/pw4iHy3yhwSQH9uvs
	DpjWMsipJcmq1C7N4O0ovLzt6Zd3nDB5DRgO1LCprwRWRqFrwjXx6CX/Fq1CT3NjhUBjKgjpykoSX
	lc2x/sRQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:60850 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w6bKp-000000007Rl-48dF;
	Sat, 28 Mar 2026 21:36:48 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w6bKp-0000000ELtl-05Xr;
	Sat, 28 Mar 2026 21:36:47 +0000
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
Subject: [PATCH net-next 02/10] net: stmmac: add TSO check for header length
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w6bKp-0000000ELtl-05Xr@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sat, 28 Mar 2026 21:36:47 +0000
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272823-lists,netdev=lfdr.de,kernel];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,rmk-PC.armlinux.org.uk:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8075535004F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

According to the STM32MP151 documentation which covers dwmac v4.2, the
hardware TSO feature can handle header lengths up to a maximum of 1023
bytes.

Add a .ndo_features_check() method implementation to check the header
length meets these requirements, otherwise fall back to software GSO.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 2957ee4a43db..e21ca1c70c6d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4940,6 +4940,14 @@ static netdev_features_t stmmac_features_check(struct sk_buff *skb,
 		queue = skb_get_queue_mapping(skb);
 		if (!stmmac_channel_tso_permitted(netdev_priv(dev), queue))
 			features &= ~NETIF_F_GSO_MASK;
+
+		/* STM32MP151 (dwmac v4.2) and STM32MP25xx (dwmac v5.3) states
+		 * for TDES2 normal (read format) descriptor that the maximum
+		 * header length supported for the TSO feature is 1023 bytes.
+		 * Fall back to software GSO for these skbs.
+		 */
+		if (skb_headlen(skb) > 1023)
+			features &= ~NETIF_F_GSO_MASK;
 	}
 
 	return features;
-- 
2.47.3


