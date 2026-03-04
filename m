Return-Path: <netdev+bounces-263734-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HRtAywJqGn2nQAAu9opvQ
	(envelope-from <netdev+bounces-263734-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:27:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 791531FE558
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73DA23144F26
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 10:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581603A0EAB;
	Wed,  4 Mar 2026 10:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Da3v+Z3B"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF75E37DEA2
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 10:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772619798; cv=none; b=KqEbixPQ2B/ho88Prxdkh/CYsRG+eOLX3ODPQR35CxX3MdalOzyym1jAxIVkz6YpKib0eFlMU2nP9XydvLVV6y1mGfh8/5mPf3PXB+QbpKrawQlUZLrLbzwXMCw3ZNbMAjuDdnh4uXSPh4Ut6hpRFsRFbcqFgmfNePS84rmqbw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772619798; c=relaxed/simple;
	bh=bdmhJXYgp6hiwq2GvdcrhMN8527Ns07T1i4rMd9dmYI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=CjZg46bl+aUJP6Ztxl8mZKDE50YeGJuPeioSY320AiFnYo+1ugHdhuk6A2bZHtpROchJ6diQKLMp2+zG9o3UER/J0lASgTdG8GhEwjy/uFcHj3KmSaT63nLlro561in/L0iVzBqpbUqqjyreXw6oNTlX1HlMH923wDy4ZMyQGZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Da3v+Z3B; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JXAuD3nUVcKQxQuqoS4zKPyRKQFd55XZkokpVdQy2cE=; b=Da3v+Z3BmPyBn5Iv7+wde9Bv3/
	gSlPdBaktNiDva8cRyRxAnPc7nVVaUT8F6r3HRe9O1asNjcaVA5ZRcAmbXXbdXQvt4EEab07bwQAj
	hghI+IhiiFsuVCJGw0gPNzhvRUvWbBWvTPHdYj7Cl2icO3KTUSvLhbtg2Scbnp/IR/xkPiacOhWNC
	poYzl4m1iNGX5hdt/c/eCyQ7J4jfQIIYoEwXiU1iq9yPjL6VkDmu+uzw/X3rX0lTdNImB3zo1Vy25
	+Xj4TYvc+piZsNqktq1rjGzMjKq5ySISNMPuLoMp40TnsfiT3RcCqRESKt0SBXDWKfkRGfgfoNc+q
	WNvqZ9Ig==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:60830 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vxjNg-000000006Ml-0Mhs;
	Wed, 04 Mar 2026 10:23:04 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vxjNe-0000000Br1W-1nOG;
	Wed, 04 Mar 2026 10:23:02 +0000
In-Reply-To: <aagH023pvswd0tlT@shell.armlinux.org.uk>
References: <aagH023pvswd0tlT@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chen-Yu Tsai <wens@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Samuel Holland <samuel@sholland.org>
Subject: [PATCH net-next 7/8] net: stmmac: mdio_bus_data->default_an_inband is
 boolean
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vxjNe-0000000Br1W-1nOG@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 04 Mar 2026 10:23:02 +0000
X-Rspamd-Queue-Id: 791531FE558
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263734-lists,netdev=lfdr.de,kernel];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_SPAM(0.00)[0.268];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,rmk-PC.armlinux.org.uk:mid]
X-Rspamd-Action: no action

default_an_inband is declared as an unsigned int, but is set to true/
false and is assigned to phylink_config's member of the same name
which is a bool. Declare this also as a bool for consistency.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 include/linux/stmmac.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 2fc169c7117e..678d03d6d3bd 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -86,10 +86,10 @@ struct stmmac_priv;
 struct stmmac_mdio_bus_data {
 	unsigned int phy_mask;
 	unsigned int pcs_mask;
-	unsigned int default_an_inband;
 	int *irqs;
 	int probed_phy_irq;
 	bool needs_reset;
+	bool default_an_inband;
 };
 
 struct stmmac_dma_cfg {
-- 
2.47.3


