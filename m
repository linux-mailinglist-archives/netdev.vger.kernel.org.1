Return-Path: <netdev+bounces-179689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65810A7E23F
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCB4D4412E3
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 14:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403191F417F;
	Mon,  7 Apr 2025 14:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N75LMDfh"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD9B1F3B9C;
	Mon,  7 Apr 2025 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744036284; cv=none; b=dZYsriucRvN6xE5BVYfvAhq6zt4sY0q5ftElQRuB2fWfI7hRGDV5P8QBJEAfz2dTKd0hPqmlSNYHHLaKJpNiP1dPtyNXJlHd02ARmDrL39cHacLa3vmfZ1iXc4EY7r6G7G4p8QCH8Za43rXY19w1q2tAbg+4Epi/Qw9j9EETxQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744036284; c=relaxed/simple;
	bh=0hRyxWlx6HgukjGUYoDEVDWNH8w5UOV+wlvIoU3NPho=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E8dDsI1riDOXe7ntleNoDAVmlb38HQ3NwrA5MZHPfupKrw3NbM5+aqTOavOmhGKvRhfT2RGn9NS30b9+AcARaqaYgDDalwOox1y9jxSsx4uSsfKChTQlGrMuoCJfN6RPoFoaVo2bX5SvAiI9T0YaB3H34PjLCwSmyB78zhBXR3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N75LMDfh; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 76B2620481;
	Mon,  7 Apr 2025 14:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744036280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0hRyxWlx6HgukjGUYoDEVDWNH8w5UOV+wlvIoU3NPho=;
	b=N75LMDfhdhs+1nDVkmhr1ImBO/G6CckheKTs38STMTGH/vQLrvTONzmmi8OWIxwuEBUVLy
	DqtFzW2xA0bW0u0hDwQ4r0pMd9s72//69+FLOSIEQ4iUl05JAeimbg6o21w/w0xX8v+9cy
	HNX+grtC7yUFoO57kRvcpLZTkIP71vzQAev/ig95JzTWJ/Lpe0pCkSHq0542/JVa7GOqp5
	cZMWj6/p/xnPecHESzao60fOCLu0WwEHqtzZjKBg2ZzWcps64+WDpwp9dSAP/HQIEyBm8q
	KAsK69QLP2Bv0XHwtutSyfc00LTVcdDU+iUhbEr/NKY4pMlXwZtE6xirqF3Qkg==
Date: Mon, 7 Apr 2025 16:31:18 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH net-next v2 0/2] Add Marvell PHY PTP support
Message-ID: <20250407163118.6a326a98@kmaincent-XPS-13-7390>
In-Reply-To: <fdfef9fd-6f9a-428f-b97f-deb52186e2f8@lunn.ch>
References: <20250407-feature_marvell_ptp-v2-0-a297d3214846@bootlin.com>
	<fdfef9fd-6f9a-428f-b97f-deb52186e2f8@lunn.ch>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtgeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfduveekuedtvdeiffduleetvdegteetveetvdelteehhfeuhfegvdeuuedtleegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduhedprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvt
 hdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepkhgrsggvlheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 7 Apr 2025 16:08:04 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Mon, Apr 07, 2025 at 04:02:59PM +0200, Kory Maincent wrote:
> > Add PTP basic support for Marvell 88E151x PHYs. =20
>=20
> Russell has repeatedly said this will cause regressions in some setups
> where there are now two PTP implementations, and the wrong one will be
> chosen by default. I would expect some comments in the commit message
> explaining how this has been addressed, so it is clear a regression
> will not happen.

This was fixed by the following patch series which have parts that get merg=
ed
along the way to version 21. It adds support to select the hardware PTP
provider and change the default to MAC PTP for newly introduced PHY PTP sup=
port
(default_timestamp flag in phy_device struct).
https://lore.kernel.org/netdev/20241212-feature_ptp_netnext-v21-0-2c282a941=
518@bootlin.com/

I will add the description in v3. I will wait at least one week to let peop=
le
review the patch.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

