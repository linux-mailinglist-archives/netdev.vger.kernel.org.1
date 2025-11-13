Return-Path: <netdev+bounces-238349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC82C579BD
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 14:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 50CC54E1543
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 13:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E00350A13;
	Thu, 13 Nov 2025 13:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="SJQ2Xsd2"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241BB35029B
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 13:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039877; cv=none; b=KRr1PJoEKnFQt+xrbS0K8ti+OB+dn29Jr2yPAUlQ4v1XOjEiEWrIv6DTxofEjU0a2ZHmVQuj/HcLfJNAIsTvUkWL9dN7Ch1Fm7OxDmABnzadLS76rk734hsRHugIj83YQlQ+cyf2nUkb5S5KMEp+ULxhLW5q4EY8MPVyia1+u7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039877; c=relaxed/simple;
	bh=BWgrT3gMtBMPff8SNz6lm3XpAyL3nG6NpP8tQkqdDtU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pNs4tns87Ce9d02Pc1rblB/Es20wfKd8cEAW4HSNUP5dOea8nzst+64F72mnhI9QNQepQgzF5QWrT6kM2RukB2rmMRCg8lMdPmDJSPfXKjjT7UQEmACpPfP6UEZMJ40JMsWO3logqd3goQoX8QNcRHhYlyINlrnodwb0IUET32g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=SJQ2Xsd2; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.58] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 5C174200C972;
	Thu, 13 Nov 2025 14:17:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 5C174200C972
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1763039873;
	bh=tzeeaE4HYZ/VwYImfEKEDrBz8w9gFgrVWPkRH+orIUk=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=SJQ2Xsd2fWvyZfNR6BvQcL1Cm32ymg8TWa4q+3Nw2edtMrqqFft0v85yYVS+6y+sk
	 vPgejyTpdkwcPjz9ZJIMWG0Fe8RuvcCZ3E30LvuL4js8gLjznKbYk3luCeD8wEJbnt
	 9ob7PjyZOgeNcDrttH+jK5TNaGfwK5mIrkO1+S6SQlB0RDy6BOtb2ue25L/G6RfdLa
	 zQNkmMKUBwXDYwt8Va+t6AyKQzQtXix0VgtIACv+IkfYlUJwRA6ykb6d5O7HjXkZQ7
	 Y3Svq18YIKQGriI/YITtLoCn6udVg5zYOmkLiVrmdur3tpbqmqhfsqoEuZq+TWNlI/
	 /ntl1W8hovtTg==
Message-ID: <d7793ec7-7d34-4a46-8f17-c4ff1152e232@uliege.be>
Date: Thu, 13 Nov 2025 14:17:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Justin Iurman <justin.iurman@uliege.be>
Subject: Re: [RFC net-next 2/3] ipv6: Disable IPv6 Destination Options RX
 processing by default
To: Tom Herbert <tom@herbertland.com>, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org
Cc: justin.iurman@uliege.be
References: <20251112001744.24479-1-tom@herbertland.com>
 <20251112001744.24479-3-tom@herbertland.com>
Content-Language: en-US
In-Reply-To: <20251112001744.24479-3-tom@herbertland.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/25 01:16, Tom Herbert wrote:
> Set IP6_DEFAULT_MAX_HBH_OPTS_CNT to zero. This disables

s/IP6_DEFAULT_MAX_HBH_OPTS_CNT/IP6_DEFAULT_MAX_DST_OPTS_CNT

> processing of Destinations Options extension headers by default.
> Processing can be enabled by setting the net.ipv6.max_dst_opts_number
> to a non-zero value.
> 
> The rationale for this is that Destination Options pose a serious risk
> of Denial off Service attack. The problem is that even if the
> default limit is set to a small number (previously it was eight) there
> is still the possibility of a DoS attack. All an attacker needs to do
> is create and MTU size packet filled  with 8 bytes Destination Options
> Extension Headers. Each Destination EH simply contains a single
> padding option with six bytes of zeroes.
> 
> In a 1500 byte MTU size packet, 182 of these dummy Destination
> Options headers can be placed in a packet. Per RFC8200, a host must
> accept and process a packet with any number of Destination Options
> extension headers. So when the stack processes such a packet it is
> a lot of work and CPU cycles that provide zero benefit. The packet
> can be designed such that every byte after the IP header requires
> a conditional check and branch prediction can be rendered useless
> for that. This also may mean over twenty cache misses per packet.
> In other words, these packets filled with dummy Destination Options
> extension headers are the basis for what would be an effective DoS
> attack.

