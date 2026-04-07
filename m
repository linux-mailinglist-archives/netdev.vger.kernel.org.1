Return-Path: <netdev+bounces-276207-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id evnAHEGY1WmG7wcAu9opvQ
	(envelope-from <netdev+bounces-276207-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 01:50:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2AA3B588F
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 01:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41A73301C593
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 23:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75025387571;
	Tue,  7 Apr 2026 23:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fOv6y9mS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84E5204C3B;
	Tue,  7 Apr 2026 23:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775605821; cv=none; b=r/aWKY9LdbsGXdD88TRixsqlfDWX45ECVQK7M7xJYSOk4cj2iD87euIWDK3ekyyknHMAfYgo2IbGyMkqyVnqetlHwwxVQehUgAYCVBeyCj+vfs1RiVvBIYqd0MU7PnTiVdDcOIJ+wsKSBMMCpd7noIwnE8jtiqNljPaRgof3ECU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775605821; c=relaxed/simple;
	bh=K1MykJGxyoozEfpTGFvy8YteHs+ohHvOXQKlnjsajfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clMgQaqusfx8uWu4ZZUDXESR49YJ/ewZt48teslB5epHY2eFLNxilPU9DFlfeodMaudm8S0rUHsfcnMz/MTJ+kIK5Oft3hioBBEQEX36sincZIPpkxdjz7PmkKzdTRhy4w8IiD4luscdCGT80Cdc/21x6LX9+8tLy+z0DUlK88M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fOv6y9mS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hovgcGXLfFI/btFmOlFejeib3LAZJSEsRKCwgtrsjjo=; b=fOv6y9mSth5Fu/cju68E+ZOYIF
	CmaJW3D8ESoRQ6dQ09YZLrspirmgZb0lV8BkC+DNVPVoLESLfqUeEC0+Qt5n4mQXAw/OajP0x6Yyd
	BPr1LxtRZXMtrYANgcIW+qifk5q+twvgRBKxsoJJP+aLN84YSlGC6UaoPhZKLA56KubI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wAGBI-00FCXH-MD; Wed, 08 Apr 2026 01:50:04 +0200
Date: Wed, 8 Apr 2026 01:50:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1] r8169: implement get_module functions for
 rtl8127atf
Message-ID: <e5e39712-0fd7-456b-b68a-60c530b674ea@lunn.ch>
References: <20260404201333.2849-1-fabio.baltieri@gmail.com>
 <4f8310c2-07be-452a-84fa-0ec87d985651@gmail.com>
 <368d3f30-b4af-4548-a4b9-f8e4e4f9a4cb@lunn.ch>
 <adWIy9d9VgDha_ub@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adWIy9d9VgDha_ub@google.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276207-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: BF2AA3B588F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > Yes, that would be best. Call i2c_add_adapter() to add it to the I2C
> > core. The SFP code in drivers/net/phy can then make use of it.
> 
> Hey Andrew, thanks for the pointers, I was able to instantiate the dw
> i2c controller, same as txgbe/txgbe_phy.c really.

Cool.

> For some reasons I had to revert 560072246088, was getting a "spurious
> STOP detected" but I'll follow up on that separately.

I2C transfers need to be multiples of 2 bytes, in order for the HWMON
to work correctly. You need to read the 16 bits in a single
operation. If they get chopped up into multiple transfers they become
unreliable. So it would be good to get to the bottom of this.

> Anyway I was able to make detection and los work, so I have some code
> with gpio, i2c and the sfp module detect and showing up in hwmon, and
> sitting in waitdev state.

Nice.

> > 
> > And you will need a PCS driver.
> > 
> > But first step is probably to work with the existing Base-T devices
> > and convert the driver to phylink.
> 
> Ok I was going to ask how to connect the one above with the ethtool
> handlers, so you are saying that first the whole driver needs to be
> converted to use phylink/pcs and then that should work automatically-ish
> right?

Yes, once phylink is coordinating all the parts, accessing the module
via ethtool should just start working.

> Can I send the current code I have as an RFC in the meantime to get some
> early feedback?

Sure. 

> It's a pretty substantial amount of boilerplate code so I suspect Heiner
> may want to refactor things about it, feels like it could live in its
> own file.

How much is identical to the txgbe? I wounder if it makes sense to add
some helpers which can be shared by both drivers?

     Andrew

