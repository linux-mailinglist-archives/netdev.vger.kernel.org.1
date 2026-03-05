Return-Path: <netdev+bounces-264280-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMvIKIdeqWmL6QAAu9opvQ
	(envelope-from <netdev+bounces-264280-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 11:44:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF2720FE7F
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 11:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44AC330269F0
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 10:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605BA37B3F2;
	Thu,  5 Mar 2026 10:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="iJJGGxyx"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B7621CA13
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 10:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772707346; cv=none; b=s8ncOU0kq8WjMGt8tEcwhsi5a31ulotgJoIQ3U/i+lpvlOBLBFJjfaW2GDBpwwLXecfKcQhW1rc0qHByC3V/7k3kQHkAh4UN4oF+6hpm3i/XN9NBp3XU/LseXETh+iiHuMJnSPvR5FKmb97tj+GCTV/C6F1k+rQc/vP5NP10zzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772707346; c=relaxed/simple;
	bh=NafOt9h05c/v6L/+nr3qqv46mS9p833gvYdu/d2F46s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G5yvEIjKmICsaNimLTvZ9x147eJocvAKImHy4evCed6Ep93TbYqk01azg6kWUnzg65LaUCiBrrHnu10X/rM++loz5PjuhbyOxLjH+ZA4Ah7PlSL72myJXm9MlgsTvYFSurrtzsTlpDtR7voSTPVnEm27YyixzDzfp2eRfkFmvBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=iJJGGxyx; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pLqOtinWYSGM7LLpbdtcUGl5b2uewU4Gn9qu8F0GxHI=; b=iJJGGxyxGi6rE9avorUz8+G4zD
	XzfLuzfcOFUoZ7V2iTr8P0jqFxMiSvbkCktTXfwmz++G3Z+aV+KZ+zu3U7phwNDEvRGmx64tys+pD
	FtxIJNCx1ysqD4Pic4jxabzp+XHauo5PVr+V/vVxuCYs7XNI8u/KfjC8ffG2Dy+xR6PfQ+Q5jFnZa
	vJk8zEp3FxyxryPIV4ufenc75fFNfotiDG3GYd1fqU1LnMjatdWYZiazbJPTvSpz4QhaZ7X24sozL
	qItEBfP25MlKSfTDs3XHUrU5cB4iIejxFnW8qPweupDITAgcvPXOeCmrj4zVnMq7zdbPCRultQEXb
	nTUNIRFA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49742)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vy69f-000000007mO-3CbM;
	Thu, 05 Mar 2026 10:42:07 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vy69c-000000000OV-0L7q;
	Thu, 05 Mar 2026 10:42:04 +0000
Date: Thu, 5 Mar 2026 10:42:03 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Chen-Yu Tsai <wens@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Samuel Holland <samuel@sholland.org>
Subject: [PATCH net-next v2 0/8] net: stmmac: mdio related cleanups
Message-ID: <aald--qJquWGIvmO@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Queue-Id: 0EF2720FE7F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264280-lists,netdev=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_SPAM(0.00)[0.421];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi,

The first four patches clean up the MDC clock divisor selection code,
turning the three different ways we choose a divisor into tabular form,
rather than doing the selection purely in code.

Convert MDIO to use field_prep() which allows a non-constant mask to be
used when preparing fields.

Then use u32 and the associated typed GENMASK for MDIO register field
definitions.

Finally, an extra couple of patches that use appropriate types in
struct mdio_bus_data.

v2:
- add comments about 300MHz to commit message in patch 1
- fix incorrect usage of stmmac_sun8i_csr_to_mdc in patch 3
- fix BIT_u32()->BIT_U32() in patch 8

 drivers/net/ethernet/stmicro/stmmac/common.h       |  10 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c  |   2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   |  11 +--
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |   9 +-
 .../net/ethernet/stmicro/stmmac/dwmac1000_core.c   |   9 +-
 .../net/ethernet/stmicro/stmmac/dwmac100_core.c    |   9 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |   9 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  18 ++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  | 106 ++++++++++++---------
 include/linux/stmmac.h                             |   6 +-
 10 files changed, 92 insertions(+), 97 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

