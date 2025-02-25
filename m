Return-Path: <netdev+bounces-169574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 660EAA44A3F
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 19:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC68019C5A81
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 18:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6752054E9;
	Tue, 25 Feb 2025 18:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ync+WzAA"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04471FBEAE;
	Tue, 25 Feb 2025 18:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507848; cv=none; b=KZ++s+AENm/9Ui4qR4Ckuuh3TMMhWG7KjWhbVp7m9xbkpQ26dvPN+ls0B/2mDPGNLH9p1zJuNittSFzeb4cx98tUIKTC7x4JmmOsfvhBqQ44uwUWwlIm8zlKFoRqlle8U9ZSf4VahBjYFrzz5nbLS6Uazd6oe6YvRGo9TsR9EEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507848; c=relaxed/simple;
	bh=gkURQyDBFIIXVu+lUbjZG9GDidubVbJnt/AHKi//iwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/qxl7X0vt1GANZyXN28R4tfiyhhh0uA2wANAdSdMqgxTvRfVFPaWL72i+W7jBweKMS3WXIdKwH3JGg+/4e/ZkuonZYjewFmF2dzik0/frnUvLjMTKhkQOWdkuMQwSBCj0DF2/diXz50fMlRVLOE5L8VaqYPv+A3SVjIJdA+mTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ync+WzAA; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HbEd1ycjERioNwQFESLBBImaWldcivxrxVLgLZpicQI=; b=ync+WzAAgbJ+vRdCqf9cvcOqmr
	SZ1EskLrr7w1ZbMgwqat6LgAavMv4wwUOdWW/bWdwI4yyw+lyp0wlmaku8MKYklpDIyxuP9CpGgKN
	dYyXhTlzGupfJZHM9+XgBSNXWyXpJaFj31RGLzwCj2JcP8BqfL7vz6Cwk10JHj1PaxEP9LmThQ90+
	SBi8F7cG/cyvM/v4IOuV4unRaG4w0f+mUtdZslUROkhuT2O6+YstgXPfjmxPFzoMwH4D7qJi654iL
	USgAZdQqcDP4LVUhou7/Ce1UbYxfnyxs52sQl10rM6oeqn8IIGwpnUEbcTHpXI2NxrQqk/lCPZpFC
	rzuMKzog==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41384)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tmzb4-0002Dt-2S;
	Tue, 25 Feb 2025 18:23:58 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tmzb2-0006EN-01;
	Tue, 25 Feb 2025 18:23:56 +0000
Date: Tue, 25 Feb 2025 18:23:55 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Antoine Tenart <atenart@kernel.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Subject: Re: [PATCH net-next v2 1/2] net: phy: sfp: Add support for SMBus
 module access
Message-ID: <Z74Kuzb6kPJOZRQw@shell.armlinux.org.uk>
References: <20250225112043.419189-1-maxime.chevallier@bootlin.com>
 <20250225112043.419189-2-maxime.chevallier@bootlin.com>
 <6ff4a225-07c0-40f6-9509-c4fa79966266@lunn.ch>
 <20250225145617.1ed1833d@fedora.home>
 <caa65ad9-9489-4d22-9e87-dd30e4e16cca@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caa65ad9-9489-4d22-9e87-dd30e4e16cca@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Feb 25, 2025 at 03:58:31PM +0100, Andrew Lunn wrote:
> > You might be correct. As I have been running that code out-of-tree for
> > a while, I was thinking that surely I'd have noticed if this was
> > wrong, however there are only a few cases where we actually write to
> > SFP :
> > 
> >  - sfp_modify_u8(...) => one-byte write
> >  - in sfp_cotsworks_fixup_check(...) there are 2 writes : one 1-byte
> > write and a 3-bytes write.
> > 
> > As I don't have any cotsworks SFP, then it looks like having the writes
> > mis-ordered would have stayed un-noticed on my side as I only
> > stressed the 1 byte write path...
> > 
> > So, good catch :) Let me triple-check and see if I can find any
> > conceivable way of testing that...
> 
> Read might be more important than write. This is particularly
> important for the second page containing the diagnostics, and dumped
> by ethtool -m. It could be the sensor values latch when you read the
> higher byte, so you can read the lower byte without worrying about it
> changing. This is why we don't want HWMON, if you can only do byte
> access. You might be able to test this with the temperature
> sensor. The value is in 1/256 degrees. So if you can get is going from
> 21 255/256C to 22 0/256C and see if you ever read 21 0/256 or 22
> 255/256C.

<frustrated>

Why don't we read SFF-8472 instead of testing module specific behaviour?
Section 9.1 (Diagnostics overview) paragraphs 4 and 5 cover this.

No, it's not latched when you read the high byte. Paragraph 4 states
that multi-byte fields must be read using "a single two-byte read
sequence across the 2-wire interface".

Paragraph 5 states that "the transceiver shall not update a multi-byte
field within the structure during the transfer of that multi-byte field
to the host, such that partially updated data would be transferred to
the host."

In other words, while reading the the individual bytes of a multi-byte
field, the value will remain stable _while the bus transaction which
is required to be a multi-byte read is in progress_.

So, when the STOP condition is signalled on the bus, the transceiver
is then free to change the values. So accessing the high byte and
low byte seperately does not guarantee to be coherent.

It *might* work with some modules. It may not work with others. It
might crash or lock the I2C bus with other modules. (I already know
that at least one GPON module locks the bus with byte reads of
0xA0 EEPROM offset 0x51.)

We've had this before. We have a byte-mode fallback in the SFP code,
and we've had to be *very* careful when enabling this only for
modules that need it.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

