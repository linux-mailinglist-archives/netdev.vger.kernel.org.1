Return-Path: <netdev+bounces-185867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3782A9BF1B
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 09:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77B659A1A99
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 07:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB23D22D79A;
	Fri, 25 Apr 2025 07:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mhhDXbkj"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E067052F88;
	Fri, 25 Apr 2025 07:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745564521; cv=none; b=EFnpjTMTSEVON3yDwbAF1UJOMHgOtF2M1jxhLWCRvc/xe0I5lpaAyd6h8+xsG67JjedM1U7dnbt67OIlyrEPmS00jGWhzpGkrWXdyx6GDFrnjIV7MwesjDSoriFUPEFvyKMeatS9mqlbX7NJTUwb8/7v/gjMkD/goTaeGFndFgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745564521; c=relaxed/simple;
	bh=ZxHAjcIptuiqodjyy8B/o+4RY/OFbTHLDblP4vNxbLE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qkrp8ssVx55W6PL6Lwa8bVen+0bl4Les1Oq8cvImccXfF/I+GBY4fTqGGZgRtXDG7oa2FLID6d7FjWJfNyPXjIomqoRY2tH5OqBdSdluIvKTOR9N6oLXye35jK5S1Puw1MwRzjonRbcY3TsOXXJOt5F7GsJT3+o3YzjqT9Qzkdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mhhDXbkj; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8F7AD442B9;
	Fri, 25 Apr 2025 07:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745564516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+8qxLu4pTTuuBfBCz9xyv1AK49aNK9oYl6N1G7UkeHY=;
	b=mhhDXbkjLaNuJHigLSjn9Ecd970zYFuxzfyD1OIpBVQlvBWlK6O12+o9vPjjmru9iB+UCH
	MkWk3laSu1OpiUYAI6f6vvpUTo/52RoL9yR5cvpyqe/ToXoJtiI3hQ8GkEV1wz5G0gE59N
	28kGFv1+m/E8m+L3dticfChUx9X3MMu6J8Hw60EcQTUBe6PnecAePoQCgSFc2bRkdF9JER
	re2f32Hl7QQHa0HtqqO/bsnGJrb4yJKBxFMIlfGV/jmsrK8uirYHrobpexhoH9LwHryjtZ
	e+ZPVife/cvYdLThvPPwZfmk+SLggGZ/VyXEekBKVoFzqDMmJwi+YV9r5wOA4A==
Date: Fri, 25 Apr 2025 09:01:53 +0200
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
Message-ID: <20250425090153.170f11bd@device-40.home>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheduieelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopeguvghvihgtvgdqgedtrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhop
 egvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Jakub,

On Thu, 24 Apr 2025 18:03:33 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 22 Apr 2025 18:17:14 +0200 Maxime Chevallier wrote:
> > +/* perphy ->start() handler for GET requests */  
> 
> Just because I think there are real bugs, I will allow myself an
> uber-nit of asking to spell the perphy as per-PHY or such in the
> comment? :)

No problem :) Thanks a lot for the review

