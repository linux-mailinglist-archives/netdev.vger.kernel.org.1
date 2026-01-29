Return-Path: <netdev+bounces-254791-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SL6hJa9be2nXEAIAu9opvQ
	(envelope-from <netdev+bounces-254791-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 14:07:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F03CB040E
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 14:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED3953017245
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 13:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499C838885D;
	Thu, 29 Jan 2026 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WLVCiQyl"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D776C3358CE
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 13:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769692028; cv=none; b=QaeoUboCA+T6Wfng4VSWi3dtit9KHFiqpNFK0nQS418OdytfKG8iQGz+rFx3svC+xcmCbYm5cCPOjMDj7s9Djdnx8K+En3p0+VF/4u7ppcCrz1/zqlLu7bRNBjvHlaNKVqOL62utO46MJX1xc9lycFCX4to3JabkqJjSt5eS//U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769692028; c=relaxed/simple;
	bh=+x7KhqKn8si1sGlR5dl0F1rWgNlCFm1tBTdtwIHCHgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtaCxMCeWIxbPdx6uA1YIXANLoOGvuBtFKTKYFfYPQplwXg4nR927nYW9WQb+W86O7A+cxA+1+svQpRSg61uTuP79GArNon8C/yjTPHBBnYnwgGEqdR5e0vzsvExs4fEdaGgIiyT40WTXwGHBXu7y7wNQMN70XBlgHRK7Sr/knE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WLVCiQyl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Bt+DrIKVGVdG1A43i4sBXZjWP9P54pe7YHWMx/MHriQ=; b=WLVCiQylABN1a35w3Jl2W07scB
	XdPyvOj/cuDd0usjVveC5ScO3zhbNMhTXmbYhYgr/fo5cj/IE6CPcAezpsJ2e1YiIu4p2/6Ta3D3i
	mWI+TboL4rWPi+A99o8nlzdOlAAqF0i11b/SLPFc4v+ndkixg1SY12NbJBX0eyYBMboc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vlRjY-005MmR-O9; Thu, 29 Jan 2026 14:06:52 +0100
Date: Thu, 29 Jan 2026 14:06:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Simon Horman <horms@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [net-next,v2,09/15] net: ftgmac100: Always register the MDIO bus
 when it exists
Message-ID: <da4f0506-50c9-45a1-8c28-001b0672ef52@lunn.ch>
References: <20260116-ftgmac-cleanup-v2-9-81f41f01f2a8@aspeedtech.com>
 <20260120121407.795529-1-horms@kernel.org>
 <8ab0e121-5ffb-4dd8-afc8-11b6ce3898bb@lunn.ch>
 <SEYPR06MB513455F4FBCB9AF4F6E4CB199D97A@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <e6f9ee03-91d8-4d3d-bf9b-c08ffa991c01@lunn.ch>
 <SEYPR06MB5134A65B925BAC871927C9C69D9EA@SEYPR06MB5134.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB5134A65B925BAC871927C9C69D9EA@SEYPR06MB5134.apcprd06.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254791-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: 7F03CB040E
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 06:07:20AM +0000, Jacky Chou wrote:
> > > > > > +	if (priv->mac_id == FTGMAC100_FARADAY ||
> > > > > > +	    priv->mac_id == FTGMAC100_AST2400 ||
> > > > > > +	    priv->mac_id == FTGMAC100_AST2500) {
> > > > > > +		err = ftgmac100_setup_mdio(netdev);
> > > > > > +		if (err)
> > > > > > +			goto err_phy_connect;
> > > > > > +	}
> > > > >
> > > > > If ftgmac100_setup_mdio() fails after of_mdiobus_register()
> > > > > returns an error, it calls mdiobus_free(priv->mii_bus) but does
> > > > > not set
> > > > > priv->mii_bus to NULL. The goto err_phy_connect then leads to
> > > > > ftgmac100_destroy_mdio() which checks if (!priv->mii_bus) but
> > > > > finds a dangling pointer, resulting in mdiobus_unregister() on
> > > > > freed memory
> > > > followed by a double free.
> > 
> > I took another look at this. The goto err_phy_connect is wrong.  At this point,
> > if there is an error nothing else needs cleaning up, so the goto should be
> > replaced with a return err;
> > 
> 
> Agreed.
> When ftgmac100_setup_mdio() fails, the MDIO bus is not registered and the
> probe function returns an error immediately.
> 
> > It is not however the full solution. If ftgmac100_probe_ncsi() fails, it jumps to
> > err_setup_mdio, which currently just does a return, leaking the mdiobus. The
> > ftgmac100_destroy_mdio() call needs moving after the err_setup_mdio: label.
> > 
> 
> In NC-SI mode, MDIO is not required.
> Therefore, always registering the MDIO bus is redundant when the interface
> operates in NC-SI mode.

But it physically exists, and in theory, you could make use of it,
hang an Ethernet switch off it, etc. Linux does not care what MDIO bus
a switch, or a PHY uses. It does not need to be the one directly
associated to the MAC. The 2700 has MDIO in its own address space, its
own driver, with its own life cycle, etc.

This series is all about making probe simpler, ready to make it more
complex again to sort out the problems with RGMII delays. Always
registering the bus just helps reduces the complexity.

	Andrew

