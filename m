Return-Path: <netdev+bounces-141475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970FD9BB125
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 11:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B4E12841BB
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 10:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8141B21A9;
	Mon,  4 Nov 2024 10:31:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661681B2199
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 10:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730716286; cv=none; b=I+Yy2TNKOkvtolsFp8K4zgaVAzupOaSi1pZ5whPHEGpaojeJH+a04TE2UeZgpyACDjhpoPd1QR4rMsCLO4cJ5RnSimLEck+xye4n6XO9U7bTteLQkragfdNi6So6RzBTmKRFyLCkqlLdglGRlYp2bZ4Qgs8tu7jsDh0AY2D6MIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730716286; c=relaxed/simple;
	bh=eAs6U/Aoz/rGj94QOQ/UC48WAhVymTQAGlUCh//91io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+4MRDyFNACykjr68eLuQ+NpCQZpZ2plokvbaCLNi6QC+dvW6z2HlWsM0LzUoGRkEFQcWeprwTLX0CsGmQIbrP9eF+FwMam7xYHHdljPPPlutjAu5Mma3JDbalc/n+U0v0JYytgLKS688qHSw+ge3U7gYf7km4QMCipAGd0kHO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t7uMS-0004VW-1j; Mon, 04 Nov 2024 11:31:04 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1t7uMQ-001xkX-2s;
	Mon, 04 Nov 2024 11:31:02 +0100
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 80A293678E4;
	Mon, 04 Nov 2024 10:31:02 +0000 (UTC)
Date: Mon, 4 Nov 2024 11:31:02 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sean Nyekjaer <sean@geanix.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] dt-bindings: can: convert tcan4x5x.txt to DT schema
Message-ID: <20241104-upbeat-wondrous-crane-6f20a3-mkl@pengutronix.de>
References: <20241104085616.469862-1-sean@geanix.com>
 <ee47c6d7-4197-4f5d-b39e-aab70a9337d6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q6hhbmkqjpisipvc"
Content-Disposition: inline
In-Reply-To: <ee47c6d7-4197-4f5d-b39e-aab70a9337d6@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--q6hhbmkqjpisipvc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH] dt-bindings: can: convert tcan4x5x.txt to DT schema
MIME-Version: 1.0

On 04.11.2024 10:27:04, Krzysztof Kozlowski wrote:
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - enum:
> > +          - ti,tcan4552
> > +          - ti,tcan4553
> > +          - ti,tcan4x5x
>=20
> That's not really what old binding said.
>=20
> It said for example:
> "ti,tcan4552", "ti,tcan4x5x"
>=20
> Which is not allowed above. You need list. Considering there are no
> in-tree users of ti,tcan4x5x alone, I would allow only lists followed by
> ti,tcan4x5x. IOW: disallow ti,tcan4x5x alone.

I'd like to keep the old binding.

> Mention this change to the binding in the commit message.

The tcan4x5x chip family has 2 registers for automatic detection of the
chip variant. While the ID2 register of the tcan4550 is 0x0, the
registers for the tcan4552 and tcan4553 contain 4552 and 4553
respectively in ASCII.

The driver was originally added for the tcan4550 chip, but currently
only has a compatible for "ti,tcan4x5x".

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--q6hhbmkqjpisipvc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcoomIACgkQKDiiPnot
vG8YrQf+JyvOYVVRW9nzhFGD9KVtlS8zKgG295wWe20oC5McULoWS3U8prFRcq1y
Kv4fIwo5MzkWeX7ZMQjDtAPg25+C/GbnDIg7O5sZjt3iZng+D3TyXLRf0Qufj/rF
HdJR4of7x7eYnh1Ft+Q9jlg7dY8i/r54v5msiMhQnj3z3U6zvMjoq4g8LVQMYU13
P6HosfwXnjA4920KPdaGxgbxEaKPz5nCKZYlJck2AlElzcFILd2S8zjUTacEVIUK
H5gaXpBXtu2A4/zPWg0f9AVhij4RAkjk63Cdc99rNiH91ZT+e8qhdmbDWm27bie/
yqOH3AwjkRWeVQXZxaSRs4mNeVkN9A==
=Lfas
-----END PGP SIGNATURE-----

--q6hhbmkqjpisipvc--

