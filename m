Return-Path: <netdev+bounces-26550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AD2778119
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 21:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB54B1C20B7E
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 19:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6F222F0D;
	Thu, 10 Aug 2023 19:14:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6869E20CA8
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 19:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7ABC433C7;
	Thu, 10 Aug 2023 19:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691694851;
	bh=kqCd67KWHHOLReJvm60zqqKL8Zb5KIbe0uvLTrSIOZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EKiS+ULIakQrrpijPFaaf0WBEim2QoRzv+C220roUF0VfjlU17zCdMn2SzsEhU6FP
	 SRtpPfGcARWlvKncZkOLSN2YI/UMmKBldJtxyKl4PMIwfYhSUbNw0Ka2/iv0UdoJV3
	 6nuYDDlVc1aMF7JMomgxsXiGeENAXSM5Qy45kkgmWIoEJjYbcd7KlLacAdqRD4aa6d
	 w3cgON9vVn+sS3nuEAK7s4vFIHDt82UaFvXB0Sai71E3bzB172dULGdRIA1CbNyWm6
	 0nLYTOgQKs4HZFo9KLXNcRXw13T/htD5/445A8BuoSNxvtP+OOilpXdP4LXEH/ZfFK
	 t7xoqjuIrGKXw==
Date: Thu, 10 Aug 2023 20:14:04 +0100
From: Conor Dooley <conor@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: trivial-devices: Remove national,lm75
Message-ID: <20230810-prissy-nibble-9f7747bdb64e@spud>
References: <20230810144451.1459985-1-alexander.stein@ew.tq-group.com>
 <20230810144451.1459985-2-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kIdsuo58jt+pjDVs"
Content-Disposition: inline
In-Reply-To: <20230810144451.1459985-2-alexander.stein@ew.tq-group.com>


--kIdsuo58jt+pjDVs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2023 at 04:44:46PM +0200, Alexander Stein wrote:
> Starting with commit 3e37c9d48f7a ("dt-bindings: hwmon: Convert lm75
> bindings to yaml") 'national,lm75' has it's own dedicated (YAML) binding.
> If kept in this file device specific properties as 'vs-supply' are
> considered excessive. Remove compatible here so it can be checked with
> more specific binding.
> arch/arm/boot/dts/nxp/imx/imx6q-mba6a.dtb: sensor@48: 'vs-supply' does not
> match any of the regexes: 'pinctrl-[0-9]+'
>   From schema: Documentation/devicetree/bindings/trivial-devices.yaml
>=20
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Doc=
umentation/devicetree/bindings/trivial-devices.yaml
> index 40bc475ee7e1..e30335d4e504 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -295,8 +295,6 @@ properties:
>            - miramems,da311
>              # Temperature sensor with integrated fan control
>            - national,lm63
> -            # I2C TEMP SENSOR
> -          - national,lm75
>              # Serial Interface ACPI-Compatible Microprocessor System Har=
dware Monitor
>            - national,lm80
>              # Serial Interface ACPI-Compatible Microprocessor System Har=
dware Monitor
> --=20
> 2.34.1
>=20

--kIdsuo58jt+pjDVs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNU2/AAKCRB4tDGHoIJi
0lwWAQDrilXexeGOevcNPNlmm6AD15crdC32Z29BDRztUy33MQD/V1hjWuJ7t9ek
NCcwFrHAYB6J63OH6XLI1MraklBLBAw=
=4Iva
-----END PGP SIGNATURE-----

--kIdsuo58jt+pjDVs--

