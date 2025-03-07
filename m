Return-Path: <netdev+bounces-172934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D072CA568AD
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 14:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A9111896A38
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 13:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159DD219E86;
	Fri,  7 Mar 2025 13:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jeWmpXMp"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CBE192D68;
	Fri,  7 Mar 2025 13:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741353507; cv=none; b=SEnpVnkH071y8OKXoSfr+HnVp0OWeHcg5Ar7jzbd1cXW4GqBkyT28gfChie+V8ahjZBzzU1ZplpCFS3/PKY3x57D97kg4jP+QGfVPu1Y0qhbWFtKbq2SHpAEE+pWlj9IVXGBleXkynQ9Ig88kcMtN7EA3kCFNTzLA2jx3Cnh8lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741353507; c=relaxed/simple;
	bh=NmvrV27jfwskBu0OegYmLtswPDJriqsgyb5BfkGpunc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M8paQBnQIN8MxOMILxylfFZiYq62oMq40HKb0CuhhwfAFCIqZL/7ZaYHLUGAB6Mk/1SKfyhEERFt+UggrnMp34u1ShwddpnAL5r+xpMUepcJk0z1R4uIInGgBCDWmQswdDxVzTLt3O8IdQnqq/AuGtR8J+m/faCgBR7PWny0saI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jeWmpXMp; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8E9D344278;
	Fri,  7 Mar 2025 13:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741353502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JhRsUH63PXad8fITVdK3UPKSquO0H7HspkXydnx5S/g=;
	b=jeWmpXMprgtWeYDHc95wJApTWvdfvuDoUAs5l9fQG2MGW/YZYF8PJelhmFIu2P6PTRT4p3
	c2R14B50m57QNsRgOzXVn5UIB4r5s91NYm6mdrrbBFf9BZs4OWGKLQc5pYk3ofQFBWU+7g
	MMK90pEgjRH78hUBDI+pDBEUGlKN4u9QeMOTOYg0qd+FNZx0j6CQlIM4gUIqaLua1r1ILZ
	aoPDeRESYhG0gXq5C/adW7tmeP85n2eKSGkueV5xM22r16ur6E5bTSuKMRaAyOOO8lmZCl
	rTaHeyfHp+y7AXbKjQ+bSq+BOWBHG472pe4Hop9fD6XTkJ8BkK7+pvIerzXymQ==
Date: Fri, 7 Mar 2025 14:18:19 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Romain Gantois <romain.gantois@bootlin.com>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>
Subject: Re: [PATCH net-next 1/7] net: ethtool: netlink: Allow per-netdevice
 DUMP operations
Message-ID: <20250307141819.55e42ccd@fedora.home>
In-Reply-To: <20250307122119.GE3666230@kernel.org>
References: <20250305141938.319282-1-maxime.chevallier@bootlin.com>
	<20250305141938.319282-2-maxime.chevallier@bootlin.com>
	<20250307122119.GE3666230@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtjeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgdphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehku
 hgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Simon,

On Fri, 7 Mar 2025 12:21:19 +0000
Simon Horman <horms@kernel.org> wrote:

> On Wed, Mar 05, 2025 at 03:19:31PM +0100, Maxime Chevallier wrote:
> > We have a number of netlink commands in the ethnl family that may have
> > multiple objects to dump even for a single net_device, including :
> > 
> >  - PLCA, PSE-PD, phy: one message per PHY device
> >  - tsinfo: one message per timestamp source (netdev + phys)
> >  - rss: One per RSS context
> > 
> > To get this behaviour, these netlink commands need to roll a custom  
> > ->dumpit().  
> > 
> > To prepare making per-netdev DUMP more generic in ethnl, introduce a
> > member in the ethnl ops to indicate if a given command may allow
> > pernetdev DUMPs (also referred to as filtered DUMPs).
> > 
> > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > ---
> >  net/ethtool/netlink.c | 45 ++++++++++++++++++++++++++++---------------
> >  net/ethtool/netlink.h |  1 +
> >  2 files changed, 30 insertions(+), 16 deletions(-)
> > 
> > diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
> > index 734849a57369..0815b28ba32f 100644
> > --- a/net/ethtool/netlink.c
> > +++ b/net/ethtool/netlink.c
> > @@ -578,21 +578,34 @@ static int ethnl_default_dumpit(struct sk_buff *skb,
> >  	int ret = 0;
> >  
> >  	rcu_read_lock();
> > -	for_each_netdev_dump(net, dev, ctx->pos_ifindex) {
> > -		dev_hold(dev);
> > +	if (ctx->req_info->dev) {
> > +		dev = ctx->req_info->dev;
> >  		rcu_read_unlock();
> > -
> > -		ret = ethnl_default_dump_one(skb, dev, ctx, genl_info_dump(cb));
> > -
> > +		/* Filtered DUMP request targeted to a single netdev. We already
> > +		 * hold a ref to the netdev from ->start()
> > +		 */
> > +		ret = ethnl_default_dump_one_dev(skb, dev, ctx,
> > +						 genl_info_dump(cb));  
> 
> Hi Maxime,
> 
> ethnl_default_dump_one_dev() is called here but it doesn't exist
> until the following patch is applied, which breaks bisection.

Yeah I messed-up in my rebase and bisection broke :(

I'll send a new version in a few days, as Jakub said, let's give some
time for the netdev_lock series to move forward and go through CI, I'll
need to rebase on it at some point.

> 
> >  		rcu_read_lock();
> > -		dev_put(dev);
> > -
> > -		if (ret < 0 && ret != -EOPNOTSUPP) {
> > -			if (likely(skb->len))
> > -				ret = skb->len;
> > -			break;
> > +		netdev_put(ctx->req_info->dev, &ctx->req_info->dev_tracker);
> > +	} else {
> > +		for_each_netdev_dump(net, dev, ctx->pos_ifindex) {
> > +			dev_hold(dev);
> > +			rcu_read_unlock();
> > +
> > +			ret = ethnl_default_dump_one(skb, dev, ctx,
> > +						     genl_info_dump(cb));
> > +
> > +			rcu_read_lock();
> > +			dev_put(dev);
> > +
> > +			if (ret < 0 && ret != -EOPNOTSUPP) {
> > +				if (likely(skb->len))
> > +					ret = skb->len;
> > +				break;
> > +			}
> > +			ret = 0;
> >  		}
> > -		ret = 0;
> >  	}
> >  	rcu_read_unlock();
> >    
> 
> ...
> 
> > diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
> > index ec6ab5443a6f..4db27182741f 100644
> > --- a/net/ethtool/netlink.h
> > +++ b/net/ethtool/netlink.h
> > @@ -388,6 +388,7 @@ struct ethnl_request_ops {
> >  	unsigned int		req_info_size;
> >  	unsigned int		reply_data_size;
> >  	bool			allow_nodev_do;
> > +	bool			allow_pernetdev_dump;  
> 
> nit: allow_pernetdev_dump should also be added to the Kernel doc for
>      struct ethnl_request_ops
> 
>      Flagged by ./scripts/kernel-doc -none
> 
>      There also appear to be similar minor issues with subsequent
>      patches in this series.

Ack, I'll make sure the doc is up to date and properly formatted :)

Thanks,

Maxime

> >  	u8			set_ntf_cmd;
> >  
> >  	int (*parse_request)(struct ethnl_req_info *req_info,
> > -- 
> > 2.48.1
> >   


