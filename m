Return-Path: <netdev+bounces-295049-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AEwkCiIOIWrp+gAAu9opvQ
	(envelope-from <netdev+bounces-295049-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 07:33:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B2A63D04C
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 07:33:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BRneAZeV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295049-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295049-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ABDD23051667
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 05:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66213C09FB;
	Thu,  4 Jun 2026 05:30:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A62D380FE7;
	Thu,  4 Jun 2026 05:30:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780551043; cv=none; b=EIuus+mM5s7Uh0HkGLXlCZtCUZ/7+Y7tX87kVmOaHFJHg+tXwBuUAIA6ddkdtH+uO6857DaAenF7Zmjf63P0gmaYz3G8LNQx6x6DV4xQuxWIYsz6Ey/UTGBj/I1YvnUQPu90Wo53UlMQuOjahYKvqVFn1Tz7aJxda/LW75yGhC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780551043; c=relaxed/simple;
	bh=BJ9KRQdOnppoMtg8qeSesxs+aJ6hpEZZg8Nol96NPcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h/WV9liU+s1jgNN9ghoNgUnECs2y0cD+gWltBnyMdjwv1xO2WvxnDvhgpx57Q6I9pqGaWSn4BR7Hpf/ImY6S1ARNedGVA0gcCiZWTLZV9zuLyiIaLaA7f0OMm9GkWm9MEW+UBYHD6/u1xh0cnQ+77gZ6hD1Hklclj2Uyn6D01AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRneAZeV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524671F00893;
	Thu,  4 Jun 2026 05:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780551042;
	bh=8sJyfXerJU9iiEPT8ZT0fAwQWe3UJ8yZ+Wj6Yp6I/XM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=BRneAZeVwpgn7kmaxaAgWt7ghltBXKLdOIt48MhO+V2jMeTdvfrbhJUJaUF30tK3c
	 jfyYncISAoFB740uCW92U5qld8AJZvXgOOySRWQIox3dti/zyfIAqizY5mCkUsV+ui
	 ueVmRxQG1X07meMyw+x7VDyfrM6ejNPDPOwvivSRqpRaMIgPfr8NN0x0JdSOXEyGAY
	 XfSCCnJ3TO7zdpxt3oWh0EfLbD7zS0mz7np/Gn8DdB5/np4m/zqWkcxjjeZSbtQHrl
	 hbWLrF9rIzOtikYYZGlIi8p9zF13KWyZtdPIGN/tUkjZRxj3QaV6rYdulbPytI6oUI
	 VrmZLIUr+3gIA==
Message-ID: <6d70757a-a849-4828-89e7-f3d51bf8c9f8@kernel.org>
Date: Thu, 4 Jun 2026 14:30:34 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net: skb: isolate skb data area allocations into a
 separate bucket
To: Pedro Falcato <pfalcato@suse.de>, Vlastimil Babka <vbabka@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-hardening@vger.kernel.org, linux-mm@kvack.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Simon Horman <horms@kernel.org>,
 Jason Xing <kerneljasonxing@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>
References: <20260602183122.747759-1-pfalcato@suse.de>
 <20260602183122.747759-3-pfalcato@suse.de>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <20260602183122.747759-3-pfalcato@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------58iuvSQkp47XgPodjS4574QO"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-295049-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pfalcato@suse.de,m:vbabka@kernel.org,m:akpm@linux-foundation.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-hardening@vger.kernel.org,m:linux-mm@kvack.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:horms@kernel.org,m:kerneljasonxing@gmail.com,m:kuniyu@google.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[harry@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,linux.dev,gentwo.org,google.com,kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B7B2A63D04C

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------58iuvSQkp47XgPodjS4574QO
Content-Type: multipart/mixed; boundary="------------axTL8uth9J2LpeygQTj3by2S";
 protected-headers="v1"
From: Harry Yoo <harry@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>, Vlastimil Babka <vbabka@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-hardening@vger.kernel.org, linux-mm@kvack.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Simon Horman <horms@kernel.org>,
 Jason Xing <kerneljasonxing@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>
Message-ID: <6d70757a-a849-4828-89e7-f3d51bf8c9f8@kernel.org>
Subject: Re: [PATCH 2/2] net: skb: isolate skb data area allocations into a
 separate bucket
References: <20260602183122.747759-1-pfalcato@suse.de>
 <20260602183122.747759-3-pfalcato@suse.de>
In-Reply-To: <20260602183122.747759-3-pfalcato@suse.de>

--------------axTL8uth9J2LpeygQTj3by2S
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/3/26 3:31 AM, Pedro Falcato wrote:
> SKB data area allocations (as done from alloc_skb()) use kmalloc().
> These allocations can be variably sized and their contents can be more
> or less controlled from userspace, which makes them useful for attacker=
s
> that want to overwrite a use-after-free'd object from the same kmalloc =
slab
> (which often just requires the sizes to roughly match into the same kma=
lloc
> bucket). [0] is an easy example of an exploit that uses netlink skb
> allocation to target another similarly-sized accidentally freed object.=

>=20
> While other mitigations like CONFIG_RANDOM_KMALLOC_CACHES exist, these =
are
> probabilistic. Use the existing kmem buckets API to further isolate the=
se
> allocations in a guaranteed fashion, when CONFIG_SLAB_BUCKETS=3Dy.
>=20
> Link: https://github.com/google/security-research/blob/master/pocs/linu=
x/kernelctf/CVE-2023-4207_lts_cos_mitigation_2/docs/exploit.md [0]
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> ---
>  net/core/skbuff.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 44a7f8401468..1f6c6b531ece 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -594,6 +594,8 @@ static void *kmalloc_pfmemalloc(size_t obj_size, gf=
p_t flags, int node)
>  	return kmalloc_node_track_caller(obj_size, flags, node);
>  }
> =20
> +static kmem_buckets *skb_data_buckets __ro_after_init;
> +
>  /*
>   * kmalloc_reserve is a wrapper around kmalloc_node_track_caller that =
tells
>   * the caller if emergency pfmemalloc reserves are being used. If it i=
s and
> @@ -632,7 +634,7 @@ static void *kmalloc_reserve(unsigned int *size, gf=
p_t flags, int node,
>  	 * Try a regular allocation, when that fails and we're not entitled
>  	 * to the reserves, fail.
>  	 */
> -	obj =3D kmalloc_node_track_caller(obj_size,
> +	obj =3D kmem_buckets_alloc_node_track_caller(skb_data_buckets, obj_si=
ze,
>  					flags | __GFP_NOMEMALLOC | __GFP_NOWARN,
>  					node);
>  	if (likely(obj))

What about kmalloc_pfmemalloc()?

> @@ -5213,6 +5215,7 @@ void __init skb_init(void)
>  						0,
>  						SKB_SMALL_HEAD_HEADROOM,
>  						NULL);
> +	skb_data_buckets =3D kmem_buckets_create("skb_data", SLAB_PANIC, 0, I=
NT_MAX, NULL);
>  	skb_extensions_init();
>  }
> =20

--=20
Cheers,
Harry / Hyeonggon


--------------axTL8uth9J2LpeygQTj3by2S--

--------------58iuvSQkp47XgPodjS4574QO
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCaiENegAKCRCGXBN6rc5S
1iLnAQCiHXHsoLVAPzu2eqLSBL/0qUnsHH8Rl1w8PYVRFrUQZAEAjAmcp39Ue/7d
KAD/ZxX4pGdrNWb8HUTS2rQYIoNNkg8=
=NWSc
-----END PGP SIGNATURE-----

--------------58iuvSQkp47XgPodjS4574QO--

