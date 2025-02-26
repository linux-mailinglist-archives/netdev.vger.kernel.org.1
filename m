Return-Path: <netdev+bounces-169913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E47A466C3
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 17:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E860173E40
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 16:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D10221546;
	Wed, 26 Feb 2025 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lDPSTg2f"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA9B22069A;
	Wed, 26 Feb 2025 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740587282; cv=none; b=YsvHBetAEr5FV84kZ5EkvVPgadce3JZACMaLTJDRriYcpPuyy06EcD9kVDLN0eiRdhp13CkxTnKQKkQSidncYO+1eAmXUxItLR5QmIMpLD/fhQv3PMDEQI2FKE+af8EehmejIpjDRkneUYolwv+/Txfd3PREc9xtgZXAu0+5yJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740587282; c=relaxed/simple;
	bh=+CJnwpM3+mYhb/baNTRwUdP82sSzeFGR+8cKV8R2Jaw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M+ZRxVnpSkISnlCs4rOC5tETIfJSf2gQPiDNrut28VbPk6TRttTGOy4r30fMmduylcXTurZgCg+Hl8IXmx41WACKRWWRyEefaicWHXP+tVNyCLwDiQLPIrbzkjB3fkWjcWt6FcoIh22ZDSr9r2Mm55z9gACoyI4nM43NDMSXbDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lDPSTg2f; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C618544421;
	Wed, 26 Feb 2025 16:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740587277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U+rOTwaDm+HJIE1QxwBJkpKIsIaJ4w8lQuPLKb8xSMk=;
	b=lDPSTg2fGI4tnkuNQQXNmHL/uceaFcw+Dr6r1NOElk2opoMeJe7utT0IqRefe2C5yEOnAf
	0AjcrlnCYZ9rq8yVET/0r2V/MRzviky7OuvAYjx048eT+qEzgDO9Hgnh1y6qw4YBq3BDGl
	BXA+8O0VZXMnwjQGTAv32W1QzO2/aL8CVVFRG1fYWHrqkcqb3S/I7u4s2NkoMQTuuvQQYR
	HQWlYXhF/lIACwzMnqCNhHhXR8o2zKTSpLV+OOWtv1TV65rIXDUrryTNojPZplas3cw14r
	7k7moZX7mdZzUo5UGvac3VPErFsR+DBPGVAOtoEP6jPIHVJQrUhJvdW0+xlZdA==
Date: Wed, 26 Feb 2025 17:27:54 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Martin Schiller <ms@dev.tdt.de>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, andrew@lunn.ch,
 hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: sfp: add quirk for FS SFP-10GM-T copper
 SFP+ module
Message-ID: <20250226172754.1c3b054b@kmaincent-XPS-13-7390>
In-Reply-To: <b300404d2adf0df0199230d58ae83312@dev.tdt.de>
References: <20250226141002.1214000-1-ms@dev.tdt.de>
	<Z78neFoGNPC0PYjt@shell.armlinux.org.uk>
	<d03103b9cab4a1d2d779b3044f340c6d@dev.tdt.de>
	<20250226162649.641bba5d@kmaincent-XPS-13-7390>
	<b300404d2adf0df0199230d58ae83312@dev.tdt.de>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekhedtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefguddtfeevtddugeevgfevtdfgvdfhtdeuleetffefffffhffgteekvdefudeiieenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgduleemleehrggvmeelfhdttdemrggsvggtmedugehfjeemvgdviegrmedufegttdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeelhegrvgemlehftddtmegrsggvtgemudegfhejmegvvdeirgemudeftgdtpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehmshesuggvvhdrthguthdruggvpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegrnhgurhgvfiesl
 hhunhhnrdgthhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

On Wed, 26 Feb 2025 16:55:38 +0100
Martin Schiller <ms@dev.tdt.de> wrote:

> On 2025-02-26 16:26, Kory Maincent wrote:
> > On Wed, 26 Feb 2025 15:50:46 +0100
> > Martin Schiller <ms@dev.tdt.de> wrote:
> >  =20
> >> On 2025-02-26 15:38, Russell King (Oracle) wrote: =20
>  [...] =20
>  [...] =20
>  [...] =20
> >>=20
> >> OK, I'll rename it to sfp_fixup_rollball_wait. =20
> >=20
> > I would prefer sfp_fixup_fs_rollball_wait to keep the name of the=20
> > manufacturer.
> > It can't be a generic fixup as other FSP could have other waiting time=
=20
> > values
> > like the Turris RTSFP-10G which needs 25s. =20
>=20
> I think you're getting two things mixed up.
> The phy still has 25 seconds to wake up. With sfp_fixup_rollball_wait
> there simply is an additional 4s wait at the beginning before we start
> searching for a phy.

Indeed you are right, I was looking in older Linux sources, sorry.
Still, the additional 4s wait seems relevant only for FS SFP, so it should
be included in the function naming to avoid confusion.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

