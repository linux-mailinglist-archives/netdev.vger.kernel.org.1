Return-Path: <netdev+bounces-181527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FA4A85564
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 09:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAFA3445641
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 07:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926FC28C5DA;
	Fri, 11 Apr 2025 07:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PqHLvB/P"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2F527E1BA;
	Fri, 11 Apr 2025 07:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744356397; cv=none; b=uAQzH4D1ECTPCSM6V1Unn/r+9SM3ceWh9Sa0epDKuhXKamISkbHWvXgB50Jaj7UVKdloS9Pgfm/vVamW+493wUkmr4BMqorunEsyAuiejbtWVR7LVYTSm7ZoOVKSEowFoPo9F3jIPbs7d0WmDUyhsuzYWqLSsDe9OgEQWv5Nf6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744356397; c=relaxed/simple;
	bh=RLRykMJ5ZAcCSTlqAFMvYKxTur9gCfh4uP+5pHfGE5I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YgwM8ZYB8GZLAeKCZ/cWwOOjippD/nJm6MlfRHp8pXTh6fZ1gkl3/+ToihUfvBn6/nPjaebRnlXxAnP2NTryf51LX0tUdw8EDDAZrF270syqwL4fMLeoXByiieDckRqzXP65w8P4C2tACCTjKn7s3Ex2H27Xw+NiwYxxvrbr3Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PqHLvB/P; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8CA814417D;
	Fri, 11 Apr 2025 07:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744356387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qdK/6yYJzGxQnCCXgiw7P3AMqcnft/7CmOOkoaxzVSE=;
	b=PqHLvB/P/MCc31hal1ebG34AdokMQJMst6lIK3BdFUrFdK3PorIig42wn24cFBywPgaQX3
	PWZr4hIoZ2jsEjL6/m5H5SuJI5b8fITC6ApXbPQlUt4tdMEbW6S/mheciafF0T4wY+JFA6
	+KKsElLdg74JaQh/1dPcab4XZElfOUpu+q9QeWF9q5zhZmaNDxLWc5jmRzvX4hoNjk2p4d
	Fszxo0zI9kg8W1DwuIzdV1tSw//TEgteiyF7pZRzxIJ3lC/hJm82EAuqE9uyesTUJs9hFI
	W1ibIKuj0xp8pSb9c0RdEwg9XZjLIb71Fh5kJxW2ANb5kPykpDUVwtC04vQnfw==
Date: Fri, 11 Apr 2025 09:26:19 +0200
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
Subject: Re: [PATCH net-next v5 1/4] net: ethtool: Introduce per-PHY DUMP
 operations
Message-ID: <20250411092619.722b7411@fedora.home>
In-Reply-To: <20250410172155.3cd854d8@kernel.org>
References: <20250410123350.174105-1-maxime.chevallier@bootlin.com>
	<20250410123350.174105-2-maxime.chevallier@bootlin.com>
	<20250410172155.3cd854d8@kernel.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudduvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepvgguu
 hhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Jakub,

On Thu, 10 Apr 2025 17:21:55 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu, 10 Apr 2025 14:33:46 +0200 Maxime Chevallier wrote:
> > ethnl commands that target a phy_device need a DUMP implementation that
> > will fill the reply for every PHY behind a netdev. We therefore need to
> > iterate over the dev->topo to list them.
> > 
> > When multiple PHYs are behind the same netdev, it's also useful to
> > perform DUMP with a filter on a given netdev, to get the capability of
> > every PHY.
> > 
> > Implement dedicated genl ->start(), ->dumpit() and ->done() operations
> > for PHY-targetting command, allowing filtered dumps and using a dump
> > context that keep track of the PHY iteration for multi-message dump.  
> 
> Transient warnings here that the new functions are not used :(
> Would it work to squash the 3rd and 4th patches in?
> Not ideal but better than having a warning.

ah damn yes indeed... meh sorry about that, I'll squash the other
patches in (except for the net/ethtool/phy.c patch). That said are you
more comfortable with this approach ? I was unsure this was what you
were expecting from the previous iteration.

Thanks,

Maxime

