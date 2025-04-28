Return-Path: <netdev+bounces-186374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB6BA9EB11
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 10:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970D2188D6D4
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 08:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578C425E833;
	Mon, 28 Apr 2025 08:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cUrsXZFF"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2838EAF1;
	Mon, 28 Apr 2025 08:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745829884; cv=none; b=uM4CX4Ys+9TL2bpmD0P/n4efge7EQiaGLyTJVSvodWhjCVdQPAvoOoXIWEwuJVzUQwSis+xAPa36T2Rcdu+2Ym/yhRAnAk+BV4n84p9rugKpDcZI87LfAzrC1kB2PYE438b+4i3iwf5JGdaMfPCKdSPmA/Uqj0c/QT7itKvMWzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745829884; c=relaxed/simple;
	bh=pH5c54yttcq6j/buwJP6C+joHzGCBJ0SAvSnOS3X9P0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=flsch2Xz0GSVk56RZZ4Dm0hRDSssRGE7XDCzrEvR5jz2QkLlL0LOdK93CRlmxEPXd8IRSb9o54R2Ouq9F+GSoJhrOH3DF+cwoyC4hHBLKrO5iOOIZQLWrAw1HrdIU8GlnsVozVeFbsq1Gg+e4nPrkGbLIZugL1Z45SBy+Kc2Esw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cUrsXZFF; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1C4DE432F7;
	Mon, 28 Apr 2025 08:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745829879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=exze3ueWY+HNg4sMqbZbk5lkw0dlxCK14ZF2dFm2BRU=;
	b=cUrsXZFFd/v0NeT60IbLaHgTaEtrXloAc/FEI1pkezzTfr37o1ION9UL0dU09kyhS9lZg7
	kF3NlmFLd88E6im5ehC+SFkPTJ4N7FAx8gmOzgaQjWZ1I1whHL5LfkvRHolJ5GHdmhADOM
	V4saVye8J3rRi8QPqJP21fIckt7SthtTvxxF7v/h3iGw7N/R5jNBnHwNdRkihDGXe3yiim
	D8JlBfxfmKmqOSSSbQ5pDPfqMVbdnBWIrnjRvWpnvP/TCEpFDcb+MZeViTrsTZRNDciCP3
	E9QTweYL4AEPbrKUqC4qoEqWqKeDva9WueGKRWdcVZXoTeWIf9EP3GdyPH35hA==
Date: Mon, 28 Apr 2025 10:44:34 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Simon Horman <horms@kernel.org>, Romain Gantois
 <romain.gantois@bootlin.com>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>
Subject: Re: [PATCH net-next v7 1/3] net: ethtool: Introduce per-PHY DUMP
 operations
Message-ID: <20250428104434.5d4fab73@device-130.home>
In-Reply-To: <20250425171044.4a9e1b4a@kernel.org>
References: <20250422161717.164440-1-maxime.chevallier@bootlin.com>
	<20250422161717.164440-2-maxime.chevallier@bootlin.com>
	<20250424180333.035ff7d3@kernel.org>
	<20250425090153.170f11bd@device-40.home>
	<20250425171044.4a9e1b4a@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddviedthedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmegvhegsfhemuggtfeelmegvvgejudemudekfeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemvgehsghfmegutgefleemvggvjedumedukeefledphhgvlhhopeguvghvihgtvgdqudeftddrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhto
 hepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

On Fri, 25 Apr 2025 17:10:44 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Fri, 25 Apr 2025 09:01:53 +0200 Maxime Chevallier wrote:
> > > > +/* perphy ->dumpit() handler for GET requests. */
> > > > +static int ethnl_perphy_dumpit(struct sk_buff *skb,
> > > > +			       struct netlink_callback *cb)
> > > > +{
> > > > +	struct ethnl_perphy_dump_ctx *ctx = ethnl_perphy_dump_context(cb);
> > > > +	struct ethnl_dump_ctx *ethnl_ctx = &ctx->ethnl_ctx;
> > > > +	int ret = 0;
> > > > +
> > > > +	if (ethnl_ctx->req_info->dev) {
> > > > +		ret = ethnl_perphy_dump_one_dev(skb, ethnl_ctx->req_info->dev,
> > > > +						ctx, genl_info_dump(cb));
> > > > +		if (ret < 0 && ret != -EOPNOTSUPP && likely(skb->len))
> > > > +			ret = skb->len;
> > > > +
> > > > +		netdev_put(ethnl_ctx->req_info->dev,
> > > > +			   &ethnl_ctx->req_info->dev_tracker);      
> > > 
> > > You have to release this in .done
> > > dumpit gets called multiple times until we run out of objects to dump.
> > > OTOH user may close the socket without finishing the dump operation.
> > > So all .dumpit implementations must be "balanced". The only state we
> > > should touch in them is the dump context to know where to pick up from
> > > next time.    
> > 
> > Thanks for poiting it out.
> > 
> > Now that you say that, I guess that I should also move the reftracker
> > I'm using for the netdev_hold in ethnl_perphy_dump_one_dev() call to
> > struct ethnl_perphy_dump_ctx ? That way we make sure the netdev doesn't
> > go away in-between the multiple .dumpit() calls then...
> > 
> > Is that correct ?  
> 
> Probably not. That'd allow an unprivileged user space program to take 
> a ref on a netdev, and never call recv() to make progress on the dump.
> 
> The possibility that the netdev may disappear half way thru is inherent
> to the netlink dump model. We will pick back up within that netdev
> based on its ifindex, no need to hold it.

OK I'm good with that then ! Thanks for the explanations, makes a lot
of sense. I'll followup with a new version soon :)

Maxime

