Return-Path: <netdev+bounces-198034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CD4ADAEB1
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 13:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BADD9171A6A
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 11:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191F02882CF;
	Mon, 16 Jun 2025 11:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="oFgA/nPD"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8280A261570
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 11:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750073735; cv=none; b=oO9lj9KXbj2PADRwwwwBLS53TALLC43bZNsCAMTgdIPsqDx3PuyJZ6eXc4WviyN9yafwvakjpVwaqGQQ4BF/skhWylEk2cBNHjZVJolNN+3cSSh0MK6/b1roVjACDZLhiAHXbN3CANJUwn1nvZ96iwJdNr9zjE3VDS2jRgZ7yyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750073735; c=relaxed/simple;
	bh=akl3IlI9UMKzKKG3JOItEuA8hoFlYBRVTz8FmhpdsNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/IpGTwEOVW2z7su4+Jgmjdes4vOPgr28kBhMYMbUEasm8KFnpxilCK7IdowiZQhUcfZJnH2HURlqX9QMYMAWh8ldiKKVl8R3hgtnYGCToQHrN2yEv61Y6OxOjx4ml0egfMO6NTJZfDfdoG5HNZp/dpIIguHxc7mUdETfKycLjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=oFgA/nPD; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oQZa/88PMdX6iEYhiaie5K+cdSdmfN52tEhIwM3F5sU=; b=oFgA/nPD4LBR2a6BURGkpFhqNI
	Yry1RoWoDshMvjJP4uVczPOt1FJhfP4F7upATYqS5ZP9IqkaZ+lYR43RWDwhN+x8IE7ToXJS001Zz
	7Dp+FdpQ13fa6F1DUlwlT6UmlKZTMHtAVGHDi0kwyjUhosElEBQErWxmQffm6PgkLvzFn0MyZtDB6
	NooSRtx5VqMxNt/4uzA3ltp+RBNtAvzqzo3T20PyMU5QJrM94l2b04O9vAa/vGRRAwBrmcz9SxwVz
	sW8q+juW4bouFr1yyz3S6flpcR+9k33hXRFQdEvG6EWGB2J+zn31hk1sqcogll4CFWzCQf9gbHXC8
	00bnR/Dg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46730)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uR87b-0003gt-2m;
	Mon, 16 Jun 2025 12:35:27 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uR87Z-0004mo-0p;
	Mon, 16 Jun 2025 12:35:25 +0100
Date: Mon, 16 Jun 2025 12:35:25 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Leon Romanovsky <leon@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org,
	hkallweit1@gmail.com, davem@davemloft.net, pabeni@redhat.com,
	kuba@kernel.org, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [net-next PATCH 0/6] Add support for 25G, 50G, and 100G to fbnic
Message-ID: <aFABfaQywj1GOQiv@shell.armlinux.org.uk>
References: <174956639588.2686723.10994827055234129182.stgit@ahduyck-xeon-server.home.arpa>
 <20250612094234.GA436744@unreal>
 <daa8bb61-5b6c-49ab-8961-dc17ef2829bf@lunn.ch>
 <20250612173145.GB436744@unreal>
 <52be06d0-ad45-4e8c-9893-628ba8cebccb@lunn.ch>
 <20250613160024.GC436744@unreal>
 <aEyprg21XsgmJoOR@shell.armlinux.org.uk>
 <20250616103327.GC750234@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616103327.GC750234@unreal>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jun 16, 2025 at 01:33:27PM +0300, Leon Romanovsky wrote:
> On Fri, Jun 13, 2025 at 11:43:58PM +0100, Russell King (Oracle) wrote:
> > On Fri, Jun 13, 2025 at 07:00:24PM +0300, Leon Romanovsky wrote:
> > > Excellent, like you said, no one needs this code except fbnic, which is
> > > exactly as was agreed - no core in/out API changes special for fbnic.
> > 
> > Rather than getting all religious about this, I'd prefer to ask a
> > different question.
> > 
> > Is it useful to add 50GBASER, LAUI and 100GBASEP PHY interface modes,
> > and would anyone else use them? That's the real question here, and
> > *not* whomever is submitting the patches or who is the first user.
> 
> Right now, the answer is no. There are no available devices in the
> market which implement it.

That's strictly your own opinion, I doubt it's based on facts.

LX2160A supports:
	50GBASE-R/CAUI-2(C2C/C2M) and
	100GBASE-R/CAUI-4(C2C/C2M)
modes. These are two and four lanes respectively. These date from
before clauses were added to IEEE 802.3 for these speeds, and are based
on the 25/50G Specification Rev 1.6.

https://ethernettechnologyconsortium.org/wp-content/uploads/2020/03/25G-50G-Specification-FINAL.pdf

This is 2.0 but the revision list indicates no changes since rev 1.6.

This specification states that 50GBASE-R is based upon 802.3 clause 82
operating at an overall rate of 50Gb/s, each lane operates at 25.78125GHz
with MLD4 bonding. The other references that contain 50GBASE-R are
50GBASE-R2, which indicates that it is two lanes. FEC is optional, and
may be clause 74 or 91. This is what the LX2160A implements, but I
believe without FEC - two lanes operating at this speed. The LX2160A
was initially designed as a TOR SoC.

We now need to compare this to what is being proposed, and what is now
present in 802.3 as referenced by the new modes.

Now, the definition of PHY_INTERFACE_MODE_50GBASER from Meta says that
it's "50GBase-R - with Clause 134 FEC". Let's first dive into clause 134.
This clause states that it is RS-FEC based on clause 91 but with
modifications to support operation for 50G. So this doesn't tie up with
LX2160A.

Next, let's look at PHY_INTERFACE_MODE_LAUI from Meta, and the
clarification is that it's LAUI-2 in IEEE 802.3. Clause 133 defines the
PCS. Clause 135 defines the PMA for 50GBASE-R and refers to LAUI-2 in
annex 135B. From annex 135B, LAUI-2 uses NRZ signalling over two lanes
at 25.78125GBd. This matches what's implemented by the LX2160A.

So there we have it - we have an embedded SoC that implements at least
one of the definitions that Meta have in this patch.

This disagrees with your assertion "There are no available devices in
the market which implement it."

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

