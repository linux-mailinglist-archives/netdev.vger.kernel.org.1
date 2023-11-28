Return-Path: <netdev+bounces-51779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 172A17FC046
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 18:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8226282A09
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 17:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643CE5C06A;
	Tue, 28 Nov 2023 17:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhIS7Awr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C3F443E;
	Tue, 28 Nov 2023 17:29:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875ECC433C7;
	Tue, 28 Nov 2023 17:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701192570;
	bh=4XvKlG/zv6MZy3Qi+1cyz4jVKinz5Rpd8AQHCJ5MZWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uhIS7Awr6BRSM0qCLhFQKcG5NqrcWBrH+WnLFYMSXN00D0yANQf2FPU39R4pZoWtb
	 XEVIgw5PGnKQDSVDxZxmW5a2n+zkS3nJ17kFTHbH+sqQ8opEtYf4t2t4RSlYlI2pZi
	 gP0kNhoalFZ4jn2wXiy2U3QEar0nD+8Zz0Z5uVLx1tF3keYaGu8IEv2xe1xqCYRlJC
	 YyK2ctqeirUNTrhk3OffUuTsyTv9iuo5juELUOMWHUPQPqidgiThtDfd5ttStxXDtu
	 TCu3K4WLyDU/Am1wThc5Af9e4mRCEw/R+iNMwZFhZ1TrRxjJ/DroZPJWjT5g+pfISV
	 AWcsn1escATwA==
Date: Tue, 28 Nov 2023 17:29:25 +0000
From: Conor Dooley <conor@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Ante Knezic <ante.knezic@helmholz.de>, netdev@vger.kernel.org,
	woojung.huh@microchip.com, andrew@lunn.ch, f.fainelli@gmail.com,
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	marex@denx.de, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v6 1/2] dt-bindings: net: microchip,ksz:
 document microchip,rmii-clk-internal
Message-ID: <20231128-laxative-overjoyed-ab1b4b3656a1@spud>
References: <cover.1701091042.git.ante.knezic@helmholz.de>
 <7f1f89010743a06c4880fd224149ea495fe32512.1701091042.git.ante.knezic@helmholz.de>
 <20231128150203.GA3264915-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Eaz27h0FCLG7yZaF"
Content-Disposition: inline
In-Reply-To: <20231128150203.GA3264915-robh@kernel.org>


--Eaz27h0FCLG7yZaF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 09:02:03AM -0600, Rob Herring wrote:
> On Mon, Nov 27, 2023 at 02:20:42PM +0100, Ante Knezic wrote:
> > Add documentation for selecting reference rmii clock on KSZ88X3 devices
> >=20
> > Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
> > ---
> >  .../devicetree/bindings/net/dsa/microchip,ksz.yaml | 38 ++++++++++++++=
+++++++-
> >  1 file changed, 37 insertions(+), 1 deletion(-)
>=20
> You forgot Conor's ack.

I think that's for the better, v5 and v6 look to have changed a decent
amount from what I acked in v4.

--Eaz27h0FCLG7yZaF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWYjdQAKCRB4tDGHoIJi
0sM2AP0UONa6EAG1nkKSAMDOqDho9LhS8mI88zn0U4Zuvi53FQD+IEMco3IIebRn
qUJ59RjTmGnDpyXY+3khiNsf+D9M3QA=
=BBCx
-----END PGP SIGNATURE-----

--Eaz27h0FCLG7yZaF--

