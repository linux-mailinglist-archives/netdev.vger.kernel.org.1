Return-Path: <netdev+bounces-260016-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AP5GENFGnGk7CgQAu9opvQ
	(envelope-from <netdev+bounces-260016-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 13:23:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C7F176134
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 13:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 263373064D87
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 12:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726B0364E99;
	Mon, 23 Feb 2026 12:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="X6C/85+N"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8A235CB88
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 12:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771849256; cv=none; b=KT5crTOGRHYejGcddjsdiUonXTnAaTnyxOayKdc9H8eb9SpxCFZQKkQA/GRdZWnyemeqT7kDVcppSeKzZdP1RwhtXO3VIun9IkELbaQCx7iUwS/bwlhaOO0FH+ocWkXkmtyuCY5gXPhl3qlqoAHtVw2+yKM+MbEaGrToUOkv1rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771849256; c=relaxed/simple;
	bh=2iw31Z3kkBHhRKv6DMZP5bmlXP59rxyO/rw+K6orc28=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=dzzhBLmj7yQK4EqQLjLEFw68gen3V88cV+UFHkFUnht7Q8Whyz82HHcjPPuRnLizA6uWsAxu1MayvjXZbpr+eL46E+3seQJHK790NTgAWWp4AF61cuqyUg2lw6RcSJpQBR8F68IA8WEa2DT7m3Dp4CgLNntua11yHhB8VEpqnlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=X6C/85+N; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WlXYakfMf+ynG/+XvFLVLTMU3fE1qwrOnQf6HbLOsMw=; b=X6C/85+Nwi1gOJWplZ32FYoSY5
	TDVf8Feo1ixuSE67TSMw0cTbesCppzibNmxdC5pWPcFd1gFoUhBAp1DaTfzbjoC1FTjV3bMNlj7uJ
	4RlfLj3XtWxkyqlOuDanF/VAtZ4f2a0pV2pEPvM9fRrunJ9RGrYuBqP7AdfjpujiMet5AyvYkG0iA
	wMe5V0D4dmsdajd+dP2rvioxi/TpjNObB1DlbjWnxAQanpDPfUUpBIILLBt3c/DeLu0u7+wyAGq/g
	TRKZCXog6espy1uvkC2Sq+HkK9BcP0C3NqqdS4P6bUUqvBq9uEzmxnpsVrz9XsgjRyndujc+3LPFA
	qapvn5BA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41386 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vuUvf-0000000043Q-3ja9;
	Mon, 23 Feb 2026 12:20:47 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vuUvf-0000000AfhS-0lJR;
	Mon, 23 Feb 2026 12:20:47 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] net: stmmac: ptp: limit n_per_out
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vuUvf-0000000AfhS-0lJR@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 23 Feb 2026 12:20:47 +0000
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
	TAGGED_FROM(0.00)[bounces-260016-lists,netdev=lfdr.de,kernel];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.960];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rmk-PC.armlinux.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:email]
X-Rspamd-Queue-Id: A5C7F176134
X-Rspamd-Action: no action

ptp_clock_ops.n_per_out sets the number of PPS outputs, which the PTP
subsystem uses to validate userspace input, such as the index number
used in a PTP_CLK_REQ_PEROUT request.

stmmac_enable() uses this to index the priv->pps array, which is an
array of size STMMAC_PPS_MAX. ptp_clock_ops.n_per_out is initialised
using priv->dma_cap.pps_out_num, which is a three bit field read from
hardware.

Documentation that I've checked suggests that values >= 5 are reserved,
but that doesn't mean such values won't appear, and if they do, we
can overrun the priv->pps array in stmmac_enable().

stmmac_ptp_register() has protection against this in its loop, but it
doesn't act to limit ptp_clock_ops.n_per_out.

Fix this by introducing a local variable, pps_out_num which is limited
to STMMAC_PPS_MAX, and use that when initialising the array and setting
priv->ptp_clock_ops.n_per_out.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---

This could be a user exploitable bug (although one has to be root
so the gun is already pointing at one's foot.) This is the commit
which introduced the problem:

Fixes: 9a8a02c9d46d ("net: stmmac: Add Flexible PPS support")

 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 3e30172fa129..cf5506bf2198 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -334,13 +334,14 @@ const struct ptp_clock_info dwmac1000_ptp_clock_ops = {
  */
 void stmmac_ptp_register(struct stmmac_priv *priv)
 {
+	unsigned int pps_out_num = priv->dma_cap.pps_out_num;
 	int i;
 
-	for (i = 0; i < priv->dma_cap.pps_out_num; i++) {
-		if (i >= STMMAC_PPS_MAX)
-			break;
+	if (pps_out_num > STMMAC_PPS_MAX)
+		pps_out_num = STMMAC_PPS_MAX;
+
+	for (i = 0; i < pps_out_num; i++)
 		priv->pps[i].available = true;
-	}
 
 	/* Calculate the clock domain crossing (CDC) error if necessary */
 	priv->plat->cdc_error_adj = 0;
@@ -350,8 +351,8 @@ void stmmac_ptp_register(struct stmmac_priv *priv)
 	/* Update the ptp clock parameters based on feature discovery, when
 	 * available
 	 */
-	if (priv->dma_cap.pps_out_num)
-		priv->ptp_clock_ops.n_per_out = priv->dma_cap.pps_out_num;
+	if (pps_out_num)
+		priv->ptp_clock_ops.n_per_out = pps_out_num;
 
 	if (priv->dma_cap.aux_snapshot_n)
 		priv->ptp_clock_ops.n_ext_ts = priv->dma_cap.aux_snapshot_n;
-- 
2.47.3


