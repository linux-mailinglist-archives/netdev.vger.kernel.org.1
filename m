Return-Path: <netdev+bounces-280732-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aH9GBNwK6mkzsgIAu9opvQ
	(envelope-from <netdev+bounces-280732-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 14:04:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF40451B87
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 14:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFF7430C66F5
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 11:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E3C3EB7F0;
	Thu, 23 Apr 2026 11:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="c6eubNzT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2F23EB7EC;
	Thu, 23 Apr 2026 11:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776945543; cv=none; b=qxkTeleY4x8nuPn3jDhyOhPuqqMYq9MBDHz8NqQ1wOW7RF+5MIIWkUL6EiX4IhF7XJQ1Iypr1M6iBXg275V0ZQAdGJLD7pCIohPa65DrAZYWfUAg1WXwqvHKdlmWA3LOQSGq6qbg3Dn9dIjt9eFL1pxGIgxzha6TZ+RfXEoSeSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776945543; c=relaxed/simple;
	bh=kZjoZ28Dwh8PvTFin6gxdQaMPKmig/GAV6JS4qdR/Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnWSlsSRNRfCD9JtAkymjeud8DUeMM5Oo1PMnDEjBD8cqDIaPtyT+2j+TVoI5N8IFS3FlNR3fdzmgRrVOz0JXtFPiWu6Tj5SFvoGefT+qUpnMek4Xr5rGMJ6xnyrdbLHFlXnBOpB80NDq30iCIWg2oCx5NRMrrRiVdYlz+PB4gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=c6eubNzT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wVF3HG+yoAlytd5ZGpgTwfmUJhGhX8NaAq1SrDvzV8c=; b=c6eubNzTvTiFEMOhGWmEH9OyLB
	dTobkywIlhEqhXeYbME21/+2vukeySqQkliM2i1T1XZqJaGmN0qh0J541FdQwHEcPg/cLCa/V7cU9
	P4reTsnsITdZJ4AHnqSil7udFIuJC2/Wy0PEG4wqkj6Suoiv0hfxxRF1iBv672wbQoBQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wFshk-00HEnX-5y; Thu, 23 Apr 2026 13:58:48 +0200
Date: Thu, 23 Apr 2026 13:58:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Lucien.Jheng" <lucienzx159@gmail.com>, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bjorn@mork.no, ericwouds@gmail.com,
	frank-w@public-files.de, daniel@makrotopia.org,
	lucien.jheng@airoha.com, albert-al.lee@airoha.com
Subject: Re: [PATCH v3] net: phy: air_en8811h: add AN8811HB MCU
 assert/deassert support
Message-ID: <18d653c9-e8fe-48ed-9524-869f79a63121@lunn.ch>
References: <20260420134506.35164-1-lucienzx159@gmail.com>
 <2f6fd850-e187-4e63-9a32-6b4b72c09905@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f6fd850-e187-4e63-9a32-6b4b72c09905@redhat.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280732-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,vger.kernel.org,mork.no,public-files.de,makrotopia.org,airoha.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: DEF40451B87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > @@ -1175,10 +1281,22 @@ static int an8811hb_probe(struct phy_device *phydev)
> >  		return -ENOMEM;
> >  	phydev->priv = priv;
> >  
> > +	mdiodev = mdio_device_create(phydev->mdio.bus,
> > +				     phydev->mdio.addr + EN8811H_PBUS_ADDR_OFFS);
> 
> Sashiko says:
> 
> Can this create an out-of-bounds array access if the base PHY address is
> high?
> The mdio_map array in struct mii_bus has a fixed size of PHY_MAX_ADDR (32).
> If phydev->mdio.addr is 24 or higher, adding EN8811H_PBUS_ADDR_OFFS (8)
> will result in an address of 32 or more.
> Neither mdio_device_create() nor mdio_device_register() validate that
> the address is within PHY_MAX_ADDR. When mdiobus_register_device()
> executes mdiodev->bus->mdio_map[mdiodev->addr] = mdiodev, could this
> write past the end of the array and corrupt adjacent memory?

This has been discussed once, but Sashiko has a shorter memory than a
goldfish. It is guaranteed by hardware design that + 8 will work.

	  Andrew

