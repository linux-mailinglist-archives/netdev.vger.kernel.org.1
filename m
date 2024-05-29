Return-Path: <netdev+bounces-99091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A0B8D3B61
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 17:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 382B11C220E1
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 15:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818D8180A92;
	Wed, 29 May 2024 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jFBmb0sV"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68E015B115;
	Wed, 29 May 2024 15:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716997842; cv=none; b=Ac5ipkSECrdYLpdkAk+ehCTjP9RZNjTu4Nw5g8h75XY8HPJvAB98cZPbJM0KZCwwauyuUX6NJkjd3YihKrjiEeGbLaKqx0cWNgVR6a6kI3vI9yrdNHINvqhmyRnjYOzG2btcMBB9QG6MdoExCdBEGlJUapn6rdBzKsdaQwomizo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716997842; c=relaxed/simple;
	bh=RhAYFzXtfNlXMtgT1RAKcn5Jr1WKF4VqdAZ6qcmROyc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oYnuSoWTe5YbG/o1hfQ1vc1u+wexThAjbU3d6jsYp34DRrzDrmgkZk5pNWaGBsoalqcto9xO9yERDZgJj6NrorSgXZwkvxsy2gNkLF+DU7tlAUrroKRmnc4SpsBaTJZIUqyYggvgvqh3KTy1nzxvZPDbryfEsRfk93VLEJ4Ym8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jFBmb0sV; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A102A1BF20A;
	Wed, 29 May 2024 15:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716997835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RhAYFzXtfNlXMtgT1RAKcn5Jr1WKF4VqdAZ6qcmROyc=;
	b=jFBmb0sV0ClEp3mLGt45IXoCfM5VWXz56T/1CJgcB19hyMJYPR0tn+k+k4L/t8wUPiqbd0
	HO6jk9Em5BHNtc8mQxOfxEWSjY9TIVEvq2c55371PNPbbd324ehX5AMh5cgeKxXhclF65s
	q2Fxk28Zh3Pjb4iITVVHXtXNp7UuW1sOTF6IJWQKZ0Z9l3441Y8MWoRm+GqME6U0MEc2+E
	CGH86tTmYZAEU4ugb1ps7Q6HX0f45PPIGftCZ6F9yUwLbWxANOTFc/wC6ny+z9PVEtG3bH
	Ny1Ce7z00cbHrw6wff/P9F6bSK1yFq9l4PmslSWj3EPXBWXcQZSnBDPdoI7xqw==
Date: Wed, 29 May 2024 17:50:32 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Radu Pirea
 <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net-next v13 09/14] net: Add the possibility to support
 a selected hwtstamp in netdevice
Message-ID: <20240529175032.54070c60@kmaincent-XPS-13-7390>
In-Reply-To: <20240529082111.1a1cbf1e@kernel.org>
References: <20240529-feature_ptp_netnext-v13-0-6eda4d40fa4f@bootlin.com>
	<20240529-feature_ptp_netnext-v13-9-6eda4d40fa4f@bootlin.com>
	<20240529082111.1a1cbf1e@kernel.org>
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

On Wed, 29 May 2024 08:21:11 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Wed, 29 May 2024 11:39:41 +0200 Kory Maincent wrote:
> > Introduce the description of a hwtstamp provider which is define with a
> > ptp_clock pointer and a qualifier value.
> >=20
> > Add a hwtstamp provider description within the netdev structure to be a=
ble
> > to select the hwtstamp we want too use. By default we use the old API t=
hat
> > does not support hwtstamp selectability which mean the hwtstamp ptp_clo=
ck
> > pointer is unset. =20
>=20
> ERROR: modpost: "ptp_clock_phydev" [drivers/net/phy/libphy.ko] undefined!

Thanks for the report.
Weird, it should be in builtin code.
I will investigate.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

