Return-Path: <netdev+bounces-129281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEE797EA42
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 12:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 634861F21D64
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 10:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C39198857;
	Mon, 23 Sep 2024 10:57:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4F0198823
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 10:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727089061; cv=none; b=ZZU9cnZv5l6rJ5Y8M8cXLseAUTm4PloyGLwrTPvYWwrvGMbJ54to6vsWSmA0fnK9f4g5329cWubb4aaDXN417oVTm2j9SkRn6e+Hz5WXEzhDRU6eZKpK8hRRWtY9E/tJVBL5gV9a4xKKkaOxaFFGIPVIi2fbeHayKd9OB4+v8mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727089061; c=relaxed/simple;
	bh=0SkozGkj68AZ5hrm4yyVeLoWtR4WfW3Fi7zQndEz+U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gt/v2zCVvREAj3FZk/gsxVp/ex2fFo6BGt9VMXDqX1vnqIzOPTfriSUmxCdiBC23eTL5oPoWvKFyk+nHYpm81MU1ggz+UaEQ67xOjQYP73l5EdLzPszUtzO0o/qMez61WCXBmS+pvkfjwIK41hKRg59tP1bFKOXdOR0VlqlVx9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ssgkn-0006MJ-Sf; Mon, 23 Sep 2024 12:57:17 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1ssgkl-000wIO-Hh; Mon, 23 Sep 2024 12:57:15 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 43146341116;
	Mon, 23 Sep 2024 10:57:12 +0000 (UTC)
Date: Mon, 23 Sep 2024 12:57:07 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Charan.Pedumuru@microchip.com
Cc: mailhol.vincent@wanadoo.fr, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: net: can: atmel: Convert to json schema
Message-ID: <20240923-burrowing-poised-taipan-22a14d-mkl@pengutronix.de>
References: <20240912-can-v1-1-c5651b1809bb@microchip.com>
 <20240912-literate-caped-mandrill-4c0c9d-mkl@pengutronix.de>
 <d9987295-74eb-4795-8517-379249cd7626@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pctubu4jhjdunxfu"
Content-Disposition: inline
In-Reply-To: <d9987295-74eb-4795-8517-379249cd7626@microchip.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--pctubu4jhjdunxfu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20.09.2024 04:51:57, Charan.Pedumuru@microchip.com wrote:
> >> +allOf:
> >> +  - $ref: can-controller.yaml#
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          contains:
> >> +            enum:
> >> +              - microchip,sam9x60-can
> >> +    then:
> >> +      required:
> >> +        - compatible
> >> +        - reg
> >> +        - interrupts
> >> +        - clocks
> >> +        - clock-names
> > AFAICS clock-names is required for all compatibles.
> In our case only sam9x60 is using clock-names property.

No, the driver uses "clk_get(&pdev->dev, "can_clk")", so this property
is mandatory.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--pctubu4jhjdunxfu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbxSX8ACgkQKDiiPnot
vG9+KQf+MKdlOE0m4njNDZ+9Dh5XHsKriEiywBRcKIa9qehl5SENRCEYdBwFLHzL
ifzlF0ypyFhyk/XH6PGQg8/HJ8MCksgKnKdfhUs/Mz75r2iboTsRVwfIlF23U0Ke
/VNEeerkrWTUvBO3vpEiHXWsWwvjqJXE/pD/7DV83wn+78YnQts0lbpAWckj1qZT
5jarfnoRuAuujYoLW2g845Z94y/shUTu3bB6KYNwKJ/ymWeRaEhedzgqe6yiBd4e
SVIx/S6Bl0d+zhwOt6e5svh3bNxdkvxYjk60x9JQr4Sr4eIqKwIHBRWyazxG5Bmn
2Uzm4ClQB4vt/ekEmk4GVIMb0d73ww==
=kWhh
-----END PGP SIGNATURE-----

--pctubu4jhjdunxfu--

