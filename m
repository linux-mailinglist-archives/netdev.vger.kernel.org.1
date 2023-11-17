Return-Path: <netdev+bounces-48767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C74D7EF745
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 18:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCB99280F49
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 17:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B391A704;
	Fri, 17 Nov 2023 17:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJ6lawmV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4554314E
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 17:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D14C433C8;
	Fri, 17 Nov 2023 17:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700243552;
	bh=q47uRSF51QGBCQgdwow/CsS84crTBnmjByt3KU3Fb1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HJ6lawmVBN+9L0mvvaWpFCl3RsrX83j+p/244P6O3TmgsJgadKoXdzFYWv6uWuoU9
	 wXTs1Y+NrdsyR6sYEGj/AisN+3NdlE2CzWo+9bMhINqeJklk0z1vg9Moap0ub7s5OA
	 tAeXInF8B9T2JvqNMjJ05SH6lsVbOa5O/3G20n3uMfCS2n4bKRtIuJbt1+dxCJ9/bn
	 B83HTRSZndGuImZsJk4Pue10gobMMFzp3Ej34RZZS+opJOzwPb09L6Qq84T5mbiqGP
	 hnngjAadPz/GGKgFjYbqkXBOI83RdfC5KToUFhLOVBvIb33QfeGZxZrTbAGiQj89FY
	 fuFH5kWPmvkaA==
Date: Fri, 17 Nov 2023 12:52:30 -0500
From: Wolfram Sang <wsa@kernel.org>
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [net-next 2/5] net: ethernet: renesas: rcar_gen4_ptp: Fail on
 unknown register layout
Message-ID: <ZVeoXiAC3/m2NVQR@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
References: <20231117164332.354443-1-niklas.soderlund+renesas@ragnatech.se>
 <20231117164332.354443-3-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6sG5jACAcQ1LRzVL"
Content-Disposition: inline
In-Reply-To: <20231117164332.354443-3-niklas.soderlund+renesas@ragnatech.se>


--6sG5jACAcQ1LRzVL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 05:43:29PM +0100, Niklas S=C3=B6derlund wrote:
> Instead of printing a warning and proceeding with an unknown register
> layout return an error. The only call site is already prepared to
> propagate the error.
>=20
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--6sG5jACAcQ1LRzVL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmVXqF4ACgkQFA3kzBSg
Kbbt8BAAsTpmqTq2y+c1pexZv2yUNr78sk1jGalfMtpKOP4sszRW4AY6Ii4w/bYX
CwNA0BQKiwBqUzUBDHphgj+PK+NuQs1Y2KcKghvG3/OrEFxvQCn6LjHVNdBzRp8M
B4bWZtd3NfL9ZBxwmPTAH++QUT1bpBdvyiXFHwq1DTW76SJtx1wBPIFeq5joCK3b
Ba50dY7Xl25aMU3Z6+vubQwjkS1p+655eCA9ds6imK+zBUHGDUHNr5zJ25l/rjqD
HTRdl06DF0KOlNzx5B4EIJGj8qxTwnaG2FOXivgo2HdaN/gor6iLDD+ytqRhE0Au
4xtZX92zQhW3zV2akq2GBGv7XIyX29oAn3qiTLjVl/9Xh0KAExoM6o8aoL1bSlRO
LLctfpEoVk8ELWyJnZ4COlFEDC16WcULHPKBEijDx3u6LYc1ZOMZ4fIWmC4lCPTJ
fPnVyeWfC9fXg+70VVRaypVtfhQGLE7b+UjF8VyciPutVhQ+LgQTkPRPXXbEG1DY
N5pgWJZZE7ZqubrzfFzuvu4xTWWftOqZeTuwWWI2T1p2aJzBW5V9xPCdGchdfdO1
jSlPjanDxKPnNPJcQd5r6QwihRoKMenIhumHhRLuNJH19F7SxCNdrxIcgUaaGbA9
LU/8oAIKPwh3+0pBHkH6ArOyO+7TPCyS7e9+O6BJ4ElqEWPBlUE=
=27q8
-----END PGP SIGNATURE-----

--6sG5jACAcQ1LRzVL--

