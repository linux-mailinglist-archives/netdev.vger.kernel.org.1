Return-Path: <netdev+bounces-231805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 763EBBFD98D
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 19:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44E351A016C7
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 17:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAF52C21E5;
	Wed, 22 Oct 2025 17:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foNz52Xi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD79280018;
	Wed, 22 Oct 2025 17:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761154387; cv=none; b=ZOzvkznv4X8H7H39nTh8csOCfyCZGAbXR8i2n8gRYdYHPNUox5iufKeidiAzSspZRxj23CRaL1pod9hY9trPqXTFhoEDdlK9RuHVKfRXs18F1F2D+rphpbBo3jKyhf5yJybprdFU1lkHS5CobsN4t7iAObTYZwSdldYPoautbDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761154387; c=relaxed/simple;
	bh=oQRSxir/QdvjZqD2ly4pH/q7y99FN0+/QgBeYN0bwZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBW4LdbuTRQqJKzmd/WINxWSWiebmiWuIbtoRlYwwk0RnXi6cT3yaevImiSZQH3BgzVK4dOMZBvm4XAAi5JktFW1V9MY9/5eKe1PxV8flDW+DqZsvR+0W9tF108FddINFOi5++GAkAcV6r9QTdjDmFYawhdTxKlXfj91qMTdJD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foNz52Xi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A93C4CEE7;
	Wed, 22 Oct 2025 17:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761154386;
	bh=oQRSxir/QdvjZqD2ly4pH/q7y99FN0+/QgBeYN0bwZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=foNz52Xiw3gDLusd1OIoklkvuJY5v8Fuj3Ph0PW57xr0dJ2SYep47tUF5Guf2EwnO
	 maIJAtQ34TehZrhN/hci0RLzLPHZwFvtUPJT1Rh9IpWlBsSv4Mh1w9yBW70pVzMalo
	 3dUfJ34YTOvyvmJkVabzTwrYkFBW+2VK9k+7EfPgGWwrKmOfGBFmyKk1GHpXmi9anP
	 j9EjTyNhlBlf0+Ou3X+Kui5UW+WKIDOn03eAhUF9teBHCAwTCCnVfmsg9bcn8QAcrV
	 cA3pIFNO1t8X6PWCm1d8fAUpYixvC/Tr1rRTvuj7j012n3JmM29gMCFOHKRhdfTuFz
	 lOeU91gkmHzEw==
Date: Wed, 22 Oct 2025 18:33:00 +0100
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Subject: Re: [PATCH net-next v2 1/5] dt-bindings: net: cdns,macb: add
 Mobileye EyeQ5 ethernet interface
Message-ID: <20251022-gladly-sulfate-de2eb50351aa@spud>
References: <20251022-macb-eyeq5-v2-0-7c140abb0581@bootlin.com>
 <20251022-macb-eyeq5-v2-1-7c140abb0581@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Jlj1uK8prG7GukV4"
Content-Disposition: inline
In-Reply-To: <20251022-macb-eyeq5-v2-1-7c140abb0581@bootlin.com>


--Jlj1uK8prG7GukV4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 09:38:10AM +0200, Th=E9o Lebrun wrote:
> Add "cdns,eyeq5-gem" as compatible for the integrated GEM block inside
> Mobileye EyeQ5 SoCs. It is different from other compatibles in two main
> ways: (1) it requires a generic PHY and (2) it is better to keep TCP
> Segmentation Offload (TSO) disabled.
>=20
> Signed-off-by: Th=E9o Lebrun <theo.lebrun@bootlin.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--Jlj1uK8prG7GukV4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPkVTAAKCRB4tDGHoIJi
0qn9AP9qOGErm2izzkTfDEmEPukpHIXAitFt5HCPpzDaAZJv0QD/WoGtPyOi/e/7
+y3mvlMhXtWtSaRWQE+lQ+2F+CKVtAs=
=rLJz
-----END PGP SIGNATURE-----

--Jlj1uK8prG7GukV4--

