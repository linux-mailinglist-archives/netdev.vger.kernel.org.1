Return-Path: <netdev+bounces-21299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA067632F3
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 11:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E2FF281246
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 09:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239CFBE56;
	Wed, 26 Jul 2023 09:57:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BB7BA3B
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 09:57:39 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFCF2119
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 02:57:38 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qObGc-0007rN-GQ; Wed, 26 Jul 2023 11:57:14 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 841111FB155;
	Wed, 26 Jul 2023 09:57:12 +0000 (UTC)
Date: Wed, 26 Jul 2023 11:57:11 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: haibo.chen@nxp.com
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	wg@grandegger.com, kernel@pengutronix.de, linux-imx@nxp.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, devicetree@vger.kernel.org,
	linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/3] arm64: dts: imx93: add the Flex-CAN stop mode by
 GPR
Message-ID: <20230726-moocher-managing-5a5352a4266a-mkl@pengutronix.de>
References: <20230726090909.3417030-1-haibo.chen@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2ujf745qpqkrvicw"
Content-Disposition: inline
In-Reply-To: <20230726090909.3417030-1-haibo.chen@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--2ujf745qpqkrvicw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.07.2023 17:09:07, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
>=20
> imx93 A0 chip use the internal q-channel handshake signal in LPCG
> and CCM to automatically handle the Flex-CAN stop mode. But this
> method meet issue when do the system PM stress test. IC can't fix
> it easily. So in the new imx93 A1 chip, IC drop this method, and
> involve back the old way=EF=BC=8Cuse the GPR method to trigger the Flex-C=
AN
> stop mode signal. Now NXP claim to drop imx93 A0, and only support
> imx93 A1. So here add the stop mode through GPR.
>=20
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx93.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/d=
ts/freescale/imx93.dtsi
> index 4ec9df78f205..d2040019e9c7 100644
> --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> @@ -319,6 +319,7 @@ flexcan1: can@443a0000 {
>  				assigned-clock-parents =3D <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
>  				assigned-clock-rates =3D <40000000>;
>  				fsl,clk-source =3D /bits/ 8 <0>;
> +				fsl,stop-mode =3D <&anomix_ns_gpr 0x14 0>;

I think there's a typo in the mainline imx93.dtsi. AFAICS it's supposed
to be "aonmix_ns_gpr", not "anomix_ns_gpr". But that's a different
problem to patch :)

AFAICS, according to imx93, rev2 data sheet, offset 0x14 is 76.6.1.3
QCHANNEL DISABLE (QCH_DIS) and bit 0 is "GPIO1". Are you sure this is
the correct reg?

>  				status =3D "disabled";
>  			};
> =20
> @@ -591,6 +592,7 @@ flexcan2: can@425b0000 {
>  				assigned-clock-parents =3D <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
>  				assigned-clock-rates =3D <40000000>;
>  				fsl,clk-source =3D /bits/ 8 <0>;
> +				fsl,stop-mode =3D <&wakeupmix_gpr 0x0C 2>;

looks plausible, please use lower case for hex addresses.

>  				status =3D "disabled";
>  			};
> =20
> --=20
> 2.34.1
>=20
>

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2ujf745qpqkrvicw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmTA7fQACgkQvlAcSiqK
BOhzjgf+Kgd/bRs+UDJX8hGI1Qfk1H3FdtJha2NOWmnPMg9Yi8i2JgNFB0132IML
+aTKa9SZ6LzWNQ7yjslmhmaM59VECO0DX6UhGUrU6E9dNS3sGsUcFhwgJBxgSWvq
4PhN3hLdWDexik6Qo1n9iWYflbmS/NnVJpixCwuQ2mKVvySsBOetmcFBnSY7pkD2
VCXFsmEcRQ8QK48bPAbMSgVQDDoqdMjBA0y5f51LatAGQ74LF6S2Qi1r1ils04ZJ
OCs30vbz1rvwe6GH9QWIhmea3HxWSH126n+YV7VCY2YZnOrE9sOR+ZwoRQ9yWmLI
Ha38AFsQR7pT6+Sk/PPMMb4Cs8C5nw==
=ynP/
-----END PGP SIGNATURE-----

--2ujf745qpqkrvicw--

