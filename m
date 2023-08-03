Return-Path: <netdev+bounces-24133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE6876EEAC
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 17:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EE511C215A0
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 15:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E6C24163;
	Thu,  3 Aug 2023 15:52:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F3123BE1
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 15:52:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100C9C433C8;
	Thu,  3 Aug 2023 15:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691077935;
	bh=shdLTUl/hzYbRD8G510/eXZG57dpgv2R1y08l4NSUis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jqQsbbvug9fDxopaztR1czHBNQ3OAniPfAUled1HxzUfts/5zXHHqEPkwrphh1f1S
	 1F0TBFJnSDipaN8aXHBM8mq6NZMlrmdsRVM5UvvpLqja6mX2TVt4yU5WG0f6SDUc7O
	 i8JLcjlj2YB09/zdeDIow4JnHJIX9Cp/CTPiW9Br809/3iFMwIAF074AUlO29evUUQ
	 hC8RDESoFZYtlOqY7DwcUt57hPZnHLJCw7uGlWdurdWHNQgmL2Pgf75SN6B2I/a0V7
	 CyGSwlhYKJxU3Kf4nQMfjtx4jt69tXjpI+GSO5QJSRxCVKiO2jS+gMUVfrgPA8Hb2A
	 UKcPFj8ez6TRw==
Date: Thu, 3 Aug 2023 16:52:09 +0100
From: Conor Dooley <conor@kernel.org>
To: nick.hawkins@hpe.com
Cc: christophe.jaillet@wanadoo.fr, simon.horman@corigine.com,
	andrew@lunn.ch, verdun@hpe.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] dt-bindings: net: Add HPE GXP UMAC
Message-ID: <20230803-balance-octopus-3d36f784f776@spud>
References: <20230802201824.3683-1-nick.hawkins@hpe.com>
 <20230802201824.3683-4-nick.hawkins@hpe.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YjjCSeNwyEiwRtye"
Content-Disposition: inline
In-Reply-To: <20230802201824.3683-4-nick.hawkins@hpe.com>


--YjjCSeNwyEiwRtye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2023 at 03:18:22PM -0500, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
>=20
> Provide access to the register regions and interrupt for Universal
> MAC(UMAC). The driver under the hpe,gxp-umac binding will provide an
> interface for sending and receiving networking data from both of the
> UMACs on the system.
>=20
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
>=20
> ---
>=20
> v2:
>  *Move mac-addresses into ports
>  *Remove | where not needed
> ---
>  .../devicetree/bindings/net/hpe,gxp-umac.yaml | 112 ++++++++++++++++++
>  1 file changed, 112 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/hpe,gxp-umac.ya=
ml
>=20
> diff --git a/Documentation/devicetree/bindings/net/hpe,gxp-umac.yaml b/Do=
cumentation/devicetree/bindings/net/hpe,gxp-umac.yaml
> new file mode 100644
> index 000000000000..ff1a3a201dcf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/hpe,gxp-umac.yaml
> @@ -0,0 +1,112 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/hpe,gxp-umac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HPE GXP Unified MAC Controller
> +
> +maintainers:
> +  - Nick Hawkins <nick.hawkins@hpe.com>
> +
> +description:
> +  HPE GXP 802.3 10/100/1000T Ethernet Unifed MAC controller.
> +  Device node of the controller has following properties.
> +
> +properties:
> +  compatible:
> +    const: hpe,gxp-umac
> +

> +  use-ncsi:
> +    type: boolean
> +    description:
> +      Indicates if the device should use NCSI (Network Controlled
> +      Sideband Interface).

How is one supposed to know if the device should use NCSI? If the
property is present does that mean that the mac hardware supports
it? Or is it determined by what board this mac is on?
Or is this software configuration?

Thanks,
Conor.

--YjjCSeNwyEiwRtye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMvNKQAKCRB4tDGHoIJi
0vEOAP9KpKkL8uHbXhp1szAIL+d8eDVx+Zy0uYlk5Nh7tT45gQD+NASu+mEXy4Hv
WnInK04BprIpkAZdykvcmILghGdm8wA=
=Bm8/
-----END PGP SIGNATURE-----

--YjjCSeNwyEiwRtye--

