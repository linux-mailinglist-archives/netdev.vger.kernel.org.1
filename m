Return-Path: <netdev+bounces-74332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38649860EBE
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 10:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 597211C25204
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 09:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874D45C8E2;
	Fri, 23 Feb 2024 09:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="VfotYj3O"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739435CDD9
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 09:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708682114; cv=none; b=NnI6Az2x76jf63gBBrhAoEA0qu2QXpymioRMr+wFskRTh65miqszu+qXWiITRbImbMtpyQmiGO4DJ9BLwd3+DVe6m8V5unfaBU74Cwrs1WOBkXiTxCJ46o4W58u3W5KqqP+MtYGXoeP1ncSjk9urHfPdDamTIKQZxuhojGyOxQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708682114; c=relaxed/simple;
	bh=ruLhFjJalLyx7M3TuTRegBnXFb/KXGW74daBMayGsxY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KH9CDxiNNm11VwOz5nuekCONeTPEo0ZTFmSVvcW0/vbpyH8hi2DMZOdXB5s69YGWJEMlOW8/ocgtmRierGa0AQ6ErCTt3o52pJmBP/PopjXkgqfW4XEivuumP+ed94mNzxvupfAW/zOG9owzM371Kcf16KbC9BkIsICzB7829v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=VfotYj3O; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id A78F6871A5;
	Fri, 23 Feb 2024 10:55:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708682105;
	bh=9Q/gqbrhMq7r9TkC++eV3poH5ENGD0mb67RO1i0FRCs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VfotYj3OvDVYS7p/uTVxlXp9w32iyZLEge3CUkJzZdFjctwVkTGJKk4yylG7nM3gF
	 SZtcnwyI3uCOZdZHQXHphqwryGH4B4JeJPRVA8jn0pBsxPKhhAn1mDKK4rEQAVjnvK
	 VjJ4TSwzyvP6qm19gEnOC2PK4A3F3vnY+yvGsdeulgb2OwodrV1gYkKZ8Y3HXlC5TA
	 q6jza3K6VY6miYCQ0ql8EBInKFPXQWCA6KpbI+NgSP++o9wGivnRne6KBLy3rppnl4
	 kPvR065KEJ5pxJ/r8WlrhC+Fh+V51VZTiZLxZ+S7QGIEfp9x+inM5DrG8CWV8+F/eY
	 UU7pNceYrUu7g==
Date: Fri, 23 Feb 2024 10:55:03 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: Eric Dumazet <edumazet@google.com>, Florian Fainelli
 <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH] ip link: hsr: Add support for passing information about
 INTERLINK device
Message-ID: <20240223105503.2c0afc88@wsk>
In-Reply-To: <20240216132114.2606777-1-lukma@denx.de>
References: <20240216132114.2606777-1-lukma@denx.de>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8CyA9EMO/JX07vZ5jfxYxm3";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/8CyA9EMO/JX07vZ5jfxYxm3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Dear Community,

