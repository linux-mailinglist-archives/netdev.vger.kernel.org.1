Return-Path: <netdev+bounces-274170-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONU/A9pBzWkkbAYAu9opvQ
	(envelope-from <netdev+bounces-274170-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 18:03:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B1C37D9F8
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 18:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C0E0A301A794
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 16:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12F343C054;
	Wed,  1 Apr 2026 16:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fRbmQFeQ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1923D6CA4
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 16:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775059347; cv=none; b=Tv/F4BItt+D3Mcevd8OxrVLHx4vHVo9geSPpoZ2waqRDPzsFfOdpy7MN+uVf4a6e613iAGWZmupQwRUegE2l2Cx9S+Xr6zNBaJA1lSqg+8464b/cfztVkIi+6ryNF7fZM9BxRpgnLlMfuvEic3RPHKlyhwCZ0LpgQXq975HFRXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775059347; c=relaxed/simple;
	bh=nQsy9CmugKTeEDDnlV7xv6TBP6e8voyaERAwTP3s76s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIeWJ7Lq08o2cxU/kAjjjmqLYSRPLtBF4exMadXmzX0Ia5mTHS3i764F6xPVZUyQrOz56KUpwp1vcgBVnj73qJMGKTbe5NrlddAuLRokLmf7eBoavPiRlIowxbky/jbNo7qjvo6z3/Y8ngCuF/qNd6qXIzseFB53iO113aFYO9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=fRbmQFeQ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=p40naoSfNGuwBVmANaXrE1JyuzEqjPS+rTBwoiTOT80=; b=fRbmQFeQBdRsFwmK3kVI7W4UIK
	5ATU8MZ7xi7uYPQgBF7ZDM+mp+VRb1g4DNfD9oRkUlNL3JBsMKiViF9BH21jLOLhbgwTy4Z3Y0Rrc
	gVIl7bZB169dWpSV5Qh826wtgA7/3HQbt8a2cDJx2bZ1xlRC9N6WIDc0EGoBgJg72hhQuNEVrckuk
	JEmN2mh+sD1oZ7NjF9Xf7PSHctyR3kvPbDnr+i6L5L+bzl69ToFGayvP8smqd0xjYD98pgF99a50R
	omOs5BpHlaU38FOGr6LHLJkt8+TNI/FZ8TzAnZlE2kFmNtu64+/fntr/o2iDBMWFmMed8qqJyAZTZ
	iDpZqVDQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53882)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w7y1Q-000000003OQ-1CBq;
	Wed, 01 Apr 2026 17:02:24 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w7y1P-000000004uY-0rAr;
	Wed, 01 Apr 2026 17:02:23 +0100
Date: Wed, 1 Apr 2026 17:02:23 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org
Subject: Re: RFC: phylink: disable PHY autonomous EEE when MAC manages LPI
Message-ID: <ac1Bj-02_ob7UPjh@shell.armlinux.org.uk>
References: <d86c53213a6328b701b8aabbde5d1c83@tipi-net.de>
 <04ff15af-26be-4278-bc2a-889e7802d271@lunn.ch>
 <aczMqBNesQH-tHx0@shell.armlinux.org.uk>
 <ccb68eaaca5512d5d662326d0817bd50@tipi-net.de>
 <48abd3e3-a3ee-4e85-a3d8-20c8ceedfb77@lunn.ch>
 <ac00PIpzXPjxktzC@shell.armlinux.org.uk>
 <ea94e96c-3e76-4c2b-a08c-43ce6decca08@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea94e96c-3e76-4c2b-a08c-43ce6decca08@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [-0.36 / 15.00];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274170-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[armlinux.org.uk:query timed out];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_SPAM(0.00)[0.382];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: D8B1C37D9F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 05:38:23PM +0200, Andrew Lunn wrote:
> On Wed, Apr 01, 2026 at 04:05:32PM +0100, Russell King (Oracle) wrote:
> > On Wed, Apr 01, 2026 at 03:11:24PM +0200, Andrew Lunn wrote:
> > > > Thanks Russell and Andrew. You're both heading in the same direction,
> > > > so to make sure I understand correctly:
> > > > 
> > > > 1. Add a new phylib interface (separate from phy_ethtool_set_eee) to
> > > >    control PHY-autonomous EEE, e.g. phy_set_autonomous_eee(phydev,
> > > >    enable) and phy_get_autonomous_eee(phydev) to query the current
> > > >    state.
> > > 
> > > In the end, we want the MAC driver using phylib to just call the
> > > phylib methods for configuring EEE, and the MAC driver should not care
> > > if EEE is actually implemented in the PHY or the MAC. The adjust_link
> > > callback would simply not enable LPI if the PHY is doing EEE.
> > 
> > This won't work.
> > 
> > If we mask out eee.tx_lpi_enabled when calling into phylib to tell
> > phylib drivers to disable SmartEEE (that's what I'm calling it here
> > because it's easier to type)),
> 
> We need phylib to handle some state information. Are we doing MAC EEE
> or SmartEEE? We can then set phydev->enable_tx_lpi == True to indicate
> if the MAC should be sending LPI indications, if and only if the
> phylib knows we are doing MAC EEE and it should be enabled because the
> user said so.

Right, and that's why I suggested phy_disable_autonomous_eee() to tell
phylib to disable SmartEEE/autonomous EEE support at the PHY independent
of phy_ethtool_set_eee().

I was also suggesting that there's eventually a complementary function
that says basically "please enable SmartEEE" because we may have phy
drivers that disable it today.

In absence of either call, phy drivers need to maintain their current
state.

> However, i think this is down the road. If the MAC driver calls
> phy_support_eee(), we should call the SmartEEE disable method of the
> PHY driver. When we add support for SmartEEE then we need this
> additional state information.

That also works for me.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

