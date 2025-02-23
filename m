Return-Path: <netdev+bounces-168863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8080A411A4
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 21:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AEF33AA540
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 20:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDCB156C76;
	Sun, 23 Feb 2025 20:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="z3zJpBih"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E3A76C61;
	Sun, 23 Feb 2025 20:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740342680; cv=none; b=o5aBPUQquZU94bWM0LuquipoO7e8OgTpzdAfGE9iGrsyv2XA0MD9q+dVhYpHfQziwezIyZBJEIoV6XqplFZnisfH96ucj3AqsUJn3m78i9TNUErGd9maCbtqPIfoWY6bP0WLPAacFR9BF8YJHb/29RndnTwER1JMLPBFd4OkvaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740342680; c=relaxed/simple;
	bh=2SRBcMj9JIMeyK5vmbaEgk30kVYy8n/NU4yA3uMiuEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpY5rgRDQx7MSp8TD1uJY2YfTn81FhsKP8FsDLBoMGHV1tI2FWF8fJzIP49SeFJc0vzY1kotIOHZboD86jzLIUDPTubcOH9tuU8dBLlG5ivGgskSN32D11d8DEowzuTZJMZM/osSuHtZxaXCfiHVVtAbV7Bn7/QSqq2IJsHD5kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=z3zJpBih; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/fYo2p8XtniofyUH/iizmuKJSZUYgRd5Be3P1t8VfvM=; b=z3zJpBihYZCDmS2PL9GNWwHwkl
	0FCmVbABqzaF/MQufl+Idg5yK0s5EdfRr7zgP5JJZyy94cOMZwGJl4ma08xBWetgIueBMDCnoNw/M
	MlQl2CGF7ohnOG7N0KGwYIoia+G1vm5KtSJo99xy/NXx0vRVHdqP7niuSGpeR8+dBh4KXLOj5f0Yc
	ik441t8DBYFJO3eN9cSG1kIvlrbRY+BC+nf54uO6cAeEFuKIPPHFeywe6U4A/FF+Vtv4PLbO6pSCu
	wcWxgiwsvLLkQfjTh7xSvLW4DKZH2XbKJBx6utQzJxGUHaCDzwUMA7GIBzYRcriummORbTX60XETx
	f89fspZQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59580)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tmId0-0003xe-0u;
	Sun, 23 Feb 2025 20:31:06 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tmIcv-0004HQ-27;
	Sun, 23 Feb 2025 20:31:01 +0000
Date: Sun, 23 Feb 2025 20:31:01 +0000
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
Message-ID: <Z7uFhc1EiPpWHGfa@shell.armlinux.org.uk>
References: <20250223172848.1098621-1-maxime.chevallier@bootlin.com>
 <87r03otsmm.fsf@miraculix.mork.no>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r03otsmm.fsf@miraculix.mork.no>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Feb 23, 2025 at 07:37:05PM +0100, Bjørn Mork wrote:
> As for Russel's comments regarding atomic reads, I'm hoping for the
> pragmatic approach and allow all possible features over SMBus. It's not
> like we have the option of using i2c on a host which only supports
> SMBus.  My experience is that both hwmon and phy access works pretty
> well with SMBus byte accesses.

The pragmatic approach is to avoid using things that are unsafe (and
thus unreliable.) As I said, disabling hwmon makes sense because you
don't want to read the 16-bit values non-atomically and end up with
scrambled readings that then trigger alarms because they've exceeded
the thresholds.

Merely proving that "oh look it works because I can read stuff"
doesn't address my point.

SMBus being used is as bad as all those crappy SFP modules out there
that don't conform to the SFP MSA but claim they do. It's just yet
another hardware designer cocking the design up in a way that makes
SFPs unreliable. Unfortunately, there's not much that we can do to
influence that, but not publishing stuff that's ultimately unreliable
helps to make the issue known.

So, not only do I think that hwmon should be disabled if using SMBus,
but I also think that the kernel should print a warning that SMBus is
being used and therefore e.g. copper modules will be unreliable. We
don't know how the various firmwares in various microprocessors that
convert I2C to MDIO will behave when faced with SMBus transfers.

All in all, I'm not happy with this, and I do wish hardware designers
would get a clue.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

