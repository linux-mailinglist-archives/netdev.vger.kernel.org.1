Return-Path: <netdev+bounces-109201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFA192759B
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 13:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 232422835C5
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 11:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AC81AD9D8;
	Thu,  4 Jul 2024 11:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="QMkPnL5R"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA341AC435;
	Thu,  4 Jul 2024 11:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720094333; cv=none; b=MQg1bJ85e+28tThR7Xk4YXwG7Z3yl5rXUaOEdXJW3o/d+hEZzKdQOH8GD68/YPwYX4a3wRODdEWZSKnxjK9hZYT6RzkrPOq5ND64oAoEgLLviUNpDLhn5mTj5Z9p3sce2eTUs4yEdWF/Ow9nu8rI1EFv9lYin4mLXkpnXKZ1mHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720094333; c=relaxed/simple;
	bh=p/6k71i6v8OdPnGY+lv9/vmvcEoCpDcg+67YsCBN4x4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uRAV8add5PSu/BA6F0TlJioM9QPxFOCZH1I5kiTdpugKpNUZcCDBRstt2U4h8oJHTRXNWZGyNJNO6AVzflFoXPBQ31wLf2W/zJryvyGz3dBKdfYTsp89/PkU/aIGKPAzBQfcl1/NPcqtDqjuBJxvWq8SuWbjbZM7jkYJc41ajcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=QMkPnL5R; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.55] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id EC1CF200CD06;
	Thu,  4 Jul 2024 13:58:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be EC1CF200CD06
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1720094321;
	bh=U/ywlGjkek4RHAQwTk9TPOPL3yDvvLL40zoLmh8F3xs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QMkPnL5RgiJBOV2MK3Je7CaEVDQVDRYrOJpjotw0bQk1aEzDbCX3YAdbM+k9LfloP
	 KpJ+YALf12xveJONlNZ87+60vsAXXcdjarOqVEhlzjoh+rQClM20x2ix3IwUQY6LCv
	 M4FNUjn1EyK6g2yWb/nojTW1RH8ns2tZk6e2SVJNOs9r0YAwt04q1sLtQdBzkI0air
	 Oup1d8fRRoyx/hS2PpzYO8wWHLLI8AWINwLgScNBLqxjrZcWP/hP0oElfZwVhB4ki/
	 r+aYj39WczB6dvm1390ayNB85zFBhChFfXLUQ2B5kue3HZxjW9FMTjTXlND3wnbF5b
	 /sRnaLDN0yYuQ==
Message-ID: <08784a20-48a4-40ec-a641-95a474673a3c@uliege.be>
Date: Thu, 4 Jul 2024 13:58:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] net: ioam6: mitigate the two reallocations
 problem
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, justin.iurman@uliege.be
References: <20240702174451.22735-1-justin.iurman@uliege.be>
 <20240702174451.22735-3-justin.iurman@uliege.be>
 <54d30d951eddf0846b88b7f9f73ce16994550bd7.camel@redhat.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <54d30d951eddf0846b88b7f9f73ce16994550bd7.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/4/24 11:23, Paolo Abeni wrote:
> On Tue, 2024-07-02 at 19:44 +0200, Justin Iurman wrote:
>> @@ -313,6 +316,10 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>>   
>>   	orig_daddr = ipv6_hdr(skb)->daddr;
>>   
>> +	local_bh_disable();
>> +	dst = dst_cache_get(&ilwt->cache);
>> +	local_bh_enable();
>> +
>>   	switch (ilwt->mode) {
>>   	case IOAM6_IPTUNNEL_MODE_INLINE:
> 
> I now see that the way you coded patch 1/2 makes this one easier.

Hi Paolo,

Indeed. I originally had it as a single two-in-one patch, then I thought 
it would be clearer to split it up (looks like I was wrong, sorry).

> Still I think it's quite doubtful to make the dst cache access
> unconditional.

By unconditional, you mean to get the cache _before_ the switch, right? 
If so, that's indeed the only solution to provide it to the encap/inline 
function for the mitigation. However, I don't see it as a problem. 
Instead of having (a) call encap/fill function, then (b) get cache; 
you'd have (a) get cache, then (b) call encap/fill function. IMHO, it's 
the same. I'll re-run our measurements and compare them to our previous 
results in order to confirm getting the cache early does not impact 
performance. The only exception would be when skb_cow_head returns an 
error in encap/fill functions: in that case, getting the cache early 
would be a waste of time, but this situation suggests there is a problem 
already so it's probably fine.

> Given the above I suggest to replace the 2 patches with a single one
> moving the whole dst_cache logic before the switch statement.

Will do!

> Also this does not address a functional issue, IMHO it's more a
> performance improvement, could as well target net-next with no fixes
> tag.

Hmmm, it's indeed OK to target net-next for patch #2 since it could be 
considered as an improvement (not really a functional issue per se). 
However, I'm not sure for patch #1. Wouldn't the kernel crash if not 
enough headroom was allocated (assuming no check is done before writing 
in the driver)?

> WRT seg6 and rpl tunnels, before any patch, I think we first need
> confirmation the problem is present there, too.

Ack. I'll try to run some tests to check that.

Thanks,
Justin

> Thanks,
> 
> Paolo
> 

