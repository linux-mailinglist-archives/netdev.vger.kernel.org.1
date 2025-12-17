Return-Path: <netdev+bounces-245163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC50CC8065
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 14:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A16D8303BE02
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 13:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590B4365A11;
	Wed, 17 Dec 2025 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlhPYpHC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3090D34250F;
	Wed, 17 Dec 2025 13:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979723; cv=none; b=apJwPVoRlC/XmTiD5TlnPzQgU3XvvoffZIV1e/9/J2/B8lbN+e8Y2Y2EwK0uCykNG9+91ghFPfj5d6HSkKndBwJskSta1Nwtegr3tqzKt44Y63eATZGoxz1f2pFgEWaiKJ0o0uzFVqHMl5uhn2Hx4pQAGqBy/czupL7xrcgYr1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979723; c=relaxed/simple;
	bh=vT6egwuI4Cc5d2XvlcIagInwQwb0kaKT90ElEJDpNR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pzq92KOkWNztKxCmi9AJ+RuuqwG8M1GDQf/u6jw4l23XpGc1P6b1iB7YD+aQdMpi39Vu1flHUV5ozfPMjmGyquVJkEhbbp3vy0qIKWekR2b1T92zRAbq8ARK3aolnDAp5YXcQ1e7qJJIbHZlX5TpDmMw7yWX12IAmd3eccpVTuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlhPYpHC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822E8C19421;
	Wed, 17 Dec 2025 13:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765979722;
	bh=vT6egwuI4Cc5d2XvlcIagInwQwb0kaKT90ElEJDpNR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JlhPYpHCL+OfMgSLCQ2hDqIb/19NUp3/4sZksaXJwJJ2Ju3ljNgruacS98Rc/gc7Q
	 zyZCIefC9y6I3bmAoyVFBxC94Ig1sMBQobwraZ1mqIPI0vTfb/HPfjVsY/ebknQ1Hw
	 n0AU9hOH+7n5u48PV3PKFZMFROWMyWi/a061w1zX2+6dTUc09snFsKlxljY4YUPBmw
	 XejOHWziz0YyGik8t0msmeCUJeqsZxDbLLfNuG/FIE6P8L4h9kweMeRDY12BQ4v/+9
	 LS5AMXvyTQJ6MwWt4Stn5LSwEkslec0OxKnnEMNugxTt255h1MOXayU2EJeJ1avmo0
	 cMWpa1/RvErqg==
Date: Wed, 17 Dec 2025 07:55:19 -0600
From: Rob Herring <robh@kernel.org>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	geert+renesas@glider.be, ben.dooks@codethink.co.uk,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, francesco.dolcini@toradex.com,
	rafael.beims@toradex.com,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH net-next v1 2/3] dt-bindings: net: micrel: Add
 keep-preamble-before-sfd
Message-ID: <20251217135519.GA767145-robh@kernel.org>
References: <20251212084657.29239-1-eichest@gmail.com>
 <20251212084657.29239-3-eichest@gmail.com>
 <20251215140330.GA2360845-robh@kernel.org>
 <aUJ-3v-OO0YYbEtu@eichest-laptop>
 <aUKgP4Hi-8tP9eaK@eichest-laptop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUKgP4Hi-8tP9eaK@eichest-laptop>

On Wed, Dec 17, 2025 at 01:21:19PM +0100, Stefan Eichenberger wrote:
> On Wed, Dec 17, 2025 at 10:58:54AM +0100, Stefan Eichenberger wrote:
> > On Mon, Dec 15, 2025 at 08:03:30AM -0600, Rob Herring wrote:
> > > On Fri, Dec 12, 2025 at 09:46:17AM +0100, Stefan Eichenberger wrote:
> > > > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > > > 
> > > > Add a property to activate a Micrel PHY feature that keeps the preamble
> > > > enabled before the SFD (Start Frame Delimiter) is transmitted.
> > > > 
> > > > This allows to workaround broken Ethernet controllers as found on the
> > > > NXP i.MX8MP. Specifically, errata ERR050694 that states:
> > > > ENET_QOS: MAC incorrectly discards the received packets when Preamble
> > > > Byte does not precede SFD or SMD.
> > > 
> > > It doesn't really work right if you have to change the DT to work-around 
> > > a quirk in the kernel. You should have all the information needed 
> > > already in the DT. The compatible string for the i.MX8MP ethernet 
> > > controller is not sufficient? 
> > 
> > Is doing something like this acceptable in a phy driver?
> > if (of_machine_is_compatible("fsl,imx8mp")) {
> > ...
> > }
> > 
> > That would be a different option, rather than having to add a new DT
> > property. Unfortunately, the workaround affects the PHY rather than the
> > MAC driver. This is why we considered adding a DT property.
> 
> Francesco made a good point about this. The i.MX8MP has two MACs, but
> only one of them is affected. Therefore, checking the machine's
> compatible string would not be correct. As far as I know, checking the
> MAC's compatible string from within the PHY driver is also not good
> practice, is it?

It's not great, but probably what you need to do. The 2 MACs are the 
same (compatible) or different? As that only works if they are 
different. I suppose you need to only check the MAC the PHY is connected 
to.

I think the ideal implementation would be the MAC driver calling some 
phy API to apply the quirk, and then that gets passed on to the phy 
driver. Surely this isn't the first case of a MAC-PHY combination 
needing to go fiddle with some special setting.

Rob

