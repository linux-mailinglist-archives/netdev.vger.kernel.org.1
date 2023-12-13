Return-Path: <netdev+bounces-56596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1B580F873
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 21:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC28F28495B
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 20:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BD365A70;
	Tue, 12 Dec 2023 20:51:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A707AD4C
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 12:51:41 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rD9hL-0006JL-4s; Tue, 12 Dec 2023 21:49:47 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rD9hI-00FQAr-Q7; Tue, 12 Dec 2023 21:49:44 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BF57D261699;
	Tue, 12 Dec 2023 20:49:42 +0000 (UTC)
Date: Tue, 12 Dec 2023 21:49:41 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH RESEND v1 2/7] dt-bindings: can: mpfs: add missing
 required clock
Message-ID: <20231212-unreeling-depose-8b6b2e032555-mkl@pengutronix.de>
References: <20231208-reenter-ajar-b6223e5134b3@spud>
 <20231208-palpitate-passable-c79bacf2036c@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4h2qlcdcaxtarwhl"
Content-Disposition: inline
In-Reply-To: <20231208-palpitate-passable-c79bacf2036c@spud>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--4h2qlcdcaxtarwhl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08.12.2023 17:12:24, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> The CAN controller on PolarFire SoC has an AHB peripheral clock _and_ a
> CAN bus clock. The bus clock was omitted when the binding was written,
> but is required for operation. Make up for lost time and add it.
>=20
> Cautionary tale in adding bindings without having implemented a real
> user for them perhaps.
>=20
> Fixes: c878d518d7b6 ("dt-bindings: can: mpfs: document the mpfs CAN contr=
oller")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../devicetree/bindings/net/can/microchip,mpfs-can.yaml    | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/microchip,mpfs-can=
=2Eyaml b/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
> index 45aa3de7cf01..05f680f15b17 100644
> --- a/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
> +++ b/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
> @@ -24,7 +24,10 @@ properties:
>      maxItems: 1
> =20
>    clocks:
> -    maxItems: 1
> +    maxItems: 2
> +    items:
> +      - description: AHB peripheral clock
> +      - description: CAN bus clock

Do we we want to have a "clock-names" property, as we need the clock
rate of the CAN bus clock.

Marc

> =20
>  required:
>    - compatible
> @@ -39,7 +42,7 @@ examples:
>      can@2010c000 {
>          compatible =3D "microchip,mpfs-can";
>          reg =3D <0x2010c000 0x1000>;
> -        clocks =3D <&clkcfg 17>;
> +        clocks =3D <&clkcfg 17>, <&clkcfg 37>;
>          interrupt-parent =3D <&plic>;
>          interrupts =3D <56>;
>      };

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--4h2qlcdcaxtarwhl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmV4x1gACgkQvlAcSiqK
BOgF/AgAhJ4xir0nA6ujdFUlOe+BWbITRC3gKi4T8KNqQvU+8gfmDpk0EjBpkbT0
5H1M0A+FA44+z9JDq6MWnVWxoajf03KOfKBjbciOadSrrBXY96gIIAnJbpJTt8yj
qCtULHegVD42Wd0VEtxqny4TTkSeTIDstqKX65M5PNn8wKKtVtbufPuFVTOZ08IA
NSXUrGvAAhKVWGtY6fe/qw5BebQIDc6fdl3xzF0R6UZzKGluO5JVeMAItJ5HtT8K
JiUGMmxEt+H2EpiQtVtY5arGq+RmwhMVSDu9CFCDgtNqbszvV8lXZebODUP+a2xu
EDNNicG+TnD2kVzye9AYXJ+qizwySg==
=Df6N
-----END PGP SIGNATURE-----

--4h2qlcdcaxtarwhl--

