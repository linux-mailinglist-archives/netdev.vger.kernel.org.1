Return-Path: <netdev+bounces-119408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE099557EF
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 14:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FB471C21163
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 12:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D8E14A635;
	Sat, 17 Aug 2024 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="IiWib+Gc"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (unknown [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88189FBF0;
	Sat, 17 Aug 2024 12:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723899507; cv=none; b=bmxRMAuEd0MvzaG+kjX25ggehfqSmEKDUjHNn1wpvZQ48TVuXdaqj6CNRcqEOqyIhXQUvP/xDtbeIO5wz/O62VKeXaCixkFvcGMtKTkZhIAw02w1DVT8QtLHKDdwMhRCcoX2KSBBq8v5vOpdcxkLn8tRm/HRmdR+ruBIEv8nDPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723899507; c=relaxed/simple;
	bh=+zS8WerxhtVJBU5wqHuJfYjSCejMiLZcr2q0Ac1CAX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FwQqkYDT6mMeR0zgwvklRJ/+JkCGcFI9HZjC//z3TXvyCNS3FpdFOwsU5CXmc3fpANUc4ANC1G71whHUydra/2CzE1gJ3RDIWLdko96cneJyW2QeacgV7mMgR4xR4D7ak5CKY+d+tohksf36l/kvdBNiC1oHYhZ3tuareTn5HdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=IiWib+Gc; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.58] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 4FB6C200C968;
	Sat, 17 Aug 2024 14:57:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 4FB6C200C968
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1723899459;
	bh=YiXaWCfprfDbXglaXn/w+Y2EgI0WDsXW5xCeYuJ5Oto=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IiWib+Gc0zhJ30t+98bFj7KrSDl+uINS1jAaE8MwGbFZLYsEtgK/yc3XocszCJQdH
	 AfJ2502YA1gtkUPiHgTCcdGJk0GSoigT+5WMPL5GCejWzn2xC1+2Nb/4CSBQFvtv1F
	 spY/QSZ5JW5D4CxVd0kduQXoEOEZsHAtFBkRYLU6xOR67iBu5L1R23QSeyAVaBnotY
	 33LV2pvWskeUYQD12/OhaIOLAzYYptZLUVwFovbU9zLyXTkCO2THMTlaU8VaBhlddk
	 OcSM23RltQziFSgxtGl7wdFBjtYll6FsxDj/7hUVG8+Hl9I9FJhwofEMvtwSid8OTo
	 o1zydn70tOY2g==
Message-ID: <47b13aef-29bb-46e6-92bc-8fd24391b05a@uliege.be>
Date: Sat, 17 Aug 2024 14:57:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net: ipv6: ioam6: new feature tunsrc
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 justin.iurman@uliege.be
References: <20240813122723.22169-1-justin.iurman@uliege.be>
 <20240813122723.22169-3-justin.iurman@uliege.be>
 <20240816103558.16502b74@kernel.org>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <20240816103558.16502b74@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/16/24 19:35, Jakub Kicinski wrote:
> On Tue, 13 Aug 2024 14:27:23 +0200 Justin Iurman wrote:
>> This patch provides a new feature (i.e., "tunsrc") for the tunnel (i.e.,
>> "encap") mode of ioam6. Just like seg6 already does, except it is
>> attached to a route. The "tunsrc" is optional: when not provided (by
>> default), the automatic resolution is applied. Using "tunsrc" when
>> possible has a benefit: performance. See the comparison:
>>   - before (= "encap" mode): https://ibb.co/bNCzvf7
>>   - after (= "encap" mode with "tunsrc"): https://ibb.co/PT8L6yq
> 
> No need to extend the selftests ?

Hi Jakub,

I've been wondering too... Currently, it doesn't check the IPv6 header 
and only focuses on the IOAM header+data. So I came to the conclusion 
that the selftests should not necessarily be updated for that. Although 
I'm not closing the door to a future update to include some extra IPv6 
header checks. I just think it's not required *now* and in this series.

I'll post -v3 to address your comments below (thanks, by the way!).

Cheers,
Justin

>> diff --git a/include/uapi/linux/ioam6_iptunnel.h b/include/uapi/linux/ioam6_iptunnel.h
>> index 38f6a8fdfd34..6cdbd0da7ad8 100644
>> --- a/include/uapi/linux/ioam6_iptunnel.h
>> +++ b/include/uapi/linux/ioam6_iptunnel.h
>> @@ -50,6 +50,13 @@ enum {
>>   	IOAM6_IPTUNNEL_FREQ_K,		/* u32 */
>>   	IOAM6_IPTUNNEL_FREQ_N,		/* u32 */
>>   
>> +	/* Tunnel src address.
>> +	 * For encap,auto modes.
>> +	 * Optional (automatic if
>> +	 * not provided).
> 
> The wrapping of this text appears excessive
> 
>> +	 */
>> +	IOAM6_IPTUNNEL_SRC,		/* struct in6_addr */
>> +
>>   	__IOAM6_IPTUNNEL_MAX,
>>   };
> 
>> @@ -178,6 +186,23 @@ static int ioam6_build_state(struct net *net, struct nlattr *nla,
>>   	ilwt->freq.n = freq_n;
>>   
>>   	ilwt->mode = mode;
>> +
>> +	if (!tb[IOAM6_IPTUNNEL_SRC]) {
>> +		ilwt->has_tunsrc = false;
>> +	} else {
>> +		ilwt->has_tunsrc = true;
>> +		ilwt->tunsrc = nla_get_in6_addr(tb[IOAM6_IPTUNNEL_SRC]);
>> +
>> +		if (ipv6_addr_any(&ilwt->tunsrc)) {
>> +			dst_cache_destroy(&ilwt->cache);
>> +			kfree(lwt);
> 
> Let's put the cleanup at the end of the function, and use a goto / label
> to jump there.
> 
>> +			NL_SET_ERR_MSG_ATTR(extack, tb[IOAM6_IPTUNNEL_SRC],
>> +					    "invalid tunnel source address");
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>>   	if (tb[IOAM6_IPTUNNEL_DST])
>>   		ilwt->tundst = nla_get_in6_addr(tb[IOAM6_IPTUNNEL_DST]);
>>   
>> @@ -257,6 +282,8 @@ static int ioam6_do_inline(struct net *net, struct sk_buff *skb,
>>   
>>   static int ioam6_do_encap(struct net *net, struct sk_buff *skb,
>>   			  struct ioam6_lwt_encap *tuninfo,
>> +			  bool has_tunsrc,
>> +			  struct in6_addr *tunsrc,
>>   			  struct in6_addr *tundst)
>>   {
>>   	struct dst_entry *dst = skb_dst(skb);
>> @@ -286,8 +313,13 @@ static int ioam6_do_encap(struct net *net, struct sk_buff *skb,
>>   	hdr->nexthdr = NEXTHDR_HOP;
>>   	hdr->payload_len = cpu_to_be16(skb->len - sizeof(*hdr));
>>   	hdr->daddr = *tundst;
>> -	ipv6_dev_get_saddr(net, dst->dev, &hdr->daddr,
>> -			   IPV6_PREFER_SRC_PUBLIC, &hdr->saddr);
>> +
>> +	if (has_tunsrc) {
>> +		memcpy(&hdr->saddr, tunsrc, sizeof(*tunsrc));
>> +	} else {
>> +		ipv6_dev_get_saddr(net, dst->dev, &hdr->daddr,
>> +				   IPV6_PREFER_SRC_PUBLIC, &hdr->saddr);
>> +	}
> 
> single statement branches, no need for {}
> 
>>   	skb_postpush_rcsum(skb, hdr, len);
>>   

