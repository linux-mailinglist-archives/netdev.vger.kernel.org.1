Return-Path: <netdev+bounces-267366-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKr0MYjfs2ktcQAAu9opvQ
	(envelope-from <netdev+bounces-267366-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:57:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2EC280FBC
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 361E43059ABF
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 09:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33B0381AF2;
	Fri, 13 Mar 2026 09:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Fo2qyXoE"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676A8363094;
	Fri, 13 Mar 2026 09:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773395468; cv=none; b=t9pAZL1Yk6GAjrTSXON/asSag1cVE8DGt4J9TRjwiLpnQJ4CM9DJCGksDc107MaNLzHQO+qd1D6owYBNpAxcejHh/Ikm/mzccTxajLMeoSumz7ehusjyHOIGImqBsf9yp07ISqozHp2mfV1LKuDwjMslTEjEm6sPZQmM6eU4FTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773395468; c=relaxed/simple;
	bh=40ha3UUc1mTF2YzNrGWxPNtWBskQkGWak6K81Ffdrl8=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=kDApHIXfy8I2hXTQhpTTyAPxr8kEPsqIw7k4ymtlYwPXLKIU0yTa9+mtRtbbfllmfzuQBQQ8w9J8e+BYaPy4BDBX6fjO4/toXVstg88vR4UFvMzfmnKT4fPt5MtD2IJSWSlGmit45aEvFmQBlXM1wYPiWVcOhIQS5WAp4LdCY7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Fo2qyXoE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tWUNNp6YFhZcSa6rDVrWkFfDII00kYuQk+eRtQg9bY8=; b=Fo2qyXoEipmMO4pm2O89ahcrSu
	pRLqW1sOPRVPVD5ExJS7JfaxGb8kZnxw8nRV1NUKCBowMe72heyHbZRrYNUnp6KognhxUiS9LHX5L
	UnKDi8pNT96vOipFTpnvVYJOfOEemgwzNQ0JNCjEXRMfpDXb2Z+pWs99+m9HeJP/pTzXoXX5CJ+Lg
	sydaj+0YZMKOURtZ9wwjhbtgnTx6Fx5rpRtSW41AXXVquet0OqkRN5BwzLH8h722X/JIQjj2B2OLI
	WF/HSRkQiwqh6ZE1fMHveNdyigNitNFbDk+atVmXMKSeevrFmjBtHS8VwuJmbiRuhY7eT15b2iAJO
	WD3rAchw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35546 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w0zAd-000000000cM-26IN;
	Fri, 13 Mar 2026 09:51:03 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w0zAc-0000000D4Ey-36GC;
	Fri, 13 Mar 2026 09:51:02 +0000
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
Subject: [PATCH net-next v3 01/15] net: stmmac: rearrange stmmac_tx_info
 members to pack better
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w0zAc-0000000D4Ey-36GC@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 13 Mar 2026 09:51:02 +0000
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267366-lists,netdev=lfdr.de,kernel];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.982];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rmk-PC.armlinux.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 2B2EC280FBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Rearrange the struct stmmac_tx_info members to pack better, essentially
by sorting by type size:

xsk_meta	embeds only a pointer - 32 or 64 bit
buf		dma address, 32 or 64 bit
len		normally 32 bit
buf_type	dependent on arch
map_as_page	normally 8 bit
last_segment	normally 8 bit
is_jumbo	normally 8 bit

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index bba9bb9c95bf..b096a9e090e3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -47,13 +47,13 @@ enum stmmac_txbuf_type {
 };
 
 struct stmmac_tx_info {
+	struct xsk_tx_metadata_compl xsk_meta;
 	dma_addr_t buf;
-	bool map_as_page;
 	unsigned len;
+	enum stmmac_txbuf_type buf_type;
+	bool map_as_page;
 	bool last_segment;
 	bool is_jumbo;
-	enum stmmac_txbuf_type buf_type;
-	struct xsk_tx_metadata_compl xsk_meta;
 };
 
 #define STMMAC_TBS_AVAIL	BIT(0)
-- 
2.47.3


