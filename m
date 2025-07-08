Return-Path: <netdev+bounces-204814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DB1AFC2BE
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 08:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAA561AA6C18
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 06:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A495219313;
	Tue,  8 Jul 2025 06:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="H6rmEwnO"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59248189F3F;
	Tue,  8 Jul 2025 06:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751956244; cv=none; b=Yep4vDErErXrCZ0Leb9V88SWTKhC1TBHbqQqSzVoAsKycBjCHPLagpGpIAvBAtg/KKpS/qWrDxY4cw9MesA78zUHAv69OayI15cn4J00NM8dm/RyY3zhUcXnffevWRBiwHHQAK47D+tLzEjnfttPCFfgwpkV7LQ1mRCkXfM7iMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751956244; c=relaxed/simple;
	bh=P9QvZUpF/LJOw9fOYyRONt8KXGdUMhir9fRjkIe5LZg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nyb4O0tIF3ZWZVFi1m/++1Gfr3nzsQzyM/1SPHoseWkjOLz2eSYLXhHdLRbTP5rzt61aFuw23zZGmDqW6N3gE9h3NVpMDRI8imPfYTn368r9sUh9lFWSumRJTkvHoM9Azk4vBYtEarFq/Cw49LUm74dssqPJWd9bBMGOvr2jsaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=H6rmEwnO; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0345D1039729E;
	Tue,  8 Jul 2025 08:30:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1751956231; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=LmJDJSLxx1my+mfQ4+domzBvSClDWTc3E/feWX0CoU0=;
	b=H6rmEwnOMrbwf3zurMHZ/ogFdVgjJ6whlG+B/JKdz0gBfNLGfa7uVUTbRQSfUBZOl3aZ/H
	eQJoqexOd6PLoJ9l7HdWKUZnjXh17iWhuNVhcNrxhQ+G8Gc6sTvG3NlTILVpPhQoGMz+Qr
	uL5x4SF39qt+rrE+YLu+NzwywUQJrj08vqUdhII/HqEiQK1/i25ttehwdXqZiB28A7mPO3
	l5rgDDQCuJGJnJHPlJSXqnfydwFEZn+48eyCj7N+FykRluC8CMmqrdSSXoeYIeXfAx5V+7
	jZ4hd1EhgAehHzWHnh4vKbfB+InV3Cajc8jcG78SYPG59oIPcTXq9l1innF2NA==
Date: Tue, 8 Jul 2025 08:30:20 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Richard
 Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>
Subject: Re: [net-next v14 00/12] net: mtip: Add support for MTIP imx287 L2
 switch driver
Message-ID: <20250708083020.0d2a73cd@wsk>
In-Reply-To: <20250701114957.2492486-1-lukma@denx.de>
References: <20250701114957.2492486-1-lukma@denx.de>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4lMkzAC5LI8uGc9.ud9OWwI";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/4lMkzAC5LI8uGc9.ud9OWwI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Dear Community,

> This patch series adds support for More Than IP's L2 switch driver
> embedded in some NXP's SoCs. This one has been tested on imx287, but
> is also available in the vf610.
>=20
> In the past there has been performed some attempts to upstream this
> driver:
>=20
> 1. The 4.19-cip based one [1]
> 2. DSA based one for 5.12 [2] - i.e. the switch itself was treat as a
> DSA switch with NO tag appended.
> 3. The extension for FEC driver for 5.12 [3] - the trick here was to
> fully reuse FEC when the in-HW switching is disabled. When bridge
> offloading is enabled, the driver uses already configured MAC and PHY
> to also configure PHY.
>=20
> All three approaches were not accepted as eligible for upstreaming.
>=20
> The driver from this series has floowing features:
>=20
> 1. It is fully separated from fec_main - i.e. can be used
> interchangeable with it. To be more specific - one can build them as
> modules and if required switch between them when e.g. bridge
> offloading is required.
>=20
>    To be more specific:
>         - Use FEC_MAIN: When one needs support for two ETH ports with
> separate uDMAs used for both and bridging can be realized in SW.
>=20
>         - Use MTIPL2SW: When it is enough to support two ports with
> only uDMA0 attached to switch and bridging shall be offloaded to HW.=20
>=20
> 2. This driver uses MTIP's L2 switch internal VLAN feature to provide
> port separation at boot time. Port separation is disabled when
> bridging is required.
>=20
> 3. Example usage:
>         Configuration:
>         ip link set lan0 up; sleep 1;
>         ip link set lan1 up; sleep 1;
>         ip link add name br0 type bridge;
>         ip link set br0 up; sleep 1;
>         ip link set lan0 master br0;
>         ip link set lan1 master br0;
>         bridge link;
>         ip addr add 192.168.2.17/24 dev br0;
>         ping -c 5 192.168.2.222
>=20
>         Removal:
>         ip link set br0 down;
>         ip link delete br0 type bridge;
>         ip link set dev lan1 down
>         ip link set dev lan0 down
>=20
> 4. Limitations:
>         - Driver enables and disables switch operation with learning
> and ageing.
>         - Missing is the advanced configuration (e.g. adding entries
> to FBD). This is on purpose, as up till now we didn't had consensus
> about how the driver shall be added to Linux.
>=20
> 5. Clang build:
> 	make LLVM_SUFFIX=3D-19 LLVM=3D1 mrproper
> 	cp ./arch/arm/configs/mxs_defconfig .config
> 	make ARCH=3Darm LLVM_SUFFIX=3D-19 LLVM=3D1 W=3D1 menuconfig
> 	make ARCH=3Darm LLVM_SUFFIX=3D-19 LLVM=3D1 W=3D1 -j8
> LOADADDR=3D0x40008000 uImage dtbs
>=20
>         make LLVM_SUFFIX=3D-19 LLVM=3D1 mrproper
>         make LLVM_SUFFIX=3D-19 LLVM=3D1 allmodconfig
>         make LLVM_SUFFIX=3D-19 LLVM=3D1 W=3D1
> drivers/net/ethernet/freescale/mtipsw/ | tee llvm_build.log make
> LLVM_SUFFIX=3D-19 LLVM=3D1 W=3D1 -j8 | tee llvm_build.log
>=20
> 6. Kernel compliance checks:
> 	make coccicheck MODE=3Dreport J=3D4
> M=3Ddrivers/net/ethernet/freescale/mtipsw/
> ~/work/src/smatch/smatch_scripts/kchecker
> drivers/net/ethernet/freescale/mtipsw/
>=20
> 7. GCC
>         make mrproper
>         make allmodconfig
>         make W=3D1 drivers/net/ethernet/freescale/mtipsw/
>=20

