Return-Path: <netdev+bounces-99899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 526CC8D6EFF
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 10:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D34B41F2381D
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 08:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E55813E3ED;
	Sat,  1 Jun 2024 08:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXJQ51s+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CF813E05B;
	Sat,  1 Jun 2024 08:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717231599; cv=none; b=O2iLKpS72T8VYfp1b7XU7UO5OKqRVU3wkVjQ6xiXdta9096cmVO4UaHowXMRqsvTn6eLmoMLmVAzMXnkhMDqfMW2eQjHLHinfD+WLB51atsHuiBtD0XwyBxbH8cZ6KvMRcoSrxiy4WSa/waCfQXslu7M3jONT0htIvX5jIupQoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717231599; c=relaxed/simple;
	bh=AhVhrQGccmJTrlTax3eYsDOox2Bstk35sLqtvHRwKqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4kBkn+DX6iqeEYqJUaoJlqyXWglOYfD/eeU9HuJlWsQOuT0rebaHkHrCVW2ir9c0EorixLKMqVopJvgJSfHjDz+vwrQwMySd4dTj7q/qDCsDrkeDQEbnCyA6MtlVgmnQ7rOoWpvbJ2iyJI7EQABtugg6pditv98dxf7ymSxqy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXJQ51s+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CA0C116B1;
	Sat,  1 Jun 2024 08:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717231598;
	bh=AhVhrQGccmJTrlTax3eYsDOox2Bstk35sLqtvHRwKqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TXJQ51s+J0tjkTjX9h6jhAyl+Ei4g3Yn8N/N+iRTW0h38/dq6xIQUd/sDJit+Q4QX
	 3r0BVUqA5d2RQoPPNCy2nyA2NSLs17aAiY3qMpHhY+iu/a4GhlQqI3/JMab7woitX/
	 MdIuQ5QGdl9seBqpfBqvjM/3+4eO/LsQO9SuOaBWh59Av4/fMmkCopvVi91LXzr2TC
	 QKSXcgvpXmEM93Z6n0w5r+d9Fcqh9kC+2JsOCnZIwiJfG52QOEpONhInM0rkg9dPTn
	 TiZcAShiydlY0CapKwNYPUW4Ml/G1jozUilRSkmfberPKt4glSym5dEH+kuAAU+YxW
	 pbwBqEr5K36QA==
Date: Sat, 1 Jun 2024 10:46:34 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: angelogioacchino.delregno@collabora.com, pabeni@redhat.com,
	devicetree@vger.kernel.org, upstream@airoha.com, conor@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, davem@davemloft.net,
	will@kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
	catalin.marinas@arm.com, netdev@vger.kernel.org,
	edumazet@google.com, kuba@kernel.org, benjamin.larsson@genexis.eu,
	conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org
Subject: Re: [PATCH net-next 1/3] dt-bindings: net: airoha: Add EN7581
 ethernet controller
Message-ID: <Zlrf6vF84nEb0M8h@lore-desk>
References: <cover.1717150593.git.lorenzo@kernel.org>
 <97946e955b05d21fe96ef8f98f794831cbd7c3b5.1717150593.git.lorenzo@kernel.org>
 <171715519233.1178488.4895515254191995557.robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3FI1EhjXmzdMgZMG"
Content-Disposition: inline
In-Reply-To: <171715519233.1178488.4895515254191995557.robh@kernel.org>


--3FI1EhjXmzdMgZMG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
> On Fri, 31 May 2024 12:22:18 +0200, Lorenzo Bianconi wrote:
> > Introduce device-tree binding documentation for Airoha EN7581 ethernet
> > mac controller.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  .../bindings/net/airoha,en7581.yaml           | 106 ++++++++++++++++++
> >  1 file changed, 106 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/airoha,en7581=
=2Eyaml
> >=20
>=20
> My bot found errors running 'make dt_binding_check' on your patch:
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/net/airoha,en7581.example.dts:27:18: fa=
tal error: dt-bindings/reset/airoha,en7581-reset.h: No such file or directo=
ry
>    27 |         #include <dt-bindings/reset/airoha,en7581-reset.h>
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[2]: *** [scripts/Makefile.lib:427: Documentation/devicetree/bindings=
/net/airoha,en7581.example.dtb] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1430: dt_bin=
ding_check] Error 2
> make: *** [Makefile:240: __sub-make] Error 2
>=20
> doc reference errors (make refcheckdocs):
>=20
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/97946e=
955b05d21fe96ef8f98f794831cbd7c3b5.1717150593.git.lorenzo@kernel.org
>=20
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.
>=20
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>=20
> pip3 install dtschema --upgrade
>=20
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your sch=
ema.
>=20

Hi Rob,

ack, right. The issue is the airoha reset patches [0] have not been applied=
 yet
but they are in my development tree so 'make dt_binding_check' works fine f=
or
me. Sorry for the noise.
I am wondering what is the right approach in this case. Should we wait for =
dts
prerequisite patches to be in net-next tree or are dts patches of this seri=
es
going to be applied to a different tree with respect to driver core that is
going to net-next?

Regards,
Lorenzo

[0] https://patchwork.kernel.org/project/linux-clk/cover/cover.1715948628.g=
it.lorenzo@kernel.org/

--3FI1EhjXmzdMgZMG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZlrf6gAKCRA6cBh0uS2t
rAEMAQCR248Wn3Z8kHDA52wggubBvEAGlFR1qjdj+lFJyyvK5QD8DhomDqE9yq94
U0kQgvLXGSZRhvmdj9VNrqhjnoB57wA=
=kUUt
-----END PGP SIGNATURE-----

--3FI1EhjXmzdMgZMG--

