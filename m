Return-Path: <netdev+bounces-180408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0EBA813B3
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 19:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 008953BEEA5
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD5A22E3FD;
	Tue,  8 Apr 2025 17:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0VghUhm3"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0468256D;
	Tue,  8 Apr 2025 17:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744133538; cv=none; b=jZ5oTrRs5XI52s+hovMImNt90gBLQMuPFRzb8wxNLDWwEGJ33MmXAlwLA3/rY5URxxTg/wtBeO7Pu0tx+aDryKO6jZvC/lRyFbqnYIDBZ+nGVvovvDpzIO+7MEjvFWaQSTuuxpcrsgW+fIgG2QdFCxMLdY42uZI4KCr7d9/VJfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744133538; c=relaxed/simple;
	bh=Uyw8/u91k97AhlT5M27wvbEtOCXoh20ebT5Esp49rco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzD+VeUFm6lOqTYBChkbDuRk/cyqFDvk0AIHsp/MR6yZ4uITD93t4WO2/MotArkh5n2ECPobHJ16YB+a1k9K/s/NVA643Z1VcMSRCgqth23YPbSKi74/yqFzkhd0IW7kvlVVePtqxiOdugOjQRkxRcWNx8IH2Cpfv1YSd1RA4ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0VghUhm3; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tBdgPAyWzfn5h5XGQGb9kQsMmLdGue7/1/u7FpE2qlU=; b=0VghUhm3Hp3VKlWFP2PTk4EowP
	55lJnsT84HpB0kSZ6ecsTUsVTxyi2SlYsBPQMLvuEJCQDsR6xE+fOmXVna+YE6lQu1s/nzvoTbF4/
	MaCom23bYcWDmgVCmsmegXnPhGoPaIvn8ut4ZNfrvjQxtK4lsxWB5bODqM6mcyEZ/oPRuld30xSdW
	8DLynfqD+8CesWVghVKBKxrRuqU5rmkYAvQdIVFocSvKT7TrlbJjegmqsRJdlLCbQWY4lbUw+k8Au
	7h/NvBbxlThTMqzX10qYYWFUK5acF3LYa6UfINrCWjJhCqtHOJbP8uw/IpOjSxyrelTXXPnYlccdu
	TG93l36A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41056)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u2Cnu-0007qs-2h;
	Tue, 08 Apr 2025 18:32:07 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u2Cns-0001bp-25;
	Tue, 08 Apr 2025 18:32:04 +0100
Date: Tue, 8 Apr 2025 18:32:04 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Simon Horman <horms@kernel.org>
Cc: Kory Maincent <kory.maincent@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
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
Message-ID: <Z_VdlGVJjdtQuIW0@shell.armlinux.org.uk>
References: <20250407-feature_marvell_ptp-v2-0-a297d3214846@bootlin.com>
 <20250407-feature_marvell_ptp-v2-2-a297d3214846@bootlin.com>
 <20250408154934.GZ395307@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408154934.GZ395307@horms.kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 08, 2025 at 04:49:34PM +0100, Simon Horman wrote:
> On Mon, Apr 07, 2025 at 04:03:01PM +0200, Kory Maincent wrote:
> > From: Russell King <rmk+kernel@armlinux.org.uk>
> > 
> > From: Russell King <rmk+kernel@armlinux.org.uk>
> > 
> > Add PTP basic support for Marvell 88E151x PHYs. These PHYs support
> > timestamping the egress and ingress of packets, but does not support
> > any packet modification.
> > 
> > The PHYs support hardware pins for providing an external clock for the
> > TAI counter, and a separate pin that can be used for event capture or
> > generation of a trigger (either a pulse or periodic).  This code does
> > not support either of these modes.
> > 
> > The driver takes inspiration from the Marvell 88E6xxx DSA and DP83640
> > drivers.  The hardware is very similar to the implementation found in
> > the 88E6xxx DSA driver, but the access methods are very different,
> > although it may be possible to create a library that both can use
> > along with accessor functions.
> > 
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > 
> > Add support for interruption.
> > Fix L2 PTP encapsulation frame detection.
> > Fix first PTP timestamp being dropped.
> > Fix Kconfig to depends on MARVELL_PHY.
> > Update comments to use kdoc.
> > 
> > Co-developed-by: Kory Maincent <kory.maincent@bootlin.com>
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> 
> Hi Kory,
> 
> Some minor feedback from my side.
> 
> > ---
> > 
> > Russell I don't know which email I should use, so I keep your old SOB.
> 
> Russell's SOB seems to be missing.

... and anyway, I haven't dropped my patches, I'm waiting for the
fundamental issue with merging Marvell PHY PTP support destroying the
ability to use MVPP2 PTP support to be solved, and then I will post
my patches.

They aren't dead, I'm just waiting for the issues I reported years ago
with the PTP infrastructure to be resolved - and to be tested as
resolved.

I'm still not convinced that they have been given Kory's responses to
me (some of which I honestly don't understand), but I will get around
to doing further testing to see whether enabling Marvell PHY PTP
support results in MVPP2 support becoming unusable.

Kory's lack of communication with me has been rather frustrating.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

