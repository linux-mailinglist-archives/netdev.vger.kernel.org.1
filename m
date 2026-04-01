Return-Path: <netdev+bounces-273931-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DAjOybIzGn5WgYAu9opvQ
	(envelope-from <netdev+bounces-273931-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:24:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 76222375CD3
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2C4C30E8916
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 07:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7397437B012;
	Wed,  1 Apr 2026 07:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="GqNvIqZo"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F263C376BCD
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 07:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775028111; cv=none; b=Q+F6tcxCqghkLzhCSlb5O2OgqNoQ0kgbLebcyHN+ez0M+qyGlTFk/jVDVWIKAFeUVMnSuAsmITZY+/K7EveYIhZs6h0LxeDkhq9Zef28RXmdiVLes32BWcpKOf8zJLRCdnqag5QbocZ2QpXd/scS5Zv9wVevHiZRet+goeC1bRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775028111; c=relaxed/simple;
	bh=EPzI7asSoluFOcbu22r5JiCkDx3b6T0eRTVXzL1VAMI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=JyQYDmZzJKN6r6F9skRhCbu16YQ1jHt5rtE6JjGau/yFejP/fCRAEGSbjWV+6RYS+xb72fARUU7+HXG+2259M1fciVJV8hyAFlC6IPA3Qs4lpqQtE6n+QX0PpuDyLM+ndl14D2CDp61qHRH/+AWjTigrUmR2VPGVmx1KYVmGago=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=GqNvIqZo; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9/5jetOXR4x4aaSx1QBWBlZ8VD7jqIHKoH/Y1tbFC5A=; b=GqNvIqZoA5gd71eKX/QcHVN/Ne
	6vOstvxdHEkR/WksCL4ZEG5MFw6rLXC3FFX0/h+IBaVRdWl1AlzdHSFwYyhCBGNtb259KPE8NJR2e
	H1vMmv5rkqBJ3vd0TSNKIgCndWc4kKAA4KWtk18fMzNkxf0xOrsIFEs0p9c8OY1jdUfw5Z9Nps5Wq
	OZZijREV9nIu4j+hwJ5g+lj3r1FpAPd5injy3CSH2Gfn4r9NiVrZpzrAK4WH+0fCDQ6xsSTDx3P6q
	7wjAIfwazR6WjigZwtDfCoMzlPAwlljRxzole+14iAraJKnTuq3E6kCT7Vcr+gcFzmAlhgd9i2GOH
	yV+9zWlA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41312 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w7ptU-000000002gu-3v66;
	Wed, 01 Apr 2026 08:21:41 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w7ptT-0000000EatI-3feh;
	Wed, 01 Apr 2026 08:21:39 +0100
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
Subject: [PATCH net-next v2 06/14] net: stmmac: add GSO MSS checks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w7ptT-0000000EatI-3feh@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 01 Apr 2026 08:21:39 +0100
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273931-lists,netdev=lfdr.de,kernel];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.881];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rmk-PC.armlinux.org.uk:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 76222375CD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add GSO MSS checks to stmmac_features_check().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 031ffb78f40d..b4cc34dd0d76 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4391,12 +4391,19 @@ static size_t stmmac_tso_header_size(struct sk_buff *skb)
  *
  * While IPv4 is limited to MAC+VLAN+IPv4+ext+TCP+ext = 138 bytes, the IPv6
  * extension headers aren't similarly limited.
+ *
+ * Fall back to software GSO for these skbs. Also check that the MSS is >=
+ * the recommended 64 bytes (documented in ETH_DMACxCR register description),
+ * and that a the header plus MSS is not larger than 16383 (documented in
+ * "Building the Descriptor and the packet for the TSO feature").
  */
 static bool stmmac_tso_valid_packet(struct sk_buff *skb)
 {
 	size_t header_len = stmmac_tso_header_size(skb);
+	unsigned int gso_size = skb_shinfo(skb)->gso_size;
 
-	return header_len <= 1023;
+	return header_len <= 1023 && gso_size >= 64 &&
+	       header_len + gso_size < 16383;
 }
 
 /**
-- 
2.47.3


