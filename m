Return-Path: <netdev+bounces-169536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE9FA44809
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 18:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22F59880612
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 17:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628531FDA65;
	Tue, 25 Feb 2025 17:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1yVAKjmb"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B7A1FC7DA;
	Tue, 25 Feb 2025 17:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503760; cv=none; b=K8TxOH0pNiSzHsdei5KyijCUrs3wKECocj3d1PaMa2mT36QqG1NuBoytFM776T7QZZ7+/T087Tc1M/fEj1SWXzt+V6DLjK54vMcdBLPPDNteYOYoMArLUj3j0vv60xbHXYe52BsF5p86ejUT3INGXK+f6OR4OCWdQSYBNxVHhbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503760; c=relaxed/simple;
	bh=ezGAIeWPAxlOHhFgXBsoCU/huFK7irSzPAfTK2ZAJS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aydX+5BztW5/9ZOZat4JmgnxUJcN3O9Tn087btyCvPY8Kr5Pn5Cw5LVc0kSzcAhpTJzrIBmDsBKbwc/Mcgb2WwJtcnwguRk4moa0OX+GC1aKyN9ZdzfxFD6ZEx7SqNLD25rdHGRFuH+p7a/dzEvTCvVfCsCJOKqkzqaknzHKM3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=1yVAKjmb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/FcX+G+I0G7bVNTYmPL3UUc4quzJ0eDdIDeI93mfRq4=; b=1yVAKjmbmU93d92TuCfnf1frpT
	Ctf7Dl/Dn1l9OVlm84zGxCeBlX9Zv9JEVa6tjGwapcEtkUtsGTuZ7t+K2wJhfdlwEvcJKpkX5sFI3
	BGP9rghzWaJoFB0ZNBRdIqJobvwLoYMiNcpamgI8sn2P/L167nbuejfNXIz9DBSKlK2Sd6Z5UcpYw
	ww+g6HT3LJ0mDrE47fL8Ub3g9Pu+3yGH4V9OsvMicaTw9+7CfeQHGmKGRMsNM4m1OKvN0EDPKmy+O
	WNkems2wavszyCNaSshvxuPTEQ8qtvBocuSKQEd5XrGVt5qQYhmbIiFy7qA1d3VvBySy1ec8eXqQr
	+EM822Pw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38584)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tmyWy-00023F-0v;
	Tue, 25 Feb 2025 17:15:40 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tmyWu-0006Bl-33;
	Tue, 25 Feb 2025 17:15:36 +0000
Date: Tue, 25 Feb 2025 17:15:36 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Antoine Tenart <atenart@kernel.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH net-next 0/2] net: phy: sfp: Add single-byte SMBus SFP
 access
Message-ID: <Z736uAVe5MqRn7Se@shell.armlinux.org.uk>
References: <20250223172848.1098621-1-maxime.chevallier@bootlin.com>
 <Z7tdlaGfVHuaWPaG@shell.armlinux.org.uk>
 <87o6yqrygp.fsf@miraculix.mork.no>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o6yqrygp.fsf@miraculix.mork.no>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Feb 25, 2025 at 01:38:30PM +0100, Bjørn Mork wrote:
> "Russell King (Oracle)" <linux@armlinux.org.uk> writes:
> > On Sun, Feb 23, 2025 at 06:28:45PM +0100, Maxime Chevallier wrote:
> >> Hi everyone,
> >> 
> >> Some PHYs such as the VSC8552 have embedded "Two-wire Interfaces" designed to
> >> access SFP modules downstream. These controllers are actually SMBus controllers
> >> that can only perform single-byte accesses for read and write.
> >
> > This goes against SFF-8472, and likely breaks atomic access to 16-bit
> > PHY registers.
> >
> > For the former, I quote from SFF-8472:
> >
> > "To guarantee coherency of the diagnostic monitoring data, the host is
> > required to retrieve any multi-byte fields from the diagnostic
> > monitoring data structure (e.g. Rx Power MSB - byte 104 in A2h, Rx
> > Power LSB - byte 105 in A2h) by the use of a single two-byte read
> > sequence across the 2-wire interface."
> >
> > So, if using a SMBus controller, I think we should at the very least
> > disable exporting the hwmon parameters as these become non-atomic
> > reads.
> 
> Would SMBus word reads be an alternative for hwmon, if the SMBus
> controller support those?  Should qualify as "a single two-byte read
> sequence across the 2-wire interface."

