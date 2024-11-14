Return-Path: <netdev+bounces-145035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF329C92BC
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 20:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCA6E1F234AB
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 19:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B041A9B3A;
	Thu, 14 Nov 2024 19:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltF//MgA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF4F1A76A4;
	Thu, 14 Nov 2024 19:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731614295; cv=none; b=pqF4covmoZfYqzc+fQdFOsPEja7wHv+AdLhIWpXsgmJTvwWOPrXWglo1wnGbk9jm3wmG1UquKFjwkiG1PgL0XVBUsxbNmBZ6hSuvsVcGb8lsDP7al1byUnN9zCjFHCGFdD82OfOeH1ZdCQMIq9c1Gs5tHCg7926wgLCaMPjLtC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731614295; c=relaxed/simple;
	bh=is2DwCeH2GJDrvyAlLjEnle+DgRiVuK3mp/CDkiqLzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j14FKS699iJvvg3PCYqiz8H6OcmGfLxPTqOF/wsG81WHkYteSH5s843akXwiSr1bbPYZhCGrzZ32uegHgSqYEiiR7XXWAiC53FW6bp2MHPrYLC3c++MbPymBW2rZnP36CRuodULyIbzL9QotblOs314H/MG+YhDa+gI7pOJFHf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltF//MgA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC41FC4CECD;
	Thu, 14 Nov 2024 19:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731614295;
	bh=is2DwCeH2GJDrvyAlLjEnle+DgRiVuK3mp/CDkiqLzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ltF//MgAZvOzyQoWrdQkRb/IV5JSJNwVfV4MntptTSf3raAGDY7lSQvl+uGAiQosD
	 73Y9cACcz8Xm3nb9BfSv7WC6Gi82kx29mdx6bqrmiHZQyXOWvOKV2CUW2Xga3nnSdv
	 dkfxwnJHofbVikZn5ISFsGnlQSq2dEZSG2P+L6Trqdzm13dQfAyk+iDUOfO9QxMNyD
	 Ziuba0obj5nGWcbQpGzq3vtJ34csD0F7GQYhzOu2Yf7xxGbze94oXzV87alTbayFzm
	 JE4Yedmpan5jWR9CfsPJD712JPGIO4RsVCI3LdHfup3za3V1hpErqM0VahsgH5oTw5
	 wnxZES/0odZNw==
Date: Thu, 14 Nov 2024 19:58:10 +0000
From: Conor Dooley <conor@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: mdio-mux-gpio: Drop
 undocumented "marvell,reg-init"
Message-ID: <20241114-clean-faceplate-77b6524744bf@spud>
References: <20241113225713.1784118-2-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zCLkFKKLPBz4F6G5"
Content-Disposition: inline
In-Reply-To: <20241113225713.1784118-2-robh@kernel.org>


--zCLkFKKLPBz4F6G5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 04:57:13PM -0600, Rob Herring (Arm) wrote:
> "marvell,reg-init" is not yet documented by schema. It's irrelevant to
> the example, so just drop it.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--zCLkFKKLPBz4F6G5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZzZWUgAKCRB4tDGHoIJi
0gW9AP4kjK4ECleVUA6JApz6IZAKsdFnLWuwqOziLCoEN+5zjgEApHI+BZYiUSAF
XPTvVQBVdacdaCDwBIIeAyNZEcsgawI=
=ZPNf
-----END PGP SIGNATURE-----

--zCLkFKKLPBz4F6G5--

