Return-Path: <netdev+bounces-91736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF498B3B01
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 17:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1974C1F25873
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 15:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE2B1635D5;
	Fri, 26 Apr 2024 15:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="aCHAHSdL"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E414815E5D2
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144443; cv=none; b=brhlUMi95RTMNTaE6SuDjj5OSW9p9SQ+IymVBwZNIy7S6V8guK8GuD29PdYFEARfdTMfwRhmd9Q+uZAqwBn/9LarJ1k6PUHTLUfoAMKubhqHpWvIT4YrhG15Ia3TLrmuXdZjAZyd9AjgTk/+LpNWAZV7x8pPFN0YGzL2Dkx+TGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144443; c=relaxed/simple;
	bh=03oLgsvUMsVbrU5/YiZ4S4cXctgtxi43V83bbnlf6TA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G6uM7qJ3OaBzTthmfBsrNXee5VzpnD56L9/F+Mh6KgD2aUxSO27xdpj9LkIyS/z9855ll5H7FaCywuUxseZTjLi59iC+9MaKuoMLmIwxDlWfxjMAAsPXgDQNbWDMiiLIRs85dt4Y7X/E1XTAGIPgchU9KLoEQCWxbPDSmxCiQRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=aCHAHSdL; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 22F2A8823A;
	Fri, 26 Apr 2024 17:13:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714144439;
	bh=pEfHxevqiWdQgbkebcL5T8IaAlJC1AOhU4/UfVF3KyY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aCHAHSdLkPFeEetLMKXKRUk1Zg9TdQat9rtlkYSIWGJhCiDsegRUsEPFvYO1U0eoc
	 xHN3HM1j0i4aarxb0YaqWewTfF8TGFi0lwP/Dw3TiNnd3T8rUj6HrJ0RWOmHz+B4ft
	 FUwvA9luEYk2kLT9AB17Echu6evxfm+ZcOn4k8h2pY+AAhZHN6QcAMyLRalxDzd70g
	 byfKx9n8W4RcVt1AgQMUe6VuOha9uqbPWdzu3TnFfn73MAv5lLvygo9r2Jf/Huv071
	 zRqMJFk3fkhTsaE9+tveVV3WS6xUon5JDNOWWZNQbIdeW0Fx5jgw2q7VaGClJXfiHQ
	 rAG9S6eQ7nGCQ==
Date: Fri, 26 Apr 2024 17:13:52 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Andrew Lunn <andrew@lunn.ch>, Stephen Hemminger
 <stephen@networkplumber.org>
Cc: Eric Dumazet <edumazet@google.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
Subject: Re: [PATCH v3] ip link: hsr: Add support for passing information
 about INTERLINK device
Message-ID: <20240426171352.2460390f@wsk>
In-Reply-To: <20240402124908.251648-1-lukma@denx.de>
References: <20240402124908.251648-1-lukma@denx.de>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//dMsbMl_Xlq3i5ya2tqwvHw";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_//dMsbMl_Xlq3i5ya2tqwvHw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

> The HSR capable device can operate in two modes of operations -
> Doubly Attached Node for HSR (DANH) and RedBOX (HSR-SAN).
>=20
> The latter one allows connection of non-HSR aware device(s) to HSR
> network.
> This node is called SAN (Singly Attached Network) and is connected via
> INTERLINK network device.
>=20
> This patch adds support for passing information about the INTERLINK
> device, so the Linux driver can properly setup it.
>=20

As the HSR-SAN support patches have been already pulled to next-next, I
would like to gentle remind about this patch.

Thanks in advance.