> The HSR capable device can operate in two modes of operations -
> Doubly Attached Node for HSR (DANH) and RedBOX.
>=20
> The latter one allows connection of non-HSR aware device to HSR
> network. This node is called SAN (Singly Attached Network) and is
> connected via INTERLINK network device.
>=20
> This patch adds support for passing information about the INTERLINK
> device, so the Linux driver can properly setup it.
>=20
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  include/uapi/linux/if_link.h |  1 +
>  ip/iplink_hsr.c              | 22 +++++++++++++++++++++-
>  2 files changed, 22 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/uapi/linux/if_link.h
> b/include/uapi/linux/if_link.h index 41708e2..aa70ed6 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -1122,6 +1122,7 @@ enum {
>  	IFLA_HSR_PROTOCOL,		/* Indicate different
> protocol than
>  					 * HSR. For example PRP.
>  					 */
> +	IFLA_HSR_INTERLINK,		/* HSR interlink network
> device */ __IFLA_HSR_MAX,
>  };
> =20
> diff --git a/ip/iplink_hsr.c b/ip/iplink_hsr.c
> index da2d03d..1f048fd 100644
> --- a/ip/iplink_hsr.c
> +++ b/ip/iplink_hsr.c
> @@ -25,12 +25,15 @@ static void print_usage(FILE *f)
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
> network to connect SAN device\n" "ADDR-BYTE\n"
>  		"	0-255; the last byte of the multicast
> address used for HSR supervision\n" "	frames (default =3D 0)\n"
> @@ -86,6 +89,12 @@ static int hsr_parse_opt(struct link_util *lu, int
> argc, char **argv, if (ifindex =3D=3D 0)
>  				invarg("No such interface", *argv);
>  			addattr_l(n, 1024, IFLA_HSR_SLAVE2,
> &ifindex, 4);
> +		} else if (matches(*argv, "interlink") =3D=3D 0) {
> +			NEXT_ARG();
> +			ifindex =3D ll_name_to_index(*argv);
> +			if (ifindex =3D=3D 0)
> +				invarg("No such interface", *argv);
> +			addattr_l(n, 1024, IFLA_HSR_INTERLINK,
> &ifindex, 4); } else if (matches(*argv, "help") =3D=3D 0) {
>  			usage();
>  			return -1;
> @@ -113,6 +122,9 @@ static void hsr_print_opt(struct link_util *lu,
> FILE *f, struct rtattr *tb[]) if (tb[IFLA_HSR_SLAVE2] &&
>  	    RTA_PAYLOAD(tb[IFLA_HSR_SLAVE2]) < sizeof(__u32))
>  		return;
> +	if (tb[IFLA_HSR_INTERLINK] &&
> +	    RTA_PAYLOAD(tb[IFLA_HSR_INTERLINK]) < sizeof(__u32))
> +		return;
>  	if (tb[IFLA_HSR_SEQ_NR] &&
>  	    RTA_PAYLOAD(tb[IFLA_HSR_SEQ_NR]) < sizeof(__u16))
>  		return;
> @@ -136,6 +148,14 @@ static void hsr_print_opt(struct link_util *lu,
> FILE *f, struct rtattr *tb[]) else
>  		print_null(PRINT_ANY, "slave2", "slave2 %s ",
> "<none>");=20
> +	if (tb[IFLA_HSR_INTERLINK])
> +		print_string(PRINT_ANY,
> +			     "interlink",
> +			     "interlink %s ",
> +
> ll_index_to_name(rta_getattr_u32(tb[IFLA_HSR_INTERLINK])));
> +	else
> +		print_null(PRINT_ANY, "interlink", "interlink %s ",
> "<none>"); +
>  	if (tb[IFLA_HSR_SEQ_NR])
>  		print_int(PRINT_ANY,
>  			  "seq_nr",

Any feedback if this approach is acceptable?


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/8CyA9EMO/JX07vZ5jfxYxm3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmXYa3cACgkQAR8vZIA0
zr2fqQf/UcdY+5oJX7ZGHF1x87OAiegEtoa1QlndFWTlp/XgU2hYypsq1hNCRmgi
s32GPocY2r/HQC5eeI0TpNC/C4wQU6snwk1O4mm0RXTO8nyEwu0APRhj8QyLakqI
mEW8ZaO2e1sqxuKaBkPAgBBmaGWVWc3RLthFiBi+5N+PsHIOh757PYskW1RcDo3F
RCN7APMZqIEfTd7rpoBNcT2SJ9JjdNt+ry+SnlpWYqWqcP7cgSar2867p4zCxE6s
CdtkUlVZVcw1UwkRl1bbQTKwYu6HPz5pFqELtDzFlqCgjyMM2QtKU4yqbNjalMW3
bFnEheGCvJyFvAJjLNSjaOU3viox6g==
=lKAI
-----END PGP SIGNATURE-----

--Sig_/8CyA9EMO/JX07vZ5jfxYxm3--

