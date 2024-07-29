Return-Path: <netdev+bounces-113772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD5A93FE13
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 21:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 058131F21980
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 19:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F8715A87C;
	Mon, 29 Jul 2024 19:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/evAa/d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF2B8F6E;
	Mon, 29 Jul 2024 19:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722280222; cv=none; b=oa7G/Mh8mtMWE/95Pp1i8i09cixkJyDB2VaoBoawmTlyi5l0nTBSQ3i2AoFAu+QX0UbcBmZutPzdQYFQE12uEccG2LfiaKzz73Rtc0M6LM8eDnX6/g6AuVeZZGAE495ep05DnE/PUWlmae1j3eNiU2fNW+ntVfD8fLxCkfjTv7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722280222; c=relaxed/simple;
	bh=GeKFbCeom+VCaHgl8+PZ2JYGr43jkE4VDnS0ZOHl118=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mV68HgUUYiccYjUhuFwohoTm7VRfuxfs+VfaNK7Pmd3CLM6fBtlQNJM6mNLebGE4tH61qcnYIagG5CJ79bqJIMFpm1QSLvNZkY6q0VTzqFYVjtJPl5V0kKM2PDV2MKzn8Vuv6n31jQC9NFjv68Y/bcK1k6CxiXjpUKqEHsq6JO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/evAa/d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C00C32786;
	Mon, 29 Jul 2024 19:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722280221;
	bh=GeKFbCeom+VCaHgl8+PZ2JYGr43jkE4VDnS0ZOHl118=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V/evAa/d22sRjeBoHWUAG0XI3zAn5CgjCDbxrFakPLvhyGkH1ZiB8hNs7aqvTXMYZ
	 5TUL6JW0aAKfa/B50hKl1p46kcghGQ2640KQImdQwmrGS4aHuFGrXF4egujzxnsdpN
	 LzKd6PjDPDzIBHj+j7JOnB5ajN3S1W801Gtaizt3WwMJ26zaaH5ItyKZZV42PUBL6v
	 FPj0Ad0YJVjfyr21oU3yEIf1MAkTrerMsKGoUzxq+g3+Jz0FEzADw4hYhlCsoVH0k9
	 rloWD0aWdv3l+WkuVM3cDuUdsE3rnW9qhDZcvJpKFlCDa44lTH+mYhszjS+/Fkt0bo
	 HgvskIRBbwgiA==
Date: Mon, 29 Jul 2024 21:10:17 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Elad Yifee <eladwf@gmail.com>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Joe Damato <jdamato@fastly.com>
Subject: Re: [PATCH net-next v2 0/2] net: ethernet: mtk_eth_soc: improve RX
 performance
Message-ID: <ZqfpGVhBe3zt0x-K@lore-desk>
References: <20240729183038.1959-1-eladwf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eeEMdISa/6n5flqb"
Content-Disposition: inline
In-Reply-To: <20240729183038.1959-1-eladwf@gmail.com>


--eeEMdISa/6n5flqb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> This small series includes two short and simple patches to improve RX per=
formance
> on this driver.

Hi Elad,

What is the chip revision you are running?
If you are using a device that does not support HW-LRO (e.g. MT7986 or
MT7988), I guess we can try to use page_pool_dev_alloc_frag() APIs and
request a 2048B buffer. Doing so, we can use use a single page for two
rx buffers improving recycling with page_pool. What do you think?

Regards,
Lorenzo

