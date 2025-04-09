Return-Path: <netdev+bounces-180959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A901DA83425
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 00:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2F877A6EAA
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 22:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD83221B918;
	Wed,  9 Apr 2025 22:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="T7bs0RuM"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D0221B8F6;
	Wed,  9 Apr 2025 22:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744238301; cv=none; b=jMRBdg31MFkWDx6r6CVbCzWIXNxJ6AJtKVPcy4fqpmwQ4MIPWr395TzuN/rw3VgFshO3HkPG+RGVTjGwohVMzbDK88MQIxmZ2rhwjfBPJTfJrV+YfoXc4uOFjA4bSLNWR3rjh1NpKh2aWbuDbr7N9J2EUs1kyJRcZSFB77KYBjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744238301; c=relaxed/simple;
	bh=OHtp4F7p63NJxA84todWDgotcK4aJifK+VZb4O3Drbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C70z4d54cLOLoJnmlYP4gbxj40LcIWrXpakyZEBCP+9FHAirbD/E3kTwaCIXOiGVfGCwUt755GhUInzsNfQdZ888EKZyPkU91GrVtvpzhWVjUDoYNFPdkaBZuUGPnxVU7CXr3Jbyi6J1fQyHLvyI/rfsfYCLU+ZwxmW+exmr64Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=T7bs0RuM; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nL7mIlluM6OajPfL+ZNXktP9xeZ4qYxjj5R5ClsiFZk=; b=T7bs0RuMx2TEfemGQ8TkaA5C4x
	kbzR+XmTDl120aq8xn4QYgqqBxvn3dAIqc/vUE7TPy41UGJEF9P7K/KPZ5j7WaOZ7GrkPx8ZokpS4
	wUGaU7A4lAKA9K1IQ4YUxusOj1Hf4t13aOc3/L1JReswU47DwNP1CWzDncNiNwjlOq+zoVVMXCvdk
	7Stv0r6kswmQMJTMceNraJpD9mqgDZlxM2zJXiqgnFfzDk7zzA9YNFSLkMYxQJ39fAR+pdc4zlBlg
	BiO6F7ckVftxk/mHWtscoPXHnlElFhDaGAssgssagWP/SoSX0V5O7xTc3W02Cw3Wx+jsA5KDeSPQh
	wbscKE/Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56222)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u2e3Y-00018D-1w;
	Wed, 09 Apr 2025 23:38:04 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u2e3U-0002vu-2s;
	Wed, 09 Apr 2025 23:38:00 +0100
Date: Wed, 9 Apr 2025 23:38:00 +0100
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
Message-ID: <Z/b2yKMXNwjqTKy4@shell.armlinux.org.uk>
References: <20250408154934.GZ395307@horms.kernel.org>
 <Z_VdlGVJjdtQuIW0@shell.armlinux.org.uk>
 <20250409101808.43d5a17d@kmaincent-XPS-13-7390>
 <Z_YwxYZc7IHkTx_C@shell.armlinux.org.uk>
 <20250409104858.2758e68e@kmaincent-XPS-13-7390>
 <Z_ZlDLzvu_Y2JWM8@shell.armlinux.org.uk>
 <20250409143820.51078d31@kmaincent-XPS-13-7390>
 <Z_Z3lchknUpZS1UP@shell.armlinux.org.uk>
 <20250409180414.19e535e5@kmaincent-XPS-13-7390>
 <Z_avqyOX2bi44sO9@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_avqyOX2bi44sO9@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Apr 09, 2025 at 06:34:35PM +0100, Russell King (Oracle) wrote:
> On Wed, Apr 09, 2025 at 06:04:14PM +0200, Kory Maincent wrote:
> > On Wed, 9 Apr 2025 14:35:17 +0100
> > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> > 
> > > On Wed, Apr 09, 2025 at 02:38:20PM +0200, Kory Maincent wrote:
> > > > Ok, thanks for the tests and these information.
> > > > Did you run ptp4l with this patch applied and did you switch to Marvell PHY
> > > > PTP source?  
> > > 
> > > This was using mvpp2, but I have my original patch as part of my kernel
> > > rather than your patch.
> > 
> > So you are only testing the mvpp2 PTP. It seems there is something broken with
> > it. I don't think it is related to my work.
> 
> Yes, and it has worked - but probably was never tested with PTPDv2 but
> with linuxptp. As it was more than five years ago when I worked on this
> stuff, I just can't remember the full details of the test setup I used.
> 
> I think the reason I gave up running PTP on my network is the problems
> that having the NIC bound into a Linux bridge essentially means that
> you can't participate in PTP on that machine. That basically means a
> VM host machine using a bridge device for the guests can't use PTP
> to time sync itself.
> 
> Well, it looks like the PHY based timestamping also isn't working -
> ptp4l says its failing to timestamp transmitted packets, but having
> added debug, the driver _is_ timestamping them, so the timestamps
> are getting lost somewhere in the networking layer, or are too late
> for ptp4l, which only waits 1ms, and the schedule_delayed_work(, 2) 
> will be about 20ms at HZ=100. Increasing the wait in ptp4l to 100ms
> still doesn't appear to get a timestamp. According to the timestamps
> on the debug messages, it's only taking 10ms to return the timestamp.
> 
> So, at the moment, ptp looks entirely non-functional. Or the userspace
> tools are broken.

Right, got to the bottom of it at last. I hate linuxptp / ptp4l. The
idea that one looks at the source, sees this:

                res = poll(&pfd, 1, sk_tx_timeout);
                if (res < 1) {
                        pr_err(res ? "poll for tx timestamp failed: %m" :
                                     "timed out while polling for tx timestamp");
                        pr_err("increasing tx_timestamp_timeout may correct "
                               "this issue, but it is likely caused by a driver bug");

finds this in the same file:

int sk_tx_timeout = 1;

So it seemed obvious and logical that increasing that initialiser would
increase the _default_ timeout... but no, that's not the case, because,
ptp4l.c does:

        sk_tx_timeout = config_get_int(cfg, NULL, "tx_timestamp_timeout");

unconditionally, and config.c has a table of config options along with
their defaults... meaning that initialiser above for sk_tx_timeout
means absolutely nothing, and one _has_ to use a config file.

With that fixed, ptp4l's output looks very similar to that with mvpp2 -
which doesn't inspire much confidence that the ptp stack is operating
properly with the offset and frequency varying all over the place, and
the "delay timeout" messages spamming frequently. I'm also getting
ptp4l going into fault mode - so PHY PTP is proving to be way more
unreliable than mvpp2 PTP. :(

Now, the one thing I can't get rid of is the receive timestamp
overflow warning - this occurs whenever e.g. ptp4l is restarted,
and is caused by there being no notification that PTP isn't being
used anymore.

Consequently, we end up with the PHY queuing a timestamp for a Sync
packet which it sees on the network, but because nothing is wanting
the packets (because e.g. ptp4l has been stopped) there's no packets
queued into the receive queue to take this timestamp, so we stop
polling the PHY for timestamps.

If we continue to rapidly poll the PHY, then we could needlessly
waste cycles - because nothing tells us "we have no one wanting
hardware timestamps anymore" which seems to be a glaring hole in
the PTP design.

Not setting DISTSOVERWRITE seems like a solution, but that seems to
lead to issues with timestamps being lost.

Well, having spent much of the afternoon and all evening on this,
and all I see are problems that don't seem to have solutions.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

