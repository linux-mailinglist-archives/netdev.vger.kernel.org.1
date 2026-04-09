Return-Path: <netdev+bounces-277060-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PAODeDQ12mrTAgAu9opvQ
	(envelope-from <netdev+bounces-277060-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 18:16:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D77383CD870
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 18:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2253304C0C4
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 16:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEE43C3C12;
	Thu,  9 Apr 2026 16:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IU+WP6P5"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045DB3BED1B;
	Thu,  9 Apr 2026 16:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775750933; cv=none; b=Xh9+GAOH192AHbCeEFmcZyvg/who6vWTlWJePvWy9HFK/q8f+NE0uj95EmBpYzLZ9T9460eTvTolDOEzKqek/8FZkMeqGYUbUBZUqfQtdrJpTm6YDPuiyXmAVonVmkkfkhyDY1L7xGCBvpB9Pv9I8RLsysO36MustZJZvmQnNKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775750933; c=relaxed/simple;
	bh=WA6er+L7tcKu1ERt+VsfyBeUxbqgQH966wC6HI41ICs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijiCRKLB5ff3jF0n16LRqvgOb7TG4PWOUZXr4+YsLMI3OZxleBIxAklH7wDkqxugwQQjysfHteE8EoPiojbQq3G+8TVVienVLo5CsIFt9sKb3mSoIDnCoWTWa1UA2WC3AfQiuqmDTlPY+7Qw3/Nlfy02zz9o+SLb2fPcovyvwuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=IU+WP6P5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=C2w4HJcFkA7Cjp8k/+Uquu+XivyVEouhPg9KdrXMdlg=; b=IU+WP6P5fgDwsFVSgqTUz3+3Il
	OWCLIebrGt6/8+Gax3+TsPs+VDEuDyrVV+bHnNvQ7XQU8Hwm8c0MQ5NkXLridka9rOd3zxySbyOLW
	eHnADi7eFssO6jQANO37fs1XJPraZnTwqqpWqjEpHaPDUb6nY8f2g1J3LMBtOcBu0WaNqmWLfV9j2
	lI7I7cuZbEIosACGv0nKtsMZ387jZvJ+Xxi+iYkSp1SB7cpVQyODLFq6+03g60lxQjaSwK7JyQ+my
	e2ftxudIzhteGxvG+lV6s15RZda8ysYMFrYee3KZAA7lkPYy/QvROeexed0JRw1rvNeHPsw54EQKk
	V4QNFnEg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50808)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wArvp-000000003qn-0m12;
	Thu, 09 Apr 2026 17:08:37 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wArvl-000000004Wg-3x7V;
	Thu, 09 Apr 2026 17:08:33 +0100
Date: Thu, 9 Apr 2026 17:08:33 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Carlo Szelinsky <github@szelinsky.de>, o.rempel@pengutronix.de,
	andrew+netdev@lunn.ch, hkallweit1@gmail.com, kuba@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: mdio: treat PSE EPROBE_DEFER as
 non-fatal during PHY registration
Message-ID: <adfPAQDiYX6eIjrT@shell.armlinux.org.uk>
References: <8e12f0ac-be0d-4664-a533-df3bd1efb34a@lunn.ch>
 <20260408210711.439068-1-github@szelinsky.de>
 <841e0a96-5e5c-4225-a426-24726163699f@lunn.ch>
 <20260409150922.74d82c39@kmaincent-XPS-13-7390>
 <908a84be-d403-4f59-8d8e-aa9de35bccbb@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <908a84be-d403-4f59-8d8e-aa9de35bccbb@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277060-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[bootlin.com,szelinsky.de,pengutronix.de,lunn.ch,gmail.com,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.977];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,armlinux.org.uk:url]
X-Rspamd-Queue-Id: D77383CD870
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 05:34:56PM +0200, Andrew Lunn wrote:
> I still think we should be deferring probe until we have all the parts
> available. The question is, how do we actually do that?

Indeed...

> We could insist that MACs being used with PSE need to call
> phylink_connect() in probe, so we can return EPROBE_DEFER. We might
> actually need a new API method, phylink_connect_probe(). That can call
> down into phylib, maybe again new API methods, which will not bind
> genphy, but return EPROBE_DEFER.

How would MACs know whether they should call phylink_connect_probe()
or phylink_connect_phy() ?

What do we do about MAC drivers that are a single driver and device,
but are made up of several network devices (like Marvell PP2) ?

We also have network drivers that provide a MDIO bus for a different
network device, which makes connecting the PHY harder in the probe
path.

Lastly, what do we do where a PHY driver hasn't been configured or
doesn't exist for the PHY?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

