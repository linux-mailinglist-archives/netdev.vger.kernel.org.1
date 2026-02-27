Return-Path: <netdev+bounces-261803-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCGwL9VpoWkOswQAu9opvQ
	(envelope-from <netdev+bounces-261803-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:54:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF0A1B59E9
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69FD330269FF
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 09:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36425364934;
	Fri, 27 Feb 2026 09:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KBULIJm9"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFC138BF73
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 09:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772186062; cv=none; b=Vhyi3YgoVP2is1HVAol2TNNJqPrDW6nXVUOC7rrvr9YpQIquItfjXkTCUBQsbVDx69mwuEyXnDN4frfkMRmXrjGAfvMl4c98MtzrO0iJafx4muloLzU+MKsUOdy4BCPg0MFTJ0VaYD0TIP2T85zcwalgvSs5Ntt1vSZIZu2t1a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772186062; c=relaxed/simple;
	bh=xMEvE6MVW5KbtPNmUGe+9TTiSBXrZkrUvFI/EewsC9g=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=GgC4oaAjDFiOwRZzALAkkY45gIyttrT9eJEeVN4H+LK1pM1cuuX0YR5tD3kzsFiemOzJShWwX19CCn6YfJOYiOSTBn4Dg+tg790KOGBIwX+G4TEzk/ar6d8lNwK+zas5jxWAwPvtZJIQdmKLtugM64uTmoV8i8cffucEbB6AnBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=KBULIJm9; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6kho+T4pB8cv+vYpSQaKdyOQtMZDJQnvD+jvbZwcTao=; b=KBULIJm9VA8MYAefHp/vSThrAx
	V8GWElB+2MqeYurSe7W44GzIst9yjOmhthTTQ7/cdQeRfLJdH/NK/H8e9nvA8SIgDcEPuKeirI2rv
	F4WRLxufwnOJZGVD5T3LZtmaWiHqgkep+GSqPwC9mO7xfmeKtvmjKCL8Eso6a5wbEHMzh/O3MPV/X
	lF/sYQwdgM1Rb4VA37nWsFUrnzAUb6fA0DwweHhMYit+bxsJS3+3VDF13FjTylicfI4QE/amp/XZv
	3JsyiV4HUCwE+F2XS9o9AvWNUXyNmyJqhfN2QhmOF/gMnbzD6ye4fq778T+eOsDXg6MxQEjm/5S5s
	SyNSKUGA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:51756 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vvuXx-000000000en-1MNL;
	Fri, 27 Feb 2026 09:54:09 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vvuXt-0000000Avnc-0UYC;
	Fri, 27 Feb 2026 09:54:05 +0000
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
Subject: [PATCH net-next 12/14] net: stmmac: move initialisation of
 dma_cfg->atds
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vvuXt-0000000Avnc-0UYC@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 27 Feb 2026 09:54:05 +0000
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-261803-lists,netdev=lfdr.de,kernel];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.978];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rmk-PC.armlinux.org.uk:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 3AF0A1B59E9
X-Rspamd-Action: no action

Move the initialisation of priv->plat->dma_cfg->atds, which indicates
that 8 32-bit word descriptors are being used for pre-v4.0 cores, after
the call to stmmac_hwif_init(), which will initialise priv->extend_desc
and priv->mode (the descriptor mode.)

We don't need to re-evaluate this in stmmac_init_dma_engine() - as the
state that it depends on only changes in stmmac_hwif_init() which is
only called in the probe path. Also, once set, no code clears this
flag.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index be144b946fd5..38f6b890ec37 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3254,9 +3254,6 @@ static int stmmac_init_dma_engine(struct stmmac_priv *priv)
 		return -EINVAL;
 	}
 
-	if (priv->extend_desc && (priv->mode == STMMAC_RING_MODE))
-		priv->plat->dma_cfg->atds = 1;
-
 	ret = stmmac_prereset_configure(priv);
 	if (ret)
 		return ret;
@@ -7449,6 +7446,13 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
 			return ret;
 	}
 
+	/* Set alternate descriptor size (which tells the hardware that
+	 * descriptors are 8 32-bit words) when using extended descriptors
+	 * with ring mode. Only applicable for pre-v4.0 cores.
+	 */
+	if (priv->extend_desc && priv->mode == STMMAC_RING_MODE)
+		priv->plat->dma_cfg->atds = 1;
+
 	/* Rx Watchdog is available in the COREs newer than the 3.40.
 	 * In some case, for example on bugged HW this feature
 	 * has to be disable and this can be done by passing the
-- 
2.47.3


