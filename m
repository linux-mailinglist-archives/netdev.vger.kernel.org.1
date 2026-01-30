Return-Path: <netdev+bounces-255246-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEAtOfcOfWlvQAIAu9opvQ
	(envelope-from <netdev+bounces-255246-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 21:05:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BD70ABE4CB
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 21:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A948300788A
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 20:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED91030C62D;
	Fri, 30 Jan 2026 20:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="RF6+jDvs"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD8B3064AF
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 20:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769803509; cv=none; b=NExij7t3sbVDubqRjEA7iinojSP631F+p7UjiCXnIWUHHVVAKsSfo4KuOfwXtOxgfYggO6f09KBzcDnWfF++kzIqbwWxCWjZcvcXV1Gp8QhPMvkaC3kRjcHb4OR8P3nwaxaKSUhTx0QetPXsDEcqS9ASqeMuVcZFwKsMO5GcD7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769803509; c=relaxed/simple;
	bh=wTrtt3kWWWKYk32kth3QuNjJH2UXyw9rdIsnI1vWA+4=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=F/XOuCLaLltsC0oJagH2RBAx4VBuOXIfNAH/IZL0O+AqbLn+HxqzPlfj0IZFcARBXqgav5UjDusFWFCy1NdLdv9YY8Br4nsWsGKamTE5RDHiTyHZNc9sZdN8jQrLfGxm/vCipE6fe/huhWYmW7NY/lqdUs6xbxdCw4nAehoSM50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=RF6+jDvs; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XkZOk7FqUkLdlqp2VaiHJPS5cbES3nLzbHstV3AGmGc=; b=RF6+jDvsep//mrz7LBk9SpZ0TI
	z2g/rs+QEsbyulobRblX3QGeUrKHDwrdKLvRrPIiS4ReOXKvvzi2BemIO5SKccuncQZXXlHuunvaV
	+3uV33J40n5CgEQCqOdaSKURuiyxMPnIAsnQJiyWJwZV9S6fpheOqNmMxO9+Cbm9K7AGTtsN1QPsU
	qqYnazJnI8qALiU0qWCxSDtKMYeIbMV2E67Qduw0O4bolUOPtYQSLgG9RygNCwH1pT7RlfFJw5ry/
	orqcxB6H559vtz+e/eZZBcKmg9j4TzeOAwO6YPjRUPpXvwIGriY9XJMSeo0D3yqxciAWQwvuyBN2F
	5mCsG+uA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:40108 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vluji-000000001Ox-3M4H;
	Fri, 30 Jan 2026 20:04:58 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vlujh-00000007Hkw-2p6r;
	Fri, 30 Jan 2026 20:04:57 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Marek Vasut <marex@nabladev.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] net: stmmac: fix stm32 (and potentially others) resume
 regression
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vlujh-00000007Hkw-2p6r@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 30 Jan 2026 20:04:57 +0000
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255246-lists,netdev=lfdr.de,kernel];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nabladev.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BD70ABE4CB
X-Rspamd-Action: no action

Marek reported that suspending stm32 causes the following errors when
the interface is administratively down:

	$ echo devices > /sys/power/pm_test
	$ echo mem > /sys/power/state
	...
	ck_ker_eth2stp already disabled
	...
	ck_ker_eth2stp already unprepared
	...

On suspend, stm32 starts the eth2stp clock in its suspend method, and
stops it in the resume method. This is because the blamed commit omits
the call to the platform glue ->suspend() method, but does make the
call to the platform glue ->resume() method.

This problem affects all other converted drivers as well - e.g. looking
at the PCIe drivers, pci_save_state() will not be called, but
pci_restore_state() will be. Similar issues affect all other drivers.

Fix this by always calling the ->suspend() method, even when the network
interface is down. This fixes all the conversions to the platform glue
->suspend() and ->resume() methods.

Link: https://lore.kernel.org/r/20260114081809.12758-1-marex@nabladev.com
Fixes: 07bbbfe7addf ("net: stmmac: add suspend()/resume() platform ops")
Reported-by: Marek Vasut <marex@nabladev.com>
Tested-by: Marek Vasut <marex@nabladev.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3f42843cd9ed..a379221b96a3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -8042,7 +8042,7 @@ int stmmac_suspend(struct device *dev)
 	u32 chan;
 
 	if (!ndev || !netif_running(ndev))
-		return 0;
+		goto suspend_bsp;
 
 	mutex_lock(&priv->lock);
 
@@ -8082,6 +8082,7 @@ int stmmac_suspend(struct device *dev)
 	if (stmmac_fpe_supported(priv))
 		ethtool_mmsv_stop(&priv->fpe_cfg.mmsv);
 
+suspend_bsp:
 	if (priv->plat->suspend)
 		return priv->plat->suspend(dev, priv->plat->bsp_priv);
 
-- 
2.47.3


