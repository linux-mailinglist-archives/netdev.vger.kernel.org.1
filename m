Return-Path: <netdev+bounces-169918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 151E7A46788
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 18:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7532D17D324
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 17:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6086B21C9E9;
	Wed, 26 Feb 2025 17:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UCMKzmC6"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DFF1DE2A9;
	Wed, 26 Feb 2025 17:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740589240; cv=none; b=LOV0zVpk4aKW4r6LfMkvvEBx8DPt6dQpIHCEd7hR2EED8XqCldYXSal1mOpdm9+Tvza11pg8U4cZVL7g1JIsE6rUUoytYQvQPqgDq19UgDlkgLB6SyZ8jX1SVrRFkYuORqMT2xMxqJQoSCenCqySs6uJKz7z4qPf1h2PUPrRYiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740589240; c=relaxed/simple;
	bh=as/rxyivHk6qYSCy6Dl+SlKl3s4ZaumMyqnaRx29FYs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F8gBl2lqjN7m7G4E82/c/r7XAB0lJyVfhgD7ygCsV1bp1fF9iONEsrZ5ejW4N7Cp+TCFMWP1iVMrsd1lvhidn0D/PQy0yAChC2oKxdPX65rCtfEzMgOPPHBtZo3MyImn1FzIrLzJ2f7HpKHud3YM4n71EGfcf3Mh+9TrO2R766I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UCMKzmC6; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A24C71F687;
	Wed, 26 Feb 2025 17:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740589235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a/HQt0AoDb+k3+XX8xsB7vdc/4Es82oRu2Uz9GkCQW0=;
	b=UCMKzmC6XIXsMaNnDiavmRgUHlvzryvgemkKqBj45PmRJPGCnZxCbxYYNYPSgrxrjPWmkH
	vJcpaViueIugGx18ze8qDeQe83r41+p5Qbn9DSFTTioYCfuT0SIgynJqM8pts6mJxagFtk
	19qb3rysjfUwBbCWIh/LkAXFKlxpDmSJsb21fKG+XsrcrNUAwLM3FmVv41bCCJGSY8PubP
	x6aO8qUtzNioh0ttzFtysFyxoonCtjS2dKP4oTHy6MjOFrXVoBCmlMG67VPKSetcOWq0LB
	OdMMT03iwKOwgnPnbDYrzh2RScByD7XGyeI4s/2pzqvj1eNPpyvAFkHb93Y/fw==
Date: Wed, 26 Feb 2025 18:00:33 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Martin Schiller <ms@dev.tdt.de>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, andrew@lunn.ch,
 hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: sfp: add quirk for FS SFP-10GM-T copper
 SFP+ module
Message-ID: <20250226180033.260070d7@kmaincent-XPS-13-7390>
In-Reply-To: <daec1a6fe2a16988b0b0e59942a94ca9@dev.tdt.de>
References: <20250226141002.1214000-1-ms@dev.tdt.de>
	<Z78neFoGNPC0PYjt@shell.armlinux.org.uk>
	<d03103b9cab4a1d2d779b3044f340c6d@dev.tdt.de>
	<20250226162649.641bba5d@kmaincent-XPS-13-7390>
	<b300404d2adf0df0199230d58ae83312@dev.tdt.de>
	<20250226172754.1c3b054b@kmaincent-XPS-13-7390>
	<daec1a6fe2a16988b0b0e59942a94ca9@dev.tdt.de>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekhedufecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefguddtfeevtddugeevgfevtdfgvdfhtdeuleetffefffffhffgteekvdefudeiieenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgduleemleehrggvmeelfhdttdemrggsvggtmedugehfjeemvgdviegrmedufegttdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeelhegrvgemlehftddtmegrsggvtgemudegfhejmegvvdeirgemudeftgdtpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehmshesuggvvhdrthguthdruggvpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegrnhgurhgvfiesl
 hhunhhnrdgthhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

On Wed, 26 Feb 2025 17:51:42 +0100
Martin Schiller <ms@dev.tdt.de> wrote:

> On 2025-02-26 17:27, Kory Maincent wrote:
> > On Wed, 26 Feb 2025 16:55:38 +0100
> > Martin Schiller <ms@dev.tdt.de> wrote:
> >  =20
> >> On 2025-02-26 16:26, Kory Maincent wrote: =20
>  [...] =20
>  [...] =20
> >>  [...]
> >>  [...]
> >>  [...] =20
>  [...] =20
>  [...] =20
> >>=20
> >> I think you're getting two things mixed up.
> >> The phy still has 25 seconds to wake up. With sfp_fixup_rollball_wait
> >> there simply is an additional 4s wait at the beginning before we start
> >> searching for a phy. =20
> >=20
> > Indeed you are right, I was looking in older Linux sources, sorry.
> > Still, the additional 4s wait seems relevant only for FS SFP, so it=20
> > should
> > be included in the function naming to avoid confusion.
> >  =20
>=20
> You may be right for the moment. But perhaps there will soon be SFP
> modules from other manufacturers that also need this quirk.
>=20
> There is also the function sfp_fixup_rollball_cc, which is currently
> only used for modules with vendor string =E2=80=9COEM=E2=80=9D. However, =
the function is
> not called sfp_fixup_oem_rollball_cc.

Indeed. As you prefer then.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

