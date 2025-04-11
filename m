Return-Path: <netdev+bounces-181542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02543A85608
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 10:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C8F18A0C55
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 08:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949AA27D771;
	Fri, 11 Apr 2025 08:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mej3UVJt"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26F5347C7;
	Fri, 11 Apr 2025 08:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744358495; cv=none; b=t95ZFZnVGI7khNk4oCLTRDxYhrcYU35pJdX3+OkQi9xx8RzYVPb6cQpKVA6sRoXl4GwUIUTOUwPaMhDiOU3g7kVS60kiNcxmwbWZZgz9HHYkZzQFPmpk2Hw9qHwZ/PTMhzqQl2czB39526QkvyXfohxeDzg4qXHhWIsgCPWWi6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744358495; c=relaxed/simple;
	bh=KZm48Ee0dY4BND+gulrPULD8FLTexvDyk+vj9T09f5k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VJAaHRe0O2FIxZufJMing5FZ2e0zc/X5CZpkR8OVSasrtrOnp0g4VfiaOUUVYx/eQN+px5uv+UqxkLcGgbsWy/6sqZeZCRwjQZCcgOUV146yB1sym6ETSCmb++uiO3knf7QABVsYpOt4Z4Y1l1tuJrGxmbo+Cyj2MX4Tmk0s6BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mej3UVJt; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B44624445D;
	Fri, 11 Apr 2025 08:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744358490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KZm48Ee0dY4BND+gulrPULD8FLTexvDyk+vj9T09f5k=;
	b=mej3UVJtWnapYhuTY1SE/Xb5/KHbqDkUCkPPr/ZVeNaolyd6mQTNrfFXPCQhnQkIlESYzx
	2h67vK6WWXz8mKWsTgojDMb+f35gVQtgl61RYlHXM/MYwAZfzAgQe13Jw84T4HfXXjeLaE
	mmdQZhnvrpVVZsG3TM7hW6PruDxsfNGEliomtbhSu0+KCpzm1lv9b6eUN0d0c2vjVAuyzb
	9E7Vj1hsxYfKjyYtqZTY5HKY7ZIY0A9vDiB0Wwx+btWQ5NjT+m2Eyn8dB/wkRXpcrOAOMl
	vSE7oL7Cwh8SsTm3jDDAThEp0KV0xF1jmulJMPyXp0w4HZ3B4pNg5wGv5Ij7Qg==
Date: Fri, 11 Apr 2025 10:01:27 +0200
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
Message-ID: <20250411100127.2d87812f@kmaincent-XPS-13-7390>
In-Reply-To: <Z/genHfvbvll09XT@shell.armlinux.org.uk>
References: <Z_ZlDLzvu_Y2JWM8@shell.armlinux.org.uk>
	<20250409143820.51078d31@kmaincent-XPS-13-7390>
	<Z_Z3lchknUpZS1UP@shell.armlinux.org.uk>
	<20250409180414.19e535e5@kmaincent-XPS-13-7390>
	<Z_avqyOX2bi44sO9@shell.armlinux.org.uk>
	<Z/b2yKMXNwjqTKy4@shell.armlinux.org.uk>
	<20250410111754.136a5ad1@kmaincent-XPS-13-7390>
	<Z_fmkuPhqMqWBL2M@shell.armlinux.org.uk>
	<20250410180205.455d8488@kmaincent-XPS-13-7390>
	<Z_gLD8XFlyG32D6L@shell.armlinux.org.uk>
	<Z/genHfvbvll09XT@shell.armlinux.org.uk>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudduvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudelmeekheekjeemjedutddtmegsvgdvjeemvggstgegmegvtgdvfhemvghfvgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkeehkeejmeejuddttdemsggvvdejmegvsggtgeemvggtvdhfmegvfhgvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudehpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgur
 hgvfieslhhunhhnrdgthhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

On Thu, 10 Apr 2025 20:40:12 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Thu, Apr 10, 2025 at 07:16:47PM +0100, Russell King (Oracle) wrote:
> > On Thu, Apr 10, 2025 at 06:02:05PM +0200, Kory Maincent wrote: =20
> > > On Thu, 10 Apr 2025 16:41:06 +0100
> > > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> > > It seems you are still using your Marvell PHY drivers without my chan=
ge.
> > > PTP L2 was broken on your first patch and I fixed it.
> > > I have the same result without the -2 which mean ptp4l uses UDP IPV4.=
 =20
> >=20
> > I'm not sure what you're referring to. =20
>=20
> Okay, turns out to be nothing to do with any fixes in my code or not
> (even though I still don't know what the claimed brokenness you
> refer to actually was.)

If I remember well you need the PTP global config 1 register set to 3 to ha=
ve
the L2 PTP working.

> It turns out to be that ptpdv2 sends PTP packets using IPv4 UDP *or*
> L2, and was using IPv4 UDP. Adding "ptpengine:transport=3Dethernet" to
> the ptpdv2 configuration allows ptp4l -2 to then work.

Ack.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

