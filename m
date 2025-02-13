Return-Path: <netdev+bounces-166226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E69A3515D
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 23:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCCFA7A3018
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 22:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A603E26FA42;
	Thu, 13 Feb 2025 22:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="rprNtDmp"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9950326E17C
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 22:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739486254; cv=none; b=WbxDiOq50PuDUtwk8K0SP7zjgeN8YDA4LWWMTW6MVzUvIdrfng1uzFQZmnakB3uU4cQXeEOmaO/o0bDwUQT4LZfFifVtF7g9wLMcL6QqfDmGZIvqGIh37SCuBZQb6QCIn48zskxWfFCqxzB3vl+FClyC5cPnvrGGGD8y/RMfOgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739486254; c=relaxed/simple;
	bh=qAoeKkhQSdbWDIWjjaPi9KjYrCuuqVM9YsLH+hvOVJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MXPIsUFGNJhFifsA8B7mGjjH2KN3Xf61tWQgEfFMoh+jSa7cEveKGnLjhzBUNIM22gdQ5HTxlxcsqT7kF06x1BmWI4px6C5t8pI7BWpzf59P+iiglZks6GIuV3OB6DrR/8YgzpuMoPeNYtlam9e3JKhwxGPIjxEKGQfqW/3mN5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=rprNtDmp; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [10.136.6.34] (unknown [213.221.151.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 4E50A200DFB0;
	Thu, 13 Feb 2025 23:37:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 4E50A200DFB0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1739486244;
	bh=iyM/1pSthidrZcSneEnlJNKpNrcKnRvY0kbzUvhcQBI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rprNtDmpy0K+nGHTLwxtcFK0CSqwTV6lJznVWoLcxiWVboTsCYhfdC0w2WDCNCndT
	 VzFOXHJYiAjSiC7afTHIRRRhvXgPUzexCtxL6A5cq/epeP+b2EZCrjkgUOLLoKmFiz
	 6CQ0mE3uINkLrkdUDHytTfTIrT+nK89R/9uKwH1gbJcbDKzVXI7+M6adcwG2RmQLmR
	 dL1W532fJAUShlvcX7ItDzl6JI/omGm+ZYx1X0dNx0gmsScmYqvJeEUt5fR2r7wBhk
	 oPv+SumAAXuwmScWfKlyQ+/o/oP9XiNNXP+gi5fS/DquDclD6iBCKXZqc7GCURaXJ/
	 edcTowYSBjjLA==
Message-ID: <a03f54be-b558-4964-8e40-b5f2bb8e7158@uliege.be>
Date: Thu, 13 Feb 2025 23:37:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/3] net: ipv6: fix dst ref loops on input in rpl
 and seg6 lwtunnels
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 Alexander Aring <alex.aring@gmail.com>, David Lebrun <dlebrun@google.com>
References: <20250211221624.18435-1-justin.iurman@uliege.be>
 <20250211221624.18435-2-justin.iurman@uliege.be> <Z63lQiyiNoQkgJFk@shredder>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <Z63lQiyiNoQkgJFk@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/13/25 13:27, Ido Schimmel wrote:
> On Tue, Feb 11, 2025 at 11:16:22PM +0100, Justin Iurman wrote:
>> As a follow up to commit 92191dd10730 ("net: ipv6: fix dst ref loops in
>> rpl, seg6 and ioam6 lwtunnels"), we also need a conditional dst cache on
>> input for seg6_iptunnel and rpl_iptunnel to prevent dst ref loops (i.e.,
>> if the packet destination did not change, we may end up recording a
>> reference to the lwtunnel in its own cache, and the lwtunnel state will
>> never be freed).
>>
>> Fixes: a7a29f9c361f ("net: ipv6: add rpl sr tunnel")
>> Fixes: af4a2209b134 ("ipv6: sr: use dst_cache in seg6_input")
>> Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
>> Cc: Alexander Aring <alex.aring@gmail.com>
>> Cc: David Lebrun <dlebrun@google.com>
> 
> Not an expert but was asked to take a look. Seems consistent with the
> output path and comparing the state address seems safe as it is only
> compared and never dereferenced after dropping the dst in the input
> path.
> 
> I would have probably split it into two patches to make it a bit easier
> to backport. 5.4.y needs the seg6 fix, but not the rpl one.
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Thanks Ido. I'll split it in two for v3.

