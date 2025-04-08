Return-Path: <netdev+bounces-180476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA4FA81705
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 22:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F80A467EC9
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 20:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC56245006;
	Tue,  8 Apr 2025 20:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Aj7F0SGZ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6249F14AD2D;
	Tue,  8 Apr 2025 20:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744144717; cv=none; b=LmokNtgUkaOGnO2lpxueHsW1t70HQTTx8BjyQr9/CF9z8meLudLYFXhq5pxAXx7RIvaiEoX88LXqN/TX2OcyZJEcXJJnK+LPI5+Td4pX6wLEMVinRLyKCR2GSZxJMfcvggSRMR23xHnwYJBKxfChwRFck9WFVkqcXHo22G9EuOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744144717; c=relaxed/simple;
	bh=/Kw6st2pnDpftiGPN3w+JzvNogqNlbnHU0D4XG+Svlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HkJBrrlOyFWH0HBZZ4p/4tw2kKD/kKCMdhFEW0I4Btssuuhj3mieABuke24GcYTe9kPrSiLvZrH94RmqOHfnDFnkiFqOfyJMs81tmNRTRkJ4cJPi0WGGT74UT+1qpLESJwos3134hum4t35pAMG0uw8lgEJDZdN2rn0symNsKmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Aj7F0SGZ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VD5RBGKxigPgtblvWuJRXHdquKAvdE2Tj2TOow3DheA=; b=Aj7F0SGZGME/JYyz9t90iWxCdp
	jt3rrDUGoihmEjhaN9LEkoC94Z7aimFskAaZMxmN9jNMRoB71DpaWQvlIbtni3ehGZUyhtAZrzmVs
	Kzxfzu0yYtIeMp9mMT0MYxjHqLyutJsckZktAEYE2/OMRrSqn3dPnk1elIJRYJUwg7TnRcSbPtEPS
	RhGyPfNwEpEtStckIe6PehFRaGB/lI7tMvd0083LshBS9fBKVIyKOYvZ8lX72762OH5luYqPfzHuJ
	fJGrZtyD188y1HbEgUTgeE+bizCDjpABEfgaf8TiftwECrDkPqy4XlbhkBDLBnt+8S+9Es1AECIlC
	MaU9IyAg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39464)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u2FiB-00084R-2X;
	Tue, 08 Apr 2025 21:38:23 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u2Fi8-0001pE-0I;
	Tue, 08 Apr 2025 21:38:20 +0100
Date: Tue, 8 Apr 2025 21:38:19 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/2] Add Marvell PHY PTP support
Message-ID: <Z_WJO9g5Al1Yr_LX@shell.armlinux.org.uk>
References: <20250407-feature_marvell_ptp-v2-0-a297d3214846@bootlin.com>
 <Z_P3FKEhv1s0y4d7@shell.armlinux.org.uk>
 <20250407182028.75531758@kmaincent-XPS-13-7390>
 <Z_P-K7mEEH6ProlC@shell.armlinux.org.uk>
 <20250407183914.4ec135c8@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407183914.4ec135c8@kmaincent-XPS-13-7390>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Apr 07, 2025 at 06:39:14PM +0200, Kory Maincent wrote:
> On Mon, 7 Apr 2025 17:32:43 +0100
> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> 
> > On Mon, Apr 07, 2025 at 06:20:28PM +0200, Kory Maincent wrote:
> > > On Mon, 7 Apr 2025 17:02:28 +0100
> > > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> > >   
> > > > On Mon, Apr 07, 2025 at 04:02:59PM +0200, Kory Maincent wrote:  
> >  [...]  
> > > > 
> > > > Is the PTP selection stuff actually sorted now? Last time I tested it
> > > > after it having been merged into the kernel for a while, it didn't work,
> > > > and I reported that fact. You haven't told me that you now expect it to
> > > > work.  
> > > 
> > > The last part of the series, the PTP selection support wasn't merged when
> > > you tested it, although the default PTP choice that causes your regression
> > > was merged.
> > > Now it is fully merged, even the ethtool support.
> > > https://lore.kernel.org/netdev/mjn6eeo6lestvo6z3utb7aemufmfhn5alecyoaz46dt4pwjn6v@4aaaz6qpqd4b/
> > > 
> > > The only issue is the rtln warning from the phy_detach function. About it, I
> > > have already sent you the work I have done throwing ASSERT_RTNL in
> > > phy_detach. Maybe I should resend it as RFC.
> > >   
> > > > I don't want this merged until such time that we can be sure that MVPP2
> > > > platforms can continue using the MVPP2 PTP support, which to me means
> > > > that the PTP selection between a MAC and PHY needs to work.  
> > > 
> > > It should works, the default PTP will be the MAC PTP and you will be able to
> > > select the current PTP between MAC and PHY with the following command:
> > > # ethtool --set-hwtimestamp-cfg eth0 index 0 qualifier precise
> > > Time stamping configuration for eth0:
> > > Hardware timestamp provider index: 0
> > > Hardware timestamp provider qualifier: Precise (IEEE 1588 quality)
> > > Hardware Transmit Timestamp Mode:
> > > 	off
> > > Hardware Receive Filter Mode:
> > > 	none
> > > Hardware Flags: none
> > > # ethtool --set-hwtimestamp-cfg eth0 index 1 qualifier precise
> > > Time stamping configuration for eth0:
> > > Hardware timestamp provider index: 1
> > > Hardware timestamp provider qualifier: Precise (IEEE 1588 quality)
> > > Hardware Transmit Timestamp Mode:
> > > 	off
> > > Hardware Receive Filter Mode:
> > > 	none
> > > Hardware Flags: none
> > > 
> > > You can list the PTPs with the dump command:
> > > # ethtool --show-time-stamping "*"
> > > 
> > > You will need to stop phc2sys and ptp4l during these change as linuxptp may
> > > face some issues during the PTP change.  
> > 
> > I'm preferring to my emails in connection with:
> > 
> > https://lore.kernel.org/r/ZzTMhGDoi3WcY6MR@shell.armlinux.org.uk
> > 
> > when I tested your work last time, it seemed that what was merged hadn't
> > even been tested. In the last email, you said you'd look into it, but I
> > didn't hear anything further. Have the problems I reported been
> > addressed?
> 
> It wasn't merged it was 19th version and it worked and was tested, but not
> with the best development design. I have replied to you that I will do some
> change in v20 to address this.
> https://lore.kernel.org/all/20241113171443.697ac278@kmaincent-XPS-13-7390/
> 
> It gets finally merged in v21.

