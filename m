Return-Path: <netdev+bounces-187621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 752F6AA8450
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 08:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AC451899819
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 06:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C6F1624E5;
	Sun,  4 May 2025 06:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="MgE7mYBf"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B380817BD3;
	Sun,  4 May 2025 06:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746340111; cv=none; b=dgsrniK0Jyh/3CfhL7y8d01PUMomett8w34Lowy5sxejmFpqoCHO8zMvyFMIW25ggqtZEvykjp/k6/lkIG+MNY8GXlulyRAvMEuCg3f5Z7uZSBgM5xwh5nqgwwe9bTJYZkHskLA1azVtTYSJcGGQupKJPpQmTprnQt9aC2QpJls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746340111; c=relaxed/simple;
	bh=JH7UWl0QPjoLu0FdEYSBj0ChSPIozh3YaMARZWs2Gyo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q/rdCKo1sSpPN8jLU/DKL17HKi4+3fINXNcMz82kQQ19PAvwdkIKEiaOCgOS889sUCaVUtoFaT7+fvvTtNxM1uCg9084ZLExTN7duGbb4/CWEDWfrmJsLB0UV9nMehEeM5/P0ryk1y/GLFLxO8wu2t9Zm3W9XhBp4+qlDG6Bgqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=MgE7mYBf; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9C58C102EBA58;
	Sun,  4 May 2025 08:28:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1746340100; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=rCgrVpFe4biw8hf/ZoueDjqGBEEPT9+1gxH8yMqDfrI=;
	b=MgE7mYBfXN/HyW3DXX1gurVkn01PGNgPV3q7o0L+9PRlNWoioSE9c6kaq2ZrqXIAPjdDgI
	ONrqX8sYjiREnJHNYF0XKTSgW48osfwDUHKGGigLh3ByV6gUlX3WDHhRaNL9/0t/uJFGc9
	f4ahN/RJd72PKhp8T4/7o+dqVrm7S1+Inh96VoMAZ80yCs+r8KxQRhdoxyEPA2z1Qowo4U
	z2ULxr3K0WOZB44kliZKG41EccEypr8FoznyhCm128qryxuGu+JwdH7mjWkgmX3vCEhyRk
	eDWwJFj7edmMDpl+Z7ZlxTGe9cRJrRxesac92ErNRHW47zCX6GFC1O81tWmhBQ==
Date: Sun, 4 May 2025 08:28:11 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew@lunn.ch>
Subject: Re: [net-next v10 4/7] net: mtip: The L2 switch driver for imx287
Message-ID: <20250504082811.4893afaa@wsk>
In-Reply-To: <20250502071328.069d0933@kernel.org>
References: <20250502074447.2153837-1-lukma@denx.de>
	<20250502074447.2153837-5-lukma@denx.de>
	<20250502071328.069d0933@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6QmTqwgtdiqccoc742SZ04r";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/6QmTqwgtdiqccoc742SZ04r
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

> On Fri,  2 May 2025 09:44:44 +0200 Lukasz Majewski wrote:
> > This patch series provides support for More Than IP L2 switch
> > embedded in the imx287 SoC.
> >=20
> > This is a two port switch (placed between uDMA[01] and MAC-NET[01]),
> > which can be used for offloading the network traffic.
> >=20
> > It can be used interchangeably with current FEC driver - to be more
> > specific: one can use either of it, depending on the requirements.
> >=20
> > The biggest difference is the usage of DMA - when FEC is used,
> > separate DMAs are available for each ENET-MAC block.
> > However, with switch enabled - only the DMA0 is used to
> > send/receive data to/form switch (and then switch sends them to
> > respecitive ports).
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch> =20
>=20
> Now that basic build is green the series has advanced to full testing,
> where coccicheck says:
>=20
> drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c:1961:1-6: WARNING:
> invalid free of devm_ allocated data
> drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c:1237:16-19: ERROR:
> bus is NULL but dereferenced.

I'm sorry for not checking the code with coccinelle.

I do have already used sparse and checkpatch.

I will fix those errors.

Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/6QmTqwgtdiqccoc742SZ04r
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmgXCPwACgkQAR8vZIA0
zr03AwgAkMNG0YrgvTM3iFWNDJ6IgUY1d14CkUU8GCex+FMbAMEEJeXx/+nws0ZR
9sxsteMOv8I8iImMD1EIgBHdT8YjQKy9afBmzf5t8E9XOeE92W/e4Dc8w5CziCyN
TV4akdUhoaTkhv3s7whhUAEOBvrZ7aHn9uqYzw5AybFcSArlLmmNS4MqWaGK0ATz
tkfp14hOhxRKzMY87sqfTZYw+1DKMwnIn8mStHL8rHFnidLrt6LlAqWYrPw4wocp
Ne/ziIpwkNfLjGtJM29tAB97HI4l4aZ5th6kcZACU+pTgRgY24wLDtXtk8UhY2a5
+EqG6B5zHuTWSNnZiUalr89fo0JhzA==
=HuJH
-----END PGP SIGNATURE-----

--Sig_/6QmTqwgtdiqccoc742SZ04r--

