Return-Path: <netdev+bounces-305816-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MpD6J1VRTmqhKgIAu9opvQ
	(envelope-from <netdev+bounces-305816-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 15:32:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF046726D27
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 15:32:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="gq/dzTHH";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305816-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305816-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBB7C302D95C
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 13:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468D4340418;
	Wed,  8 Jul 2026 13:28:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B676F33F591;
	Wed,  8 Jul 2026 13:28:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783517283; cv=none; b=NmslI3uw5VItdsyn8mb1DfSM4g7zilOu9V85zlCpz6I7LzxBxqKDayBCWalEv4/P3AhV6GXFWiTONB9IdEznUzZcf//oMXgfnvD7uN6dyhNVHjvsTuRsZjdg7oh0uXZTwN8O2DVssRpWsLXyK/xb1hqi7ng8lYO+pW1IszE9dXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783517283; c=relaxed/simple;
	bh=QJ95qpiXZBu+4cDMaEogfSFwkcealgcdhFrXZnWHJGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DqXWxefu+jzSrf+i+BrtAirD3yJl1sayXS47Xd3BB7Wii++RMn2SXl45BEmDXButrODF3B0KwF1OLv7Ak7L3/bVKkqE5zDILTz2wljNXYPUkvEgWPAe04tapXM1HxDgf0EwEqsYSzery3YHNYDFIeMSb8r6amhuGo3lLfhDZHkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gq/dzTHH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD841F000E9;
	Wed,  8 Jul 2026 13:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783517279;
	bh=JZznSW1QxIA8YchHXYmBD7rqYjeBEHt8iCwtpCrWKE8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gq/dzTHHIPOEXl71Cphk3JscbEHk9Wo5plPjKBq+bmWbIWK56ZMHaxIrTY3KFY+HQ
	 A1X6ZaAvKvBP98O74jcXyYY1Jt17sg8z4ahhyBZ4hBhGUvrx3QnsUatXAl0GvrY2mA
	 BQf1+UYkt3LNEoOJEM5TKj9Yytsovd6h5eND+lOXK70SSQp/hlpBIIeP8jBz0DTn/K
	 bLJ5UDpxgmx4+LBs1R25AYDzr28o8DwJAlBFiH4+Tpe6HcMfRVhys5r4+jkmqXQj+d
	 jlcBzXBiitML/4/D1WNM/YlayTkznXQR0XwkZw4evyIWfphPLUZmYlJF0mYzNB5+Cx
	 JW+BxXzgtWlzQ==
Message-ID: <529e3997-d26f-4d8e-ad90-3329fe90e555@kernel.org>
Date: Wed, 8 Jul 2026 22:27:54 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: skb: isolate skb data area allocations
 into a separate bucket
To: Pedro Falcato <pfalcato@suse.de>, Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 Kees Cook <kees@kernel.org>, linux-mm@kvack.org,
 Vlastimil Babka <vbabka@kernel.org>
References: <20260702170728.168755-1-pfalcato@suse.de>
 <04debe19-bbe8-4b5f-9668-753d1f97832d@redhat.com>
 <ak4w2k4Woj55E0On@pedro-suse>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <ak4w2k4Woj55E0On@pedro-suse>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305816-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pfalcato@suse.de,m:pabeni@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:horms@kernel.org,m:kerneljasonxing@gmail.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:kees@kernel.org,m:linux-mm@kvack.org,m:vbabka@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[harry@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,gmail.com,vger.kernel.org,kvack.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF046726D27



On 7/8/26 8:16 PM, Pedro Falcato wrote:
> On Wed, Jul 08, 2026 at 10:30:50AM +0200, Paolo Abeni wrote:
>> On 7/2/26 7:07 PM, Pedro Falcato wrote:> @@ -586,6 +586,8 @@ struct
>> sk_buff *napi_build_skb(void *data, unsigned int frag_size)
>>>  }
>>>  EXPORT_SYMBOL(napi_build_skb);
>>>  
>>> +static kmem_buckets *skb_data_buckets __ro_after_init;
>>> +
>>>  static void *kmalloc_pfmemalloc(size_t obj_size, gfp_t flags, int node)
>>>  {
>>>  	if (!gfp_pfmemalloc_allowed(flags))
>>> @@ -593,7 +595,8 @@ static void *kmalloc_pfmemalloc(size_t obj_size, gfp_t flags, int node)
>>>  	if (!obj_size)
>>>  		return kmem_cache_alloc_node(net_hotdata.skb_small_head_cache,
>>>  					     flags, node);
>>> -	return kmalloc_node_track_caller(obj_size, flags, node);
>>> +	return kmem_buckets_alloc_node_track_caller(skb_data_buckets, obj_size,
>>> +						    flags, node);
>>
>> Sashiko noted that some drivers may require GFP_DMA buckets, and the
>> above may break them:
>>
>> https://sashiko.dev/#/patchset/20260702170728.168755-1-pfalcato%40suse.de
> 
> Oh, this is really awkward. Adding linux-mm and slab maintainers for input here.
> 
> Considering the current slab bucketing does not seem to duplicate DMA or
> CGROUP caches, could it make sense to duplicate those as well?

Could we specify what kmalloc types the user needs when creating
kmem_buckets and duplicate caches for the requested kmalloc types only?

> Otherwise we could add a branch like:
>
> if (gfp_flags & __GFP_DMA)
> 	/* use the global dma kmalloc caches */

-- 
Cheers,
Harry / Hyeonggon

