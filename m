Return-Path: <netdev+bounces-114968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A481944D14
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C87EBB2262E
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0051A08CE;
	Thu,  1 Aug 2024 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2XVA2/l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451771A0724
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722518576; cv=none; b=RAMsdUhmiJ3iVCdpXPJBJeTsTTCMhU+xo5IoRLHyNxZKMay/8eiL13pVEzDRRBrNowAwGnGZoUU6RW+1CVo+3MIDEscfnmkW0lw8Xsh5j4WsrRFQa4SO9YiMncqSNQH+X/y6aZR4D9mW2c3H+1YEmOsD7tPO+hcd6QXPboZbLgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722518576; c=relaxed/simple;
	bh=xlV7Gz8L7Wl+LupZc2FuTx9dv8STmb2Jx+Q8VSNdOSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8GOkhz1v9tjSoYDDLb3s/+82wNxuZF81F4SNof7jIIh+qjCNHUM6pfYM9INgmBoD26UttCpayoikugMm3WKJDdkPVsy5k4qKoTv11BHUMgof0p6Im3ExtucF9ndEe3trhoPJe5y9kvkIxRLe6tPvKnCRalPLaVRdMc/yL2PblY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2XVA2/l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2DAC32786;
	Thu,  1 Aug 2024 13:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722518575;
	bh=xlV7Gz8L7Wl+LupZc2FuTx9dv8STmb2Jx+Q8VSNdOSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G2XVA2/lTPlK5p2O1Uk3CygwZi4CPMbQaq0jshrjtpK1CHBDOZvoo7eWS0qJ7khAp
	 gXJdn8vq3TvfARG5qNZF69j8W72nrrWn3vGDUVQng9d080qMHYuDyLaxFtfucM91Hh
	 7LLuMKYlJIoO0bYpBPn3mM4urVafWAY7eTio2qpDNbTsNE7sXjUkgXREhHQ+MDYZdC
	 /Chj/jGAZ7E+s8i2s3yhiYvdDokvaOyG+9w7i7V2d60q7fL6TFMi/HFmFVH2cj3oLB
	 9GyQAN3npDt3Ym3yANc2d/ajI6sFLXsczJBWGRFOj3w1RwTKJiaawf/cc9m6zLHCHz
	 smxCzX5qKFb1A==
Date: Thu, 1 Aug 2024 15:22:52 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu, rkannoth@marvell.com,
	sgoutham@marvell.com, andrew@lunn.ch, arnd@arndb.de,
	horms@kernel.org
Subject: Re: [PATCH net-next 2/9] net: airoha: Move airoha_queues in
 airoha_qdma
Message-ID: <ZquMLCfLA1AV1Dpz@lore-desk>
References: <cover.1722356015.git.lorenzo@kernel.org>
 <4b566f4f6feeb73f195863c01b7c9ae1ad01474a.1722356015.git.lorenzo@kernel.org>
 <20240731191543.2cc0c985@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DmRxnjGw068Z48ef"
Content-Disposition: inline
In-Reply-To: <20240731191543.2cc0c985@kernel.org>


--DmRxnjGw068Z48ef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, 30 Jul 2024 18:22:41 +0200 Lorenzo Bianconi wrote:
> > QDMA controllers available in EN7581 SoC have independent tx/rx hw queu=
es
> > so move them in airoha_queues structure.
>=20
> You seem to be touching a lot of the same lines you touched in the
> previous patch here :(
> Maybe you can add some of the
>=20
> +	struct airoha_qdma *qdma =3D &q->eth->qdma[0];
>=20
> lines, and propagate qdma pointers in the previous patch already?

ack, I will fix it in v2.

Regrads,
Lorenzo

--DmRxnjGw068Z48ef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZquMLAAKCRA6cBh0uS2t
rN0rAQCf1L4l5IdtKqIexzypE4lkii8ITkculANOD5jvUk4pOwD/ddooYvk8AhQE
VYnSebpUkfrYsZZSrXos4Yjx007emAY=
=udzB
-----END PGP SIGNATURE-----

--DmRxnjGw068Z48ef--

