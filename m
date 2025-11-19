Return-Path: <netdev+bounces-240062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6CCC6FF4D
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 17:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 5FB122FCF5
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 16:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D36329C60;
	Wed, 19 Nov 2025 16:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rOsF1021"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05D636E565;
	Wed, 19 Nov 2025 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568378; cv=none; b=sClw2024i908fmOKoB8Ef6v05FOrCMu8lX127qvONgL8YvHi6e4RhFvwPsmPfHgqwv+adko+QXyIaQDylMZZW2ip+zKPAGpgRuOIhBUvezuE7HYWPpuzjwBm2uxCz+GZfuo9lepTiGcjMQfZvipDs7XJ0QaXOlfZ5Lh8jl6mEyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568378; c=relaxed/simple;
	bh=24Dcce1UVUAVpMKj+dP4kjzWvZwevmROYUFbHq7zowM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGLX+DLwAh/g4FEC1OaG6IWrRZ9GKrD8sGupuwMNtcRsphl0YB9XkBjMRW+UvbvFagd8W0J6FUS9a1bbLtBP/bvER516E5W71nGXx81xJP8coBwPuqoNKgZCUtoRGhLMJWMPOlwVFES9d8J+k1dvyQC26d5vegfA/iYo9Wv9czo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=rOsF1021; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Px0Xg38eGUHqwzUBVJdLah8PpQsrq4TfC5LY5cFQMlM=; b=rOsF1021SaoG7Nw1Hgy8oXc1bK
	ZvXQO2cj7ivTOvaZkvjBlpZeDympoUzyVOa1Lg++4CTA5KXY4+BuwpdoME3FqaUR8B+o0z6Ml5RkZ
	GozOU+jdgOPttzz7PQjbUBVoaVF8HPoGixr/NvPvTv+alVfX8jurIXLdrxYXwV4K3Iw//tpn1Ozz8
	DjT5C+wZ4wpuZyCLfBHIQd/ljwbsPk3i1k5HZ7NPrep/G5UJb5kYHIM2FMdh7vffHP+WXRZS1EoOm
	lDuBXp352I5BKD+AEtfXgYm0nhK4LRkci53YrnMtmA6X2Wf+NvdFo735uJ7Xww0V4LZVnSZvwYsCb
	poVz+FXA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51792)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vLkh4-0000000057K-1HbR;
	Wed, 19 Nov 2025 16:06:06 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vLkh1-000000003Xc-1Uc7;
	Wed, 19 Nov 2025 16:06:03 +0000
Date: Wed, 19 Nov 2025 16:06:03 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Wei Fang <wei.fang@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"eric@nelint.com" <eric@nelint.com>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 net] net: phylink: add missing supported link modes
 for the fixed-link
Message-ID: <aR3q6_CS2A1VH236@shell.armlinux.org.uk>
References: <20251117102943.1862680-1-wei.fang@nxp.com>
 <aRwtEVvzuchzBHAu@shell.armlinux.org.uk>
 <PAXPR04MB8510A92D5185F67DDC8CC32F88D6A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <e7222c87-3e4c-4170-993b-dbf5ba26c462@lunn.ch>
 <aRx8Zh-7MWeY0iJd@shell.armlinux.org.uk>
 <PAXPR04MB8510BA569EB34E26E1A499BB88D7A@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8510BA569EB34E26E1A499BB88D7A@PAXPR04MB8510.eurprd04.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Nov 19, 2025 at 01:22:17AM +0000, Wei Fang wrote:
> > On Tue, Nov 18, 2025 at 03:00:00PM +0100, Andrew Lunn wrote:
> > > > > > Fixes: de7d3f87be3c ("net: phylink: Use phy_caps_lookup for fixed-link
> > > > > > configuration")
> > > > > > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > > > > > Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > > > >
> > > > > NAK. I give up.
> > > > >
> > > >
> > > > Sorry, could you please tell me what the reason is?
> > >
> > > I think Russell is referring to the commit message, and how you only
> > > quoted a little section of his explanation. There is no limit to
> > > commit messages, they don't need to be short. It is actually better if
> > > they are long. So you could use his whole explanation. And then you
> > > don't need the link.
> > 
> > Worse than that. I gave my reviewed-by, which seems to have been a waste
> > of time.
> > 
> 
> I'm sorry, I was in a rush to send out the v3 patch, and I hadn't received
> your Reviewed-by tag at that time, so the tag was not added. When I saw
> that you gave the Review-by in v2, I realized that I could no longer add it
> to v3, so I replied that I had sent v3, hoping that you could resend your
> Reviewed-by tag.
> 
> If you don't mind, I will refine the commit message as Andrew suggested
> and add your Revived-by tag from v2 to v4. I apologize again.

I also question the need to refine the commit message this much. One
of the points of lore.kernel.org is that it provides a stable source
for mailing list archives. We use URLs to that site extensively in
the kernel development process - e.g. it's recommended to use it in
Closes: tags, and to reference discussion from commit messages. If
I look at the number of times lore.kernel.org has been mentioned in
commit messages since 6.17, it comes out at around 5700 to date.
Looking back to 6.16, it's about 13000.

So, lore.kernel.org is already an insanely valuable resource to the
kernel community, and the loss of it would result in a lot of
context being lost.

We have had problems with other sites - lkml.org used to be the
popular site, but that became unreliable and stuff broke. However,
the difference is that lore.kernel.org is maintained by the same
people who look after the rest of the kernel.org infrastructure.

Moreover, using lore.kernel.org is encouraged when one wishes to
link to discussion. See "Linking to list discussions from commits"
at the bottom of https://www.kernel.org/lore.html

So, I think there was no need to go through v3, inflating the commit
message, and end up in this situation.

Every time a patch gets reposted, the netdev cycle (as far as the
netdev maintainers are concerned) restarts, and it means a multi-day
delay before the change gets committed. As things stand, this is
likely to miss tomorrow's linux-net tree submission, which is
highly likely to be the last one before 6.18 is released. So we're
not going to get this fixed before the final 6.18 now. And for
what value? None as far as I can see. The patch was ready at v2.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

