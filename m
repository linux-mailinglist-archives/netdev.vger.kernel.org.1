Return-Path: <netdev+bounces-48841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5AB7EFAD7
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 22:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CD1BB2152C
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 21:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A3C48780;
	Fri, 17 Nov 2023 21:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3eItnnH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498AC47765
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 21:21:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4DAC433C9;
	Fri, 17 Nov 2023 21:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700256102;
	bh=R1SydD41aTF9AzGFrOUtAlS1/Bcr1NLr5O1fgAKhXvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F3eItnnHNgeJZodZWS8WZkxcs20jv8535KJ6Dq+xBVsj7HfggMKSIAPX8rqc0RmDQ
	 0dj5/e8xqZEN936yWKj8WR+3yBiveRAhjqaefNfFLyaMGy8ixHp2DGYtrLZE3pYoqG
	 DQTTcZvRXQD0htyNWE/8461UxdEYED1aVyg9L9HXYn9clEQDb2ojJALKhY17d9vaVs
	 u58WlmrMiqdoOGG60uPyAeyEZ1Co3PnLzN9qMBib1QCGWNG++Np0Uf5LqgiMJZpwhH
	 ciEvUrmCwRl5cd3S1ZepE/WAhe2z4MfEKRiPxH4fMWGKL1YaJC9R2FfQC200DxxJjk
	 RnMn2Vor3m5rw==
Date: Fri, 17 Nov 2023 16:21:37 -0500
From: Wolfram Sang <wsa@kernel.org>
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [net-next 4/5] net: ethernet: renesas: rcar_gen4_ptp: Add V4H
 clock setting
Message-ID: <ZVfZYUd3Ov24nlXJ@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
References: <20231117164332.354443-1-niklas.soderlund+renesas@ragnatech.se>
 <20231117164332.354443-5-niklas.soderlund+renesas@ragnatech.se>
 <ZVeqSsfBEMsQ+8mP@shikoro>
 <ZVe2PJVQVZgKSFuE@oden.dyn.berto.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ssBge7LyC9GSR782"
Content-Disposition: inline
In-Reply-To: <ZVe2PJVQVZgKSFuE@oden.dyn.berto.se>


--ssBge7LyC9GSR782
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I could not make up my mind, I think ether is fine. I opted to put it in=
=20
> this series to group all gPTP changes in one series. If you think it's=20
> better moved to the upcoming TSN series I can move it there.

No, I also think either is fine.


--ssBge7LyC9GSR782
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmVX2V4ACgkQFA3kzBSg
Kba1sQ/+OmGENg404mz7lxBdaB+dy/yqn5WXyBEJu41FKiWx8PhRnr0ebHW0LaXW
AlQ/7tRd2ZQIEnNolkv7wO+xc7XUFtio9oAuKnq3ECHJvgk7UlqFB+h2q/4eZvNG
ON2WkibWDnzUAUqlbIvHukwLbDqxQiZl1F9krHgWK9Q5KMKdHGCDs3SYTidQZzXD
BKiy3l5sUkY4LbGW5wKREHSbto1XemHcPgFat7FT4K7ugSBT6BusZ9pS14WuLSfF
Civ8HuUHI9sCELG0mcysdy4JnILUQLHEfYuJNf6eoKCPpNuwX7f25LYfP79o/SX7
R7DdBAw3337ZnZrLEalCMPS1tmJJBbYppuwTVB3pFVH6Q9r5C2BoONd83RMV+hLz
+TNm1fZu7/DvAutHtYuqDsH1mGbgUO5tE/w+7M4CDt8O3ELJr9sKj9jWoYGjhQCC
XCoPWRj3wa9b+tIkECqORNR3j1z9g6EvGIVzLFVLgNXwBtF1QajsV7og3VMLIdNX
fWjkgTC9mGgoID/4BunTc8ONv8WK+P2o49A5DLA1qUeMyCw6GMBfShdzSUjLD/x5
7YuQXLUNbfRPc7es67JXRN72SbYbEAaPxu1WNpps6xDrywwpbY5stNpus6ClMIfQ
Gt/nULtO5wmcXer2lnIxfH6lMhtUFVJfCESwtYUYI+1+UV92ceY=
=twPK
-----END PGP SIGNATURE-----

--ssBge7LyC9GSR782--

