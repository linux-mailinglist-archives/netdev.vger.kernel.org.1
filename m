Return-Path: <netdev+bounces-25273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A55773A3C
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 14:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F5922817A5
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 12:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEA1101EA;
	Tue,  8 Aug 2023 12:45:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AC1EED1
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 12:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD27C433C8;
	Tue,  8 Aug 2023 12:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691498746;
	bh=57M2u8UPlvZ/iPMyVrQbhx5eMYWe8moJxNKmzCQ1eNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oa5tC5GT2rs94ZvbfUCcaMK/wP/SRTNslJRU+Q+jHjLEe0Uhcr9DpycEMvzrVcFgO
	 X+ahxr4gZhgtz9vVLbsu9OC7p6cn08HejFPflzeEvE+j7w1mRi7uPP2glGAvnh1GsO
	 vcylR3kURIs7kbPaNCAUPBTGBnu8TvbeEbB3YyKYUkRtfEOp9/PGnGfTst+9VvcOKW
	 loHqQ3WTJ72C9m6SavLKblGX6DfaaVGirW+vwTQANrYk0L2epEXyPKZh5zflDICEM1
	 wYtoAOHB530FnVkLQotoGJfq2SJ0uspevGZXs1emdJWEXEXMrAO9rfya9O7Is2SvDJ
	 BylkEVtNnqEEw==
Date: Tue, 8 Aug 2023 13:45:40 +0100
From: Conor Dooley <conor@kernel.org>
To: Md Danish Anwar <a0501179@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Simon Horman <simon.horman@corigine.com>,
	Vignesh Raghavendra <vigneshr@ti.com>, Andrew Lunn <andrew@lunn.ch>,
	Richard Cochran <richardcochran@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>, nm@ti.com, srk@ti.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/5] Introduce IEP driver and packet timestamping
 support
Message-ID: <20230808-nutmeg-mashing-543b41e56aa1@spud>
References: <20230807110048.2611456-1-danishanwar@ti.com>
 <20230808-unnerving-press-7b61f9c521dc@spud>
 <1c8e5369-648e-98cb-cb14-08d700a38283@ti.com>
 <529218f6-2871-79a2-42bb-8f7886ae12c3@kernel.org>
 <8bb5a1eb-3912-c418-88fe-b3d8870e7157@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Qy+4LCvJDb1UKTzX"
Content-Disposition: inline
In-Reply-To: <8bb5a1eb-3912-c418-88fe-b3d8870e7157@ti.com>


--Qy+4LCvJDb1UKTzX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2023 at 06:06:11PM +0530, Md Danish Anwar wrote:
> On 08/08/23 5:52 pm, Roger Quadros wrote:
> >=20
> >=20
> > On 08/08/2023 15:18, Md Danish Anwar wrote:
> >> On 08/08/23 5:38 pm, Conor Dooley wrote:
> >>> On Mon, Aug 07, 2023 at 04:30:43PM +0530, MD Danish Anwar wrote:
> >>>> This series introduces Industrial Ethernet Peripheral (IEP) driver to
> >>>> support timestamping of ethernet packets and thus support PTP and PPS
> >>>> for PRU ICSSG ethernet ports.
> >>>>
> >>>> This series also adds 10M full duplex support for ICSSG ethernet dri=
ver.
> >>>>
> >>>> There are two IEP instances. IEP0 is used for packet timestamping wh=
ile IEP1
> >>>> is used for 10M full duplex support.
> >>>>
> >>>> This is v2 of the series [v1]. It addresses comments made on [v1].
> >>>> This series is based on linux-next(#next-20230807).=20
> >>>>
> >>>> Changes from v1 to v2:
> >>>> *) Addressed Simon's comment to fix reverse xmas tree declaration. S=
ome APIs
> >>>>    in patch 3 and 4 were not following reverse xmas tree variable de=
claration.
> >>>>    Fixed it in this version.
> >>>> *) Addressed Conor's comments and removed unsupported SoCs from comp=
atible
> >>>>    comment in patch 1.=20
> >>>
> >>> I'm sorry I missed responding there before you sent v2, it was a bank
> >>> holiday yesterday. I'm curious why you removed them, rather than just
> >>> added them with a fallback to the ti,am654-icss-iep compatible, given
> >>> your comment that "the same compatible currently works for all these
> >>> 3 SoCs".
> >>
> >> I removed them as currently the driver is being upstreamed only for AM=
654x,
> >> once I start up-streaming the ICSSG driver for AM64 and any other SoC.=
 I will
> >> add them here. If at that time we are still using same compatible, the=
n I will
> >> modify the comment otherwise add new compatible.
> >>
> >> As of now, I don't see the need of adding other SoCs in iep binding as=
 IEP
> >> driver up-streaming is only planned for AM654x as of now.
> >=20
> > But, is there any difference in IEP hardware/driver for the other SoCs?
> > AFAIK the same IP is used on all SoCs.
> >=20
> > If there is no hardware/code change then we don't need to introduce a n=
ew compatible.
> > The comment for all SoCs can already be there right from the start.
> >=20
>=20
> There is no code change. The same compatible is used for other SoCs. Even=
 if
> the code is same I was thinking to keep the compatible as below now
>=20
> - ti,am654-icss-iep   # for K3 AM65x SoCs
>=20
> and once other SoCs are introduced, I will just modify the comment,
>=20
> - ti,am654-icss-iep   # for K3 AM65x, AM64x SoCs
>=20
> But we can also keep the all SoCs in comment right from start as well. I =
am
> fine with both.

> Conor / Roger, Please let me know which approach should I go with in next=
 revision?

IMO, "ti,am564-icss-iep" goes in the driver and the other SoCs get
specific compatibles in the binding with "ti,am564-icss-iep" as a
fallback.

--Qy+4LCvJDb1UKTzX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNI48wAKCRB4tDGHoIJi
0vd2AQCD1PBK5RG7PeNLxT8QjAC0nZ3ESYCKNWXzG8O/6AIM+QEA8NaT/8p8YQuh
H0bgixdfcJbyHFc0KwqR5+q6nbo3pw8=
=LIWP
-----END PGP SIGNATURE-----

--Qy+4LCvJDb1UKTzX--