Looking at the SNIA documents, this should work, so if a SMBus supports
two-byte reads, then we should be able to support hwmon with such a
controller. However, if only single-byte reads are supported, then I
think we should disable hwmon as we'd be going against the statement
I provided above from the docs.

> > Whether PHY access works correctly or not is probably module specific.
> > E.g. reading the MII_BMSR register may not return latched link status
> > because the reads of the high and low bytes may be interpreted as two
> > seperate distinct accesses.
> 
> Bear with me.  Trying to learn here.  AFAIU, we only have a defacto
> specification of the clause 22 phy interface over i2c, based on the
> 88E1111 implementation.  As Maxime pointed out, this explicitly allows
> two sequential distinct byte transactions to read or write the 16bit
> registers. See figures 27 and 30 in
> https://www.marvell.com/content/dam/marvell/en/public-collateral/transceivers/marvell-phys-transceivers-alaska-88e1111-datasheet.pdf

However, note that it's:

 START ADDR(W) REG RE-START ADDR(R) HIGH STOP
 START ADDR(W) REG RE-START ADDR(R) LOW STOP

and not:

 START ADDR(W) REG STOP START ADDR(R) HIGH STOP
 ...

I forget whether SMBus can do re-starts.

> Looks like the latch timing restrictions are missing, but I still do not
> think that's enough reason to disallow access to phys over SMBus.  If
> this is all the interface specification we have?

I'm not sure what you're referring to here with "latch timing
restrictions".

Reading more of the 88E1111, if one only transfers an odd number of
bytes for a register, it looks like that could cause problems. It
doesn't appear to specify what happens if it receives a write e.g.
for upper byte of register 0, and then receives a write for
register 4 (as a hypothetical example - caused where the lower byte of
register 0 transfer failed.)

We do need to think about these corner cases!

> I have been digging around for the RollBall protocol spec, but Google
> isn't very helpful.  This list and the mdio-i2c.c implementation is all
> that comes up.  It does use 4 and 6 byte transactions which will be
> difficult to emulate on SMBus.  But the
> 
> 	/* By experiment it takes up to 70 ms to access a register for these
> 	 * SFPs. Sleep 20ms between iterations and try 10 times.
> 	 */
> 
> comment in i2c_rollball_mii_poll() indicates that it isn't very timing
> sensitive at all. The RollBall SFP+ I have ("FS", "SFP-10G-T") is faster
> than the comment indicates, but still leaves plenty of time for the
> single byte SMBus transactions to complete.

The "RollBall" protocol isn't official afaics. It got called that
because of the first module that Marek happened to have that implemented
it. Having taken several of these modules apart, it's implemented by a
microcontroller, which may be an Arm Cortex based controller, or might
be 8051 based. Whether the firmware implementation at the high-level
code is the same or not is anyone's guess. We just don't know. It
could be entirely different implementations - and that's the problem.
We already know that the timings for this protocol vary depending on
the module (possibly because of differing implementations) which brings
questions up about the behaviour in obscure cases like single-byte
reads.

> Haven't found any formal specification of i2c clause 45 access either.
> But some SFP+ vendors have been nice enough to document their protocol
> in datasheets.  Examples:
> 
> https://www.repotec.com/download/managed-ethernet/ds-ml/01-MOD-M10GTP-DS-verB.pdf
> https://www.apacoe.com.tw/files/ASFPT-TNBT-X-NA%20V1.4.pdf
> 
> They all seem to agree that 2/4/6 byte accesses are required, and they
> offer no single byte alternative even if the presence of a "smart"
> bridge should allow intelligent latching.  So this might be
> "impossible" (aka "hard") to do over SMBus.   I have no such SFP+ so I
> cannot even try.

Indeed. So maybe we need a stronger kernel message to basically blame
the hardware designer and refuse to operate with modules that _might_
use the Rollball protocol. (Note, it's "might" because if we can't
access the PHY, we don't know for certain that this module is a
copper module.)

> > In an ideal world, I'd prefer to say no to hardware designs like this,
> > but unfortunately, hardware designers don't know these details of the
> > protocol, and all they see is "two wire, oh SMBus will do".
> 
> I believe you are reading more into the spec than what's actually there.

So I'm making up the quote above from SFF-8472.  Okay, if that's where
this discussion is going, I'm done here.

NAK to this patch set.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

