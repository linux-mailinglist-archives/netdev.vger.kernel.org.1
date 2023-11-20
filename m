Return-Path: <netdev+bounces-49146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8427F0ED5
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 10:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A27942821CA
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 09:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60A410A10;
	Mon, 20 Nov 2023 09:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pIM4bFxw"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4525BA;
	Mon, 20 Nov 2023 01:18:03 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B089940004;
	Mon, 20 Nov 2023 09:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700471880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=POKstibQf2T728kxGgPI1aeq/54Lhb4ulb9k4+ErqNA=;
	b=pIM4bFxwpNEJG2Z1NyAfaEWkMcj10QWyDQyFJWzibWpR+EkemNzXD3Y1CpsK6z2dVe2HW/
	yvyM3sjRsFfZp310uKs2XAMnxeHHhrnqDnI6YPqrXPflerIKL191CD2Oumb8R4VYrlCjxv
	dkQ3wNabpXlA73TWCqeZSmn4EAAg+M+WAdOjB0eRXMevilOuryM2jbFLsZ/fGqU2g9R4EP
	Iy0pbdjjSs9ISOd15nivSuCoIQqFKor7nse6M2ljzhM+a+6mNGytOEXQ81CAjq0igNWsOW
	VzWJDyHOzpvqHlvFn+fkQnI7shRKiNMIy5Jei0NLq9fUcPl/GaTE5P2aB5sRug==
Date: Mon, 20 Nov 2023 10:17:57 +0100
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
Subject: Re: [PATCH net-next v7 08/16] net: ethtool: Add a command to expose
 current time stamping layer
Message-ID: <20231120101757.7ecf40b2@kmaincent-XPS-13-7390>
In-Reply-To: <20231118182424.2d569940@kernel.org>
References: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
	<20231114-feature_ptp_netnext-v7-8-472e77951e40@bootlin.com>
	<20231118182424.2d569940@kernel.org>
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

On Sat, 18 Nov 2023 18:24:24 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 14 Nov 2023 12:28:36 +0100 Kory Maincent wrote:
> > +		ops->get_ts_info(dev, &ts_info);
> > +		if (ts_info.so_timestamping &
> > +		    SOF_TIMESTAMPING_HARDWARE_MASK)
> > +			data->ts_layer =3D MAC_TIMESTAMPING;
> > +
> > +		if (ts_info.so_timestamping &
> > +		    SOF_TIMESTAMPING_SOFTWARE_MASK)
> > +			data->ts_layer =3D SOFTWARE_TIMESTAMPING; =20
>=20
> How does this work? so_timestamping is capabilities, not what's
> enabled now. So if driver supports SW stamping we always return
> SOFTWARE?

Yes, the software timestamping comes from the MAC capabilities.
I decided to separate software and MAC timestamping. If we select PHY
timestamping we can't use software timestamping and for an user, selecting =
the
MAC as timestamping seems not logical to use software timestamping.

Indeed there is a mistake here I should have used "else if" condition.
Mmh in fact, maybe not, because it would breaks the access to software
timestamping until patch 13.
I will remove the SOFTWARE/MAC timestamping distinction from this patch.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

