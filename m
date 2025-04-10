Return-Path: <netdev+bounces-181152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3F2A83E74
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 11:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4424E4C4596
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C78219A8A;
	Thu, 10 Apr 2025 09:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VgGoUaD6"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C162C20E03C;
	Thu, 10 Apr 2025 09:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744276682; cv=none; b=f0+J5nkm/bHMgTG2Ot/+h+9nsuLbssBjb2g2bz/iIGOqY+LEEFTHRBPKcO3k88MLNdCQhHCqVMBad1YRtUcnt+vLJHYwdpw8v6nWsWMAQ5+jyVfSG7bFYUIVc6sLYs6n3NeKPoBTzrKPbKDR8q1un/tuZ0vp87IHKOIqUoDMg+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744276682; c=relaxed/simple;
	bh=IO/3Ego9f+5DJtF/vnNJ+2LC2rLEHB1MHcACmWPQHhI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Co8LeHHNgzOloz0eVXX1aaGnkE5JUeXSWWB3bE6diJkDiJ3uC3QJdIEbOkptKnfHXMjH2W01/JJB+WQyKhp91CpJCn6OalpEnnd/4slFk7gIV4KL/sT+FXbPaBzzhISSFItLkJO0xIcQdumCTqHlgqNJr2N1pnMCWW9OSccgpss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VgGoUaD6; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0292420481;
	Thu, 10 Apr 2025 09:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744276678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xx/rn+Pcn8MAeb8vgsGEare5ynzXsUjO/f292alQDvc=;
	b=VgGoUaD67e7QIzduf1T5O4ZH80tvdJPoeiaC+L0JAviW6nNR+WLtTLacdTJa5Rztse8EDR
	vyZf01gVGdYk7KfDPkO4kp2CACw/EOsTbrnitRxV09ve5x0OsWisOOVJgcIMJwvosrZ8Jc
	62/yPPzZl8e/wc7S5FS3p2f2KEt4ad63oP1s4UiTS6uNyRzyx4WdOSuIvZ+AuBUbzkhkRo
	jFjjifWe9qb4SfOgyWo7d9MAvCBS3Wk8WNqT0sNLRBC1GGSuy4uUNXYCvtadp3CfFL6D5i
	8XIt+a8yda6nsdgNAeWzsP36v4YVC+P0CBqBkRuJq9vw1PtU+9BJrSlOhE3dPw==
Date: Thu, 10 Apr 2025 11:17:54 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: phy: Add Marvell PHY PTP support
Message-ID: <20250410111754.136a5ad1@kmaincent-XPS-13-7390>
In-Reply-To: <Z/b2yKMXNwjqTKy4@shell.armlinux.org.uk>
References: <20250408154934.GZ395307@horms.kernel.org>
	<Z_VdlGVJjdtQuIW0@shell.armlinux.org.uk>
	<20250409101808.43d5a17d@kmaincent-XPS-13-7390>
	<Z_YwxYZc7IHkTx_C@shell.armlinux.org.uk>
	<20250409104858.2758e68e@kmaincent-XPS-13-7390>
	<Z_ZlDLzvu_Y2JWM8@shell.armlinux.org.uk>
	<20250409143820.51078d31@kmaincent-XPS-13-7390>
	<Z_Z3lchknUpZS1UP@shell.armlinux.org.uk>
	<20250409180414.19e535e5@kmaincent-XPS-13-7390>
	<Z_avqyOX2bi44sO9@shell.armlinux.org.uk>
	<Z/b2yKMXNwjqTKy4@shell.armlinux.org.uk>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdekhedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudehpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopegurghvvghms
 egurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

