Return-Path: <netdev+bounces-231556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA2BBFA7BB
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 09:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E3921A01190
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 07:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA862F4A04;
	Wed, 22 Oct 2025 07:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P20bzHE8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CBA2F49F4
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 07:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761117168; cv=none; b=NpbCa3DdU9AB2+oGrMqKbZRkDe+Q8GDCucsN8D1GRIuvUikIF+7px6ZLilR7xas2qWNKGBI9a8ZkZdhgGgnpVeNHPw1Cx+9hpGp3BV4CYoiJcrjbIYsXDYm3gYtN3VusCAOtApeJUx8n/Zeu65wFBUtthTRja8F3rXFjB/ZUEZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761117168; c=relaxed/simple;
	bh=aCOhMXeNcRlLEJFFTCWsYH3yznwlPc3/uJAlYhMI6lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpBN+2ylDjs0+yj/Ns9gySKGP8fvh3nYkIfabIarqUfM+NuBXwiWPzdhdFw/e0aF3suKaI0il7DtDyJEIEjO8GmMyX6kb8OQBd72ssCRMFo2gDw5Wi7u/caXY8DYzsKGtP/PbnZHGa3sO6SXz0D9FO3FLkme+nGn15J7hdLH0a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P20bzHE8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099D4C4CEE7;
	Wed, 22 Oct 2025 07:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761117168;
	bh=aCOhMXeNcRlLEJFFTCWsYH3yznwlPc3/uJAlYhMI6lo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P20bzHE882yA6YpVwda4fjhuxkc1B1YP8vfan0Thd1UpfWY5E5Ai1Fa3iBvGDLdHo
	 uHXRDqdfzWzSpBVY6fobdgGoVR57prFL3IAz/xKKrnyRdCB5oDF5znTcGusdVjqKNw
	 /A2UlLm3syA+BDqsDTX8NW1Qdg18kcHNpq4o+G4HOCBsS8W92gxbsyEaT5lch7WEnC
	 NIcdRgjZANy5OVG8M2BGmsa09g8zZi6mxBRjtBxUAsBP6+utl+22nBVSdM/EuknISt
	 1p94l6tXZ1b3w9h1/xrpN2H3V81HhknAgRoxeMIX0np4FlDu718+UfWK3C2EnAxbIG
	 Kj7KUzfAzpOng==
Date: Wed, 22 Oct 2025 09:12:45 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Remove code duplication in
 airoha_regs.h
Message-ID: <aPiD7WTSGbJq_xKO@lore-desk>
References: <20251018-airoha-regs-cosmetics-v1-1-bbf6295c45fd@kernel.org>
 <20251021182800.2c736d21@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z+kCoUsYQ/MpQx5l"
Content-Disposition: inline
In-Reply-To: <20251021182800.2c736d21@kernel.org>


--z+kCoUsYQ/MpQx5l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 21, Jakub Kicinski wrote:
> On Sat, 18 Oct 2025 11:21:47 +0200 Lorenzo Bianconi wrote:
> > This patch does not introduce any logical change, it just removes
> > duplicated code in airoha_regs.h.
> > Fix naming conventions in airoha_regs.h.
>=20
> Appears not to apply

ack, I will rebase and post v2.

Regards,
Lorenzo

> --=20
> pw-bot: cr

--z+kCoUsYQ/MpQx5l
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaPiD7QAKCRA6cBh0uS2t
rIUJAP9sOdpMJGpik1zGfDRuiTGJVOSOzifTwnhJUXdgIC5RJgD+PW8POUZxObMS
MPTuJ+Zw2b8Oy+Ww44Da7DmnCcrRDg4=
=Cu9m
-----END PGP SIGNATURE-----

--z+kCoUsYQ/MpQx5l--

