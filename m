Return-Path: <netdev+bounces-25271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB90D773A0C
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 14:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8B421C20F37
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 12:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2048B100A6;
	Tue,  8 Aug 2023 12:08:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF32B100A3
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 12:08:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCADC433C8;
	Tue,  8 Aug 2023 12:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691496486;
	bh=iKFqjhht/NXdZgjGWSjxol/XyOZYksQmyjVTIwqbqok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b+WW0w8h/Gbs8bpKCSYCtqnRjZTq3Ub0tNBt5pnkvUPjXE/936GbOIZKmpx8L8zKr
	 HlQYtOfpaqqwpjC9h7cRK8rPo2E6b0Qw75oyRooQGgEtTKNtcUkG+SWeCiYLV77O2M
	 sqQBJtRZ4GYHzpsl9r83Giab/iOx+A2Yudx/YRS/Kcyu9xRAPUsBZXhGLQ7sDr6/cu
	 NzoSNRXCOzp5fygWFv4De+UcwhH/7LCqYMMoaYu86hGf13POhB1y3L1xq1v1Yct9OG
	 6ovdTEIzSiIM49GuhPzeTTr19gS6H3iTpJ2gONcX0JGEIXr7yqcyQyAy/T4O5Sw1BK
	 Y2nrkJa66ea7g==
Date: Tue, 8 Aug 2023 13:08:00 +0100
From: Conor Dooley <conor@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Roger Quadros <rogerq@kernel.org>,
	Simon Horman <simon.horman@corigine.com>,
	Vignesh Raghavendra <vigneshr@ti.com>, Andrew Lunn <andrew@lunn.ch>,
	Richard Cochran <richardcochran@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>, nm@ti.com, srk@ti.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/5] Introduce IEP driver and packet timestamping
 support
Message-ID: <20230808-unnerving-press-7b61f9c521dc@spud>
References: <20230807110048.2611456-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3Wq7r3DP1wfOlIpT"
Content-Disposition: inline
In-Reply-To: <20230807110048.2611456-1-danishanwar@ti.com>


--3Wq7r3DP1wfOlIpT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 07, 2023 at 04:30:43PM +0530, MD Danish Anwar wrote:
> This series introduces Industrial Ethernet Peripheral (IEP) driver to
> support timestamping of ethernet packets and thus support PTP and PPS
> for PRU ICSSG ethernet ports.
>=20
> This series also adds 10M full duplex support for ICSSG ethernet driver.
>=20
> There are two IEP instances. IEP0 is used for packet timestamping while I=
EP1
> is used for 10M full duplex support.
>=20
> This is v2 of the series [v1]. It addresses comments made on [v1].
> This series is based on linux-next(#next-20230807).=20
>=20
> Changes from v1 to v2:
> *) Addressed Simon's comment to fix reverse xmas tree declaration. Some A=
PIs
>    in patch 3 and 4 were not following reverse xmas tree variable declara=
tion.
>    Fixed it in this version.
> *) Addressed Conor's comments and removed unsupported SoCs from compatible
>    comment in patch 1.=20

I'm sorry I missed responding there before you sent v2, it was a bank
holiday yesterday. I'm curious why you removed them, rather than just
added them with a fallback to the ti,am654-icss-iep compatible, given
your comment that "the same compatible currently works for all these
3 SoCs".

Thanks,
Conor.

> *) Addded patch 2 which was not part of v1. Patch 2, adds IEP node to dt
>    bindings for ICSSG.
>=20
> [v1] https://lore.kernel.org/all/20230803110153.3309577-1-danishanwar@ti.=
com/
>=20
> Thanks and Regards,
> Md Danish Anwar
>=20
> Grygorii Strashko (1):
>   net: ti: icssg-prueth: am65x SR2.0 add 10M full duplex support
>=20
> MD Danish Anwar (1):
>   dt-bindings: net: Add iep node in ICSSG driver dt binding
>=20
> Md Danish Anwar (1):
>   dt-bindings: net: Add ICSS IEP
>=20
> Roger Quadros (2):
>   net: ti: icss-iep: Add IEP driver
>   net: ti: icssg-prueth: add packet timestamping and ptp support
>=20
>  .../devicetree/bindings/net/ti,icss-iep.yaml  |  37 +
>  .../bindings/net/ti,icssg-prueth.yaml         |   7 +
>  drivers/net/ethernet/ti/Kconfig               |  12 +
>  drivers/net/ethernet/ti/Makefile              |   1 +
>  drivers/net/ethernet/ti/icssg/icss_iep.c      | 961 ++++++++++++++++++
>  drivers/net/ethernet/ti/icssg/icss_iep.h      |  41 +
>  drivers/net/ethernet/ti/icssg/icssg_config.c  |   6 +
>  drivers/net/ethernet/ti/icssg/icssg_ethtool.c |  21 +
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 433 +++++++-
>  drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  28 +-
>  10 files changed, 1540 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/ti,icss-iep.yaml
>  create mode 100644 drivers/net/ethernet/ti/icssg/icss_iep.c
>  create mode 100644 drivers/net/ethernet/ti/icssg/icss_iep.h
>=20
> --=20
> 2.34.1
>=20

--3Wq7r3DP1wfOlIpT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNIwIAAKCRB4tDGHoIJi
0g2dAP9kfFgMp83Kr/SnIeHz0AcFRVRxFOM13wTotQ4N7927ZwD/TYglqmJwOtcE
rW1EGcQQYNr+DLVPAzsiIpVYIj4QOgs=
=f/yq
-----END PGP SIGNATURE-----

--3Wq7r3DP1wfOlIpT--

