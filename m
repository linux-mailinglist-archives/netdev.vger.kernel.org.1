Return-Path: <netdev+bounces-269865-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNM8KEcWvWnG6QIAu9opvQ
	(envelope-from <netdev+bounces-269865-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 10:41:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 233D52D829A
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 10:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9CCF30A04F4
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 09:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6335375F96;
	Fri, 20 Mar 2026 09:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="HV/4QcVk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15180374749
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773999597; cv=none; b=aE4MQc+s+/OGQBnr2NukqKT8QQnH6aCugwQi8qRausu5EieOBedBGEQFM1d+7Q3NkbYOSecbwggQ1Y+r/RnvQZNwIRiuVGFIAqPIkUSgPg9/hKwJW3vHLkap9/VCmnbY+6Je/MqIczT9d4gJHojoFdf6aagMw2LGz5Cro2nJ/IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773999597; c=relaxed/simple;
	bh=hqVLgjCNlLJ7pjhab4ZO6AKFe7YAExUM8VVRxABWi+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u9f9qW8Rsh7RHiuYU3tymTjDUunELOv1GgvZueC6/VqC9GisQDE/xVv+iWfHgvxEfVq0Dl1PlB0Zo9kkaGalLLv+lUwbQGaI1knok39bkvVCvArDuV+Xc8gDe1ymWkUSc55baVmp1HbX4rIqnpGLFIAcn67rq2h04zTPb/7aCqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=HV/4QcVk; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=GSWrQ5pzLlYgZV6SfWe+StLuHVoQh34pOQ6vD246CNA=;
	b=HV/4QcVkI5djULZzLlW3leoxXIsOB5of/SsrsBIOEadYpamk45+8wiQzvo9rZD
	FCOeG0NTBgS0tw19KsIDXWTLRekO1qPtXiZf4cGYsj06rDY00D3zLQxx/+xHLCni
	OK1ysqQqCty2S/XdnJbX9byvySLfa3QpLbJ6ZJ6RxK8GY=
Received: from [7.247.167.152] (unknown [])
	by gzsmtp1 (Coremail) with UTF8SMTPA id Mc8vCgDn7r2rFb1pCCJtAA--.48875S2;
	Fri, 20 Mar 2026 17:38:52 +0800 (CST)
Message-ID: <c0779757-8318-4ecb-93ee-284b325c11d2@yeah.net>
Date: Fri, 20 Mar 2026 17:38:43 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: gso: Forbid IPv6 TSO with extensions on
 devices with only IPV6_CSUM
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Ramaseuski <jramaseu@redhat.com>,
 netdev@vger.kernel.org
Cc: kuba@kernel.org, horms@kernel.org, edumazet@google.com, sdf@fomichev.me,
 ahmed.zaki@intel.com, aleksander.lobakin@intel.com, benoit.monin@gmx.fr,
 willemb@google.com, Tianhao Zhao <tizhao@redhat.com>,
 Michal Schmidt <mschmidt@redhat.com>
References: <20250814105119.1525687-1-jramaseu@redhat.com>
 <0414e7e2-9a1c-4d7c-a99d-b9039cf68f40@yeah.net>
 <willemdebruijn.kernel.d12bc5fb9c16@gmail.com>
 <49dac359-326a-4f3a-8c18-9897ea7be498@redhat.com>
 <d6b8909d-705e-498d-ad9a-e61fa24c9d88@yeah.net>
 <9186ce75-4038-4467-b492-7a7821659842@redhat.com>
 <willemdebruijn.kernel.2e5ca236c023e@gmail.com>
From: xietangxin <xietangxin@yeah.net>
In-Reply-To: <willemdebruijn.kernel.2e5ca236c023e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Mc8vCgDn7r2rFb1pCCJtAA--.48875S2
X-Coremail-Antispam: 1Uf129KBjvAXoWfGrykJF43WFW3Wr17Xr17trb_yoW8GrW3Xo
	WrJw43Ja18Kr1UXF1UG34Uu345X3W8JFs7ZrW093W5GwnFqa4UCw43Jw15Xay3Kr1rG3y5
	Jry7J345ua4DGFn3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUwJ5rUUUUU
X-CM-SenderInfo: x0lh3tpqj0x0o61htxgoqh3/1tbiNQ06bmm9Fa3Q+gAA3q
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yeah.net,none];
	R_DKIM_ALLOW(-0.20)[yeah.net:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269865-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[yeah.net:+];
	FREEMAIL_FROM(0.00)[yeah.net];
	NEURAL_HAM(-0.00)[-0.955];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xietangxin@yeah.net,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,google.com,fomichev.me,intel.com,gmx.fr,redhat.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 233D52D829A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/15/2026 12:19 AM, Willem de Bruijn wrote:
> Paolo Abeni wrote:
>> On 3/6/26 7:32 AM, xietangxin wrote:
>>> On 3/5/2026 11:21 PM, Paolo Abeni wrote:
>>>> On 3/5/26 3:57 PM, Willem de Bruijn wrote:
>>>>> xietangxin wrote:
>>>>>> 在 2025/8/14 18:51, Jakub Ramaseuski 写道:
>>>>>>> When performing Generic Segmentation Offload (GSO) on an IPv6 packet that
>>>>>>> contains extension headers, the kernel incorrectly requests checksum offload
>>>>>>> if the egress device only advertises NETIF_F_IPV6_CSUM feature, which has 
>>>>>>> a strict contract: it supports checksum offload only for plain TCP or UDP 
>>>>>>> over IPv6 and explicitly does not support packets with extension headers.
>>>>>>> The current GSO logic violates this contract by failing to disable the feature
>>>>>>> for packets with extension headers, such as those used in GREoIPv6 tunnels.
>>>>>>>
>>>>>>> This violation results in the device being asked to perform an operation
>>>>>>> it cannot support, leading to a `skb_warn_bad_offload` warning and a collapse
>>>>>>> of network throughput. While device TSO/USO is correctly bypassed in favor
>>>>>>> of software GSO for these packets, the GSO stack must be explicitly told not 
>>>>>>> to request checksum offload.
>>>>>>>
>>>>>>> Mask NETIF_F_IPV6_CSUM, NETIF_F_TSO6 and NETIF_F_GSO_UDP_L4
>>>>>>> in gso_features_check if the IPv6 header contains extension headers to compute
>>>>>>> checksum in software.
>>>>>>>
>>>>>>> The exception is a BIG TCP extension, which, as stated in commit
>>>>>>> 68e068cabd2c6c53 ("net: reenable NETIF_F_IPV6_CSUM offload for BIG TCP packets"):
>>>>>>> "The feature is only enabled on devices that support BIG TCP TSO.
>>>>>>> The header is only present for PF_PACKET taps like tcpdump,
>>>>>>> and not transmitted by physical devices."
>>>>>>>
>>>>>>> kernel log output (truncated):
>>>>>>> WARNING: CPU: 1 PID: 5273 at net/core/dev.c:3535 skb_warn_bad_offload+0x81/0x140
>>>>>>> ...
>>>>>>> Call Trace:
>>>>>>>  <TASK>
>>>>>>>  skb_checksum_help+0x12a/0x1f0
>>>>>>>  validate_xmit_skb+0x1a3/0x2d0
>>>>>>>  validate_xmit_skb_list+0x4f/0x80
>>>>>>>  sch_direct_xmit+0x1a2/0x380
>>>>>>>  __dev_xmit_skb+0x242/0x670
>>>>>>>  __dev_queue_xmit+0x3fc/0x7f0
>>>>>>>  ip6_finish_output2+0x25e/0x5d0
>>>>>>>  ip6_finish_output+0x1fc/0x3f0
>>>>>>>  ip6_tnl_xmit+0x608/0xc00 [ip6_tunnel]
>>>>>>>  ip6gre_tunnel_xmit+0x1c0/0x390 [ip6_gre]
>>>>>>>  dev_hard_start_xmit+0x63/0x1c0
>>>>>>>  __dev_queue_xmit+0x6d0/0x7f0
>>>>>>>  ip6_finish_output2+0x214/0x5d0
>>>>>>>  ip6_finish_output+0x1fc/0x3f0
>>>>>>>  ip6_xmit+0x2ca/0x6f0
>>>>>>>  ip6_finish_output+0x1fc/0x3f0
>>>>>>>  ip6_xmit+0x2ca/0x6f0
>>>>>>>  inet6_csk_xmit+0xeb/0x150
>>>>>>>  __tcp_transmit_skb+0x555/0xa80
>>>>>>>  tcp_write_xmit+0x32a/0xe90
>>>>>>>  tcp_sendmsg_locked+0x437/0x1110
>>>>>>>  tcp_sendmsg+0x2f/0x50
>>>>>>> ...
>>>>>>> skb linear:   00000000: e4 3d 1a 7d ec 30 e4 3d 1a 7e 5d 90 86 dd 60 0e
>>>>>>> skb linear:   00000010: 00 0a 1b 34 3c 40 20 11 00 00 00 00 00 00 00 00
>>>>>>> skb linear:   00000020: 00 00 00 00 00 12 20 11 00 00 00 00 00 00 00 00
>>>>>>> skb linear:   00000030: 00 00 00 00 00 11 2f 00 04 01 04 01 01 00 00 00
>>>>>>> skb linear:   00000040: 86 dd 60 0e 00 0a 1b 00 06 40 20 23 00 00 00 00
>>>>>>> skb linear:   00000050: 00 00 00 00 00 00 00 00 00 12 20 23 00 00 00 00
>>>>>>> skb linear:   00000060: 00 00 00 00 00 00 00 00 00 11 bf 96 14 51 13 f9
>>>>>>> skb linear:   00000070: ae 27 a0 a8 2b e3 80 18 00 40 5b 6f 00 00 01 01
>>>>>>> skb linear:   00000080: 08 0a 42 d4 50 d5 4b 70 f8 1a
>>>>>>>
>>>>>>> Fixes: 04c20a9356f283da ("net: skip offload for NETIF_F_IPV6_CSUM if ipv6 header contains extension")
>>>>>>> Reported-by: Tianhao Zhao <tizhao@redhat.com>
>>>>>>> Suggested-by: Michal Schmidt <mschmidt@redhat.com>
>>>>>>> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
>>>>>>> Signed-off-by: Jakub Ramaseuski <jramaseu@redhat.com>
>>>>>>> ---
>>>>>>> ---
>>>>>>>  net/core/dev.c | 12 ++++++++++++
>>>>>>>  1 file changed, 12 insertions(+)
>>>>>>>
>>>>>>> diff --git a/net/core/dev.c b/net/core/dev.c
>>>>>>> index b28ce68830b2b..1d8a4d1da911e 100644
>>>>>>> --- a/net/core/dev.c
>>>>>>> +++ b/net/core/dev.c
>>>>>>> @@ -3778,6 +3778,18 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
>>>>>>>  		if (!(iph->frag_off & htons(IP_DF)))
>>>>>>>  			features &= ~NETIF_F_TSO_MANGLEID;
>>>>>>>  	}
>>>>>>> +
>>>>>>> +	/* NETIF_F_IPV6_CSUM does not support IPv6 extension headers,
>>>>>>> +	 * so neither does TSO that depends on it.
>>>>>>> +	 */
>>>>>>> +	if (features & NETIF_F_IPV6_CSUM &&
>>>>>>> +	    (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
>>>>>>> +	     (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
>>>>>>> +	      vlan_get_protocol(skb) == htons(ETH_P_IPV6))) &&
>>>>>>> +	    skb_transport_header_was_set(skb) &&
>>>>>>> +	    skb_network_header_len(skb) != sizeof(struct ipv6hdr) &&
>>>>>>> +	    !ipv6_has_hopopt_jumbo(skb))
>>>>>>> +		features &= ~(NETIF_F_IPV6_CSUM | NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4);
>>>>>>>  
>>>>>>>  	return features;
>>>>>>>  }
>>>>>> question about this patch affecting tunneled IPv6-in-IPv4 packets
>>>>>>
>>>>>> In our environment with a hinic NIC, we use VXLAN tunnels where
>>>>>> the outer header is IPv4 and the inner is IPv6. After this commit,
>>>>>> large packets no longer use hardware TSO and fall back to software segmentation.
>>>>>>
>>>>>> In the VXLAN IPv6-in-IPv4 case, `skb_shinfo(skb)->gso_type` includes
>>>>>> `SKB_GSO_TCPV6` (inner is IPv6 TCP), but the network header points to the outer
>>>>>> IPv4 header. Thus `skb_network_header_len(skb)` returns the IPv4 header length
>>>>>> (usually 20), which is not equal to `sizeof(struct ipv6hdr)` (40). This causes
>>>>>> the condition to trigger and clears `NETIF_F_TSO6`, even though the inner IPv6
>>>>>> packet has no extension headers and the device is capable of handling TSO for
>>>>>> such packets.
>>>>>>
>>>>>> Is it the intended behavior to disable TSO for all tunneled IPv6-in-IPv4 packets
>>>>>> when the NIC lacks NETIF_F_HW_CSUM, even if the inner IPv6 header has no extensions?
>>>>>>
>>>>>> Any feedback or guidance would be greatly appreciated.
>>>>>
>>>>> That is definitely unintended.
>>>>>
>>>>> Thanks for the clear analysis.
>>>>>
>>>>> I was about to write a refinement that might catch this case,
>>>>> something like
>>>>>
>>>>> @@ -3819,8 +3819,10 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
>>>>>             (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
>>>>>              (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
>>>>>               vlan_get_protocol(skb) == htons(ETH_P_IPV6))) &&
>>>>> -           skb_transport_header_was_set(skb) &&
>>>>> -           skb_network_header_len(skb) != sizeof(struct ipv6hdr))
>>>>> +             ((!skb->encapsulation &&
>>>>> +               skb_transport_header_was_set(skb) &&
>>>>> +               skb_network_header_len(skb) != sizeof(struct ipv6hdr)) ||
>>>>> +              (skb_inner_network_header_len(skb) != sizeof(struct ipv6hdr))))
>>>>>                 features &= ~(NETIF_F_IPV6_CSUM | NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4);
>>>>>
>>>>> But, how are these VXLAN IPv6-in-IPv4 packets having
>>>>> vlan_get_protocol(skb) == htons(ETH_P_IPV6)?
>>>>>
>>>>> Shouldn't that be the protocol of the outer headr, so ETH_P_IP, and
>>>>> thus this branch not reached at all? (Which itself would leave a false
>>>>> positive as now an inner network header with extensions would not be
>>>>> caught..)
>>>>
>>>> Also the tunnel could have ENCAP_TYPE_IPPROTO, and likely we need to
>>>> disable csum even in that case? Possibly something alike the following
>>>> could work?
>>>>
>>>> Side note, I *think* that replacing SKB_GSO_UDP_L4 with separate
>>>> SKB_GSO_UDPV4_L4 SKB_GSO_UDPV6_L4 would remove a bit of complexity in
>>>> serveral places, but I'm not sure how much invasive would be such a change.
>>>>
>>>> ---
>>>> diff --git a/net/core/dev.c b/net/core/dev.c
>>>> index 4af4cf2d63a4..f9824dfef376 100644
>>>> --- a/net/core/dev.c
>>>> +++ b/net/core/dev.c
>>>> @@ -3769,6 +3769,22 @@ static netdev_features_t
>>>> dflt_features_check(struct sk_buff *skb,
>>>>  	return vlan_features_check(skb, features);
>>>>  }
>>>>
>>>> +static bool skb_gso_has_extension_hdr(const struct sk_buff *skb)
>>>> +{
>>>> +	if (!skb->encapsulation)
>>>> +		return ((skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
>>>> +			(skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
>>>> +			 vlan_get_protocol(skb) == htons(ETH_P_IPV6))) &&
>>>> +			skb_transport_header_was_set(skb) &&
>>>> +			skb_network_header_len(skb) != sizeof(struct ipv6hdr));
>>>> +
>>>> +	return (skb->inner_protocol_type == ENCAP_TYPE_IPPROTO ||
>>>> +		((skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
>>>> +		  (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
>>>> +		   inner_ip_hdr(skb)->version == 6)) &&
>>>> +		 skb_inner_network_header_len(skb) != sizeof(struct ipv6hdr)));
>>>> +}
>>>> +
>>>>  static netdev_features_t gso_features_check(const struct sk_buff *skb,
>>>>  					    struct net_device *dev,
>>>>  					    netdev_features_t features)
>>>> @@ -3815,12 +3831,7 @@ static netdev_features_t gso_features_check(const
>>>> struct sk_buff *skb,
>>>>  	/* NETIF_F_IPV6_CSUM does not support IPv6 extension headers,
>>>>  	 * so neither does TSO that depends on it.
>>>>  	 */
>>>> -	if (features & NETIF_F_IPV6_CSUM &&
>>>> -	    (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
>>>> -	     (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
>>>> -	      vlan_get_protocol(skb) == htons(ETH_P_IPV6))) &&
>>>> -	    skb_transport_header_was_set(skb) &&
>>>> -	    skb_network_header_len(skb) != sizeof(struct ipv6hdr))
>>>> +	if (features & NETIF_F_IPV6_CSUM && skb_gso_has_extension_hdr(skb))
>>>>  		features &= ~(NETIF_F_IPV6_CSUM | NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4);
>>>>
>>>>  	return features;
>>>>
>>> Hi Paolo, Willem,
>>>
>>> Thank you both for the insightful analysis and the proposed fix.
>>>
>>> I have backported and tested Paolo's patch in our environment with hinic NIC.
>>> We focused on the VXLAN (IPv6-in-IPv4) scenario and the Native IPv6 scenario :
>>>
>>> Scenario               | IPv6 Ext-Headers | Result | Behavior
>>> -----------------------|------------------|--------|---------------
>>> VXLAN (IPv6-in-IPv4)   | No               | PASS   | HW TSO enabled
>>> VXLAN (IPv6-in-IPv4)   | Yes              | PASS   | SW GSO fallback
>>> Native IPv6            | No               | PASS   | HW TSO enabled
>>> Native IPv6            | Yes              | PASS   | SW GSO fallback
>>>
>>> Thanks again for the help!
>> Please, if you will and can, take it over to cook it in a formal patch.
> 
> Otherwise I can.
> 
> The check is also needed for tunnels that set ENCAP_TYPE_IPPROTO, such
> as sit. That condition can be removed as far as I can tell?
> 
> Only, I still do not see how this condition can have triggered, as
> vlan_get_protocol(skb) should be htons(ETH_P_IP).
> 
> I built a simple reproducer using vxlan over veth in virtme-ng, while
> changing veth's NETIF_F_.._CSUM to reach this code. That indeed shows
> correct ETH_P_IP.
> 
> Tangxin, can you show a stack trace when this condition hits? For
> instance by adding a WARN_ON_ONCE(1) inside that branch, or by using
> bpftrace:
> 
> sudo bpftrace -e 'kfunc:netif_skb_features { if (args->skb->encapsulation && args->skb->protocol == 0xDD86) { @[kstack] = count(); } }'
Hi Willem,

Sorry for the late reply.

I have tested this on Linux 7.0-rc4
(commit f338e77383789c0cae23ca3d48adcc5e9e137e3c).

In my VXLAN (IPv6-in-IPv4) environment,
vlan_get_protocol(skb) indeed returns htons(ETH_P_IP) as you expected.
However, the condition is still triggered because skb_shinfo(skb)->gso_type
contains SKB_GSO_TCPV6 (since the inner packet is IPv6 TCP).

Below is the call trace captured via WARN_ON_ONCE when the condition is hit:

WARNING: net/core/dev.c:3824 at gso_features_check+0xbc/0x158, CPU#10: python3/16193
CPU: 10 UID: 0 PID: 16193 Comm: python3 Kdump: loaded Not tainted 7.0.0-rc4+ #12 PREEMPT
Hardware name: Huawei TaiShan 200 (Model 2280)/BC82AMDD, BIOS 1.86 01/10/2022
pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : gso_features_check (net/core/dev.c:3824 (discriminator 1))
lr : netif_skb_features (net/core/dev.c:3837)
...
Call trace:
 gso_features_check (net/core/dev.c:3824 (discriminator 1))
 netif_skb_features (net/core/dev.c:3837)
 validate_xmit_skb (net/core/dev.c:4012)
 validate_xmit_skb_list (net/core/dev.c:4075)
 sch_direct_xmit (net/sched/sch_generic.c:335)
 __dev_xmit_skb (net/core/dev.c:4255 (discriminator 4))
 __dev_queue_xmit (net/core/dev.c:4804)
 neigh_hh_output (./include/net/neighbour.h:541)
 ip_finish_output2 (./include/net/neighbour.h:554 net/ipv4/ip_output.c:237)
 __ip_finish_output (net/ipv4/ip_output.c:315 net/ipv4/ip_output.c:297)
 ip_finish_output (net/ipv4/ip_output.c:325)
 ip_output (./include/linux/netfilter.h:307 net/ipv4/ip_output.c:438)
 ip_local_out (net/ipv4/ip_output.c:134)
 iptunnel_xmit (net/ipv4/ip_tunnel_core.c:99 (discriminator 4))
 udp_tunnel_xmit_skb (net/ipv4/udp_tunnel_core.c:195) [udp_tunnel]
 vxlan_xmit_one (drivers/net/vxlan/vxlan_core.c:2544) [vxlan]
 vxlan_xmit (drivers/net/vxlan/vxlan_core.c:2832) [vxlan]
 dev_hard_start_xmit (net/core/dev.c:3889)
 __dev_queue_xmit (net/core/dev.c:4836)
 ... (TCP/IPv6 stack)
 tcp_sendmsg (net/ipv4/tcp.c:1465)
 inet6_sendmsg (net/ipv6/af_inet6.c:653 (discriminator 2))

look forward to your patch.

Best regards,
Tangxin Xie


