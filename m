Return-Path: <netdev+bounces-267700-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDI0GGMutWkXxQAAu9opvQ
	(envelope-from <netdev+bounces-267700-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 10:46:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B85B328C7E2
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 10:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1C6D3050A26
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 09:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632B7334C11;
	Sat, 14 Mar 2026 09:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Rabh65Nd"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED08A8003D;
	Sat, 14 Mar 2026 09:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773481350; cv=none; b=VDLDORYOaMOZRx5cFrVBW8/ED1M4tWbf6gywbHPU07korh8MJDMmqAm6fKm3wpyFU3uO4OgZW4h4wA4XtLSfkcPlZ7bvo2AIZ9BfvZcsmYKEboiK1ibUpdzM/isa0Ku26CgQuSsfh+HXI1suQT+Hm4H+YKZ+inMySihhkPt96qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773481350; c=relaxed/simple;
	bh=40ha3UUc1mTF2YzNrGWxPNtWBskQkGWak6K81Ffdrl8=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=iFEYdVj5HRX0T7YaScXW2G42c8xHqfNpqA8s9jatLkdJr4qgn5DZd8f7IamjXq41ZCFLBW6dx6RZdnClkPu05oBxvl9lT4/+QxdEIAVhrBtkrB1PKBzfEmMXy06M9tzXyO4DI1aMym+NXRdkBNlXsmxWbKMs6743evt1S+KBoCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Rabh65Nd; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tWUNNp6YFhZcSa6rDVrWkFfDII00kYuQk+eRtQg9bY8=; b=Rabh65NdMHQyYlSvBQ4iqeH5As
	Jjfw4pMOXC+UkoLd9WSQb+/p61P/hKNQxIfj6M9HnHsfYblTB1OLYac3lBAfxo1wzn1fD3nkwHAHK
	is9wCrUfCfNh3Aa9he0p2JlTOj7rnRaO9EB3wiT6+torl3oq0RDLAmHygRmvBZz+Xe8VLMjsoERv7
	DOrEp0c3445FtIe3zf9StfTC52/AJrw76RVUX8ZK3oULSg4yyOg58nM8BY/KzJFbp6pSLAnkaodo4
	Q4JwmwW/j2jD7UkoF9OiZM3cx4nSRozbdBFQl1B8uIFfaAkbLI9sL/IH7qq8a4noROxYSOz5MFU44
	efamlP5g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36466 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w1LVp-000000001zo-32NV;
	Sat, 14 Mar 2026 09:42:25 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w1LVo-0000000DGRl-44lt;
	Sat, 14 Mar 2026 09:42:25 +0000
In-Reply-To: <abUtGH9KB03PH5Ne@shell.armlinux.org.uk>
References: <abUtGH9KB03PH5Ne@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v4 01/15] net: stmmac: rearrange stmmac_tx_info
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
Message-Id: <E1w1LVo-0000000DGRl-44lt@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sat, 14 Mar 2026 09:42:24 +0000
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267700-lists,netdev=lfdr.de,kernel];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rmk-PC.armlinux.org.uk:mid,armlinux.org.uk:email]
X-Rspamd-Queue-Id: B85B328C7E2
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