How about a new document to update RFC8200 Sec. 4.1.? Maybe we can get 
6man consensus to enforce only one occurrence (vs. 2 for the Dest) for 
each extension header. Let alone the recommended order (without 
normative language), we could...

OLD:
    Each extension header should occur at most once, except for the
    Destination Options header, which should occur at most twice (once
    before a Routing header and once before the upper-layer header).

NEW:
    Each extension header MUST occur at most once, except for the
    Destination Options header, which MUST occur at most twice (once
    before a Routing header and once before the upper-layer header).

...and...

OLD:
    IPv6 nodes must accept and attempt to process extension headers in
    any order and occurring any number of times in the same packet,
    except for the Hop-by-Hop Options header, which is restricted to
    appear immediately after an IPv6 header only.  Nonetheless, it is
    strongly advised that sources of IPv6 packets adhere to the above
    recommended order until and unless subsequent specifications revise
    that recommendation.

NEW:
    IPv6 nodes must accept and attempt to process extension headers in
    any order in the same packet,
    except for the Hop-by-Hop Options header, which is restricted to
    appear immediately after an IPv6 header only.  Nonetheless, it is
    strongly advised that sources of IPv6 packets adhere to the above
    recommended order until and unless subsequent specifications revise
    that recommendation.

> Disabling Destination Options is not a major issue for the following
> reasons:
> 
> * Linux kernel only supports one Destination Option (Home Address
>    Option). There is no evidence this has seen any real world use

IMO, this is precisely the one designed for such real world end-to-end 
use cases (e.g., PDM [RFC8250] and PDMv2 [draft-ietf-ippm-encrypted-pdmv2]).

> * On the Internet packets with Destination Options are dropped with
>    a high enough rate such that use of Destination Options is not
>    feasible

I wouldn't say that a 10-20% drop is *that* bad (i.e., "not feasible") 
for sizes < 64 bytes. But anyway...

> * It is unknown however quite possible that no one anywhere is using
>    Destination Options for anything but experiments, class projects,
>    or DoS. If someone is using them in their private network then
>    it's easy enough to configure a non-zero limit for their use case
> ---
>   include/net/ipv6.h | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/ipv6.h b/include/net/ipv6.h
> index 74fbf1ad8065..723a254c0b90 100644
> --- a/include/net/ipv6.h
> +++ b/include/net/ipv6.h
> @@ -86,8 +86,11 @@ struct ip_tunnel_info;
>    * silently discarded.
>    */
>   
> -/* Default limits for Hop-by-Hop and Destination options */
> -#define IP6_DEFAULT_MAX_DST_OPTS_CNT	 8
> +/* Default limits for Hop-by-Hop and Destination options. By default
> + * packets received with Destination Options headers are dropped to thwart
> + * Denial of Service attacks (see sysctl documention)
> + */
> +#define IP6_DEFAULT_MAX_DST_OPTS_CNT	 0
>   #define IP6_DEFAULT_MAX_HBH_OPTS_CNT	 8
>   #define IP6_DEFAULT_MAX_DST_OPTS_LEN	 INT_MAX /* No limit */
>   #define IP6_DEFAULT_MAX_HBH_OPTS_LEN	 INT_MAX /* No limit */

I'd rather prefer to update RFC8200 and enforce a maximum of 2 
occurrences for the Dest, and keep the default limit of 8 options.

Also, regardless of what we do here (and this remark also applies to the 
Hop-by-Hop), I think it's reasonable for a *host* to drop packets with a 
number of Hbh or Dest options that exceeds the configured limit. 
However, for a router (i.e., forwarding mode), I'd prefer to skip the EH 
chain rather than drop packets (for obvious reasons).

