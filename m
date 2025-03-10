Return-Path: <netdev+bounces-173554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8988A59718
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 15:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E61D5188A384
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 14:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F2822A4EF;
	Mon, 10 Mar 2025 14:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EQFIjUpq"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADD71BC3F;
	Mon, 10 Mar 2025 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741615747; cv=none; b=nWFV79oBPvJQeTEgavwfAC/rXy+h/kUw2vH4YN07ekyQ7UreDvCTss6pQcORweAO14r9u0tVoiQYVWBxRie/Pytt6KHtUIfIO2nFK8t0YOKbdtKGqWv0ERxysojkCNgSFXAtefUu3q2vLby2xC9OGOzyJBu0r8/BAyUYi6GCupw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741615747; c=relaxed/simple;
	bh=oRbVaKtnF4PmdP78IKDl4VhfEJ4QclxPJCQxWxPGGZA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KjYEmqX0cWR4DEpJtHejdgJWeu9wk/idiIIV5RlOId5EbVXspGHBojiF1Q4smokX6GALwbz605xVqG2wKw5vL2TncLpXo3D9GFNBiQm26RO7ZXDsdr+W2FUkPDFV67baHvIsXnfpUp+MQE37lz8S3ADJPdk2qJ6QO1w6rlGZ1Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EQFIjUpq; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B4FCC442C0;
	Mon, 10 Mar 2025 14:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741615743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kQoA35KV6qH9O+kb5ibj+NzTP3DR8xoqxecJpDELOu8=;
	b=EQFIjUpqzQoXsi5bWv6Yldt1iIxTAre/8DDmloAsguOEM/KAbhHiUKB5SmIY95uftYh2S0
	ryXaOM0g1bCy4jj3jWqQSHLCIaQuGhaM9w2/AHTYh4kVCOe59zTlIdykZ38nXDwT2ZoCtV
	vUbkM+zulOMuOGwKa/FaFARPqRjoXbRtOwCp8ApzllhIAS8SHOzpR4SLxjUzOmlRQYV0N8
	zzWfQnfG60nLg00bq6/g8izWgwCIC0JtDGTugt2m5aNW972BxgoF5138BNUBdWoMTlS92w
	pqLfd6Vm3xVDC5ktK8S+LFunS0d67Q9n/d0BB75A4A00bSllDCYjdZMwJqysVQ==
Date: Mon, 10 Mar 2025 15:08:58 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Elad Nachman <enachman@marvell.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Taras Chornyi <taras.chornyi@plvision.eu>,
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "thomas.petazzoni@bootlin.com"
 <thomas.petazzoni@bootlin.com>, "miquel.raynal@bootlin.com"
 <miquel.raynal@bootlin.com>, "przemyslaw.kitszel@intel.com"
 <przemyslaw.kitszel@intel.com>, "dkirjanov@suse.de" <dkirjanov@suse.de>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH v2 0/5] Fix prestera driver fail to probe
 twice
Message-ID: <20250310150858.6bbf4114@kmaincent-XPS-13-7390>
In-Reply-To: <BN9PR18MB4251B1533E14523AEADBA22FDB342@BN9PR18MB4251.namprd18.prod.outlook.com>
References: <20240320172008.2989693-1-enachman@marvell.com>
	<4104387a-d7b5-4029-b822-060ef478c6e3@lunn.ch>
	<BN9PR18MB42517F8E84C8C18078E45C37DB322@BN9PR18MB4251.namprd18.prod.outlook.com>
	<89a01616-57c2-4338-b469-695bdc731dee@lunn.ch>
	<BL1PR18MB42488523A5E05291EA57D0AEDB372@BL1PR18MB4248.namprd18.prod.outlook.com>
	<6dae31dc-8c4f-4b8d-80e4-120619119326@lunn.ch>
	<BN9PR18MB4251B1533E14523AEADBA22FDB342@BN9PR18MB4251.namprd18.prod.outlook.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudelheehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepudetgefgvddvkeelvdfgteetkeefvdeghfeivdeiudefkefgkefhveeiteelleevnecuffhomhgrihhnpehprhhoohhfphhoihhnthdrtghomhdpkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppeegiedrudekkedrvdefledruddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepgeeirddukeekrddvfeelrddutddphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudegpdhrtghpthhtohepvghnrggthhhmrghnsehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepthgrrhgrshdrtghhohhrnhihihesphhlvhhishhiohhnrdgvuhdprhgtphhtthhop
 egurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

Hello,=20

