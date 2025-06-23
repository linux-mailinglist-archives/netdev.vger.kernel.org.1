Return-Path: <netdev+bounces-200299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6029EAE474B
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 16:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EFFC3AA222
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 14:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AF425E465;
	Mon, 23 Jun 2025 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="h4IztXMv"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD7E267700
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750689848; cv=none; b=gnZqIPAzT3c0KNYyZED9crOY1+cmV7bM8msURKYvle6N/WxWUvwBlTuwjQZB0WObUD7k8cQQgjK1MZ0/ybR4r6cz2ZXI8bN3krlzvAzRRc+TuXtBtavUtE31zja2nTKt9w+WZXO1/qvTh1jfP23YQTlziZS+PFaWDqMnUl677gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750689848; c=relaxed/simple;
	bh=fKJMeXjP7rfC68DWbKNCL8jBQpda2u+DeFo5MK3nhKE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=etuTw1laoANrpcqFO1FZ144DKWPvqh/HUovJpPvdOXAOSFLRNVWERL4z5v0/VUDN9s+WQp+sdKbE20T/RTUdbP+8M38g3i1lv0dN5yWFuUep3hwK4ml7uEf6tZLAffBNjo8vFTmhs2Ox7uPYkd3F9UsIhFm9fFB+Kt69Je55ta4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=h4IztXMv; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BFA8F43941;
	Mon, 23 Jun 2025 14:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750689844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g2dWzZjWgTWEu6aarvUYJ/ac2UZ4SjsExL2erCbIV9Q=;
	b=h4IztXMv2lbfjkeo8cT5jqaHyFhQW+0pILK+y1gEp48hYx8/nJrswjAxQ10elfcxRkm1Fq
	ottdWt7xyygRvt/nuEUkXRZMkAR3R2aJg/nTNiJuoVONsTmn6LrXsfDR5DzPVDqhitwaw8
	TTVxbDjLGURLNtc4H1PIXvX2HdM8kME0DoKr1cwXR7Mp3M0Hwt+C4XrN7fW/BIQtCxDZQI
	I3zIV/ZBsjQv+sFMi8JMiN9H3xOHdGGyGjpENm+E5llyBGighqmEEGRCcBFBcfanIIiJPJ
	zfzBrDfjQ5nx9cz4jR11izl55R2R0kt8xE7UcOMNJRCAbGRCEfVKzJ0W95HuWg==
Date: Mon, 23 Jun 2025 16:44:02 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, sdf@fomichev.me, jdamato@fastly.com,
 ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next 5/9] net: ethtool: copy req_info from SET to
 NTF
Message-ID: <20250623164402.675aec0c@fedora.home>
In-Reply-To: <20250623073721.1315dd03@kernel.org>
References: <20250621171944.2619249-1-kuba@kernel.org>
	<20250621171944.2619249-6-kuba@kernel.org>
	<20250622140020.3dcc6814@fedora.home>
	<20250623073721.1315dd03@kernel.org>
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
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddujedvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddupdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlv
 gdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Jakub,

On Mon, 23 Jun 2025 07:37:21 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Sun, 22 Jun 2025 14:00:20 +0200 Maxime Chevallier wrote:
> > > @@ -979,6 +979,9 @@ static void ethnl_default_notify(struct net_device *dev, unsigned int cmd,
> > >  
> > >  	req_info->dev = dev;
> > >  	req_info->flags |= ETHTOOL_FLAG_COMPACT_BITSETS;
> > > +	if (orig_req_info)
> > > +		memcpy(&req_info[1], &orig_req_info[1],
> > > +		       ops->req_info_size - sizeof(*req_info));    
> > 
> > Is there any chance we can also carry orig_req_info->phy_index into
> > req_info ? That's a bit of sub-command context that is also useful for
> > notifications, especially PLCA. As of today, the PLCA notif after a SET
> > isn't generated at all as the phy_index isn't passed to the ethnl
> > notification code.  
> 
> Definitely a good idea, only question is whether it should be a
> separate series. But the change is easy, I guess just:
> 
> diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
> index 1a8589693d91..91974d8e74d8 100644
> --- a/net/ethtool/netlink.c
> +++ b/net/ethtool/netlink.c
> @@ -981,9 +981,11 @@ static void ethnl_default_notify(struct net_device *dev, unsigned int cmd,
>  
>         req_info->dev = dev;
>         req_info->flags |= ETHTOOL_FLAG_COMPACT_BITSETS;
> -       if (orig_req_info)
> +       if (orig_req_info) {
> +               req_info->phy_index = orig_req_info->phy_index;
>                 memcpy(&req_info[1], &orig_req_info[1],
>                        ops->req_info_size - sizeof(*req_info));
> +       }
>  
>         netdev_ops_assert_locked(dev);
>  
> If you'd like me to squash it in -- would you be able to test this?

That could be a separate series, but indeed I think this is all
that's needed. I'll be able to test that, no problem :)

Thanks,

Maxime

