Return-Path: <netdev+bounces-294675-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u4kzDLLfH2pRrgAAu9opvQ
	(envelope-from <netdev+bounces-294675-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:02:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4296A63579B
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:02:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gibson.dropbear.id.au header.s=202602 header.b=LnPVNuzo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294675-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-294675-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D2ECE300C0CE
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 08:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B523955EA;
	Wed,  3 Jun 2026 08:02:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F44402453
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 08:02:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780473731; cv=none; b=Q58UrFAALbXcGA681Z52h3xqK4VbMRSiW8NVlXFExwlsUsO2E+6WezylEqXksMHa3WodN2XOBtxFIec3TXXNHnSRn61kK2y9MHFj9E26Wl7G4Z7jHpq11AeIxmpddrLHTKLUZ25EiBd6JY0RIDan5lyLSPZpkAn0E+uWQLje+gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780473731; c=relaxed/simple;
	bh=FhEX2C5U1e2rLZE3qf3v81ODJ4nqrFQu116VRK2H89s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOv57UyKlYuw/IKye+c/F7MgZu4dhOi9LgRfx2uZRPlb9ETsTViOMXXSCsajr8t2QccKt3BZyzCNP+iCMOqnO1SSmdtbvo96U6Qc2GHtaeBqwk5Tjq9z3K9Hha60GCQeD7/yKxz1S7PLZL82pUcCZ7iucPVH0bZmPwGatOTbvVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b=LnPVNuzo; arc=none smtp.client-ip=150.107.74.76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202602; t=1780473727;
	bh=CS2AOn/tJ0mhXVuSowRo5F86TzuTj5U20PzZdWlsqc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LnPVNuzo3iGFLrZWRaHrS4RFAlNoXR3F9EgxxKcZnGS8Bp9+mTPwKRmW5vNxXmaiH
	 vddTm3+IlpL7FZQaPNxCnEmAsDZiOMzpkmVrx9o4Uc9cBvVX74qE8MEXNWw8us0+1F
	 Xw/XKoiPbZj41WfrAYMBl5Mdg0fYNVvw8znO+sD4LjhKASxWBTQy2g8/u93a8n/8JM
	 iAJ+v3WBhAVly6/E1GrmugM1utf/jhcacZrMjgIHEXpJdaJdEUTOYBG6bjimhjHwzw
	 fbi3Z1M0Khsq3r0AkveT6nWqL64Owvz3ziZX9oDZIYfhOwD70vq1y68jx1jOJJiQ3X
	 sR6acvVyuFGew==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4gVgCM39K2z4wxG; Wed, 03 Jun 2026 18:02:07 +1000 (AEST)
Date: Wed, 3 Jun 2026 18:02:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: =?iso-8859-1?B?zfFpZ28=?= Huguet <ihuguet@redhat.com>,
	Stefano Brivio <sbrivio@redhat.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	netdev@vger.kernel.org, yuhuang@redhat.com, justin.iurman@gmail.com,
	horms@kernel.org, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, idosch@nvidia.com,
	dsahern@kernel.org, Chris Adams <linux@cmadams.net>,
	Beniamino Galvani <bgalvani@redhat.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Andrew Lunn <andrew@lunn.ch>, regressions@lists.linux.dev
Subject: Re: [PATCH net v2] Revert "ipv6: preserve insertion order for
 same-scope addresses"
Message-ID: <ah_fejZd-lPr6AqM@zatzit>
References: <20260529112357.5079-1-fmancera@suse.de>
 <20260529134045.56330243@elisabeth>
 <5079261a-79e5-421b-bf6a-a511acaaeca4@kernel.org>
 <20260601153525.546746a8@elisabeth>
 <CACT4oueDv=KRZmJw=1N58EN7eoFz5AqbBBMP8FE4=+rQ99oFEg@mail.gmail.com>
 <8e9cbf0a-caff-4575-afb7-fe852df8a51a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2hgDZo9YJcACAqqN"
Content-Disposition: inline
In-Reply-To: <8e9cbf0a-caff-4575-afb7-fe852df8a51a@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[gibson.dropbear.id.au:s=202602];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:matttbe@kernel.org,m:ihuguet@redhat.com,m:sbrivio@redhat.com,m:fmancera@suse.de,m:netdev@vger.kernel.org,m:yuhuang@redhat.com,m:justin.iurman@gmail.com,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:idosch@nvidia.com,m:dsahern@kernel.org,m:linux@cmadams.net,m:bgalvani@redhat.com,m:regressions@leemhuis.info,m:andrew@lunn.ch,m:regressions@lists.linux.dev,m:justiniurman@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[david@gibson.dropbear.id.au,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DMARC_NA(0.00)[dropbear.id.au];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294675-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gibson.dropbear.id.au:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@gibson.dropbear.id.au,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,suse.de,vger.kernel.org,gmail.com,kernel.org,google.com,davemloft.net,nvidia.com,cmadams.net,leemhuis.info,lunn.ch,lists.linux.dev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4296A63579B


--2hgDZo9YJcACAqqN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 03, 2026 at 03:46:14PM +1000, Matthieu Baerts wrote:
>=20
>=20
> On 02/06/2026 00:01, =C3=8D=C3=B1igo Huguet wrote:
> > On Mon, Jun 1, 2026 at 3:35=E2=80=AFPM Stefano Brivio <sbrivio@redhat.c=
om> wrote:
> >> I was thinking that if we implement a label like NLM_F_INSERT_LAST
> >> (David's proposal for the name), we could patch iproute2 to set it on
> >> 'ip address restore' at least, other than using it in pasta(1).
>=20
> (...)
>=20
> > What if we reapply the patch and add a NLM_F_INSERT_FIRST /
> > NLM_F_PREPEND option instead? This will break UAPI, which is bad, but
> > probably not too bad per the conversations in this and the other
> > thread.=20
>=20
> I guess it is safer not to break UAPI and not reapplying the patch,
> especially when there is no clear way to know which order is taken by
> the kernel.

I think =C3=8D=C3=B1igo wasn't suggesting reapplying the patch as is, but a
modified version that only makes the behavioural change when userspace
sets a new attribute/flag/whatever.

> What about clearly stating that the default order is "random", except
> when an additional flag is set to sort them chronologically or the
> opposite?

We could, but since userspace relying on the existing behaviour is
already out there, I'm not sure what it buys us.  The insertion order
also isn't random - it's sorted by scope at least.  Theoretically
there could be other (existing) sorting criteria for other address
types (I haven't looked beyong IPv4 and IPv6).  The problem arises
because IPv4 and IPv6 have different behaviours when inserting
something where the order isn't defined - IPv4 inserts after existing
entries of the same scope, IPv6 puts it before existing entries of the
same scope - it's literally a < versus a <=3D.

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--2hgDZo9YJcACAqqN
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmof320ACgkQzQJF27ox
2GdT4Q/+Pdyv4ttbRv9/hxDynh1JFBvIDwN77zvrMD9D9VZNFWTzFrSWI3fzkw1J
+narmMh4NtYObu26YzltRw2hq4pKMEkUYw14Tgx0okBBMX/kHzymNrSADC3GGJKG
MvHcTP03r/7pD+cnPF7d8DToYQDC3WfCsMKSg79OXmDOy9fdy3/8K21JtYv+m820
bPiQv77nbXBElhBnGENR6Oy4k7uyM7ga0TQFTxWWbzYeJSaVnHju33Fit+qdulnI
vZVX2Aj+g7MPdzHzF+wvA6+xp/vLKALA0Sut1uLzWiQAF5NRHKEoc9xO5QCl6N8l
r6XICQZN3/KwL5it+WLXgJkwVsahBjIwLE91hxWAtRI38gpSIPyDmmTqHRL9beTq
XfRb/fuuFVLT2TNs55G+iG0S7pstcoqzBhMIPUbh3K8kFVpRYx5B2Vhv/1DGNR0t
3emeU5M9kRXkH/VQpFshfeO7rNYQtlqtE+dssUQhpX3saNUczO4vfTnJlM9sYyT6
BoGzVGPlAImatDuJWwUGh1WiO4ceD1UfVQ/wJm0+dhadWabI5SWj/D5Cy2k/+rJv
EUOmUl+7a6j9fIrPkn7M+PFNnQKIi2r/fyvRqDmII4a3JMAGuGf8upziK3Xmf0a2
tjj7MgiG1AXcxBgogthYG9KXicHMhhiLtX+O2U0CnqCkWUXeUdk=
=0PGq
-----END PGP SIGNATURE-----

--2hgDZo9YJcACAqqN--

