Return-Path: <netdev+bounces-229360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0CABDB126
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 21:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 885585406A7
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 19:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53744296BB5;
	Tue, 14 Oct 2025 19:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ac8abtOE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CFD13C8EA;
	Tue, 14 Oct 2025 19:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760470511; cv=none; b=Dv+zyzwGAL40sBtxRocROwTkaMO4geFXR1QI8Kpl2Slz7kLfr4WJKmdaEloTJbFG82wCcLbLtrGrkvwSQ7YmR1+H2KrtspHLn4SE67PxbKWlVkUMT900IkO4HsUORMzGdDxeQ8VNw4B86hoE1QIewckYPTDUq8DwkufDyJOEK7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760470511; c=relaxed/simple;
	bh=6WyT5RUgeTI0ramo5ow+utKpZdSxPiw51PSH2clXC/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMXsVB2N15TvWSZrVX9qfUdKmYZmv2M94x2h/eq5dI4gVpLucbsgV+L74jVuCwFjiG21DQyk5l+USkYvDUwZj30v1heVCvPc/n50CSHwXmVKy9gGFX3bw62qdWJVWkCuuWKEMMJ9lZUE+d86ZoduIXmyHxfflEc1H+QF4SOdjfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ac8abtOE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2781C4CEE7;
	Tue, 14 Oct 2025 19:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760470509;
	bh=6WyT5RUgeTI0ramo5ow+utKpZdSxPiw51PSH2clXC/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ac8abtOEeRbCjTwzhTOS5RZq9MbwUsog0kpaDNXgQ22qcC3vM9dWkm4b8KRpK9IUn
	 VlQyDgPN1o4peC4i8lp6WAsSrWwronR0PZu5hVxA9Mqg+a0e3q4kwUXZz6DNVletlv
	 y0uDXdEVexL3ykZJmx0csC38PAEK06JRsRYSkygc4mqKsDq2+dgZI6NHyP/I1ugda0
	 epmIwK12HrOCAoOLiU/Ex3a+b9P5m3XAjXLMPPwlMlPdZs2WtUzeMzsqStHcdV9Hf+
	 kS1cExMfHv6lbbvghK3Csf9NDGtTfI6jI2yZSttAYYjGKeFB/iost+KWyKlLgVq2WZ
	 kjNpgdAssXWyQ==
Date: Tue, 14 Oct 2025 20:35:04 +0100
From: Conor Dooley <conor@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: net: dsa: nxp,sja1105: Add optional
 clock
Message-ID: <20251014-unclothed-outsource-d0438fbf1b23@spud>
References: <20251010183418.2179063-1-Frank.Li@nxp.com>
 <20251014-flattop-limping-46220a9eda46@spud>
 <20251014-projector-immovably-59a2a48857cc@spud>
 <20251014120213.002308f2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1cavWFt1//eeFpZd"
Content-Disposition: inline
In-Reply-To: <20251014120213.002308f2@kernel.org>


--1cavWFt1//eeFpZd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 12:02:13PM -0700, Jakub Kicinski wrote:
> On Tue, 14 Oct 2025 19:12:23 +0100 Conor Dooley wrote:
> > On Tue, Oct 14, 2025 at 07:02:50PM +0100, Conor Dooley wrote:
> > > On Fri, Oct 10, 2025 at 02:34:17PM -0400, Frank Li wrote: =20
> > > > Add optional clock for OSC_IN and fix the below CHECK_DTBS warnings:
> > > >   arch/arm/boot/dts/nxp/imx/imx6qp-prtwd3.dtb: switch@0 (nxp,sja110=
5q): Unevaluated properties are not allowed ('clocks' was unexpected)
> > > >=20
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com> =20
> > >=20
> > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > pw-bot: not-applicable =20
> >=20
> > Hmm, I think this pw-bot command, intended for the dt patchwork has
> > probably screwed with the state in the netdev patchwork. Hopefully I can
> > fix that via
>=20
> The pw-bot commands are a netdev+bpf thing :) They won't do anything
> to dt patchwork. IOW the pw-bot is a different bot than the one that
> replies when patch is applied.

Rob's recently added it to our patchwork too.

--1cavWFt1//eeFpZd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaO6l6AAKCRB4tDGHoIJi
0gdJAQCGLivdo7jDloa60UBytTTxBpcVXA0yDHBcrNK1N0asVAEAuJ9ZWl3E3KvI
t6iFRKWBOW6bFyRDG6Ws3iE5/otsOQ4=
=qbXq
-----END PGP SIGNATURE-----

--1cavWFt1//eeFpZd--

