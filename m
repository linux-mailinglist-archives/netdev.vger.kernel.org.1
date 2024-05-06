Return-Path: <netdev+bounces-93685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B624B8BCB8A
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 12:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BD231F22F7C
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 10:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E840E1428E6;
	Mon,  6 May 2024 10:03:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880DD14262C
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 10:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714989787; cv=none; b=d1qG+BU1DUPuKwvzqpiMXamRTputXOPyJ/X+b5PCTlNvTAs+hLHKmkJg/2MO09HZIn8eWIe0I03p3Xpb9XXD2sj0/Dzr6oQVBlWXQTPu4tyrV7l4z+OCjS/4cMDs0DnN7SwaOkfL4iJm0v8nq0p3H7zWHv29yFiaDuyUngZxGVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714989787; c=relaxed/simple;
	bh=Z4EcRz/G6UHRpsJjAcYqWpUOiBu9/8gVcBoHx1+EaB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iS+wfiasrrHaSNVXAGSm6uLDgMlCEjP+Nqn5wiqrYmPCq4D6kLZ2gFpnzhmDlhyXT2eyqG77xYOmtBMI5c/mb72kdIV/Ij564i+vwzVoHB5WM6GLUnZsZ0xrJPzD4/Z2rwVAkag3hhmPZ/3AHYPgutwkkay67KfxI4E8hho+tfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1s3vBG-0007qw-Vy; Mon, 06 May 2024 12:02:47 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1s3vBF-00GEz0-Eb; Mon, 06 May 2024 12:02:45 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 051D92CB44D;
	Mon, 06 May 2024 10:02:45 +0000 (UTC)
Date: Mon, 6 May 2024 12:02:44 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Thomas Kopp <thomas.kopp@microchip.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux@ew.tq-group.com
Subject: Re: [PATCH v2 0/6] can: mcp251xfd: add gpio functionality
Message-ID: <20240506-imperial-taupe-deer-9132a5-mkl@pengutronix.de>
References: <20240506-mcp251xfd-gpio-feature-v2-0-615b16fa8789@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sse27ts3gacsw3dx"
Content-Disposition: inline
In-Reply-To: <20240506-mcp251xfd-gpio-feature-v2-0-615b16fa8789@ew.tq-group.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--sse27ts3gacsw3dx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 06.05.2024 07:59:42, Gregor Herburger wrote:
> Hi all,
>=20
> The mcp251xfd allows two pins to be configured as GPIOs. This series
> adds support for this feature.
>=20
> The GPIO functionality is controlled with the IOCON register which has
> an erratum. The second patch is to work around this erratum. I am not
                  ^^^^^^
> sure if the place for the check and workaround in
> mcp251xfd_regmap_crc_write is correct or if the check could be bypassed
> with a direct call to mcp251xfd_regmap_crc_gather_write. If you have a
> better suggestion where to add the check please let me know.

Yes, better move the workaround to mcp251xfd_regmap_crc_gather_write().
I don't remember under which circumstances regmap uses the
gather_write() or the write() function.

> Patch 1-3 from https://lore.kernel.org/linux-can/20240429-mcp251xfd-runti=
me_pm-v1-0-c26a93a66544@pengutronix.de/

Nitpick: Please add your S-o-b to these patches.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--sse27ts3gacsw3dx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmY4qsEACgkQKDiiPnot
vG8TYAf9HmPQqBGVCnYkMCu3rzFuWptfpRq+2Ef2dNd1CszgbeuOuEN+Z97BRRHy
KZjA/1Y1Y5185xwvzHH3TFSBB7H1huYN2zekcIEYVGNMExwYBpEPhWzdjWc2IH6w
xdfwz21foHD50PsRk72FGmijpXN46RXBEIuV6KVbyvVVufNXxcNEz6yYcpIjgT+G
TgVmmglnNtZmzYNfUgu9gKVAdbskQkUaziTlIO/QQwXveBTOWisq/83asXFMO9Sb
u68PbNU6Z+/YKUv+OGz73a2cVV7NUcICpZPRHabgqFKmGzGFavFzb+8xXU42jPMN
zgpwVIDPo8o2euA/22RHCkb2vudCDA==
=+dVm
-----END PGP SIGNATURE-----

--sse27ts3gacsw3dx--

