Return-Path: <netdev+bounces-139239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 722CA9B117C
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 23:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3719B225BB
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 21:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A839213124;
	Fri, 25 Oct 2024 21:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="vV9hKXVF"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1706213120;
	Fri, 25 Oct 2024 21:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729890402; cv=none; b=nlwHH0rdFA2Y4YC3Dnwi0OmCBbck19C4AcRx6VUb8woZ28kuxhFop5FdKzrC8OnW4jy5S7bimnfu6PB2p4v+3VC4Ime4XhVwKrHIpHtNPYEHg9m3VfQEFDVVsyKQ8EMdTij63fGH/EZ3yQHAL8LAqyelksqwmrQxg/vAmxvFYYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729890402; c=relaxed/simple;
	bh=pqNdeGqpS3ELJrftLu6CbADN4Yt/eviDgPqQ891h5Fs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tHKo9xuQ3rHETKj9DLmeBkpwoo0ritle7dKzCacXZ7jBe7nM4fhtB14qjTj/Mi5QKS6crL3G2WpAdz8ItDTNXfbxnctr0OPUSAHzemH9wWB0FD1AMpKWRDuMAtxHs/W13zDy4Z7wyPvmjlMAeztZuHpk1iypI0cCN2N+gh0LBP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=vV9hKXVF; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.58] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id E5CAF200F487;
	Fri, 25 Oct 2024 23:06:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be E5CAF200F487
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1729890397;
	bh=o9yNod9FcRqEk/LV8Ey+bAHerVAR7xSMn0rxDJz6Na0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vV9hKXVFz9ut42jGdcVedjr1G3AAGvkvIm4b8q4izH8/0p76RfijBnuCutNvIsgZ4
	 4NhqBpOG6USBege9j6n8hQPIEfgPrUqETQfVVKMc391k8meW1+/7QznQBElFzayQNO
	 xemuzEITNXY6qV+T92Tz0AILaoNS6r7A/Mbm9WTCKuDVuBwl9R+R11nLsLpMa18yHZ
	 KFUspj43xIomAK+2DBnL1vXLgpmLduB4Sv99L8TuzXeMolyLYYTXTJiNsk4SUxToNk
	 Y7Ehlbd4o3h6wvzjwc6sSll6zBc2v6sAMlFV0z1INe5x0UE4Th7abxHLzdlsz/0r8u
	 RR3M1mVD3D1pw==
Message-ID: <d3bce110-4b1b-44ed-8c1d-a9736a02f1dd@uliege.be>
Date: Fri, 25 Oct 2024 23:06:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: ipv6: ioam6_iptunnel: mitigate
 2-realloc issue
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org
References: <20241025133727.27742-1-justin.iurman@uliege.be>
 <20241025133727.27742-2-justin.iurman@uliege.be>
 <59a875a9-2072-467d-8989-f01525ecd08c@intel.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <59a875a9-2072-467d-8989-f01525ecd08c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/24 17:12, Alexander Lobakin wrote:
> From: Justin Iurman <justin.iurman@uliege.be>
> Date: Fri, 25 Oct 2024 15:37:25 +0200
> 
>> This patch mitigates the two-reallocations issue with ioam6_iptunnel by
>> providing the dst_entry (in the cache) to the first call to
>> skb_cow_head(). As a result, the very first iteration would still
>> trigger two reallocations (i.e., empty cache), while next iterations
>> would only trigger a single reallocation.
> 
> [...]
> 
>>   static int ioam6_do_inline(struct net *net, struct sk_buff *skb,
>> -			   struct ioam6_lwt_encap *tuninfo)
>> +			   struct ioam6_lwt_encap *tuninfo,
>> +			   struct dst_entry *dst)
>>   {
>>   	struct ipv6hdr *oldhdr, *hdr;
>>   	int hdrlen, err;
>>   
>>   	hdrlen = (tuninfo->eh.hdrlen + 1) << 3;
>>   
>> -	err = skb_cow_head(skb, hdrlen + skb->mac_len);
>> +	err = skb_cow_head(skb, hdrlen + (!dst ? skb->mac_len
>> +					       : LL_RESERVED_SPACE(dst->dev)));
> 
> You use this pattern a lot throughout the series. I believe you should
> make a static inline or a macro from it.
> 
> static inline u32 some_name(const *dst, const *skb)
> {
> 	return dst ? LL_RESERVED_SPACE(dst->dev) : skb->mac_len;
> }
> 
> BTW why do you check for `!dst`, not `dst`? Does changing this affects
> performance?

Not at all, you're right... even the opposite actually. Regarding the 
static inline suggestion, it could be a good idea and may even look like 
this as an optimization:

static inline u32 dev_overhead(struct dst_entry *dst, struct sk_buff *skb)
{
	if (likely(dst))
		return LL_RESERVED_SPACE(dst->dev);

	return skb->mac_len;
}

The question is... where should it go then? A static inline function per 
file (i.e., ioam6_iptunnel.c, seg6_iptunnel.c, and rpl_iptunnel.c)? In 
that case, it would still be repeated 3 times. Or in a header file 
somewhere, to have it defined only once? If so, what location do you 
think would be best?

