Return-Path: <netdev+bounces-261813-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PvkOf5voWm6swQAu9opvQ
	(envelope-from <netdev+bounces-261813-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 11:20:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 437131B5F19
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 11:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EDA730512A6
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15B236BCE8;
	Fri, 27 Feb 2026 10:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="XRuEyIeA"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B34D361DA2
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772187607; cv=none; b=A/7OI3ydSy5rzqEUF7itwvI5Dj5XBmVvdJonILhhFyErkzNoHumOragjmD1hGHZgHBf0zF+G3/MU0aPVscyH16xtJnNs7Mpgp9q1c9b96AoqgVre63wg/OJ7noa4dqBfIgf7j+hVBKxRyCCk2eVhypado0T0G01P/WhbU1WYJxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772187607; c=relaxed/simple;
	bh=S5WbKUe/GSU6gr4sflzxccH6wjNJ3Au64Oqxsj6D0Rk=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ENkXSHMF7n9MvepsiY9cWLCO2UaN5DdUYr4Rl1vqo8dYrO59WMosnFmiSnAq+z2c+DerKTzWy+ka9JerUg3pcrOosQxyarI9FLlLLJx0cLoBBTktiVCtVmlc5d96zN2IUr8/d8VyP8penMdVb/F3Z88HxssA7AgSzzkhpD3dt5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=XRuEyIeA; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gc2DPN8dhX2Y1LOPz3Pgjt4dmwCjQz6dghOPKT5Mkqc=; b=XRuEyIeAZwlUVZF1DdUW031rTe
	cvvhNEEzGhi671hJzVqyKXUiWPT34bBho+i3MQDoZkj5prIbekJXlJVsSB/98Y5aQPZdg7keIBOul
	e7o3J0LjKtdlHaD9V8VFiSj5BPjSWkghqn8Z4JWb5irZRwTcqv2Doa3uzHfCdaSg6gRhgsfAyX2un
	usKAWz1E3VYotNfggkhzfv43CGdbuex8AuSftqAVG7gZ6LYf1/0zxam8IXHP8OY0YqkK2rSoiasyF
	ZCXLH5bFdDeMwWeSzEhZbDXnpAjB6ZK6vIeiZoDzZIgryNrbBBx3c36Id8vwskgNe0wiSfUsYxw/m
	xbEPlcBw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:43828 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vvuY5-000000000fN-13zF;
	Fri, 27 Feb 2026 09:54:17 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vvuY3-0000000Avnq-1Spv;
	Fri, 27 Feb 2026 09:54:15 +0000
In-Reply-To: <aaFpZvuIzOLaNM0m@shell.armlinux.org.uk>
References: <aaFpZvuIzOLaNM0m@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 14/14] net: stmmac: move DMA configuration validation
 to driver probe
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vvuY3-0000000Avnq-1Spv@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 27 Feb 2026 09:54:15 +0000
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261813-lists,netdev=lfdr.de,kernel];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.979];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:email,rmk-PC.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 437131B5F19
X-Rspamd-Action: no action

Move the DMA configuration validation from stmmac_init_dma_engine()
to the start of the driver probe function. The platform glue is
expected to supply the DMA configuration, and a non-zero programmable
burst length (bpl).

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a9b26d12a057..5d1cc9aead00 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3249,11 +3249,6 @@ static int stmmac_init_dma_engine(struct stmmac_priv *priv)
 	u32 chan = 0;
 	int ret = 0;
 
-	if (!priv->plat->dma_cfg || !priv->plat->dma_cfg->pbl) {
-		netdev_err(priv->dev, "Invalid DMA configuration\n");
-		return -EINVAL;
-	}
-
 	ret = stmmac_prereset_configure(priv);
 	if (ret)
 		return ret;
@@ -7733,6 +7728,11 @@ static int __stmmac_dvr_probe(struct device *device,
 	u32 rxq;
 	int i, ret = 0;
 
+	if (!plat_dat->dma_cfg || !plat_dat->dma_cfg->pbl) {
+		dev_err(device, "invalid DMA configuration\n");
+		return -EINVAL;
+	}
+
 	ndev = devm_alloc_etherdev_mqs(device, sizeof(struct stmmac_priv),
 				       MTL_MAX_TX_QUEUES, MTL_MAX_RX_QUEUES);
 	if (!ndev)
-- 
2.47.3


