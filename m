Return-Path: <netdev+bounces-273925-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKIzOAnJzGn5WgYAu9opvQ
	(envelope-from <netdev+bounces-273925-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:28:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B224375E03
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 121EC303132C
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 07:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B20379971;
	Wed,  1 Apr 2026 07:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="LKFiCl0R"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C2C376BCD
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 07:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775028064; cv=none; b=MTS5eYVoLKqpCvDLZX0ypRP6Ws8LyQK8nUpSR1GkGAr4Q2ysANH1d97WMBRB5yOhhGOZNCqeq9SSiMIdeypW0PRRRNxNH48eDSfAOhEICz8ceeeUJAs7f0LTjafLb5zcBSrFU6r7CAcPkK4oZvzWFPSLDjN1Qnahq/nhMgT4XdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775028064; c=relaxed/simple;
	bh=FkZFVWQ7tfS09KSgH/klLnl0AkMyAP8/VQ+vu7LyRZA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZXWm2n+0tOFaMrysqd4HM7AU8Gn2pun3ebsEIryC4oZMKJoi93ydDplsPdJjpgC5mbUZwqfE+yZZ9E8z0JBo++i01lYxJnFT+PMQ+evZCC2N7HtqBqZevFTt8ghcsNhy4zlujU1FwQfuVXMQnc+K6eeR/sma3iTLKqghgcKzR0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=LKFiCl0R; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dtZ756YY08U7bg9gCLlbHxheqzmQ87Emq5OyGQIx0cI=; b=LKFiCl0RCjhzJ3C+P5IS8FxFBb
	3BHkBjOpVXcISPhGwNG5h60PeNLqYYn9vKChFdm4c6MLX0tdzHkrNlHVb2hvz+orK1b74B1MhxJdU
	7i9Sm1uXrovvajmGSMAa5BvNlXfJk619PVxp5PfPkq4duZtjBKRxF7EWWrwADc6XK4ZykcLSCAhjm
	iMpBsDrjqXuwa+6EZjxqlh849Vm1cXwP8NA7ES/MTyxPsLqZQt1MRqHIJtYORUUYxbxO9gXc++R5j
	tgXlSJ81IL/dzjic9fnGN/f8hFfKZ6BEaoV0if/9PeTQbVfeEss3GupRLcsdfbtpRsX1+wgwFSxIW
	xllbjzZw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48410)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w7psl-000000002fC-40Ef;
	Wed, 01 Apr 2026 08:20:56 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w7psi-000000004be-2FE0;
	Wed, 01 Apr 2026 08:20:52 +0100
Date: Wed, 1 Apr 2026 08:20:52 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Ong Boon Leong <boon.leong.ong@intel.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 00/14] net: stmmac: TSO fixes/cleanups
Message-ID: <aczHVF04LIGq_lYO@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273925-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.335];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:url,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 4B224375E03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a more refined version of the previous patch series fixing
and cleaning up the TSO code.

I'm not sure whether "TSO" or "GSO" should be used to describe this
feature - although it primarily handles TCP, dwmac4 appears to also
be able to handle UDP.

In essence, this series adds a .ndo_features_check() method to handle
whether TSO/GSO can be used for a particular skbuff - checking which
queue the skbuff is destined for and whether that has TBS available
which precludes TSO being enabled on that channel.

I'm also adding a check that the header is smaller than 1024 bytes,
as documented in those sources which have TSO support - this is due
to the hardware buffering the header in "TSO memory" which I guess
is limited to 1KiB. I expect this test never to trigger, but if
the headers ever exceed that size, the hardware will likely fail.
While IPv4 headers are unlikely to be anywhere near this, there is
nothing in the protocol which prevents IPv6 headers up to 64KiB.

As we now have a .ndo_features_check() method, I'm moving the VLAN
insertion for TSO packets into core code by unpublishing the VLAN
insertion features when we use TSO. Another move is for checksumming,
which is required for TSO, but stmmac's requirements for offloading
checksums are more strict - and this seems to be a bug in the TSO
path.

I've changed the hardware initialisation to always enable TSO support
on the channels even if the user requests TSO/GSO to be disabled -
this fixes another issue as pointed out by Jakub in a previous review.

I'm moving the setup of the GSO features, cleaning those up, and
adding a warning if platform glue requests this to be enabled but the
hardware has no support. Hopefully this will never trigger if everyone
got the STMMAC_FLAG_TSO_EN flag correct. Also adding a check for TxPBL
value.

Finally, moving the "TSO supported" message to the new
stmmac_set_gso_features() function so keep all this TSO stuff together.

 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   3 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 214 +++++++++++++++-------
 2 files changed, 150 insertions(+), 67 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

