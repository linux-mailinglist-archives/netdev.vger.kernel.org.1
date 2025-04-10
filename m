Return-Path: <netdev+bounces-181343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FF2A8492D
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 18:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 838BE188851C
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 16:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F361EC018;
	Thu, 10 Apr 2025 16:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lYjEnBBp"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB737189F5C;
	Thu, 10 Apr 2025 16:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300937; cv=none; b=ur5KTuUrKcJOYa4ygy5KyK7LjCin/RdpL+NkiQgQvvzQtHbGsrXZWIAQo3898WmWJMmJz0ity1SvgL/rY15s5eyA32RQZGtB/xxhix7WBNmpNuPkNVr2I8u/u7Tn4Wxe/djK1XMTmDa6WyeAZk8uPnVVEFj20t9lLHukR4T7vn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300937; c=relaxed/simple;
	bh=D3r1imQhIqhuLnALHMnDOhpLM6osMmH+dNnVd3Iu1mg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EYvOhUb+GYWel9scWw5O8fng2kTIzRo8x0zACyBDt/bzt1os2YFUSnZKVw49VYpC1h892SNfXGbmYhPzUHtEq1kWkAKGHjWoEd3Kg4Mb/lzx6Cln62MIc42V+Fa9MDIFo+lzq7Bpz3Ym7BV05xoYzB+8M91OukqbbJGBDGcDH7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lYjEnBBp; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2318C44536;
	Thu, 10 Apr 2025 16:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744300927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zynQ21FxEu/wyvbjhcfMThiWf9gT/Ox0I1AHhTYa89I=;
	b=lYjEnBBpJoeEUvpfKfB1oqLwVZij5oN4gHWsH5hs3aO8Nk4kNswWdpAHsfxHU1wAwrJzVH
	grb0W3lECk2UmND4OAo4C95Wat0lWXavWLK8rAtd1qRTYrueFvtkOOoMqlAfHE89st4G+C
	KNwr3cpX9wuH3RS9IuMEaQRcFPOjLPuJvJe9QLCjEklElqRE2Fe7m73UxCDjSkjcM3kS27
	acOVnkgzBzJIK4qLPTEXDDYUcYpkxi8MrLmXrd7K2F/G6nHCU8bwleRDTif3E6AXhe2MqI
	9Dxj61G1vnpv3lrpb+MB/3kL5Edt7ypRzK0IzPff+Y7UJNe6aTI4f4m7TRh3gg==
Date: Thu, 10 Apr 2025 18:02:05 +0200
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
Message-ID: <20250410180205.455d8488@kmaincent-XPS-13-7390>
In-Reply-To: <Z_fmkuPhqMqWBL2M@shell.armlinux.org.uk>
References: <20250409101808.43d5a17d@kmaincent-XPS-13-7390>
	<Z_YwxYZc7IHkTx_C@shell.armlinux.org.uk>
	<20250409104858.2758e68e@kmaincent-XPS-13-7390>
	<Z_ZlDLzvu_Y2JWM8@shell.armlinux.org.uk>
	<20250409143820.51078d31@kmaincent-XPS-13-7390>
	<Z_Z3lchknUpZS1UP@shell.armlinux.org.uk>
	<20250409180414.19e535e5@kmaincent-XPS-13-7390>
	<Z_avqyOX2bi44sO9@shell.armlinux.org.uk>
	<Z/b2yKMXNwjqTKy4@shell.armlinux.org.uk>
	<20250410111754.136a5ad1@kmaincent-XPS-13-7390>
	<Z_fmkuPhqMqWBL2M@shell.armlinux.org.uk>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdelfeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudehpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopegurghvvghms
 egurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

On Thu, 10 Apr 2025 16:41:06 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Thu, Apr 10, 2025 at 11:17:54AM +0200, Kory Maincent wrote:
> > On Wed, 9 Apr 2025 23:38:00 +0100
> > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote: =20
> > > On Wed, Apr 09, 2025 at 06:34:35PM +0100, Russell King (Oracle) wrote=
: =20

> > >=20
> > > With that fixed, ptp4l's output looks very similar to that with mvpp2=
 -
