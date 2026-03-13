Return-Path: <netdev+bounces-267373-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kL7bG7jes2ktcQAAu9opvQ
	(envelope-from <netdev+bounces-267373-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:54:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 814AC280E57
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 96C9630138EC
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 09:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359783890FB;
	Fri, 13 Mar 2026 09:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="AMD3BQDB"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9181440DFCE;
	Fri, 13 Mar 2026 09:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773395511; cv=none; b=uyOz5Umlfv/KMmSolC/UATk7sDcjB8yRKJzHNqkGdGokuO+vaXnU1mCEJfq1fl6rw0lweeRnxgtcbIWC+E+relb1KBMhTdw2keisKpT7leiOct0LOyaPMlxrUthbn/+Tspu21RXWt+IjLgnLFg6Gn0aRzhNPc1KUd6wwZaDghoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773395511; c=relaxed/simple;
	bh=ZWq64joZ2HzysBWsR0irO48NxLG3PCjk88eimnNVwaI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=tpf8RsLi0ae3a6S9GoeU13gysTfnfZVC9Mp0aMx5UW2+Z58PnMR5ZFHwcfLSSFHtE19hAqFnTiHnoKLyib7vO6fqSGeGeRnJPYomdgW64iZHaF0yafBz0vIEjMWXEhxNa7vxOoKWESl/94rf9re3uEQwI5LSQKmR+wjjHWskA8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=AMD3BQDB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5rpidXVVDoCtCkRYl0DmYJZsfgbhv+B1m4hTkd40PP4=; b=AMD3BQDBbp9kpthRPyHQQuQi/0
	Md8sHY9oqwssZKurdsTCIDNw7zu9KH1f61IbZm9Pu81oE8aK+yIRR+qi9U0z7Xtn/yBPc87QuU0ap
	1A7oCBGECQRMAzSbxC7LqkwDrKzA4ztNyB01s/ekwd/0EBClh9LNYDj9o7lq1jJT6Gq3k/znWuIlm
	tPOFO/0lOQmu1GxPXQtMvyWpdLHYbk5RGPBfveDuyRBky7irgNQ3gmQsRKehL+/XT3dNNGKuJfbhw
	M6PQtJvhcu0wcU4BVF41GaTPJxlur3Pf99KZIN5lKJ2qmfEy5soZs1yav93EG+2lC7uCTgGTQhSsU
	nLCh1lvg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:53558 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w0zBG-000000000ej-1afF;
	Fri, 13 Mar 2026 09:51:42 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w0zBC-0000000D4Fg-2QA6;
	Fri, 13 Mar 2026 09:51:38 +0000
In-Reply-To: <abPdzyXJHqt5v3bi@shell.armlinux.org.uk>
References: <abPdzyXJHqt5v3bi@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH net-next v3 08/15] net: stmmac: use consistent tests for
 receive buffer size
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w0zBC-0000000D4Fg-2QA6@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 13 Mar 2026 09:51:38 +0000
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267373-lists,netdev=lfdr.de,kernel];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.980];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rmk-PC.armlinux.org.uk:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 814AC280E57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Two out of the three sites that set the receive buffer size (via
stmmac_set_dma_bfsize()) check for rx_q->xsk_pool &&
rx_q->buf_alloc_num. One uses just rx_q->xsk_pool.

Discussing with Yoong Siang Song, the conclusion is that
stmmac_dma_operation_mode() is missing the rx_q->buf_alloc_num
check. Add this check.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 1d40168ec68d..787b02c2607a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2612,7 +2612,7 @@ static void stmmac_dma_operation_mode(struct stmmac_priv *priv)
 		stmmac_dma_rx_mode(priv, priv->ioaddr, rxmode, chan,
 				rxfifosz, qmode);
 
-		if (rx_q->xsk_pool) {
+		if (rx_q->xsk_pool && rx_q->buf_alloc_num) {
 			buf_size = xsk_pool_get_rx_frame_size(rx_q->xsk_pool);
 			stmmac_set_dma_bfsize(priv, priv->ioaddr,
 					      buf_size,
-- 
2.47.3


