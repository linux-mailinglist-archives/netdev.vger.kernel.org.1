Return-Path: <netdev+bounces-56313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEE880E7BB
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 10:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C8FA281769
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 09:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DEA584F9;
	Tue, 12 Dec 2023 09:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oKPX3Cx8"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54858CF
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 01:33:08 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231212093306euoutp01e65299a9f177470c5c334b1355a1b64c~gC8HGqjhU3096730967euoutp01U;
	Tue, 12 Dec 2023 09:33:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231212093306euoutp01e65299a9f177470c5c334b1355a1b64c~gC8HGqjhU3096730967euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1702373586;
	bh=coV+CyqHigZqfAo5dBvVITEJXDtCbj6wI2UqmBm2Za4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oKPX3Cx8fCYOulcXMZ//MKmDR4uSSULggPlz2FtZUcsP2kp5HtpIQSJvt3fYxlDpe
	 4C7XmfFaABAnvA/dLa8253bV+tl0oAv2ikgailfL1z3rvl3Wk5FKCv0fm7lWCnQCVT
	 f2BTut8ZnBlTnIRggzsbX0gR2wc7FtBDmfdzp9wc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231212093305eucas1p1a54fd6241a7c67d3dfab577a238cbb12~gC8G3aA_j0692606926eucas1p1L;
	Tue, 12 Dec 2023 09:33:05 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 89.44.09552.1D828756; Tue, 12
	Dec 2023 09:33:05 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20231212093305eucas1p1efe0774516346de77142dc1ab427122d~gC8Ge-Hyf0939409394eucas1p1H;
	Tue, 12 Dec 2023 09:33:05 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231212093305eusmtrp1577005544b8d95b3724fb1a237036e46~gC8GeM1BM0428904289eusmtrp1r;
	Tue, 12 Dec 2023 09:33:05 +0000 (GMT)
X-AuditID: cbfec7f5-853ff70000002550-ce-657828d1ee38
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 98.E4.09274.1D828756; Tue, 12
	Dec 2023 09:33:05 +0000 (GMT)
Received: from localhost (unknown [106.120.51.111]) by eusmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20231212093305eusmtip2c4efa8ecf7cb216e6eb929b4d57765a0~gC8GRiG3N0763907639eusmtip25;
	Tue, 12 Dec 2023 09:33:05 +0000 (GMT)
From: Lukasz Stelmach <l.stelmach@samsung.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Jakub Kicinski <kuba@kernel.org>,  netdev@vger.kernel.org
Subject: Re: [PATCH] [v2] net: asix: fix fortify warning
Date: Tue, 12 Dec 2023 10:33:04 +0100
In-Reply-To: <20231211090535.9730-1-dmantipov@yandex.ru> (Dmitry Antipov's
	message of "Mon, 11 Dec 2023 12:05:32 +0300")
