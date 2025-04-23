Return-Path: <netdev+bounces-185204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8DBA993DF
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 18:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A811B4A76AD
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 15:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7089227FD60;
	Wed, 23 Apr 2025 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdvy5qC0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485DE1EFFB9;
	Wed, 23 Apr 2025 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422935; cv=none; b=JteiBwDDUM/hy8mp6/tnDa30XnV3u4oEDAMabXs9TV+iDOsKVIoZUnlPo1DNIJNtXa0NpTh0i2MFMQMZoMkvnmrXaEZ1vYzIFaYTnaHw0w37k4Pkej4SZlsixoFy4rS6QXyyP1oEM5HuSPx3NUZDG4YimgAuzZvOuXQ7+CcrKs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422935; c=relaxed/simple;
	bh=DxbYADm2xMQfLgDopgflxpjsuQXoBGQFPugm760iDtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyTRZvtDFClb+9U8C8VJhy8DtduqbUvTsHcY2UAz0EIaaKD18mA1350GELiXS5uoViWd+emF8IPa8BWtyA3Yb3JowPGInepIp8Gw6/HnlhbkPCLm+S915GPwnnAkzO3TDZEPNTA1hZnKUkPRyBciJHEDSlSfv1aoGRoTosPWihY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdvy5qC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F060CC4CEE2;
	Wed, 23 Apr 2025 15:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745422935;
	bh=DxbYADm2xMQfLgDopgflxpjsuQXoBGQFPugm760iDtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sdvy5qC0Ea3lYm2p0MXnrRsZKOENC2bpsU/9gwzNVNGRpD+7p2I6yp5E8zukS7o1T
	 mZxemI8xDaD9LfymGvSQis4nUfMN998t6Yx/t/7K4UDE2KdAnm1Plazuptsoy0Gs95
	 KlzQmigI9/7tdO+rdB6Ba7jwG7oBAs2z6VLPs1KzRy3sYyxCsZw7hmOVhYIx7jjD0C
	 3LsHN+7V/n7bxiVFVOxypgrh1/OVBA9XDwxEluKmIx6JMJsKHNNEBCUEvJ5xFVy11R
	 8Mx7A6RHgw2h3zSzI+3Td2Yio1oOqM2jPmee6rCR7wf5vUTM/nxQ9wR25Bvx8rtzpe
	 rmJsLrn+zmnrw==
Date: Wed, 23 Apr 2025 16:42:09 +0100
From: Conor Dooley <conor@kernel.org>
To: Justin Chen <justin.chen@broadcom.com>
Cc: devicetree@vger.kernel.org, netdev@vger.kernel.org, rafal@milecki.pl,
	linux@armlinux.org.uk, hkallweit1@gmail.com,
	bcm-kernel-feedback-list@broadcom.com, opendmb@gmail.com,
	conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, andrew+netdev@lunn.ch,
	florian.fainelli@broadcom.com
Subject: Re: [PATCH net-next v2 2/8] dt-bindings: net: brcm,unimac-mdio:
 Remove asp-v2.0
Message-ID: <20250423-sandblast-deem-40909212e9bb@spud>
References: <20250422233645.1931036-1-justin.chen@broadcom.com>
 <20250422233645.1931036-3-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ongtfeaqz9/SdaZ/"
Content-Disposition: inline
In-Reply-To: <20250422233645.1931036-3-justin.chen@broadcom.com>


--ongtfeaqz9/SdaZ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 04:36:39PM -0700, Justin Chen wrote:
> Remove asp-v2.0 which was only supported on one SoC that never
> saw the light of day.
>=20
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--ongtfeaqz9/SdaZ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaAkKUQAKCRB4tDGHoIJi
0lJnAP9Jjx7ehSg7eXWf0qWz7Ha1glgla+3vFM2+V0lBVta50gEAvjGWFm/2Vctk
FuVzPKBELCAEeR1PLUMzLDVm4T8rXgE=
=QH9V
-----END PGP SIGNATURE-----

--ongtfeaqz9/SdaZ/--

