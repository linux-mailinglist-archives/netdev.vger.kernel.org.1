Return-Path: <netdev+bounces-146361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CAE9D3077
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 23:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F4B61F21B96
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 22:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED321D31BE;
	Tue, 19 Nov 2024 22:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="rsaoLuAa"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AC11D270C;
	Tue, 19 Nov 2024 22:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732055417; cv=none; b=rvb8MT6lUqJL0Am0s9ER98vjWSNmKiKN0zZ3x5rNkVK0YcRs1A8qSGcX5YY1mSRd6WvPAUzsaYB+yRwiQY5hvf0zxdtOHQY9s/ZL11KcgW15l76SHiL28t1G1T96cmUrJTXCqL8qX/eLYi58Ezf30XhgfMhHPjq/XQ4+hHF4y2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732055417; c=relaxed/simple;
	bh=TvMDltNMHCtD9rE4M/d+PEZcC/CkNyUA5e+c2HUcHNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YuQcIMYMukvjL1nbbvZ9XWoQQubW7K0r5bk1/1KC/6bMh15REdI6+W9v7oDuFJL8S2EfRIjWOMrekC3BSygaQcoaHgrPNA0p9wauPdv/qpSn1bS6K+greMFLxP6U7GsSZTwJLlJ9jTZ3SS31MYm4FX7qoVcvSJp5jLEbKXpB7OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=rsaoLuAa; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.17] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id A464E200CCF2;
	Tue, 19 Nov 2024 23:30:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be A464E200CCF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1732055413;
	bh=ZOdoXIASx8uMjrOMZMw9r1oaH5U7Ah3h1Lu6jKbvoDg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rsaoLuAaob6CD57aDArTQKQfr7bqCeibRUqLEzSCM7B5Mn//cRfWwZXXL2qp1oare
	 rpNEeGqOmN5Kq09U5vIAUFQv+dhhhudK+dODO9chuoHMeQLEnCYg6ocyGGzt+qupup
	 olsPeswQmze5bZ77itY5US5NX4gR3cDez7ArzDuSG38PkBXUIc2CHxw9HN0Zwnjda5
	 Ff14uvl2KPVebMi+QTsyO5rZyXZrsu3PcIQwBkrnZ7u4idl/IIYevltplYYDrMkfyM
	 QP1DFOfmcY/bklu+VSv+8/Cp8pmfKZ9gdLCPp5uogWu40lc52yuW/LaZTaqhNpvVF1
	 fvhD+ANHRWomw==
