Return-Path: <netdev+bounces-274525-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FYKGUBjzmmXnQYAu9opvQ
	(envelope-from <netdev+bounces-274525-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 14:38:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D227738925F
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 14:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3C5230FD7AD
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 12:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916C23C3C1E;
	Thu,  2 Apr 2026 12:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="oHQM6NjX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E470F3E4C77
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 12:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775133171; cv=none; b=Ec+pVEMPYdfXL0PWfAilTXtzMxXqToSPOZ2vek037Kf9WtJUA61fHZI4xXvOEncuOvWVdIyc+I7WhXekuLahCUjh1WbsL5EKR0s7zh3ikb+dQtT6etm2WZmSH5nkuhYGTL04wlr8OOMwSCm0cycfAaagZwFi2nLxSAMO3IHN304=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775133171; c=relaxed/simple;
	bh=7CKTq5EgBVwKt6ohFa9sWoco9cIARxL1kh9bJgeCvgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YoWAA0AZ+wWdiYCdnIAo+5IgZV+9hmdUvEXwqz7+vab7h4CRwID6mM9jde5xldrEFcxXgAxS/no86X5lFYdDjb2BXUolLns1l6iyq/l+7QqbA8NUqpJhaSOACBaWAdK3cQmpdeW0+Md5F9O5DQirMFmzDv3GKxjFxUOkbx0Ykqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=oHQM6NjX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4UqxmdJEVCQoNalCHjg1ctOf5d0BGHJ6LokwKBQqqy0=; b=oHQM6NjXWBZcVfrp7gYNXs/6ON
	lwBGkMIXxxRkc+Rs04WoX/hQt23IBlmdtB3ayyKzibmJ1+39LC/RKctwdiGojdzb/VPMf+lPoU8Us
	XBj0eP8O4DHexZeM+ywFpUwgNtTlHBg9HtdQCffP5dKOcYiTW1/TBNr0MzRqek5oWvUPyuMzM8rvv
	wBK7L+wPdBbZcCA94PtxkBKRxWydvDF9911ObKHIuQppL6uLAdRWsD2/gXwWdLzJTQnpli+/OpEmz
	MvZKVEAXWxShPzAX6jrZZynEKDqVYlgdU54D+HUetiNkf4/yIJ16cmx7+AVdMneFbC1xSMMKI2HgY
	IwJIcV/Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41176)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w8HDu-000000004R9-1Th7;
	Thu, 02 Apr 2026 13:32:34 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w8HDs-000000005kY-43w0;
	Thu, 02 Apr 2026 13:32:32 +0100
Date: Thu, 2 Apr 2026 13:32:32 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Subject: Re: RFC: phylink: disable PHY autonomous EEE when MAC manages LPI
Message-ID: <ac5h4C99Lh2ez7GN@shell.armlinux.org.uk>
References: <d86c53213a6328b701b8aabbde5d1c83@tipi-net.de>
 <04ff15af-26be-4278-bc2a-889e7802d271@lunn.ch>
 <aczMqBNesQH-tHx0@shell.armlinux.org.uk>
 <ccb68eaaca5512d5d662326d0817bd50@tipi-net.de>
 <48abd3e3-a3ee-4e85-a3d8-20c8ceedfb77@lunn.ch>
 <ac00PIpzXPjxktzC@shell.armlinux.org.uk>
 <ea94e96c-3e76-4c2b-a08c-43ce6decca08@lunn.ch>
 <ac1Bj-02_ob7UPjh@shell.armlinux.org.uk>
 <4950b35ad3df1e8a09d063907dad32a3@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4950b35ad3df1e8a09d063907dad32a3@tipi-net.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	TAGGED_FROM(0.00)[bounces-274525-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_SPAM(0.00)[0.496];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,armlinux.org.uk:url,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: D227738925F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 09:53:37AM +0200, Nicolai Buchwitz wrote:
> On 1.4.2026 18:02, Russell King (Oracle) wrote:
> > On Wed, Apr 01, 2026 at 05:38:23PM +0200, Andrew Lunn wrote:
> > > On Wed, Apr 01, 2026 at 04:05:32PM +0100, Russell King (Oracle) wrote:
> > > > On Wed, Apr 01, 2026 at 03:11:24PM +0200, Andrew Lunn wrote:
> > > > > > Thanks Russell and Andrew. You're both heading in the same direction,
> > > > > > so to make sure I understand correctly:
> > > > > >
> > > > > > 1. Add a new phylib interface (separate from phy_ethtool_set_eee) to
> > > > > >    control PHY-autonomous EEE, e.g. phy_set_autonomous_eee(phydev,
> > > > > >    enable) and phy_get_autonomous_eee(phydev) to query the current
> > > > > >    state.
> > > > >
> > > > > In the end, we want the MAC driver using phylib to just call the
> > > > > phylib methods for configuring EEE, and the MAC driver should not care
> > > > > if EEE is actually implemented in the PHY or the MAC. The adjust_link
> > > > > callback would simply not enable LPI if the PHY is doing EEE.
> > > >
> > > > This won't work.
> > > >
> > > > If we mask out eee.tx_lpi_enabled when calling into phylib to tell
> > > > phylib drivers to disable SmartEEE (that's what I'm calling it here
> > > > because it's easier to type)),
> > > 
> > > We need phylib to handle some state information. Are we doing MAC EEE
> > > or SmartEEE? We can then set phydev->enable_tx_lpi == True to indicate
> > > if the MAC should be sending LPI indications, if and only if the
> > > phylib knows we are doing MAC EEE and it should be enabled because the
> > > user said so.
> > 
> > Right, and that's why I suggested phy_disable_autonomous_eee() to tell
> > phylib to disable SmartEEE/autonomous EEE support at the PHY independent
> > of phy_ethtool_set_eee().
> > 
> > I was also suggesting that there's eventually a complementary function
> > that says basically "please enable SmartEEE" because we may have phy
> > drivers that disable it today.
> > 
> > In absence of either call, phy drivers need to maintain their current
> > state.
> > 
> > > However, i think this is down the road. If the MAC driver calls
> > > phy_support_eee(), we should call the SmartEEE disable method of the
> > > PHY driver. When we add support for SmartEEE then we need this
> > > additional state information.
> > 
> > That also works for me.
> 
> Thanks both. So if I understand correctly:
> 
> 1. Add a .disable_autonomous_eee callback to struct phy_driver
> 
> 2. Call it from phy_support_eee() so MAC drivers don't need to know
>    or care whether the PHY does (autonomous|smart)eee
> 
> 3. BCM54xx (AutogrEEEn) and RTL8211F as first users
> 
> 4. No enable counterpart for now. PHY drivers maintain their current
>    default behavior unless phy_support_eee() is called.
> 
> Sounds good. Sorting out the warts of (autonomous|smart)eee will be
> iterative anyway, so starting with just the disable path makes sense
> (and hopefully will make setups a bit less broken than they were with
> both fighting for LPI).
> 
> I'll put the RFC patches together.

Sounds good to me, but I'd wait for Andrew's input.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

