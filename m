Return-Path: <netdev+bounces-265117-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKwaErYDrGkFjAEAu9opvQ
	(envelope-from <netdev+bounces-265117-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 11:53:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4508722B34A
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 11:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2C8613014A31
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 10:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D6233AD82;
	Sat,  7 Mar 2026 10:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zp8DijVf"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CF821CFE0
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772880803; cv=none; b=o4Djf3yIx7o+J4Wk9AKRPZrW32O/qzDlfNygjnu4cB6FOBcc05Wsm0c5gIl4oeyJcE0fzSiIijUbXUpjGm6xnkhaGQ7QmKeQlKjHVFHIQ9b5N5VNwv8xGukMQ1QGfrZFVqLq9x8JQy0lRaQUA8ZOIv43OiGmemlUBzWPvStncNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772880803; c=relaxed/simple;
	bh=mZ+GO9kHO5m6bVPwQQYDdVPiodNPwBklQKFVT92K9Uc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=MGXFZjKct3BY70Y9+nxiiUQNkZagBSOH4sqSNDWXFRAERYByRtEuBs/QkPuz4WvpBcG05UfCD2yhuqWvakKnngpM/5wWv+rVlMHosPOW8n0EV4VIaMeQxLEFjs+uTwxCDdvqWCRms9iVRtz3W1hg4sIFCACjnlbWaUOgqSA8QJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zp8DijVf; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=702wOfxhINsK5kpNSdhf3nuVOhqS4fpKbmE3wnxb/5E=; b=zp8DijVfcZtlxs1VZOj203boBT
	EwdhwEwD2iFXynI2iHVd8aFWjUBuyL5wg7XqUmXymxPsBLEoB4Bvror9Z7GQSTKpIwk93qeSLZoVX
	6CflVvA8vqFg5eMu76YzFXevfVnYRjBIDVAYHtPo6VDF99f3SQHtvphp4F7VbefZD6CZThx6uDe1t
	OFFv7ehbJ5oVkmbJiQysJMIqXR5rbHcHYXWdW0g56PcYj8MbApxy4haBIL3YOM1oO1LTehmyy7x3i
	S6WY2zBI1EwQvDtbOZNSSdp1bLHeRRVVlnSNTMtLX1QEl6JpJPvww3pWqWoPdLcckYv2jeJbZDvPi
	YGcLDkEg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:43718 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vypHY-0000000024v-01SQ;
	Sat, 07 Mar 2026 10:53:16 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vypHX-0000000CSbc-123K;
	Sat, 07 Mar 2026 10:53:15 +0000
In-Reply-To: <aawDiK7DjcSXSs1X@shell.armlinux.org.uk>
References: <aawDiK7DjcSXSs1X@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 1/2] net: stmmac: ptp: rearrange n_ext_ts
 initialisation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vypHX-0000000CSbc-123K@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sat, 07 Mar 2026 10:53:15 +0000
X-Rspamd-Queue-Id: 4508722B34A
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
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265117-lists,netdev=lfdr.de,kernel];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.296];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rmk-PC.armlinux.org.uk:mid,armlinux.org.uk:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Use local variables for n_ext_ts rather than referencing the DMA
capability several times.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 98da499ba3b1..654d04f8c373 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -335,6 +335,7 @@ const struct ptp_clock_info dwmac1000_ptp_clock_ops = {
 void stmmac_ptp_register(struct stmmac_priv *priv)
 {
 	unsigned int pps_out_num = priv->dma_cap.pps_out_num;
+	unsigned int n_ext_ts;
 	int i;
 
 	if (pps_out_num > STMMAC_PPS_MAX) {
@@ -358,8 +359,9 @@ void stmmac_ptp_register(struct stmmac_priv *priv)
 	if (pps_out_num)
 		priv->ptp_clock_ops.n_per_out = pps_out_num;
 
-	if (priv->dma_cap.aux_snapshot_n)
-		priv->ptp_clock_ops.n_ext_ts = priv->dma_cap.aux_snapshot_n;
+	n_ext_ts = priv->dma_cap.aux_snapshot_n;
+	if (n_ext_ts)
+		priv->ptp_clock_ops.n_ext_ts = n_ext_ts;
 
 	if (priv->plat->ptp_max_adj)
 		priv->ptp_clock_ops.max_adj = priv->plat->ptp_max_adj;
-- 
2.47.3


