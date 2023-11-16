Return-Path: <netdev+bounces-48455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA3F7EE638
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 18:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12AB7B20C89
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 17:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558E346546;
	Thu, 16 Nov 2023 17:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFyoDzEM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E5A46540;
	Thu, 16 Nov 2023 17:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CB0C433C8;
	Thu, 16 Nov 2023 17:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700157353;
	bh=JTOSSzmkti/CwkIFzl38dTbWRkcFa2xCEPwQSmwX8aA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EFyoDzEMgrhUh2OxSpogBRBdx/kxk2p6NXUbDjjjl4EwgWbPltzgZixN/p8bEtMi7
	 hKGIPprRoW/tOD8Qi79NE84j5zepPPPfDTZ4nGeBlQ/kfEvXdSTu504rIhA0hRfivw
	 otOlkcUPnhOfuI3QGcCn7TyQWtn2zoL4S1oS43gRY3NxT1gobz1QaTr1DCgXPKxuT6
	 iETnqxuNlPQ+vxs2F2//BHVqDgh9I14q059z8Lx1OZVi2DuLkrZvhkcXnD8TvBMG8/
	 ZbCvJ1T99RoNUpsb7o/vOmb0CiVd4cgH494by8++yRUaYyitC8OskXl2dJ+ztFQ4Gj
	 NSvbNuQH7f1SQ==
Date: Thu, 16 Nov 2023 17:55:48 +0000
From: Conor Dooley <conor@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Samin Guo <samin.guo@starfivetech.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
	geert@linux-m68k.org
Subject: Re: [PATCH v2 12/12] [UNTESTED] riscv: dts: starfive:
 beaglev-starlight: Enable gmac
Message-ID: <20231116-stellar-anguished-7cf06eb5634a@squawk>
References: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
 <20231029042712.520010-13-cristian.ciocaltea@collabora.com>
 <f253b50a-a0ac-40c6-b13d-013de7bac407@lunn.ch>
 <233a45e1-15ac-40da-badf-dee2d3d60777@collabora.com>
 <cb6597be-2185-45ad-aa47-c6804ff68c85@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uAMF7mMjCIyQbaxj"
Content-Disposition: inline
In-Reply-To: <cb6597be-2185-45ad-aa47-c6804ff68c85@collabora.com>


--uAMF7mMjCIyQbaxj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 03:15:46PM +0200, Cristian Ciocaltea wrote:
> On 10/30/23 00:53, Cristian Ciocaltea wrote:
> > On 10/29/23 20:46, Andrew Lunn wrote:
> >> On Sun, Oct 29, 2023 at 06:27:12AM +0200, Cristian Ciocaltea wrote:
> >>> The BeagleV Starlight SBC uses a Microchip KSZ9031RNXCA PHY supporting
> >>> RGMII-ID.
> >>>
> >>> TODO: Verify if manual adjustment of the RX internal delay is needed.=
 If
> >>> yes, add the mdio & phy sub-nodes.
> >>
> >> Please could you try to get this tested. It might shed some light on
> >> what is going on here, since it is a different PHY.
> >=20
> > Actually, this is the main reason I added the patch. I don't have access
> > to this board, so it would be great if we could get some help with test=
ing.
>=20
> @Emil, @Conor: Any idea who might help us with a quick test on the
> BeagleV Starlight board?

I don't have one & I am not sure if Emil does. Geert (CCed) should have
one though. Is there a specific test you need to have done?

--uAMF7mMjCIyQbaxj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVZXoQAKCRB4tDGHoIJi
0tu2AP9drj6GsHST1GuwVshDCPfcDCHRO+vR+I1UqBAWPOMUXwEAqSxcPaC1TyWe
GMY51dqgFxkhTDyvFRD6foJdL4VC4w8=
=kvIZ
-----END PGP SIGNATURE-----

--uAMF7mMjCIyQbaxj--

