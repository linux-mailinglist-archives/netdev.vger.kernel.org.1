Return-Path: <netdev+bounces-180653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE943A8207B
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 10:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CDD61688DA
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 08:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A130D25D200;
	Wed,  9 Apr 2025 08:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="doUC5u26"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2E52288D2;
	Wed,  9 Apr 2025 08:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744188409; cv=none; b=FEz1IwwtlEflVGLJCPKCC/RINHVldlryyTS9Eu/AZAVoxIYr8WL0pWgTqS8Y7/oJ5A+dQ4JEodcyVM67QZDPmV+eESzgDF50b3CMFzeDdanlBYcC8gt9UlGL5BVl6wbKynTTeGpEGDZP76EV9AT86Wk6L6WGNbn5fkMPeL0beyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744188409; c=relaxed/simple;
	bh=ELTQItVKPoTP7c+nLyur/J7OnfuqLK8egZ3hcfXIwEU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FOQshlLUwEpLBnxV1W65ELXX3W3Ien/OrOSHt3zdgu4iT1QhDpF4crVgO+qKK2f3g+Wg8/aLCdJl3ZFt7p5VzYb3sG3B/Ky3TO3x6sNrA51yogXgP7cxlxo6DY1xqdY/RRite7/AMmvdGSor3UsSkpOD3gNLkoUkM+Jx1r0gBHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=doUC5u26; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8934C432E9;
	Wed,  9 Apr 2025 08:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744188399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3TZpZwYgRJlFfqY27EAxiIvEVz1LTIr3mhT89//HxqA=;
	b=doUC5u26REQCP+TR+0/XXqfQjyyx++QbY+Ds8v7EQmfsUFk3r2ofW7q6yC4Le1DZnZ9fSp
	iURp9q2uZbYpD/mK/hDO2T+5E2rf5OcqsXts+VS4qQpvGlNQYVBzpiOALkSWeybPJrGdPV
	5YHH25C0ufggccBRSp0yWTBWf3cDkohogWzgQAZxJ6PbzujFz2LKRDlviE2qMWPvQqT6WS
	uR4ywY9g5Ajt7BYBvH5A6VAhpT3o1wG3syYVPqhpbutEK05+bncoRbhf585ThtqzFwd8lS
	bDq+JAN6R4Q6BYjCrIkv0+TxJrE9MCk6F6O1gRNce5KDgstTKITOC/4cGM3s9g==
Date: Wed, 9 Apr 2025 10:46:37 +0200
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
Message-ID: <20250409104637.37301e01@kmaincent-XPS-13-7390>
In-Reply-To: <Z_Yxb6-qclDSWk01@shell.armlinux.org.uk>
References: <20250407-feature_marvell_ptp-v2-0-a297d3214846@bootlin.com>
	<Z_P3FKEhv1s0y4d7@shell.armlinux.org.uk>
	<20250407182028.75531758@kmaincent-XPS-13-7390>
	<Z_P-K7mEEH6ProlC@shell.armlinux.org.uk>
	<20250407183914.4ec135c8@kmaincent-XPS-13-7390>
	<Z_WJO9g5Al1Yr_LX@shell.armlinux.org.uk>
	<20250409103130.43ab4179@kmaincent-XPS-13-7390>
	<Z_Yxb6-qclDSWk01@shell.armlinux.org.uk>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdehheehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptefgfeffgeelkeeugfejkeetveeffeelveetffefgeeuhfffjeejvdfgueeltdffnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduhedprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvt
 hdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepkhgrsggvlheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: kory.maincent@bootlin.com

On Wed, 9 Apr 2025 09:35:59 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Wed, Apr 09, 2025 at 10:31:30AM +0200, Kory Maincent wrote:
> > On Tue, 8 Apr 2025 21:38:19 +0100
> > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> >  =20
> > > On Mon, Apr 07, 2025 at 06:39:14PM +0200, Kory Maincent wrote: =20
>  [...] =20
>  [...] =20
>  [...] =20
> > >=20
> > > Okay, so I'm pleased to report that this now works on the Macchiatobi=
n:
> > >=20
> > > where phc 2 is the mvpp2 clock, and phc 0 is the PHY. =20
> >=20
> > Great, thank you for the testing!
> >  =20
> > >=20
> > > # ethtool -T eth2
> > > Time stamping parameters for eth2:
> > > Capabilities:
> > >         hardware-transmit
> > >         software-transmit
> > >         hardware-receive
> > >         software-receive
> > >         software-system-clock
> > >         hardware-raw-clock
> > > PTP Hardware Clock: 2
> > > Hardware Transmit Timestamp Modes:
> > >         off
> > >         on
> > >         onestep-sync
> > >         onestep-p2p
> > > Hardware Receive Filter Modes:
> > >         none
> > >         all
> > >=20
> > > So I guess that means that by default it's using PHC 2, and thus using
> > > the MVPP2 PTP implementation - which is good, it means that when we a=
dd
> > > Marvell PHY support, this won't switch to the PHY implementation. =20
> >=20
> > Yes.
> >  =20
> > >=20
> > > Now, testing ethtool:
> > >=20
> > > $ ./ethtool --get-hwtimestamp-cfg eth2
> > > netlink error: Operation not supported
> > >=20
> > > Using ynl:
> > >=20
> > > # ./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --dump
> > > tsconfig-get --json '{"header":{"dev-name":"eth2"}}' []
> > >=20
> > > So, It's better, something still isn't correct as there's no
> > > configuration. Maybe mvpp2 needs updating first? If that's the case,
> > > then we're not yet in a position to merge PHY PTP support. =20
> >=20
> > Indeed mvpp2 has not been update to support the ndo_hwtstamp_get/set ND=
Os.
> > Vlad had made some work to update all net drivers to these NDOs but he =
never
> > send it mainline:
> > https://github.com/vladimiroltean/linux/commits/ndo-hwtstamp-v9
> >=20
> > I have already try to ping him on this but without success.
> > Vlad any idea on when you could send your series upstream? =20
>=20
> Right, and that means that the kernel is not yet ready to support
> Marvell PHY PTP, because all the pre-requisits to avoid breaking
> mvpp2 have not yet been merged.

Still I don't understand how this break mvpp2.
As you just tested this won't switch to the PHY PTP implementation. The old
usage of using SIOCG/SHWTSTAMP will still work, you simply won't be able to=
 use
the new netlink feature of switching between the two PTP as long as
ndo_hwtstamp_get/set NDOs is not supported in mvpp2.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