> > +static int ethnl_perphy_start(struct netlink_callback *cb)
> > +{
> > +	struct ethnl_perphy_dump_ctx *phy_ctx = ethnl_perphy_dump_context(cb);
> > +	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
> > +	struct ethnl_dump_ctx *ctx = &phy_ctx->ethnl_ctx;
> > +	struct ethnl_reply_data *reply_data;
> > +	const struct ethnl_request_ops *ops;
> > +	struct ethnl_req_info *req_info;
> > +	struct genlmsghdr *ghdr;
> > +	int ret;
> > +
> > +	BUILD_BUG_ON(sizeof(*ctx) > sizeof(cb->ctx));
> > +
> > +	ghdr = nlmsg_data(cb->nlh);
> > +	ops = ethnl_default_requests[ghdr->cmd];
> > +	if (WARN_ONCE(!ops, "cmd %u has no ethnl_request_ops\n", ghdr->cmd))
> > +		return -EOPNOTSUPP;
> > +	req_info = kzalloc(ops->req_info_size, GFP_KERNEL);
> > +	if (!req_info)
> > +		return -ENOMEM;
> > +	reply_data = kmalloc(ops->reply_data_size, GFP_KERNEL);
> > +	if (!reply_data) {
> > +		ret = -ENOMEM;
> > +		goto free_req_info;
> > +	}
> > +
> > +	/* Don't ignore the dev even for DUMP requests */  
> 
> another nit, this comment wasn't super clear without looking at the dump
> for non-per-phy case. Maybe:
> 
> 	/* Unlike per-dev dump, don't ignore dev. The dump handler
> 	 * will notice it and dump PHYs from given dev.
> 	 */
> ?

That's better indeed :)

> > +	ret = ethnl_default_parse(req_info, &info->info, ops, false);
> > +	if (ret < 0)
> > +		goto free_reply_data;
> > +
> > +	ctx->ops = ops;
> > +	ctx->req_info = req_info;
> > +	ctx->reply_data = reply_data;
> > +	ctx->pos_ifindex = 0;
> > +
> > +	return 0;
> > +
> > +free_reply_data:
> > +	kfree(reply_data);
> > +free_req_info:
> > +	kfree(req_info);
> > +
> > +	return ret;
> > +}
> > +
> > +static int ethnl_perphy_dump_one_dev(struct sk_buff *skb,
> > +				     struct net_device *dev,
> > +				     struct ethnl_perphy_dump_ctx *ctx,
> > +				     const struct genl_info *info)
> > +{
> > +	struct ethnl_dump_ctx *ethnl_ctx = &ctx->ethnl_ctx;
> > +	struct phy_device_node *pdn;
> > +	int ret = 0;
> > +
> > +	if (!dev->link_topo)
> > +		return 0;  
> 
> Now for the bugs..
> 
> > +	xa_for_each_start(&dev->link_topo->phys, ctx->pos_phyindex, pdn,
> > +			  ctx->pos_phyindex) {
> > +		ethnl_ctx->req_info->phy_index = ctx->pos_phyindex;
> > +
> > +		/* We can re-use the original dump_one as ->prepare_data in
> > +		 * commands use ethnl_req_get_phydev(), which gets the PHY from
> > +		 * the req_info->phy_index
> > +		 */
> > +		ret = ethnl_default_dump_one(skb, dev, ethnl_ctx, info);
> > +		if (ret)
> > +			break;  
> 
> 		return ret;
> 
> > +	}  
> 
> 	ctx->pos_phyindex = 0;
> 
> 	return 0;
> 
> IOW I don't see you resetting the pos_phyindex, so I think you'd only
> dump correctly the first device? The next device will try to dump its
> PHYs starting from the last index of the previous dev's PHY? [1]

That is true... My mistake was to test on a system with one PHY only on
the first interface and a lot on the second, I'll adjust my tests and
fix that, thanks a lot for spotting !

> 
> > +	return ret;
> > +}
> > +
> > +static int ethnl_perphy_dump_all_dev(struct sk_buff *skb,
> > +				     struct ethnl_perphy_dump_ctx *ctx,
> > +				     const struct genl_info *info)
> > +{
> > +	struct ethnl_dump_ctx *ethnl_ctx = &ctx->ethnl_ctx;
> > +	struct net *net = sock_net(skb->sk);
> > +	netdevice_tracker dev_tracker;
> > +	struct net_device *dev;
> > +	int ret = 0;
> > +
> > +	rcu_read_lock();
> > +	for_each_netdev_dump(net, dev, ethnl_ctx->pos_ifindex) {
> > +		netdev_hold(dev, &dev_tracker, GFP_ATOMIC);
> > +		rcu_read_unlock();
> > +
> > +		/* per-PHY commands use ethnl_req_get_phydev(), which needs the
> > +		 * net_device in the req_info
> > +		 */
> > +		ethnl_ctx->req_info->dev = dev;
> > +		ret = ethnl_perphy_dump_one_dev(skb, dev, ctx, info);
> > +
> > +		rcu_read_lock();
> > +		netdev_put(dev, &dev_tracker);  
> 
> missing
> 
> 		ethnl_ctx->req_info->dev = NULL;
> 
> right? Otherwise if we need to send multiple skbs the "continuation"
> one will think we're doing a filtered dump.
> 
> Looking at commits 7c93a88785dae6 and c0111878d45e may be helpful,
> but I doubt you can test it on a real system, filling even 4kB
> may be hard for small messages :(

Ah damn, yes. I got that right I think in net/ethtool/phy.c but not
here.

As for testing, I do have a local patch to add PHY support to
netdevsim, allowing me to add an arbitrary number of PHYs to any nsim
devices. I'll make sure to test this case. I still plan to upstream the
netdevsim part at some point, but that still needs a bit of polishing...

> > +		if (ret < 0 && ret != -EOPNOTSUPP) {
> > +			if (likely(skb->len))
> > +				ret = skb->len;
> > +			break;
> > +		}
> > +		ret = 0;  
> 
> [1] or you can clear the pos_index here
> 
> > +	}
> > +	rcu_read_unlock();
> > +
> > +	return ret;
> > +}
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

Thanks for poiting it out.

Now that you say that, I guess that I should also move the reftracker
I'm using for the netdev_hold in ethnl_perphy_dump_one_dev() call to
struct ethnl_perphy_dump_ctx ? That way we make sure the netdev doesn't
go away in-between the multiple .dumpit() calls then...

Is that correct ?

> > +	} else {
> > +		ret = ethnl_perphy_dump_all_dev(skb, ctx, genl_info_dump(cb));
> > +	}
> > +
> > +	return ret;
> > +}  

Thanks a lot for the review, that's most helpful.

Maxime

