Return-Path: <netdev+bounces-156860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8948A0809F
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 20:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26F773A7757
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 19:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8603D1F9428;
	Thu,  9 Jan 2025 19:37:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30C31991A1
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 19:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736451431; cv=none; b=fGQkiSgBv2xlbtlW05PStPNIevw96U8OE6wmvXIH9sl++SmUV741cFCVJFuJWCETxfBYmpO+5+qw5ph7CtZ/JIIorZssuukpkiRmCqCLJFkAHOOWd2kyZpCrN0sYzxkINL+IDFWDIbXk2P5im1YiInhbSvJBL1uK3yN6zBs+0s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736451431; c=relaxed/simple;
	bh=Qf8XfNVHTpPcGsnSZqkhkIDT1FUy7hXEfZzgL5AqJ/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/XH08+2z9A3TZGckuPWslLPt82+kSDcunB4E55FmkfrmnBtxbp0Uyaqsfed16qdpT7uZcLX4eCfRTbm13+y91KiQ1JkuTXEJtvDeoo5ZLfI9qDIYPPvkUOcVnBzGdECyYCD8g7BaTSFS+hdkJzpi8/ZVfE/Hxtbb7V/oaOTi2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tVyKw-0004f3-1A; Thu, 09 Jan 2025 20:36:58 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tVyKu-0002IE-2L;
	Thu, 09 Jan 2025 20:36:56 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tVyKu-0004oP-21;
	Thu, 09 Jan 2025 20:36:56 +0100
Date: Thu, 9 Jan 2025 20:36:56 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 7/7] net: usb: lan78xx: Enable EEE support
 with phylink integration
Message-ID: <Z4AlWODqb4IZcWyh@pengutronix.de>
References: <20250108121341.2689130-1-o.rempel@pengutronix.de>
 <20250108121341.2689130-8-o.rempel@pengutronix.de>
 <Z35z6ZHspfSZK4U7@shell.armlinux.org.uk>
 <Z36KacKBd2WaOxfW@pengutronix.de>
 <Z36WqNGpWWkHTjUE@shell.armlinux.org.uk>
 <Z4ADpj0DlqBRUEK-@pengutronix.de>
 <Z4AG7zvIvQDv3GTn@shell.armlinux.org.uk>
 <Z4AJ4bxLePBbbR2u@pengutronix.de>
 <Z4ARB96M6KDuPvv8@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4ARB96M6KDuPvv8@shell.armlinux.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Thu, Jan 09, 2025 at 06:10:15PM +0000, Russell King (Oracle) wrote:
