Return-Path: <netdev+bounces-169593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF25A44ACE
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 19:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112FD3A5F72
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 18:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D5919AD90;
	Tue, 25 Feb 2025 18:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Gc+p7HjV"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E92A14F9C4;
	Tue, 25 Feb 2025 18:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740508815; cv=none; b=cyvIptu//dc3iV6mkqWX3FKrc3aDupQtjMbUyNYiXDKZA7OpkpoWR05haP6xr6i1Jscc0xe+Mn7J0Y6u4um33BqSMLxZZk/H3S9+FZ+mXJXoetDhtx/UAhR149I/XYMb8o8tdvHti+Le3zrBAohEtr09jiijkr+W6K3sYeZFzG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740508815; c=relaxed/simple;
	bh=wPEnV2mno5xbUH0szyTczg3utgP780YBBIdVg1C/AqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onL2mqDn7OWTdwtCubJeVk+kNRx+shEUJ2sLQPY9he694PTquxARoGIdV2H1o6PLOfzj95J6qzTH7peMFuwbrhSYRbXeAMH8125YdA7pCvskaF2PrJ40YG1uYglOtl+yumqbdDgXHENBjMVre78L2onVxT0uMGxZ1JFtFDZQKG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Gc+p7HjV; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yUfKzzXtlpJWqtPSPd4z1n+cY2G3l5tCTWaTRMTYygo=; b=Gc+p7HjVwSLB2cvSP1VX7+u4aH
	6x3nzVo50UXGlopSXeCZoHiG+QvWrgIJRyqCMalndwWsqsdIwEFPiAIXD19GHM3jYekUD0tvJZq4S
	iw585gQqpIF/cSvsitrtGfb0uZ2sNQ0vRhRCk846xEhB8XaP5RCocopykXnTRCSzVCqzT0sM2jqoO
	kR9AadyJRJaGpsC+7JkRliEVc5uSDcW0FdubG4koA2DltdyC9jVWcksAiGW7JcVvPxChh6ZVxDsdr
	i1th8Sxxqh0ZQ/cbw0/RLFNEXQ7WtHtSkb2eDjmNC9lO35RI/DGfAWCQAzfHi9nZhGtRk/narLx8p
	KF7CAyFA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39570)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tmzqf-0002G5-1b;
	Tue, 25 Feb 2025 18:40:05 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tmzqc-0006FQ-0o;
	Tue, 25 Feb 2025 18:40:02 +0000
Date: Tue, 25 Feb 2025 18:40:02 +0000
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
Message-ID: <Z74OgoixUyD5BLDs@shell.armlinux.org.uk>
References: <20250223172848.1098621-1-maxime.chevallier@bootlin.com>
 <Z7tdlaGfVHuaWPaG@shell.armlinux.org.uk>
 <87o6yqrygp.fsf@miraculix.mork.no>
 <Z736uAVe5MqRn7Se@shell.armlinux.org.uk>
 <87h64hsxsi.fsf@miraculix.mork.no>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h64hsxsi.fsf@miraculix.mork.no>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Feb 25, 2025 at 07:07:41PM +0100, Bjørn Mork wrote:
> "Russell King (Oracle)" <linux@armlinux.org.uk> writes:
> 
> >> I believe you are reading more into the spec than what's actually there.
> >
> > So I'm making up the quote above from SFF-8472.  Okay, if that's where
> > this discussion is going, I'm done here.
> 
> No, not at all.  That was not what I meant.  Please accept my apologies.
> This came out wrong. You are absolutely correct about reading the 16bit
> diagnostic registers you quoted. I would never doubt that. I have an
> extreme respect for you and your knowledge of these standards and the
> practical hardware implications.
> 
> It was the conclusion that this fact prevents SMBus hosts I wanted to
> question.  I still don't see that.  Some SMBus hosts might be able do 2
> byte reads.  And if they can't, then I believe they can safely ignore
> these registers without being out of spec.  Like the proposed solution.

It doesn't prevent SMBus hosts, but it does prevent SMBus hosts from
being able to be used *reliably* with the diagnostics "EEPROM" to read
the values in a coherent manner.

It also prevents being able to identify the Nokia 3FE46541AA module,
because the module's I2C locks the bus when a single-byte read of
offset 0x51 in the "identity" EEPROM at 0xA0/0x50.

We do already have single-byte mode in the SFP driver, which is
necessary to work around the broken I2C interface on RTL8672 and
RTL9601C which emulate that EEPROM.

There's a lot of "brokenness" out there, and what I've learnt from
dealing with SFPs over the last 10+ years is to be cautious about
*everything*. One thing that can be guaranteed is that a module will
be broken in unexpected ways, and using a different behaviour for
working modules will turn out to break.

The Nokia 3FE46541AA is a brilliant example of a module that
emulates all accesses and fails with single-byte reads, thus making
it incompatible with a SMBus that can only read single bytes.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

