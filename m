Return-Path: <netdev+bounces-181832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBB9A86881
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 23:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB999466BB5
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 21:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C636128541E;
	Fri, 11 Apr 2025 21:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="N8UDUYDd"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889F518C011
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 21:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744408285; cv=none; b=lJPBiXlhuM1FdCO4vhRbOhUyTYNOOJpKV61ossvUDH+2v2PuOmNvurozrKfcepG/eC74BRmDKuXYwLHYyWqdBpYKzxGBHaOEQSY7ZSIhZC2vcrenRZIHF78gF9o4hqY6YzLdvQ8x0waIdkb8ATjcwpJkNLp4GnylwNYI+/53JQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744408285; c=relaxed/simple;
	bh=GjRuJFiaMNYyBrN7ghVphlWVr62Pf44z6Cr2h1v94XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8y5YlxamCrKMoCuJuDNqL/P2Cu2DuwVdbv5SL4ia7MJlAVPQ8TcqhcXvEG1uIRMZRkC8xa5lBhydWWkQHCI+Uu6Ni4ul1WriFbgz1FJHbC5tkCe5JKEwm7XZ9oRJ/+pR20Vr8mwxZHNrNVermBsQ2pT9XTXX6gtl+0meHha+aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=N8UDUYDd; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hlomlVJ41qOBEHjQzg6XyL3tXrr1pmGiKqlgvvgKKUY=; b=N8UDUYDd/6oWQ8IqKZfRFHxBIz
	S99GuBIGvDFSEV44P6ARpRzfUpstrH6B5+kTG2gptuGE3WbeW267w6Ka3rJ8Dz7WP2GRJ8Lq8NJEy
	KNt2PU9N5pykYR0NVm4tHU6KpixPwggOQu5JkgwrkQwQjXsicodDoiAfrmN6pRtjr3nWqCokk7S45
	HnKaY83exWLznpuNBwiKEKlkvTO3ebGCRqsXlL55SU/0o067hax/A4g4vdnWHhH9rPWfcncmSYpsK
	O2VYPdeyhOAhVyjQhWnJvwAhGKyJSZ2tQFaw18PPDm2jVj1mSc2tto0kylCf2/WqXB7K5Uxc38NhY
	NeTWOFpA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37386)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u3MHQ-0003u4-2u;
	Fri, 11 Apr 2025 22:51:20 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u3MHP-0004yR-22;
	Fri, 11 Apr 2025 22:51:19 +0100
Date: Fri, 11 Apr 2025 22:51:19 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org
Subject: Re: [BUG] 6.14: WARNING: CPU: 0 PID: 478 at net/bridge/br_vlan.c:433
 nbp_vlan_flush+0xc0/0xc4
Message-ID: <Z_mO15XmCYj8BIB8@shell.armlinux.org.uk>
References: <Z_lQXNP0s5-IiJzd@shell.armlinux.org.uk>
 <20250411184902.ajifatz3dmx6cqar@skbuf>
 <Z_mAFvJ9w4kn0v_G@shell.armlinux.org.uk>
 <Z/mA27oWj2eSvTTF@shell.armlinux.org.uk>
 <20250411212325.knn3a3id3p7oidug@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411212325.knn3a3id3p7oidug@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Apr 12, 2025 at 12:23:25AM +0300, Vladimir Oltean wrote:
