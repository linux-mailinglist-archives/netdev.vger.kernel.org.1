Return-Path: <netdev+bounces-295635-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gXADM7RjImr+VwEAu9opvQ
	(envelope-from <netdev+bounces-295635-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 07:50:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F7F6454B0
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 07:50:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Uu+kycIx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295635-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295635-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05F93302514F
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 05:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143D93EE1C6;
	Fri,  5 Jun 2026 05:45:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED28F30FF20;
	Fri,  5 Jun 2026 05:45:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780638341; cv=none; b=PAysw+zs93L7aTK9b4m5pP37aNQjMwzyq7rJ+u02qZGEb0uvK5bFIMVvSdzNFqNiZCOdlJtnGReiQaN76/aZb/iyE7tASiWJrSNJat5rbri3FiY0XyYdRKYR5Pj3UhJOZ1xD0LYb8XxyawP6wSM8jKcr6SHp76kg//1bUQaFhZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780638341; c=relaxed/simple;
	bh=nwXlljI8Y6t4hxChuNBKodksxjLzP/mgZriOqiVpDf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=liRCuDnmGf50xMCj/v1Ec1+m2BB7FmV9AyROhe1YZsSAmuhvDB4V/dkfN3EtyaImTTU69xNTNXOwmVUWXwNhB9lhjslSyJIKsi5krpaKnQYUhCnguxjbavb6xrkoa6JnL1NorSDJ9nHu7SBQU8BTTtwe1ZwyQMAX+t4TFYH1jo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uu+kycIx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593121F00893;
	Fri,  5 Jun 2026 05:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780638339;
	bh=mhVtNpIY3P5HlHg06DPqLtn0RckcLp4C6pdGau2Sqv0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Uu+kycIxx/OwP3X+MW0bxkvQU4ddOXwn3XvJ7ehtVT3TKsoeCOSObRuucLETHpt5k
	 pdlTazcWxqM/rvf0VsEj6F9iXGfWD79yvmqOWbXXD3qK4rHo1aBhHk/Lg6KqoOSwJS
	 /KH227tJUhDSUda5T4B9vGDT09V7SFVSXF6uSX+HDBmBkd9Av5QPF+sDmUZaXgFMM/
	 6cKhDwlHOBYRPdbkwf8VLc8FFqlK8PMTNpWTshOJ/dBtdWtERGC0abLZ9Fx6NGIXM3
	 ilTMDOT3piuhx356QjyJfh3GekndYg4p4r+HuBlK6LBYMRAddiO76Flw4lnODF5BLy
	 KovD8fMcDvSmQ==
Message-ID: <0198cf7c-ba09-47e9-abc3-dd230c1183dc@kernel.org>
Date: Fri, 5 Jun 2026 14:45:28 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net: skb: isolate skb data area allocations into a
 separate bucket
To: Pedro Falcato <pfalcato@suse.de>
Cc: Vlastimil Babka <vbabka@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-hardening@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hao Li <hao.li@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Simon Horman <horms@kernel.org>,
 Jason Xing <kerneljasonxing@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>
References: <20260602183122.747759-1-pfalcato@suse.de>
 <20260602183122.747759-3-pfalcato@suse.de>
 <6d70757a-a849-4828-89e7-f3d51bf8c9f8@kernel.org>
 <aiHIQ4ZxnMSifhmi@pedro-suse>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <aiHIQ4ZxnMSifhmi@pedro-suse>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------997bZ7rcMfhtcga6qMSb40eN"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-295635-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pfalcato@suse.de,m:vbabka@kernel.org,m:akpm@linux-foundation.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-hardening@vger.kernel.org,m:linux-mm@kvack.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:horms@kernel.org,m:kerneljasonxing@gmail.com,m:kuniyu@google.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[harry@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,davemloft.net,google.com,redhat.com,vger.kernel.org,kvack.org,linux.dev,gentwo.org,gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 43F7F6454B0

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------997bZ7rcMfhtcga6qMSb40eN
Content-Type: multipart/mixed; boundary="------------n0FZEuI5Zztetg5lfgI5QZI8";
 protected-headers="v1"
From: Harry Yoo <harry@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Vlastimil Babka <vbabka@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-hardening@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hao Li <hao.li@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Simon Horman <horms@kernel.org>,
 Jason Xing <kerneljasonxing@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>
Message-ID: <0198cf7c-ba09-47e9-abc3-dd230c1183dc@kernel.org>
Subject: Re: [PATCH 2/2] net: skb: isolate skb data area allocations into a
 separate bucket
References: <20260602183122.747759-1-pfalcato@suse.de>
 <20260602183122.747759-3-pfalcato@suse.de>
 <6d70757a-a849-4828-89e7-f3d51bf8c9f8@kernel.org>
 <aiHIQ4ZxnMSifhmi@pedro-suse>
In-Reply-To: <aiHIQ4ZxnMSifhmi@pedro-suse>

--------------n0FZEuI5Zztetg5lfgI5QZI8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/5/26 4:12 AM, Pedro Falcato wrote:
> On Thu, Jun 04, 2026 at 02:30:34PM +0900, Harry Yoo wrote:
>>
>>
>> On 6/3/26 3:31 AM, Pedro Falcato wrote:
>>> SKB data area allocations (as done from alloc_skb()) use kmalloc().
>>> These allocations can be variably sized and their contents can be mor=
e
>>> or less controlled from userspace, which makes them useful for attack=
ers
>>> that want to overwrite a use-after-free'd object from the same kmallo=
c slab
>>> (which often just requires the sizes to roughly match into the same k=
malloc
>>> bucket). [0] is an easy example of an exploit that uses netlink skb
>>> allocation to target another similarly-sized accidentally freed objec=
t.
>>>
>>> While other mitigations like CONFIG_RANDOM_KMALLOC_CACHES exist, thes=
e are
>>> probabilistic. Use the existing kmem buckets API to further isolate t=
hese
>>> allocations in a guaranteed fashion, when CONFIG_SLAB_BUCKETS=3Dy.
>>>
>>> Link: https://github.com/google/security-research/blob/master/pocs/li=
nux/kernelctf/CVE-2023-4207_lts_cos_mitigation_2/docs/exploit.md [0]
>>> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
>>> ---
>>>  net/core/skbuff.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>>> index 44a7f8401468..1f6c6b531ece 100644
>>> --- a/net/core/skbuff.c
>>> +++ b/net/core/skbuff.c
>>> @@ -594,6 +594,8 @@ static void *kmalloc_pfmemalloc(size_t obj_size, =
gfp_t flags, int node)
>>>  	return kmalloc_node_track_caller(obj_size, flags, node);
>>>  }
>>> =20
>>> +static kmem_buckets *skb_data_buckets __ro_after_init;
>>> +
>>>  /*
>>>   * kmalloc_reserve is a wrapper around kmalloc_node_track_caller tha=
t tells
>>>   * the caller if emergency pfmemalloc reserves are being used. If it=
 is and
>>> @@ -632,7 +634,7 @@ static void *kmalloc_reserve(unsigned int *size, =
gfp_t flags, int node,
>>>  	 * Try a regular allocation, when that fails and we're not entitled=

>>>  	 * to the reserves, fail.
>>>  	 */
>>> -	obj =3D kmalloc_node_track_caller(obj_size,
>>> +	obj =3D kmem_buckets_alloc_node_track_caller(skb_data_buckets, obj_=
size,
>>>  					flags | __GFP_NOMEMALLOC | __GFP_NOWARN,
>>>  					node);
>>>  	if (likely(obj))
>>
>> What about kmalloc_pfmemalloc()?
>=20
> Good point, that looks free as well.
>=20
> Sidenote: isolating kmem_cache_alloc for possibly-aliasing caches could=
 also
> be useful. skb allocation has net_hotdata.skb_small_head_cache. It does=
n't merge
> with anything for $raisins (odd size, plus I don't think usercopy cache=
s are
> getting merged?) but it feels too... accidental?

Right, we never merge caches with useroffset/usersize.

Hmm...

/* SKB_SMALL_HEAD_CACHE_SIZE is the size used for the skbuff_small_head
 * kmem_cache. The non-power-of-2 padding is kept for historical reasons =
and
 * to avoid potential collisions with generic kmalloc bucket sizes.
 */
#define SKB_SMALL_HEAD_CACHE_SIZE					\
	(is_power_of_2(SKB_SMALL_HEAD_SIZE) ?			\
		(SKB_SMALL_HEAD_SIZE + L1_CACHE_BYTES) :	\
		SKB_SMALL_HEAD_SIZE)


What are "historical reasons" other than avoiding collisions with
kmalloc caches?

> Maybe passing something like SLAB_NO_MERGE and making the size
> standard-looking would be nice. I have a size of 704 bytes per object, =
and
> this probably causes some weird wastage for each slab.

Yes, unless the "historical reasons" do not make it infeasible to do that=
=2E

And I wonder if net/core/skbuff.c intends to always prevent merging, or
only with hardening configs like SLAB_BUCKETS.

--=20
Cheers,
Harry / Hyeonggon


--------------n0FZEuI5Zztetg5lfgI5QZI8--

--------------997bZ7rcMfhtcga6qMSb40eN
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCaiJieAAKCRCGXBN6rc5S
1vqiAQCwzNxsZCILMai81ko92snBjCKgniuSar5HpR5PyzdzLQEAgghVBLPZo6us
vlmp+GMB8t+jxEqUqiKgV0KKMxhigg0=
=p8Ku
-----END PGP SIGNATURE-----

--------------997bZ7rcMfhtcga6qMSb40eN--

