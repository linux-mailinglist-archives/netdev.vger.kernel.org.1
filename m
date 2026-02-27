Return-Path: <netdev+bounces-261790-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCONEOlpoWkOswQAu9opvQ
	(envelope-from <netdev+bounces-261790-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:54:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9891F1B59FF
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2BF8302DF64
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 09:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5CA30E0D6;
	Fri, 27 Feb 2026 09:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CAHh7uFX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C040B1F03D7
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 09:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772185974; cv=none; b=sd9433zEcNAFmMXsAkNnJORKhn6bYptJ6yhMjmWzN+zL6a+nNf8ZZJ83P++ZiPLSEpv4Yt2Pkw/a9CSYoEFME4l1VKRFtYQXR+OQrBsyhtc5gO5ee/KQqYZW510FgTQfGCGNYIPh9qP9mScfTHxe8EPCN1pPo/iWqe9xTXxPCGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772185974; c=relaxed/simple;
	bh=XbRxWurh5EMBA87jC9VS4heaQA7/q518hefT/KgL9AM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UCybB16vQzrZzxz2uKYSRJ99i6HWuEYTxFwYiORBN/ShEMcnPvL5NyRvQ5JkkLg2WM9beEeR1L1wOAqQfe0pErtq9DrOoF7zVeNjnVmihVfDwibGWZSe4dW1vBnFjX2JJnzLsGeZeSwhipFH2Ml7QJnwqMNXCIp9cEtgIyXzWfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=CAHh7uFX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=G4AOdtDSBTVKcUGqRwL58Pt4pHFgHiIpoKmDb5710ZY=; b=CAHh7uFXnhy7PVKqbwANdh3hnP
	HJFpuvTH9l+NloCx5hJ7jBicJQnI9RpafLAVn0lxbbX/7DkSPzi0+AxOBd6Og0EFekz+tuuvOKidC
	GCU5+FG17cCUzKT1OBx+Tc/2XzSwV4Rz/2IMQC61U65nRev47kaNE4/YdlUq4DPtJDVoGHNT+t5nZ
	CLp+A2awkOrFqDx8CBnkSaeWfHphTx1rlYemr6dqG1di185JbE/SedWEyiJsdwds185H+DCBNdW7m
	zfQ/C+wt+b4CjXBA3xDMiLPK9cpSNXwY5o7/++0/9DbTZdrh3qe7Xwzz9PhFizozbraP20EdQXEvH
	qcgWPQgQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45912)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vvuWY-000000000bc-3D2O;
	Fri, 27 Feb 2026 09:52:42 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vvuWV-000000002z1-0ab9;
	Fri, 27 Feb 2026 09:52:39 +0000
Date: Fri, 27 Feb 2026 09:52:38 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 00/14] net: stmmac: further cleanups
Message-ID: <aaFpZvuIzOLaNM0m@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261790-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.917];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:url,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 9891F1B59FF
X-Rspamd-Action: no action

Hi,

Yet another bunch of patches cleaning up the stmmac driver.

We start off by cleaning up the formatting for stmmac_mac_finish(). Then
remove a plat_dat->port_node which is redundant, followed by several
descriptor methods that aren't called.

We then remove useless dwmac4 interrupt definitions, and realise that
v4.10 definitions are the same as v4.0, so get rid of those as well.
We also remove the write-only priv->hw->xlgmac member.

Next, we change priv->extend_desc and priv->chain_mode to be a boolean
and document what each of these are doing. Also do the same for
dma_cfg->fixed_burst and dma_cfg->mixed_burst.

Then, move the initialisation of dma_cfg->atds into stmmac_hw_init()
as this is where we have all the dependencies for this known, and
simplify its initialisation. Also comment what this is doing.

Finally, move the check that priv->plat->dma_cfg is present and the
programmable burst limit is set into the driver probe rather than
checking it each time we are just about to reset the dwmac core.
It is unnecessary to keep checking this. This makes a platform glue
driver fail early when it hasn't setup everything that's required
rather than when attempting to bring the netdev up for the first time.

 drivers/net/ethernet/stmicro/stmmac/common.h       |  1 -
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c  |  4 +--
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c | 19 -----------
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c   |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h   |  8 -----
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c   | 36 +++-----------------
 .../net/ethernet/stmicro/stmmac/dwxgmac2_descs.c   | 18 ----------
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c     | 18 ----------
 drivers/net/ethernet/stmicro/stmmac/hwif.c         |  9 +----
 drivers/net/ethernet/stmicro/stmmac/hwif.h         | 11 ------
 drivers/net/ethernet/stmicro/stmmac/norm_desc.c    | 18 ----------
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |  9 +++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 39 +++++++++++-----------
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  |  7 ++--
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |  3 --
 include/linux/stmmac.h                             |  5 ++-
 16 files changed, 37 insertions(+), 170 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