> On Thu, Jan 09, 2025 at 06:39:45PM +0100, Oleksij Rempel wrote:
> > On Thu, Jan 09, 2025 at 05:27:11PM +0000, Russell King (Oracle) wrote:
> > > On Thu, Jan 09, 2025 at 06:13:10PM +0100, Oleksij Rempel wrote:
> > > > On Wed, Jan 08, 2025 at 03:15:52PM +0000, Russell King (Oracle) wrote:
> > > > > On Wed, Jan 08, 2025 at 03:23:37PM +0100, Oleksij Rempel wrote:
> > > > > > Yes, otherwise every MAC driver will need to do it in the
> > > > > > ethtool_set_eee() function.
> > > > > 
> > > > > I've had several solutions, and my latest patch set actually has a
> > > > > mixture of them in there (which is why I'm eager to try and find a way
> > > > > forward on this, so I can fix the patch set):
> > > > > 
> > > > > 1. the original idea to address this in Marvell platforms was to limit
> > > > >    the LPI timer to the maximum representable value in the hardware,
> > > > >    which would be 255us. This ignores that the hardware uses a 1us
> > > > >    tick rate for the timer at 1G speeds, and 10us for 100M speeds.
> > > > >    (So it limits it to 260us, even though the hardware can do 2550us
> > > > >    at 100M speed). This limit was applied by clamping the value passed
> > > > >    in from userspace without erroring out.
> > > > > 
> > > > > 2. another solution was added the mac_validate_tx_lpi() method, and
> > > > >    implementations added _in addition_ to the above, with the idea
> > > > >    of erroring out for values > 255us on Marvell hardware.
> > > > > 
> > > > > 3. another idea was to have mac_enable_tx_lpi() error out if it wasn't
> > > > >    possible to allow e.g. falling back to a software timer (see stmmac
> > > > >    comments below.) Another reason for erroring out applies to Marvell
> > > > >    hardware, where PP2 hardware supports LPI on the GMAC but not the
> > > > >    XGMAC - so it only works at speeds at or below 2.5G. However, that
> > > > >    can be handled via the lpi_capabilities, so I don't think needs to
> > > > >    be a concern.
> > > > > 
> > > > > > The other question is, should we allow absolute maximum values, or sane
> > > > > > maximum? At some point will come the question, why the EEE is even
> > > > > > enabled?
> > > > > 
> > > > > As referenced above, stmmac uses the hardware timer for LPI timeouts up
> > > > > to and including 1048575us (STMMAC_ET_MAX). Beyond that, it uses a
> > > > > normal kernel timer which is:
> > > > > 
> > > > > - disabled (and EEE mode reset) when we have a packet to transmit, or
> > > > >   EEE is disabled
> > > > > - is re-armed when cleaning up from packet transmission (although
> > > > >   it looks like we attempt to immediately enter LPI mode, and would
> > > > >   only wait for the timer if there are more packets to queue... maybe
> > > > >   this is a bug in stmmac's implementation?) or when EEE mode is first
> > > > >   enabled with a LPI timer longer than the above value.
> > > > > 
> > > > > So, should phylink have the capability to switch to a software LPI timer
> > > > > implementation when the LPI timeout value exceeds what the hardware
> > > > > supports?
> > > > 
> > > > No, i'll list my arguments later down.
> > > > 
> > > > > To put it another way, should the stmmac solution to this be
> > > > > made generic?
> > > > 
> > > > May be partially?
> > > > 
> > > > > Note that stmmac has this software timer implementation because not
> > > > > only for the reason I've given above, but also because cores other than
> > > > > GMAC4 that support LPI do not have support for the hardware timer.
> > > > 
> > > > There seems to be a samsung ethernet driver which implements software
> > > > based timer too.
> > > > 
> > > > > > The same is about minimal value, too low value will cause strong speed
> > > > > > degradation. Should we allow set insane minimum, but use sane default
> > > > > > value?
> > > > > 
> > > > > We currently allow zero, and the behaviour of that depends on the
> > > > > hardware. For example, in the last couple of days, it's been reported
> > > > > that stmmac will never enter LPI with a value of zero.
> > > > > 
> > > > > Note that phylib defaults to zero, so imposing a minimum would cause
> > > > > a read-modify-write of the EEE settings without setting the timer to
> > > > > fail.
> > > > >
> > > > > > > Should set_eee() error out?
> > > > > > 
> > > > > > Yes, please.
> > > > > 
> > > > > If we are to convert stmmac, then we need to consider what it's doing
> > > > > (as per the above) and whether that should be generic - and if it isn't
> > > > > what we want in generic code, then how do we allow drivers to do this if
> > > > > they wish.
> > > > 
> > > >    - EEE Advertisement:  
> > > > 
> > > >      Advertising EEE capabilities is entirely dependent on the PHY. Without a
> > > > PHY, these settings cannot be determined or validated, as the PHY defines the
> > > > supported capabilities. Any attempt to configure EEE advertisement without an
> > > > attached PHY should fail immediately with an appropriate error, such as:  "EEE
> > > > advertisement configuration not applied: no PHY available to validate
> > > > capabilities."
> > > 
> > > Sorry, at this point, I give up with phylink managed EEE. What you
> > > detail above is way too much for me to get involved with, and goes
> > > well beyond simply:
> > > 
> > > 1) Fixing the cockup with the phylib-managed EEE that has caused *user*
> > >    *regressions* that we need to resolve.
> > > 
> > > 2) Providing core functionality so that newer implementations can have
> > >    a consistency of behaviour.
> > > 
> > > I have *no* interest in doing a total rewrite of kernel EEE
> > > functionality - that goes well beyond my aims here.
> > >
> > > So I'm afraid that I really lost interest in reading your email, sorry.
> >  
> > Sorry for killing your motivation. I can feel your pain...
> 
> I just don't think it's right to throw a whole new load of problems
> to be solved into the mix when we already have issues in the kernel
> caused by inappropriately merged previous patches.
> 
> Andrew had a large patch set, which added the phylib core code, and
> fixed up many drivers. This was taken by someone else, and only
> Andrew's core phylib code was merged along with the code for their
> driver, thus breaking a heck of a lot of other drivers.
> 
> Either this needs to be fixed, or why don't we just declare that we've
> broken EEE in the kernel, declare that we don't support EEE at all, and
> rip the whole sorry damn thing out and start again from scratch -
> because what you're suggesting is basically changing *everything*
> about EEE support.
> 
> Yes, what we currently do may be sub-optimal, but it's the API that
> we've presented to userspace for a long time.
> 
> I just don't think it's right to decide to pile all these new issues
> on top of the utter crap situation we currently have.
> 
> Oh, lookie... I just looked back in the git history to find the person
> who submitted the subset of Andrew's code was... YOU. YOU broke lots of
> drivers by doing so. Now you're torpedoing attempts to fix them by
> trying to make it more complicated. Sorry, but your opinion has just
> lost all credibility with me given the mess you previously created
> and haven't been bothered to try to fix up. At least *I've* been
> trying to fix you crap.

First, I want to say that I understand your frustration with the current
situation and appreciate the effort you've put into improving EEE.
However, I find the tone of your message inappropriate. Personal and
highly emotional comments make constructive communication much harder.  

While we may not be working as a team, we share a common interest in
improving the Linux kernel. I acknowledge that there have been issues
with some of my patches in the past, and I take responsibility for them.
My goal has always been to contribute meaningful improvements and learn
from any mistakes.  

Let’s focus on the shared goal of making the kernel better. A respectful
and technical discussion will benefit everyone involved and ensure
progress is made.  

Best regards,  
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