Okay, so I'm pleased to report that this now works on the Macchiatobin:

# ./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --dump tsinfo-get --json '{"header":{"dev-name":"eth2"}}' 
[{'header': {'dev-index': 5, 'dev-name': 'eth2'},
  'hwtstamp-provider': {'index': 2, 'qualifier': 0},
  'phc-index': 2,
  'rx-filters': {'bits': {'bit': [{'index': 0, 'name': 'none'},
                                  {'index': 1, 'name': 'all'}]},
                 'nomask': True,
                 'size': 16},
  'timestamping': {'bits': {'bit': [{'index': 0, 'name': 'hardware-transmit'},
                                    {'index': 1, 'name': 'software-transmit'},
                                    {'index': 2, 'name': 'hardware-receive'},
                                    {'index': 3, 'name': 'software-receive'},
                                    {'index': 4,
                                     'name': 'software-system-clock'},
                                    {'index': 6,
                                     'name': 'hardware-raw-clock'}]},
                   'nomask': True,
                   'size': 18},
  'tx-types': {'bits': {'bit': [{'index': 0, 'name': 'off'},
                                {'index': 1, 'name': 'on'},
                                {'index': 2, 'name': 'onestep-sync'},
                                {'index': 3, 'name': 'onestep-p2p'}]},
               'nomask': True,
               'size': 4}},
 {'header': {'dev-index': 5, 'dev-name': 'eth2'},
  'hwtstamp-provider': {'index': 0, 'qualifier': 0},
  'phc-index': 0,
  'rx-filters': {'bits': {'bit': [{'index': 0, 'name': 'none'},
                                  {'index': 2, 'name': 'some'}]},
                 'nomask': True,
                 'size': 16},
  'timestamping': {'bits': {'bit': [{'index': 0, 'name': 'hardware-transmit'},
                                    {'index': 2, 'name': 'hardware-receive'},
                                    {'index': 3, 'name': 'software-receive'},
                                    {'index': 4,
                                     'name': 'software-system-clock'},
                                    {'index': 6,
                                     'name': 'hardware-raw-clock'}]},
                   'nomask': True,
                   'size': 18},
  'tx-types': {'bits': {'bit': [{'index': 0, 'name': 'off'},
                                {'index': 1, 'name': 'on'}]},
               'nomask': True,
               'size': 4}}]

where phc 2 is the mvpp2 clock, and phc 0 is the PHY.

# ethtool -T eth2
Time stamping parameters for eth2:
Capabilities:
        hardware-transmit
        software-transmit
        hardware-receive
        software-receive
        software-system-clock
        hardware-raw-clock
PTP Hardware Clock: 2
Hardware Transmit Timestamp Modes:
        off
        on
        onestep-sync
        onestep-p2p
Hardware Receive Filter Modes:
        none
        all

So I guess that means that by default it's using PHC 2, and thus using
the MVPP2 PTP implementation - which is good, it means that when we add
Marvell PHY support, this won't switch to the PHY implementation.

Now, testing ethtool:

$ ./ethtool --get-hwtimestamp-cfg eth2
netlink error: Operation not supported

Using ynl:

# ./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --dump tsconfig-get --json '{"header":{"dev-name":"eth2"}}'
[]

So, It's better, something still isn't correct as there's no
configuration. Maybe mvpp2 needs updating first? If that's the case,
then we're not yet in a position to merge PHY PTP support.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

