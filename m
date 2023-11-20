Return-Path: <netdev+bounces-49175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B6B7F1088
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 11:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22AF61F2360F
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 10:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7703F6FA8;
	Mon, 20 Nov 2023 10:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Z2ChnBnC"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E123A0;
	Mon, 20 Nov 2023 02:40:32 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 077931C000C;
	Mon, 20 Nov 2023 10:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700476830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aFDoD/sf7hb9m2oDJulcbKCtm+j0do0V7EoRgM61mz8=;
	b=Z2ChnBnCRgpveBlmH6q0kxQZj4TWlnHNku1bMn3gvXiRdAdr4nw9jUBm3X9v8h59YiwTlT
	1cXbxA4t0+FroaiA4ZCIEujF7pBP4RKzkGNcyEp3jDDn5J8HMvidEAAlWfHUDXYFRHpay9
	2O2lvIEL55KN9K+13Rvj78ScZDtjBoJgS8+zJ4hMr5/nVl6trktyU3AE3RqZOgG7JAPbwI
	n2Gywn0BA9BZrGU+36aU78oFEb7tdCem/62vikQM4NsXOvN+eG5m9l+WTb3qecNBQbksTC
	fL3kYMp8auXKtDvN55Joc5QA6L9NuKiQvkDrQYE/3TnPqsSpriD1pW92QFSaWg==
Date: Mon, 20 Nov 2023 11:40:27 +0100
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
Message-ID: <20231120114027.225442b5@kmaincent-XPS-13-7390>
In-Reply-To: <20231120101757.7ecf40b2@kmaincent-XPS-13-7390>
References: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
	<20231114-feature_ptp_netnext-v7-8-472e77951e40@bootlin.com>
	<20231118182424.2d569940@kernel.org>
	<20231120101757.7ecf40b2@kmaincent-XPS-13-7390>
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

On Mon, 20 Nov 2023 10:17:57 +0100
K=C3=B6ry Maincent <kory.maincent@bootlin.com> wrote:

> On Sat, 18 Nov 2023 18:24:24 -0800
> Jakub Kicinski <kuba@kernel.org> wrote:
>=20
> > On Tue, 14 Nov 2023 12:28:36 +0100 Kory Maincent wrote: =20
> > > +		ops->get_ts_info(dev, &ts_info);
> > > +		if (ts_info.so_timestamping &
> > > +		    SOF_TIMESTAMPING_HARDWARE_MASK)
> > > +			data->ts_layer =3D MAC_TIMESTAMPING;
> > > +
> > > +		if (ts_info.so_timestamping &
> > > +		    SOF_TIMESTAMPING_SOFTWARE_MASK)
> > > +			data->ts_layer =3D SOFTWARE_TIMESTAMPING;   =20
> >=20
> > How does this work? so_timestamping is capabilities, not what's
> > enabled now. So if driver supports SW stamping we always return
> > SOFTWARE? =20
>=20
> Yes, the software timestamping comes from the MAC capabilities.
> I decided to separate software and MAC timestamping. If we select PHY
> timestamping we can't use software timestamping and for an user, selectin=
g the
> MAC as timestamping seems not logical to use software timestamping.
>=20
> Indeed there is a mistake here I should have used "else if" condition.
> Mmh in fact, maybe not, because it would breaks the access to software
> timestamping until patch 13.
> I will remove the SOFTWARE/MAC timestamping distinction from this patch.

After thinking again, the "else if" condition works and won't break anythin=
g as
we could still access software timestamping within the MAC_TIMESTAMPING lay=
er.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

