Return-Path: <netdev+bounces-198038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F947ADAF49
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 13:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784231892845
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 11:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6312E88A3;
	Mon, 16 Jun 2025 11:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jZm2gFpl"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC80B2E7F08;
	Mon, 16 Jun 2025 11:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750075057; cv=none; b=r/d1TUMts/Ps1x16qPD9j/DOs8anN4JX+uMGBdEu8yYab+AOvpb7eBy8j9QjkqbK0M4l9HcjtDQkgGfbUsQXQXHnECzxrBBuPAUJTWnnCNI1/32EBs0O+B9j9hEFnqLU6NND4gY0psUwnE6WbESO3YIvwf/om589Rbhiu2bTipM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750075057; c=relaxed/simple;
	bh=7UQcCRG/DzjoTINw75Thr/V1OSec/H5bJM6NzCoBbII=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jdMQ+/zIKquyBkt/PfqD+TZnzjaZLJ6n64KwcMI1azr5A5F6lXXsT7wmxwtrjbwSOi94Jv1QXvkiM06QhK/3wdUxV9AY5wNttdPSCxo/VES1h93cZcfI4knpatKWhkYe9JaWRz0kVo7gNg7SGHk+Uolug95vLTpmi28WwZHTS/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jZm2gFpl; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E54AC41C06;
	Mon, 16 Jun 2025 11:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750075045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4FLWwkVH6DEVcvVT08KYgNqjz3qTwYhk8sdZO+Ozrho=;
	b=jZm2gFpl1r5AR9tCK4wkoWaAfQ9rtsbE5xbxClDNOXdsW/bGcvNRujZMA1IAUDEIASF1Mu
	jaOfqrQH1YV5vI9vhYeFExJmtEvOuif5O5pA6OpWX8qHRw/7xOne0H8jrQyuE8KGdvYUmW
	+ush8Ud7Ufn3Ru0JuhmrnnK3BrNjdE6lLZSe/PBAF8YmVp6EmPGt95fEYuwJOBDP0+fIqh
	48kdrHgKekJtlGGhFQ/1seG9aR+KilV9KlOScignSVQbqiYpOwJjWHX+2gSDplne9O6tA7
	n0QSDDVLqWOt6OWxzWufjUCZ4QYFwjnK5833QhiTAWjki7iAf4dFJpET0XuzWA==
Date: Mon, 16 Jun 2025 13:57:22 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Rob Herring
 <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
 <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v13 02/13] net: pse-pd: Add support for
 reporting events
Message-ID: <20250616135722.2645177e@kmaincent-XPS-13-7390>
In-Reply-To: <20250614121843.427cfc42@kernel.org>
References: <20250610-feature_poe_port_prio-v13-0-c5edc16b9ee2@bootlin.com>
	<20250610-feature_poe_port_prio-v13-2-c5edc16b9ee2@bootlin.com>
	<20250614121843.427cfc42@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvieehudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefguddtfeevtddugeevgfevtdfgvdfhtdeuleetffefffffhffgteekvdefudeiieenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvjedprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepohdrrhgvmhhpvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiiv
 ghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepughonhgrlhgurdhhuhhnthgvrhesghhmrghilhdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

Le Sat, 14 Jun 2025 12:18:43 -0700,
Jakub Kicinski <kuba@kernel.org> a =C3=A9crit :

> On Tue, 10 Jun 2025 10:11:36 +0200 Kory Maincent wrote:
> > +static struct net_device *
> > +pse_control_find_net_by_id(struct pse_controller_dev *pcdev, int id,
> > +			   netdevice_tracker *tracker)
> > +{
> > +	struct pse_control *psec, *next;
> > +
> > +	mutex_lock(&pse_list_mutex);
> > +	list_for_each_entry_safe(psec, next, &pcdev->pse_control_head,
> > list) { =20
>=20
> nit: _safe is not necessary here, the body of the if always exits after
> dropping the lock

Indeed, I will drop it.

> Do you plan to add more callers for this function?
> Maybe it's better if it returns the psec pointer with the refcount
> elevated. Because it would be pretty neat if we could move the=20
> ethnl_pse_send_ntf(netdev, notifs, &extack); that  pse_isr() does
> right after calling this function under the rtnl_lock.
> I don't think calling ethnl_pse_send_ntf() may crash the kernel as is,
> but it feels like a little bit of a trap to have ethtool code called
> outside of any networking lock.

Ok. My aim was to put the less amount of code inside the rtnl lock but if y=
ou
prefer I will call ethnl_pse_send_ntf() with the lock acquired.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