I am just coming back to this series of fixes.
Indeed the 30s in case of probe defer are hard to accept but if it solves t=
he
issue for now shouldn't we merge it? Andrew, Jakub what do you think?

If not, we could at least merge patches 3 to 5 which are unrelated.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Regards,


On Wed, 27 Mar 2024 17:27:41 +0000
Elad Nachman <enachman@marvell.com> wrote:

> Hi Andrew,
>=20
> We have made internal technical review of the issues you have raised (ret=
urn
> version API, try to get version API before starting to initialize and load
> the firmware, clear configuration API) versus the delay saved (almost 30
> seconds minus several seconds to perform and complete the API calls) - ar=
ound
> 20 seconds or so.
>=20
> Existing customers we have talked to seem to be able to cope with the
> existing delay.
>=20
> Unfortunately, the amount of coding and testing involved with saving thes=
e 20
> seconds or so is beyond our available development manpower at this specif=
ic
> point in time.
>=20
> Unfortunately, we will have to defer making the development you have
> requested to a later period in time.
>=20
> Elad.
>=20
>=20
> > -----Original Message-----
> > From: Andrew Lunn <andrew@lunn.ch>
> > Sent: Sunday, March 24, 2024 5:25 PM
> > To: Elad Nachman <enachman@marvell.com>
> > Cc: Taras Chornyi <taras.chornyi@plvision.eu>; davem@davemloft.net;
> > edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> > kory.maincent@bootlin.com; thomas.petazzoni@bootlin.com;
> > miquel.raynal@bootlin.com; przemyslaw.kitszel@intel.com;
> > dkirjanov@suse.de; netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [EXTERNAL] Re: [PATCH v2 0/5] Fix prestera driver fail to =
probe
> > twice
> >  =20
>  [...] =20
> > problem. =20
>  [...] =20
> > >
> > > No, the PoE is the general high level application where he noted the =
=20
> > problem. =20
> > > There is no PoE code nor special PoE resources in the Prestera driver=
. =20
> >=20
> > So here is K=C3=B6ry email:
> >=20
> > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> > 3A__lore.kernel.org_netdev_20240208101005.29e8c7f3-40kmaincent-2DXPS-
> > 2D13-2D7390_T_-
> > 23mb898bb2a4bf07776d79f1a19b6a8420716ecb4a3&d=3DDwIDAw&c=3DnKjWec2
> > b6R0mOyPaz7xtfQ&r=3DeTeNTLEK5-
> > TxXczjOcKPhANIFtlB9pP4lq9qhdlFrwQ&m=3DSD1MhKC11sFmp4Q8l76N_DgGdac
> > 4aMCTdPsa7Pofb73HEqAGtJ-1p0-
> > etIyyldC7&s=3DVWat9LPub52H3nUez4itmkpuMipnYD3Ngn-paFC9wd4&e=3D
> >=20
> > I don't see why the prestera needs to be involved in PoE itself. It is =
just
> > a MAC. PoE happens much lower down in the network stack. Same as Preste=
ra
> > uses phylink, it does not need to know about the PHYs or the SFP module=
s,
> > phylink manages them, not prestera.
> >  =20
> > > The problem was caused because the module exit was lacking the so
> > > called "switch HW reset" API call which would cause the firmware to
> > > exit to the firmware loader on the firmware CPU, and move to the state
> > > in the state machine when it can receive new firmware from the host
> > > CPU (running the Prestera switchDev driver).
> > > =20
>  [...] =20
>  [...] =20
>  [...] =20
> > >
> > > There is no existing API/ABI for that. =20
> >=20
> > Do you at least have the ability to determine if an API call exists or =
not?
> > It sounds like your firmware needs extending to support returning the
> > version. If the API is missing, you know it is 4.1 or older. If it does
> > exist, it will return 4.2 or higher.
> >  =20
>  [...] =20
> > >
> > > Exactly.
> > > =20
>  [...] =20
> > >
> > > Right. And there is also the configuration. There is no telling what
> > > kind of Configuration the existing firmware is running. Just using the
> > > existing firmware Will lead to the situation where Linux kernel side
> > > will report certain configuration (via ip link / ip addr / tc , etc.)=
 but
> > > the =20
> > firmware configuration is completely different.
> >=20
> > Well, during probe and -EPRODE_DEFER, linux has no configuration, since=
 the
> > driver failed to probe. However, for a rmmod/modprobe, the firmware cou=
ld
> > have stale configuration. However pretty much every device i've come ac=
ross
> > has the concept of a software reset which clears out the configuration.
> > Seems to be something else your firmware is missing.
> >=20
> > 	Andrew =20



--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