> On Fri, Apr 11, 2025 at 09:51:39PM +0100, Russell King (Oracle) wrote:
> > On Fri, Apr 11, 2025 at 09:48:22PM +0100, Russell King (Oracle) wrote:
> > > On Fri, Apr 11, 2025 at 09:49:02PM +0300, Vladimir Oltean wrote:
> > > > From 508d912b5f6b56c3f588b1bf28d3caed9e30db1b Mon Sep 17 00:00:00 2001
> > > > From: Vladimir Oltean <vladimir.oltean@nxp.com>
> > > > Date: Fri, 11 Apr 2025 21:38:52 +0300
> > > > Subject: [PATCH] net: dsa: mv88e6xxx: fix -ENOENT while deleting user port
> > > >  VLANs
> > > > 
> > > > Russell King reports that on the ZII dev rev B, deleting a bridge VLAN
> > > > from a user port fails with -ENOENT:
> > > > https://lore.kernel.org/netdev/Z_lQXNP0s5-IiJzd@shell.armlinux.org.uk/
> > > > 
> > > > This comes from mv88e6xxx_port_vlan_leave() -> mv88e6xxx_mst_put(),
> > > > which tries to find an MST entry in &chip->msts associated with the SID,
> > > > but fails and returns -ENOENT as such.
> > > > 
> > > > But we know that this chip does not support MST at all, so that is not
> > > > surprising. The question is why does the guard in mv88e6xxx_mst_put()
> > > > not exit early:
> > > > 
> > > > 	if (!sid)
> > > > 		return 0;
> > > > 
> > > > And the answer seems to be simple: the sid comes from vlan.sid which
> > > > supposedly was previously populated by mv88e6xxx_vtu_loadpurge().
> > > > But some chip->info->ops->vtu_loadpurge() implementations do not look at
> > > > vlan.sid at all, for example see mv88e6185_g1_vtu_loadpurge().
> > > 
> > > This paragraph isn't accurate. It's actually:
> > > 
> > > mv88e6xxx_port_vlan_leave()
> > > {
> > > 	struct mv88e6xxx_vtu_entry vlan;
> > > 
> > > 	err = mv88e6xxx_vtu_get(chip, vid, &vlan);
> > > 
> > > and _this_ leaves vlan.sid uninitialised when mv88e6xxx_vtu_get()
> > > ends up calling mv88e6185_g1_vtu_getnext().
> 
> Correct, vtu_getnext() reads the SID and vtu_loadpurge() writes it.
> I got carried away when I found a plausible explanation for the issue,
> and I was in too much of a haste to post it (plus, I had no equipment to
> test).
> 
> > > I posioned to vlan (using 0xde) and then hexdump'd it after this call,
> > > and got:
> > > 
> > > [   50.748068] mv88e6085 mdio_mux-0.4:00: p9 dsa_port_do_vlan_del vid 1
> > > [   50.754802] e0b61b08: 01 00 02 00 de 01 de 03 03 03 03 03 03 03 03 03
> > > [   50.761343] e0b61b18: 00 de de 00 00 00 00 00 00 00 00 00 00 de de de
> > > [   50.767855] mv88e6085 mdio_mux-0.4:00: p9 vid 1 valid 0 (0-10)
> > > [   50.773943] mv88e6085 mdio_mux-0.4:00: p9 !user err=-2
> > > 
> > > Note byte 4, which is the sid, is the poison value.
> > > 
> > > So, should mv88e6xxx_vtu_get(), being the first caller of the iterator,
> > > clear vlan entirely before calling chip->info->ops->vtu_getnext()
> > > rather than just initialising a few fields? Or should
> > > mv88e6185_g1_vtu_getnext() ensure that entry->sid is set to zero?
> > 
> > Or maybe test mv88e6xxx_has_stu() before calling mv88e6xxx_mst_put() ?
> > 
> > If mv88e6xxx_has_stu() is not sufficient, then mv88e6xxx_vlan_msti_set()
> > is another site where mv88e6xxx_vtu_get() is used followed by use of
> > vlan.sid.
> 
> mv88e6xxx_has_stu() is sufficient, the question is whether it is necessary.
> 
> Testing for sid == 0 covers all cases of a non-bridge VLAN or a bridge
> VLAN mapped to the default MSTI. For some chips, SID 0 is valid and
> installed by mv88e6xxx_stu_setup(). A chip which does not support the
> STU would implicitly only support mapping all VLANs to the default MSTI,
> so although SID 0 is not valid, the behavior coincidentally is the same.
> I'm not a huge fan of coincidence, being explicit is more helpful to a
> human reader.
> 
> In my opinion, I would opt for both changes. To be symmetric with
> mv88e6xxx_mst_get() which has mv88e6xxx_has_stu() inside, I would also
> like mv88e6xxx_mst_put() to have mv88e6xxx_has_stu() inside. But that
> means the caller will have to dereference vlan.sid, which means it will
> access uninitialized memory, which is not nice even if it ignores it
> later. So I would also add the memset() in mv88e6xxx_vtu_get(), prior to
> the chip->info->ops->vtu_getnext() call.

That sounds sensible.

Andrew might be able to test next week - I believe he had a ZII dev
rev B platform, which is what I discovered this on.

Unfortunately, the ZII dev rev B platform doesn't lend itself to being
remotely controlled because of the need to disconnect a network cable
each time it boots to ensure DHCP and root-NFS uses the non-switch
port. Also, the barebox boot loader configuration can't be changed as
there's no facility to write updates to non-voltage storage.

To trigger the VLAN issue, I have:

/etc/network/interfaces.d/br0:
auto br0
iface br0 inet manual
        bridge-ports lan0 lan1 lan2 lan3 lan4 lan5 lan6 lan7 optical2
        bridge-maxwait 0

and I boot the board, and then ifdown br0. That's basically it...

For the other issue, I was doing:

# cd /sys/bus/mdio_bus/drivers/mv88e6085
# echo mdio_mux-0.4:00 > unbind

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

