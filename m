Return-Path: <netdev+bounces-253098-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id F3V0HjAedWkaBAEAu9opvQ
	(envelope-from <netdev+bounces-253098-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 20:32:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C17987EB98
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 20:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 698A530086DF
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 19:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826841A9F91;
	Sat, 24 Jan 2026 19:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LJ28Phtq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2960EB665
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 19:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769283116; cv=none; b=TprfNimRgkZJd5C1sRvsZchJ7u5tPxj+cGrREEjWR8sEkLnXq9nqpkq73LQNF5q+LSZVgl+6sq/613GEtXMhInSWiALZAMn3FdtRVuyuKTkAR6xbUTtXGXcZXAxgF/WbdJBQRPmdBZ+sRTEvHTsrdAq/sEowOerbUkBENb2rM50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769283116; c=relaxed/simple;
	bh=ZdpaJouGKHSCS8OXQWA+tSItmzz9WQiOyRvEV5ABBoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9gUjGfdyhEDcPEynZN8A4uC7gUSe9tSBtm+NTFoCwDXNPAu34ezBDcLVdkMF9VaVUn9e2jyU3Xu6MXR0AGhYdp3PtZ9iqqvWOCjSmKG0sGyw3BeRKdFsG0wu9pAGO5+9YqAyv2r/sOG4l8KXt7r5NBVrUuzrW2RbfZuLLix5ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LJ28Phtq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xFfNnoPzShSYUU5muZJ7I+EP9lrrCb+jH1auO+viRTg=; b=LJ28Phtqy24z9NzYllSNzmLAez
	p45gD6dK1hNDrAvTtBnTZCuBcmWKeo0KzlStQ0e0yvHjEgPYOeXNqqHXGKtHO6n01M/QXocXlweMF
	i1pVpKzhP8lVIZbBBcmjoHi5kLRhs759XejrCmjSMnNCOq4pzDJCXZRxx6tKFdgd+VNw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vjjMH-004VSZ-HC; Sat, 24 Jan 2026 20:31:45 +0100
Date: Sat, 24 Jan 2026 20:31:45 +0100
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
Message-ID: <e6f9ee03-91d8-4d3d-bf9b-c08ffa991c01@lunn.ch>
References: <20260116-ftgmac-cleanup-v2-9-81f41f01f2a8@aspeedtech.com>
 <20260120121407.795529-1-horms@kernel.org>
 <8ab0e121-5ffb-4dd8-afc8-11b6ce3898bb@lunn.ch>
 <SEYPR06MB513455F4FBCB9AF4F6E4CB199D97A@SEYPR06MB5134.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB513455F4FBCB9AF4F6E4CB199D97A@SEYPR06MB5134.apcprd06.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253098-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C17987EB98
X-Rspamd-Action: no action

> > > > diff --git a/drivers/net/ethernet/faraday/ftgmac100.c
> > > > b/drivers/net/ethernet/faraday/ftgmac100.c
> > > > index f1cb5dc37919..931fdf3d07d1 100644
> > > > --- a/drivers/net/ethernet/faraday/ftgmac100.c
> > > > +++ b/drivers/net/ethernet/faraday/ftgmac100.c
> > > > @@ -1957,6 +1957,14 @@ static int ftgmac100_probe(struct
> > platform_device *pdev)
> > > >  		priv->txdes0_edotr_mask = BIT(15);
> > > >  	}
> > > >
> > > > +	if (priv->mac_id == FTGMAC100_FARADAY ||
> > > > +	    priv->mac_id == FTGMAC100_AST2400 ||
> > > > +	    priv->mac_id == FTGMAC100_AST2500) {
> > > > +		err = ftgmac100_setup_mdio(netdev);
> > > > +		if (err)
> > > > +			goto err_phy_connect;
> > > > +	}
> > >
> > > If ftgmac100_setup_mdio() fails after of_mdiobus_register() returns an
> > > error, it calls mdiobus_free(priv->mii_bus) but does not set
> > > priv->mii_bus to NULL. The goto err_phy_connect then leads to
> > > ftgmac100_destroy_mdio() which checks if (!priv->mii_bus) but finds a
> > > dangling pointer, resulting in mdiobus_unregister() on freed memory
> > followed by a double free.

I took another look at this. The goto err_phy_connect is wrong.  At
this point, if there is an error nothing else needs cleaning up, so
the goto should be replaced with a return err;

It is not however the full solution. If ftgmac100_probe_ncsi() fails,
it jumps to err_setup_mdio, which currently just does a return,
leaking the mdiobus. The ftgmac100_destroy_mdio() call needs moving
after the err_setup_mdio: label.

This is one of the problems with this driver. The labels are not
consistent. Some label names indicate what failed, others indicate
what needs cleaning up. The later patches solve this by using devm_ so
removing all these labels.

	 Andrew

