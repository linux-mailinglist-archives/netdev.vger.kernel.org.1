Return-Path: <netdev+bounces-170321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60490A4825F
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 640D01889D30
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 14:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B389125EFBF;
	Thu, 27 Feb 2025 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BU7cRs5O"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C798725E837;
	Thu, 27 Feb 2025 14:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740668254; cv=none; b=YNvlKj46bgFZy5MxADQAeFdJtMWChojKFycg9+Td/1xiaw8h9JYmGUzmpZjL+OlqEIFCGnHohm5OT4V8mO5HOaEa4EVSAQzTlMwC6VwyiJaHiTNaquY0m4x8rAV8+afYfAi12nBM1BZ8Yhk5byvMaXkHHr7jLPJR2G6asVzaV20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740668254; c=relaxed/simple;
	bh=RlenwtE5mxdv5cb/MEos3p+JmVXLB2yGNlafSdQiqDk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cLyWgsw9GpWkWlBV0fP6KEFQ9dKbc4WTPbCG9tziODZ7bSKLwuoH39ZmJ8L5zApPXs21Imhjal+SfThgKmCworNmo6kuiHejXqTxPLFaGfb3pD9b2sggEO49cmL5FFoYh+uIA6x45Yks+nGKzRi1VnT8nJNNbdFrc9sASDFvyXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BU7cRs5O; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 79B34441AB;
	Thu, 27 Feb 2025 14:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740668250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vxxXj7qHDUKOxFYzmRI0KA+MFriKrU/fu0NUeDhbg/4=;
	b=BU7cRs5OtfDkPDMGdgZwKTlTc5pmwx2JLI94bxKT/RK1ESGqwqZbYREl5ZEO0xxobAguDz
	x7xX8uP5TrtRexTxHHMTjKle1BcWMPnoc2QV4gsf6L1tOTjiBe99bbZmYl2eDU9hG33LmO
	uZENFBdzrcafa1Ebx9BYhNcXQTREL/ysPxNnvq5ubwzpKms1OxOWUKERpcgoSYZZ7ELn5g
	IpuVo5M0I6ZKPbwz/EjjfTkxxpim5QMKhaXw/+uEeycd7JNmlSlKcrsa3eutNxMEbZFxPE
	qb/+97DCYh0XjqGadp/wzZD6ysAsOrz1HLEbNnW7c912m2EAo70YLJQf2qy9pw==
Date: Thu, 27 Feb 2025 15:57:27 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Donald Hunter
 <donald.hunter@gmail.com>, Rob Herring <robh@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 06/12] net: pse-pd: Add support for budget
 evaluation strategies
Message-ID: <20250227155727.7bdc069f@kmaincent-XPS-13-7390>
In-Reply-To: <Z8AW6S2xmzGZ0y9B@pengutronix.de>
References: <20250218-feature_poe_port_prio-v5-0-3da486e5fd64@bootlin.com>
	<20250218-feature_poe_port_prio-v5-6-3da486e5fd64@bootlin.com>
	<20250220165129.6f72f51a@kernel.org>
	<20250224141037.1c79122b@kmaincent-XPS-13-7390>
	<20250224134522.1cc36aa3@kernel.org>
	<20250225102558.2cf3d8a5@kmaincent-XPS-13-7390>
	<20250225174752.5dbf65e2@kernel.org>
	<Z76t0VotFL7ji41M@pengutronix.de>
	<Z76vfyv5XoMKmyH_@pengutronix.de>
	<20250226184257.7d2187aa@kernel.org>
	<Z8AW6S2xmzGZ0y9B@pengutronix.de>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekjeejiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedukeejleefheelgeevffdugfeggeduudekgeelgfdviedvkedugefhffekudetvdenucffohhmrghinhephhhpvgdrtghomhdptghishgtohdrtghomhdpsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvgedprhgtphhtthhopehordhrvghmphgvlhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtr
 dhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepughonhgrlhgurdhhuhhnthgvrhesghhmrghilhdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

