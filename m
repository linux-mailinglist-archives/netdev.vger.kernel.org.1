Return-Path: <netdev+bounces-28354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4400C77F283
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 10:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 724B3281E17
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 08:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A544FC0E;
	Thu, 17 Aug 2023 08:56:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3855D2C9C
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 08:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6AA5C433C8;
	Thu, 17 Aug 2023 08:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692262564;
	bh=9bDuY4CAwq3emi0LWvjJSZGJSZqOemRjjqVz1VixD10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aDuAsDMmGzdgrTKeCwZIXfYjfwCOla4Adogr507rJhu5hwxy70453WMRqb6kDbGin
	 084kqXUPx3hLfcm5089YuN4yUmNJ31dtreSK52kJjyBZjDaqqWVF6tKLgzPNxISWkS
	 y5zuLjcSLauHN/E5KFBIUKmgdf46CYveBpYIjAbFI/Rfmgoqs2UxUZFt28tlLrq1CA
	 sQfZ7jAbrOx7U9tJOHagYKL/wiragV5BTz0ar5G8KyozStfp3RL2c6TKJwSDmWgtJV
	 P5lyPa5CWOE3K9e1A64kMjVomLtVZFMAQEDTmmXjA/B0ApeCWINd4tBW0B/n77mtTq
	 v/MCkWrIKXcAA==
Date: Thu, 17 Aug 2023 09:55:59 +0100
From: Conor Dooley <conor@kernel.org>
To: "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc: "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
	"simon.horman@corigine.com" <simon.horman@corigine.com>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"Verdun, Jean-Marie" <verdun@hpe.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] dt-bindings: net: Add HPE GXP UMAC
Message-ID: <20230817-animate-aerosol-5c857b4ff9a9@spud>
References: <20230802201824.3683-1-nick.hawkins@hpe.com>
 <20230802201824.3683-4-nick.hawkins@hpe.com>
 <20230803-balance-octopus-3d36f784f776@spud>
 <AF599C90-1257-4C13-AF60-8680A812421A@hpe.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gJ6NujNNSkAlOeiD"
Content-Disposition: inline
In-Reply-To: <AF599C90-1257-4C13-AF60-8680A812421A@hpe.com>


--gJ6NujNNSkAlOeiD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2023 at 04:26:09PM +0000, Hawkins, Nick wrote:
> Hi Conor,
>=20
> Thanks for your feedback. I will provide an explanation below.
>=20
> > > +description:
> > > + HPE GXP 802.3 10/100/1000T Ethernet Unifed MAC controller.
> > > + Device node of the controller has following properties.
> > > +
> > > +properties:
> > > + compatible:
> > > + const: hpe,gxp-umac
> > > +
>=20
>=20
> > > + use-ncsi:
> > > + type: boolean
> > > + description:
> > > + Indicates if the device should use NCSI (Network Controlled
> > > + Sideband Interface).
>=20
>=20
> > How is one supposed to know if the device should use NCSI? If the
> > property is present does that mean that the mac hardware supports
> > it? Or is it determined by what board this mac is on?
> > Or is this software configuration?
>=20
> Hi Conor,
>=20
> There are two MAC's available in the ASIC but only one can support
> NCSI. Even though it supports NCSI does not mean the board has
> been physically wired to support it. In terms of the device tree I would
> expect the "use-ncsi" to be present in the dts board specific file.
>=20
> There will be hardware configurations where both MAC0 and MAC1
> will be using the SERDES connections. In that case there will be no
> NCSI available.
>=20
> Is a better description needed here to explain this?

Ah crap, I missed this yesterday - I think this came in as I was doing
my queue sweep. The improved description seems good to me, thanks for
adding to it.

--gJ6NujNNSkAlOeiD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZN3gnwAKCRB4tDGHoIJi
0rKVAQDPJoKAqlpV7Q1t6ED5S659aQuuZhr/DdhyowGt8aRpVwEA3LWLW16B+M6I
vz/Rwt5DU2t/EondExnJr/SQgyAHHgY=
=KkRV
-----END PGP SIGNATURE-----

--gJ6NujNNSkAlOeiD--

