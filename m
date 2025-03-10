Return-Path: <netdev+bounces-173593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B90EAA59B28
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 17:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 715A718880BB
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 16:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D33230988;
	Mon, 10 Mar 2025 16:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isA2ib1a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309C31E519;
	Mon, 10 Mar 2025 16:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624652; cv=none; b=UihhGZq+WweWWoZbX4AOO5jQRHBEKz3KgDPrIDV81FxZ4mB0LF+wRX2DBEdUKSa/4BlACufueJ2D9wUAEOjEyFgqt6pspMG3vO9OQ2mWuHafVyEsYO2tuz1OwjYHnqdJWfiFaQwlHqe7lYFJ6EVTCMzaZk0YU8CChy5VF9wvu5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624652; c=relaxed/simple;
	bh=gTUrSXfg09Nwvn6NfV7VP8ZhiyGW1oZOs57vjOlXqgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXuPHVUif72cCTwPdh6OH1UGqPDpWI0mgwPxpOzl1ipzMUjJlffoLmqG0brsc8IBofTnb26FsvCLg/LZKUh6X73SeDXRxakVAB8ntLKgJ+RYBPMkEGumde025r7wrXs8ZENUn/akmS8XGmVXnUoVzuWvIE2mUiYgK0UlFACbwsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isA2ib1a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30EABC4CEE5;
	Mon, 10 Mar 2025 16:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741624652;
	bh=gTUrSXfg09Nwvn6NfV7VP8ZhiyGW1oZOs57vjOlXqgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=isA2ib1aReU7/YMLC0A167HcEx4jP7QsuD8D2y4izHGn50rEOQFBDYZNSziKJjKDZ
	 /26GW9HwoehSWRa/6d33Fc8cngSprjxJxZrA4n6n9VOGCNjECpuQeOWVmZzxfmrtV4
	 qMFiHx1AT0EshM/qKjtN6lsVdN53CY57v2/L0Ztjzd9a1rTe/Vx0dnIrv3uMNSmh9K
	 hK5KecIm4Hmn+gZtOpdzc39eW5FKGo2b5TMc0yAV29emysm2hYQzguxuUdlnbwcRD/
	 zUEbNjzMydSPWccmYsjJZXLSxQ+eiHRvav47olH7OLoyaaJDl5ORxzODTZZZHyJuKl
	 HRNcOENPZvRWA==
Date: Mon, 10 Mar 2025 16:37:25 +0000
From: Conor Dooley <conor@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
	Emil Renner Berthing <kernel@esmil.dk>,
	Eric Dumazet <edumazet@google.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Minda Chen <minda.chen@starfivetech.com>, netdev@vger.kernel.org,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Rob Herring <robh@kernel.org>,
	Samin Guo <samin.guo@starfivetech.com>
Subject: Re: [PATCH net-next 4/7] riscv: dts: starfive: remove
 "snps,en-tx-lpi-clockgating" property
Message-ID: <20250310-climatic-monorail-f06784705219@spud>
References: <Z82tWYZulV12Pjir@shell.armlinux.org.uk>
 <E1trIAF-005ntc-S5@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CZyrpZ2HiVDm2QKt"
Content-Disposition: inline
In-Reply-To: <E1trIAF-005ntc-S5@rmk-PC.armlinux.org.uk>


--CZyrpZ2HiVDm2QKt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 09, 2025 at 03:02:03PM +0000, Russell King (Oracle) wrote:
> Whether the MII transmit clock can be stopped is primarily a property
> of the PHY (there is a capability bit that should be checked first.)
> Whether the MAC is capable of stopping the transmit clock is a separate
> issue, but this is already handled by the core DesignWare MAC code.
>=20
> As commit "net: stmmac: starfive: use PHY capability for TX clock stop"
> adds the flag to use the PHY capability, remove the DT property that is
> now unecessary.
>=20
> Cc: Samin Guo <samin.guo@starfivetech.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Acked-by: Conor Dooley <conor.dooley@microchip.com>


--CZyrpZ2HiVDm2QKt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ88VRAAKCRB4tDGHoIJi
0igTAQCFZVYFhHAngmyoswJyr+9kBc4WZx2CvPHD4XUtMbBjEQEA6wyvNZXw1B0U
/+2ky25MqZJCRKv33flXhTeDh7fNYw4=
=M1xu
-----END PGP SIGNATURE-----

--CZyrpZ2HiVDm2QKt--

