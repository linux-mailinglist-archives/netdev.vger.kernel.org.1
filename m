Return-Path: <netdev+bounces-108543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D93ED9241E6
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 17:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1855F1C23184
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 15:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBBA1BB6A5;
	Tue,  2 Jul 2024 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="daYvFN/A"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951721BB69D
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719932915; cv=none; b=ahPG7t5CLxEvvqnTNlFa62WhF8IeiqZ3Lw8FCN6o03erec+u9MWCmXYxchFvqnRnBLd4wWg1vA2mP3FVg0LA00P7lzNZnstWEA3AncvLsrAp10MQvMMfM+W9MIuuWsLpLbPTauFYD4ADMLS2RPrgR9fhVyRp9EAbVwd0lsu62qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719932915; c=relaxed/simple;
	bh=dSS1zIc1qSp1uRhiYbfZ+AGvPvKSTo9TuaXhasfCU3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCxR3j1lifboJmsq30wRYF3xQqySZ+IcniU7Vhd5NsBlf02eCRJ/+a/8bTZyPeMgBe8iJle/nvqV056YnnkjmlkO821fphoZxfaH6igcOEJQL4pCtV0u1t0Y0/dcbQK87ZIloB3j3YjCgS23fyhhZ+4B5SdF9hXRNg/rSoq3wbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=daYvFN/A; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=D+9yhrsZmNEfs2IwUZXXPwRLvQq0OzgW+8UWPEQbnGM=; b=daYvFN/ANjmODCHFJFy1x/pe+e
	Ra6eSrhAwdy7EO/i6jWXcN6pwTsuJXrRb7uX4EDJIUX1slsCkVv+ezzeUu7gT1upKmNPgejeau3f+
	2feikN7GxCkagL9KX3RIoxvsxtcVl0Q0bos0GBvbzh3jbQ3HPMRAohpNrRtcHFUytubX9ejwo8oW5
	Ngip7gEn6YbzGcrZhWrh9HNH/jppA82ERT0AZQgPKfQLLu8dGZEiAUannrNbcvZ3mNOAVAk2z7ob9
	lPCCvV1b0HSnKQSvhielUIsmBx26KSIQopFTwiwbm10/4vq6RWf+8aCVOxsGgknnvaFzkVm2CkyOA
	knF5TV2w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39552)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sOf6z-00041A-2r;
	Tue, 02 Jul 2024 16:08:05 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sOf6z-00021O-NW; Tue, 02 Jul 2024 16:08:05 +0100
Date: Tue, 2 Jul 2024 16:08:05 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>, andrew@lunn.ch
Cc: si.yanteng@linux.dev, Huacai Chen <chenhuacai@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>, hkallweit1@gmail.com,
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, Jose.Abreu@synopsys.com,
	guyinggang@loongson.cn, netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v13 12/15] net: stmmac: Fixed failure to set
 network speed to 1000.
Message-ID: <ZoQX1bqtJI2Zd9qH@shell.armlinux.org.uk>
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <e7ae2409f68a2f953ba7c823e248de7d67dfd4e9.1716973237.git.siyanteng@loongson.cn>
 <CAAhV-H6ZJwWQOhAPmoaH4KYr66LCurKq94f87FQ05yEX6XYoNg@mail.gmail.com>
 <ZlgpLm3L6EdFO60f@shell.armlinux.org.uk>
 <6ba14d835ff12f479eeced585b9336c1e6219d54@linux.dev>
 <gndedhwq6q6ou56nxnld6irkv4curb7mql4sy2i4wx5qnqksoh@6kpyuozs656l>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <gndedhwq6q6ou56nxnld6irkv4curb7mql4sy2i4wx5qnqksoh@6kpyuozs656l>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jul 02, 2024 at 01:31:44PM +0300, Serge Semin wrote:
> On Tue, Jun 04, 2024 at 11:29:43AM +0000, si.yanteng@linux.dev wrote:
> > 2024年5月30日 15:22, "Russell King (Oracle)" <linux@armlinux.org.uk> 写到:
> > 
> > Hi, Russell, Serge,
> > 
> > > I would like this patch to be held off until more thought can be put
> > > 
> > > into how to handle this without having a hack in the driver (stmmac
> > > 
> > > has too many hacks and we're going to have to start saying no to
> > > 
> > > these.)
> > Yeah, you have a point there, but I would also like to hear Serge's opinion.
> 
> I would be really glad not to have so many hacks in the STMMAC driver.
> It would have been awesome if we are able to find a solution without
> introducing one more quirk in the common driver code.
> 
> I started digging into this sometime ago, but failed to come up with
> any decent hypothesis about the problem nature. One of the glimpse
> idea was that the loongson_gnet_fix_speed() method code might be somehow
> connected with the problem. But I didn't have much time to go further
> than that.
> 
> Anyway I guess we'll need to have at least two more patchset
> re-spins to settle all the found issues. Until then we can keep
> discussing the problem Yanteng experience on his device. Russell, do
> you have any suggestion of what info Yanteng should provide to better
> understand the problem and get closer to it' cause?

First question: is auto-negotiation required by 802.3 for 1000base-T?
By "required" I mean "required to be used" not "required to be
implemented". This is an important distinction, and 802.3 tends to be
a bit wooly about the exact meaning. However, I think on balance the
conclusion is that AN is mandatory _to be used_ for 1000base-T links.

Annex 40C's state diagrams seems to imply that mr_autoneg_enable
(BMCR AN ENABLE) doesn't affect whether or not the AN state machines
work for 1000base-T, and some PHY datasheets (e.g. Marvell Alaska)
state that disabling mr_autoneg_enable leaves AN enabled but forced
to 1G full duplex.

So, I'm thinking is that the ethtool interface should reject any
request where we have a PHY supporting *only* base-T for gigabit
speeds, where the user is requesting !AN && SPEED_1000 on the basis
that AN is part of the link setup of 1000base-T links.

Maybe this should be a property of the struct phy_device so we can
transition phylib and phylink to return an appropriate error to
userspace?

Alternatively, maybe just implement the Marvell Alaska solution
to this problem (if the user attempts to disable AN on a PHY
supporting only base-T at gigabit speeds, then we silently force
AN with SPEED_1000 and DUPLEX_FULL.

Andrew - seems to be an IEEE 802.3 requirement that's been missed
in phylib, any thoughts?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

