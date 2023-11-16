Return-Path: <netdev+bounces-48372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A7D7EE2AD
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 15:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32F201C209C7
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 14:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851F5321B5;
	Thu, 16 Nov 2023 14:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tT7pAGH6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A382321AB;
	Thu, 16 Nov 2023 14:22:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF52C433C7;
	Thu, 16 Nov 2023 14:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700144564;
	bh=IS1DuP8+1kUE365TQJj5hRQ+HcxauE+Dzik9ZXeEijs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tT7pAGH6H3r4emjRDPthCSKY7xssdmajLP+5/xeX438B0cVaprE19Rd+hqlsFDTnA
	 lbDytFbjZI0hjk0zl/Tqc/XBmgFoBsYxUZh3aGT5EQ2k49cOD6Y/VY23Zmw/R78wy1
	 adQYt0kMhCre5T9OBOZA5Tr4UduG3PTISDvLVwKT8XrHiMfoRfLVEpDOaqWDnvMLJN
	 D65c7S2NrUo6z6liQrbz4MPWSgE0lBuDxOn/VXFGyiPZ+zfDMcbuLlLjr3Df1InDIa
	 obQHutb1sRJQ36sT7hqMyhRDbxVqcW9hXm5bQAop8cVjHu66hztlz9TVItoS+IT62Y
	 +ch0tVomSEpIg==
Date: Thu, 16 Nov 2023 14:22:41 +0000
From: Conor Dooley <conor@kernel.org>
To: Luo Jie <quic_luoj@quicinc.com>
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	hkallweit1@gmail.com, linux@armlinux.org.uk, corbet@lwn.net,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 2/6] dt-bindings: net: ethernet-controller: add
 10g-qxgmii mode
Message-ID: <20231116-flier-washed-eb1a45481323@squawk>
References: <20231116112437.10578-1-quic_luoj@quicinc.com>
 <20231116112437.10578-3-quic_luoj@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eeTAmJq3hbXLEdrA"
Content-Disposition: inline
In-Reply-To: <20231116112437.10578-3-quic_luoj@quicinc.com>


--eeTAmJq3hbXLEdrA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 07:24:33PM +0800, Luo Jie wrote:
> Add the new interface mode 10g-qxgmii, which is similar to
> usxgmii but extend to 4 channels to support maximum of 4
> ports with the link speed 10M/100M/1G/2.5G.
>=20

> This patch is separated from Vladimir Oltean's previous patch
> <net: phy: introduce core support for phy-mode =3D "10g-qxgmii">.

This belongs in the changelog under the --- line.

>=20
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Are you missing a from: line in this patch?

> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>

Otherwise,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/net/ethernet-controller.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.ya=
ml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> index d14d123ad7a0..0ef6103c5fd8 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> @@ -104,6 +104,7 @@ properties:
>        - usxgmii
>        - 10gbase-r
>        - 25gbase-r
> +      - 10g-qxgmii
> =20
>    phy-mode:
>      $ref: "#/properties/phy-connection-type"
> --=20
> 2.42.0
>=20

--eeTAmJq3hbXLEdrA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVYlrgAKCRB4tDGHoIJi
0stsAQC/xl95sWf1KDMyE1ytf/jBbf6R1duIc9zoYY4ivS9IhAD9FebNFMkbQsMM
CW1kP66V0irHHz6eUXF+HF8sOB2uLAE=
=JVOw
-----END PGP SIGNATURE-----

--eeTAmJq3hbXLEdrA--