Message-ID: <oypijdbkav935b.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
	protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsWy7djPc7oXNSpSDd7u1rJ4dWw7q8WFbX2s
	FscWiDkwe2xa1cnm8XmTnMfhhn6WAOYoLpuU1JzMstQifbsEroz9C2+yF6yUrXg2fzJrA+Nz
	iS5GTg4JAROJAysvM3YxcnEICaxglPi3sI0VwvnCKHHr6U6ozGdGicfPfzHDtDxomQWVWM4o
	cX7ZEhYI5wWjxJ2ZD4H6OTjYBPQk1q6NAGkQEdCQ+Dh7ASOIzSxgK3Hq5j4WEFtYwEJi6swz
	jCDlLAKqEs1duSBhToEqidZ3DWAlvALmEosuXACzRQUsJY5vbWeDiAtKnJz5hAViZK7EzPNv
	wO6REDjCIfF2wXyoQ10kWtfeYoWwhSVeHd/CDmHLSJye3MMC0dDOKNF0ZSErhDOBUeJzRxMT
	RJW1xJ1zv9ggbEeJpe+/soBcKiHAJ3HjrSDEZj6JSdumM0OEeSU62oQgqlUk1vXvYYGwpSR6
	X61ghLA9JKY/72OHhFU3o8SflzeYJjAqzELy0CwkD80CGsssoCmxfpc+RFhbYtnC18yzoMG4
	bt17lgWMrKsYxVNLi3PTU4uN81LL9YoTc4tL89L1kvNzNzECE8zpf8e/7mBc8eqj3iFGJg7G
	Q4wqQM2PNqy+wCjFkpefl6okwntyR3mqEG9KYmVValF+fFFpTmrxIUZpDhYlcV7VFPlUIYH0
	xJLU7NTUgtQimCwTB6dUA5PqpjAj4YMBO69cEP8dFfA/fHKpT+MRQ7ucf3leJuKtejrcJi43
	X53sFDI9vNiYWdLlq3bJL1G52T2vK48fNfi+ZN5dg42iZb4awW8/XHhs4Ow6yXXTos/TTHlZ
	VP8nKPJbfvoQWKv7n0ns0r/qvvV+mWLcCpvUqg0yP5+1PptlVhBz6sChZxONhFyFupV/N+/v
	560KrTGSi2ycX3tWW2mKUIbGtf/WvHrHLXdH7irk3qlf9+36y3O2xeUm1/I2rjosdHR+0t/J
	Pqk/eTdzLPkvzJjr/inMPZ5D9MBer//W86ftK9umsOntF3eRS1sL+L3PGBhmLn8e3Pdw9pT6
	fYGfv/El2MRMDcqZMSskUomlOCPRUIu5qDgRALFhiBirAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42I5/e/4Pd2LGhWpBkue8Vu8Orad1eLCtj5W
	i2MLxByYPTat6mTz+LxJzuNwQz9LAHOUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5
	rJWRqZK+nU1Kak5mWWqRvl2CXsb+hTfZC1bKVjybP5m1gfG5RBcjJ4eEgInEg5ZZjF2MXBxC
	AksZJd4/e8nUxcgBlJCSWDk3HaJGWOLPtS42iJpnjBKvLj9nAalhE9CTWLs2AqRGREBD4uPs
	BYwgNrOArcSpm/tYQGxhAQuJqTPPgMWFBMwldp2bzAbSyiKgKtHclQsS5hSokmh91wBWzgtU
	sujCBTBbVMBS4vjWdjaIuKDEyZlPWCDGZ0t8Xf2ceQKjwCwkqVlIUrOANjALaEqs36UPEdaW
	WLbwNfMsqOPWrXvPsoCRdRWjSGppcW56brGRXnFibnFpXrpecn7uJkZgXGw79nPLDsaVrz7q
	HWJk4mA8xKgC1Plow+oLjFIsefl5qUoivCd3lKcK8aYkVlalFuXHF5XmpBYfYjQF+mwis5Ro
	cj4wYvNK4g3NDEwNTcwsDUwtzYyVxHk9CzoShQTSE0tSs1NTC1KLYPqYODilGphkVi+6bcth
	dd3Yqyv/3qaaMsZt1sHiurMtmyYpLp3Zp7m4T+9Qq4rlWkMxBbYle3b35y//dDIy6mxhSSXD
	jaJcmwvTP91tWnP8BPPBZ8FSNoVNv3U23i2desye6dx0pwUKhWfOTJsZp3j7UdVDhom2jH+r
	Jq5qtC7kPsfvxWT19saTB1/9fvAXLDpsys61VcSuaKF39LUa1wq/FYxZPBvXX9ql2alg7T/5
	3uLfOh4L2y74JnycmxB/PHPp4/x/KUf0Jvbdle1Id5b00A3JXjB7uRLTo0TG5DmGhU9e7d2z
	oEzwaLZ0poFfw8T52ksC1+1jVX8xi0tYr+DV8VjD+R72p2ft5Jl7wOKyuZ3bvMlKLMUZiYZa
	zEXFiQCVWkwqIAMAAA==
