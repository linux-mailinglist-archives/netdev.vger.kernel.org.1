Return-Path: <netdev+bounces-30735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03659788C17
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 17:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1B422817F0
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 15:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3140F101DE;
	Fri, 25 Aug 2023 15:05:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5166C2F9
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 15:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BA7C433C8;
	Fri, 25 Aug 2023 15:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692975919;
	bh=eHpdomHqz2leXbmraR960nt9YH0gz7JmtwmpSircQLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z8aKF+T3AUgnpDQ2xSCjBmHAewY/IRdr/0ugFhgTgx8XNW7iCbkJsh6QnMSU80Hes
	 hU621LFeBaESpgxd+AOHTNk+ctd0SIcyvqQDBVElSCS33SWP9imOa/y8n+gM2Npcut
	 H9t2VAOpnbDyboarm5dwSoPcsK3ApnOa6RBCi9FLqeaJaSnLjjPRdcrGgpZgZ3EebL
	 GELHS2XQgThDWNxqhTSMS3bmv99xi6PRaZpe7Poxu1LIOBDXpro5RF/b2FEN/Ib3/V
	 F0lID51u17YsKAfEiSkHZerKlrn4RZgek0OL1rAVyfUxTfvwkRajxAkTdkG3wSWh9c
	 3lpKplKSJxd3g==
Date: Fri, 25 Aug 2023 16:05:13 +0100
From: Conor Dooley <conor@kernel.org>
To: Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, airat.gl@gmail.com
Subject: Re: [PATCH net] dt-bindings: net: dsa: marvell: fix wrong model in
 compatibility list
Message-ID: <20230825-outdated-supply-90d9c2d92d63@spud>
References: <20230825082027.18773-1-alexis.lothore@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/Vq4s2c2AbFormVj"
Content-Disposition: inline
In-Reply-To: <20230825082027.18773-1-alexis.lothore@bootlin.com>


--/Vq4s2c2AbFormVj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2023 at 10:20:27AM +0200, Alexis Lothor=E9 wrote:
> From: Alexis Lothor=E9 <alexis.lothore@bootlin.com>
>=20
> Fix wrong switch name in compatibility list. 88E6163 switch does not exist
> and is in fact 88E6361
>=20
> Fixes: 9229a9483d80 ("dt-bindings: net: dsa: marvell: add MV88E6361 switc=
h to compatibility list")
> Signed-off-by: Alexis Lothor=E9 <alexis.lothore@bootlin.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--/Vq4s2c2AbFormVj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOjDKQAKCRB4tDGHoIJi
0gIqAP0Q5WIzR/1kPHTO3wHb+0pQ98OlKLPip/G372M2Y8RQ7gD/S6K8ItQlYSvo
wnlgU/1kqwSHxsGL07Vj+LuMIaItMQw=
=0QUe
-----END PGP SIGNATURE-----

--/Vq4s2c2AbFormVj--

