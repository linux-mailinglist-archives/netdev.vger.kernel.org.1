Return-Path: <netdev+bounces-155198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BFDA01707
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 23:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B5F4162583
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 22:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB310161321;
	Sat,  4 Jan 2025 22:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0uHl05AP"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6CA1482E3
	for <netdev@vger.kernel.org>; Sat,  4 Jan 2025 22:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736028618; cv=none; b=pVS5VvHBW2Yd3eVG0XyxJFS3HZUhsETLj8SrC7zY31TIBrEDn+IE1Dk5AvnrdNyE0nWwgsNE06Eyps01vkMxW+edmR8sgNBKtMhA23ZL6RB6U2dL37pgoqbH5/y4htcpAWMPAChjJfG4JvEwi0GVgu7ItPFnaYdUnelqvllOdxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736028618; c=relaxed/simple;
	bh=Jf2R+SQo4B3l8Fj+a/QscG50KA78bl1NMq8pyLkwQeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRemurfGfsJ+J/gYRpYoOzAKbbq8iZlanAXlm5A4r8gweSL4fxoD42pYhdrPO4pbKacdsCU1dCLBMKxju6gIHZfnV8CVrG9kRsYy0Azx1jDJLH+9ZZGMr9EAoiTYj0VMhjG+61yVTNWcMIf8k4wY4nZkXYq8YXNpSmeOav5IWn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0uHl05AP; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tMNRRy+7DcPDzF9ETGLfwyLlclQY2HEKqxaCE8E7afk=; b=0uHl05AP7DGkTcNCoK1DmCvoIx
	W4DgUt+10eeWCLhtB2cGMODCsF4EuNgn79HYa3aT8eJFst1kL0Pj80f0AVPi5UCtNxDCFSEQ6gZ9A
	KBzfTs86rmjeil1rVm/prJKXB1Lsi2EtN7JDBgUAZFVE/b+0S1v05Dh3gtFMOKVhbUZt/TS7iSbY9
	nSyiIGnmIZsxPdJLCrVNWI2n9gPENQq4PROFrRlFyIYQQf7AVaNDZJSZilBuJxLEtks7pU8dQvqkR
	1TTTjJ4UzlyLPj4oGqXRnUAf9OuOyMo2Rx4P7d0+OS+eSxJ/3eSoceCo7303joO+2vx41vGW8JBUc
	R0U8PiuQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57172)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tUCLG-0004Ir-2x;
	Sat, 04 Jan 2025 22:09:58 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tUCLA-0002el-2N;
	Sat, 04 Jan 2025 22:09:52 +0000
Date: Sat, 4 Jan 2025 22:09:52 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
	f.fainelli@gmail.com, olteanv@gmail.com, netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz, pabeni@redhat.com,
	marek.behun@nic.cz
Subject: Re: [PATCH v2 net 3/4] net: dsa: mv88e6xxx: Never force link on
 in-band managed MACs
Message-ID: <Z3mxsEziH_ylpCD_@shell.armlinux.org.uk>
References: <20241219123106.730032-1-tobias@waldekranz.com>
 <20241219123106.730032-4-tobias@waldekranz.com>
 <Z3ZrH9yqtvu2-W7f@shell.armlinux.org.uk>
 <87zfk974br.fsf@waldekranz.com>
 <Z3bIF7xaXrje79D8@shell.armlinux.org.uk>
 <87pll26z2b.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pll26z2b.fsf@waldekranz.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Jan 04, 2025 at 10:37:00PM +0100, Tobias Waldekranz wrote:
