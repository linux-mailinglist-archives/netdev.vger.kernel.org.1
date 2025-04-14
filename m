Return-Path: <netdev+bounces-182307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13870A88742
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635FF188BF17
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D2D19F130;
	Mon, 14 Apr 2025 15:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EOJpbGNA"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28C62DFA59
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 15:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744644103; cv=none; b=LqkgUriZE8HOuixebyKkXghUDifnDKwCC4ELEUdXGykheCTBfHNPQCsABgPC8EMV2OmuVlpFxWiS3TsRdtaz/l1/BFA53akaAFAmaEKH3QNAUhJA2raXAjYTCZbbuwyajloizf1lAKjklSMfTZRHorCgETSyFYvUHHLIAIoetSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744644103; c=relaxed/simple;
	bh=MoBr0aJA5pVta4gEYDaJzktdE+ov5SotnJErFmqQ38M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c92jBB72I7As0rwI2C4JQhiQ1vB1h/WzMJfu+0RQST/zA7nnBZ637ZudqIos+NbZ3rp4iD4X2Sa+RhNvqsDW/dk9oIj8yufuQbHf39pCkShLZ3PuJi+rEE3/pgt6VDM5a1yTAmmfhBXNlmU5T2UxU4uiX1mIYj5aa3w3F3Qq9XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EOJpbGNA; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4870043AD3;
	Mon, 14 Apr 2025 15:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744644099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ygapjmNPvOfET8QFT+iYp9P/E0tbINpCsgwxNw4u+uA=;
	b=EOJpbGNAvBGJsog+iV3mGnUiU43jnLrFLeyazrKwL02RHkMBSCJct49n9g2t1Nba8obfuO
	Es/R/vK6g2WMoKd0Klwkg8pDBn6blqNlq+Rjb7SepNZbI6IrnLXl1dyPLQwoeImvAU3Y2g
	5U+NEfCS3Vqgasymbub26D9DCD3gjTZ9um6ntnHDfZ3g+rShIpXWty+jpNomxo7yeNX5nH
	d+ST4u5NW1dG5P+iDZ08ZSeHOBrW9JBJx+/s1eU2eslopMktC/+nr0gydSBBiVH8ICsVlH
	5IE+lt01swB7sl8+LGHO1JSlppKb7PxTgWEM7J/LDEOkrxboze5zBlLAMV8TQw==
Date: Mon, 14 Apr 2025 17:21:37 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>
Subject: Re: [PATCH RFC net-next 3/5] net: phy: add Marvell PHY PTP support
Message-ID: <20250414172137.42e98e29@kmaincent-XPS-13-7390>
In-Reply-To: <Z_0hzd7Bl6ECzyBB@shell.armlinux.org.uk>
References: <Z_mI94gkKkBslWmv@shell.armlinux.org.uk>
	<E1u3Lta-000CP7-7r@rmk-PC.armlinux.org.uk>
	<20250414164314.033a74d2@kmaincent-XPS-13-7390>
	<Z_0hzd7Bl6ECzyBB@shell.armlinux.org.uk>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddtledtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguu
 hhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 14 Apr 2025 15:55:09 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Mon, Apr 14, 2025 at 04:43:14PM +0200, Kory Maincent wrote:
> > On Fri, 11 Apr 2025 22:26:42 +0100
> > Russell King <rmk+kernel@armlinux.org.uk> wrote:
> >  =20
> > > Add PTP basic support for Marvell 88E151x single port PHYs.  These
> > > PHYs support timestamping the egress and ingress of packets, but does
> > > not support any packet modification, nor do we support any filtering
> > > beyond selecting packets that the hardware recognises as PTP/802.1AS.
> > >=20
> > > The PHYs support hardware pins for providing an external clock for the
> > > TAI counter, and a separate pin that can be used for event capture or
> > > generation of a trigger (either a pulse or periodic). Only event
> > > capture is supported.
> > >=20
> > > We currently use a delayed work to poll for the timestamps which is
> > > far from ideal, but we also provide a function that can be called from
> > > an interrupt handler - which would be good to tie into the main Marve=
ll
> > > PHY driver.
> > >=20
> > > The driver takes inspiration from the Marvell 88E6xxx DSA and DP83640
> > > drivers. The hardware is very similar to the implementation found in
> > > the 88E6xxx DSA driver, but the access methods are very different,
> > > although it may be possible to create a library that both can use
> > > along with accessor functions. =20
> >=20
> > It seems a lot less stable than the first version of the driver.
> >=20
> > Lots of overrun:
> > ptp4l[949.894]: port 1 (eth0): assuming the grand master role
> > [  954.899275] Marvell 88E1510 ff0d0000.ethernet-ffffffff:01: tx timest=
amp
> > overrun (stat=3D0x5 seq=3D0) [  954.908670] Marvell 88E1510
> > ff0d0000.ethernet-ffffffff:01: rx timestamp overrun (q=3D1 stat=3D0x5 s=
eq=3D0) =20
>=20
> I've explained why this happens - it will occur if timestamping has
> been enabled but there's been no packets to be stamped for a while
> but there _have_ been packets on the network that the hardware
> decided to stamp. There is no way around this because the driver isn't
> told when to shutdown timestamping.

Yes but I didn't faced this on your first version. Maybe there is a way to
avoid this.
I have not yet dive into your code to check the changes but I will.
=20
> > PTP L2 in master mode is not working at all maybe because there is no
> > configuration of PTP global config 1 register. =20
>=20
> No, sorry, wrong. There is, and you haven't read what I've written
> previously if you're still thinking this.
>=20
> Look in "ptp: marvell: add core support for Marvell PTP v2.1".
>=20
> Look at marvell_tai_global_config(). (I've explained why it's there.)
>=20
> Look at:
>=20
> +       /* MsdIDTSEn - Enable timestamping on all PTP MessageIDs */
> +       err =3D tai->ops->ptp_global_write(tai->dev, PTPG_CONFIG_1,
> +                                        MV_PTP_MSD_ID_TS_EN);

Oop sorry, missed that custom ops.
=20
> > Faced also a case where it has really high offsets and I need to reboot=
 the
> > board to see precise synchronization again:
> > ptp4l[4649.618]: port 1: LISTENING to UNCALIBRATED on RS_SLAVE
> > ptp4l[4652.519]: master offset 7650600217 s0 freq +32767998 path delay
> > -33923681843 ptp4l[4653.487]: master offset 7617827584 s1 freq      +6 =
path
> > delay -33923681843 ptp4l[4654.454]: master offset     -27201 s2 freq
> > -27195 path delay -33923681843 ptp4l[4654.454]: port 1: UNCALIBRATED to
> > SLAVE on MASTER_CLOCK_SELECTED ptp4l[4655.422]: master offset 339268796=
73
> > s2 freq +32767999 path delay -67850561538 ptp4l[4656.389]: master offset
> > 33649307442 s2 freq +32767999 path delay -67605734496 ptp4l[4657.356]:
> > master offset 33454635535 s2 freq +32767999 path delay -67443834753 =20
>=20
> I don't see that, I get way smaller offsets with this when using the
> ZII rev B platform as the master.
>=20
> > The PTP set as master mode seems really buggy. =20
>=20
> That's something I didn't test, but as the hardware is symmetrical (there
> aren't separate settings for PTP MSGIDs that get stamped on the transmit
> and receive paths) I'm not sure what's going on. If one enables
> timestamping for MSG ID 0 (Sync) then the hardware will stamp packets
> received and transmitted that have a PTP MSG ID 0.
>=20
> In any case, I can't do any testing now, sorry.

Yes, I will investigate.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

