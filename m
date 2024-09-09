Return-Path: <netdev+bounces-126471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8146797143C
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 11:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAA581C22E59
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 09:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA751B6557;
	Mon,  9 Sep 2024 09:45:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190E41B6528
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 09:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725875120; cv=none; b=FUilmNBG4cTjz2vNxLmQNEBtepaF5vBB1mBoZjWUVdYs0jtxS5EWCLDR40rGWtnRJayQvXb2qhFVFI/QO0rND6hakER1PyKrOoiLeyyJ8/AT+yJxUsaF9TpPY8Yq6urxQP8FjA/tcdlc1kTEO4lMReOh6NU4nR04IrStG0UCuUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725875120; c=relaxed/simple;
	bh=+4evIbnZzt4io1Sc2b1tEsI+If1tOXLMbFPYq8FUF9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnrATzAM8Ao/Qs47I2xwE6Vw453VhFkmwAOrgm76hDfC9Ypu6sRaTfXV0iAZVfh0Hh6jxOcH9xNWyMkcYLKhZqve+Tj6PKo9qDNG8V1vziJOqfIbP7PPVu2k2P+xVc8JFbS2ixU00PxNNdaQ4l6oeHiDRrpjrZGpltC/ZL2ydHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1snax1-0002Uv-3i; Mon, 09 Sep 2024 11:44:51 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1snax0-006cVw-05; Mon, 09 Sep 2024 11:44:50 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9FD24336781;
	Mon, 09 Sep 2024 09:44:49 +0000 (UTC)
Date: Mon, 9 Sep 2024 11:44:49 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Arnd Bergmann <arnd@arndb.de>, kernel@pengutronix.de, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Heiko Stuebner <heiko@sntech.de>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: rockchip_canfd: avoids 64-bit division
Message-ID: <20240909-dark-seahorse-of-support-b2206a-mkl@pengutronix.de>
References: <20240909112119.249479-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vw4xxvfo7kzbvp2i"
Content-Disposition: inline
In-Reply-To: <20240909112119.249479-1-arnd@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--vw4xxvfo7kzbvp2i
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09.09.2024 11:21:04, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The new driver fails to build on some 32-bit configurations:
>=20
> arm-linux-gnueabi-ld: drivers/net/can/rockchip/rockchip_canfd-timestamp.o=
: in function `rkcanfd_timestamp_init':
> rockchip_canfd-timestamp.c:(.text+0x14a): undefined reference to `__aeabi=
_ldivmod'
>=20
> Rework the delay calculation to only require a single 64-bit
> division.
>=20
> Fixes: 4e1a18bab124 ("can: rockchip_canfd: add hardware timestamping supp=
ort")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I've already send a PR which replaces the division by div_u64(), so not
as elaborate as yours:

| https://lore.kernel.org/all/20240909-can-rockchip_canfd-fix-64-bit-divisi=
on-v1-1-2748d9422b00@pengutronix.de/

I'll port your patch on top of mine and include it in my next PR.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--vw4xxvfo7kzbvp2i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbew44ACgkQKDiiPnot
vG9qfAf8CTk2RmeHPrfJav3PuBHG1Q2oYZqWnA01UAaihzEzI66cuAwP2jpOtInE
epFUOo/Lj3yG/Qpt5dpcs1coQmN1LrVengCjQlX0KCtZtRLOCv29UULyus8dPrqt
5zYCXeAtAe6XL9ou90Wo3gkaVldVQ2xndwBmq0Cd4XI5hxpj88rHQcpHiNpQAE8J
bEyNLPgchY7prDi3elH255rFWfRhIdXHztM/HqRj1d/P6Rp3O1gEnpAL6YjO1gf4
bsV1Z64Hci2aZFCzuy5fMy1SHCwLu65LuBwvrHBMO8zMRW2eyuBvto2p22kriLTv
gmjDucroH7Sd9tffjRJQeU5MmMeTKg==
=93jr
-----END PGP SIGNATURE-----

--vw4xxvfo7kzbvp2i--