> On tor, jan 02, 2025 at 17:08, "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> > On Thu, Jan 02, 2025 at 02:06:32PM +0100, Tobias Waldekranz wrote:
> >> On tor, jan 02, 2025 at 10:31, "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> >> > On Thu, Dec 19, 2024 at 01:30:42PM +0100, Tobias Waldekranz wrote:
> >> >> NOTE: This issue was addressed in the referenced commit, but a
> >> >> conservative approach was chosen, where only 6095, 6097 and 6185 got
> >> >> the fix.
> >> >> 
> >> >> Before the referenced commit, in the following setup, when the PHY
> >> >> detected loss of link on the MDI, mv88e6xxx would force the MAC
> >> >> down. If the MDI-side link was then re-established later on, there was
> >> >> no longer any MII link over which the PHY could communicate that
> >> >> information back to the MAC.
> >> >> 
> >> >>         .-SGMII/USXGMII
> >> >>         |
> >> >> .-----. v .-----.   .--------------.
> >> >> | MAC +---+ PHY +---+ MDI (Cu/SFP) |
> >> >> '-----'   '-----'   '--------------'
> >> >> 
> >> >> Since this a generic problem on all MACs connected to a SERDES - which
> >> >> is the only time when in-band-status is used - move all chips to a
> >> >> common mv88e6xxx_port_sync_link() implementation which avoids forcing
> >> >> links on _all_ in-band managed ports.
> >> >> 
> >> >> Fixes: 4efe76629036 ("net: dsa: mv88e6xxx: Don't force link when using in-band-status")
> >> >> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> >> >
> >> > I'm feeling uneasy about this change.
> >> >
> >> > The history of the patch you refer to is - original v1:
> >> >
> >> > https://lore.kernel.org/r/20201013021858.20530-2-chris.packham@alliedtelesis.co.nz
> >> >
> >> > When v3 was submitted, it was unchanged:
> >> >
> >> > https://lore.kernel.org/r/20201020034558.19438-2-chris.packham@alliedtelesis.co.nz
> >> >
> >> > Both of these applied the in-band-status thing to all Marvell DSA
> >> > switches, but as Marek states here:
> >> >
> >> > https://lore.kernel.org/r/20201020165115.3ecfd601@nic.cz
> >> 
> >> Thanks for that context!
> >> 
> >> > doing so breaks last least one Marvell DSA switch (88E6390). Hence why
> >> > this approach is taken, rather than not forcing the link status on all
> >> > DSA switches.
> >> >
> >> > Your patch appears to be reverting us back to what was effectively in
> >> > Chris' v1 patch from back then, so I don't think we can accept this
> >> > change. Sorry.
> >> 
> >> Before I abandon this broader fix, maybe you can help me understand
> >> something:
> >> 
> >> If a user explicitly selects `managed = "in-band-status"`, why would we
> >> ever interpret that as "let's force the MAC's settings according to what
> >> the PHY says"? Is that not what `managed = "auto"` is for?
> >
> > You seem confused with that point, somehow confusing the calls to
> > mac_link_up()/mac_link_down() when using in-band-status with something
> > that a PHY would indicate. No, that's just wrong.
> >
> > If using in-band-status, these calls will be made in response to what
> > the PCS says the link state is, possibly in conjunction with a PHY if
> > there is a PHY present. Whether the PCS state gets forwarded to the MAC
> > is hardware specific, and we have at least one DSA switch where this
> > doesn't appear happen.
> >
> > Please realise that there are _three_ distinct modules here:
> >
> > - The MAC
> > - The PCS
> > - The PHY or media
> 
> Right, I sloppily used "PHY" to refer to the link partner on the other
> end of the SERDES.  I realize that the remote PCS does not have to
> reside within a PHY.

Sigh, it seems I'm not making myself clear.

Host system:

  ---------------------------+
    NIC (or DSA switch port) |
     +-------+    +-------+  |
     |       |    |       |  |
     |  MAC  <---->  PCS  <-----------------------> PHY, SFP or media
     |       |    |       |  |     ^
     +-------+    +-------+  |     |
                             |   phy interface type
  ---------------------------+   also in-band signalling
                                 which managed = "in-band-status"
				 applies to

> E.g. what does it mean to have an SGMII link where in-band signaling is
> not used?  Is that not part of what defines SGMII?

There _are_ PHYs out there that implement Cisco SGMII (which is IEEE
802.3 1000BASE-X modified to allow signalling at 10M and 100M speeds by
symbol replication, and changing the format of the 1000BASE-X to provide
the details of the SGMII link speed and duplex) but do _not_ support
that in-band signalling.

The point of SGMII without in-band signalling rather than just using
1000BASE-X without in-band signalling is that SGMII can operate at
10M and 100M, whereas 1000BASE-X can not.

The usual situation, however, is that most devices that support Cisco
SGMII also allow the in-band signalling to be configured to be used or
not used.


Going back to the diagram above, the link between the MAC and PCS is
_not_ described in DT currently, not by the managed property not by
the phy-modes etc properties.

Now, the port configuration register on the Marvell switches controls
the MAC settings. The PCS has a separate register set (normally
referred to as serdes in Marvell's Switch terminology) which is an
IEEE compliant clause 22 register layout.

The problem is, it seems *some* Marvell switches automatically forward
the PCS status to the MAC. Other switches do not. The DT "managed"
property does not describe this - because - as stated above - the
"managed" property applies to the link between the PCS and external
world (which may be a PHY, or may be media) and _not_ between the
MAC and its associated PCS.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