> Signed-off-by: Lukasz Majewski <lukma@denx.de>
>=20
> ---
> Changes for v2:
>=20
> - Rebase the patch on top of iproute2-next/main repo
> - Replace matches() with strcmp() when interlink
> - Use print_color_string() instead of just print_string()
>=20
> Changes for v3:
> - Add proper description to ip/iplink.c and man/man8/ip-link.8.in
> ---
>  ip/iplink.c           |  4 ++--
>  ip/iplink_hsr.c       | 18 +++++++++++++++++-
>  man/man8/ip-link.8.in |  5 +++++
>  3 files changed, 24 insertions(+), 3 deletions(-)
>=20
> diff --git a/ip/iplink.c b/ip/iplink.c
> index 95314af5..bca365ce 100644
> --- a/ip/iplink.c
> +++ b/ip/iplink.c
> @@ -40,8 +40,8 @@ void iplink_types_usage(void)
>  	/* Remember to add new entry here if new type is added. */
>  	fprintf(stderr,
>  		"TYPE :=3D { amt | bareudp | bond | bond_slave |
> bridge | bridge_slave |\n"
> -		"          dsa | dummy | erspan | geneve | gre |
> gretap | gtp | ifb |\n"
> -		"          ip6erspan | ip6gre | ip6gretap | ip6tnl
> |\n"
> +		"          dsa | dummy | erspan | geneve | gre |
> gretap | gtp | hsr |\n"
> +		"          ifb | ip6erspan | ip6gre | ip6gretap |
> ip6tnl |\n" "          ipip | ipoib | ipvlan | ipvtap |\n"
>  		"          macsec | macvlan | macvtap | netdevsim
> |\n" "          netkit | nlmon | rmnet | sit | team | team_slave |\n"
> diff --git a/ip/iplink_hsr.c b/ip/iplink_hsr.c
> index 76f24a6a..42adb430 100644
> --- a/ip/iplink_hsr.c
> +++ b/ip/iplink_hsr.c
> @@ -21,12 +21,15 @@ static void print_usage(FILE *f)
>  {
>  	fprintf(f,
>  		"Usage:\tip link add name NAME type hsr slave1
> SLAVE1-IF slave2 SLAVE2-IF\n"
> -		"\t[ supervision ADDR-BYTE ] [version VERSION]
> [proto PROTOCOL]\n"
> +		"\t[ interlink INTERLINK-IF ] [ supervision
> ADDR-BYTE ] [ version VERSION ]\n"
> +		"\t[ proto PROTOCOL ]\n"
>  		"\n"
>  		"NAME\n"
>  		"	name of new hsr device (e.g. hsr0)\n"
>  		"SLAVE1-IF, SLAVE2-IF\n"
>  		"	the two slave devices bound to the HSR
> device\n"
> +		"INTERLINK-IF\n"
> +		"	the interlink device bound to the HSR
> network to connect SAN device(s)\n" "ADDR-BYTE\n"
>  		"	0-255; the last byte of the multicast
> address used for HSR supervision\n" "	frames (default =3D 0)\n"
> @@ -82,6 +85,12 @@ static int hsr_parse_opt(struct link_util *lu, int
> argc, char **argv, if (ifindex =3D=3D 0)
>  				invarg("No such interface", *argv);
>  			addattr_l(n, 1024, IFLA_HSR_SLAVE2,
> &ifindex, 4);
> +		} else if (strcmp(*argv, "interlink") =3D=3D 0) {
> +			NEXT_ARG();
> +			ifindex =3D ll_name_to_index(*argv);
> +			if (ifindex =3D=3D 0)
> +				invarg("No such interface", *argv);
> +			addattr_l(n, 1024, IFLA_HSR_INTERLINK,
> &ifindex, 4); } else if (matches(*argv, "help") =3D=3D 0) {
>  			usage();
>  			return -1;
> @@ -109,6 +118,9 @@ static void hsr_print_opt(struct link_util *lu,
> FILE *f, struct rtattr *tb[]) if (tb[IFLA_HSR_SLAVE2] &&
>  	    RTA_PAYLOAD(tb[IFLA_HSR_SLAVE2]) < sizeof(__u32))
>  		return;
> +	if (tb[IFLA_HSR_INTERLINK] &&
> +	    RTA_PAYLOAD(tb[IFLA_HSR_INTERLINK]) < sizeof(__u32))
> +		return;
>  	if (tb[IFLA_HSR_SEQ_NR] &&
>  	    RTA_PAYLOAD(tb[IFLA_HSR_SEQ_NR]) < sizeof(__u16))
>  		return;
> @@ -132,6 +144,10 @@ static void hsr_print_opt(struct link_util *lu,
> FILE *f, struct rtattr *tb[]) else
>  		print_null(PRINT_ANY, "slave2", "slave2 %s ",
> "<none>");=20
> +	if (tb[IFLA_HSR_INTERLINK])
> +		print_color_string(PRINT_ANY, COLOR_IFNAME,
> "interlink", "interlink %s ",
> +
> ll_index_to_name(rta_getattr_u32(tb[IFLA_HSR_INTERLINK]))); +
>  	if (tb[IFLA_HSR_SEQ_NR])
>  		print_int(PRINT_ANY,
>  			  "seq_nr",
> diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
> index 31e2d7f0..8aab29bf 100644
> --- a/man/man8/ip-link.8.in
> +++ b/man/man8/ip-link.8.in
> @@ -1621,6 +1621,8 @@ the following additional arguments are
> supported:=20
>  .BI "ip link add link " DEVICE " name " NAME " type hsr"
>  .BI slave1 " SLAVE1-IF " slave2 " SLAVE2-IF "
> +.RB [ " interlink"
> +.IR INTERLINK-IF " ] "
>  .RB [ " supervision"
>  .IR ADDR-BYTE " ] ["
>  .BR version " { " 0 " | " 1 " } ["
> @@ -1637,6 +1639,9 @@ the following additional arguments are
> supported: .BI slave2 " SLAVE2-IF "
>  - Specifies the physical device used for the second of the two ring
> ports.=20
> +.BI interlink " INTERLINK-IF"
> +- The interlink device bound to the HSR network to connect SAN
> device(s). +
>  .BI supervision " ADDR-BYTE"
>  - The last byte of the multicast address used for HSR supervision
> frames. Default option is "0", possible values 0-255.




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_//dMsbMl_Xlq3i5ya2tqwvHw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmYrxLAACgkQAR8vZIA0
zr2JPQf+J2wSCp9KJ1xxLHBRqKU5wXPm4XjVk67hcMJX5gBBnvCAKPdNWzVuqTvj
4qPemM/b5wsca74GCUVGtSj3himdkg86Lj6G8KbwBxcnxWzisRHrvWyoAD4LxF0O
4hFea6JuVLqwvAcxhRMPEHgPbstn4J4q4qd89WZ5B9qT7vtlfIgq2uCsLZYa1wpo
z9clen4Im+3oBv7EbDZpMD1B5HbM8Wo+wZPx432iMkRNRudjy1Sl2L6bhDaMMUYV
23H5BIe0xxJ0ay8DrtW1wTUOubkrFdx84mBer0Y1EhDGQn3naX5kmqHE+/wMdbRS
qWdarze/dLnMyEH6LcmT76P5ECyznw==
=3sV6
-----END PGP SIGNATURE-----

--Sig_//dMsbMl_Xlq3i5ya2tqwvHw--

