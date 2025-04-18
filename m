Return-Path: <netdev+bounces-184081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C14CA9331E
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 09:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0D8A8A0A4C
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 07:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7153B253955;
	Fri, 18 Apr 2025 07:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="L9yBzUfi"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCDD209F2A;
	Fri, 18 Apr 2025 07:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744959630; cv=none; b=VEtO+FLMPqXUIxhcfKu7Q4B+zkq9RVUbAI+LRn70S9Wd3u6cOelaQndDqv8Py1L8fWvYVozW0C2GYhfEzF9Mg23KjXU9rqzhyYjwiaX9eMDNJlnxdmRUchInKI8VP/piXNm9vJnpVU/SdLTlpNoij0jShfz/CKzp7oBqDhLnEz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744959630; c=relaxed/simple;
	bh=wiVXYijXoCx9e9/HPWVlzT93KtXbqNjBfqsDxz1Fesc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n9KYSDu7Q949Mmxr+q50NwbIXjT1cEuL+1fM7BF2j+wnwFYAiTL/ZQOmxfiElc3gT/3WFy6R1zNto+gyQRBUCc+q+kJe9xEf+86El6hmQXgXOahhCcYNtrJqhU72dzdPyFEe2qXTr01Pp5WXNZTdl2x0bf/9odUux6z69av2J7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=L9yBzUfi; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D216F4435F;
	Fri, 18 Apr 2025 07:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744959619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FVm3s6Daurjg4AWD/fcVP0eHe4qdw9NBVQ3f6X7CoD8=;
	b=L9yBzUfiLFVwSF++fBp2zlChVq6y9R1Cv2QxCZcDHteqWea1iWwck3uWioXm+9tXO3VTEw
	BlnctNULf64DkF40MZlCbPnBlJCpCzrJuOKghJIXtQt+85cQG+lwtJG9jW5OTKyNAMthOS
	cVtnOO5qLEV/bcDKRvw/nSUCpSao7Y/LBbUB5ptBQxaltjhIWSRofUUJ5Y6JnTehfcQufU
	rWHOlPh4Ywz1bQbdhWJqmYvdzJ31FHddmluKpfaJIWB1IerF6TMxROUyPjbZB1Hxe0N9di
	PIW8GeeZXwyJUX5lJIcicm0uJFOD2bzzelSwLQiK8ftOJ164Igw83l6Vnib7CQ==
Date: Fri, 18 Apr 2025 09:00:16 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Heiner Kallweit
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
Subject: Re: [PATCH net-next v6 1/2] net: ethtool: Introduce per-PHY DUMP
 operations
Message-ID: <20250418090016.01900035@fedora.home>
In-Reply-To: <564ca4ac-661e-4126-a65a-106d3c28a47e@redhat.com>
References: <20250415085155.132963-1-maxime.chevallier@bootlin.com>
	<20250415085155.132963-2-maxime.chevallier@bootlin.com>
	<564ca4ac-661e-4126-a65a-106d3c28a47e@redhat.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedugeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeeftdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepheetveefiedvkeejfeekkefffefgtdduteejheekgeeileehkefgfefgveevfffhnecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepk
 hhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Paolo,

On Thu, 17 Apr 2025 12:03:43 +0200
Paolo Abeni <pabeni@redhat.com> wrote:

> On 4/15/25 10:51 AM, Maxime Chevallier wrote:
> > +static int ethnl_perphy_dump_all_dev(struct sk_buff *skb,
> > +				     struct ethnl_perphy_dump_ctx *ctx,
> > +				     const struct genl_info *info)
> > +{
> > +	struct ethnl_dump_ctx *ethnl_ctx = &ctx->ethnl_ctx;
> > +	struct net *net = sock_net(skb->sk);
> > +	struct net_device *dev;
> > +	int ret = 0;
> > +
> > +	rcu_read_lock();
> > +	for_each_netdev_dump(net, dev, ethnl_ctx->pos_ifindex) {
> > +		dev_hold(dev);  
> 
> Minor nit: please use netdev_hold() instead.

Will do, I didn't see the notice about using netdev_hold instead in the
doc, I merely used the current ethnl_default_dumpit() as a reference,
and it uses dev_hold() as well.

should I convert it to netdev_hold() along the way in v3 ?

Maxime