>=20
> iperf3 result without these patches:
> 	[ ID] Interval           Transfer     Bandwidth
> 	[  4]   0.00-1.00   sec   563 MBytes  4.72 Gbits/sec
> 	[  4]   1.00-2.00   sec   563 MBytes  4.73 Gbits/sec
> 	[  4]   2.00-3.00   sec   552 MBytes  4.63 Gbits/sec
> 	[  4]   3.00-4.00   sec   561 MBytes  4.70 Gbits/sec
> 	[  4]   4.00-5.00   sec   562 MBytes  4.71 Gbits/sec
> 	[  4]   5.00-6.00   sec   565 MBytes  4.74 Gbits/sec
> 	[  4]   6.00-7.00   sec   563 MBytes  4.72 Gbits/sec
> 	[  4]   7.00-8.00   sec   565 MBytes  4.74 Gbits/sec
> 	[  4]   8.00-9.00   sec   562 MBytes  4.71 Gbits/sec
> 	[  4]   9.00-10.00  sec   558 MBytes  4.68 Gbits/sec
> 	- - - - - - - - - - - - - - - - - - - - - - - - -
> 	[ ID] Interval           Transfer     Bandwidth
> 	[  4]   0.00-10.00  sec  5.48 GBytes  4.71 Gbits/sec                  se=
nder
> 	[  4]   0.00-10.00  sec  5.48 GBytes  4.71 Gbits/sec                  re=
ceiver
>=20
> iperf3 result with "use prefetch methods" patch:
> 	[ ID] Interval           Transfer     Bandwidth
> 	[  4]   0.00-1.00   sec   598 MBytes  5.02 Gbits/sec
> 	[  4]   1.00-2.00   sec   588 MBytes  4.94 Gbits/sec
> 	[  4]   2.00-3.00   sec   592 MBytes  4.97 Gbits/sec
> 	[  4]   3.00-4.00   sec   594 MBytes  4.98 Gbits/sec
> 	[  4]   4.00-5.00   sec   590 MBytes  4.95 Gbits/sec
> 	[  4]   5.00-6.00   sec   594 MBytes  4.98 Gbits/sec
> 	[  4]   6.00-7.00   sec   594 MBytes  4.98 Gbits/sec
> 	[  4]   7.00-8.00   sec   593 MBytes  4.98 Gbits/sec
> 	[  4]   8.00-9.00   sec   593 MBytes  4.98 Gbits/sec
> 	[  4]   9.00-10.00  sec   594 MBytes  4.98 Gbits/sec
> 	- - - - - - - - - - - - - - - - - - - - - - - - -
> 	[ ID] Interval           Transfer     Bandwidth
> 	[  4]   0.00-10.00  sec  5.79 GBytes  4.98 Gbits/sec                  se=
nder
> 	[  4]   0.00-10.00  sec  5.79 GBytes  4.98 Gbits/sec                  re=
ceiver
>=20
> iperf3 result with "use PP exclusively for XDP programs" patch:
> 	[ ID] Interval           Transfer     Bandwidth
> 	[  4]   0.00-1.00   sec   635 MBytes  5.33 Gbits/sec
> 	[  4]   1.00-2.00   sec   636 MBytes  5.33 Gbits/sec
> 	[  4]   2.00-3.00   sec   637 MBytes  5.34 Gbits/sec
> 	[  4]   3.00-4.00   sec   636 MBytes  5.34 Gbits/sec
> 	[  4]   4.00-5.00   sec   637 MBytes  5.34 Gbits/sec
> 	[  4]   5.00-6.00   sec   637 MBytes  5.35 Gbits/sec
> 	[  4]   6.00-7.00   sec   637 MBytes  5.34 Gbits/sec
> 	[  4]   7.00-8.00   sec   636 MBytes  5.33 Gbits/sec
> 	[  4]   8.00-9.00   sec   634 MBytes  5.32 Gbits/sec
> 	[  4]   9.00-10.00  sec   637 MBytes  5.34 Gbits/sec
> 	- - - - - - - - - - - - - - - - - - - - - - - - -
> 	[ ID] Interval           Transfer     Bandwidth
> 	[  4]   0.00-10.00  sec  6.21 GBytes  5.34 Gbits/sec                  se=
nder
> 	[  4]   0.00-10.00  sec  6.21 GBytes  5.34 Gbits/sec                  re=
ceiver
>=20
> iperf3 result with both patches:
> 	[ ID] Interval           Transfer     Bandwidth
> 	[  4]   0.00-1.00   sec   652 MBytes  5.47 Gbits/sec
> 	[  4]   1.00-2.00   sec   653 MBytes  5.47 Gbits/sec
> 	[  4]   2.00-3.00   sec   654 MBytes  5.48 Gbits/sec
> 	[  4]   3.00-4.00   sec   654 MBytes  5.49 Gbits/sec
> 	[  4]   4.00-5.00   sec   653 MBytes  5.48 Gbits/sec
> 	[  4]   5.00-6.00   sec   653 MBytes  5.48 Gbits/sec
> 	[  4]   6.00-7.00   sec   653 MBytes  5.48 Gbits/sec
> 	[  4]   7.00-8.00   sec   653 MBytes  5.48 Gbits/sec
> 	[  4]   8.00-9.00   sec   653 MBytes  5.48 Gbits/sec
> 	[  4]   9.00-10.00  sec   654 MBytes  5.48 Gbits/sec
> 	- - - - - - - - - - - - - - - - - - - - - - - - -
> 	[ ID] Interval           Transfer     Bandwidth
> 	[  4]   0.00-10.00  sec  6.38 GBytes  5.48 Gbits/sec                  se=
nder
> 	[  4]   0.00-10.00  sec  6.38 GBytes  5.48 Gbits/sec                  re=
ceiver
>=20
> About 16% more packets/sec without XDP program loaded,
> and about 5% more packets/sec when using PP.
> Tested on Banana Pi BPI-R4 (MT7988A)
>=20
> ---
> Technically, this is version 2 of the =E2=80=9Cuse prefetch methods=E2=80=
=9D patch.
> Initially, I submitted it as a single patch for review (RFC),
> but later I decided to include a second patch, resulting in this series
> Changes in v2:
> 	- Add "use PP exclusively for XDP programs" patch and create this series
> ---
> Elad Yifee (2):
>   net: ethernet: mtk_eth_soc: use prefetch methods
>   net: ethernet: mtk_eth_soc: use PP exclusively for XDP programs
>=20
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> --=20
> 2.45.2
>=20

--eeEMdISa/6n5flqb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZqfpGQAKCRA6cBh0uS2t
rIUMAP4nuNOMAUEsFdsLjRwAyFNgf1vOCZYQoyFon6wysD5fSQEAlHKbTNTyt0u4
EsoZUJ8VcK/cKEWZoQJOtnrr7BxBVw4=
=l8GM
-----END PGP SIGNATURE-----

--eeEMdISa/6n5flqb--

