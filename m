Return-Path: <netdev+bounces-23423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C589476BEDB
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 22:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3A131C21028
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 20:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC2A263A5;
	Tue,  1 Aug 2023 20:55:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECA34DC77
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 20:55:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E4DC433C7;
	Tue,  1 Aug 2023 20:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690923332;
	bh=mm3PCHxbwsPxpNKZvF47Eq/nkX3Fl3n17TT37Rm9fuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jYJpB5TgdglczH9pMWcLYolh/Bqraj/YkJIzZJ6u9wmVzHEAljC4hSb3/OOtTBEeQ
	 EsZX7mJyjmZxjeTjWjaln+MUKFSZ80TGplGDRT6Sz511UieJb2dEQsB5MKBcH668p3
	 M5INEcXObtUmfMbhpNhSbqV8+vZRliTza71Q2BgeIIJKNIJKSHClQTrKKD1tLaTLix
	 pW3eaZgd6gdfB7+bilYeAhhEnOWeFrKL9hyjFgg4oiTwoe4P2qm7rBgLSDiXA9HV9S
	 bpoOHzAjZtxMyEZtynw7xr1VA+fiTW2T7ling1zFYpU8eXfSzQ9pFlJG2/mtsvcWa0
	 /tLfgYwkOrNvQ==
Date: Tue, 1 Aug 2023 21:55:26 +0100
From: Conor Dooley <conor@kernel.org>
To: niravkumar.l.rabara@intel.com
Cc: adrian.ho.yin.ng@intel.com, andrew@lunn.ch, conor+dt@kernel.org,
	devicetree@vger.kernel.org, dinguyen@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, mturquette@baylibre.com,
	netdev@vger.kernel.org, p.zabel@pengutronix.de,
	richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
	wen.ping.teh@intel.com
Subject: Re: [PATCH v2 2/5] dt-bindings: reset: add reset IDs for Agilex5
Message-ID: <20230801-roast-frigidly-4ea82386bb3d@spud>
References: <20230618132235.728641-1-niravkumar.l.rabara@intel.com>
 <20230801010234.792557-1-niravkumar.l.rabara@intel.com>
 <20230801010234.792557-3-niravkumar.l.rabara@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7JizuF9tmWfj3Hnb"
Content-Disposition: inline
In-Reply-To: <20230801010234.792557-3-niravkumar.l.rabara@intel.com>


--7JizuF9tmWfj3Hnb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 01, 2023 at 09:02:31AM +0800, niravkumar.l.rabara@intel.com wro=
te:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
>=20
> Add reset ID definitions required for Intel Agilex5 SoCFPGA, re-use
> altr,rst-mgr-s10.h as common header file similar S10 & Agilex.
>=20
> Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  include/dt-bindings/reset/altr,rst-mgr-s10.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/dt-bindings/reset/altr,rst-mgr-s10.h b/include/dt-bi=
ndings/reset/altr,rst-mgr-s10.h
> index 70ea3a09dbe1..04c4d0c6fd34 100644
> --- a/include/dt-bindings/reset/altr,rst-mgr-s10.h
> +++ b/include/dt-bindings/reset/altr,rst-mgr-s10.h
> @@ -63,12 +63,15 @@
>  #define I2C2_RESET		74
>  #define I2C3_RESET		75
>  #define I2C4_RESET		76
> -/* 77-79 is empty */
> +#define I3C0_RESET		77
> +#define I3C1_RESET		78
> +/* 79 is empty */
>  #define UART0_RESET		80
>  #define UART1_RESET		81
>  /* 82-87 is empty */
>  #define GPIO0_RESET		88
>  #define GPIO1_RESET		89
> +#define WATCHDOG4_RESET		90
> =20
>  /* BRGMODRST */
>  #define SOC2FPGA_RESET		96
> --=20
> 2.25.1
>=20

--7JizuF9tmWfj3Hnb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMlxPgAKCRB4tDGHoIJi
0j/yAQCN8amnEfhB4tqnW7rRuRVU+vga9lWTHsdxnAi7KxIfGQD/RzRlxKV2gbZF
zkFsLzoFDmLwFyZ0m+gs10g7xmc8zww=
=DGyl
-----END PGP SIGNATURE-----

--7JizuF9tmWfj3Hnb--

