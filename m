Return-Path: <netdev+bounces-211226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5E0B173E9
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 17:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 060A2586CF7
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 15:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3D81B87F2;
	Thu, 31 Jul 2025 15:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tA3sXF8W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A34415A8
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 15:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753975463; cv=none; b=n0rmPvsKUCtIiRvcZVgoQ/1KjnG7WqGOzrO3xZTGMCTxluX4A519FhWjek8nHsPCjtVm6DxMaRNrsv7iTyba9VRQbKmt6jxao2+HZcnyzrGi4EQM505GPBE+5aeU1yLgG1Wo+seuaruKtIwAiacbC4uyEpmNHxcEu81q/Dn8hzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753975463; c=relaxed/simple;
	bh=hV+4QbSz5Udx3GshLiQvcY/nKgtH8erkV2rR614Vsok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTowlOlbJ7r1cJ7J4HoP4QUS4jpIjpFyjSBlXXOnFKLbNRmZ+sLGEROu9hNONqZxVCd/hXYzKYzjZE6hy/k5/ABA/uOBieLjSm6oqzWEJt9LJ7pCXYyRd+gbF1IETsJchq7T86kaWEtLvqr50dV6AtHbP1pejVZFEsmq6DxmmBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tA3sXF8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D56C4CEEF;
	Thu, 31 Jul 2025 15:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753975462;
	bh=hV+4QbSz5Udx3GshLiQvcY/nKgtH8erkV2rR614Vsok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tA3sXF8Wm+rCh5mCtzlnzkpSBzdJoXk9uSm04XD8G9+Xe5wPjXpJ4iw2zM1jkor20
	 i4KXvmcOZ7WWlRvwPhSiIs1SPOheHn/6xyQ0fQslkUJVFNXoz5IadUOSTgEog7jKmW
	 FIVJ3hqnsenhiJ43t/lk9fwP48XUqtV6oWICB6s6HuhzLTH4eO52tw/S4Cj3Ut1dUm
	 +vUgpTgdQhY7eGIQY1ov5B8CfJQB3Otitgqz49+4RmJPzCkfEew0aePtsGJmuGLirm
	 XvAjFnWzTY1jfUzZWhlOCZViCSnFXCHtaqIaj1/w2L8nO3se8Uj7f7y7OM5xm1ydpQ
	 PtHBAHEbsi6qA==
Date: Thu, 31 Jul 2025 17:24:20 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: airoha: npu: Add missing MODULE_FIRMWARE macros
Message-ID: <aIuKpP-wKp1FA8jM@lore-desk>
References: <20250731-airoha-npu-missing-module-firmware-v1-1-450c6cc50ce6@kernel.org>
 <1ef51e54-9ad1-4e98-aaba-63d493e22959@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E2aXBMfY4AdSuySP"
Content-Disposition: inline
In-Reply-To: <1ef51e54-9ad1-4e98-aaba-63d493e22959@lunn.ch>


--E2aXBMfY4AdSuySP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, Jul 31, 2025 at 12:25:21PM +0200, Lorenzo Bianconi wrote:
> > Introduce missing MODULE_FIRMWARE definitions for firmware autoload.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> If this is for net it needs a Fixes: tag.

ack, right. I will add it in v2.

Regards,
Lorenzo

>=20
>     Andrew
>=20
> ---
> pw-bot: cr

--E2aXBMfY4AdSuySP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaIuKpAAKCRA6cBh0uS2t
rLfQAQDKaUprICj1f1jY9i/BonCKzcGgE8L5TpLpaeKx2bdKGwD8CYzZ+VBSB8Rc
eh1L1nTp4U8W+SKz05d/eRhmsNs3BA4=
=1Iaq
-----END PGP SIGNATURE-----

--E2aXBMfY4AdSuySP--

