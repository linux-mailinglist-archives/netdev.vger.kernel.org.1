Return-Path: <netdev+bounces-132609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3793099267D
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 09:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C93CCB2080D
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 07:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4000714C5B5;
	Mon,  7 Oct 2024 07:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="C+tb8sSn"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5888541C7F;
	Mon,  7 Oct 2024 07:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728287824; cv=none; b=IlT3gLLhZfy8BqMQ142oGBUchYIxsFYik4UwPrEUB8xOcLcAAb/GWjnsNAb2k75qq/9Zx8t6hXLmVpJ7WP63fg0T2aKxHuIXIRrOhh2hVAEitGdcr9kR/RMhRpuWgsZkEoLjg4+BrSismNRqWsbOuuXjLksSqQtBsJ+maw6Q8hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728287824; c=relaxed/simple;
	bh=lFoTegalWJz/926ecIf2O6zlRXbba6SLin82MoKM0BI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EJbZWDKBmfyQstyAUZFi7lNlNRmL074Y/7kfWPgeaCVM0d1ZxAQz4mjx0Mc6hyJaG3cmh+f3TurQYqdB3W/1FC4hb5K/PD0xiSMH9cC2A+QoXnCQ1prVCnASGUMjZEB+RYMh++k2U4rTXZew+5AxxJY4s4hGX4aba5x05/Q1hBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=C+tb8sSn; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 4313588D5B;
	Mon,  7 Oct 2024 09:56:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728287815;
	bh=9BGnMXQSavohhC2EYGCXy1MOGene7VMC5//c/dvJgl0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C+tb8sSnxl1LHPYeyT3Ljrv+uWXQjUQFJHyuGbl2yGS5S3vXiTgYb6LRLekWH19Bx
	 84NAK/miZnyHB2C2nOylbWor2Qza7LYNNLvk/9Crs02QqKkQr8PELDcenyOAq8IwnZ
	 OTmCHZu7xDPxOZ7yzUDOIE9xkM4YM7MJ33DYZX0mr/9OQ2CA0DQcXmrqLWJfpsf85k
	 vNmxmC5l5QjdjNKxX/x1ep1ltXbdn9ck/vMBY9j0noaddToO9FlOeSHJnL+sVgM2eX
	 4yBcY48PTWM4T4b80tz80UUKiSOOWrHUPoXgtpfBcIjfwcHZGkbbwPnzgaTHb/OkRm
	 o6SlKiaOcD9Uw==
Date: Mon, 7 Oct 2024 09:56:53 +0200
From: Lukasz Majewski <lukma@denx.de>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: <jiri@resnulli.us>, <aleksander.lobakin@intel.com>, <horms@kernel.org>,
 <robh@kernel.org>, <jan.kiszka@siemens.com>, <dan.carpenter@linaro.org>,
 <diogo.ivo@siemens.com>, <pabeni@redhat.com>, <kuba@kernel.org>,
 <edumazet@google.com>, <davem@davemloft.net>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next 0/3] Introduce VLAN support in HSR
Message-ID: <20241007095653.4534664e@wsk>
In-Reply-To: <20241004074715.791191-1-danishanwar@ti.com>
References: <20241004074715.791191-1-danishanwar@ti.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=pg.V_ZyQHlB1UmJVii8Ao.";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/=pg.V_ZyQHlB1UmJVii8Ao.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi MD Danish Anwar,

> This series adds VLAN support to HSR framework.
> This series also adds VLAN support to HSR mode of ICSSG Ethernet
> driver.
>=20

Could you add proper test script for this code?

Something similar to:
https://elixir.bootlin.com/linux/v6.12-rc2/source/tools/testing/selftests/n=
et/hsr

> Murali Karicheri (1):
>   net: hsr: Add VLAN CTAG filter support
>=20
> Ravi Gunasekaran (1):
>   net: ti: icssg-prueth: Add VLAN support for HSR mode
>=20
> WingMan Kwok (1):
>   net: hsr: Add VLAN support
>=20
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 45 +++++++++++-
>  net/hsr/hsr_device.c                         | 76
> ++++++++++++++++++-- net/hsr/hsr_forward.c                        |
> 19 +++-- 3 files changed, 128 insertions(+), 12 deletions(-)
>=20
>=20
> base-commit: 6b67e098c9c95bdccb6b0cd2d63d4db9f5b64fbd




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/=pg.V_ZyQHlB1UmJVii8Ao.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmcDlEUACgkQAR8vZIA0
zr3YGAf/fM+Kqhnwy73uU2jUhB0riGuH8wbJwxOZikSdORexG/l9qCgrC3Rungcw
8Ure6w+NNegVQHZns4p51VLzWiVqwTq9ZtQJXpjEjT/GY6dv6zRvvkMNC73rgjKb
1JjsBo1NWG2yWVa59J3XDrLf/0y+FQ2nXOtRIpSVckcttkL8EqSV/0n0C+zvorY6
beaxCVlPElynZ37iRBColDkYbshyFTojrYDs2n23OR+wvoe3Wpq9/TDtc3l9VVZk
uEJT/3xmpha90xksU/eDEmR6ncJif9gBl1uudSe+ep/QXHxik/LePTIJQz3htQbZ
vx9q4UV1KAkJP1WLZfHNjXTiuYGH2w==
=fOuJ
-----END PGP SIGNATURE-----

--Sig_/=pg.V_ZyQHlB1UmJVii8Ao.--

