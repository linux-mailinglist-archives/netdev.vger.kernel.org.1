Return-Path: <netdev+bounces-229692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3634BDFD54
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 19:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84B5918958BC
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 17:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29852DFF18;
	Wed, 15 Oct 2025 17:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ESET1QWN"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AAA21B9F5;
	Wed, 15 Oct 2025 17:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760548867; cv=none; b=g4o8SQVzKf6HUDxS/B+WWg4HrB/qKnZWyG7yM1WkfWZB+ax1vx0FAdziIZKEG+x90hZfodDiq6LbSsTDMqcboij+dfBdVu091m9OAsza4FMOu/4OfUNWu/6gtyWusRXhz4ONxbdo3E5PN2UWrHAtQ1Lezn2u++tqicj3U/w7uBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760548867; c=relaxed/simple;
	bh=6yQ2mN4Lteo3bR5j0fbnB+JIR14pL0OnjYwcg0ikrso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8TS1CcrEHBqFlum78df4+EP9ztdg7CmHCUR/r9Wn23R/3IwwLwIs9CA0Q4Rm6WeQtLOHea08knYwsDve6Lw4K6FnfkHJcOeU0i7HFrJNurK2wR76aaSHzLNzAp+t7NoyIk2apmrSk5psHUj33kPJGgwKEozM/uQsbyoZLTmAAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ESET1QWN; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=N6aNZCIcI2zN3R1/BCJoGwM/7sTPHIJJPl1PJ4HpJBE=; b=ESET1QWNsqJm/GD1mJtk4L3OD+
	OXmTrnMQv+PAWuxEh9Ta/Wij7meIB2/sHARKmpQq3g9Kyj5C29OuLWc9niG5RrzQDnlsru6vMVECW
	X2wNF+Ds/0F4bn1vTpVjApZu7e8vEpesWB3e2subPPAFivrKyA2mA7KNcUPleqCl9B7sS7IFRu2C/
	kNaGX59mFWpcqwzYs1XmRjzfucorGGk61pSh9tcapwwY4pmbHvF7US7TwWRrG5wfU35PWTO/thLNf
	iI0AggyCB4fbWGSJAb5HxTvQNz/O0p0GM2+nqTZheEr2O+LzU6YzL7ogAuKmt8S1ki5v5Fd+of3Io
	K5dLpsEg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47568)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v95B7-000000005Fe-34CR;
	Wed, 15 Oct 2025 18:20:45 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v95B2-000000002RJ-3ZAm;
	Wed, 15 Oct 2025 18:20:40 +0100
Date: Wed, 15 Oct 2025 18:20:40 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: stmmac: Move subsecond increment
 configuration in dedicated helper
Message-ID: <aO_X6Hv2R_mgpOXR@shell.armlinux.org.uk>
References: <20251015102725.1297985-1-maxime.chevallier@bootlin.com>
 <20251015102725.1297985-2-maxime.chevallier@bootlin.com>
 <aO-4hnUINpQ0JORE@shell.armlinux.org.uk>
 <27800f8c-eb0d-41c2-9e45-b45cf1767c23@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27800f8c-eb0d-41c2-9e45-b45cf1767c23@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Oct 15, 2025 at 06:20:03PM +0200, Maxime Chevallier wrote:
> Hi Russell,
> 
> On 15/10/2025 17:06, Russell King (Oracle) wrote:
> > On Wed, Oct 15, 2025 at 12:27:21PM +0200, Maxime Chevallier wrote:
> >> +static void stmmac_update_subsecond_increment(struct stmmac_priv *priv)
> >> +{
> >> +	bool xmac = priv->plat->has_gmac4 || priv->plat->has_xgmac;
> > 
> > Just to say that I have patches that get rid of these has_xxx flags for
> > the cores, and these changes (and the additional platform glue patches
> > that have been posted) will conflict with them.
> 
> Fair, I was in your position not so long ago :)
> 
> For this particular series, it should be straightforward to fix the
> conflict, but for the pending new glue divers we'll have to
> find the sweet spot for these changes.
> 
> Maybe send it as an RFC so that people can see what to expect ?

My experience of sending RFCs is the engagement is sadly low to non-
existent, leading to the question of whether sending RFCs has any
use at all. I'm pretty fed up with the whole mainline kernel process,
trying to get engagement from people, that I question why I bother
most of the time.

> > Given the rate of change in stmmac, at some point we're going to have
> > to work out some way of stopping stmmac development to get such an
> > invasive cleanup change merged
> 
> Agreed.
> 
>  - but with my variability and pressures
> > on the time I can spend even submitting patches, I've no idea how that
> > will work... I was going to send them right at the start of this
> > cycle, but various appointments on Monday and Tuesday this week plus
> > work pressures prevented that happening.
> 
> To give your more visibility, that's the only work I plan to do on
> stmmac for that cycle, the rest is going to be phy_port,
> and probably some netdevsim-phy.

I'd prefer that my five patch series I've just sent out is merged
(the patches I'm talking about w.r.t. has_xxx follow immediately
after these in my queue.) However, I don't think there's any
conflicts between the five I've sent out and these changes looking
at their overall diffs. That said, pushing out loads of patches in
one day isn't helpful to the already overworked reviewers.

> Do you plan to send the next round of PCS stuff next, or the cleanups
> for the has_xxx flags you were mentioning ?

It depends whether there's any conflicting changes. I have such a
backlog that I'm trying to send out as many non-conflicting netdev
related topics as I can to get the maximum merged when I have the
opportunity, even if the topics end up touching the same files.
I just totalled up the backlog - it's around 120 stmmac related
patches (including adding the phylink core WoL support), plus about
20 for marvell PTP. Eek! :/

When one has so many patches, "what to send out next" becomes a major
decision, and really depends on previous patch set progress.

As you explicitly ask about the PCS stuff and cleanups, I've sent
the first batch (which is the bulk) of PCS stuff today, and non-
overlapping cleanup changes.  If the cleanup changes go in, then
the next tranch of cleanups will have the has_xxx change in.

If the PCS changes go in, then I'll send out the next two patches
which move the PCS interrupt control over to phylink. After that
comes the potentially regression inducing change - making stmmac's
PCS follow what phylink requests of it. I'm expecting that to cause
trouble, but I have no confidence that it'll get enough testing to
uncover issues before being merged. This change really needs testing
on those platforms that use the DWMAC integrated PCS (not xpcs).

If all goes well with the patches I've sent today, then I'm expecting
them to be merged over this coming weekend. That means the next patches
will be sent early next week.

So... if your changes can be merged before or around the time that my
5-patch cleanup gets merged, I can rebase my changes on top, but if
your patch set needs re-posting, I suggest we have another discussion
how we proceed.

As mentioned, I'm aware that there are other patches that have already
been submitted that add platform glue that reference the has_xxx stuff,
so if these get merged, a rebase is going to be required. (annoyingly,
this will be high-risk because of getting the compile coverage to
catch every reference.. unless I remember to grep for them after
rebasing.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