On Thu, 27 Feb 2025 08:40:25 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Wed, Feb 26, 2025 at 06:42:57PM -0800, Jakub Kicinski wrote:
> > On Wed, 26 Feb 2025 07:06:55 +0100 Oleksij Rempel wrote: =20
> > > Here is one example how it is done by HP switches:
> > > https://arubanetworking.hpe.com/techdocs/AOS-CX/10.08/HTML/monitoring=
_6200/Content/Chp_PoE/PoE_cmds/pow-ove-eth-all-by.htm
> > >=20
> > > switch(config)# interface 1/1/1    <---- per interface
> > > switch(config-if)# power-over-ethernet allocate-by usage
> > > switch(config-if)# power-over-ethernet allocate-by class
> > >=20
> > > Cisco example:
> > > https://www.cisco.com/c/en/us/td/docs/switches/datacenter/nexus9000/s=
w/93x/power-over-ethernet/configuration/configuring-power-over-ethernet/m-c=
onfiguring-power-over-ethernet.html
> > >=20
> > > switch(config)# interface ethernet1/1   <---- per interface
> > > switch(config-if)# power inline auto =20
> >=20
> > I don't see any mention of a domain in these docs.
> > This patchset is creating a concept of "domain" but does=20
> > not expose it as an object. =20
>=20
> Ok, I see. @K=C3=B6ry, can you please provide regulator_summary with some
> inlined comments to regulators related to the PSE components and PSE
> related outputs of ethtool (or what ever tool you are using).
>=20
> I wont to use this examples to answer.

On my side, I am not close to using sysfs. As we do all configurations thro=
ugh
ethtool I have assumed we should continue with ethtool.
I think we should set the port priority through ethtool, but indeed the PSE
power domain method get and set could be moved to sysfs as it is not someth=
ing
relative to the port but to a group of ports. Ethtool should still report t=
he
PSE power domain ID of a port to know which domain the port is.

@Oleksij here it is:

# cat /sys/kernel/debug/regulator/regulator_summary
 regulator                      use open bypass  opmode voltage current    =
 min     max
---------------------------------------------------------------------------=
------------
 regulator-dummy                  5    4      0 unknown     0mV     0mA    =
 0mV     0mV=20
    d00e0000.sata-target          1                                 0mA    =
 0mV     0mV
    d00e0000.sata-phy             1                                 0mA    =
 0mV     0mV
    d00e0000.sata-ahci            1                                 0mA    =
 0mV     0mV
    spi0.0-vcc                    1                                 0mA    =
 0mV     0mV
 pse-reg                          1    4      0 unknown     0mV     0mA    =
 0mV     0mV=20
    pse-0-0020_pi0                0    1      0 unknown 53816mV  2369mA    =
 0mV     0mV=20
       0-0020-pse-0-0020_pi0      0                                 0mA    =
 0mV     0mV
    pse-0-0020_pi2                0    1      0 unknown 53816mV  2369mA    =
 0mV     0mV=20
       0-0020-pse-0-0020_pi2      0                                 0mA    =
 0mV     0mV
    pse-0-0020_pi7                0    1      0 unknown 53816mV  2369mA    =
 0mV     0mV=20
       0-0020-pse-0-0020_pi7      0                                 0mA    =
 0mV     0mV
 pse-reg2                         1    2      0 unknown     0mV     0mA    =
 0mV     0mV=20
    pse-0-0020_pi1                0    0      0 unknown 53816mV  4738mA    =
 0mV     0mV=20
 vcc_sd1                          2    1      0 unknown  1800mV     0mA  18=
00mV  3300mV=20
    d00d0000.mmc-vqmmc            1                                 0mA  18=
00mV  1950mV

# ./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do pse-get -=
-json
 '{"header":{"dev-name":"wan"}}'
{'c33-pse-admin-state': 2,
 'c33-pse-avail-pw-limit': 127500,
 'c33-pse-pw-d-status': 2,
 'c33-pse-pw-limit-ranges': [{'max': 99900, 'min': 2000}],
 'header': {'dev-index': 4, 'dev-name': 'wan'},
 'pse-budget-eval-strat': 2,
 'pse-prio': 0,
 'pse-prio-max': 8,
 'pse-pw-d-id': 1}

# ./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do pse-set -=
-json
 '{"header":{"dev-name":"wan"}, "pse-prio":1}'
None
# ./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do pse-set -=
-json
'{"header":{"dev-name":"wan"}, "c33-pse-avail-pw-limit":15000}'
None

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

