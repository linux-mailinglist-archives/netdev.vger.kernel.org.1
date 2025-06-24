Return-Path: <netdev+bounces-200513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E842DAE5C59
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 08:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 027F93B8201
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 06:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D35229B0D;
	Tue, 24 Jun 2025 06:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="a0dAg9UN"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CA923E226
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 06:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750744809; cv=none; b=mH/CYfUOJkSzu+94Ml5SJxiayyShimdtdfQW7yTsKMxoNfmrhlyZFDYJrXR0u7vXvrbG/dHYHJl2e5h2pOzuvOwKIbidjHXMtjYvdQ8wvO9jrGxXd9GLUjZSdPkAyuqbMnJ4aLmmt2Bz4jI53Qi/BEWnVWXpYY8FHdi/JCnqcKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750744809; c=relaxed/simple;
	bh=7XuVvObeFOUlea0uIV9cwVMhDM+prVTrUOU0zTewMk4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UGCYGwUHx8d+h+EatImEpQEDRWkpC5TqQD9R03mp/olXfsEi3f4TJq1n1mOD9p2nPOKcpz5oGtnpVDjehGo2NVQrHUXA/vyttU1Ecr5pxy+6ZGvS+mv4yYdL4AuBjkyEh7DIWv0020LKjtbWj/H8glWUnkjXfuuMhAAEuTLHKHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=a0dAg9UN; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2B8EB442BA;
	Tue, 24 Jun 2025 06:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750744805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VUQ3ayKE9eHImqqnnMOe3BZ5JdYB6XGKgyXyYBCz0vM=;
	b=a0dAg9UNGUQSHr1ackVXgkWsjLeqZTyd0/hKJctXUySL3m4T04qz9B2Y8lHTNJgNfTpFPC
	kNXTxB0IUjIGIwn37/dDmCW/6oObnAkSmSupqVzI5qoLQFlqKwZw45VawpyftMQQfbqHUY
	azOZYA+OyulcMN5acRIpkF8NxPNnzcXdbF9rFBQ1hU1dFa9l2ZAgS5x8uTRQAN5UFwSG+5
	yJZmmtyGKJcWEwYISuqEah/4Btxi+qlXLfsnDcOhLIvVXwNDcS7RHNw65411y8dMhE+qNH
	+4vH9PBWdcBD7wf6wAb7sa1zQT9Nut+Ik94n1fXxpUNqIlm8Atj7xMCsBtvIgA==
Date: Tue, 24 Jun 2025 08:00:04 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, sdf@fomichev.me, jdamato@fastly.com,
 ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next v2 0/8] net: ethtool: rss: add notifications
Message-ID: <20250624080004.7a36543e@2a02-8440-d115-be0d-cec0-a2a1-bc3c-622e.rev.sfr.net>
In-Reply-To: <20250623231720.3124717-1-kuba@kernel.org>
References: <20250623231720.3124717-1-kuba@kernel.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdduleduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopedvrgdtvddqkeeggedtqdguudduhedqsggvtdguqdgtvggttddqrgdvrgduqdgstgeftgdqiedvvdgvrdhrvghvrdhsfhhrrdhnvghtpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddupdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepnhgvthguv
 ghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Jakub,

On Mon, 23 Jun 2025 16:17:12 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> Next step on the path to moving RSS config to Netlink. With the
> refactoring of the driver-facing API for ETHTOOL_GRXFH/ETHTOOL_SRXFH
> out of the way we can move on to more interesting work.
> 
> Add Netlink notifications for changes in RSS configuration.
> 
> As a reminder (part) of rss-get was introduced in previous releases
> when input-xfrm (symmetric hashing) was added. rss-set isn't
> implemented, yet, but we can implement rss-ntf and hook it into
> the changes done via the IOCTL path (same as other ethtool-nl
> notifications do).
> 
> Most of the series is concerned with passing arguments to notifications.
> So far none of the notifications needed to be parametrized, but RSS can
> have multiple contexts per device, and since GET operates on a single
> context at a time, the notification needs to also be scoped to a context.
> Patches 2-5 add support for passing arguments to notifications thru
> ethtool-nl generic infra.
> 
> The notification handling itself is pretty trivial, it's mostly
> hooking in the right entries into the ethool-nl op tables.

I was able to test the PLCA path, which works fine :)

So, I reviewed and tested some of the ethnl patches in this series,
though I wasn't able to test the RSS-specific aspects.

Thanks,

Maxime

