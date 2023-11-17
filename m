Return-Path: <netdev+bounces-48766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F34F97EF741
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 18:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABA8F280F60
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 17:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A288F36B1E;
	Fri, 17 Nov 2023 17:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STU2KUYp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832374315C
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 17:49:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259DAC433C8;
	Fri, 17 Nov 2023 17:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700243371;
	bh=t3RO+MQ9z2LUNsTVC1dHHAaM1f/KVns6ngZmVPaHF1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=STU2KUYp5jr/X06ogCS6ZPJtO5jcca8O2vPZ5PsqtmMwgX2jqevkoWWvoVpgRsj+I
	 SGN9EBASuBae5QEC0nWT6YEfAN2mBSRsHogwC0CwOYRPee99MQdsR5eVeE5KevN80c
	 +0vBu8Y7uahxgj0U9RecmVleym3gJZr85twUrAth1Zgr4DsV1EhsOocNSlaU8+56O8
	 7veBLh8s1G/ezdb+Omw7h2BRjSJ9nabp82rSLfFjQtD4jruy8J3KVi5121VCtN9WHz
	 MJhfc+Q28JJAtVx9Q1t75Y/S+FRQYgDlaoyeZwJVWIfiISPk6mPwex8TOQCsaK0eN7
	 LMl76ipr9xw9w==
Date: Fri, 17 Nov 2023 12:49:29 -0500
From: Wolfram Sang <wsa@kernel.org>
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [net-next 1/5] net: ethernet: renesas: rcar_gen4_ptp: Remove
 incorrect comment
Message-ID: <ZVenqeTESTUSOyJq@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
References: <20231117164332.354443-1-niklas.soderlund+renesas@ragnatech.se>
 <20231117164332.354443-2-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4haptCi5eTjC83Le"
Content-Disposition: inline
In-Reply-To: <20231117164332.354443-2-niklas.soderlund+renesas@ragnatech.se>


--4haptCi5eTjC83Le
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 05:43:28PM +0100, Niklas S=C3=B6derlund wrote:
> The comments intent was to indicates which function uses the enum. While
> upstreaming rcar_gen4_ptp the function was renamed but this comment was
> left with the old function name.
>=20
> Instead of correcting the comment remove it, it adds little value.
>=20
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--4haptCi5eTjC83Le
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmVXp6kACgkQFA3kzBSg
KbZISQ//ePUZVmIbDWM38cFGxmHCwcX/DK0ujyjsIW4qiyBQTTbHXB4l0yA9ZUGt
msshuzWUSytgHn4K84/DYeaT8kTSkapM1884EcNiZQLHYZJy4OSHpeeiUQt/ld6v
vq9Vckdh/tU7BtjoZQRpcObmItxWQF/eqBL8miJ0XK3f6o5URcuPmRwpGPRJW2oA
e1LeD7ExITSNQIzy4AbEbaGUq0IL4vz0cS+B79829LNRGpidc1xUCR3VMzl8psfI
XHCVipg13mxuoWai6FY3JmIB+yGplE5Smlmw8WEWgaLn5yc0BDCCq88tjOdoGQA/
FEgY2Qw+zBqYAN/mwpaFRX68CFMHVMUNNgMO9ZiEfQ+z8oQNwm3tTvpBevhtC2UB
8wbhpD/WllV06+W8+AbodofB6AxP/mDFVZh9HJ4Ki5K5xHeDtd0DqfIXKN0k72k+
ieCjSoh7MKRbf5pm3YfvJtLTC448+VvvVK+LdW8FQBBWmrBI+3pIGJtqv1xt7S3x
HjBXK8yiUrELQ/6mcOxMugIs/WIVMK5Vh5sZvNuVdg7jbNLHOe2eZpglvNQqdRWk
b6MkOqXPQLWronmYKi+8PQqVp4FfsrQYRUTsesKcX1oKgfF05qj//tb1uz6XVZJw
LaOqXNcTLvp3DdxQFqWuI1FgpJnxVe/zQSnwlfBCCm1fhd05VYw=
=mQel
-----END PGP SIGNATURE-----

--4haptCi5eTjC83Le--

