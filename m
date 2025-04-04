Return-Path: <netdev+bounces-179342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05352A7C0C7
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 17:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6DD017AB40
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 15:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA9C1F4E57;
	Fri,  4 Apr 2025 15:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cmnYwXGB"
X-Original-To: netdev@vger.kernel.org
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8025D517;
	Fri,  4 Apr 2025 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743781427; cv=none; b=BZkVLDHY0sPRx4TEczKhlairaW6j63eCSEdglstJVPGMxXuxX7TXxj5eDiuab0rEClU4I+3YUr7lbcNnWmVTUNE7FJCbsJiG1RYjfIqLP19y0T7gFWlpNi6+AgyQ3aHuo42Y18kzcU65i99mExdteEC8QM1nRMaGL6qOql8jdSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743781427; c=relaxed/simple;
	bh=y5kdJZvxZbSx1NwGH41iuXoXmVDiZX60eBPJUgWXggk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+Z4+OEGuoC8hIjPoRITcvxM0XKlvK2VdMX6Nks+Re3mHldtRQIMXUXLq1Sm4Ffck9kccnExUpGKiMobP3F8rrERpqVO6588nqx/n4c56HjznESkdIeVHL1Iz7V5jl0sxAFobJErZ7B45qGS2ofp4lisTJVlCpLO4YkodNSPUt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cmnYwXGB; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 83CF9583F40;
	Fri,  4 Apr 2025 15:09:58 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7002620488;
	Fri,  4 Apr 2025 15:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743779391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F1k4aXHMVDjBaGF4+/DFJ9DVIauTuz/+r1G0nZFFj/E=;
	b=cmnYwXGBAFAIsLG0kU4d0QuGEkupgz8zbN+69t+bZ6gR/Y5tuGoaOAqwmsLUL36gP3WiTX
	xDbALV6vL2pCQ71niWLgSf8ts/CfWM4jbh/7FV8yGG4OinFuyYdkD7UXEKWS6+7s8bk3MG
	ybYkcX2609Z+0jm7fU7FTurKKOrtbUZdzr5pkjA8zepoC/Dx3GlpPxMM9oZwnjDb3Cet4a
	XnuddFcG02gkH044wI7GjJvKFzTDW2pEIL7goWQCdaamAqoYcYZ20uFfKaoFy47KX7kBTh
	4Fz8L2Cfigm/21a/qCT/WxjkIe39bc0dl9/HhLZDkHAccKPlJD5kyYK6Qn+FIg==
Date: Fri, 4 Apr 2025 17:09:49 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Simon Horman <horms@kernel.org>, Michal
 Kubecek <mkubecek@suse.cz>, Florian Fainelli <f.fainelli@gmail.com>, Kory
 Maincent <kory.maincent@bootlin.com>
Subject: Re: [PATCH net] net: ethtool: Don't call .cleanup_data when
 prepare_data fails
Message-ID: <20250404170949.64e46b89@fedora.home>
In-Reply-To: <20250404074744.6689fa8b@kernel.org>
References: <20250403132448.405266-1-maxime.chevallier@bootlin.com>
	<20250404074744.6689fa8b@kernel.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduledujeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddvpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepvgguu
 hhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Jakub,

On Fri, 4 Apr 2025 07:47:44 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu,  3 Apr 2025 15:24:46 +0200 Maxime Chevallier wrote:
> > There's a consistent pattern where the .cleanup_data() callback is
> > called when .prepare_data() fails, when it should really be called to
> > clean after a successfull .prepare_data() as per the documentation.
> > 
> > Rewrite the error-handling paths to make sure we don't cleanup
> > un-prepared data.  
> 
> Code looks good. I have a question about the oldest instance of 
> the problem tho. The callbacks Michal added seem to be "idempotent".
> As you say the code doesn't implement the documented model, but
> I think until eeprom (?) was added the prepare callbacks could
> have only failed on memory allocation, and all the cleanup did
> was kfree(). So since kfree(NULL) is fine - nothing would have
> crashed..
> 
> Could you repost with the Fixes tag and an explanation of where
> the first instance of this causing a potential real crash was added?

TBH I didn't even see a crash, I just stumbled upon that when working
on the phy-dump stuff. I was actually surprised that I could trace it
back so far, surely things would've blown-up somewhere in the past 6
years...

I'll look at the chronology and see what was the first point in time
where a crash could've realistically gone wrong then.

Thanks

Maxime

