Return-Path: <netdev+bounces-306088-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qe8lFexcT2rofAIAu9opvQ
	(envelope-from <netdev+bounces-306088-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 10:33:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DE12A72E553
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 10:33:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=iogearbox.net header.s=default2302 header.b=gtnv9J4x;
	dmarc=pass (policy=reject) header.from=iogearbox.net;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306088-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-306088-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 67A4B3072D29
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 08:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43F53F1670;
	Thu,  9 Jul 2026 08:31:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A053EFFDC;
	Thu,  9 Jul 2026 08:31:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783585916; cv=none; b=llgLo5LanM7+zZ7FVA2OVzcdq7zGp0d86K5wKUuO69KM/xoye/Vhb/wB8Opdnf5aU+TiPbNpG8QhG/4TjNkdGk+zta26NoULaieLm7cKDjXAmSUx+zZ1s7SzqNxm77LIdQPgme/UQf8mUD7nYOaszJ+sra4K3PnuSKX+Fr3VFTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783585916; c=relaxed/simple;
	bh=Dtmon6vaQdULeooMR9XgBXuSxuCy4G1aKiy/0dMhAZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ibaHGTrIpj3iyU32uUik7aYJAXRBpeBJHlAwr01wzMcl8SZFG6IYWfgj6MXpV8Nq1YeqPHsFh2KRTaqnI41bAzydmFqwF49D7ZrjiIkOfWc2W0U7HRcewWg1AwFqRYO0t75OhUG+hPMo2799qLdJ4RXW+X8Rw8OxU/Oo8LsG6M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=gtnv9J4x; arc=none smtp.client-ip=213.133.104.62
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=zyJYfoN2AkhAREfybHYcueWfFEi8XhN3BVKByEKGZ6I=; b=gtnv9J4x2xU6CMTYY2QeyTKLcn
	czcvtvbwYTQqZaNKV0+vyettuduOs92CZfzhtjbO6ABOZK1k1G5mOkEC0eeNOdG1vR3Bkf6ustA7r
	9rvbpLeka7UicmpQ0eXyCJQS3UQeYOgP5MuzN+esBf2bXh0BIxG9lmYHRla+5Gd/+6CVsTg8YkYPF
	OnGn0YQ+znH6vbvhQL6omFaoQDjOg1JijLp6efn2GM0vsS7Kv8StvQW/4waAlJKrSrhAtm6LmDM9F
	92jAkkc7cgryB7Orbx8Dt0p0htHRz3v7V/kgs9bS958ika0PB8kSJu7k7x52bVd86iDkbOHycrxhW
	NFVKWdLQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1whkAX-000N6r-1B;
	Thu, 09 Jul 2026 10:31:41 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1whkAW-0005e7-1Z;
	Thu, 09 Jul 2026 10:31:40 +0200
Message-ID: <6bcf9de7-c28b-4397-8e3f-503a22d26a80@iogearbox.net>
Date: Thu, 9 Jul 2026 10:31:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v10 1/5] bpf: add bpf_icmp_send kfunc
To: Mahe Tardy <mahe.tardy@gmail.com>,
 Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 john.fastabend@gmail.com, jordan@jrife.io, martin.lau@linux.dev,
 yonghong.song@linux.dev, emil@etsalapatis.com, netdev@vger.kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, horms@kernel.org
References: <20260625110321.28236-1-mahe.tardy@gmail.com>
 <20260625110321.28236-2-mahe.tardy@gmail.com>
 <aj1V2ZdzY1EGtsma@devvm7509.cco0.facebook.com> <aj1b_z6h5xn42Hxe@gmail.com>
 <aj6kdnfAB0LJKDcR@devvm7509.cco0.facebook.com> <akJKY_x1GdO3MZJS@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <akJKY_x1GdO3MZJS@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28055/Thu Jul  9 08:25:20 2026)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-306088-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:mahe.tardy@gmail.com,m:sdf.kernel@gmail.com,m:bpf@vger.kernel.org,m:andrii@kernel.org,m:ast@kernel.org,m:john.fastabend@gmail.com,m:jordan@jrife.io,m:martin.lau@linux.dev,m:yonghong.song@linux.dev,m:emil@etsalapatis.com,m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:horms@kernel.org,m:mahetardy@gmail.com,m:sdfkernel@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,jrife.io,linux.dev,etsalapatis.com,google.com,redhat.com,davemloft.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE12A72E553

