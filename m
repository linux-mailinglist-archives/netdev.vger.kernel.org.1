Return-Path: <netdev+bounces-241231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A75C8C81A74
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 17:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D47C3A9DBF
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 16:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF37629E110;
	Mon, 24 Nov 2025 16:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="kavZpPEV"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCC329C327
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 16:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764002700; cv=none; b=SsaQT/AyHLkuoT/cwB+0Mi8E14+DiAN6hw0owikWpuRTyzu0jhFlU10GEHpVGKcN1Eu2quoOl97c82LDPhOVwCPBPlabEFpHAPfi6dCUY3lCBWO0k8NwAtQV0XtIThKE2Oa35bePW9cDCMFVVU7yU2oEwAbnZPKdYw9EdNUoYgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764002700; c=relaxed/simple;
	bh=6Q4LeVfWb/CwC/gwaZIkJT1vZtnyELH7UhEsssd/nKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fo1C5/rCCooRBT6DLmF0SZyDrqn9MlLiOrT0AluMfXEDunjOYZrOaHXs1p+FVApFLvGlgdrfHV+xBCwxlYhT2SLnSC1XFYBYK/NcqoBXsqJ3rAcGJdXI0mIULpl2U+n8tqvOXdpc05qEYaO9uspwvZIslvhFvV4Qqxwgw+5FfUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=kavZpPEV; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.58] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 4DE88200AA22;
	Mon, 24 Nov 2025 17:44:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 4DE88200AA22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1764002686;
	bh=94tbaAcEE7cL6Ain67JeCIBTbjaXE+uD+PoADT0a6Pk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kavZpPEVgn6kAJCJuaWSre0/FrQq8c69OCIzR7IGykb5g6dMXyEiR/feuEf51r93t
	 vOH2n3K3zAIhdDhrP3IzhnROU6Rwx8aTs7fqZVLdrgf5Rpe5XoWWMZ3PG48TrfGMIf
	 eeQHcrCeY2/olFNkuoanV4HQWAE5QVJR1lrtNgR42WLYV9u67V4samYE2A48cSRNSr
	 7hL+T33uB0ArEGV3xI2ropZqOWEi39bC3BmuTPZ20BvZDPxxpQqbYvyYzvgCyv3e4C
	 wnVvaW2EVKQdkYoM8vAhqCGtKdamorW4GxCUBPIV1ShI35aDWSkM0CLcC5yPOgLhZv
	 g3zxabF7eB8Ug==
Message-ID: <6b9ec0e7-19cc-4059-953a-dea7dbd095ef@uliege.be>
Date: Mon, 24 Nov 2025 17:44:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 2/3] ipv6: Disable IPv6 Destination Options RX
 processing by default
To: Tom Herbert <tom@herbertland.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org
References: <20251112001744.24479-1-tom@herbertland.com>
 <20251112001744.24479-3-tom@herbertland.com>
 <d7793ec7-7d34-4a46-8f17-c4ff1152e232@uliege.be>
 <CALx6S369Cb-9mtD3hSS0udTHZ_4r5d+2UD8zfsonjfM7QrHhAA@mail.gmail.com>
 <edb1d889-480d-4ef0-ae96-fa99d00aaaad@uliege.be>
 <CALx6S34SjAvoidT+vjWA=U3GezP39hT2v3LuaFtLid_sMY7+dA@mail.gmail.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <CALx6S34SjAvoidT+vjWA=U3GezP39hT2v3LuaFtLid_sMY7+dA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/22/25 17:48, Tom Herbert wrote:
