Return-Path: <netdev+bounces-143980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A46899C4F84
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 08:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F5B5B254CD
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 07:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0CD20B21C;
	Tue, 12 Nov 2024 07:36:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A874620B1FD
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 07:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731396964; cv=none; b=s0MpIm9A9kteLHSTmjhBqHzyLZKTbsH1C7cJq09G1RYQT6AFK9m/GXho+FSY/NFvHegrXs1gz4n4BkGEeM3yySvOvzZhwVS5UBUl+0Zjun7dbRoVF41okOjPRhVqi3MS6UZQf8embJ9dz7fzrsiZxA9L6OHokq5SU1GueFlHUUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731396964; c=relaxed/simple;
	bh=MTusJ+VIblS7XuG1K9vvab4HGqAvOzQdo69w87y3F6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMBm6WgEF7czEinWMh8YkP9U3rHilsngeqOr+7Z+dgL+f/QTQfOG0phHltHs/FdfxXFCep8+M6Lf+onpjhFJCoqVpBswLN24ox2EXBCRBXLcK+2ftaXq5LMEDjkw6FefOGeP8Fh91a4fB0O0oacoHgJunOAc/kiLvswIPRP3G2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tAlRA-0004gT-SY; Tue, 12 Nov 2024 08:35:44 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tAlRA-000NDS-0N;
	Tue, 12 Nov 2024 08:35:44 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BF6B4371246;
	Tue, 12 Nov 2024 07:35:43 +0000 (UTC)
Date: Tue, 12 Nov 2024 08:35:43 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: can: tcan4x5x: Document the
 ti,nwkrq-voltage-sel option
Message-ID: <20241112-sincere-warm-quetzal-e854ac-mkl@pengutronix.de>
References: <20241111-tcan-wkrqv-v2-0-9763519b5252@geanix.com>
 <20241111-tcan-wkrqv-v2-2-9763519b5252@geanix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kgu6nm6qbttpidbk"
Content-Disposition: inline
In-Reply-To: <20241111-tcan-wkrqv-v2-2-9763519b5252@geanix.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--kgu6nm6qbttpidbk
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/2] dt-bindings: can: tcan4x5x: Document the
 ti,nwkrq-voltage-sel option
MIME-Version: 1.0

On 11.11.2024 09:54:50, Sean Nyekjaer wrote:
> nWKRQ supports an output voltage of either the internal reference voltage
> (3.6V) or the reference voltage of the digital interface 0 - 6V.
> Add the devicetree option ti,nwkrq-voltage-sel to be able to select
> between them.
>=20
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml | 13 ++++++++=
+++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml b=
/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
> index f1d18a5461e05296998ae9bf09bdfa1226580131..a77c560868d689e92ded08b9d=
eb43e5a2b89bf2b 100644
> --- a/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
> +++ b/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
> @@ -106,6 +106,18 @@ properties:
>        Must be half or less of "clocks" frequency.
>      maximum: 18000000
> =20
> +  ti,nwkrq-voltage-sel:
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    description:
> +      nWKRQ Pin GPO buffer voltage rail configuration.
> +      The option of this properties will tell which
> +      voltage rail is used for the nWKRQ Pin.
> +    oneOf:
> +      - description: Internal voltage rail
> +        const: 0
> +      - description: VIO voltage rail
> +        const: 1

We usually don't want to put register values into the DT. Is 0, i.e. the
internal voltage rail the default? Is using a boolean better here?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--kgu6nm6qbttpidbk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmczBUwACgkQKDiiPnot
vG/mHwf/V/AdTguFVuFRCKsEV/Otsvn2jZqArMnu6ejpMEmdSJ0obfxwglmq8l68
dfHjq+Or5XCgR6NxLoSWeG6cKFgTatO+YToo7T2heLFncFbHYH8rgzOdI7dwitLy
Tb9GJEQD+/O7pPhQCi3r1iMfjjGIfwfoHPTD0xB+qxkqJERv+LP0w/0g5aVM5BmI
pnTOUtZ64jRBkpFTCXoeS3XwT/ve1JUy/+ShV1TNhub0CKVx7ds/ZHxxsHb5YKc0
kp/QqTkDUpb4qADVwyUVhtDZSMqN7MNWvCSJ5hj529hajySeCXF2zpvQdPDPJpam
9Ywrs6wqj/j75pejy4WqDQwQLUU6Zg==
=h1Jh
-----END PGP SIGNATURE-----

--kgu6nm6qbttpidbk--

