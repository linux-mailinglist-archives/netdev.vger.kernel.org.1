Return-Path: <netdev+bounces-181547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F951A85677
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 10:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40253178328
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 08:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B83293B73;
	Fri, 11 Apr 2025 08:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fSacQ7kd"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EF6293453;
	Fri, 11 Apr 2025 08:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744359939; cv=none; b=lVifaytRtUch8AztcecwrylBfR9Pji75LWm6k0kVHF+ytzh0RYf+kjBKshSpebPmx6SQbEuRCPQPE2iawN+xs93/UiWmPRiOIfjObgwSYCXywchUWbpOhw7ulhO0BvVZcsmiVi5VHarwd06RKM4wWhRAVPhnfJ+dbVVR3Q0+NQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744359939; c=relaxed/simple;
	bh=JwBOToStDNC6eRyq2CWfhIrnJZ8F0nTYN4XNiNbJsRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOTzBAfomUUyn9mE8hetwtJiyLntV0FCgsyTdGjTRoLRF4MQptpzJIaJIV9x+McP0oBZZPjdIDbINOlI7FMu62D27ZH+xvxrnVrKc+GGwBZ1OVthDIqAqwN4HxKnGWibc5WZrWhw0DS+Ff1VxU7M2tpzpmS8ozbA6QarpLnXA2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=fSacQ7kd; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=U6Gj2djXMHC7fr7F/i8dDDB7gZNxDSeRy62dyPGupNQ=; b=fSacQ7kdNYyBInTxoam/Zwjzzx
	rO0GcbnfRSMRDU3lUjnWVeF59PsysoFCfPaG/VJys9wNXquoIa2at/NLiFApKQZWIidvIbTkY40h/
	5q8iJL/OeVHdOe4hCH4O7uIL/CrMFdzQbDbzs7wPMnl8AH1Yt7PEoE9lEQ1OK4K+iWBnTSRInav+W
	TD902aTYACk4ZHBAZXybmS0JCfEyAv2hOQdjjxf342C6J2nK1ol3X8tSaVlagLyhCFT4rHvao5NYi
	gAB26nCpSyteExXlbWmz4z0SEF4t/Ke7sn5LM6WNCQJhFXVWYwQGsI8gj06KlCKGEPlTFGrPcEn9p
	mHuASgEQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36950)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u39hV-00030H-2u;
	Fri, 11 Apr 2025 09:25:26 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u39hT-0004ST-1C;
	Fri, 11 Apr 2025 09:25:23 +0100
Date: Fri, 11 Apr 2025 09:25:23 +0100
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
Message-ID: <Z_jR82l7ZRwvunuH@shell.armlinux.org.uk>
References: <Z_Z3lchknUpZS1UP@shell.armlinux.org.uk>
 <20250409180414.19e535e5@kmaincent-XPS-13-7390>
 <Z_avqyOX2bi44sO9@shell.armlinux.org.uk>
 <Z/b2yKMXNwjqTKy4@shell.armlinux.org.uk>
 <20250410111754.136a5ad1@kmaincent-XPS-13-7390>
 <Z_fmkuPhqMqWBL2M@shell.armlinux.org.uk>
 <20250410180205.455d8488@kmaincent-XPS-13-7390>
 <Z_gLD8XFlyG32D6L@shell.armlinux.org.uk>
 <Z/genHfvbvll09XT@shell.armlinux.org.uk>
 <20250411100127.2d87812f@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411100127.2d87812f@kmaincent-XPS-13-7390>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Apr 11, 2025 at 10:01:27AM +0200, Kory Maincent wrote:
> On Thu, 10 Apr 2025 20:40:12 +0100
> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> 
> > On Thu, Apr 10, 2025 at 07:16:47PM +0100, Russell King (Oracle) wrote:
> > > On Thu, Apr 10, 2025 at 06:02:05PM +0200, Kory Maincent wrote:  
> > > > On Thu, 10 Apr 2025 16:41:06 +0100
> > > > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> 
> > > > It seems you are still using your Marvell PHY drivers without my change.
> > > > PTP L2 was broken on your first patch and I fixed it.
> > > > I have the same result without the -2 which mean ptp4l uses UDP IPV4.  
> > > 
> > > I'm not sure what you're referring to.  
> > 
> > Okay, turns out to be nothing to do with any fixes in my code or not
> > (even though I still don't know what the claimed brokenness you
> > refer to actually was.)
> 
> If I remember well you need the PTP global config 1 register set to 3 to have
> the L2 PTP working.

The PTP global config 1 register determines which message IDs get
timestamped, both for incoming and outgoing messages.

Setting it to 0x3 means that only Sync and Delay_Req messages only
get stamped, irrespective of whether userspace wants to stamp
messages in the transmit path with other message IDs.

With it set to ~0 as I have it, this means all PTP messages are
candidates for being stamped.

As this is a global register, which can be shared between ports (not
for 1510, but may be for other PHYs or DSA), and we have no idea which
messages will need to be stamped, setting it to ~0 is sensible, and
it's also what would be expected of the PTP layers, because we report
back to userspace HWTSTAMP_FILTER_SOME which means "return value: time
stamp all packets requested plus some others" (from the documentation).

I'm currently using 0x0203 (sync, delay_req, delay_resp) and it's
working mostly fine, although I do from time to time see rx overruns
and sometimes tx timestamps missed. I'm trying to fix that before I
post updated patches.

It should be fine with other values too, and should have no effect
whether L2 and L4 are used. DSA sets this to 0x0f, which uses the
same hardware, and I assume is well tested:

        /* MV88E6XXX_PTP_MSG_TYPE is a mask of PTP message types to
         * timestamp. This affects all ports that have timestamping enabled,
         * but the timestamp config is per-port; thus we configure all events
         * here and only support the HWTSTAMP_FILTER_*_EVENT filter types.
         */
        err = mv88e6xxx_ptp_write(chip, MV88E6XXX_PTP_MSGTYPE,
                                  MV88E6XXX_PTP_MSGTYPE_ALL_EVENT);

#define MV88E6XXX_PTP_MSGTYPE_ALL_EVENT         0x000f

with peer delay response messages directed to the second arrival
timestamp registers:

        /* Use ARRIVAL1 for peer delay response messages. */
        err = mv88e6xxx_ptp_write(chip, MV88E6XXX_PTP_TS_ARRIVAL_PTR,
                                  MV88E6XXX_PTP_MSGTYPE_PDLAY_RES);

#define MV88E6XXX_PTP_MSGTYPE_PDLAY_RES         0x0008

Please re-test with other values and report how it doesn't work.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

