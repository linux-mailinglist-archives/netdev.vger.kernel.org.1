Return-Path: <netdev+bounces-145033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0689C92B2
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 20:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CDF6B2827F
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 19:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6054F1A7275;
	Thu, 14 Nov 2024 19:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRnWQu2n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE33148827;
	Thu, 14 Nov 2024 19:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731614264; cv=none; b=rDo0GcP7vrLsosfp82UNs/I2VXKdHlbWGlXZ3MvBoZRwGViZPszgkfo7OLdQmnNmYqUoGVejEQWKJizNN5iuXf7+D81GuE1Lt5q6R6vb4j/HXUnuxesHIhzd8G39bT3cBx2+1keUTx8j8ZPAX5NbxmOdyGKX5a13sDe/A1KwM9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731614264; c=relaxed/simple;
	bh=OAa0i6PQbFBX9nxXU16/72WHOOIFXow2PFAUR2Ydja8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMUm2rfQwflxrzTLyxtM0m7Vqv70j8yCIAhLX4ooLTQldUn7VzqNf0YRB6uSKIqvLY21koWJpwCjfTSZCOQPjMmHTRrKiYluUlx/OlkencJPpPQR4R41tchaxT5RQ3xWN3Ow9hdIsMOgW11UqdI0bF4Pqmpgdsvh3A6E/QtceVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRnWQu2n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9DA0C4CECF;
	Thu, 14 Nov 2024 19:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731614263;
	bh=OAa0i6PQbFBX9nxXU16/72WHOOIFXow2PFAUR2Ydja8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QRnWQu2nSakrfClWLAGqmJTp2XpscJTT3KC2itHiGwdIi3b7+xP6Evfc8Q1awxpIH
	 zIgAWloo/6XcjAGF9tRoWY+X+3+OzC45ym3W9Pp033fbvcYsWH83GfFfrPZyU972Uw
	 8U4oB06EPPct2FdCr8EyrYXt/8UGUXRgO0UTiMdiBqea5FmTQTvVpgIZL8iTK9vdFS
	 KOX+6ixUrr2FHJ88RFox1HZT5Wv8XsBQxwK6HxDB5jXnSDavWiSnIc1B0lolgbFAfN
	 c/N2jRfSWVF/xrPmdoTm4TojR7IHYfB+RPzGixt4a7XgT+cT2ZWyuiBiWrdoZTRLpM
	 JwKD3v6Wf277w==
Date: Thu, 14 Nov 2024 19:57:39 +0000
From: Conor Dooley <conor@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: sff,sfp: Fix "interrupts"
 property typo
Message-ID: <20241114-spelling-stimulate-27d132bab456@spud>
References: <20241113225825.1785588-2-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uXl+LIBonLLh1Pue"
Content-Disposition: inline
In-Reply-To: <20241113225825.1785588-2-robh@kernel.org>


--uXl+LIBonLLh1Pue
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 04:58:25PM -0600, Rob Herring (Arm) wrote:
> The example has "interrupt" property which is not a defined property. It
> should be "interrupts" instead. "interrupts" also should not contain a
> phandle.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--uXl+LIBonLLh1Pue
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZzZWMwAKCRB4tDGHoIJi
0j8yAQDpms3Ys4sS8WOalvUjCBd6pbiPJKOwadvRufiu+Dw8jgD7BgtLGCEM4YB9
t9VnA7kmSKDP5Jet/6DAFA8i8iqBYgI=
=rAh9
-----END PGP SIGNATURE-----

--uXl+LIBonLLh1Pue--

