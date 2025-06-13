Return-Path: <netdev+bounces-197535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A058EAD9101
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 17:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11CD93BCAE7
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 15:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5381E3775;
	Fri, 13 Jun 2025 15:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DLra/t+u"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCFE2B9A9
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749827966; cv=none; b=dotFtExxiXGEtEV6cBq6WxnnYHznoeBp9VwmCACK+iOW5yJI24x6OCBJ3A9B3zDvSrQobB7XNwB6AaoU0v6j8YOfTWlFWIpU9Ceh7wlzSB1hScAb+xEqj+Kwi2g4kj9/1h/daY0r8VKzbhB49kxlM8Iyy6BNby310F406vLQBXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749827966; c=relaxed/simple;
	bh=p1rhh/fGdmIDGr/TsX0Xs3GyJ/Su4r5ivsgnAQewD+0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rk6GlG9hP9jZqSKJQG91W/gAf7lw0Lq9V7FlZLy3i+a5PJENFN5MTuMW/2FZ2A02mNKIA201vX2lrsKeifV1mJLKC6YPj++EW4iZLxgNzCOeZ07sQvgMDgHZytLoT94sNhv5Ck0nJcKaoXGLNzkP2uWjsr3+/LDK5S4FiCQ21ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DLra/t+u; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4E2F644285;
	Fri, 13 Jun 2025 15:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1749827956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9cBpoogK8ga4z0TyKrRG5zUSu4oFEUuU3w8Uw/LgPLo=;
	b=DLra/t+uvHBZtfIQNREGdk4f7O4t78bZY2YRyKUrXZeotdTWwdrIBQmEZg+ZSwIokjNdTT
	H/7gco3DMufm6ov8aE3J+TAFtOue6FcXwlBzf6+HzTo+b+wad66BURhrq8BVSYKtY9RWjn
	/7uDO49Z94kB4NjM4Oibk+SJofJzyLYsIU9jiFMragaszDreVSUPJenpwIYIiTwROEh5ac
	LAiJYXjne0odCRtJTZR/Dbz9x16HOhAyuobK6Jo0L89XJ5yATlHsKIk10jQtVRKh3s3Jdr
	YozmXHEuDqPls8voGHD+TW33wMOrEAz65KxpfaeYnSoZeyKwS1QbFsQbcqseMg==
Date: Fri, 13 Jun 2025 17:19:13 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH RFC net-next 2/5] ptp: marvell: add core support for
 Marvell PTP v2.1
Message-ID: <20250613171913.11a10645@kmaincent-XPS-13-7390>
In-Reply-To: <Z_9252w9vWiGysiF@shell.armlinux.org.uk>
References: <Z_mI94gkKkBslWmv@shell.armlinux.org.uk>
	<E1u3LtV-000CP1-2C@rmk-PC.armlinux.org.uk>
	<20250416104849.43374926@kmaincent-XPS-13-7390>
	<Z_9252w9vWiGysiF@shell.armlinux.org.uk>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddukedvlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefguddtfeevtddugeevgfevtdfgvdfhtdeuleetffefffffhffgteekvdefudeiieenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgduleemkeehkeejmeejuddttdemfedttgefmeektgehsgemfhdtkegumeegfeegsgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekheekjeemjedutddtmeeftdgtfeemkegthegsmehftdekugemgeefgegspdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohephhhkrghllhifv
 ghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: kory.maincent@bootlin.com

Hello Russell,

Le Wed, 16 Apr 2025 10:22:47 +0100,
"Russell King (Oracle)" <linux@armlinux.org.uk> a =C3=A9crit :

> On Wed, Apr 16, 2025 at 10:48:49AM +0200, Kory Maincent wrote:
> > On Fri, 11 Apr 2025 22:26:37 +0100
> > Russell King <rmk+kernel@armlinux.org.uk> wrote: =20
> > > Provide core support for the Marvell PTP v2.1 implementations, which
> > > consist of a TAI (time application interface) and timestamping blocks.
> > > This hardware can be found in Marvell 88E151x PHYs, Armada 38x and
> > > Armada 37xx (mvneta), as well as Marvell DSA devices.
> > >=20
> > > Support for both arrival timestamps is supported, we use arrival 1 for
> > > PTP peer delay messages, and arrival 0 for all other messages.
> > >=20
> > > External event capture is also supported.
> > >=20
> > > PPS output and trigger generation is not supported.
> > >=20
> > > This core takes inspiration from the existing Marvell 88E6xxx DSA PTP
> > > code and DP83640 drivers. Like the original 88E6xxx DSA code, we
> > > use a delayed work to keep the cycle counter updated, and a separate
> > > delayed work for event capture.
> > >=20
> > > We expose the ptp clock aux work to allow users to support single and
> > > multi-port designs - where there is one Marvell TAI instance and a
> > > number of Marvell TS instances. =20
> >=20
> > ...
> >  =20
> > > +#define MV_PTP_MSGTYPE_DELAY_RESP	9
> > > +
> > > +/* This defines which incoming or outgoing PTP frames are timestampp=
ed */
> > > +#define MV_PTP_MSD_ID_TS_EN	(BIT(PTP_MSGTYPE_SYNC) | \
> > > +				 BIT(PTP_MSGTYPE_DELAY_REQ) | \
> > > +				 BIT(MV_PTP_MSGTYPE_DELAY_RESP))
> > > +/* Direct Sync messages to Arr0 and delay messages to Arr1 */
> > > +#define MV_PTP_TS_ARR_PTR	(BIT(PTP_MSGTYPE_DELAY_REQ) | \
> > > +				 BIT(MV_PTP_MSGTYPE_DELAY_RESP)) =20
> >=20
> > Why did you have chosen to use two queues with two separate behavior?
> > I have tried using only one queue and the PTP as master behaves correct=
ly
> > without all these overrun. It is way better with one queue.
> > Maybe it was not the best approach if you want to use the two queues.  =
 =20
>=20
> First, both queues have the same behaviour.
>=20
> Second, because they *aren't* queues as they can only stamp one message.
> The sync messages come from the master on a regular basis. The delay
> response messages come from the master in response to a delay request
> message, the timing of which is determined by the local slave.
>=20
> If the local end sends a delay request just at the point that the master
> sends a sync message causing the master to immediately follow the sync
> message with the delay response message, then we could get an overrun
> on a single queue - because we'll stamp the sync message and if we don't
> read the timestamp quickly enough, the stamp registers will be busy
> preventing the timestamp of the delay response being captured.

I just come back on this. I think you are wrong.
We are using different registers to save timestamp for departure or arrival
packets.
If there is a sync message and a delay request message (the delay response =
is
not timestamped) at the same time, the sync message timestamp will be save =
in
the departure registers and the delay request timestamp in the arrival regi=
sters
(or the contrary if the Marvell PTP is a follower). There is no possibility=
 to
loose the timestamp on that case, therefore using two registers for arrival
packets is useless.

FYI, I just tested the patch series on the Espressobin which have a mv88e6x=
xx
and the PTP worked well.=20

Do you now If you will have time to send a v2 or should I take the lead on
this series?=20

> With the overruns that I've seen, they've always been on the second
> "queue" and have always been for a sequence number several in the past
> beyond the point that the overrun has been reported. However, the
> packet which the sequence number matches had already been received -
> and several others have also been received. I've been wondering if it's
> a hardware bug, or maybe it's something other bits of the kernel is
> doing wrong.

I think we should drop this as I don't see anything relevant to use two
"queues" except overrun cases.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

