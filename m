Return-Path: <netdev+bounces-272112-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cF1pMhVPxWlH9QQAu9opvQ
	(envelope-from <netdev+bounces-272112-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 16:21:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 694E63377D8
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 16:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3864A302492C
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 15:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B86391845;
	Thu, 26 Mar 2026 15:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="z4WZ0+Pc"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C5431F9B1
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 15:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538382; cv=none; b=DnTmcW/we8O7vPR6AAGHxmZguewOHJN0+vn2u9Aw06YMIQOtv9HmYvMRcTdi9HAyF+1g1aRWDHbte0BJKdeQbBnRspFdfF1XhmFrlJEGfz0o3e96xhF9jmHVIKMD2Og5t3Nesn10w/vRF4It+jf2JXbIElrm2Cynf3sis3gYbd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538382; c=relaxed/simple;
	bh=riShO0B+XJvgymHRo4pobwzGA26gP3YuwHdHwRXiKEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uO0co0n2dPqhXB7URDgBZXXNAM+vKNN2Y2gO83+GUHKT/WnyMXZhw9GkMhBg8muiHsGRkshpZSgkEq5xn+AuNhNZOZ1iU2X7X++/esJLjf/So56YDu8j8GUri0qzQFgbfFdRBxQyGj/67t3pEN2tK1frverGNM6olpUF/BOIFnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=z4WZ0+Pc; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HTBHsV6WBbwTbUCCq7Wss7dUMGmY3e7LYLqUZajKUxA=; b=z4WZ0+PcJ2izrmpkC0B1uY5Snm
	V+kfxwXZDcErRzjzOr8Bstd42BvRhj7jHgIjXK/7ln9ikf6c8HDcUbVqhhmYxbZYReGm+9y3IXoUQ
	eoj4JUzsHfBBoch/ow39E+r2MWW3fRbZAjGz0Lmq/Mt6ozG5RqHxiY8IPXKZFbWyHk14+k85JU04Z
	POrtv0oy/GPS08VCyCDtAMbJ9t8lfz8HEHbW03KqAnboyQqWEWAi22PhQGaYbsll8lEsgwv/Owjlt
	MLR1HOj78d8fTF9lfUgqudPABNHNkcu5e4U7iWdra1R96FKcXKQrfIxOkNyS4284lrYoFyC0CuNhv
	PWtOTlOQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37094)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w5mUk-000000004wo-1piI;
	Thu, 26 Mar 2026 15:19:38 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w5mUi-00000000783-3yNo;
	Thu, 26 Mar 2026 15:19:36 +0000
Date: Thu, 26 Mar 2026 15:19:36 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net] net: sfp: Fix Ubiquiti U-Fiber Instant SFP module on
 mvneta
Message-ID: <acVOiGTN2uPTJXRV@shell.armlinux.org.uk>
References: <20260326122038.2489589-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260326122038.2489589-1-kabel@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,kernel.org,google.com,davemloft.net,gmail.com,lunn.ch,bootlin.com];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272112-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.990];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,shell.armlinux.org.uk:mid,armlinux.org.uk:email,armlinux.org.uk:url]
X-Rspamd-Queue-Id: 694E63377D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 01:20:38PM +0100, Marek Behún wrote:
> In commit 8110633db49d7de2 ("net: sfp-bus: allow SFP quirks to override
> Autoneg and pause bits") we moved the setting of Autoneg and pause bits
> before the call to SFP quirk when parsing SFP module support.
> 
> Since the quirk for Ubiquiti U-Fiber Instant SFP module zeroes the
> support bits and sets 1000baseX_Full only, the above mentioned commit
> changed the overall computed support from
>   1000baseX_Full, Autoneg, Pause, Asym_Pause
> to just
>   1000baseX_Full.
> 
> This broke the SFP module for mvneta, which requires Autoneg for
> 1000baseX since commit c762b7fac1b249a9 ("net: mvneta: deny disabling
> autoneg for 802.3z modes").
> 
> Fix this by setting back the Autoneg, Pause and Asym_Pause bits in the
> quirk.
> 
> Fixes: 8110633db49d7de2 ("net: sfp-bus: allow SFP quirks to override Autoneg and pause bits")
> Signed-off-by: Marek Behún <kabel@kernel.org>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

