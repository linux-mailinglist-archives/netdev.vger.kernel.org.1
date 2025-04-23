Return-Path: <netdev+bounces-185200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4B0A992DA
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 17:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FF007AA113
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 15:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5929A29B229;
	Wed, 23 Apr 2025 15:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uD/qEYJx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3108B29AAF1;
	Wed, 23 Apr 2025 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422494; cv=none; b=uUTc3ktKcUF7WfUZJ/1V1QIN4qJJR1O4oVVbxp2C76AJb1gCobzkl3TJYRAN0fuSj6rntt2mlc/RbLR8/jmP73uA/V8T/mjYoDhQXqbDNUy9ciIxSVqSdfp1PvH496nhfI41RAwMB97NGpIaRi9yOReBFoj1M6i+9WOlvwbw+Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422494; c=relaxed/simple;
	bh=p/nh3OW4M+82zbNV28nOlVLNUKAQWBOI2NC59sQvgzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4B3YvFQE5TofP1/1S7Mx7bDxjX99A0iYVVqORM6t62A6Vvg4shU8Wc+p1RM99KKvyEEHHJRGp5eLc7J3cliKZCrJst+F3lea0krNV6dPdsf4m8OBzPh5w6dEoGt+fmywZCn003521F43AbVnay+ApJTq49OmzfCZR95xLWTMOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uD/qEYJx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89C9C4CEE2;
	Wed, 23 Apr 2025 15:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745422493;
	bh=p/nh3OW4M+82zbNV28nOlVLNUKAQWBOI2NC59sQvgzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uD/qEYJxcJIIhciJ5jhtNU70eFBcW9LhOFCIVuy1HeJxfE2LeS/5l8x3/sOwDYIEH
	 FDOzoDVPJIuED+wvFBvzVNWFS5B/RVzbND67k6thEY7lMSOmNBQPxxhWa+AjfK6vI9
	 5Ruf8RuzMxvMCjj4IXsf8nrK4sx3JcRoSxwGtwY8nrp93VuvvZvmaE18lWVk0x++1C
	 WwLUrcmrvKK+qPUtWQUdA9KEP/osRlF/WK7L7+I5Fqse/weCRhXLRPRSs9yGjSV96L
	 pCUOtG8A+bNZZ/64fIJmulpwuoi+5g5MX9HMM4ejEPkeMuovlc9pHwPvi2E9mLcinX
	 re0hJFHV04z7A==
Date: Wed, 23 Apr 2025 16:34:47 +0100
From: Conor Dooley <conor@kernel.org>
To: Justin Chen <justin.chen@broadcom.com>
Cc: devicetree@vger.kernel.org, netdev@vger.kernel.org, rafal@milecki.pl,
	linux@armlinux.org.uk, hkallweit1@gmail.com,
	bcm-kernel-feedback-list@broadcom.com, opendmb@gmail.com,
	conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, andrew+netdev@lunn.ch,
	florian.fainelli@broadcom.com
Subject: Re: [PATCH net-next v2 1/8] dt-bindings: net: brcm,asp-v2.0: Remove
 asp-v2.0
Message-ID: <20250423-hardly-answering-87ec478ef51d@spud>
References: <20250422233645.1931036-1-justin.chen@broadcom.com>
 <20250422233645.1931036-2-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5Yh4ycaxJJXdv8FW"
Content-Disposition: inline
In-Reply-To: <20250422233645.1931036-2-justin.chen@broadcom.com>


--5Yh4ycaxJJXdv8FW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 04:36:38PM -0700, Justin Chen wrote:
> Remove asp-v2.0 which was only supported on one SoC that never
> saw the light of day.
>=20
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--5Yh4ycaxJJXdv8FW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaAkIlwAKCRB4tDGHoIJi
0hA1AP90p1vX9aj5sXfGtpEOiHnEj97spwAeSnFvApbg2bKLdQD+MJhVSI5nqBCM
mxX7nXNjPHrKSrFuuRFvqjdVxHBsaQo=
=SspX
-----END PGP SIGNATURE-----

--5Yh4ycaxJJXdv8FW--

