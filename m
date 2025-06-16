Return-Path: <netdev+bounces-197988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B33ADAC53
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 11:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBF1E188BBC7
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 09:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927741FDA;
	Mon, 16 Jun 2025 09:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="L63JiDBO"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23EE1DDC33
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 09:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750067393; cv=none; b=rF5mRpRZEUVe1xBC/oug5FGAbUwYxhkcY4yOSyn3dJcZm8jF10gJ+5epWwYQjhChKNBm+O3oaKge1L395GS9p/7zerCp61bd3oIChzdrzEOf3WcSYxNp6UmxyLTVFqCrhUJaFIjWHHw/BgTj+FAMzgrpakCV/ZVo20Ca8JebJ6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750067393; c=relaxed/simple;
	bh=zPdJ7hP5RJ3sJC1ntSPtfmKw/MM6tkymw4tWQs4ZOE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyS1xAyRAoKIKixDY7NqIi5Y2X9UUPInZQWrHS/VuOGBIrbWTuAVMm0J2FeTnKCR22mKP/cLOxteG8HS5lkWyn0iMMjD1k43Y7wwcf/b7r/pohMoKwjS4yN7FOOB4anQE06sIsain0mzi9INcWXrlgv9EM7bUfgSzMFOtkN+hMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=L63JiDBO; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=z05fUkDWa1ajyCUb62sZzATM48OTZQrruWi99fREf78=; b=L63JiDBOwISLrdfwxbIXV/acyA
	VsbDsKqXpZQFBAIaB24NX4WezvmMVBm1gsCYJ9x97cqpgas5jmFroE3dQsBQxlg+WMi0qun/6HZFG
	I3At+uxeXHiWkJMyrcWh7kxE+QdLYdOkMjgjy8oq0sGAwgL1J9Ft8C6kU6xUMnP+nC2r70lfWImKr
	fK+y9H52rN0+KolsBLt15GZ0c2E2MKRqQt8D51qooLXYSwB/mIksuHzBGXsO+GcrPupb8Kej4QhH5
	MIKqtohd8QL0iF04rt/ckWp5F8/o+6bc1eynHT9rIOPdw1+n4RN5dVeln+Thd37nY1j565H3G8to4
	HUIa1bCQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51744)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uR6TL-0003XG-0f;
	Mon, 16 Jun 2025 10:49:47 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uR6TJ-0004iM-2C;
	Mon, 16 Jun 2025 10:49:45 +0100
Date: Mon, 16 Jun 2025 10:49:45 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org, hkallweit1@gmail.com, davem@davemloft.net,
	pabeni@redhat.com, kuba@kernel.org, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [net-next PATCH 0/6] Add support for 25G, 50G, and 100G to fbnic
Message-ID: <aE_oue0q4QhoYggH@shell.armlinux.org.uk>
References: <174956639588.2686723.10994827055234129182.stgit@ahduyck-xeon-server.home.arpa>
 <20250612094234.GA436744@unreal>
 <daa8bb61-5b6c-49ab-8961-dc17ef2829bf@lunn.ch>
 <20250612173145.GB436744@unreal>
 <52be06d0-ad45-4e8c-9893-628ba8cebccb@lunn.ch>
 <20250613160024.GC436744@unreal>
 <aEyprg21XsgmJoOR@shell.armlinux.org.uk>
 <CAKgT0UdkGK7L6jYWW9iy_RnZV8+FofSGV+HTMvC3-fBtCBoGyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgT0UdkGK7L6jYWW9iy_RnZV8+FofSGV+HTMvC3-fBtCBoGyQ@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Jun 14, 2025 at 09:26:00AM -0700, Alexander Duyck wrote:
> On Fri, Jun 13, 2025 at 3:44 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
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
> >
> > So, let's look into this. According to the proposed code and comments,
> > PHY_INTERFACE_MODE_50GBASER is a single lane for 50G with clause 134
> > FEC.
> >
> > LAUI seems to also be a single lane 50G, no mention about FEC (so one
> > assumes it has none) and the comment states it's an attachment unit
> > interface. It doesn't mention anything else about it.
> >
> > Lastly, we have PHY_INTERFACE_MDOE_100GBASEP, which is again a single
> > lane running at 100G with clause 134 FEC.
> >
> > I assume these are *all* IEEE 802.3 defined protocols, sadly my 2018
> > version of 802.3 doesn't cover them. If they are, then someday, it is
> > probable that someone will want these definitions.
> 
> Yes, they are all 802.3 protocols. The definition for these all start
> with clause 131-140 in the IEEE spec.

