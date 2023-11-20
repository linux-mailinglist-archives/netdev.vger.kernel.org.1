Return-Path: <netdev+bounces-49141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA13D7F0E72
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 10:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720E82821AC
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 09:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA961079B;
	Mon, 20 Nov 2023 09:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="paDSiH0R"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB07AA;
	Mon, 20 Nov 2023 01:05:53 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 37BEC240011;
	Mon, 20 Nov 2023 09:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700471152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F+8OWPo1A4refdMdhqNNO7xxvh/IBp3TS2F/HFALuR0=;
	b=paDSiH0R8x0I2s9DfJyh3cmEKguAtUNqaTG4IDwEY83FRMaAM8Ogv5pU4HGBL5/s3bNeTJ
	3OUET9xs2O9V0UM1ZO9LBukefbZ7uov0pHzeszSDmRuiYmpGbuuKPcztmONZ3RUxpfD+xv
	Q+LWPupD0dygScKaJW19mVKgmzeLIomQ1GAbzsfpu2rmsO7pNUJ/zxb0UfCff7RN1z2zFY
	ZlG2BwQgFqQWOGExCCP8/aDaDBzwW38Foqhj7m9RicLvbMw8vTED3RL5PYfVpxco+4mxor
	SM4wFc0gOwzIBBjeGBAa8Mk73+3+MukXotrIxGf6+NwqVJn5sSECkccB5QKS4g==
Date: Mon, 20 Nov 2023 10:05:49 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
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
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v7 07/16] net_tstamp: Add TIMESTAMPING SOFTWARE
 and HARDWARE mask
Message-ID: <20231120100549.22c83bd0@kmaincent-XPS-13-7390>
In-Reply-To: <20231118182247.638c0feb@kernel.org>
References: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
	<20231114-feature_ptp_netnext-v7-7-472e77951e40@bootlin.com>
	<20231118182247.638c0feb@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Sat, 18 Nov 2023 18:22:47 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 14 Nov 2023 12:28:35 +0100 Kory Maincent wrote:
> > Timestamping software or hardware flags are often used as a group,
> > therefore adding these masks will easier future use.
> >=20
> > I did not use SOF_TIMESTAMPING_SYS_HARDWARE flag as it is deprecated and
> > not use at all. =20
>=20
> Does this really need to be in uAPI?

I have put it in the same place as SOF_TIMESTAMPING_* flags but indeed I am=
 not
sure ethtool would need it.
I can move it to include/linux/net_tstamp.h and we will move back to uapi if
we see that it is necessary. What do you think?


--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

