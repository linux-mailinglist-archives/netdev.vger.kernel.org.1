Return-Path: <netdev+bounces-274647-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKKmAoyvzml+pQYAu9opvQ
	(envelope-from <netdev+bounces-274647-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 20:03:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 076E038CDA6
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 20:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7DC193015EDC
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 18:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4910A336897;
	Thu,  2 Apr 2026 18:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DBW4I4ju"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8585B1EA84;
	Thu,  2 Apr 2026 18:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775153029; cv=none; b=GvgMAKXVEfHPN8LjDO9fPlTL6EMYW4oWhowCK/jm7/UXQ/DyBvB4Pu1qTeFrHoBWsZ8cnc0PM2pM+eVaDfjYohCGLI3B8O60JWoHpDv8vRyGJcd+ADJxVLyNMDp6PAR/NtACcX0c+6MG8OxcyT/pnWBWY04iLs7zx9tWBpE5y3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775153029; c=relaxed/simple;
	bh=NZ4vqxVXtBA/A7WROrC6a/iYy6QmWgn7sIznh+F6htU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjPWDLHkzGR6z1bQc0gRnMESzQJz70ZFNGKX3pr3/iy2LZYp8D8X+cyZrlLoRsxrkJaUhRmOO/y7a3VnMSdjJdkmPdUgPS5p/7sikraxEHPJ43Zv2DXpAh2rSOtPpEBj1Z6P8iV+qJQZTTmonBu3qRe8XHfrbKISsb/42XQLNZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DBW4I4ju; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oFgn4SkT3UIhZjso55rs3ARDkSYec0Plxn/lXnNKuDg=; b=DBW4I4juBHF10U/Q0PXFuYrNpk
	yMTbleoXNpWhaahi/LAqsp/vVnl/W6ycwWCElf8hkdG+Iay3q7vt28W8GpXsd7U1X93sqgJ7Bwknw
	XNdJ8ohXTZsEUoN7vfagFyb+Cms37E3bwc2OGOl66QUznYhUXMZiV9UlUdEQ5KN8dI70f/0HoezQl
	Aem3co0PQUBiu90efz2k+sUQMUZRqp5BrLcZ8i82cD/3RxfA3Ldrd+81EAdp37H3Kn/NSUnyKc/7U
	6ODCBKMxAB+qhCqNqlK7LeAW51fAR4o5GsRq0WONe9MPRcyEWm0Kg1GYzsr639B5KdbNU5YWbZrIM
	FuYSOzUQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33114)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w8MOO-000000004nB-3G4q;
	Thu, 02 Apr 2026 19:03:44 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w8MON-000000005y1-0cTa;
	Thu, 02 Apr 2026 19:03:43 +0100
Date: Thu, 2 Apr 2026 19:03:42 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Charles Perry <charles.perry@microchip.com>, netdev@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 3/3] net: phy: add a PHY write barrier when
 disabling interrupts
Message-ID: <ac6vfhsW2ThF8i2_@shell.armlinux.org.uk>
References: <20260402131229.319599-1-charles.perry@microchip.com>
 <20260402131229.319599-4-charles.perry@microchip.com>
 <6bb3aec4-1635-4287-b7ce-f15b693563ea@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bb3aec4-1635-4287-b7ce-f15b693563ea@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274647-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.593];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 076E038CDA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 03:31:52PM +0200, Andrew Lunn wrote:
> > +static int phy_write_barrier(struct phy_device *phydev)
> > +{
> > +	int err;
> > +
> > +	err = phy_read(phydev, MII_PHYSID1);
> > +	if (err < 0)
> > +		return err;
> 
> There are a small number of MDIO busses which don't implement C22,
> only C45. You are likely to get -EIO or maybe ENODEV, -EOPNOTSUPP,
> -EINVAL for such a read. Returning the error than makes
> phy_disable_interrupts() fail, etc.

If it returns -EOPNOTSUPP (meaning, at least, that bus->read is not
implemented), do we want to issue a C45 read instead?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

