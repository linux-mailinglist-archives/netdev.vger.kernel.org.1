Return-Path: <netdev+bounces-109668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 209959297E5
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 14:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98355B20FAF
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 12:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA40C1DFDE;
	Sun,  7 Jul 2024 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DQQYWzK4"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D4C1E498;
	Sun,  7 Jul 2024 12:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720356932; cv=none; b=ISpwuyp1cddrJdcBMfTK5BYaU2o2lhihqr41tZauKgq3wRoCuW0EvLxKArCCCDX0H9ukutIulz4wNKoPe+1d0cyvb77OshmER1zhOJu7Q9VVpy1FcRYYkU72b8akcIg1es/GsQP1/fxvbQExLqGV9T5MjU1w1sSMDvWqrEUhnOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720356932; c=relaxed/simple;
	bh=699Dr1Zzftx7dykQBKJJCEHmbS/vhJfNO9kbYbzbuBw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XKBEn8XQKlWFhUJpfw1LV9mWqMqbZpt3DiXYvNCYOeEyo9WAx3xj0Q/0879EnYDHY4u6GFQ/SGJJu7qCuRNObuQnb+hHZrU2RrIkL3GDSCCD4OEow/mEJ86oeSXOAaF+oAaE/BJc+RmJIZufWWSPqEP4tCoggwMBS7Lp9kanpMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DQQYWzK4; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1832B60003;
	Sun,  7 Jul 2024 12:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720356927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bf1fF8WwiErDA75AsNYKAJh+BycwFxySDUH58lCZ6iY=;
	b=DQQYWzK4nfe8TvCSLPXaPkrU4Jp4Ov33l2pvuxBymaPFP7LXr5/nz57XxpUmJnBZaR4Q/G
	BcXUz1IMEjakNEDx3sSaLSXSnBsOmlSCtMTNZ41K/jnVDMtnh49bORy29oLwsZ1gyvkFC4
	twR2/K7mi4yJo+zD6QiA0sTzYElhZfvKtwKgckR/squSxUdZaVCu4HVadoAYXkNnrX/jN2
	qXKjXZEAZxUruXdfmEuNcTi57ZlgjGIPr/OTpwi7TuPsBikXR2TP9DG2nwyOu72mVotdkJ
	4IDoPnXlUU3WOX93pchqu1+cNCBBbh73Xjmf2POgju0D8O5IMEbWAM6IgmqzCA==
Date: Sun, 7 Jul 2024 14:55:23 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Simon Horman <horms@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Radu
 Pirea <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh
 <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net-next v16 13/14] net: ethtool: Add support for
 tsconfig command to get/set hwtstamp config
Message-ID: <20240707145523.37fdfeec@kmaincent-XPS-13-7390>
In-Reply-To: <20240707082408.GF1481495@kernel.org>
References: <20240705-feature_ptp_netnext-v16-0-5d7153914052@bootlin.com>
	<20240705-feature_ptp_netnext-v16-13-5d7153914052@bootlin.com>
	<20240707082408.GF1481495@kernel.org>
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
X-GND-Sasl: kory.maincent@bootlin.com

On Sun, 7 Jul 2024 09:24:08 +0100
Simon Horman <horms@kernel.org> wrote:

> On Fri, Jul 05, 2024 at 05:03:14PM +0200, Kory Maincent wrote:
>  [...] =20
>=20
> > diff --git a/Documentation/networking/timestamping.rst
> > b/Documentation/networking/timestamping.rst index
> > 5e93cd71f99f..8b864ae33297 100644 ---
> > a/Documentation/networking/timestamping.rst +++
> > b/Documentation/networking/timestamping.rst @@ -493,8 +493,8 @@ implici=
tly
> > defined. ts[0] holds a software timestamp if set, ts[1] is again deprec=
ated
> > and ts[2] holds a hardware timestamp if set.=20
> > =20
> > -3. Hardware Timestamping configuration: SIOCSHWTSTAMP and SIOCGHWTSTAMP
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +3. Hardware Timestamping configuration: ETHTOOL_MSG_TSCONFIG_SET/GET
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =20
>=20
> nit: make htmldocs flags that this title underline is too short
>=20
> ...

Arf, indeed forgot to rebuild the doc, sorry.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