Good.

> > Now, looking at the SFP code:
> > - We already have SFF8024_ECC_100GBASE_CR4 which is value 0x0b.
> >   SFF-8024 says that this is "100GBASE-CR4, 25GBASE-CR, CA-25G-L,
> >   50GBASE-CR2 with RS (Clause 91) FEC".
> >
> >   We have a linkmode for 100GBASE-CR4 which we already use, and the
> >   code adds the LAUI interface.
> 
> The LAUI interface is based on the definition in clause 135 of the
> IEEE spec. Basically the spec calls it out as LAUI-2 which is used for
> cases where the FEC is either not present or implemented past the PCS
> PMA.

Please name things as per the 802.3 spec, although "based on" suggests
it isn't strictly to the 802.3 spec... I don't have a recent enough spec
to be able to check yet.

> >   Well, "50GBASE-CR2" is 50GBASE-R over two lanes over a copper cable.
> >   So, this doesn't fit as LAUI is as per the definition above
> >   extracted from the code.
> 
> In the 50G spec LAUI is a 2 lane setup that is running over NRZ, the
> PAM4 variant is 50GAUI and can run over 2 lanes or 1.

I guess what you're saying here is that 802.3 LAUI-2 is NRZ, whereas
your LAUI is PAM4 ? Please nail this down properly, is your LAUI
specific to your implementation, or is it defined by 802.3?

> > - Adding SFF8024_ECC_200GBASE_CR4 which has value 0x40. SFF-8024
> >   says this is "50GBASE-CR, 100GBASE-CR2, 200GBASE-CR4". No other
> >   information, e.g. whether FEC is supported or not.
> 
> Yeah, it makes it about as clear as mud. Especially since they use "R"
> in the naming, but then in the IEEE spec they explain that the
> 100GbaseP is essentially the R form for 2 lanes or less but they
> rename it with "P" to indicate PAM4 instead of NRZ.

So, 100GBASE-R is four lanes, 100GBASE-P is two or one lane using PAM4,
right?

> >   We do have ETHTOOL_LINK_MODE_50000baseCR_Full_BIT, which is added.
> >   This is added with PHY_INTERFACE_MODE_50GBASER
> >
> >   Similar for ETHTOOL_LINK_MODE_100000baseCR2_Full_BIT, but with
> >   PHY_INTERFACE_MDOE_100GBASEP. BASE-P doesn't sound like it's
> >   compatible with BASE-R, but I have no information on this.
> >
> >   Finally, we have ETHTOOL_LINK_MODE_200000baseCR4_Full_BIT which
> >   has not been added.
> 
> I was only adding what I could test. Basically in our case we have the
> CR4 cable that is running 2 links at CR2 based on the division of the
> cable.

Much of these translations are based on documentation rather than
testing, especially for speeds >10G. Adding the faster speeds helps
avoid a stream of patches as people test other modules, unless the
spec is actually wrong.

> > So, it looks to me like some of these additions could be useful one
> > day, but I'm not convinced that their use with SFPs is correct.
> 
> Arguably this isn't SPF, this QSFP which is divisible. For QSFP and
> QSFP+ they didn't do as good a job of explaining it as they did with
> QSFP-DD where the CMIS provides an explanation on how to advertise the
> ability to split up the connection into mulitple links.



> 
> > Now, the next question is whether we have anyone else who could
> > possibly use this.
> >
> > Well, we have the LX2160A SoC in mainline, used on SolidRun boards
> > that are available. These support 25GBASE-R, what could be called
> > 50GBASE-R2 (CAUI-2), and what could be called 100GBASE-R4 (CAUI-4).
> >
> > This is currently as far as my analysis has gone, and I'm starting
> > to fall asleep, so it's time to stop trying to comment further on
> > this right now. Some of what I've written may not be entirely
> > accurate either. I'm unlikely to have time to provide any further
> > comment until after the weekend.
> >
> > However, I think a summary would be... the additions could be useful
> > but currently seem to me wrongly used.
> 
> If needed I can probably drop the 200G QSFP support for now until we
> can get around to actually adding QSFP support instead of just 200G
> support. I am pretty sure only the 50G could be supported by a SFP as
> it would be a single lane setup, I don't know if SFP can support
> multiple lanes anyway.

Electrically, a SFP cage only has a fixed number of pins, and only has
sufficient to support one lane. As such, I'm not sure it makes sense to
add the >1 lane protocols to phylink_sfp_interfaces. I think if we want
to do that, we need to include the number of lanes that the cage has at
the use sites.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

