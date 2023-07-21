Return-Path: <netdev+bounces-19773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7694375C2CD
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 11:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A714A1C2160A
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 09:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3BC14F82;
	Fri, 21 Jul 2023 09:18:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D16614F80
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 09:18:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8A0C433C8;
	Fri, 21 Jul 2023 09:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689931102;
	bh=0bzriDPWcVl5IAQAULm4Fy/3jSBYKjLgbMXVXAKk0jw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K43FWKeFEWCJjMNwex7JRXm8/raM/g4hBc/eugX8W614rnt3RiH2UsL1yYaGb5sce
	 M3sn/aE2exI7+aIte6kPaOP/MKr1wnxd5dZMSlqjrpp8elvYHw9rTkQDG2OpuL1aZD
	 HB8vmA+5wEnhvlA2G4+o4Ci3NvXq2aP/wOO8OOREdXKX0jelW5SnxiMNGVgVLfOBsh
	 OMqVvxwRr9c4w4yypNWDjWi9ZrJt3KwDskmV/hmv3vx8gcB+39xD/+jl1ZKE2CFAH0
	 nbr+X7tSQ6jebokMGnbu1V0dSTuMGghIusKbdL82qZCAfg9NQi1pEdiKQKIrk7atdw
	 +3iILHUqzKxdA==
Date: Fri, 21 Jul 2023 10:18:17 +0100
From: Conor Dooley <conor@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Samin Guo <samin.guo@starfivetech.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	Peter Geis <pgwipeout@gmail.com>, Frank <Frank.Sae@motor-comm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Yanhong Wang <yanhong.wang@starfivetech.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: net: motorcomm: Add pad driver
 strength cfg
Message-ID: <20230721-liquid-stench-3721d2483433@spud>
References: <20230720111509.21843-1-samin.guo@starfivetech.com>
 <20230720111509.21843-2-samin.guo@starfivetech.com>
 <0cd8b154-d255-4c16-b76d-9d3b036f3093@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nX7BpCsPop1fJgk1"
Content-Disposition: inline
In-Reply-To: <0cd8b154-d255-4c16-b76d-9d3b036f3093@lunn.ch>


--nX7BpCsPop1fJgk1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2023 at 06:00:15PM +0200, Andrew Lunn wrote:
> > +  motorcomm,rx-clk-drv-microamp:
> > +    description: |
> > +      drive strength of rx_clk rgmii pad.
> > +      The YT8531 RGMII LDO voltage supports 1.8V/3.3V, and the LDO vol=
tage can
> > +      be configured with hardware pull-up resistors to match the SOC v=
oltage
> > +      (usually 1.8V).
> > +      The software can read the registers to obtain the LDO voltage an=
d configure
> > +      the legal drive strength(curren).
> > +      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > +      | voltage |        curren Available (uA)            |
>=20
> current has a t.
>=20
> > +      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > +      | voltage |        curren Available (uA)            |
>=20
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

With the fixup,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.


--nX7BpCsPop1fJgk1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLpNWQAKCRB4tDGHoIJi
0nTzAP0ckflSUS82Xtk5G/0CSY+mIXDKdGQzxx8RPffLo59tfAD+LNoSTLxCZ9iB
x31NhCi8qO6X88lBOMyPXJgPGlkeLg0=
=Z4dn
-----END PGP SIGNATURE-----

--nX7BpCsPop1fJgk1--