Message-ID: <e17b4ac0-2534-45c1-92fc-74305d8ead82@uliege.be>
Date: Tue, 19 Nov 2024 23:30:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 0/4] Mitigate the two-reallocations issue for
 iptunnels
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org
References: <20241119222139.14338-1-justin.iurman@uliege.be>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <20241119222139.14338-1-justin.iurman@uliege.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/24 23:21, Justin Iurman wrote:
> v5:
> - address Paolo's comments
> - s/int dst_dev_overhead()/unsigned int dst_dev_overhead()/
> v4:
> - move static inline function to include/net/dst.h
> v3:
> - fix compilation error in seg6_iptunnel
> v2:
> - add missing "static" keywords in seg6_iptunnel
> - use a static-inline function to return the dev overhead (as suggested
>    by Olek, thanks)
> 
> The same pattern is found in ioam6, rpl6, and seg6. Basically, it first
> makes sure there is enough room for inserting a new header:
> 
> (1) err = skb_cow_head(skb, len + skb->mac_len);
> 
> Then, when the insertion (encap or inline) is performed, the input and
> output handlers respectively make sure there is enough room for layer 2:
> 
> (2) err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
> 
> skb_cow_head() does nothing when there is enough room. Otherwise, it
> reallocates more room, which depends on the architecture. Briefly,
> skb_cow_head() calls __skb_cow() which then calls pskb_expand_head() as
> follows:
> 
> pskb_expand_head(skb, ALIGN(delta, NET_SKB_PAD), 0, GFP_ATOMIC);
> 
> "delta" represents the number of bytes to be added. This value is
> aligned with NET_SKB_PAD, which is defined as follows:
> 
> NET_SKB_PAD = max(32, L1_CACHE_BYTES)
> 
> ... where L1_CACHE_BYTES also depends on the architecture. In our case
> (x86), it is defined as follows:
> 
> L1_CACHE_BYTES = (1 << CONFIG_X86_L1_CACHE_SHIFT)
> 
> ... where (again, in our case) CONFIG_X86_L1_CACHE_SHIFT equals 6
> (=X86_GENERIC).
> 
> All this to say, skb_cow_head() would reallocate to the next multiple of
> NET_SKB_PAD (in our case a 64-byte multiple) when there is not enough
> room.
> 
> Back to the main issue with the pattern: in some cases, two
> reallocations are triggered, resulting in a performance drop (i.e.,
> lines (1) and (2) would both trigger an implicit reallocation). How's
> that possible? Well, this is kind of bad luck as we hit an exact
> NET_SKB_PAD boundary and when skb->mac_len (=14) is smaller than
> LL_RESERVED_SPACE(dst->dev) (=16 in our case). For an x86 arch, it
> happens in the following cases (with the default needed_headroom):
> 
> - ioam6:
>   - (inline mode) pre-allocated data trace of 236 or 240 bytes
>   - (encap mode) pre-allocated data trace of 196 or 200 bytes
> - seg6:
>   - (encap mode) for 13, 17, 21, 25, 29, 33, ...(+4)... prefixes
> 
> Let's illustrate the problem, i.e., when we fall on the exact
> NET_SKB_PAD boundary. In the case of ioam6, for the above problematic
> values, the total overhead is 256 bytes for both modes. Based on line
> (1), skb->mac_len (=14) is added, therefore passing 270 bytes to
> skb_cow_head(). At that moment, the headroom has 206 bytes available (in
> our case). Since 270 > 206, skb_cow_head() performs a reallocation and
> the new headroom is now 206 + 64 (NET_SKB_PAD) = 270. Which is exactly
> the room we needed. After the insertion, the headroom has 0 byte
> available. But, there's line (2) where 16 bytes are still needed. Which,
> again, triggers another reallocation.
> 
> The same logic is applied to seg6 (although it does not happen with the
> inline mode, i.e., -40 bytes). It happens with other L1 cache shifts too
> (the larger the cache shift, the less often it happens). For example,
> with a +32 cache shift (instead of +64), the following number of
> segments would trigger two reallocations: 11, 15, 19, ... With a +128
> cache shift, the following number of segments would trigger two
> reallocations: 17, 25, 33, ... And so on and so forth. Note that it is
> the same for both the "encap" and "l2encap" modes. For the "encap.red"
> and "l2encap.red" modes, it is the same logic but with "segs+1" (e.g.,
> 14, 18, 22, 26, etc for a +64 cache shift). Note also that it may happen
> with rpl6 (based on some calculations), although it did not in our case.
> 
> This series provides a solution to mitigate the aforementioned issue for
> ioam6, seg6, and rpl6. It provides the dst_entry (in the cache) to
> skb_cow_head() **before** the insertion (line (1)). As a result, the
> very first iteration would still trigger two reallocations (i.e., empty
> cache), while next iterations would only trigger a single reallocation.
> 
> Justin Iurman (4):
>    include: net: add static inline dst_dev_overhead() to dst.h
>    net: ipv6: ioam6_iptunnel: mitigate 2-realloc issue
>    net: ipv6: seg6_iptunnel: mitigate 2-realloc issue
>    net: ipv6: rpl_iptunnel: mitigate 2-realloc issue
> 
>   include/net/dst.h         |  9 +++++
>   net/ipv6/ioam6_iptunnel.c | 73 ++++++++++++++++-----------------
>   net/ipv6/rpl_iptunnel.c   | 46 +++++++++++----------
>   net/ipv6/seg6_iptunnel.c  | 85 ++++++++++++++++++++++++---------------
>   4 files changed, 123 insertions(+), 90 deletions(-)
> 

Sorry, I just noticed I missed net-next window. Will resubmit when it 
reopens.

