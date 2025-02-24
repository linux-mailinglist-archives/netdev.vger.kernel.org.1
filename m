Return-Path: <netdev+bounces-168911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B04A417C2
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 09:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCA123ABE83
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 08:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA3323A999;
	Mon, 24 Feb 2025 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hVsAGjGB"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1639237717;
	Mon, 24 Feb 2025 08:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740386860; cv=none; b=Z3RWiwXc8a+adwbCAmQhFsttM6H7yrImxNkGGs+GpoyfEn6fJqzA/mzzb30NYtO4ak464n4Mekow5N1hmaD+/lXH93D8KxcPRHMTcUhauNkQx4cOK5/EsNJ5W5O/Wab+I2BXKIXfMkPqzFaEEd9fKfkLRjkEPjhCSWiZOF0DYjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740386860; c=relaxed/simple;
	bh=N/a0FSOcy4lpjIF/07vPlKdiNnwQDpKLGbXxcMbb8Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rX5Q+X2mOmbfzopHWMYeMMKd1sJWCL87GU8DVabLQ6w2MoPMMNajmSWfmnZwwdso6RE6nT3Y70+Ai6YiaPXaDbeS5Yf6Sfcdynaz7rLxYSOTDS1nLphbSbGGybdTyuo6w0w9U03QtULSjvFpR4xWcWDGQ9EfXCEp4V1GlF3Es6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hVsAGjGB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8DSPR/pZ3Ub3yKWwJjoSPUXzbVMPDyN7eYUJoZQkSYM=; b=hVsAGjGBI3htPSzRcotE3hWsV/
	dgNJq88/QpMnYHUx9oQDhMf3eTYnSG67e/s5kYV1Vo3ExraVDsT8FIjZpiE14bg2cSqkDOX3QbCug
	GIswQYN+FwvTpuAxACeph+DSRpOW/Fi+yzZAnsZXsZVjLNfw2kqUjaagMCy2KVy4HOeHFCSAzv+C/
	jjHxlFCRd/IG/7xnxMtlffDuNHVQ+oNZgQWk/9BiiGHm5Eg0owilNdJvUOAbUp/IR8A6bBVM3aNj2
	b0s90E4LpU3l8PZwaWnesR9EwGXyLcRj9oRKzqJ86/WrZGaI1/tsQK5gK46ugF4XZKtxxHENF7le2
	BWmvKTOg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47184)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tmU7W-0005XM-2X;
	Mon, 24 Feb 2025 08:47:22 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tmU7S-0004rI-2B;
	Mon, 24 Feb 2025 08:47:18 +0000
Date: Mon, 24 Feb 2025 08:47:18 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
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
Message-ID: <Z7wyFolx3q6ACUHO@shell.armlinux.org.uk>
References: <20250223172848.1098621-1-maxime.chevallier@bootlin.com>
 <87r03otsmm.fsf@miraculix.mork.no>
 <Z7uFhc1EiPpWHGfa@shell.armlinux.org.uk>
 <3c6b7b3f-04a2-48ce-b3a9-2ea71041c6d2@lunn.ch>
 <87ikozu86l.fsf@miraculix.mork.no>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ikozu86l.fsf@miraculix.mork.no>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Feb 24, 2025 at 08:13:22AM +0100, Bjørn Mork wrote:
> Andrew Lunn <andrew@lunn.ch> writes:
> 
> >> So, not only do I think that hwmon should be disabled if using SMBus,
> >> but I also think that the kernel should print a warning that SMBus is
> >> being used and therefore e.g. copper modules will be unreliable. We
> >> don't know how the various firmwares in various microprocessors that
> >> convert I2C to MDIO will behave when faced with SMBus transfers.
> >
> > I agree, hwmon should be disabled, and that the kernel should printing
> > a warning that the hardware is broken and that networking is not
> > guaranteed to be reliable.
> 
> What do you think will be the effect of such a warning?  Who is the
> target audience?
> 
> You can obviously add it, and I don't really care.  But I believe the
> result will be an endless stream of end users worrying about this scary
> warning and wanting to know what they can do about it.  What will be
> your answer?

... which is good, because it raises the visibility of crap hardware
and will make people think twice about whether to purchase it, thus
penalising (a little) the sales of badly designed hardware.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

