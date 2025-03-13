Return-Path: <netdev+bounces-174621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 853DEA5F8EC
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 15:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E71E53B0622
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 14:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28337267AF6;
	Thu, 13 Mar 2025 14:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="QJcqiFKa"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C031F130F
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 14:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741877305; cv=none; b=mgNtGlN5wELE1hA7/FNaHZOt438771D6yonJgRvgv/bJVUKjnjRnb7B5byYXRA8cI3DdZV4vqAXu8WBQnMJlhVBkBd5KWT4aUgui/sL+R+f9pPmRrkjZ3diZ3xe6IB7+6tE1lAlM/W9aL8YBQZHu12EFoXK7mLHDSB3iRFpHC2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741877305; c=relaxed/simple;
	bh=PFpj0fvRfpH7WYvbktlQJLTawiFbOaORNFQp94uQFcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LUYDYon/dCxTKH4seZBirgC/zIEHzPJmvqnNsBuYgMNmfs5tvWg+q18rT9/x6AgLQckgIx4DnhYdy7pb6cw24khx9T5qwYHqf85eJSAd52JaAkTmw2f6jlGFnjxVpW+TqArxe3dmdktvJaIM9R5nVXXqQMTgC57GOtMHJc59SOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=QJcqiFKa; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [10.206.8.177] (unknown [89.164.90.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id EEF2E200EED2;
	Thu, 13 Mar 2025 15:48:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be EEF2E200EED2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1741877301;
	bh=bbp1xUvyocW4KzwXVBbqrxeWwx5lrA6wSiqRAQYTHKs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QJcqiFKa1TKNnQ2duCxyxjnkNOpR4N+JA+r+yk/8pgU+1o3CE+NOi5vMAO8rxLXZh
	 HqbcBXGaNalP0y7vcKH2Z5GYoPCEttRzohSZzb8PP6tz+mBvJiVZsS6730VDoy6XtP
	 Yqz6mYxBPRB4lhnCQhKlttYZx52zo8TsNppHSwbctsGvKvt0PnxqXOfPHeX/kqwU1n
	 iHrixpjcXN0xiBhFVZQ38QfcNGH6RnIdnoqkyqh8bz2syBBf3DMu2fpNv2ljamzDH1
	 ykock00iAgJFzywGcQoyWlPrve2OQwuNE1U7PKFMi70Ir3VZlMhvA09stR9jsdnVuY
	 AdPhF5bkJWWyA==
Message-ID: <62a962f7-a91d-4338-9b18-d4073e83f814@uliege.be>
Date: Thu, 13 Mar 2025 15:48:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 5/7] net: ipv6: ila: fix lwtunnel_output() loop
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, Tom Herbert <tom@herbertland.com>,
 Ido Schimmel <idosch@nvidia.com>
References: <20250311141238.19862-1-justin.iurman@uliege.be>
 <20250311141238.19862-6-justin.iurman@uliege.be>
 <de0104f3-2a2c-44ee-a3e9-8acc927cbfc6@redhat.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <de0104f3-2a2c-44ee-a3e9-8acc927cbfc6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/13/25 13:46, Paolo Abeni wrote:
> On 3/11/25 3:12 PM, Justin Iurman wrote:
>> diff --git a/net/ipv6/ila/ila_lwt.c b/net/ipv6/ila/ila_lwt.c
>> index 7d574f5132e2..67f7c7015693 100644
>> --- a/net/ipv6/ila/ila_lwt.c
>> +++ b/net/ipv6/ila/ila_lwt.c
>> @@ -96,6 +96,14 @@ static int ila_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>>   		}
>>   	}
>>   
>> +	/* avoid lwtunnel_output() reentry loop when destination is the same
>> +	 * after transformation
>> +	 */
>> +	if (orig_dst->lwtstate == dst->lwtstate) {
>> +		dst_release(dst);
>> +		return orig_dst->lwtstate->orig_output(net, sk, skb);
>> +	}
>> +
>>   	skb_dst_drop(skb);
>>   	skb_dst_set(skb, dst);
>>   	return dst_output(net, sk, skb);
> 
> Even this pattern is repeated verbatim in patch 3, and I think it should
> deserve a shared helper. Also a bit of a pity there are a few variations

+1 as well. However, same remark applies here: this patch (and some 
others) will be removed from this series in -v2.

> that do not fit cleanly a common helper, but I guess there is little to
> do about that for 'net'.

Indeed...

> Thanks,
> 
> Paolo
> 

