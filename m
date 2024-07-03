Return-Path: <netdev+bounces-108759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8304692543E
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 08:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05EFEB2103B
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 06:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1CB132C3B;
	Wed,  3 Jul 2024 06:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="I8fKhS/P"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A033C6BA;
	Wed,  3 Jul 2024 06:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719989724; cv=none; b=lL9VGMBLBd0HV6UieAOgvcCERUCxi1c3Cx6pVgWaNdADbaLYfJ96Q5mlqu/ZpqTwuyfpNwXdC0iEuPSz1zDwCRhXbt2NQV5sTE4hi7idBtNS9OqRjL7B8esP7kHopSra+HP4ABwBn1Vk2kXVflgF+ck1Vu3rDzdZD8j0byXEHF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719989724; c=relaxed/simple;
	bh=2GfBsRxrZDH/TfdgmHX2/PhCbLhSEw5SNB0zMATiQrs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qFaMowh5SH5mJQdIj/C1HZoquSiFRNwi7S2Hgx1U870nKR/04PQjZYreFdq+wgy3ZRFcvT1qf+EfiIZuz5lmkcrS/zYL8MUJM9W5XKJZIlks2/JwaQt7RNqbSp2FTrSkcnwLY0GSAIQgqi1vIA8qsplSeM7GZm0HF6z9OXzDsgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=I8fKhS/P; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6359BE0005;
	Wed,  3 Jul 2024 06:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719989718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+112STnSmnBq9WUzd+MMzssxIWtDa9bVrOCWUEJOUuc=;
	b=I8fKhS/PeXcxlVYKe8GK5xsSrkRKJFif/5MORW6V/qT3DUtUbQ9kbnfUxbs4tbbS/DJzEV
	jPFWvgvEggNfffM640DrSbT0+fBra+dREqbHrZL1s7PhHeOvzA+cbriDYePT27AvLxbCj7
	dqShxFxthmywaX1xvnXswUsV5D+iOhzHLHD4fc3CbgihqrODEomTMVS8TQ03Nls/1YiRaj
	0hIINbX8JRqqt2Vf5TSazRnCf4I2dzk08SaXQP3p58mcqUjzQS6CwkJmhcqtrV03iDnXBk
	NJvtlrNmJCUffYMxJG9sxt14dS+SlK/CtM06Rm/yl5SlDMh8KtQ+/m5ZCjQZcw==
Date: Wed, 3 Jul 2024 08:55:15 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Marek =?UTF-8?B?QmVow7pu?=
 <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, mwojtas@chromium.org, Nathan Chancellor
 <nathan@kernel.org>, Antoine Tenart <atenart@kernel.org>, Marc Kleine-Budde
 <mkl@pengutronix.de>
Subject: Re: [PATCH net-next v14 12/13] net: ethtool: strset: Allow querying
 phy stats by index
Message-ID: <20240703085515.25dab47c@fedora-2.home>
In-Reply-To: <20240702105411.GF598357@kernel.org>
References: <20240701131801.1227740-1-maxime.chevallier@bootlin.com>
	<20240701131801.1227740-13-maxime.chevallier@bootlin.com>
	<20240702105411.GF598357@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Simon,

On Tue, 2 Jul 2024 11:54:11 +0100
Simon Horman <horms@kernel.org> wrote:

> On Mon, Jul 01, 2024 at 03:17:58PM +0200, Maxime Chevallier wrote:
> > The ETH_SS_PHY_STATS command gets PHY statistics. Use the phydev pointer
> > from the ethnl request to allow query phy stats from each PHY on the
> > link.
> > 
> > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > ---
> >  net/ethtool/strset.c | 24 +++++++++++++++++-------
> >  1 file changed, 17 insertions(+), 7 deletions(-)
> > 
> > diff --git a/net/ethtool/strset.c b/net/ethtool/strset.c  
> 
> ...
> 
> > @@ -279,6 +280,8 @@ static int strset_prepare_data(const struct ethnl_req_info *req_base,
> >  	const struct strset_req_info *req_info = STRSET_REQINFO(req_base);
> >  	struct strset_reply_data *data = STRSET_REPDATA(reply_base);
> >  	struct net_device *dev = reply_base->dev;
> > +	struct nlattr **tb = info->attrs;  
> 
> Hi Maxime,
> 
> Elsewhere in this function it is assumed that info may be NULL.
> But here it is dereferenced unconditionally.

Hmm in almst all netlink commands we do dereference the genl_info *info
pointer without checks.

I've looked into net/netlink/genetlink.c to backtrack call-sites and it
looks to be that indeed info can't be NULL (either populated from
genl_start() or genl_family_rcv_msg_doit(). Maybe Jakub can confirm
this ?

If what I say above is correct, I can include a small patch to remove
the un-necessary check that makes smatch think the genl_info pointer can
be NULL.

Thanks for the report,

Maxime

