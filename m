Return-Path: <netdev+bounces-31944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8129C791A11
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 16:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2A9C1C2081F
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 14:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8C5C12E;
	Mon,  4 Sep 2023 14:53:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D38FA949
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 14:53:23 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B5E1A5
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 07:53:22 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qdAwc-0007kU-4G; Mon, 04 Sep 2023 16:52:50 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4D3C92186D5;
	Mon,  4 Sep 2023 14:52:48 +0000 (UTC)
Date: Mon, 4 Sep 2023 16:52:47 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Srinivas Goud <srinivas.goud@amd.com>
Cc: wg@grandegger.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	p.zabel@pengutronix.de, git@amd.com, michal.simek@amd.com,
	linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, appana.durga.rao@xilinx.com,
	naga.sureshkumar.relli@xilinx.com
Subject: Re: [PATCH v4 1/3] dt-bindings: can: xilinx_can: Add ECC property
 'xlnx,has-ecc'
Message-ID: <20230904-crystal-jokester-a76c1506c442-mkl@pengutronix.de>
References: <1693557645-2728466-1-git-send-email-srinivas.goud@amd.com>
 <1693557645-2728466-2-git-send-email-srinivas.goud@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nin2tevzwjvssdyh"
Content-Disposition: inline
In-Reply-To: <1693557645-2728466-2-git-send-email-srinivas.goud@amd.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--nin2tevzwjvssdyh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01.09.2023 14:10:43, Srinivas Goud wrote:
> ECC feature added to Tx and Rx FIFOs for Xilinx AXI CAN Controller.
> Part of this feature configuration and counter registers added in
> IP for 1bit/2bit ECC errors.
>=20
> xlnx,has-ecc is optional property and added to Xilinx AXI CAN Controller
> node if ECC block enabled in the HW
>=20
> Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
> ---
> Changes in v4:
> Fix binding check warning
> Update property description=20
>=20
> Changes in v3:
> Update commit description
>=20
> Changes in v2:
> None
>=20
>  Documentation/devicetree/bindings/net/can/xilinx,can.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml b/=
Documentation/devicetree/bindings/net/can/xilinx,can.yaml
> index 64d57c3..50a2671 100644
> --- a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
> +++ b/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
> @@ -49,6 +49,10 @@ properties:
>    resets:
>      maxItems: 1
> =20
> +  xlnx,has-ecc:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: CAN Tx and Rx fifo has ECC (AXI CAN)

Are there 2 FIFOs? If so I'd phrase it this way:
"CAN TX and RX FIFOs have ECC support (AXI CAN)" - or -
"CAN TX and RX FIFOs support ECC"

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--nin2tevzwjvssdyh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmT17z0ACgkQvlAcSiqK
BOgWQQf+My4CPC2KjO558oJv4n5uvbTZcmM8qAT2RFDMOB+Kny4bi4yvygdF6ysD
sBj/FRevD9HgawxAHO7f99cCSdwg+DLex4Ya9wJ4Lu/SnebAP9WQxCx6esvnYdEa
tsGQqEQqBPn6RsuK9fcmeiIX9kNg9EWstA5e6LclXusSrkdpYGMiF1seeUEzxDK7
IBxfHm6I9n/HqOg92PJrhtOo4DFMAC0FXm35yqxTXidRW91CdpbECLJcRcnxhc2x
jco+vaxeVylUUkzLhxcfX5+7dcOAQ8bwQeWYg0tREThMxrUbfeMvOxgCJ802pHZK
XZroGNCv/NZ2s30019lKTfyPyalaRA==
=NA90
-----END PGP SIGNATURE-----

--nin2tevzwjvssdyh--

