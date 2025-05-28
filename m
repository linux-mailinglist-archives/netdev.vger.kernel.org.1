Return-Path: <netdev+bounces-193962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2895AC6A24
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 15:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCFF47A7F0A
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 13:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E49286889;
	Wed, 28 May 2025 13:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f5pa5OML"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBB31AC891;
	Wed, 28 May 2025 13:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748438248; cv=none; b=iZrJyYhcLrTLpuvxTsR+5t2nxHqt677QrgSv4taKW1nVqI0KijS9pArmLav4QfEnY+ba5riFw3dIVc440XNHiv8u1F4L7kAo1shUenvHGs+tFiViPL9eDsVDMh13llnNQAqsW4omAQtIe+1KNt4eISWUa8yZp47Zmo9QSJfgMis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748438248; c=relaxed/simple;
	bh=XyqXMFLpjQUAOlJ4J5EDK/pH8DkmZweApWK3C83/s9M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lTwtom7UDk55/6MI0z4C4+F/pyV0v0TSW/kNCxSY7+5AP0t7qQpdC1f4/IGu8YpJGJN31zuJnWHJjSRMOOT7/Lyz/cpr4Rw/dBQMqZa7dBuxZA5RPeeHXDuF3ANT82I52wyGgn2Ye5xZ/yYLVDL5dVirbYnSgEGsr6sx/NFOkm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f5pa5OML; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6A39F43B39;
	Wed, 28 May 2025 13:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1748438238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jhe4l8G7g9CuqxjAYyb4mOmnurWtrgOLitbau5hV8GQ=;
	b=f5pa5OML32eamqT/6wf2JaYwGb0E5OBrE0uNEUr8vEb16KKhlfBTpZDLQHmDC/oAIXmR9t
	vcX791GXDtrvMNye5H6KAGRHoyE3dUpWmtObyq6EskJBei0K/i9c1Tr4phPLQAOKuAzPHA
	vi77pjqXAe+bz+l4KaFY9wvE47MJaWIyyfYpJEChna3qJI07jAqbeQEv/h0M1CjLFQOmes
	rfK8CxgR7KVVBBVCs63WpBYxdL6QLOFCThoNCHt306T6lLopESzqT6oLss/sDpaI5Oj10w
	mONgTGbx2jnBGcMlY5QDvJTbNctGKdnZTt47lbkAlN3/KKQg5tt6FiHHCwkZYQ==
Date: Wed, 28 May 2025 15:17:15 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Rob Herring
 <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
 <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH net-next v12 00/13] Add support for PSE budget
 evaluation strategy
Message-ID: <20250528151715.59b8f738@kmaincent-XPS-13-7390>
In-Reply-To: <8b3cdc35-8bcc-41f6-84ec-aee50638b929@redhat.com>
References: <20250524-feature_poe_port_prio-v12-0-d65fd61df7a7@bootlin.com>
	<8b3cdc35-8bcc-41f6-84ec-aee50638b929@redhat.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvfeefieculddtuddrgeefvddrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefguddtfeevtddugeevgfevtdfgvdfhtdeuleetffefffffhffgteekvdefudeiieenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvkedprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepohdrrhgvmhhpvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtp
 dhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepughonhgrlhgurdhhuhhnthgvrhesghhmrghilhdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

Le Wed, 28 May 2025 09:31:20 +0200,
Paolo Abeni <pabeni@redhat.com> a =C3=A9crit :

> On 5/24/25 12:56 PM, Kory Maincent wrote:
> > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> >=20
> > This series brings support for budget evaluation strategy in the PSE
> > subsystem. PSE controllers can set priorities to decide which ports sho=
uld
> > be turned off in case of special events like over-current.
> >=20
> > This patch series adds support for two budget evaluation strategy.
> > 1. Static Method:
> >=20
> >    This method involves distributing power based on PD classification.
> >    It=E2=80=99s straightforward and stable, the PSE core keeping track =
of the
> >    budget and subtracting the power requested by each PD=E2=80=99s clas=
s.
> >=20
> >    Advantages: Every PD gets its promised power at any time, which
> >    guarantees reliability.
> >=20
> >    Disadvantages: PD classification steps are large, meaning devices
> >    request much more power than they actually need. As a result, the po=
wer
> >    supply may only operate at, say, 50% capacity, which is inefficient =
and
> >    wastes money.
> >=20
> > 2. Dynamic Method:
> >=20
> >    To address the inefficiencies of the static method, vendors like
> >    Microchip have introduced dynamic power budgeting, as seen in the
> >    PD692x0 firmware. This method monitors the current consumption per p=
ort
> >    and subtracts it from the available power budget. When the budget is
> >    exceeded, lower-priority ports are shut down.
> >=20
> >    Advantages: This method optimizes resource utilization, saving costs.
> >=20
> >    Disadvantages: Low-priority devices may experience instability.
> >=20
> > The UAPI allows adding support for software port priority mode managed =
from
> > userspace later if needed.
> >=20
> > Patches 1-2: Add support for interrupt event report in PSE core, ethtool
> > 	     and ethtool specs.
> > Patch 3: Adds support for interrupt and event report in TPS23881 driver.
> > Patches 4,5: Add support for PSE power domain in PSE core and ethtool.
> > Patches 6-8: Add support for budget evaluation strategy in PSE core,
> > 	     ethtool and ethtool specs.
> > Patches 9-11: Add support for port priority and power supplies in PD692=
x0
> > 	      drivers.
> > Patches 12,13: Add support for port priority in TPS23881 drivers.
> >=20
> > Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>=
 =20
>=20
> I'm sorry, even if this has been posted (just) before the merge window,
> I think an uAPI extension this late is a bit too dangerous, please
> repost when net-next will reopen after the merge window.

Ok I will.
Would it be possible to review the netlink part of the series? (patch 2, 7 =
and
8)=20

Regard,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

