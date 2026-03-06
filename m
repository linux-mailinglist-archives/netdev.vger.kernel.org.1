Return-Path: <netdev+bounces-264709-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPCXDJGQqml0TQEAu9opvQ
	(envelope-from <netdev+bounces-264709-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 09:30:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1FC21D16B
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 09:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF548300FEF5
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 08:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342C43793C5;
	Fri,  6 Mar 2026 08:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DqkdCVgA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="djzEMDvZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191BA372678
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 08:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772785806; cv=none; b=TgEbuy947BlybBUF9PZ3sW5ebHmvexaUzYLxATmh5RkgBs6L5phWq/s7Y2ITxWWfKv6Zdkf8m5iM0+JXuz6fC36jpMjI8bnCEoGKwq84LQvxY4MR6e9cjnmhd6eiWj0M3jr9D2TiJ7Ehe1hQi7J8C2K7ONRlfkWAc9kJzajQ7hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772785806; c=relaxed/simple;
	bh=6qSvhn1KyHfnwBN6v/gB/mbpkvuw9hhSRMux91vs0Ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z0sn+hysYjAOAxOTIm5fO3XsQSStHFzIY4lHAckWusNdPutmALhaJgOawE/UqxeMbvp3aHHf7NFLC55L6mSDh6pGxCBTm0QLV8NQcCjm7Tvnd6LJfMYdbZgm6xzz3qrChd48bEpDGKde+MD0qEFXL7oEsznLY/J+7PzTo/oYaAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DqkdCVgA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=djzEMDvZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772785803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pwoIbOuPkwVSzkxpecMGIg/6594vjRS8teGbyEHo5Ko=;
	b=DqkdCVgAWe8M2Lh6bvdOhinu8INnPQPvUZKt4hS8Z97mc1zaRla823BUd0h+xXXO41hDHH
	5gi8xOc11BzKheg7Ss/EvWJku2f+mhCYSkJpJ7bTH051uhkt1c6RANdjF7x1O4FjZjIn+y
	qIZhSqp4XhiQ4JF9CjYuGweDKI+KJFI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-XlQnfhdWNZucuPBHSAS0Mg-1; Fri, 06 Mar 2026 03:30:01 -0500
X-MC-Unique: XlQnfhdWNZucuPBHSAS0Mg-1
X-Mimecast-MFC-AGG-ID: XlQnfhdWNZucuPBHSAS0Mg_1772785800
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4836cc0b38eso93153885e9.2
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 00:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772785800; x=1773390600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pwoIbOuPkwVSzkxpecMGIg/6594vjRS8teGbyEHo5Ko=;
        b=djzEMDvZw5k0mnde5h68Nfi82HOYA5AXS4nqZylFd1T2F51I8VyQCXvt6UuGe7zeqo
         flhzDqTA0lgRNsTCyZlYapgRPAS6S91oOT5j8aHBw9stwaFgRMJ66OQ0CGXldgOEir3q
         fk/c1TmbB09Qlwji4S7WeIcQF9Io/BAP+3X580xZLAJatRJe9FEQ+BfPjDXNUwfhXzi0
         lhTIVwXigZp9qhsNZPhNLMLjFM4IzmugVGvdLwOUvPBnNpQivPcYg65BjrztM9RpauAv
         L68j3nhHcwyaTubWv1T0JdeUT9xOg6gYoYYeL6d1UMuhJ3rKBCcgotQH+ZhS+TqZvRKs
         VzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772785800; x=1773390600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pwoIbOuPkwVSzkxpecMGIg/6594vjRS8teGbyEHo5Ko=;
        b=HWt+vUQFWjaHDIDCFBX8Hcw9GlT8bX1OMGFAmLyAUpnvrwpECtLfmZDaHvLjv2tbzC
         fTn0vfJ7nGEaQMD5O7ZFDcLX2gyVhCGFUPyfliXa76KR7gZbqQ3T2MXSJMrq1D4ZaWPQ
         wFGrTtCj8wdSZDJvVe0BpLpeQIXrizj2HQousOntb0PEY+mZR43qyIZOYH5q609s2zEd
         NM0BQC6P1gKVATF2xAK28pDq7h7c6ioQD8tSBUjKFUak5GV99yjrSblcu8b8EZxzVoif
         a5ZMR/9CaIcgbR6En81Sy6LsvznAHHLGj+mW0RdiTtqo4mPTn4pN9IpjJFOivIlXghTR
         y+Uw==
X-Forwarded-Encrypted: i=1; AJvYcCURFrZ7tzN9E07+QFuMts2NVQnDV5YwxJEexcxsEuEagugq4OSY1TmTD6U5J0b+Qb8yU/6rTf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlgy4TyxrjgNrTh9vbeCKzmPnchcBRvVAgQEZMTVHpz8imQKfz
	hYLXGMQXREfIU9xT9w/xwmRtpm+UqDPfBKgUT4cS4dsXUf8pdoTwOYlLrrDztjDQ3x5r/1Gd+Mj
	nF9x8YTHYroV4uB86NpH2HpLwT8e+CwNeL0uesahp9tgc3H0Q97EM2Vjb6w==
X-Gm-Gg: ATEYQzyGm8ymfarJbEBBIwSxUxRUF8uREQRWsEMmETBCgvtq25E9G/n9qyJRpMZ+MDd
	vHPsxLk5JzGCbP6il01H5TO/B/N+AEbTC7LjKCssOZulMjrTJ+IjrHk93kSaTeFivcMXsvqArZX
	x7Ydu00+f6kyKIzHs3gLnHsF5P0oPH5Bh1vSYPtv7LNehw849lxyp1qrkDjVq3sNQ/7tyeTrGpZ
	j/pqvNVCftoiBD5FnoI7z9MvROBnolDuJJ1jif4WVh5wqYCcgxhbA/WOVjPZhAS0yRiGuyIsDDh
	NUAWCYwjlU/IH/F6orvp5m5DQ2nUDvVL+Z7B/SzlcVtd1E2WJRcZc53kVBbz0y7B/Um/EJxGqoA
	5PNWArS4zHBT/JbwJx0M/qUDFPQ==
X-Received: by 2002:a05:600c:138a:b0:47e:e076:c7a5 with SMTP id 5b1f17b1804b1-4852691cf3amr18686675e9.11.1772785800128;
        Fri, 06 Mar 2026 00:30:00 -0800 (PST)
X-Received: by 2002:a05:600c:138a:b0:47e:e076:c7a5 with SMTP id 5b1f17b1804b1-4852691cf3amr18686195e9.11.1772785799625;
        Fri, 06 Mar 2026 00:29:59 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48527686fa9sm23673015e9.8.2026.03.06.00.29.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 00:29:59 -0800 (PST)
Message-ID: <9186ce75-4038-4467-b492-7a7821659842@redhat.com>
Date: Fri, 6 Mar 2026 09:29:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: gso: Forbid IPv6 TSO with extensions on
 devices with only IPV6_CSUM
To: xietangxin <xietangxin@yeah.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jakub Ramaseuski <jramaseu@redhat.com>, netdev@vger.kernel.org
Cc: kuba@kernel.org, horms@kernel.org, edumazet@google.com, sdf@fomichev.me,
 ahmed.zaki@intel.com, aleksander.lobakin@intel.com, benoit.monin@gmx.fr,
 willemb@google.com, Tianhao Zhao <tizhao@redhat.com>,
 Michal Schmidt <mschmidt@redhat.com>
References: <20250814105119.1525687-1-jramaseu@redhat.com>
 <0414e7e2-9a1c-4d7c-a99d-b9039cf68f40@yeah.net>
 <willemdebruijn.kernel.d12bc5fb9c16@gmail.com>
 <49dac359-326a-4f3a-8c18-9897ea7be498@redhat.com>
 <d6b8909d-705e-498d-ad9a-e61fa24c9d88@yeah.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <d6b8909d-705e-498d-ad9a-e61fa24c9d88@yeah.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8E1FC21D16B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264709-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[yeah.net,gmail.com,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,fomichev.me,intel.com,gmx.fr,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/6/26 7:32 AM, xietangxin wrote:
> On 3/5/2026 11:21 PM, Paolo Abeni wrote:
>> On 3/5/26 3:57 PM, Willem de Bruijn wrote:
>>> xietangxin wrote:
>>>> 在 2025/8/14 18:51, Jakub Ramaseuski 写道:
>>>>> When performing Generic Segmentation Offload (GSO) on an IPv6 packet that
>>>>> contains extension headers, the kernel incorrectly requests checksum offload
>>>>> if the egress device only advertises NETIF_F_IPV6_CSUM feature, which has 
>>>>> a strict contract: it supports checksum offload only for plain TCP or UDP 
>>>>> over IPv6 and explicitly does not support packets with extension headers.
>>>>> The current GSO logic violates this contract by failing to disable the feature
>>>>> for packets with extension headers, such as those used in GREoIPv6 tunnels.
>>>>>
>>>>> This violation results in the device being asked to perform an operation
>>>>> it cannot support, leading to a `skb_warn_bad_offload` warning and a collapse
>>>>> of network throughput. While device TSO/USO is correctly bypassed in favor
>>>>> of software GSO for these packets, the GSO stack must be explicitly told not 
>>>>> to request checksum offload.
>>>>>
>>>>> Mask NETIF_F_IPV6_CSUM, NETIF_F_TSO6 and NETIF_F_GSO_UDP_L4
>>>>> in gso_features_check if the IPv6 header contains extension headers to compute
>>>>> checksum in software.
>>>>>
>>>>> The exception is a BIG TCP extension, which, as stated in commit
>>>>> 68e068cabd2c6c53 ("net: reenable NETIF_F_IPV6_CSUM offload for BIG TCP packets"):
>>>>> "The feature is only enabled on devices that support BIG TCP TSO.
>>>>> The header is only present for PF_PACKET taps like tcpdump,
>>>>> and not transmitted by physical devices."
>>>>>
>>>>> kernel log output (truncated):
>>>>> WARNING: CPU: 1 PID: 5273 at net/core/dev.c:3535 skb_warn_bad_offload+0x81/0x140
>>>>> ...
>>>>> Call Trace:
>>>>>  <TASK>
>>>>>  skb_checksum_help+0x12a/0x1f0
>>>>>  validate_xmit_skb+0x1a3/0x2d0
>>>>>  validate_xmit_skb_list+0x4f/0x80
>>>>>  sch_direct_xmit+0x1a2/0x380
>>>>>  __dev_xmit_skb+0x242/0x670
>>>>>  __dev_queue_xmit+0x3fc/0x7f0
>>>>>  ip6_finish_output2+0x25e/0x5d0
>>>>>  ip6_finish_output+0x1fc/0x3f0
>>>>>  ip6_tnl_xmit+0x608/0xc00 [ip6_tunnel]
>>>>>  ip6gre_tunnel_xmit+0x1c0/0x390 [ip6_gre]
>>>>>  dev_hard_start_xmit+0x63/0x1c0
>>>>>  __dev_queue_xmit+0x6d0/0x7f0
>>>>>  ip6_finish_output2+0x214/0x5d0
>>>>>  ip6_finish_output+0x1fc/0x3f0
>>>>>  ip6_xmit+0x2ca/0x6f0
>>>>>  ip6_finish_output+0x1fc/0x3f0
>>>>>  ip6_xmit+0x2ca/0x6f0
>>>>>  inet6_csk_xmit+0xeb/0x150
>>>>>  __tcp_transmit_skb+0x555/0xa80
>>>>>  tcp_write_xmit+0x32a/0xe90
>>>>>  tcp_sendmsg_locked+0x437/0x1110
>>>>>  tcp_sendmsg+0x2f/0x50
>>>>> ...
>>>>> skb linear:   00000000: e4 3d 1a 7d ec 30 e4 3d 1a 7e 5d 90 86 dd 60 0e
>>>>> skb linear:   00000010: 00 0a 1b 34 3c 40 20 11 00 00 00 00 00 00 00 00
>>>>> skb linear:   00000020: 00 00 00 00 00 12 20 11 00 00 00 00 00 00 00 00
>>>>> skb linear:   00000030: 00 00 00 00 00 11 2f 00 04 01 04 01 01 00 00 00
>>>>> skb linear:   00000040: 86 dd 60 0e 00 0a 1b 00 06 40 20 23 00 00 00 00
>>>>> skb linear:   00000050: 00 00 00 00 00 00 00 00 00 12 20 23 00 00 00 00
>>>>> skb linear:   00000060: 00 00 00 00 00 00 00 00 00 11 bf 96 14 51 13 f9
>>>>> skb linear:   00000070: ae 27 a0 a8 2b e3 80 18 00 40 5b 6f 00 00 01 01
>>>>> skb linear:   00000080: 08 0a 42 d4 50 d5 4b 70 f8 1a
>>>>>
>>>>> Fixes: 04c20a9356f283da ("net: skip offload for NETIF_F_IPV6_CSUM if ipv6 header contains extension")
>>>>> Reported-by: Tianhao Zhao <tizhao@redhat.com>
>>>>> Suggested-by: Michal Schmidt <mschmidt@redhat.com>
>>>>> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
>>>>> Signed-off-by: Jakub Ramaseuski <jramaseu@redhat.com>
>>>>> ---
>>>>> ---
>>>>>  net/core/dev.c | 12 ++++++++++++
>>>>>  1 file changed, 12 insertions(+)
>>>>>
>>>>> diff --git a/net/core/dev.c b/net/core/dev.c
>>>>> index b28ce68830b2b..1d8a4d1da911e 100644
>>>>> --- a/net/core/dev.c
>>>>> +++ b/net/core/dev.c
>>>>> @@ -3778,6 +3778,18 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
>>>>>  		if (!(iph->frag_off & htons(IP_DF)))
>>>>>  			features &= ~NETIF_F_TSO_MANGLEID;
>>>>>  	}
>>>>> +
>>>>> +	/* NETIF_F_IPV6_CSUM does not support IPv6 extension headers,
>>>>> +	 * so neither does TSO that depends on it.
>>>>> +	 */
>>>>> +	if (features & NETIF_F_IPV6_CSUM &&
>>>>> +	    (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
>>>>> +	     (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
>>>>> +	      vlan_get_protocol(skb) == htons(ETH_P_IPV6))) &&
>>>>> +	    skb_transport_header_was_set(skb) &&
>>>>> +	    skb_network_header_len(skb) != sizeof(struct ipv6hdr) &&
>>>>> +	    !ipv6_has_hopopt_jumbo(skb))
>>>>> +		features &= ~(NETIF_F_IPV6_CSUM | NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4);
>>>>>  
>>>>>  	return features;
>>>>>  }
>>>> question about this patch affecting tunneled IPv6-in-IPv4 packets
>>>>
>>>> In our environment with a hinic NIC, we use VXLAN tunnels where
>>>> the outer header is IPv4 and the inner is IPv6. After this commit,
>>>> large packets no longer use hardware TSO and fall back to software segmentation.
>>>>
>>>> In the VXLAN IPv6-in-IPv4 case, `skb_shinfo(skb)->gso_type` includes
>>>> `SKB_GSO_TCPV6` (inner is IPv6 TCP), but the network header points to the outer
>>>> IPv4 header. Thus `skb_network_header_len(skb)` returns the IPv4 header length
>>>> (usually 20), which is not equal to `sizeof(struct ipv6hdr)` (40). This causes
>>>> the condition to trigger and clears `NETIF_F_TSO6`, even though the inner IPv6
>>>> packet has no extension headers and the device is capable of handling TSO for
>>>> such packets.
>>>>
>>>> Is it the intended behavior to disable TSO for all tunneled IPv6-in-IPv4 packets
>>>> when the NIC lacks NETIF_F_HW_CSUM, even if the inner IPv6 header has no extensions?
>>>>
>>>> Any feedback or guidance would be greatly appreciated.
>>>
>>> That is definitely unintended.
>>>
>>> Thanks for the clear analysis.
>>>
>>> I was about to write a refinement that might catch this case,
>>> something like
>>>
>>> @@ -3819,8 +3819,10 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
>>>             (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
>>>              (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
>>>               vlan_get_protocol(skb) == htons(ETH_P_IPV6))) &&
>>> -           skb_transport_header_was_set(skb) &&
>>> -           skb_network_header_len(skb) != sizeof(struct ipv6hdr))
>>> +             ((!skb->encapsulation &&
>>> +               skb_transport_header_was_set(skb) &&
>>> +               skb_network_header_len(skb) != sizeof(struct ipv6hdr)) ||
>>> +              (skb_inner_network_header_len(skb) != sizeof(struct ipv6hdr))))
>>>                 features &= ~(NETIF_F_IPV6_CSUM | NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4);
>>>
>>> But, how are these VXLAN IPv6-in-IPv4 packets having
>>> vlan_get_protocol(skb) == htons(ETH_P_IPV6)?
>>>
>>> Shouldn't that be the protocol of the outer headr, so ETH_P_IP, and
>>> thus this branch not reached at all? (Which itself would leave a false
>>> positive as now an inner network header with extensions would not be
>>> caught..)
>>
>> Also the tunnel could have ENCAP_TYPE_IPPROTO, and likely we need to
>> disable csum even in that case? Possibly something alike the following
>> could work?
>>
>> Side note, I *think* that replacing SKB_GSO_UDP_L4 with separate
>> SKB_GSO_UDPV4_L4 SKB_GSO_UDPV6_L4 would remove a bit of complexity in
>> serveral places, but I'm not sure how much invasive would be such a change.
>>
>> ---
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index 4af4cf2d63a4..f9824dfef376 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -3769,6 +3769,22 @@ static netdev_features_t
>> dflt_features_check(struct sk_buff *skb,
>>  	return vlan_features_check(skb, features);
>>  }
>>
>> +static bool skb_gso_has_extension_hdr(const struct sk_buff *skb)
>> +{
>> +	if (!skb->encapsulation)
>> +		return ((skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
>> +			(skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
>> +			 vlan_get_protocol(skb) == htons(ETH_P_IPV6))) &&
>> +			skb_transport_header_was_set(skb) &&
>> +			skb_network_header_len(skb) != sizeof(struct ipv6hdr));
>> +
>> +	return (skb->inner_protocol_type == ENCAP_TYPE_IPPROTO ||
>> +		((skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
>> +		  (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
>> +		   inner_ip_hdr(skb)->version == 6)) &&
>> +		 skb_inner_network_header_len(skb) != sizeof(struct ipv6hdr)));
>> +}
>> +
>>  static netdev_features_t gso_features_check(const struct sk_buff *skb,
>>  					    struct net_device *dev,
>>  					    netdev_features_t features)
>> @@ -3815,12 +3831,7 @@ static netdev_features_t gso_features_check(const
>> struct sk_buff *skb,
>>  	/* NETIF_F_IPV6_CSUM does not support IPv6 extension headers,
>>  	 * so neither does TSO that depends on it.
>>  	 */
>> -	if (features & NETIF_F_IPV6_CSUM &&
>> -	    (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
>> -	     (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
>> -	      vlan_get_protocol(skb) == htons(ETH_P_IPV6))) &&
>> -	    skb_transport_header_was_set(skb) &&
>> -	    skb_network_header_len(skb) != sizeof(struct ipv6hdr))
>> +	if (features & NETIF_F_IPV6_CSUM && skb_gso_has_extension_hdr(skb))
>>  		features &= ~(NETIF_F_IPV6_CSUM | NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4);
>>
>>  	return features;
>>
> Hi Paolo, Willem,
> 
> Thank you both for the insightful analysis and the proposed fix.
> 
> I have backported and tested Paolo's patch in our environment with hinic NIC.
> We focused on the VXLAN (IPv6-in-IPv4) scenario and the Native IPv6 scenario :
> 
> Scenario               | IPv6 Ext-Headers | Result | Behavior
> -----------------------|------------------|--------|---------------
> VXLAN (IPv6-in-IPv4)   | No               | PASS   | HW TSO enabled
> VXLAN (IPv6-in-IPv4)   | Yes              | PASS   | SW GSO fallback
> Native IPv6            | No               | PASS   | HW TSO enabled
> Native IPv6            | Yes              | PASS   | SW GSO fallback
> 
> Thanks again for the help!
Please, if you will and can, take it over to cook it in a formal patch.

Thanks,

Paolo


