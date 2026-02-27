Return-Path: <netdev+bounces-261800-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COUkKgZroWkOswQAu9opvQ
	(envelope-from <netdev+bounces-261800-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:59:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BAE1B5AC3
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FF0130FE016
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 09:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C947C3603C7;
	Fri, 27 Feb 2026 09:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="LlANKypZ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9F936EAAA
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 09:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772186051; cv=none; b=Wo/fzOrM+pnlbi6yQgNs7c7UHNpkx55NuDSH7s0afnHXBLziMV8PqEY0CL9GOgOpJuOGpo4jX0tqPJWh4qb9O7j855XYknfwzXtPB3NaDHp1AQdr+1z1+RU9i5bTN6Q1EXUh6TU/Mqgocije57BTLBzNr6JhYnNUGlZRkC/4elE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772186051; c=relaxed/simple;
	bh=RKuDj33bztk7ruuZvVscrGrwvjKDTDgg3n1Ip1u6nEc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=dko/wr3Hi8nVFnA+5DZpk0iXO5VB1CScXKg4IBMsvm/TbJwfdwSDwM1ywoIHGK8xPZmiAs2UG4IEISwYDy5Nb0SEBq9l7hcxD+ixQXRn7QNWEOppkvfXMEYcgfudOo++rlA+TMt0Bt42+gUv33Xg0cmso1XLBS7ty2BDsNARGCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=LlANKypZ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=F/bQ/rnZccmE+rKEzBQi9hVeRpGw3fDnoAfQlnEj840=; b=LlANKypZGhCuf/3rBmJkaWbYwO
	hjAwDH6LEMXPfmVCjXNsVBgYTpEbhun7bKTNbpbY9MusACHZao6vkc2PQCsWg6T9fF3mNf6VWepCt
	Hpz7svS31tOW+iDZiCCn7yOrH06pl48RD6loS5K9npUyxISLEB0TD6Z1xwlnUzNYmEm3CyhhGSj0F
	bVJQwIRQRiWdLVP7nXX0vjcfLq0YPYZbn97qjPivg+M9/UoEMf6wKUe7Q0iAuBCtu0H7veNioK2i8
	TQD3nTuYoO26urWnYGi9mnHcDWQGUFl0y5+tD2ly/v/MX/sCFDGAxC8Di4+Kl7K7EdpNvjaHfPPLs
	5TE32ArA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:39328 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vvuXh-000000000e2-0PzH;
	Fri, 27 Feb 2026 09:53:53 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vvuXd-0000000AvnL-36K3;
	Fri, 27 Feb 2026 09:53:49 +0000
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
Subject: [PATCH net-next 09/14] net: stmmac: make extend_desc boolean
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vvuXd-0000000AvnL-36K3@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 27 Feb 2026 09:53:49 +0000
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261800-lists,netdev=lfdr.de,kernel];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.979];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rmk-PC.armlinux.org.uk:mid,armlinux.org.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 16BAE1B5AC3
X-Rspamd-Action: no action

extend_desc is a boolean, so make it so, and use "true" to assign it.
Add a comment to describe what this member does.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.c   | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 1fcc91be7589..71dac8c1a3ca 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -76,7 +76,7 @@ static int stmmac_dwmac1_quirks(struct stmmac_priv *priv)
 		/* GMAC older than 3.50 has no extended descriptors */
 		if (priv->synopsys_id >= DWMAC_CORE_3_50) {
 			dev_info(priv->device, "Enabled extended descriptors\n");
-			priv->extend_desc = 1;
+			priv->extend_desc = true;
 		} else {
 			dev_warn(priv->device, "Extended descriptors not supported\n");
 		}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 51c96a738151..57ded8e5177f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -302,9 +302,13 @@ struct stmmac_priv {
 	bool eee_active;
 	bool eee_sw_timer_en;
 	bool legacy_serdes_is_powered;
+	/* descriptor format:
+	 *  when clear: struct dma_desc or for tx TBS struct dma_edesc
+	 *  when set, struct dma_extended_desc
+	 */
+	bool extend_desc;
 	unsigned int mode;
 	unsigned int chain_mode;
-	int extend_desc;
 	struct kernel_hwtstamp_config tstamp_config;
 	struct ptp_clock *ptp_clock;
 	struct ptp_clock_info ptp_clock_ops;
-- 
2.47.3


