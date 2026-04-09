Return-Path: <netdev+bounces-277115-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +sjUFwwE2Gk1WQgAu9opvQ
	(envelope-from <netdev+bounces-277115-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 21:54:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D013CF1ED
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 21:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93002300AC20
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 19:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D7633A9DB;
	Thu,  9 Apr 2026 19:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rENiqqgG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6FC336EC6;
	Thu,  9 Apr 2026 19:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775764489; cv=none; b=gS2sOA48lj8VviTtbF2E6l5tfw4Hr/CwdvmufWp5PKQA4r9YoQpPiYQ0IDd6mS6lftU8oJW1v/qdNRJmuoKABoMnZH+tb1HdvbCl7NgvTKviBZXB72wgKw9Hhs8WF2yzNWxB0DCUlSHqnLNfy3nCJrYtwkvczIZ0zXAOMJJLZWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775764489; c=relaxed/simple;
	bh=YHbjw5Pi02GNmKksf99jT1mik4D/XDXbRuffw83653A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjdOLpCR909cvLvHfwobPoEe7UOGbKWUIzSOaxn8D/QhTuS/+UwDzbP2/BVH7QvMjczDTUsbC+qq2ihntSlGOQr06+xZwvfNWFfU6MXYgZRpRgRysomHLg+FscLEXwp19gILQDNx6hQ+RCrNfGUuFWbkRe9DmsXV+/9QJ7TX8Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rENiqqgG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4m3qEQXbBSLI1c3Dofa2Pc9DqVCUH9sM2mc1pfaBTy0=; b=rENiqqgGOleRFOrUlzIVL0zkYF
	8WCpohMYTag4aFjJx19sfHY6HHrh6RwSDTUWGU8h/p529Hk1Y81AwSolAAUif3+N8hR5ezT09j6px
	gU8giOGqIxuZVyWzz2VfGii31bhGDT3BN7ohZji2v/x2xHRE+tlA1svqSb5p6yadVReA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wAvST-00FTpF-Tu; Thu, 09 Apr 2026 21:54:33 +0200
Date: Thu, 9 Apr 2026 21:54:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Carlo Szelinsky <github@szelinsky.de>, o.rempel@pengutronix.de,
	andrew+netdev@lunn.ch, hkallweit1@gmail.com, kuba@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: mdio: treat PSE EPROBE_DEFER as
 non-fatal during PHY registration
Message-ID: <280018e9-4499-4a13-b692-6d6a4499477b@lunn.ch>
References: <8e12f0ac-be0d-4664-a533-df3bd1efb34a@lunn.ch>
 <20260408210711.439068-1-github@szelinsky.de>
 <841e0a96-5e5c-4225-a426-24726163699f@lunn.ch>
 <20260409150922.74d82c39@kmaincent-XPS-13-7390>
 <908a84be-d403-4f59-8d8e-aa9de35bccbb@lunn.ch>
 <adfPAQDiYX6eIjrT@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adfPAQDiYX6eIjrT@shell.armlinux.org.uk>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277115-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[bootlin.com,szelinsky.de,pengutronix.de,lunn.ch,gmail.com,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: C2D013CF1ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 05:08:33PM +0100, Russell King (Oracle) wrote:
> On Thu, Apr 09, 2026 at 05:34:56PM +0200, Andrew Lunn wrote:
> > I still think we should be deferring probe until we have all the parts
> > available. The question is, how do we actually do that?
> 
> Indeed...
> 
> > We could insist that MACs being used with PSE need to call
> > phylink_connect() in probe, so we can return EPROBE_DEFER. We might
> > actually need a new API method, phylink_connect_probe(). That can call
> > down into phylib, maybe again new API methods, which will not bind
> > genphy, but return EPROBE_DEFER.

I did not say i would be easy...
 
> How would MACs know whether they should call phylink_connect_probe()
> or phylink_connect_phy() ?

It would not. Anybody with a board using PSE would need to modify the
MAC driver to use phylink_connect_probe(), if they have a slow to load
PSE device.

> What do we do about MAC drivers that are a single driver and device,
> but are made up of several network devices (like Marvell PP2) ?

It would need more care, but it should work. You might end up removing
a perfectly good device because the other one is missing its PHY,
which is not ideal, but hopefully you get there in the end.

> We also have network drivers that provide a MDIO bus for a different
> network device, which makes connecting the PHY harder in the probe
> path.

Yes, we would see such setup doing more deferred probing, but again,
they should get there in the end. The most common systems doing this
are using the FEC. Are there any board using the FEC and problematic
PSE?

> Lastly, what do we do where a PHY driver hasn't been configured or
> doesn't exist for the PHY?

I was wondering if we can get from the driver core some idea where we
are in the deferred probing window. If we are 2/3 of the way through
the window, fall back to genphy?

I'm not saying we should change all MAC drivers, or recommend new MAC
drivers connect to the PHY in probe. I just want to offer the option
if you have a problematic PSE or PHY, change the MAC driver.

What we have also said in the past, it is the bootloaders problem to
download firmware into the PHY, or PSE, so that it is ready to go by
the time Linux boots. That would also be the simpler solution here.

    Andrew

