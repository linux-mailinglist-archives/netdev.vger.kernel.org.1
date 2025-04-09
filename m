Return-Path: <netdev+bounces-180654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95B1A8207E
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 10:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04B737A3870
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 08:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D717F25A322;
	Wed,  9 Apr 2025 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SKwNBoIT"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF5F2288D2;
	Wed,  9 Apr 2025 08:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744188491; cv=none; b=gpvgvdzFVwFNncxClIetNwevNlB9/TNKsChUO18Kae/SvTzAwpGCd8LupERl2maYQ3dyQ4Qk4BI72ahRtXzYDCX0yOqensRn7pQJ634kwetdaGlFJyxZR4opoRHC5RQHV7S3qic6nmrTbGT661cB66/yRZOqkKzcB/w2IPeiPPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744188491; c=relaxed/simple;
	bh=FzxkBb1sdpsvb1R+Xxx7Gu9t6Q85IJ9bl5cql5GOxtA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IC9+2Thcn6I4FMsxFZ7vkwwrMeHJe5/dgTt2Ui9F/h4tZsgneckDunTbsYByHGPSKPoeFTOLy+PJLYlv9DPpApNyv1l0Jv9LncC2VUI8oCo9YJrp9So3nvCaS6INY8AJUmhdtF6nkiJVRckxHBjzKfKLWqUItC02MIdoBLdGaNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SKwNBoIT; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EAE0E4341A;
	Wed,  9 Apr 2025 08:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744188485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aPTGt9yMl6HsU79oGJNd6ommK+J3iAILEVJiqKGZx9E=;
	b=SKwNBoITBBe4BIh9bZug+5VeFetvlGqPf2/hu4Ov+UCIM2FGQCbNNgIDJcXX6tWbRjHOtb
	AX2EUaeyS2nLedufzkzJCOGECqlteNZiYxcK6viSD8VnOtTEReku+B8fHv2z1WYLjESMPF
	5fP9t4YSj/ff+OtV1jsCnjPQSuYFqje2/mm/jFlP07GRaG85DRqxsKC6qnUq8G3hUexGfO
	zHkfPxqDJOCGl2mwcc13bLooNqKftmM2/4+Q/YOl4jfe+3xN+aAwGEO6scmCqoYaYZhVWN
	n1h40tBcOtOOOZJbCas/9b+vspbu5jyA44S1ubSVBcMADiGWaQLEEMuABO6KtA==
Date: Wed, 9 Apr 2025 10:48:03 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Marek =?UTF-8?B?QmVo?=
 =?UTF-8?B?4oia4oirbg==?= <kabel@kernel.org>, Richard Cochran
 <richardcochran@gmail.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/2] Add Marvell PHY PTP support
Message-ID: <20250409104803.20ed97d4@kmaincent-XPS-13-7390>
In-Reply-To: <20250409083835.pwtqkwalqkwgfeol@skbuf>
References: <20250407-feature_marvell_ptp-v2-0-a297d3214846@bootlin.com>
	<Z_P3FKEhv1s0y4d7@shell.armlinux.org.uk>
	<20250407182028.75531758@kmaincent-XPS-13-7390>
	<Z_P-K7mEEH6ProlC@shell.armlinux.org.uk>
	<20250407183914.4ec135c8@kmaincent-XPS-13-7390>
	<Z_WJO9g5Al1Yr_LX@shell.armlinux.org.uk>
	<20250409103130.43ab4179@kmaincent-XPS-13-7390>
	<Z_Yxb6-qclDSWk01@shell.armlinux.org.uk>
	<20250409083835.pwtqkwalqkwgfeol@skbuf>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdehheehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepuddtffeljeeihfdtheefvdffjeejtdfgfeefheeffefhjeejvedvfeduudfftdeunecuffhomhgrihhnpehgihhthhhusgdrtghomhdprghrmhhlihhnuhigrdhorhhgrdhukhdpsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduhedprhgtphhtthhopehvlhgrughimhhirhdrohhlthgvrghnsehngihprdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhop
 ehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

On Wed, 9 Apr 2025 11:38:35 +0300
Vladimir Oltean <vladimir.oltean@nxp.com> wrote:

> On Wed, Apr 09, 2025 at 09:35:59AM +0100, Russell King (Oracle) wrote:
> > On Wed, Apr 09, 2025 at 10:31:30AM +0200, Kory Maincent wrote: =20
> > > On Tue, 8 Apr 2025 21:38:19 +0100
> > > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> > >  =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
> > >=20
> > > Great, thank you for the testing!
> > >  =20
>  [...] =20
> > >=20
> > > Yes.
> > >  =20
>  [...] =20
> > >=20
> > > Indeed mvpp2 has not been update to support the ndo_hwtstamp_get/set =
NDOs.
> > > Vlad had made some work to update all net drivers to these NDOs but he
> > > never send it mainline:
> > > https://github.com/vladimiroltean/linux/commits/ndo-hwtstamp-v9
> > >=20
> > > I have already try to ping him on this but without success.
> > > Vlad any idea on when you could send your series upstream? =20
> >=20
> > Right, and that means that the kernel is not yet ready to support
> > Marvell PHY PTP, because all the pre-requisits to avoid breaking
> > mvpp2 have not yet been merged.
> >=20
> > So that's a NAK on this series from me.
> >=20
> > I'd have thought this would be obvious given my well known stance
> > on why I haven't merged Marvell PHY PTP support before.
> >=20
> > --=20
> > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last! =20
>=20
> I will try to update and submit that patch set over the course of this
> weekend.

That's great, thanks for the update status!

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