> On Sat, Nov 22, 2025 at 1:53 AM Justin Iurman <justin.iurman@uliege.be> wrote:
>>
>> On 11/21/25 22:23, Tom Herbert wrote:
>>> On Thu, Nov 13, 2025 at 5:17 AM Justin Iurman <justin.iurman@uliege.be> wrote:
>>>>
>>>> On 11/12/25 01:16, Tom Herbert wrote:
>>>>> Set IP6_DEFAULT_MAX_HBH_OPTS_CNT to zero. This disables
>>>>
>>>> s/IP6_DEFAULT_MAX_HBH_OPTS_CNT/IP6_DEFAULT_MAX_DST_OPTS_CNT
>>>>
>>>>> processing of Destinations Options extension headers by default.
>>>>> Processing can be enabled by setting the net.ipv6.max_dst_opts_number
>>>>> to a non-zero value.
>>>>>
>>>>> The rationale for this is that Destination Options pose a serious risk
>>>>> of Denial off Service attack. The problem is that even if the
>>>>> default limit is set to a small number (previously it was eight) there
>>>>> is still the possibility of a DoS attack. All an attacker needs to do
>>>>> is create and MTU size packet filled  with 8 bytes Destination Options
>>>>> Extension Headers. Each Destination EH simply contains a single
>>>>> padding option with six bytes of zeroes.
>>>>>
>>>>> In a 1500 byte MTU size packet, 182 of these dummy Destination
>>>>> Options headers can be placed in a packet. Per RFC8200, a host must
>>>>> accept and process a packet with any number of Destination Options
>>>>> extension headers. So when the stack processes such a packet it is
>>>>> a lot of work and CPU cycles that provide zero benefit. The packet
>>>>> can be designed such that every byte after the IP header requires
>>>>> a conditional check and branch prediction can be rendered useless
>>>>> for that. This also may mean over twenty cache misses per packet.
>>>>> In other words, these packets filled with dummy Destination Options
>>>>> extension headers are the basis for what would be an effective DoS
>>>>> attack.
>>>>
>>>> How about a new document to update RFC8200 Sec. 4.1.? Maybe we can get
>>>> 6man consensus to enforce only one occurrence (vs. 2 for the Dest) for
>>>> each extension header. Let alone the recommended order (without
>>>> normative language), we could...
>>>
>>> Hi Justin,
>>
>> Hi Tom,
>>
>>> It's a nice idea, but given the turnaround times for the IETF process
>>
>> Indeed, but I think we'll need that at some point. I'll craft something
>> and send it to 6man to get feedback.
>>
>>> it would take years. Also to implement that in the stack isn't
>>
>> I don't think it would be difficult thanks to struct inet6_skb_parm that
>> is stored in the control buffer of skb's. We already have some flags
>> that are set, and offsets defined.
> 
> Justin,
> 
> A patch for that would be good regardless of whether you take it to IETF :-).

Hi Tom,

Of course, but at the same time, we'll probably want to remain compliant 
with RFC8200 :-)

>>
>>> particularly trivial. Avoiding the potential DoS attack is the higher
>>> priority problem IMO, and disabling DestOpts by default will have
>>> little impact since almost no one is using them..
>>
>> Agree, but both issues are linked. If we don't explicitly limit (funny,
>> in this case, I'd be OK to use that term ;-) the number of Destination
>> Options header to 2 (as it should be), then the attack surface increases.
> 
> Yes, but it doesn't eliminate the potential for attack.

I think we're in violent agreement. What I meant was that... well, 
that's already a step forward.

