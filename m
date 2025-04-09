Return-Path: <netdev+bounces-180648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 044CCA82029
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 10:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCAA98816C1
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 08:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1299B21ADB5;
	Wed,  9 Apr 2025 08:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BQC82+JG"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98F41DEFE4;
	Wed,  9 Apr 2025 08:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744187604; cv=none; b=iBd4TLKfI8P4rVlQJAJiTN0Cw6LWj1zco7Ronn2aK/QkjU3xNqPKhYNAZMNpxjecTsksIbrHvpJS2LZI/MR79Im0RFCVOMQh8gq6/c2jZ9D1fSEjr5upuSNT2p7s/9FmDTQPlIbtWtfxCs3ByqydSPn6BCwMy9s4eTzoaZ9R4u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744187604; c=relaxed/simple;
	bh=DBu10xqnRC55ZvjHYpZP6/MVuipQrl3KTWRj0IvtK7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuRhoLTVfErp+uZb7Sdsu+UBzK4aR+G7xZ5uIsLHCSrGvKQdPEzeFIl5nCj4vEzcma3Gp9L9ov7eMfGA0EGoAXZqhbDqPkUL52uxEsmLHSFcEhiFi+/xW9YMrFd4IwKvBcbVAls1HrZEs7m2ObN7YbiNhsC+Y2wFae0mRpgpm6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=BQC82+JG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=94CRJ1QKEZIeOBN2yxEUCNifssJmO/x61XeP55dLjCw=; b=BQC82+JGLo6KyCxTGpLJKAzVzz
	Ul4vyHS2IfHuiZDvVK1YA6k5hGdgdcVR3lxjfA9rZ99qpwU6wrGkZJ+eorXWUky8QWCBXjCSm9XFa
	SUzoJnP/jkkTgEh89x6eUZRnHMiLfPyQTpkT/qwY3Ujiji+Nd1wbQjjexdcuEcn+yjX7hLUzgmvfK
	X82Oq3QhS563o8HZpIkdCkqGqY78pxz8+3/+06WnAbvuGsvPw4hENrfpwDecAz/RWSHpX4uSCophH
	5x5Us3NSikXebU8ZL5jRyzl4NOGJok6pklo/O+EfqFvsqtuUIJ9eyMpD9VYayI3/3buisFYYjogRx
	BVllv0jA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33850)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u2Qrv-0000Fa-27;
	Wed, 09 Apr 2025 09:33:11 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u2Qrt-0002Pb-2C;
	Wed, 09 Apr 2025 09:33:09 +0100
Date: Wed, 9 Apr 2025 09:33:09 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: phy: Add Marvell PHY PTP support
Message-ID: <Z_YwxYZc7IHkTx_C@shell.armlinux.org.uk>
References: <20250407-feature_marvell_ptp-v2-0-a297d3214846@bootlin.com>
 <20250407-feature_marvell_ptp-v2-2-a297d3214846@bootlin.com>
 <20250408154934.GZ395307@horms.kernel.org>
 <Z_VdlGVJjdtQuIW0@shell.armlinux.org.uk>
 <20250409101808.43d5a17d@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409101808.43d5a17d@kmaincent-XPS-13-7390>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Apr 09, 2025 at 10:18:08AM +0200, Kory Maincent wrote:
> On Tue, 8 Apr 2025 18:32:04 +0100
> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> 
> > On Tue, Apr 08, 2025 at 04:49:34PM +0100, Simon Horman wrote:
> > > On Mon, Apr 07, 2025 at 04:03:01PM +0200, Kory Maincent wrote:  
> > > > From: Russell King <rmk+kernel@armlinux.org.uk>
> > > > 
> > > > From: Russell King <rmk+kernel@armlinux.org.uk>
> > > > 
> > > > Add PTP basic support for Marvell 88E151x PHYs. These PHYs support
> > > > timestamping the egress and ingress of packets, but does not support
> > > > any packet modification.
> > > > 
> > > > The PHYs support hardware pins for providing an external clock for the
> > > > TAI counter, and a separate pin that can be used for event capture or
> > > > generation of a trigger (either a pulse or periodic).  This code does
> > > > not support either of these modes.
> > > > 
> > > > The driver takes inspiration from the Marvell 88E6xxx DSA and DP83640
> > > > drivers.  The hardware is very similar to the implementation found in
> > > > the 88E6xxx DSA driver, but the access methods are very different,
> > > > although it may be possible to create a library that both can use
> > > > along with accessor functions.
> > > > 
> > > > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > > > 
> > > > Add support for interruption.
> > > > Fix L2 PTP encapsulation frame detection.
> > > > Fix first PTP timestamp being dropped.
> > > > Fix Kconfig to depends on MARVELL_PHY.
> > > > Update comments to use kdoc.
> > > > 
> > > > Co-developed-by: Kory Maincent <kory.maincent@bootlin.com>
> > > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>  
> > > 
> > > Hi Kory,
> > > 
> > > Some minor feedback from my side.
> > >   
> > > > ---
> > > > 
> > > > Russell I don't know which email I should use, so I keep your old SOB.  
> > > 
> > > Russell's SOB seems to be missing.  
> > 
> > ... and anyway, I haven't dropped my patches, I'm waiting for the
> > fundamental issue with merging Marvell PHY PTP support destroying the
> > ability to use MVPP2 PTP support to be solved, and then I will post
> > my patches.
> > 
> > They aren't dead, I'm just waiting for the issues I reported years ago
> > with the PTP infrastructure to be resolved - and to be tested as
> > resolved.
> > 
> > I'm still not convinced that they have been given Kory's responses to
> > me (some of which I honestly don't understand), but I will get around
> > to doing further testing to see whether enabling Marvell PHY PTP
> > support results in MVPP2 support becoming unusable.
> > 
> > Kory's lack of communication with me has been rather frustrating.
> 
> You were in CC in all the series I sent and there was not a lot of review and
> testing on your side. I know you seemed a lot busy at that time but I don't
> understand what communication is missing here? 

I don't spend much time at the physical location where the hardware that
I need to test your long awaited code is anymore. That means the
opportunities to test it are *rare*.

So far, each time I've tested your code, it's been broken. This really
doesn't help.

If you want me to do anything more in a timely manner, like test fixes,
you need to get them to me by the end of this week, otherwise I won't
again be able to test them for a while.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

