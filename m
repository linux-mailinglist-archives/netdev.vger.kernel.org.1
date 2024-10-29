Return-Path: <netdev+bounces-139804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AAA9B43FC
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 09:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71640281BB8
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 08:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA102038CB;
	Tue, 29 Oct 2024 08:15:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BFE201254
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 08:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730189745; cv=none; b=lot8NW9GXmH8wPHdjmAC+246mmwlTOUTcQbvrid+2rBjU0ph+opQx/KbMqaMqx1Y4o94IO5xV3hxfPEGIjR0Fm4dhYKHQbfvFDs50CVK5E/CMyFI/sBU/VGFzTfACTNxqn6lipVn7meuvmGE+pGZbf6X6aDMlbcJC5yWqXyYfgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730189745; c=relaxed/simple;
	bh=YggC+Qxo+NVcOErzTUXjBABSyADwrdnokU2LGl0F+fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgc/kcYmHsWV4VYnsrtJRWbKLSV7xBTJda7E80crHmsZ+PR0AEzGQe5sNb6hUx9Sr5s7/Rfni184Hd2vk1ADkdQR0S8OZInCLjzy7+lg2BgROFlj2GrCWdL9vwVr5ilRIC1Cr7apEPEIG0VmR/71LwfCU4Rz3lXHVQVNxbd/CiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t5hNJ-0006Vu-Og; Tue, 29 Oct 2024 09:14:49 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1t5hNG-000zSr-0D;
	Tue, 29 Oct 2024 09:14:46 +0100
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 885EA361330;
	Tue, 29 Oct 2024 08:14:45 +0000 (UTC)
Date: Tue, 29 Oct 2024 09:14:45 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ming Yu <a0282524688@gmail.com>
Cc: tmyu0@nuvoton.com, lee@kernel.org, linus.walleij@linaro.org, 
	brgl@bgdev.pl, andi.shyti@kernel.org, mailhol.vincent@wanadoo.fr, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, wim@linux-watchdog.org, linux@roeck-us.net, jdelvare@suse.com, 
	jic23@kernel.org, lars@metafoo.de, ukleinek@kernel.org, 
	alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v1 1/9] mfd: Add core driver for Nuvoton NCT6694
Message-ID: <20241029-fresh-dinosaur-of-penetration-d695ff-mkl@pengutronix.de>
References: <20241024-adventurous-imaginary-hornet-4d5c46-mkl@pengutronix.de>
 <CAOoeyxUhnyYG3p+DQJG-tvU5vc5WYQZLLqCXW=uPcXTjq2gVfw@mail.gmail.com>
 <20241025-truthful-honest-newt-c371c8-mkl@pengutronix.de>
 <CAOoeyxUEf5vjqL67WjR-DbrhE0==2hqHLEyZ5XEBhEfMfQ5pag@mail.gmail.com>
 <20241025-spirited-nocturnal-antelope-ce93dd-mkl@pengutronix.de>
 <CAOoeyxW5QwPMGAYCWhQDtZwJJLG5xj9HXpL3-cduRSgF+4VHhg@mail.gmail.com>
 <20241028-uptight-modest-puffin-0556e7-mkl@pengutronix.de>
 <CAOoeyxU1r3ayhNWrbE_muDhA0imfZYX3-UHxSen9TqsTrSsxyA@mail.gmail.com>
 <20241028-observant-gentle-doberman-0a2baa-mkl@pengutronix.de>
 <CAOoeyxWh1-=NVQdmNp5HBzf1YPo9tQdh=OzUUVFmvC-F7sCHWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l2xctpm5dxyfmd5l"
Content-Disposition: inline
In-Reply-To: <CAOoeyxWh1-=NVQdmNp5HBzf1YPo9tQdh=OzUUVFmvC-F7sCHWg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--l2xctpm5dxyfmd5l
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/9] mfd: Add core driver for Nuvoton NCT6694
MIME-Version: 1.0

On 29.10.2024 11:45:30, Ming Yu wrote:
> > > > You have a high coupling between the MFD driver and the individual
> > > > drivers anyways, so why not directly use the dynamically allocated
> > > > buffer provided by the caller and get rid of the memcpy()?
> > >
> > > Okay! I will provide a function to request and free buffer for child =
devices,
> > > and update the caller's variables to use these two functions in the n=
ext patch.
> >
> > I don't see a need to provide dedicated function to allocate and free
> > the buffers. The caller can allocate them as part of their private data,
> > or allocate them during probe().
>=20
> Okay, so each child device may allocate a buffer like this during probe():
> priv->xmit_buf =3D devm_kcalloc(dev, MAX_PACKET_SZ, sizeof(unsigned char),
> GFP_KERNEL), right?

basically yes, probably devm_kzalloc() or embed it into the priv struct
directly with ____cacheline_aligned:

| https://elixir.bootlin.com/linux/v6.11.5/source/drivers/net/can/spi/mcp25=
1xfd/mcp251xfd.h#L498

The size of the driver's RX and TX buffers depend on what they want to
send and expect to receive. The next step would be to create structs the
describe the RX and TX buffers for each driver. If you have a common
header between each driver, create that first.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--l2xctpm5dxyfmd5l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcgmXIACgkQKDiiPnot
vG+LsQf+O4zJwfuGycNIY6uZPaHVz1IAgaeC/v2Jtznp51yqr0WvDVOcdhOLHKtG
8Rbd+lDgWhPK2WCiBnwj6fhpBzTIZSZHbVlIqX2668gYpCvRr4YTSydt1HYDNoHA
/G2k1g8rCdtTWiynu5+P2CUdaolzZEdq+lOnCLoOkbWD1cDT/lMdHPYoyBLbLNZ8
b7IbbBc1D6jVlBd9Om1Zn7Ev9cQQ9UGp9QY1fUWdv+KwJz76NCIMgGK93Hf5kDFy
/5AIztMNibr+sFbwkZ7ypmag3icRiF750TOECdq0LEUPXM2eVXkQ+pIGkIcgXTQL
p1zN+c2H8FwJZIvGgdCLxDQc2B+uLw==
=2AiX
-----END PGP SIGNATURE-----

--l2xctpm5dxyfmd5l--

