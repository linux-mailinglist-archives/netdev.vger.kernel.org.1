Return-Path: <netdev+bounces-16942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB2774F7CD
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 20:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5631B2818E4
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 18:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D871E52D;
	Tue, 11 Jul 2023 18:10:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80D31E508
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 18:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77234C433C8;
	Tue, 11 Jul 2023 18:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689099018;
	bh=fgsSU4RTwG4VGCYX1r2gOtI9K5ILxtnDHYmNK6g0Mkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sc+m/bTBE4mmECtCDGZJiMQjX7s83U1TwrfjoYrot9ksHXoaYC0wEQd0ySZSa43Si
	 Xf53ueLL+QXtBWoxmxBxcTMwonY27GfRa0LU+rEcjrh1AV/NR1Xcp0XSsjJBmh5e4I
	 qF++OOo0UlxZUg95+pPSEle6XLficCeo38fGGIKXpMvWcwq6sZcq7LiUz4+28mC2Z0
	 3TJn0byHHeNPf8oEt6/XIzkcI1RPotW1TuG2G2us1+sfbgnWBpTA2z7dbDrGVEFmZ+
	 vfDpTvP85IxQ5PEsfdXAhiIo7wxIHBrxT8Wrvmtks2QdQMpQt5gIqDkcG8+Y9udOiN
	 WXFt5ncsTu0hQ==
Date: Tue, 11 Jul 2023 19:10:12 +0100
From: Conor Dooley <conor@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
	git@xilinx.com,
	Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
	Wolfgang Grandegger <wg@grandegger.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: can: xilinx_can: Add reset description
Message-ID: <20230711-parted-rasping-82b911b90e1e@spud>
References: <cover.1689084227.git.michal.simek@amd.com>
 <c8e7f86d60b56a9ca2592d9ee30a3a64e535f429.1689084227.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="goRIxT+tsSQKD88J"
Content-Disposition: inline
In-Reply-To: <c8e7f86d60b56a9ca2592d9ee30a3a64e535f429.1689084227.git.michal.simek@amd.com>


--goRIxT+tsSQKD88J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2023 at 04:03:54PM +0200, Michal Simek wrote:
> IP core has input for reset signal which can be connected that's why
> describe optional reset property.
>=20
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>=20
>  Documentation/devicetree/bindings/net/can/xilinx,can.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml b/=
Documentation/devicetree/bindings/net/can/xilinx,can.yaml
> index 897d2cbda45b..64d57c343e6f 100644
> --- a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
> +++ b/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
> @@ -46,6 +46,9 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description: CAN Tx mailbox buffer count (CAN FD)
> =20
> +  resets:
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
> --=20
> 2.36.1
>=20

--goRIxT+tsSQKD88J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZK2bBAAKCRB4tDGHoIJi
0pTmAP0RcjbnxLer61UPJAZOWQdhrzOor0yr7ddQcKI9iGX9RAEAshUh7JvDWhDV
fnrS8qIgliqgcBJXI/9ewYwCU5qfTQ8=
=QG6Q
-----END PGP SIGNATURE-----

--goRIxT+tsSQKD88J--