X-CMS-MailID: 20231212093305eucas1p1efe0774516346de77142dc1ab427122d
X-Msg-Generator: CA
X-RootMTR: 20231212093305eucas1p1efe0774516346de77142dc1ab427122d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231212093305eucas1p1efe0774516346de77142dc1ab427122d
References: <20231211090535.9730-1-dmantipov@yandex.ru>
	<CGME20231212093305eucas1p1efe0774516346de77142dc1ab427122d@eucas1p1.samsung.com>

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2023-12-11 pon 12:05>, when Dmitry Antipov wrote:
> When compiling with gcc version 14.0.0 20231129 (experimental) and
> CONFIG_FORTIFY_SOURCE=3Dy, I've noticed the following warning:
>
> ...
> In function 'fortify_memcpy_chk',
>     inlined from 'ax88796c_tx_fixup' at drivers/net/ethernet/asix/ax88796=
c_main.c:287:2:
> ./include/linux/fortify-string.h:588:25: warning: call to '__read_overflo=
w2_field'
> declared with attribute warning: detected read beyond size of field (2nd =
parameter);
> maybe use struct_group()? [-Wattribute-warning]
>   588 |                         __read_overflow2_field(q_size_field, size=
);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ...
>
> This call to 'memcpy()' is interpreted as an attempt to copy TX_OVERHEAD
> (which is 8) bytes from 4-byte 'sop' field of 'struct tx_pkt_info' and
> thus overread warning is issued. Since we actually want to copy both
> 'sop' and 'seg' fields at once, use the convenient 'struct_group()' here.
>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> v2: prefer 'sizeof_field(struct tx_pkt_info, tx_overhead)' over the
> hardcoded constant (Jakub Kicinski)
> ---
>  drivers/net/ethernet/asix/ax88796c_main.c | 2 +-
>  drivers/net/ethernet/asix/ax88796c_main.h | 8 +++++---
>  2 files changed, 6 insertions(+), 4 deletions(-)
>

Acked-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>

> diff --git a/drivers/net/ethernet/asix/ax88796c_main.c b/drivers/net/ethe=
rnet/asix/ax88796c_main.c
> index e551ffaed20d..11e8996b33d7 100644
> --- a/drivers/net/ethernet/asix/ax88796c_main.c
> +++ b/drivers/net/ethernet/asix/ax88796c_main.c
> @@ -284,7 +284,7 @@ ax88796c_tx_fixup(struct net_device *ndev, struct sk_=
buff_head *q)
>  	ax88796c_proc_tx_hdr(&info, skb->ip_summed);
>=20=20
>  	/* SOP and SEG header */
> -	memcpy(skb_push(skb, TX_OVERHEAD), &info.sop, TX_OVERHEAD);
> +	memcpy(skb_push(skb, TX_OVERHEAD), &info.tx_overhead, TX_OVERHEAD);
>=20=20
>  	/* Write SPI TXQ header */
>  	memcpy(skb_push(skb, spi_len), ax88796c_tx_cmd_buf, spi_len);
> diff --git a/drivers/net/ethernet/asix/ax88796c_main.h b/drivers/net/ethe=
rnet/asix/ax88796c_main.h
> index 4a83c991dcbe..68a09edecab8 100644
> --- a/drivers/net/ethernet/asix/ax88796c_main.h
> +++ b/drivers/net/ethernet/asix/ax88796c_main.h
> @@ -25,7 +25,7 @@
>  #define AX88796C_PHY_REGDUMP_LEN	14
>  #define AX88796C_PHY_ID			0x10
>=20=20
> -#define TX_OVERHEAD			8
> +#define TX_OVERHEAD     sizeof_field(struct tx_pkt_info, tx_overhead)
>  #define TX_EOP_SIZE			4
>=20=20
>  #define AX_MCAST_FILTER_SIZE		8
> @@ -549,8 +549,10 @@ struct tx_eop_header {
>  };
>=20=20
>  struct tx_pkt_info {
> -	struct tx_sop_header sop;
> -	struct tx_segment_header seg;
> +	struct_group(tx_overhead,
> +		struct tx_sop_header sop;
> +		struct tx_segment_header seg;
> +	);
>  	struct tx_eop_header eop;
>  	u16 pkt_len;
>  	u16 seq_num;

=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAmV4KNAACgkQsK4enJil
gBB6hwgAgqvcbXQtYoOrABTgCeyzibUMpPJdeaoTi+KkNomWUeYF0eEb6xgrLM6g
R570UYObYXGuDP3Egs+2QWtdUfDGfk0I4ObrMET/QVuWepBpXQXnMv5/n9v9ZIkp
7ceeqY1wjR5z7T/YOT3PpqT9NgoRkHgrY1WrIuBZit8ewWRl4WtqmKWhMGsSE2GT
jt/qIEw1pAoTZ97zUcd2TGirkAcVdEJWSw5BdGu4f3lHtHFG7uuQbHCbAH7dzGqW
ZV+728pq4LXNXhnTRwAXly7Z9KLfdpZBWvpdw7Wu+kr1GnDnGmlTTR49A/7Yaqrn
Ms8h7ty2P19C07G2YXhWvVli/uR7MA==
=vbwi
-----END PGP SIGNATURE-----
--=-=-=--

