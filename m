Return-Path: <netdev+bounces-180646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B751DA8201E
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 10:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32BBB8A0786
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 08:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345592528FC;
	Wed,  9 Apr 2025 08:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="C+3QWfdj"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE09B3D76;
	Wed,  9 Apr 2025 08:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744187505; cv=none; b=Bi/ORIZaCCIXZ3MTsrrdwjSKfm+9tsg6myefCdVNduCFTnsN7ASkj5xFAeS3enSc6VAh8IGXmdwewliP6R6NV3PFDUKmRwChefvglBCd8cUmdCdIcLIARbScxi4hYdufW8nds154hHDD96iJcEaMO2CSzj6jEmhtpajGxQy4qCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744187505; c=relaxed/simple;
	bh=flmCLpSGOvwvlim3TEhlpkEBZpLrsv+Lm2Xaao4j+DU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a1NTW5hQnmTnkQfxwpGs9DbpxWa6iWOQWurkryy3033s65xfuVOJq2H+ajb11U7lIrFYt1e4YAjdzE/6qb2+XG5O6zPojJdmVc54JDTnU70eo5gJ1m16lP0Fcn9Z3zm9nItNnAir1mgh4hlKL+CajH4mFSv/Cl16fDmGzG+hIms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=C+3QWfdj; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 05F6E432F5;
	Wed,  9 Apr 2025 08:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744187494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q6UDxOkI9c5sQpM50GzmrBvmyVrY4RBV9cIKIJIWKuY=;
	b=C+3QWfdjtlFQNnVELMFszi8TbpV2UkoRnPldE0Hxbu48ZmUxeL0lPgY5XPdMKOPu9DqeNb
	x1Pfg/FVSdbd/UBEcy6RhOjZr65aZ8MtBLHOZkakCReoBiTRxn3yudjAi39a+F50Tf9pIe
	wCKvUfiN/t/dmvFxk4rv+qkV0DJ69VdGdyfXNMk7xE/3VZMvdOJb1VDki+fCbFEcFg90zq
	EUSs0daLA7y226iCtDP4o8UlilB4SWbfrI1a85J6K4Y7Sjit21RkzbKCel6ku9S2lIGa4J
	KSJjlDaTOR1VN1YEDF+grSdKbB40NEthEonGCKAwh3SFyytKyzf4sZ2dso/SOQ==
Date: Wed, 9 Apr 2025 10:31:30 +0200
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
Message-ID: <20250409103130.43ab4179@kmaincent-XPS-13-7390>
In-Reply-To: <Z_WJO9g5Al1Yr_LX@shell.armlinux.org.uk>
References: <20250407-feature_marvell_ptp-v2-0-a297d3214846@bootlin.com>
	<Z_P3FKEhv1s0y4d7@shell.armlinux.org.uk>
	<20250407182028.75531758@kmaincent-XPS-13-7390>
	<Z_P-K7mEEH6ProlC@shell.armlinux.org.uk>
	<20250407183914.4ec135c8@kmaincent-XPS-13-7390>
	<Z_WJO9g5Al1Yr_LX@shell.armlinux.org.uk>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdehheduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepheevueefveffvdfgjefhleetueefgfdutddugfeiudefteekgfduhffgleehvdffnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmpdgsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudehpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopegurghvvghmsegur
 ghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehkrggsvghlsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: kory.maincent@bootlin.com

On Tue, 8 Apr 2025 21:38:19 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Mon, Apr 07, 2025 at 06:39:14PM +0200, Kory Maincent wrote:
> > On Mon, 7 Apr 2025 17:32:43 +0100
> > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> > > I'm preferring to my emails in connection with:
> > >=20
> > > https://lore.kernel.org/r/ZzTMhGDoi3WcY6MR@shell.armlinux.org.uk
> > >=20
> > > when I tested your work last time, it seemed that what was merged had=
n't
> > > even been tested. In the last email, you said you'd look into it, but=
 I
> > > didn't hear anything further. Have the problems I reported been
> > > addressed? =20
> >=20
> > It wasn't merged it was 19th version and it worked and was tested, but =
not
> > with the best development design. I have replied to you that I will do =
some
> > change in v20 to address this.
> > https://lore.kernel.org/all/20241113171443.697ac278@kmaincent-XPS-13-73=
90/
> >=20
> > It gets finally merged in v21. =20
>=20
> Okay, so I'm pleased to report that this now works on the Macchiatobin:
>=20
> where phc 2 is the mvpp2 clock, and phc 0 is the PHY.

Great, thank you for the testing!

>=20
> # ethtool -T eth2
> Time stamping parameters for eth2:
> Capabilities:
>         hardware-transmit
>         software-transmit
>         hardware-receive
>         software-receive
>         software-system-clock
>         hardware-raw-clock
> PTP Hardware Clock: 2
> Hardware Transmit Timestamp Modes:
>         off
>         on
>         onestep-sync
>         onestep-p2p
> Hardware Receive Filter Modes:
>         none
>         all
>=20
> So I guess that means that by default it's using PHC 2, and thus using
> the MVPP2 PTP implementation - which is good, it means that when we add
> Marvell PHY support, this won't switch to the PHY implementation.

Yes.

>=20
> Now, testing ethtool:
>=20
> $ ./ethtool --get-hwtimestamp-cfg eth2
> netlink error: Operation not supported
>=20
> Using ynl:
>=20
> # ./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --dump
> tsconfig-get --json '{"header":{"dev-name":"eth2"}}' []
>=20
> So, It's better, something still isn't correct as there's no
> configuration. Maybe mvpp2 needs updating first? If that's the case,
> then we're not yet in a position to merge PHY PTP support.

Indeed mvpp2 has not been update to support the ndo_hwtstamp_get/set NDOs.
Vlad had made some work to update all net drivers to these NDOs but he never
send it mainline:
https://github.com/vladimiroltean/linux/commits/ndo-hwtstamp-v9

I have already try to ping him on this but without success.
Vlad any idea on when you could send your series upstream?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