Gentle ping on this driver's patch set ...

> Links:
> [1] - https://github.com/lmajewski/linux-imx28-l2switch/commits/master
> [2] -
> https://github.com/lmajewski/linux-imx28-l2switch/tree/imx28-v5.12-L2-ups=
tream-RFC_v1
> [3] -
> https://source.denx.de/linux/linux-imx28-l2switch/-/tree/imx28-v5.12-L2-u=
pstream-switchdev-RFC_v1?ref_type=3Dheads
>=20
>=20
> Lukasz Majewski (12):
>   dt-bindings: net: Add MTIP L2 switch description
>   ARM: dts: nxp: mxs: Adjust the imx28.dtsi L2 switch description
>   ARM: dts: nxp: mxs: Adjust XEA board's DTS to support L2 switch
>   net: mtip: The L2 switch driver for imx287
>   net: mtip: Add buffers management functions to the L2 switch driver
>   net: mtip: Add net_device_ops functions to the L2 switch driver
>   net: mtip: Add mtip_switch_{rx|tx} functions to the L2 switch driver
>   net: mtip: Extend the L2 switch driver with management operations
>   net: mtip: Extend the L2 switch driver for imx287 with bridge
>     operations
>   ARM: mxs_defconfig: Enable CONFIG_NFS_FSCACHE
>   ARM: mxs_defconfig: Update mxs_defconfig to 6.16-rc1
>   ARM: mxs_defconfig: Enable CONFIG_FEC_MTIP_L2SW to support MTIP L2
>     switch
>=20
>  .../bindings/net/nxp,imx28-mtip-switch.yaml   |  150 ++
>  MAINTAINERS                                   |    7 +
>  arch/arm/boot/dts/nxp/mxs/imx28-xea.dts       |   56 +
>  arch/arm/boot/dts/nxp/mxs/imx28.dtsi          |    9 +-
>  arch/arm/configs/mxs_defconfig                |   13 +-
>  drivers/net/ethernet/freescale/Kconfig        |    1 +
>  drivers/net/ethernet/freescale/Makefile       |    1 +
>  drivers/net/ethernet/freescale/mtipsw/Kconfig |   13 +
>  .../net/ethernet/freescale/mtipsw/Makefile    |    4 +
>  .../net/ethernet/freescale/mtipsw/mtipl2sw.c  | 1958
> +++++++++++++++++ .../net/ethernet/freescale/mtipsw/mtipl2sw.h  |
> 654 ++++++ .../ethernet/freescale/mtipsw/mtipl2sw_br.c   |  120 +
>  .../ethernet/freescale/mtipsw/mtipl2sw_mgnt.c |  443 ++++
>  13 files changed, 3418 insertions(+), 11 deletions(-)
>  create mode 100644
> Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
> create mode 100644 drivers/net/ethernet/freescale/mtipsw/Kconfig
> create mode 100644 drivers/net/ethernet/freescale/mtipsw/Makefile
> create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw.h
> create mode 100644
> drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c create mode
> 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw_mgnt.c
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/4lMkzAC5LI8uGc9.ud9OWwI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmhsuvwACgkQAR8vZIA0
zr18FAgAugcPdC55UMMKk5rfZiswE8C+zfajggnswPx6CsyMLd9VC+fQ0vLCEQVF
50g00sQ138COO+I9mkbqjK3LAQFHuMVsuy7SBQqADQ9F2LjzSpt5Y/PiEOL0FQom
bKpFJWGh9b6krGTT9gZcfnVEPDTJ1VRuWoQ1az1gXvGJBH/sHRBvuOqrDb+lVZKl
pkRYXD/cKasueLGPk6GAjalN05PuLtL6wTRQWG2W6AdJcYamaflrDoVRnf1fCn2z
K8fpqZbo91HS38hpjqa4sCQZAlQiHo5xv6nC7glH7Ffwo1PqPOFr4DIKFjkODEIT
JLl4jELD21yMDPVJKxhCH/6sBJhb8Q==
=xtyg
-----END PGP SIGNATURE-----

--Sig_/4lMkzAC5LI8uGc9.ud9OWwI--