> > > which doesn't inspire much confidence that the ptp stack is operating
> > > properly with the offset and frequency varying all over the place, and
> > > the "delay timeout" messages spamming frequently. I'm also getting
> > > ptp4l going into fault mode - so PHY PTP is proving to be way more
> > > unreliable than mvpp2 PTP. :( =20
> >=20
> > That's really weird. On my board the Marvell PHY PTP is more reliable t=
han
> > MACB. Even by disabling the interrupt.
> > What is the state of the driver you are using?  =20
>=20
> Right, it seems that some of the problems were using linuxptp v3.0
> rather than v4.4, which seems to work better (in that it doesn't
> seem to time out and drop into fault mode.)
>=20
> With v4.4, if I try:
>=20
> # ./ptp4l -i eth2 -m -s -2
> ptp4l[322.396]: selected /dev/ptp0 as PTP clock
> ptp4l[322.453]: port 1 (eth2): INITIALIZING to LISTENING on INIT_COMPLETE
> ptp4l[322.454]: port 0 (/var/run/ptp4l): INITIALIZING to LISTENING on
> INIT_COMPLETE ptp4l[322.455]: port 0 (/var/run/ptp4lro): INITIALIZING to
> LISTENING on INIT_COMPLETE ptp4l[328.797]: selected local clock
> 005182.fffe.113302 as best master
>=20
> that's all I see. If I drop the -2, then:

It seems you are still using your Marvell PHY drivers without my change.
PTP L2 was broken on your first patch and I fixed it.
I have the same result without the -2 which mean ptp4l uses UDP IPV4.
=20
> and from that you can see that the offset and frequency are very much
> all over the place, not what you would expect from something that is
> supposed to be _hardware_ timestamped - which is why I say that NTP
> seems to be superior to PTP at least here.
>=20
> With mvpp2, it's a very similar story:

> ptp4l[628.834]: master offset      38211 s2 freq  -29874 path delay     6=
2949
> ptp4l[629.834]: master offset     -41111 s2 freq  -97733 path delay     6=
6289
> ptp4l[630.834]: master offset      33131 s2 freq  -35824 path delay     6=
3864
> ptp4l[631.834]: master offset     -55578 s2 freq -114594 path delay     6=
3864
> ptp4l[632.833]: master offset      34110 s2 freq  -41579 path delay     5=
7582
> ptp4l[633.834]: master offset     -13137 s2 freq  -78593 path delay     6=
0047
> ptp4l[634.834]: master offset      55063 s2 freq  -14334 path delay     4=
9425
> ptp4l[635.834]: master offset     -41302 s2 freq  -94180 path delay     4=
9425

I can't tell about mvpp2 as I don't have board with this MAC but these valu=
es
seem really high and vary a lot. As this behavior is similar between the Ma=
rvell
PHY or the mvpp2 MAC maybe the issue comes indeed from your link partner.=20

> Again, offset all over the place, frequency also showing that it doesn't
> stabilise.
>=20
> This _could_ be because of the master clock being random - but then it's
> using the FEC PTP implementation with PTPD v2 - maybe either the FEC
> implementation is buggy or maybe it's PTPD v2 causing this. I have no
> idea how I can debug this - and I'm not going to invest in a "grand
> master" PTP clock on a whim just to find out that isn't the problem.
>=20
> I thought... maybe I can use the PTP implementation in a Marvell
> switch as the network master, but the 88E6176 doesn't support PTP.
>=20
> Maybe I can use an x86 platform... nope:
>=20
> # ethtool -T enp0s25
> Time stamping parameters for enp0s25:
> Capabilities:
>         software-transmit
>         software-receive
>         software-system-clock

Still you could try with timestamping from software on the link partner.
On my side I am using a STM32MP157-DK as link partner.

If I set the DK board as PTP master and tell it to use software PTP (-S
parameter) it is still more reliable than yours.
ptp4l[4419.134]: master offset        136 s2 freq   -1984 path delay    118=
390
ptp4l[4420.134]: master offset       1757 s2 freq    -322 path delay    115=
888
ptp4l[4421.134]: master offset      -1154 s2 freq   -2706 path delay    115=
888
ptp4l[4422.134]: master offset      -1652 s2 freq   -3551 path delay    115=
888
ptp4l[4423.134]: master offset      -1199 s2 freq   -3593 path delay    115=
252

> PTP Hardware Clock: none
> Hardware Transmit Timestamp Modes: none
> Hardware Receive Filter Modes: none
>=20
> Anyway, let's try taking a tcpdump on the x86 machine of the sync
> packets and compare the deviation of the software timestamp to that
> of the hardware timestamp (all deviations relative to the first
> packet part seconds):
>=20
> 16:30:30.577298 - originTimeStamp : 1744299061 seconds, 762464622 nanosec=
onds
> 16:30:31.577270 - originTimeStamp : 1744299062 seconds, 762363987 nanosec=
onds
>    -28us						-100.635us
> 16:30:32.577303 - originTimeStamp : 1744299063 seconds, 762429696 nanosec=
onds
>    +85us						-34.926us
> 16:30:33.577236 - originTimeStamp : 1744299064 seconds, 762328728 nanosec=
onds
>    -62us						-135.894us
> 16:30:34.577280 - originTimeStamp : 1744299065 seconds, 762398770 nanosec=
onds
>    -18us						-65.852us
>=20
> We can see here that the timestamp from the software receive is far
> more regular than the origin timestamp in the packets, which, in
> combination with the randomness of both mvpp2 and the 88e151x PTP
> trying to sync with it, makes me question whether there is something
> fundamentally wrong with the FEC PTP implementation / PTPDv2.

So we come to the same conclusion, the issue comes from your link partner! =
;)

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

