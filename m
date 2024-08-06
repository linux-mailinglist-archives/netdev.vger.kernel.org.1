Return-Path: <netdev+bounces-116242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AFA9498AE
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 21:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5739D2835AD
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 19:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A080154BF8;
	Tue,  6 Aug 2024 19:56:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BAC149C74
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 19:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722974173; cv=none; b=VPXgYfn4IVabB9cEsQ8ve5uxd5oJhWhFsk3LL/Juw+lsRqRcZx3LhFplnKmE9MINjmMNU9YyMZDPxD3Q1gA0UYQJ25zSKwe0JQ/r9Uw2Gzd/pHI1vx5xlF08l6j9VRuOLKtoxXn2bSz9mGlrm9toAeO4+lFe8BmwSl5Q7gDM9SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722974173; c=relaxed/simple;
	bh=u7BQVSOIInr31bt4SnPSp5X+E1sR/G4Z2tTnB19SYLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnOu2Lr8nf0md6p8ZfOVRfVjVveQGdekYI8CoUimaL9jnhprIpzmCIsGe94BxAjKU8CWrQY6Nc64WhYZlKvWuj4mc8IjPFExnj79Ar9ZDx/l5trOzdCpn/eLqjy6zh5v09KPcwHGtdIkmfo1kZJH4YzAo/bYP0JCvTdA3Wlmz5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbQHW-0005kO-0G; Tue, 06 Aug 2024 21:55:42 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbQHT-0051lZ-Gn; Tue, 06 Aug 2024 21:55:39 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1826D318370;
	Tue, 06 Aug 2024 19:55:39 +0000 (UTC)
Date: Tue, 6 Aug 2024 21:55:38 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Rob Herring <robh@kernel.org>
Cc: kernel@pengutronix.de, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Elaine Zhang <zhangqing@rock-chips.com>, David Jander <david.jander@protonic.nl>, 
	Simon Horman <horms@kernel.org>, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH can-next v2 01/20] dt-bindings: can: rockchip_canfd: add
 rockchip CAN-FD controller
Message-ID: <20240806-hypersonic-malkoha-of-grandeur-1f5d81-mkl@pengutronix.de>
References: <20240731-rockchip-canfd-v2-0-d9604c5b4be8@pengutronix.de>
 <20240731-rockchip-canfd-v2-1-d9604c5b4be8@pengutronix.de>
 <20240806165020.GA1664499-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oqlbtdiwnzp33yvb"
Content-Disposition: inline
In-Reply-To: <20240806165020.GA1664499-robh@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--oqlbtdiwnzp33yvb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 06.08.2024 10:50:20, Rob Herring wrote:
> On Wed, Jul 31, 2024 at 11:37:03AM +0200, Marc Kleine-Budde wrote:
> > Add documentation for the rockchip rk3568 CAN-FD controller.
> >=20
> > Co-developed-by: Elaine Zhang <zhangqing@rock-chips.com>
> > Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > ---
> >  .../bindings/net/can/rockchip,canfd.yaml           | 76 ++++++++++++++=
++++++++
>=20
> rockchip,rk3568-canfd.yaml

Thanks, will rename.

> >  MAINTAINERS                                        |  7 ++
> >  2 files changed, 83 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/can/rockchip,canfd.y=
aml b/Documentation/devicetree/bindings/net/can/rockchip,canfd.yaml
> > new file mode 100644
> > index 000000000000..444269f630f4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/can/rockchip,canfd.yaml
> > @@ -0,0 +1,76 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/can/rockchip,canfd.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title:
> > +  Rockchip CAN-FD controller
> > +
> > +maintainers:
> > +  - Marc Kleine-Budde <mkl@pengutronix.de>
> > +
> > +allOf:
> > +  - $ref: can-controller.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - const: rockchip,rk3568-canfd
> > +      - items:
> > +          - enum:
> > +              - rockchip,rk3568v2-canfd
> > +              - rockchip,rk3568v3-canfd
> > +          - const: rockchip,rk3568-canfd
>=20
> Given you already know there are differences in the versions to handle=20
> and there's no existing driver supporting the fallback, I don't know=20
> that a fallback is too useful here.

Let me re-think out loud about the compatibilities:

There is a CAN-FD IP core in the rockchip,rk3568 SoC.
=20
In the silicon revision v2 of the SoC it has 12 documented errata und
silicon revision v3 some of them are fixed. This means the driver can
skip some of the workarounds.

The v3 revision works with all the errata of the v2 active, currently
with a probably not measurable increase of CPU load. This might change
in the future, if more v2 workarounds are added. These might
degrade performance.

So it's for the v2 silicon revision:
compatible =3D "rockchip,rk3568v2-canfd";

And for the v3 silicon revision:
compatible =3D "rockchip,rk3568v3-canfd", "rockchip,rk3568v2-canfd";

Which is documented in the yaml as:

properties:
  compatible:
    oneOf:
      - const: rockchip,rk3568v2-canfd
      - items:
          - const: rockchip,rk3568v3-canfd
          - const: rockchip,rk3568v2-canfd

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--oqlbtdiwnzp33yvb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmayf7cACgkQKDiiPnot
vG8IPQf+LbC/VIPZu4gM2+A5GdbMSbKA+z4aGn1tNxv7siHocgF9WZUOcVXbJrLO
fvDub7fQyHJcmJKmoeN3EqUH9Neh3w1W1yDelU19iuQ8EUC2TBWI52uINZ2U5AlW
us1lapjelVoNnJjG24mjn4+VILOX2DlMKa4zFVdJ+eJmcKKz7MfZiNT60GE7Xgol
jkVM989K7H20HS7+tvRAAAgtmTm/zQOcfZiB4owx3xIYByZVJyB7Pn+2IfIfF++Y
jVUuTXbJxmkrhi4iY+JBZMdoz4ymLLvolJ3+3SnzVBos6cK1gztcdRozWnSNq0O0
nmOkPEm+nNO+KzlGWm0IQhtcj4VaHw==
=K7S6
-----END PGP SIGNATURE-----

--oqlbtdiwnzp33yvb--

