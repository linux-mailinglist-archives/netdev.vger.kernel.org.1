Return-Path: <netdev+bounces-180867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 942C6A82BE3
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 18:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DB5018997FB
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 16:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2ED1C5D7A;
	Wed,  9 Apr 2025 16:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JL8EOc5U"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12CC2561CC;
	Wed,  9 Apr 2025 16:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744214488; cv=none; b=FXs7xf18ZTgKZPb0IGccJsHHkyP7OI6TrS7XFgpq5pe6D9yNzVjfaDMSHm3eiHbmPAEiqhP6kIHFW/I2glwE69jEU2AxQ67Q6/GMJAI5stYpkKDRGfoDUk+wxzrTq7vpTPrFVFU7BxLkHv3l/7g54YU6zl412OqLRB2Yu52rNF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744214488; c=relaxed/simple;
	bh=0u5bAlhyzUTkQjn8mO8HV7RJ6HPAVrpDfucNCvnu8pM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OKOtNABNovp0tw3CmOCiNwSrcvV8D9UWsxqd9g6JgGeoQXWuRgFyB+rU2dBfIeDdfQV4OdqEDrYZQpYrWRkg94BqRVydV7upSRdiIFvKqfC6hs5fnxRZNLlFPT6qoCbmGiFOPLJGMer5L23CO05rLcCW6eFDGIvDIxFHOLt60ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JL8EOc5U; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F010244416;
	Wed,  9 Apr 2025 16:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744214482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QASM93YoBn1cH19f+hF6k4ieDhMQtmf59MfvRZCYBw8=;
	b=JL8EOc5UQ0nu9M2/wr6h8ohj5UkaYIp1nn8pgRqDO19EwTZ94rWxQG26TQYOkT2JsyKcLQ
	A15UxGRS7Ww8pMbJp1LaEKS2lqme+S5XoiWKL4HuYMYPugbnoIXWzItcKTyb2dtpN7iv1S
	Mwb7jx1+tDhksDfnaoxhi52281Ij4kkVGDgqYsgxr6ixy/6FBF9BK2LsQM0KkfIv/jmWB3
	TxPU0q6goN+1upwillBiyF8QBPmE8IO5ytmu2vCook+GhAjH4l/3SpFJo2jqiRdcfAoehD
	V1a5Y02gfHw1oXf7WDb3pMGNBlwP2bp7FcILoCBa92BlYq3dZl0jqMNy0XL5HQ==
Date: Wed, 9 Apr 2025 18:01:20 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, Richard
 Cochran <richardcochran@gmail.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: phy: Add Marvell PHY PTP support
Message-ID: <20250409180120.61353f37@kmaincent-XPS-13-7390>
In-Reply-To: <Z_aTjBrUw79skcAg@shell.armlinux.org.uk>
References: <20250407-feature_marvell_ptp-v2-0-a297d3214846@bootlin.com>
	<20250407-feature_marvell_ptp-v2-2-a297d3214846@bootlin.com>
	<Z_aTjBrUw79skcAg@shell.armlinux.org.uk>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeigeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepffeffffhheduhedvvddvgeevveeuveehheefveeuleeguefftedujedvffevteetnecuffhomhgrihhnpehtvghrmhgsihhnrdgtohhmpdgsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudegpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnv
 ghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehkrggsvghlsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: kory.maincent@bootlin.com

On Wed, 9 Apr 2025 16:34:36 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Mon, Apr 07, 2025 at 04:03:01PM +0200, Kory Maincent wrote:
> > From: Russell King <rmk+kernel@armlinux.org.uk>
> >=20
> > From: Russell King <rmk+kernel@armlinux.org.uk>
> >=20
> > Add PTP basic support for Marvell 88E151x PHYs. These PHYs support
> > timestamping the egress and ingress of packets, but does not support
> > any packet modification.
> >=20
> > The PHYs support hardware pins for providing an external clock for the
> > TAI counter, and a separate pin that can be used for event capture or
> > generation of a trigger (either a pulse or periodic).  This code does
> > not support either of these modes.
> >=20
> > The driver takes inspiration from the Marvell 88E6xxx DSA and DP83640
> > drivers.  The hardware is very similar to the implementation found in
> > the 88E6xxx DSA driver, but the access methods are very different,
> > although it may be possible to create a library that both can use
> > along with accessor functions.
> >=20
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> >=20
> > Add support for interruption.
> > Fix L2 PTP encapsulation frame detection.
> > Fix first PTP timestamp being dropped.
> > Fix Kconfig to depends on MARVELL_PHY.
> > Update comments to use kdoc. =20
>=20
> Would you mind forwarding me the changes you actually made so I can
> integrate them into the version I have (which is structured quite
> differently from - what I assume - is a much older version of my
> patches please?

I don't know how you want this but here is a diff with your first patch sent
mainline:
https://termbin.com/gzei
There is also a small fix in the tai part:
https://termbin.com/6a18

> The PTP IP is re-used not only in Marvell PHY drivers but also their
> DSA drivers, and having it all in drivers/net/phy/ as this version
> has does not make sense.

Ok, didn't know that.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

