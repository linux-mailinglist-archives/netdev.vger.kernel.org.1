Return-Path: <netdev+bounces-174616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9F5A5F8D3
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 15:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 426643A7B20
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 14:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46B786337;
	Thu, 13 Mar 2025 14:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="tnO8Jh4T"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060DB267731
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741877167; cv=none; b=BwHS3Ozm5aUw8aniNrnPAyQNMWW+YCnc13mt9L8hdMDPm/B2h/m9GtfPI6D32IXGRlShgf6MSla8km0fGzV/RyzuApoS4+Lsc9lc/aejMHEoa3mx1fY1Mj/L5OPJw2LqIKpzmSHVk7QgTazmaVhgqIlxCeopG7wCs1SIKVyyhxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741877167; c=relaxed/simple;
	bh=Ab8e9jCFXUDUEDUY9Yrgqt3TKhGiRMskSWxrrP/1gmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ldYApGtEXuS5ZlD7E4SA7NnTkGakBXVNjzthSkXfhH0PN/h1SYb3ZNoL/dxqJFBqH8L8YYgBOBGK6QLCbueLwLUnqv1p16mzWBxLOKzWSidSIc0EUlXTR835fENpD/gS/kfg4DaLtQlUNMpRB2H+JiTTXbdrObU5vluB9wMUh/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=tnO8Jh4T; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [10.206.8.177] (unknown [89.164.90.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id ACBD5200EED5;
	Thu, 13 Mar 2025 15:45:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be ACBD5200EED5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1741877156;
	bh=CaYCmvjcHBso8F5nUxZ8PSHUAb0OaIyVEaxOdhAdHoY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tnO8Jh4TQ94EwB/q6LoSi+8M+lok4Waxl/0dFaoord2Zn6gziQ97xyY0UMF7J4Lc3
	 CZFLZ1XnN7lmVENYGfYZo6CoW21Wy5MLw9lAPa1vP/GAVgG5NwTsTx4itGsNEAMZIF
	 ZMeoJsgsWb87B/q2hQMFZQva9Pvkl/zHq9TPR+/1tbJKYa6mfpdkY22Kt2CeuiNYsk
	 6bSlxQqfnEmXvLqpItuMKksHz7RIdMouGfCOkbw/oVUm0H7vSX04jBch5sBWy7nQNX
	 7jy1PFgzfl3u9ao7OPgRauPuINQuK3skwGNqGrxCYGEx+VYO8rsdD/CW3IIOP0XYu+
	 PtmIF511/qbNA==
Message-ID: <641c2376-8e58-42d5-a934-acad5782b9f0@uliege.be>
Date: Thu, 13 Mar 2025 15:45:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/7] net: ipv6: seg6_local: fix lwtunnel_input() loop
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, David Lebrun <dlebrun@google.com>,
 Andrea Mayer <andrea.mayer@uniroma2.it>,
 Stefano Salsano <stefano.salsano@uniroma2.it>,
 Ahmed Abdelsalam <ahabdels.dev@gmail.com>,
 Mathieu Xhonneux <m.xhonneux@gmail.com>, Ido Schimmel <idosch@nvidia.com>
References: <20250311141238.19862-1-justin.iurman@uliege.be>
 <20250311141238.19862-5-justin.iurman@uliege.be>
 <183561ba-a6e1-4036-9555-d773c14d14bb@redhat.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <183561ba-a6e1-4036-9555-d773c14d14bb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/13/25 13:40, Paolo Abeni wrote:
> On 3/11/25 3:12 PM, Justin Iurman wrote:
>> ---
>>   net/ipv6/seg6_local.c | 85 +++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 81 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
>> index ac1dbd492c22..15485010cdfb 100644
>> --- a/net/ipv6/seg6_local.c
>> +++ b/net/ipv6/seg6_local.c
>> @@ -378,8 +378,16 @@ static void seg6_next_csid_advance_arg(struct in6_addr *addr,
>>   static int input_action_end_finish(struct sk_buff *skb,
>>   				   struct seg6_local_lwt *slwt)
>>   {
>> +	struct lwtunnel_state *lwtst = skb_dst(skb)->lwtstate;
>> +
>>   	seg6_lookup_nexthop(skb, NULL, 0);
>>   
>> +	/* avoid lwtunnel_input() reentry loop when destination is the same
>> +	 * after transformation
>> +	 */
>> +	if (lwtst == skb_dst(skb)->lwtstate)
>> +		return lwtst->orig_input(skb);
>> +
>>   	return dst_input(skb);
> 
> The above few lines are repeted a lot of times below. Please factor them
> out in an helper and re-use it.

+1, although this patch (and some others) will be removed from the 
series in -v2. That said, Paolo's remark may be applied to Andrea's 
seg6-related patches that will follow.

> Thanks,
> 
> Paolo
> 

