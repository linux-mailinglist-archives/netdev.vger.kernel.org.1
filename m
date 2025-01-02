Return-Path: <netdev+bounces-154780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 866C39FFC9A
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 18:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 739A13A2444
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 17:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D83F17C98;
	Thu,  2 Jan 2025 17:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Rn5sm3uB"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EB14689
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 17:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735837733; cv=none; b=S51tqSyJ3bGb5kAf4kyYhZ5DiuptgStYhcfeeKr2PXEfoGi6msTafL5HGZD3pWPVpKf1JLaXXYCkNa1OZT60Dj1sF45rIHC+gmuRKxq1TbjovbAYgqnbMkcTacbNBLJkQKTZsjYaTAApERkxiSvaeCtG+bPPPzoYnbN9Pd90vCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735837733; c=relaxed/simple;
	bh=r4nafZgXJvl8zdGmQddyw/kV7BLMkY/18u0XcdlxLJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKiqaVp6Pj0wor/xM8rqw6Mo37Cx0EdkEK09AWY7gVPmVw91T5x+sjtSk6wG6cMe37eifPOCo4JyI/cKc0WuoKiuFjZew40EgNXfsn2O2Be8Hi2yoC/dh0JLDiiajRVG0cZKL2xIJ+SCMdNZdEZ+HYhhPP/+DxTe4jIU2IPRrs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Rn5sm3uB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SNOxilU1AuYKAtiT5IuzrOLxO+/VBRjyvSEIvH9T82I=; b=Rn5sm3uBWlIJL5ck5i0Yoj2jsc
	Oi89LQ1OzFL0LCHa6qSKcMemY5pjdjqotyX0oflDvJONj25NwmZB3qpZr4VGVrXF8oUY7tro9yQnd
	m7zSjvF8EIcanJYfv+gvLwK2YJOXcJN8vb8BhvV28zoOacK6DiO0nHRonNpwt50MISomlhZwZr0El
	RhSG3aOa48WoNY4OFQ01P+gNNDJPjghMYd70kqCMw6B+d/agWPaQ24wc6CqRGKM0JaIbIwEijfgA9
	DXAFq9FoPWCdJUyVxvohWwTxxY6gHWoj+PqKWfa181o12KF4XKEtBIrpmRtIiM7v8OUXRIqXqUUZU
	zlUALHYw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54144)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tTOgd-0002DZ-2C;
	Thu, 02 Jan 2025 17:08:43 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tTOgZ-0000RN-1n;
	Thu, 02 Jan 2025 17:08:39 +0000
Date: Thu, 2 Jan 2025 17:08:39 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
	f.fainelli@gmail.com, olteanv@gmail.com, netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz, pabeni@redhat.com,
	marek.behun@nic.cz
Subject: Re: [PATCH v2 net 3/4] net: dsa: mv88e6xxx: Never force link on
 in-band managed MACs
Message-ID: <Z3bIF7xaXrje79D8@shell.armlinux.org.uk>
References: <20241219123106.730032-1-tobias@waldekranz.com>
 <20241219123106.730032-4-tobias@waldekranz.com>
 <Z3ZrH9yqtvu2-W7f@shell.armlinux.org.uk>
 <87zfk974br.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfk974br.fsf@waldekranz.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jan 02, 2025 at 02:06:32PM +0100, Tobias Waldekranz wrote:
> On tor, jan 02, 2025 at 10:31, "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> > On Thu, Dec 19, 2024 at 01:30:42PM +0100, Tobias Waldekranz wrote:
> >> NOTE: This issue was addressed in the referenced commit, but a
> >> conservative approach was chosen, where only 6095, 6097 and 6185 got
> >> the fix.
> >> 
> >> Before the referenced commit, in the following setup, when the PHY
> >> detected loss of link on the MDI, mv88e6xxx would force the MAC
> >> down. If the MDI-side link was then re-established later on, there was
> >> no longer any MII link over which the PHY could communicate that
> >> information back to the MAC.
> >> 
> >>         .-SGMII/USXGMII
> >>         |
> >> .-----. v .-----.   .--------------.
> >> | MAC +---+ PHY +---+ MDI (Cu/SFP) |
> >> '-----'   '-----'   '--------------'
> >> 
> >> Since this a generic problem on all MACs connected to a SERDES - which
> >> is the only time when in-band-status is used - move all chips to a
> >> common mv88e6xxx_port_sync_link() implementation which avoids forcing
> >> links on _all_ in-band managed ports.
> >> 
> >> Fixes: 4efe76629036 ("net: dsa: mv88e6xxx: Don't force link when using in-band-status")
> >> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> >
> > I'm feeling uneasy about this change.
> >
> > The history of the patch you refer to is - original v1:
> >
> > https://lore.kernel.org/r/20201013021858.20530-2-chris.packham@alliedtelesis.co.nz
> >
> > When v3 was submitted, it was unchanged:
> >
> > https://lore.kernel.org/r/20201020034558.19438-2-chris.packham@alliedtelesis.co.nz
> >
> > Both of these applied the in-band-status thing to all Marvell DSA
> > switches, but as Marek states here:
> >
> > https://lore.kernel.org/r/20201020165115.3ecfd601@nic.cz
> 
> Thanks for that context!
> 
> > doing so breaks last least one Marvell DSA switch (88E6390). Hence why
> > this approach is taken, rather than not forcing the link status on all
> > DSA switches.
> >
> > Your patch appears to be reverting us back to what was effectively in
> > Chris' v1 patch from back then, so I don't think we can accept this
> > change. Sorry.
> 
> Before I abandon this broader fix, maybe you can help me understand
> something:
> 
> If a user explicitly selects `managed = "in-band-status"`, why would we
> ever interpret that as "let's force the MAC's settings according to what
> the PHY says"? Is that not what `managed = "auto"` is for?

You seem confused with that point, somehow confusing the calls to
mac_link_up()/mac_link_down() when using in-band-status with something
that a PHY would indicate. No, that's just wrong.

If using in-band-status, these calls will be made in response to what
the PCS says the link state is, possibly in conjunction with a PHY if
there is a PHY present. Whether the PCS state gets forwarded to the MAC
is hardware specific, and we have at least one DSA switch where this
doesn't appear happen.

Please realise that there are _three_ distinct modules here:

- The MAC
- The PCS
- The PHY or media

and the managed property is about whether in-band signalling is used
from the PCS towards the media, not from the PCS towards the MAC.

So, if the MAC doesn't get updated with the PCS' link state, then
mac_link_up()/mac_link_down() need to do that manually, even if the
link from the PCS towards the media is using in-band signalling.

I think you're confusing in-band-status as meaning that the MAC
gets automatically updated with the PCS media-side link state -
the DT property has no bearing on that.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

