Return-Path: <netdev+bounces-263059-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJlJNkaQpmnxRAAAu9opvQ
	(envelope-from <netdev+bounces-263059-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 08:39:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7682B1EA410
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 08:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 307E130205CA
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 07:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC50C34F48C;
	Tue,  3 Mar 2026 07:39:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from s1.jo-so.de (s1.jo-so.de [37.221.195.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA4330C63B
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 07:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.221.195.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772523586; cv=none; b=A1ulIs73w4b6RdF5fpu6FXr4s/U3eCEpItlEzMN2kqj8eEUx6NEtmCreNYe5mTA3GeS8q8UW5993fnUkVnbMij/PnvMHHw/gUI087u2c7rPbqDXgu/sWIYX+U2k0mrz7W9C9loDWJzU6SUDgU4pUdF2wlWly8VEPSxSRwkLrFgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772523586; c=relaxed/simple;
	bh=fZ0q1hw4g1+8tR6WIMRcKfQbW912ciKe5xpNP/xeTCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2oytuD9+pwpB5ojgfJOoTCaPCLAeYNDmgorQKRLA0r44mjF2zMY3ZgQ7ns1mdWgO6XtFxVc1md8wUtQrVXRBEeBVd7y2xktNTYPTmuCN8K4VzZWFBc/xYaXUgGXNqT2kVZQ5yJhP08FydzJrZDnYwoMAmV6aSRBZRbQNQxp/j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jo-so.de; spf=pass smtp.mailfrom=jo-so.de; arc=none smtp.client-ip=37.221.195.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jo-so.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jo-so.de
Received: from mail-relay (helo=jo-so.de)
	by s1.jo-so.de with local-bsmtp (Exim 4.98.2)
	(envelope-from <joerg@jo-so.de>)
	id 1vxKLs-0000000A5Eo-3gj5;
	Tue, 03 Mar 2026 08:39:32 +0100
Received: from joerg by zenbook.jo-so.de with local (Exim 4.99.1)
	(envelope-from <joerg@jo-so.de>)
	id 1vxKLs-00000001RRM-0Zmc;
	Tue, 03 Mar 2026 08:39:32 +0100
Date: Tue, 3 Mar 2026 08:39:32 +0100
From: =?utf-8?B?SsO2cmc=?= Sommer <joerg@jo-so.de>
To: Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willy Tarreau <w@1wt.eu>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Zhouyan Deng <dengzhouyan_nwpu@163.com>, 
	Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH net] tcp: secure_seq: add back ports to TS offset
Message-ID: <aaaL81V4GWUPEajE@jo-so.de>
OpenPGP: id=C1ED266701F55480; url=https://jo-so.de/pgp-key-alea.txt;
 preference=signencrypt
References: <20260302205527.1982836-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="22sl5wzfkl5db2yu"
Content-Disposition: inline
In-Reply-To: <20260302205527.1982836-1-edumazet@google.com>
X-Rspamd-Queue-Id: 7682B1EA410
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,1wt.eu,vger.kernel.org,gmail.com,163.com,strlen.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263059-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[jo-so.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joerg@jo-so.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.650];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,jo-so.de:mid]
X-Rspamd-Action: no action


--22sl5wzfkl5db2yu
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net] tcp: secure_seq: add back ports to TS offset
MIME-Version: 1.0

Eric Dumazet schrieb am Mo 02. M=C3=A4r, 20:55 (+0000):
> This reverts 28ee1b746f49 ("secure_seq: downgrade to per-host timestamp o=
ffsets")
>=20
> tcp_tw_recycle went away in 2017.
>=20
> Zhouyan Deng reported off-path TCP source port leakage via
> SYN cookie side-channel that can be fixed in multiple ways.
>=20
> One of them is to bring back TCP ports in TS offset randomization.
>=20
> As a bonus, we perform a single siphash() computation
> to provide both an ISN and a TS offset.

This sounds great! I was questioning myself if the grace period for
tcp_tw_recycle isn't over.

> @@ -118,33 +99,30 @@ EXPORT_SYMBOL(secure_ipv6_port_ephemeral);
>  #endif
> =20
>  #ifdef CONFIG_INET
> -u32 secure_tcp_ts_off(const struct net *net, __be32 saddr, __be32 daddr)
> -{
> -	if (READ_ONCE(net->ipv4.sysctl_tcp_timestamps) !=3D 1)
> -		return 0;
> -
> -	ts_secret_init();
> -	return siphash_2u32((__force u32)saddr, (__force u32)daddr,
> -			    &ts_secret);
> -}
> -
>  /* secure_tcp_seq_and_tsoff(a, b, 0, d) =3D=3D secure_ipv4_port_ephemera=
l(a, b, d),
>   * but fortunately, `sport' cannot be 0 in any circumstances. If this ch=
anges,
>   * it would be easy enough to have the former function use siphash_4u32,=
 passing
>   * the arguments as separate u32.
>   */
> -u32 secure_tcp_seq(__be32 saddr, __be32 daddr,
> -		   __be16 sport, __be16 dport)
> +union tcp_seq_and_ts_off
> +secure_tcp_seq_and_ts_off(const struct net *net, __be32 saddr, __be32 da=
ddr,
> +			  __be16 sport, __be16 dport)
>  {
> -	u32 hash;
> +	u32 ports =3D (__force u32)sport << 16 | (__force u32)dport;
> +	union tcp_seq_and_ts_off st;
> =20
>  	net_secret_init();
> -	hash =3D siphash_3u32((__force u32)saddr, (__force u32)daddr,
> -			    (__force u32)sport << 16 | (__force u32)dport,
> -			    &net_secret);
> -	return seq_scale(hash);
> +
> +	st.hash64 =3D siphash_3u32((__force u32)saddr, (__force u32)daddr,
> +				 ports, &net_secret);

Sorry, if this is a dump question, but does this make the ts_off unique per
connection or only per quadruple (saddr, sport, daddr, dport), i.e. the same
remote port gets the same ts_off. The documentation says =E2=80=98per conne=
ction=E2=80=99
and it might be helpful to say it gets the same ts_off if the addresses and
ports are the same.


Kind regards, J=C3=B6rg

--=20
=E2=80=9CComputer games don't affect kids. If Pacman would have affected us=
 as
children, we would now run around in darkened rooms, munching yellow
pills and listening to repetetive music.=E2=80=9D

--22sl5wzfkl5db2yu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABEIAB0WIQS1pYxd0T/67YejVyF9LJoj0a6jdQUCaaaQMgAKCRB9LJoj0a6j
dWMAAP4xN1US8w0BZsh0uQBL4hvYm3Q9IE6G0Pyq7I/r6PCvmQD+I98hPAYkTd91
M5wWWKUpX+/fmR8unIB9HR5lFWtHf8I=
=aEei
-----END PGP SIGNATURE-----

--22sl5wzfkl5db2yu--

