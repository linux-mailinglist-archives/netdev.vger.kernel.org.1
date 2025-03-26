Return-Path: <netdev+bounces-177707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD31CA715AF
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 12:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C52853BE9AD
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 11:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C901ADC86;
	Wed, 26 Mar 2025 11:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YKEnACO4"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA5D1A38E4;
	Wed, 26 Mar 2025 11:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742988394; cv=none; b=AnAfLB7fb5mWinQR6/3qBsuQx7TFzO3wCXMKfg5kYE9VPtDctrKGzGDF/FtxSZqiArdmZKNiBshKKz378LqpGOVicbLF1D+WjiaVDI8TRMG38oP/UJyTcINc3x6CAzo44HoQecjybbhGRsqSVdBUEV8R9BV+wVxCzBPldZHoouM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742988394; c=relaxed/simple;
	bh=VMvgqkRpSkEdDcVQfBHjqOv2N1jS+1d4y7ueQuWHJic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lfDlV8VgFbtvVQg5gTZp791d31IBkEbNQg+5qXfh/Y3eb1eVIqoPYMed1NRWQMJ1qzIIfLgNfChp0qy7AYJp+Hgr6/VuYoijrQCDcJ/RYICpkvHbwYiM1Bx+o2IYFOCcHa6tspGKw3wnuZUjcKLpYP+dpM1+hWIh/WLUCh/CHtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YKEnACO4; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ECAD7441FF;
	Wed, 26 Mar 2025 11:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742988389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sCyhizZ6fioj/Cn50FEmvft5O6zsfQST6n+ZMo09TZw=;
	b=YKEnACO4OwvDDi73eZxozFu3r+G2hmI0QrW9NrDammoDZdd4eE3tZza6uVCudWVgKGaJG8
	9iYghPUUIL4uxa8aBTQPHDw5p54YRxos2Qq5z9ByqD6OT222leEaq0ONMDVpDWMoE8BIwM
	Goil2DkhtNHqxcOUrFCpLSzkDykzdJhaQNdwUJHLpURNqOb0dhamhOBrvllixZY+Gl630D
	2Oz5ivbUUQ3nOT9GBu76z8ApSFXu+c3O4Gf+iGCDQHlcMf3HmOooAKsEGymv2+3jO5ka5k
	UxGeJyd57KTkV9BrMV+pY9bkOfOVWrslAVIkZjnfPn+amEuzwcd86lXseRFB6A==
Date: Wed, 26 Mar 2025 12:26:27 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, Andrew Lunn
 <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Simon
 Horman <horms@kernel.org>, Romain Gantois <romain.gantois@bootlin.com>,
 Piergiorgio Beruto <piergiorgio.beruto@gmail.com>
Subject: Re: [PATCH net-next v4 2/8] net: ethtool: netlink: Allow
 per-netdevice DUMP operations
Message-ID: <20250326122627.600bec6b@fedora.home>
In-Reply-To: <20250326112936.16f8b075@kmaincent-XPS-13-7390>
References: <20250324104012.367366-1-maxime.chevallier@bootlin.com>
	<20250324104012.367366-3-maxime.chevallier@bootlin.com>
	<20250325122706.5287774d@kmaincent-XPS-13-7390>
	<20250325141507.4a223b03@kernel.org>
	<20250325142202.61d2d4b3@kernel.org>
	<20250326085906.62a7c9fc@fedora.home>
	<20250326112936.16f8b075@kmaincent-XPS-13-7390>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieehgedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtohepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvt
 hdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

On Wed, 26 Mar 2025 11:29:36 +0100
Kory Maincent <kory.maincent@bootlin.com> wrote:

> On Wed, 26 Mar 2025 08:59:06 +0100
> Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:
> 
> > On Tue, 25 Mar 2025 14:22:02 -0700
> > Jakub Kicinski <kuba@kernel.org> wrote:
> >   
> > > On Tue, 25 Mar 2025 14:15:07 -0700 Jakub Kicinski wrote:    
> >  [...]    
> > > > 
> > > > Let's try. We can probably make required_dev attr of
> > > > ethnl_parse_header_dev_get() a three state one: require, allow, reject?
> > > >    
> > > 
> > > Ah, don't think this is going to work. You're not converting all 
> > > the dumps, just the PHY ones. It's fine either way, then.    
> > 
> > Yeah I noticed that when implementing, but I actually forgot to mention
> > in in my cover, which I definitely should have :(
> > 
> > What we can also do is properly support multi-phy dump but not filtered
> > dump on all the existing phy commands (plca, pse-pd, etc.) so that be
> > behaviour is unchanged for these. Only PHY_GET and any future per-phy
> > commands would support it.  
> 
> Couldn't we remove the existence check of ctx->req_info->dev in
> ethnl_default_start and add the netdev_put() in the ethnl_default_dumpit()?
> Would this work?

It would work, but it seems unnecessary to hold a refcount on a
specific netdev while we iterate on all netdevs in the namespace
afterwards. But I'd say that's an implementation detail :)

> Or we could keep your change and let the userspace adapt to the new support of
> filtered dump. In fact you are modifying all the ethtool commands that are
> already related to PHY, if you don't they surely will one day or another so it
> is good to keep it.

So the question is, is it OK to stop ignoring the ifindex/ifname header
attribute for ethnl dump requests, and if so, should we do that for all
dump commands or only the ones for which is makes sense to do so.

Jakub says "t's fine either way, then.", but don't fully get if this is
an answer to the above question :)

This will only change the behaviour of filtered dumps, that aren't
really used with ethnl (except for PHY_GET but we won't change its
behaviour either way)

Maxime

