Return-Path: <netdev+bounces-142950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC619C0C02
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14B07283C10
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 16:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B487B2161EC;
	Thu,  7 Nov 2024 16:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T110jnrQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883511DF273;
	Thu,  7 Nov 2024 16:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730998450; cv=none; b=MoiE5Mk5m3eCT+dEIkvV3G1+R6YTWyTldiz7/hrDGM4sPXCpZok8e2l2t66SGKk/Ez/KLX/RjlOkTifIUBQs5Wcf4LuUQOgkJqlJSC9hcuDRt4u/K1Fdd6sXhE0SPCK2UGyZIPODPNYtPGbJGTLGJJaiAD2ff5+28ZsBT+We9TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730998450; c=relaxed/simple;
	bh=N7/+k8R1g/1cLd26Dqj9FwKPnuSvCR/4iZYQJXHKMjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSzlMY/CrK8MXIWI2RY5fEz2ajue90zO8Xh8aVR4f05Klk0gJjoXTQTm40xYhqseuSFpP7v5jmxbCDaMghHqhS36W4QRKLLAMnu7RDkyXpapI6F/DVgLT0qHXOEfjJG6d9e2SvHJULg2GGCeYQurk0pJowttFxhXxYW7qkeWUZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T110jnrQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5FAC4CECC;
	Thu,  7 Nov 2024 16:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730998449;
	bh=N7/+k8R1g/1cLd26Dqj9FwKPnuSvCR/4iZYQJXHKMjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T110jnrQm8L454/7d1EKqbLTlIzbnivQzwxM8CIltTmKUK/WSdw+h3u0xfPxsl1vY
	 bMo+eFDhsuHaBNnckYsaZNfw0Bm9yd/yfM94zhaxuM2bkoX70U7W9BzT4vBip7kvCn
	 k6aL1K2W7oPxi6PCvjouG3yP5YOALYtqRPToeerrkF9a8gK0w7qthU8vr/LSchMjJn
	 ZRvyO82MnJITMS0HevvmP09WRGnthFc9qkcpKoyZHK+GF2Z5OpHGx2r+Gircf2OFiM
	 8b9RC5Kd0bDgqFKlktaXvfT7Ym2H8JSjkbQc15frbzdv+t5BAaJiIgyzv2UZI2nqgA
	 9136QCbwzpO3A==
Date: Thu, 7 Nov 2024 16:54:04 +0000
From: Conor Dooley <conor@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de,
	ratbert@faraday-tech.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next 1/3] dt-bindings: net: ftgmac100: support for AST2700
Message-ID: <20241107-tinwork-outlast-e01b02ba1c40@spud>
References: <20241107111500.4066517-1-jacky_chou@aspeedtech.com>
 <20241107111500.4066517-2-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PE4QUCYR82RbQ4ek"
Content-Disposition: inline
In-Reply-To: <20241107111500.4066517-2-jacky_chou@aspeedtech.com>


--PE4QUCYR82RbQ4ek
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 07, 2024 at 07:14:58PM +0800, Jacky Chou wrote:
> The AST2700 is the 7th generation SoC from Aspeed.
> Add compatible support for AST2700 in yaml.
>=20
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--PE4QUCYR82RbQ4ek
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZyzwrAAKCRB4tDGHoIJi
0jniAQDG+ZKFEkC0A4YtWW0cY8u2S8aQzuNpbWNhqNLiQc9bbgEAjr3QBoZt551w
o3uGvBsvJnPKoUPcOGbblogPIWa72wk=
=0rCc
-----END PGP SIGNATURE-----

--PE4QUCYR82RbQ4ek--