>>
>>>>
>>>> OLD:
>>>>       Each extension header should occur at most once, except for the
>>>>       Destination Options header, which should occur at most twice (once
>>>>       before a Routing header and once before the upper-layer header).
>>>>
>>>> NEW:
>>>>       Each extension header MUST occur at most once, except for the
>>>>       Destination Options header, which MUST occur at most twice (once
>>>>       before a Routing header and once before the upper-layer header).
>>>>
>>>> ...and...
>>>>
>>>> OLD:
>>>>       IPv6 nodes must accept and attempt to process extension headers in
>>>>       any order and occurring any number of times in the same packet,
>>>>       except for the Hop-by-Hop Options header, which is restricted to
>>>>       appear immediately after an IPv6 header only.  Nonetheless, it is
>>>>       strongly advised that sources of IPv6 packets adhere to the above
>>>>       recommended order until and unless subsequent specifications revise
>>>>       that recommendation.
>>>>
>>>> NEW:
>>>>       IPv6 nodes must accept and attempt to process extension headers in
>>>>       any order in the same packet,
>>>>       except for the Hop-by-Hop Options header, which is restricted to
>>>>       appear immediately after an IPv6 header only.  Nonetheless, it is
>>>>       strongly advised that sources of IPv6 packets adhere to the above
>>>>       recommended order until and unless subsequent specifications revise
>>>>       that recommendation.
>>>>
>>>>> Disabling Destination Options is not a major issue for the following
>>>>> reasons:
>>>>>
>>>>> * Linux kernel only supports one Destination Option (Home Address
>>>>>      Option). There is no evidence this has seen any real world use
>>>>
>>>> IMO, this is precisely the one designed for such real world end-to-end
>>>> use cases (e.g., PDM [RFC8250] and PDMv2 [draft-ietf-ippm-encrypted-pdmv2]).
>>>
>>> Sure, but  where is the Linux implementation? Deployment?
>>
>> Maybe they'll send it upstream one day, who knows.
>>
>>>>
>>>>> * On the Internet packets with Destination Options are dropped with
>>>>>      a high enough rate such that use of Destination Options is not
>>>>>      feasible
>>>>
>>>> I wouldn't say that a 10-20% drop is *that* bad (i.e., "not feasible")
>>>> for sizes < 64 bytes. But anyway...
>>>
>>> The drop rates for Destination Options vary by size of the extension
>>> header. AP NIC data shows that 32 bytes options have about a 30% drop
>>> rate, 64 byte options have about a 40% drop rate, but 128 byte options
>>> have over 80% drop rate. The drops are coming from routers and not
>>> hosts, Linux has no problem with different sizes. As you know from the
>>> 6man list discussions, I proposed a minimum level of support that
>>> routers must forward packets with up to 64 bytes of extension headers,
>>> but that draft was rejected because of concerns that it would ossify
>>> an already ossified protocol :-(. Even if a 40% drop rate isn't "that
>>> bad" the 80% drop rate of 128 bytes EH would seem to qualify as "bad".
>>> In any case, no one in IETF has offered an alternative plan to address
>>> the high loss rates and without a solution I believe it's fair to say
>>> that use of Destination Options is not feasible.
>>
>> The difference with APNIC's measurements lies in the fact that they
>> reach end-users located behind ISPs, where EHs are heavily filtered. So
>> their measurements are worst case scenarios (not saying they are not
>> representative, just that it's a different location in networks). This
>> becomes "less" problematic (don't get me wrong, there are still EH
>> filters) if you remain at the core/edge (e.g., cloud providers, etc).
>>
> 
> That's exactly the point though. The vast majority of our users, i.e.
> billions of laptops and SmartPhones, live behind ISPs and packets sent
> to them with EH are commonly being filtered by ISPs. IMO we need to
> set the defaults for the benefit of _them_, not for the relative
> handful of nodes that remain at the core/edge. For the latter group if
> they really want to use extension headers they can easily configure
> their devices accordingly. As contrary as it is to the end-to-end
> principle, it may actually be a good thing that ISPs have been
> filtering all along since that saves hosts from DoS attacks involving
> EH, but it's time to close this security hole in Linux itself.

Again, we're in violent agreement here (although I'd push for a default 
limit of 1 option for both Hbh and Dest, just to align Dest with Hbh 
since it is needed for the latter and RAO). I think that an update to 
RFC8200 + a limit of 1 in rfc8504-bis (vs. 8 in RFC8504) would provide a 
good compromise regarding security and usability on hosts. I checked 
RFC9673 and it doesn't require any change.

> Also we need to be honest here. The whole idea of extension headers
> was ill conceived from the get go. Even if we didn't know any better
> in the first design of IPv6 thirty years ago, I really wished the
> problems would have been addressed when IPv6 was promoted to Standard.
> Destination Options are particularly problematic since they have no
> security to speak of. If someone wants to send end-to-end information
> wouldn't they wrap this in an encrypted transport layer, I mean why
> expose end-to-end information in plain text for all the world to see
> and muck with?

Mostly agree. You could still use ESP+Dest, though. Also, we may have 
use cases in the future that do not require confidentiality (who knows?).

> In the end, the most likely future of extension headers is that they
> will be relegated to use in limited domains. And that's fine, in a
> limited domain any issues of router compatibility can be managed and
> security can be enforced. But on the Internet, I don't believe we'll

That's exactly what I've been saying for months/years. Well, not for the 
Destination Options (which are IMO specifically designed for that), nor 
for ESP, which works very well (but we know why ;-). Oh, and the 
Fragment header too is supposed to work on the Internet, but we also 
know why it doesn't. Anyway...

> ever see EH used. And that's why I think we should disable Destination
> Options by default for the greater good of humanity! ;-)

