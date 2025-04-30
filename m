Return-Path: <netdev+bounces-186954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D581AA431F
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 08:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A649A7E51
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 06:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769851DE4D8;
	Wed, 30 Apr 2025 06:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="j+nHDkym"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5B41EEF9;
	Wed, 30 Apr 2025 06:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745994754; cv=none; b=cscZl3747A+gPL6A7No+Or7faOfXpjQWYWBmbnfgI6uRgzlyfkP4LSmGSxlsernM7sOfYKWU1qJOb1l0uC6WESXnBNECnOOlLuOLGuk9agzwFDlEMjjmiC5RJAF6RiUOdC8F6J4QNcSh/mI8hqJbzJYIr7Sf4yVrRvQX9KAoRTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745994754; c=relaxed/simple;
	bh=1NINY84KPlz/zdZ+0AUbQN4QFpGdzjc1N8RcjFfZycY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hm1fs8jtGoeiOcnFz103xmaFaYxbjyfsQiNWVifYCeXW5QLXPTSc5EjwHfoeQrwB01bhev+TjqE5fgjMBVDvAQ7JdqBgGhgrRGx2hZIwnpE34oHIKF8CEAI+3Clr5DzQID/JVi7qfPx4CzxRCD8jXHlVI17+8ZnBcSdN1xHIzK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=j+nHDkym; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DAD2A43A4D;
	Wed, 30 Apr 2025 06:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745994743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rMct6rwV0rkF1WxtEmv6iyMd03nGjUcSuxSQDfiZZro=;
	b=j+nHDkymH+VHC8ASsobpg86S7/LM6pz/wDmJpz5NHLogTzM4DxHssAVCu6eNLKJ6f0woEW
	VPF6vcSEeFLF62mBBqOd/DlkTW5Bu6Z+VSYw9Fv5iucaML1bvARt5v1tQDQO3xOkN63D7M
	BZiTcxRpWekbC5YMnBdnvAQmlfjJcS5ARP41ATuWKHePDUjHdLPA6YeX5ADbcnUxk07Uid
	WBum957d6HADCt8av5O0ZpgB2XgvQi/yjfk1Ipd1BkKKbuSqdzeCmvoVQYvMcReu2abixF
	1uT06f/MQtVYS3EqoLgrwfOx8O3bIHH6ROLfH10HWr793ImwUW5f466aR6xt3g==
Date: Wed, 30 Apr 2025 08:32:20 +0200
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
Message-ID: <20250430083220.5fba6c32@device-130.home>
In-Reply-To: <20250424180333.035ff7d3@kernel.org>
References: <20250422161717.164440-1-maxime.chevallier@bootlin.com>
	<20250422161717.164440-2-maxime.chevallier@bootlin.com>
	<20250424180333.035ff7d3@kernel.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieehleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopeguvghvihgtvgdqudeftddrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhto
 hepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Jakub,

On Thu, 24 Apr 2025 18:03:33 -0700
Jakub Kicinski <kuba@kernel.org> wrote:


> > +
> > +/* perphy ->dumpit() handler for GET requests. */
> > +static int ethnl_perphy_dumpit(struct sk_buff *skb,
> > +			       struct netlink_callback *cb)
> > +{
> > +	struct ethnl_perphy_dump_ctx *ctx = ethnl_perphy_dump_context(cb);
> > +	struct ethnl_dump_ctx *ethnl_ctx = &ctx->ethnl_ctx;
> > +	int ret = 0;
> > +
> > +	if (ethnl_ctx->req_info->dev) {
> > +		ret = ethnl_perphy_dump_one_dev(skb, ethnl_ctx->req_info->dev,
> > +						ctx, genl_info_dump(cb));
> > +		if (ret < 0 && ret != -EOPNOTSUPP && likely(skb->len))
> > +			ret = skb->len;
> > +
> > +		netdev_put(ethnl_ctx->req_info->dev,
> > +			   &ethnl_ctx->req_info->dev_tracker);  
> 
> You have to release this in .done
> dumpit gets called multiple times until we run out of objects to dump.
> OTOH user may close the socket without finishing the dump operation.
> So all .dumpit implementations must be "balanced". The only state we
> should touch in them is the dump context to know where to pick up from
> next time.

Sorry for the delayed answer, I'm still wrapping my head around all
this. calling netdev_put in dumpit() is not correct, but won't moving
this into .done() make us subject to the scenario you described to me
in another mail where userspace would stall the dump operation by not
calling recv() ?

Maybe the safest path, as you mention in the other thread, would be to
store the requesting ifindex in .start(), call netdev_put() in start()
as well, and hold/dump/put in each .dumpit() then.

Maxime