On 6/29/26 12:35 PM, Mahe Tardy wrote:
> On Fri, Jun 26, 2026 at 09:18:39AM -0700, Stanislav Fomichev wrote:
>> On 06/25, Mahe Tardy wrote:
>>> On Thu, Jun 25, 2026 at 09:24:59AM -0700, Stanislav Fomichev wrote:
>>>> On 06/25, Mahe Tardy wrote:
>>>
>>> [...]
>>>
>>>>> +__bpf_kfunc int bpf_icmp_send(struct __sk_buff *skb_ctx, int type, int code)
>>>>> +{
>>>>> +	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
>>>>> +	struct sk_buff *nskb;
>>>>> +	struct sock *sk;
>>>>> +
>>>>> +	sk = skb_to_full_sk(skb);
>>>>> +	if (sk && sk->sk_kern_sock &&
>>>>> +	    (sk->sk_protocol == IPPROTO_ICMP || sk->sk_protocol == IPPROTO_ICMPV6))
>>>>> +		return -EBUSY;
>>>>> +
>>>>> +	switch (skb->protocol) {
>>>>> +#if IS_ENABLED(CONFIG_INET)
>>>>> +	case htons(ETH_P_IP): {
>>>>> +		if (type != ICMP_DEST_UNREACH)
>>>>> +			return -EOPNOTSUPP;
>>>>> +		if (code < 0 || code > NR_ICMP_UNREACH ||
>>>>> +		    code == ICMP_FRAG_NEEDED) /* needs a valid next-hop MTU */
>>>>> +			return -EINVAL;
>>>>> +
>>>>> +		/* icmp_send expects skb_dst to be a real rtable. */
>>>>> +		if (!skb_valid_dst(skb))
>>>>> +			return -ENETUNREACH;
>>>>> +
>>>>> +		nskb = skb_clone(skb, GFP_ATOMIC);
>>>>> +		if (!nskb)
>>>>> +			return -ENOMEM;
>>>>> +
>>>>> +		memset(IPCB(nskb), 0, sizeof(*IPCB(nskb)));
>>>>> +		icmp_send(nskb, type, code, 0);
>>>>> +		consume_skb(nskb);
>>>>> +		break;
>>>>> +	}
>>>>> +#endif
>>>>> +#if IS_ENABLED(CONFIG_IPV6)
>>>>> +	case htons(ETH_P_IPV6):
>>>>> +		if (type != ICMPV6_DEST_UNREACH)
>>>>> +			return -EOPNOTSUPP;
>>>>> +		if (code < 0 || code > ICMPV6_REJECT_ROUTE)
>>>>> +			return -EINVAL;
>>>>
>>>> [..]
>>>>
>>>>> +		/* icmpv6_send may treat skb_dst as rt6_info. */
>>>>> +		if (skb_metadata_dst(skb))
>>>>> +			return -ENETUNREACH;
>>>>
>>>> A bit confused about this. Which part of icmpv6_send treats skb_dst as rt6_info?
>>>> (I see the original sashiko report about dst, but icmp6 seems to be not
>>>> requiring it)
>>>
>>> Yeah I was also a bit confused because this came out of nowhere as soon
>>> as I put the skb_valid_dst only on the IPv4 path (for different
>>> reasons), but there is actually a potential trace in which we have type
>>> confusion indeed:
>>>
>>> - icmp6_send() checks scoped source addresses and calls icmp6_iif() at net/ipv6/icmp.c:702
>>> - icmp6_iif() calls icmp6_dev() at net/ipv6/icmp.c:441
>>> - icmp6_dev() does skb_rt6_info(skb) for loopback/L3 master devices at net/ipv6/icmp.c:428
>>> - skb_rt6_info() casts any non-NULL dst to struct rt6_info at include/net/ip6_route.h:233
>>> - rt6->rt6i_idev is then dereferenced at net/ipv6/icmp.c:434
>>>
>>> When checking with pahole, we can find this on my local kernel:
>>>
>>> struct rt6_info {
>>> 	struct dst_entry           dst;                  /*     0   136 */
>>> 	/* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
>>> 	struct fib6_info *         from;                 /*   136     8 */
>>> 	int                        sernum;               /*   144     4 */
>>> 	struct rt6key              rt6i_dst;             /*   148    20 */
>>> 	struct rt6key              rt6i_src;             /*   168    20 */
>>> 	struct in6_addr            rt6i_gateway;         /*   188    16 */
>>>
>>> 	/* XXX 4 bytes hole, try to pack */
>>>
>>> 	/* --- cacheline 3 boundary (192 bytes) was 16 bytes ago --- */
>>> 	struct inet6_dev *         rt6i_idev;            /*   208     8 */  <--- we dereference this
>>> 	u32                        rt6i_flags;           /*   216     4 */
>>> 	short unsigned int         rt6i_nfheader_len;    /*   220     2 */
>>>
>>> 	/* size: 224, cachelines: 4, members: 9 */
>>> 	/* sum members: 218, holes: 1, sum holes: 4 */
>>> 	/* padding: 2 */
>>> 	/* last cacheline: 32 bytes */
>>> };
>>>
>>> And the metadata_dst would look like this:
>>>
>>> struct metadata_dst {
>>> 	struct dst_entry           dst;                  /*     0   136 */
>>> 	/* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
>>> 	enum metadata_type         type;                 /*   136     4 */
>>>
>>> 	/* XXX 4 bytes hole, try to pack */
>>>
>>> 	union {
>>> 		struct ip_tunnel_info tun_info;          /*   144    96 */
>>> 		struct hw_port_info port_info;           /*   144    16 */
>>> 		struct macsec_info macsec_info;          /*   144     8 */
>>> 		struct xfrm_md_info xfrm_info;           /*   144    16 */
>>> 	} u;                                             /*   144    96 */  <--- we land on this union
>>>
>>> 	/* size: 240, cachelines: 4, members: 3 */
>>> 	/* sum members: 236, holes: 1, sum holes: 4 */
>>> 	/* last cacheline: 48 bytes */
>>> };
>>>
>>> Let's say it's a struct ip_tunnel_info:
>>>
>>> struct ip_tunnel_info {
>>> 	struct ip_tunnel_key       key;                  /*     0    64 */
>>>
>>> 	/* XXX last struct has 7 bytes of padding */
>>>
>>> 	/* --- cacheline 1 boundary (64 bytes) --- */
>>> 	struct ip_tunnel_encap     encap;                /*    64     8 */  <--- 144 + 64 = 208 we land here
>>> 	struct dst_cache           dst_cache;            /*    72    16 */
>>> 	u8                         options_len;          /*    88     1 */
>>> 	u8                         mode;                 /*    89     1 */
>>>
>>> 	/* size: 96, cachelines: 2, members: 5 */
>>> 	/* padding: 6 */
>>> 	/* paddings: 1, sum paddings: 7 */
>>> 	/* last cacheline: 32 bytes */
>>> };
>>>
>>> So I imagine this is fairly tricky to trigger but still a case of type
>>> confusion. I have actually no idea how likely this can happen from my
>>> call but the trace makes sense at least.
>>
>> That logic seems to exist for the icmp6_send to find the input device
>> (since the expected use-case for calling icmp6_send is to the incoming
>> skb). And since you're mainly doing egress, I don't think this path will
>> ever trigger (iow the check is not needed)?
>>
>> Maybe you can add cgroup_ingress test case? Looks like this rt6_info
>> path might trigger for ipv6 lo? I don't see any ingress test in your
>> series, so might be good to have one regardless?
> 
> The initial reason I added only egress is because the use case of this
> makes more sense if that's your local kernel giving you feedback about a
> connection you are trying to establish, as a process, but is prevented.
> 
> But indeed, I could extend the test to ingress as well, I'd just like
> ideally getting an ack from networking maintainers since this is already
> v10 of this, before making some new changes.

Sry for the delay, Mahe. Not speaking for net maintainers, but if the
skb_metadata_dst() test in IPv6 would be made more strict and align with
IPv4 by erroring out on !skb_valid_dst(skb), would this work? It would
reject NULL dst for IPv6 case when someone would push a synthetic TEST_RUN
skb to spoofe an icmpv6 injection without CAP_NET_ADMIN fwiw. Otherwise
lgtm.

Thanks,
Daniel

