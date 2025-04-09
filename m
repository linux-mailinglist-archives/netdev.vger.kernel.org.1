Return-Path: <netdev+bounces-180727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD0CA82498
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E73741BC26EA
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 12:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B559925F96A;
	Wed,  9 Apr 2025 12:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jxgW6Uws"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F6E228CA5;
	Wed,  9 Apr 2025 12:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744201396; cv=none; b=MXl5TNWArJEM2VrjzIkT1bRrNX8o+Hf766WMWyg2fthQ3RkB9uyP01YD0hngMLxUqHvvr+scbYa1Wvvf/f6YPZ2W4Xu62hyVTQIN10XvWs/QJHaSNatsqhmN8cu/jHfKV2t1fwNDhl4Pz2g0Y64tRHOLw8DB1+LBjojE2pwMFY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744201396; c=relaxed/simple;
	bh=XEH2xglOVQRjPBywFjA+DC4ijTLX1l4ik7K96V7jCHk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=laHiu9QmWCXXFegM4QLdhcCHxd/VwMThEbHX1zIeJrzZWYhHeVQTB1u/vJpg4LhJgV16FAiymITeQw8DAAaggg3AQfpEtGGMqd8jfT8MXOcyMwfhsnzCmWOVvJkDHKB2XJrHvKUB7pArrl/GNUg2EamKGWat+xNXUQfsbNpJJik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jxgW6Uws; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 48597443E3;
	Wed,  9 Apr 2025 12:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744201392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5KRclEWQlEkNbqTm4wJByZBuTzEdYL/3Arqom4jZWr4=;
	b=jxgW6UwsXCkBDGvH0aAUTkYJnvDQrJEBYAUJIPivQKwxycBntM+LYwPl4v9NIXy9xtJjQq
	RUcFkiVn2WZ3BUgDgh5PQZxRKnP8XxEMThPhZSlPczJFKEgr6j9IDIxmJw/iRtL0IOOr9W
	3pRCstbTmQnpA+h4QH+qwntrQkda4gAI0QS9Z/CTAWW0Q1J838FC1XJpp0Ca2q08K1mq1c
	TDQQ+UVtFKbFdLmIAbUKHMOxfBzQZxbr1i7uqGv7pLQ9TOPTjeK6yJziA1zmN7PUFCJnjB
	3fp2PZXfqdyM68FGkdrgeKQH8o2T/q/bS6sXYIDa/GSr2QHWUhzaxH7048ezVw==
Date: Wed, 9 Apr 2025 14:23:09 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, Richard
 Cochran <richardcochran@gmail.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v2 0/2] Add Marvell PHY PTP support
Message-ID: <20250409142309.45cdd62f@kmaincent-XPS-13-7390>
In-Reply-To: <Z_Y-ENUiX_nrR7VY@shell.armlinux.org.uk>
References: <20250407-feature_marvell_ptp-v2-0-a297d3214846@bootlin.com>
	<Z_P3FKEhv1s0y4d7@shell.armlinux.org.uk>
	<20250407182028.75531758@kmaincent-XPS-13-7390>
	<Z_P-K7mEEH6ProlC@shell.armlinux.org.uk>
	<20250407183914.4ec135c8@kmaincent-XPS-13-7390>
	<Z_WJO9g5Al1Yr_LX@shell.armlinux.org.uk>
	<20250409103130.43ab4179@kmaincent-XPS-13-7390>
	<Z_Yxb6-qclDSWk01@shell.armlinux.org.uk>
	<20250409104637.37301e01@kmaincent-XPS-13-7390>
	<Z_Y-ENUiX_nrR7VY@shell.armlinux.org.uk>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdehleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudehpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguu
 hhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehkrggsvghlsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: kory.maincent@bootlin.com

On Wed, 9 Apr 2025 10:29:52 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Wed, Apr 09, 2025 at 10:46:37AM +0200, Kory Maincent wrote:
> > On Wed, 9 Apr 2025 09:35:59 +0100
> > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> > > Right, and that means that the kernel is not yet ready to support
> > > Marvell PHY PTP, because all the pre-requisits to avoid breaking
> > > mvpp2 have not yet been merged. =20
> >=20
> > Still I don't understand how this break mvpp2.
> > As you just tested this won't switch to the PHY PTP implementation. =20
>=20
> How do I know that from the output? Nothing in the output appears to
> tells me which PTP implementation will be used.
>=20
> Maybe you have some understanding that makes this obvious that I don't
> have.

You are right there is no report of the PTP source device info in ethtool.
With all the design change of the PTP series this has not made through my b=
rain
that we lost this information along the way.

You can still know the source like that but that's not the best.
# ls -l /sys/class/ptp

It will be easy to add the source name support in netlink but which names a=
re
better report to the user?
- dev_name of the netdev->dev and phydev->mdio.dev?
  Maybe not the best naming for the phy PTP source
  (ff0d0000.ethernet-ffffffff:01)
- "PHY" + the PHY ID and "MAC" string?
- Another idea?=20

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

