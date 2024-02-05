Return-Path: <netdev+bounces-69164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCD0849DFC
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 16:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD066288054
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 15:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977462D05D;
	Mon,  5 Feb 2024 15:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vy9I8vP6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD042D050
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 15:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707146673; cv=none; b=Mm3bmIQ8+cX1F6Ah3U6DZWuTp9mxk9CFHsb/DrlYt3X6HyV7vmsx688L+pVU2YaM8u7/QDs0h6p0A5x5UWFUMxryBmwQHYXbUZpHdDxAiHjtPG1JHAp99Gj7J/7Z38buMzDLEw9I2QOjNpV7aSVi9zKOH/aoVj8ks7+I/ht8i3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707146673; c=relaxed/simple;
	bh=r4C2bmdNSBfTawmzVlK/EPVgF7BPlDAxsu/K5myoys8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=H79RnALm+7YYLaKCQ0ojIKZctRGpvC97mS6XYsHAc1WIh4/pxv6l+RTgSSBVd4UzuKZM0FRikH6Ppk4EIBR6UPjqW4WtD5Yjdi92G/rAanDPuq22U1V58O5LoeDwNJPW41m7aGMED8xM2KWcccjcCnRxCyeTSyZl8kFnRgGZc2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vy9I8vP6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B3DC433F1;
	Mon,  5 Feb 2024 15:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707146672;
	bh=r4C2bmdNSBfTawmzVlK/EPVgF7BPlDAxsu/K5myoys8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=Vy9I8vP6WNMcN/NuIepvizclMNk6cwKuRl7z4DBCUvf3gU9k64PTAjWTRm9YWwePf
	 h4+ppurQTxePWz69iD2plzDeG+49zJpEHHQGp05INzqBPTrXac72Td1X1GR5HrwibZ
	 O2nZZQFOTUKrCxFt1S9pN0WytqT7kDv0Y1Y5NdxKDrsdrDyg/7KJqAnDsMH3l2g8XU
	 kLP9ZnCzu6P4xbwDKIk7Gnu26ksM7calKEdFS8hzr+0PeVf+vF2PC1aZZ/r4jhfNrc
	 /9pUu9iITLcqiS5EZHMktyoaFmB4CQQwMtnjOmRuJexVsRdB7SyYL5pBX9oT/Y2j/s
	 ntt4mzCNnzV6Q==
Message-ID: <6e659e99-97dd-474d-9706-76ae44dd921a@kernel.org>
Date: Mon, 5 Feb 2024 08:24:31 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/5] net/ipv6: Remove expired routes with a
 separated list of routes.
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
To: thinker.li@gmail.com, netdev@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, kernel-team@meta.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, liuhangbin@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com
References: <20240202082200.227031-1-thinker.li@gmail.com>
 <20240202082200.227031-4-thinker.li@gmail.com>
 <2ddfe75a-45e4-4499-8aae-4d83de90d1ce@kernel.org>
In-Reply-To: <2ddfe75a-45e4-4499-8aae-4d83de90d1ce@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/24 9:45 PM, David Ahern wrote:
>> @@ -1264,8 +1265,18 @@ cleanup_prefix_route(struct inet6_ifaddr *ifp, unsigned long expires,
>>  		if (del_rt)
>>  			ip6_del_rt(dev_net(ifp->idev->dev), f6i, false);
>>  		else {
>> -			if (!(f6i->fib6_flags & RTF_EXPIRES))
>> +			if (!(f6i->fib6_flags & RTF_EXPIRES)) {
>> +				table = f6i->fib6_table;
>> +				spin_lock_bh(&table->tb6_lock);
>>  				fib6_set_expires(f6i, expires);
>> +				/* If fib6_node is null, the f6i is just
>> +				 * removed from the table.
>> +				 */
>> +				if (rcu_dereference_protected(f6i->fib6_node,
> 
> ... meaning this check should not be needed

reviewing this patch again this morning, and yes, I believe this check
is needed here and other places. Given that all of the instances check
if the route entry is still in the table, it should be consolidated into
fb6_add_gc_list.

> 
>> +							      lockdep_is_held(&table->tb6_lock)))
>> +					fib6_add_gc_list(f6i);
>> +				spin_unlock_bh(&table->tb6_lock);
>> +			}
>>  			fib6_info_release(f6i);
>>  		}
>>  	}