On Wed, 9 Apr 2025 23:38:00 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Wed, Apr 09, 2025 at 06:34:35PM +0100, Russell King (Oracle) wrote:
> > On Wed, Apr 09, 2025 at 06:04:14PM +0200, Kory Maincent wrote: =20
> > > On Wed, 9 Apr 2025 14:35:17 +0100
> > > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> > >  =20
>  [...] =20
>  [...] =20
>  [...] =20
> > >=20
> > > So you are only testing the mvpp2 PTP. It seems there is something br=
oken
> > > with it. I don't think it is related to my work. =20
> >=20
> > Yes, and it has worked - but probably was never tested with PTPDv2 but
> > with linuxptp. As it was more than five years ago when I worked on this
> > stuff, I just can't remember the full details of the test setup I used.
> >=20
> > I think the reason I gave up running PTP on my network is the problems
> > that having the NIC bound into a Linux bridge essentially means that
> > you can't participate in PTP on that machine. That basically means a
> > VM host machine using a bridge device for the guests can't use PTP
> > to time sync itself.
> >=20
> > Well, it looks like the PHY based timestamping also isn't working -
> > ptp4l says its failing to timestamp transmitted packets, but having
> > added debug, the driver _is_ timestamping them, so the timestamps
> > are getting lost somewhere in the networking layer, or are too late
> > for ptp4l, which only waits 1ms, and the schedule_delayed_work(, 2)=20
> > will be about 20ms at HZ=3D100. Increasing the wait in ptp4l to 100ms
> > still doesn't appear to get a timestamp. According to the timestamps
> > on the debug messages, it's only taking 10ms to return the timestamp.
> >=20
> > So, at the moment, ptp looks entirely non-functional. Or the userspace
> > tools are broken. =20
>=20
> Right, got to the bottom of it at last. I hate linuxptp / ptp4l. The
> idea that one looks at the source, sees this:
>=20
>                 res =3D poll(&pfd, 1, sk_tx_timeout);
>                 if (res < 1) {
>                         pr_err(res ? "poll for tx timestamp failed: %m" :
>                                      "timed out while polling for tx
> timestamp"); pr_err("increasing tx_timestamp_timeout may correct "
>                                "this issue, but it is likely caused by a
> driver bug");
>=20
> finds this in the same file:
>=20
> int sk_tx_timeout =3D 1;
>=20
> So it seemed obvious and logical that increasing that initialiser would
> increase the _default_ timeout... but no, that's not the case, because,
> ptp4l.c does:
>=20
>         sk_tx_timeout =3D config_get_int(cfg, NULL, "tx_timestamp_timeout=
");
>=20
> unconditionally, and config.c has a table of config options along with
> their defaults... meaning that initialiser above for sk_tx_timeout
> means absolutely nothing, and one _has_ to use a config file.
>=20
> With that fixed, ptp4l's output looks very similar to that with mvpp2 -
> which doesn't inspire much confidence that the ptp stack is operating
> properly with the offset and frequency varying all over the place, and
> the "delay timeout" messages spamming frequently. I'm also getting
> ptp4l going into fault mode - so PHY PTP is proving to be way more
> unreliable than mvpp2 PTP. :(

That's really weird. On my board the Marvell PHY PTP is more reliable than =
MACB.
Even by disabling the interrupt.
What is the state of the driver you are using?=20

On my board using the PHY PTP:
# ethtool --set-hwtimestamp-cfg eth0 index 0 qualifier precise
# ptp4l -m -i eth0 -s -2=20
ptp4l[1111.786]: selected /dev/ptp0 as PTP clock
ptp4l[1111.829]: port 1 (eth0): INITIALIZING to LISTENING on INIT_COMPLETE
ptp4l[1111.830]: port 0 (/var/run/ptp4l): INITIALIZING to LISTENING on INIT=
_COMPLETE
ptp4l[1111.831]: port 0 (/var/run/ptp4lro): INITIALIZING to LISTENING on IN=
IT_COMPLETE
ptp4l[1117.896]: selected local clock 2ace59.fffe.e52d8b as best master
ptp4l[1159.456]: port 1 (eth0): new foreign master 0080e1.fffe.4253d0-1
ptp4l[1163.456]: selected best master clock 0080e1.fffe.4253d0
ptp4l[1163.456]: port 1 (eth0): LISTENING to UNCALIBRATED on RS_SLAVE
ptp4l[1165.456]: master offset 797590212440464546 s0 freq      -0 path dela=
y      1368
ptp4l[1166.456]: master offset 797590212440460565 s1 freq   -3981 path dela=
y      1353
ptp4l[1167.456]: master offset        -24 s2 freq   -4005 path delay      1=
353
ptp4l[1167.456]: port 1 (eth0): UNCALIBRATED to SLAVE on MASTER_CLOCK_SELEC=
TED
ptp4l[1168.456]: master offset        -19 s2 freq   -4007 path delay      1=
353
ptp4l[1169.457]: master offset        821 s2 freq   -3173 path delay       =
528
ptp4l[1170.457]: master offset          2 s2 freq   -3745 path delay       =
528
ptp4l[1171.457]: master offset       -295 s2 freq   -4042 path delay       =
578
ptp4l[1172.457]: master offset       -262 s2 freq   -4097 path delay       =
578
ptp4l[1173.457]: master offset       -147 s2 freq   -4061 path delay       =
553
ptp4l[1174.457]: master offset        -42 s2 freq   -4000 path delay       =
525
ptp4l[1175.457]: master offset        -38 s2 freq   -4008 path delay       =
525
ptp4l[1176.457]: master offset        -10 s2 freq   -3992 path delay       =
522
ptp4l[1177.457]: master offset        -29 s2 freq   -4014 path delay       =
525
ptp4l[1178.457]: master offset        -23 s2 freq   -4017 path delay       =
525
ptp4l[1179.457]: master offset          0 s2 freq   -4000 path delay       =
522
ptp4l[1180.458]: master offset          4 s2 freq   -3996 path delay       =
523
ptp4l[1181.458]: master offset         -8 s2 freq   -4007 path delay       =
523
ptp4l[1182.458]: master offset         10 s2 freq   -3992 path delay       =
521
ptp4l[1183.458]: master offset          9 s2 freq   -3990 path delay       =
521
ptp4l[1184.458]: master offset         -7 s2 freq   -4003 path delay       =
523
ptp4l[1185.458]: master offset          4 s2 freq   -3994 path delay       =
523
ptp4l[1186.458]: master offset        -15 s2 freq   -4012 path delay       =
525

> Now, the one thing I can't get rid of is the receive timestamp
> overflow warning - this occurs whenever e.g. ptp4l is restarted,
> and is caused by there being no notification that PTP isn't being
> used anymore.
>=20
> Consequently, we end up with the PHY queuing a timestamp for a Sync
> packet which it sees on the network, but because nothing is wanting
> the packets (because e.g. ptp4l has been stopped) there's no packets
> queued into the receive queue to take this timestamp, so we stop
> polling the PHY for timestamps.
>=20
> If we continue to rapidly poll the PHY, then we could needlessly
> waste cycles - because nothing tells us "we have no one wanting
> hardware timestamps anymore" which seems to be a glaring hole in
> the PTP design.

Maybe ptp4l should disable the tx timestamp mode and the rx filter mode if =
it
stops.=20

> Not setting DISTSOVERWRITE seems like a solution, but that seems to
> lead to issues with timestamps being lost.
>=20
> Well, having spent much of the afternoon and all evening on this,
> and all I see are problems that don't seem to have solutions.

Maxime is also working on a Macchiatobin, I will ask him to test on his sid=
e.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

