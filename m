Return-Path: <netdev+bounces-114861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 468239446C0
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 10:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE00E1F24C91
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 08:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0E916E87D;
	Thu,  1 Aug 2024 08:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZnoPc0/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2762E16DEB2
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 08:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722501428; cv=none; b=CelEl5cs7o7tm0AH4Zw8jMxSkFGqcU9Yp62Ll3VGT638YkwthCBYkPeZfesGIYzb/D5Hw+7/sLT7yiuzLzzx4AY2YpZOKWgbDRh+7mMwKPd5ljFwKvUghQtBcs2U6zY4EvRRA26mmb/mMuCTN5tYquGpQQfxiLfYA/ZsjLzs6IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722501428; c=relaxed/simple;
	bh=OT2sDz0OKIm8QRG5F7LdjMu8ZgkSCxvVfRHyPEwwHcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZKamQSCVOUI/lFYo7pFvTFn2O5d3tWm3ZZoQ2nksqFCXThGUzCQxb7g7+69qVesA6WeIKct7lCfEzkbkElgHXBcLl5dOe5X+fd4HzUq1YOHuDf8MeeahhTmIO5ozOoMs/3zd93G4k1/l+kplddnRPMRVzjOoZVWJvXLnzrMWgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZnoPc0/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BACC32786;
	Thu,  1 Aug 2024 08:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722501427;
	bh=OT2sDz0OKIm8QRG5F7LdjMu8ZgkSCxvVfRHyPEwwHcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QZnoPc0/2qUzUt95Nuicy7fWJy/rhGnsvDrSxd9wCHvPOt0STkiQHhONSNp8ILp7J
	 hmkCAQWXRPe/cz97KfZpXracAaAjyrp9ySMWtOU2TElyvdn7ZwFK7Ig/Dv3RnCHuLY
	 A2/uTYpIiHu2gW4T4X4ojWPK2YeqCwboF1wfG3Jy7OIa9waXuvdeGcTKj/DFRdByzu
	 G7bh0M/RU8JsVUwtCQX7tL/4n37WkYISaTU0CNpGlfJi0fvTD5jsIhjG0QOsb/pSwf
	 Z7Kf5gFfLyoOk8vdH29xQLPvcrta8oREOkf5bzPgDJG7S2Po5dW3/poZgiVWZLLVYQ
	 y0XIsI6gnbggw==
Date: Thu, 1 Aug 2024 10:37:04 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu, rkannoth@marvell.com,
	sgoutham@marvell.com, andrew@lunn.ch, arnd@arndb.de,
	horms@kernel.org
Subject: Re: [PATCH net-next 7/9] net: airoha: Clean-up all qdma controllers
 running airoha_hw_cleanup()
Message-ID: <ZqtJMAARGkCa8zHN@lore-desk>
References: <cover.1722356015.git.lorenzo@kernel.org>
 <fc10753d211fe7782c8173f27cfb7b8586adf583.1722356015.git.lorenzo@kernel.org>
 <20240731191446.64954a6e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0hktBeiwjAo6ffqI"
Content-Disposition: inline
In-Reply-To: <20240731191446.64954a6e@kernel.org>


--0hktBeiwjAo6ffqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, 30 Jul 2024 18:22:46 +0200 Lorenzo Bianconi wrote:
> > Run airoha_hw_cleanup routine for both QDMA controllers available on
> > EN7581 SoC removing airoha_eth module or in airoha_probe error path.
> > This is a preliminary patch to support multi-QDMA controllers.
>=20
> Doesn't this have to be squashed with the previous patch?

ack, I will fix it in v2.

Regards,
Lorenzo

--0hktBeiwjAo6ffqI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZqtJMAAKCRA6cBh0uS2t
rN46AQDyeh8qsUabome4T3Nx19j40paoed4VVxTuKG4UL0IF5AEArH4bKssFcNde
pcS0m60a303qBK8Re9ggsa0MuQvFRA0=
=Xk1u
-----END PGP SIGNATURE-----

--0hktBeiwjAo6ffqI--

