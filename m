Return-Path: <netdev+bounces-278549-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFS6A7983mm/EwAAu9opvQ
	(envelope-from <netdev+bounces-278549-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 19:43:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C78B3FD347
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 19:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D9DA7302742C
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B043F0777;
	Tue, 14 Apr 2026 17:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ypQma+/V"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972583F0761;
	Tue, 14 Apr 2026 17:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776188568; cv=none; b=L5rhEBRflRCufn0gt3LRpQKfCnYCynGSnFV9Msylrea3XwhKkNI+eiBsbyVOaKUjFKW8juSCYZxmw2lwZvWJbb66g78zdSszRi63EO96Wlok0Rx4zeMWpBl0xdGYKYE8o7eqWpGOB9AQlse0p9eVX3vBeKxbaOD9l/WxcaDMb6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776188568; c=relaxed/simple;
	bh=5W7FvYPoolVxHBjNG1Q5nwS/9/wrVz0X+7d/L2tF8JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTazkh8Cz7c77vPSVprQN0weFsHdehWxgU2XStbS/a6puxaKxWb0kushvNHJ+bAe1D8+BcZMIdCdz5YO9H73pg0L1t9JZRzlV/NjZMGg1Z1BfzUi/gC9MEl1lw8lE9sztKlVZ3VbmyZLTD1qryAje/wO+9BxbzbILDxazhUujo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ypQma+/V; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CJKWkxB0gYZ24Tdv1A3cXZH75CGO07izxPTmES74YL8=; b=ypQma+/VP27jY1qgvvLD9vOKGm
	hOO5xc3UjHVXi4saKQ6cLfS1FhVOAVXcbQ7bmz/mhL9WXifCml/HKW5Ta3LywfRIBzwieJJnYyw8p
	df98RCq3eCEzWrLdq89bz8G0s+J2ORNrY/Qi6ikPA9t7vdHftRRRdXS92+68bOwXq8ODtfBalW1aI
	XKoFgdvW9/qETHBIFtjfrDaL3T6rNnPkLId6ri/Mb+5PHo7scZVRH3Ls5tQBV7kYD8b+X73cOpvrM
	xVgjBqq5WtsrXYoM/qwXjfAIA/+a5njJ+/Bkyoa2E+yhsT8iw1aVxN1oozN/Zp4709ti0ZyrZ/o+X
	rfYwhc8w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35602)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wChmZ-000000001GK-43td;
	Tue, 14 Apr 2026 18:42:40 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wChmT-000000001Ol-3B2t;
	Tue, 14 Apr 2026 18:42:33 +0100
Date: Tue, 14 Apr 2026 18:42:33 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Chen Jung Ku <ku.loong@gapp.nthu.edu.tw>, davem@davemloft.net,
	kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
	hkallweit1@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: mdio: octeon: use %p for bus id
Message-ID: <ad58iba02vSmM6rW@shell.armlinux.org.uk>
References: <20260414155652.7468-1-ku.loong@gapp.nthu.edu.tw>
 <efc34ba8-730a-4c01-bc44-ee64569d2d4e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efc34ba8-730a-4c01-bc44-ee64569d2d4e@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gapp.nthu.edu.tw,davemloft.net,kernel.org,google.com,redhat.com,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278549-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.764];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,armlinux.org.uk:url,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 2C78B3FD347
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 06:16:08PM +0200, Andrew Lunn wrote:
> On Tue, Apr 14, 2026 at 11:56:52PM +0800, Chen Jung Ku wrote:
> > Replace %px with %p to avoid exposing raw kernel pointer values.
> 
> What exactly are we giving away here?
> 
>                         compatible = "cavium,octeon-3860-mdio";
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>                         reg = <0x11800 0x00001900 0x0 0x40>;
> 
> Isn't bus->register_base this well known value?
> 
> You also need to think about ABI.

There isn't ABI here.

        bus->register_base = devm_platform_ioremap_resource(pdev, 0);

        snprintf(bus->mii_bus->id, MII_BUS_ID_SIZE, "%px", bus->register_base);

bus->register_base is the ioremap'd version of the resource, which is
effectively random, and it can be either a 32 or 64-bit hex number
depending on the pointer size. It's an exceedingly bad choice of MDIO
bus ID.

A better more stable choice would be to use the bus address or
dev_name().

Even so, I don't think there's any ABI here as the existing "ID" will
not be stable.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