I don't think I'm quite ready to see Destination Options completely 
disabled by default on hosts :-( See above the proposed limit of 1 (but 
I totally understand why you want 0, though).

Justin

> Tom
> 
>>>>
>>>>> * It is unknown however quite possible that no one anywhere is using
>>>>>      Destination Options for anything but experiments, class projects,
>>>>>      or DoS. If someone is using them in their private network thenthatit
>>>>>      it's easy enough to configure a non-zero limit for their use case
>>>>> ---
>>>>>     include/net/ipv6.h | 7 +++++--
>>>>>     1 file changed, 5 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/include/net/ipv6.h b/include/net/ipv6.h
>>>>> index 74fbf1ad8065..723a254c0b90 100644
>>>>> --- a/include/net/ipv6.h
>>>>> +++ b/include/net/ipv6.h
>>>>> @@ -86,8 +86,11 @@ struct ip_tunnel_info;
>>>>>      * silently discarded.
>>>>>      */
>>>>>
>>>>> -/* Default limits for Hop-by-Hop and Destination options */
>>>>> -#define IP6_DEFAULT_MAX_DST_OPTS_CNT  8
>>>>> +/* Default limits for Hop-by-Hop and Destination options. By default
>>>>> + * packets received with Destination Options headers are dropped to thwart
>>>>> + * Denial of Service attacks (see sysctl documention)
>>>>> + */
>>>>> +#define IP6_DEFAULT_MAX_DST_OPTS_CNT  0
>>>>>     #define IP6_DEFAULT_MAX_HBH_OPTS_CNT         8
>>>>>     #define IP6_DEFAULT_MAX_DST_OPTS_LEN         INT_MAX /* No limit */
>>>>>     #define IP6_DEFAULT_MAX_HBH_OPTS_LEN         INT_MAX /* No limit */
>>>>
>>>> I'd rather prefer to update RFC8200 and enforce a maximum of 2
>>>> occurrences for the Dest, and keep the default limit of 8 options.
>>>>
>>>> Also, regardless of what we do here (and this remark also applies to the
>>>> Hop-by-Hop), I think it's reasonable for a *host* to drop packets with a
>>>> number of Hbh or Dest options that exceeds the configured limit.
>>>> However, for a router (i.e., forwarding mode), I'd prefer to skip the EH
>>>> chain rather than drop packets (for obvious reasons).
>>>
>>> I considered that, but there is a problem in that when we process HBH
>>> options we don't know if we're a host (i.e. the final destination) or
>>> a router (i.e. the packet will be forwarded). I would prefer to keep
>>
>> Correct. We may consider calling ip6_route_input() earlier (this is what
>> IOAM does already), for example before calling ipv6_parse_hopopts() in
>> ip6_rcv_core(), instead of doing it in ip6_rcv_finish_core(). Otherwise,
>> we'd need to rely on ipv6_chk_addr_ret(). Maybe something like (not tested):
>>
>> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
>> index a23eb8734e15..0351b7fc58ee 100644
>> --- a/net/ipv6/exthdrs.c
>> +++ b/net/ipv6/exthdrs.c
>> @@ -119,6 +119,7 @@ static bool ip6_parse_tlv(bool hopbyhop,
>>          const unsigned char *nh = skb_network_header(skb);
>>          int off = skb_network_header_len(skb);
>>          bool disallow_unknowns = false;
>> +       int ipv6_chk_addr_ret = -1;
>>          int tlv_count = 0;
>>          int padlen = 0;
>>
>> @@ -166,8 +167,30 @@ static bool ip6_parse_tlv(bool hopbyhop,
>>                          }
>>                  } else {
>>                          tlv_count++;
>> -                       if (tlv_count > max_count)
>> -                               goto bad;
>> +                       if (tlv_count > max_count) {
>> +                               /* Drop a Destination Options header when its
>> +                                * number of options exceeds the configured
>> +                                * limit.
>> +                                */
>> +                               if (!hopbyhop)
>> +                                       goto bad;
>> +
>> +                               /* Drop a Hop-by-Hop Options header when its
>> +                                * number of options exceeds the configured
>> +                                * limit IF we're the destination. Otherwise,
>> +                                * just skip it.
>> +                                */
>> +                               if (ipv6_chk_addr_ret == -1)
>> +                                       ipv6_chk_addr_ret = ipv6_chk_addr(
>> +                                                       dev_net(skb->dev),
>> +                                                       &ipv6_hdr(skb)->daddr,
>> +                                                       skb->dev, 0);
>> +
>> +                               if (ipv6_chk_addr_ret)
>> +                                       goto bad;
>> +
>> +                               goto skip;
>> +                       }
>>
>>                          if (hopbyhop) {
>>                                  switch (nh[off]) {
>> @@ -210,6 +233,7 @@ static bool ip6_parse_tlv(bool hopbyhop,
>>                                          break;
>>                                  }
>>                          }
>> +skip:
>>                          padlen = 0;
>>                  }
>>                  off += optlen;
>>
>>> it simple and drop whenever a limit is exceeded. RFC9673 does allow a
>>> host to skip over HBH options, but IMO it's too risky to blindly
>>> accept a packet without verifying all the headers.
>>
>> For a host, I agree. But as a router, I really don't think we should
>> drop packets if the limit is exceeded. In that case, we just don't care,
>> we're routers, it's not our job to decide if we drop a packet because of
>> EHs. Otherwise, we'd be doing the same as operators' policies and
>> hardware limitation in transit ASs, and we'd be exacerbating the
>> ossification.
>>
>> Justin
>>
>>> Tom
>>


