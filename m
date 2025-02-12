Return-Path: <netdev+bounces-165473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B80D0A32316
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 11:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F228165CB5
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 10:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401301FC102;
	Wed, 12 Feb 2025 10:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqHoJrai"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8DD1F12EC
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 10:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739354607; cv=none; b=lEQ1zvMqEEOISCiAdgNze5IVFAeZ/yQUwrz95fqAz25e+DbcWZcujgJrdf0h40SoHHRaquHx8Jye8q+x8n4RXXAGEXNwFmfSkqDdcBy6mb1FOOo+iOPItdVR3Tj1racW1eCF7OWFCfzlPwhsqfTW/OUCoKREr8QA5sVpbRoCAs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739354607; c=relaxed/simple;
	bh=5nIGClIepa3vn8Kx0AIIOulxeLtJZx+xFkAW9HB1GUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTYXqrIHouGiHzkYUHQa8D2gjz9XxYgT34+WAz7/mYsRMgj+B/0M8GGxm9FoaMhJ9mYuKu+AjBLsx6qSHqfzuGgDsx0QoXfUknxp2ZqY3mHvswhe3mKfwWS7IHAnUaO0jfehMEAX/bwcrXOMlc+qQDBsRzES+DKjANobbOCkoyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqHoJrai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF3EC4CEDF;
	Wed, 12 Feb 2025 10:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739354606;
	bh=5nIGClIepa3vn8Kx0AIIOulxeLtJZx+xFkAW9HB1GUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rqHoJraiptilXADmxS1SNDibvf5crLWII9M2ufZI3e4Z2XrwTmbv6qisVhe45f93S
	 lrwsDxa6P8OJPIhUXN7nRDvl+598EkGzmOq3/dyQeweypW1YNDh9aodQTV0LkXc/Em
	 wFUmaV3ig8z5Ge6TIdC2UtGOdPtyDV0xTqdGFBOD7vWzzm257JI6/yXi3ccrmWkecp
	 fx1b3McW81oKzUOUdv8gn2/e+hDKR3ZG5oVd7g10HBhkZKJfZK/tdbYfP6iHd6ytCr
	 njiagqgMKdmwhh/Rqi9Lu9Gr4m7WMuoHEOUbz4bIkwY2fX5jZYTqMjkx9PFBFoforC
	 NQT/mujTJuMMw==
Date: Wed, 12 Feb 2025 11:03:24 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] Enable TSO for DSA ports on Airoha EN7581
 SoC
Message-ID: <Z6xx7AwglUEt_9J0@lore-desk>
References: <20250212-airoha-fix-tso-v1-0-1652558a79b4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="K9tnhGwKobYJn02N"
Content-Disposition: inline
In-Reply-To: <20250212-airoha-fix-tso-v1-0-1652558a79b4@kernel.org>


--K9tnhGwKobYJn02N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Add missing vlan_features configuration to enable TSO/Scatter Gather for
> airoha_eth lan ports.
> Fix checksum configuration for TSO packets with cloned headers.
>=20
> ---
> Lorenzo Bianconi (2):
>       net: airoha: Fix TSO support for header cloned skbs
>       net: airoha: Enable TSO/Scatter Gather for LAN port
>=20
>  drivers/net/ethernet/mediatek/airoha_eth.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> ---
> base-commit: 4e41231249f4083a095085ff86e317e29313c2c3
> change-id: 20250211-airoha-fix-tso-44a6f9cb14c0

Hi,

I figured out I am missing a patch in this series, please drop it, I will
repost. Sorry for the noise.

Regards,
Lorenzo

>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo@kernel.org>
>=20

--K9tnhGwKobYJn02N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ6xx6wAKCRA6cBh0uS2t
rJm3AQDXbXlIcf436GJupafNCG7ANsY51fU/rVvITbR48Yhd4wEA766hQ2x5T3rJ
s/ksDQ/sB+rrQKgeQJ9wUZu2gGC2FQM=
=bCuL
-----END PGP SIGNATURE-----

--K9tnhGwKobYJn02N--

