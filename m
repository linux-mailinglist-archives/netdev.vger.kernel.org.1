Return-Path: <netdev+bounces-273940-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDoKGtnHzGn5WgYAu9opvQ
	(envelope-from <netdev+bounces-273940-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:23:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E954375C98
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DFE173045274
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 07:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BAB37C0E5;
	Wed,  1 Apr 2026 07:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DWllS1wt"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BFC36EA8B
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 07:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775028153; cv=none; b=CsLx2Lc/N3hxYFCd1FHJfst7dkpvAAlFPM6xhmuNiXFQzCdZhjzekJbBprGsF9L5Jei14s3mZi7Fg/tAQvgQSnxUrj6LOg6MuWJJnCroNPe3ddAVBlnvTh3rgHinarJw03htCP60/k7ZyFMfKOStgsLSSCcMCRRjg6NNZB08ePQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775028153; c=relaxed/simple;
	bh=pUcDquLlHVjQZ+/0nY2I8HPTx2U5C2c2ancprO1/UWk=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Cr/PSWtaI3nSXB4OfZOROfg56VK51Mj7ZoEhlP0Fg0hwGIueUMFyhi7MI9MZ3ig/dwTCMTJmndhiVbzfhcg+33pI4tq7WateClWYi/CgavcPTUS6VVvbdqqUnp5bvMR9n3YcyfB36ndE0uyhwzHfn5UpR6Bj78kQPOD/oOX9kjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DWllS1wt; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7e//swqwHU8cxAR5zK0XovUJAr7PPmCorHDhD/SbGoE=; b=DWllS1wtCsr/wuu8J3LmNYkVaS
	yorU2v7Cu5jHVhdQObSTEnlCMqGNYp8nG9h0W1evG9+RAriihKpkLMiv9/pZuSRixRhkfGUyeRIIl
	yB7mhiu7o0oI5go87sIb6b9yvv/OD0EMXm91i8iE3onYWpInA8tZvNEv4XlilPSQGCWTdM/iANjH5
	/hRbVGKgXxFMopr0GIzcrI1Aye8JPnfPjeN85g3QLFfBY4cmp8tmkjtH33SZpQZBNmheKR/4A3UM5
	HObAWBsVXa4d11wCc9oGLLts1K2xmKGwmdepxk6Xzt95HBIGVd2rMyijZEQrTwjDjXtIv1ZsZigZs
	/LW3ZgIQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:56898 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w7puA-000000002jU-4BQj;
	Wed, 01 Apr 2026 08:22:23 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w7pu8-0000000Eau5-3Zne;
	Wed, 01 Apr 2026 08:22:20 +0100
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
Subject: [PATCH net-next v2 14/14] net: stmmac: move "TSO supported" message
 to stmmac_set_gso_features()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w7pu8-0000000Eau5-3Zne@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 01 Apr 2026 08:22:20 +0100
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
	TAGGED_FROM(0.00)[bounces-273940-lists,netdev=lfdr.de,kernel];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.877];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rmk-PC.armlinux.org.uk:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 0E954375C98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move the "TSO supported" message to stmmac_set_gso_features() so that
we group all probe-time TSO stuff in one place.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 406c32142d90..3e01f968115d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4391,6 +4391,9 @@ static void stmmac_set_gso_features(struct net_device *ndev)
 	const struct stmmac_dma_cfg *dma_cfg;
 	int txpbl;
 
+	if (priv->dma_cap.tsoen)
+		dev_info(priv->device, "TSO supported\n");
+
 	if (!(priv->plat->flags & STMMAC_FLAG_TSO_EN))
 		return;
 
@@ -7469,9 +7472,6 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
 		devm_pm_set_wake_irq(priv->device, priv->wol_irq);
 	}
 
-	if (priv->dma_cap.tsoen)
-		dev_info(priv->device, "TSO supported\n");
-
 	if (priv->dma_cap.number_rx_queues &&
 	    priv->plat->rx_queues_to_use > priv->dma_cap.number_rx_queues) {
 		dev_warn(priv->device,
-- 
2.47.3


