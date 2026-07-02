Return-Path: <netdev+bounces-304026-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RajBOb8bRmpvKAsAu9opvQ
	(envelope-from <netdev+bounces-304026-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 10:05:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CDE6F48D7
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 10:05:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tu-dortmund.de header.s=unimail header.b="aS/e+tc2";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304026-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304026-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=tu-dortmund.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EC846300362F
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 08:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6309C40D587;
	Thu,  2 Jul 2026 08:05:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C24240315F;
	Thu,  2 Jul 2026 08:05:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782979516; cv=none; b=BClmAiak40BcNZG++hO48yvZBZs68ewdveFirucQyylTylDQjBE78qJ4MFdlPqWlvDZj/kV7BOJZ+L8aQ5faSLdU010JcpXa2blZuNIWQZCSjwNTHZDeuPqbF1w5P3AJEhDGZv8Tqy5Eazoj/jnFiiqMML+mEfmc+0y9k1dd1AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782979516; c=relaxed/simple;
	bh=p2tmfpj8SOa2U7J282F7R1AWFJjb7ICedeLy9HK85Eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cu+QU37HjVEPcA1Lqps9mY0cmVUDAVKJG6uEzdzCL99WBKJMrLVLa7n3N3lR6zEIA+iVqZx81Kra4E3ibCC4JUzp/5r9OKbMjV++2jj8CxAnqWUjfTJuS1tyy5NRpm4ptoGmH7kcjCT6ZgktdiORK1dfmMBSiXClBy8v9+2J7Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=aS/e+tc2; arc=none smtp.client-ip=129.217.128.51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
	s=unimail; t=1782979315;
	bh=9/xNQ5lc4ObNK1WLPMw5+LKCDYi+eeikoU+dGFfxuqA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=aS/e+tc2jWMpr3chXIvM+SMRMqw258rfRqGKaguyhXg7eXh49+L/+kE8KoR5nBsZW
	 FOAnTvXNC/Zg3NcO9AzsdlglYErn/fej+0r95Cdtuwor7l/CEo/WWO4syQ7tfWxHlS
	 Q8NX5d8dBLlOQFixRhYizmPjXKXCwcuZuToj5gEM=
Received: from [129.217.186.236] ([129.217.186.236])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 66281s2U004521
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 2 Jul 2026 10:01:54 +0200 (CEST)
Message-ID: <3299f304-81fd-4a84-8144-b9f1c94925ea@tu-dortmund.de>
Date: Thu, 2 Jul 2026 10:01:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] tun/tap & vhost-net: multi-threaded
 network performance
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Brett Sheffield <bacs@librecast.net>, regressions@lists.linux.dev,
        netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Tim Gebauer <tim.gebauer@tu-dortmund.de>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        linux-kernel@vger.kernel.org
References: <akVnoOYQOrt8k-Gu@karahi.librecast.net>
 <20260701165359-mutt-send-email-mst@kernel.org>
 <ef33f0a7-f0b7-4bc4-9263-10d2b480d717@tu-dortmund.de>
 <20260702034152-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <20260702034152-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tu-dortmund.de,none];
	R_DKIM_ALLOW(-0.20)[tu-dortmund.de:s=unimail];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304026-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:mst@redhat.com,m:bacs@librecast.net,m:regressions@lists.linux.dev,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:tim.gebauer@tu-dortmund.de,m:willemdebruijn.kernel@gmail.com,m:jasowang@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[librecast.net,lists.linux.dev,vger.kernel.org,kernel.org,tu-dortmund.de,gmail.com,redhat.com,lunn.ch,davemloft.net,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tu-dortmund.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,brettsheffield.com:url,tu-dortmund.de:dkim,tu-dortmund.de:mid,tu-dortmund.de:from_mime,librecast.net:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 83CDE6F48D7

On 7/2/26 09:42, Michael S. Tsirkin wrote:
> On Thu, Jul 02, 2026 at 09:24:59AM +0200, Simon Schippers wrote:
>> On 7/1/26 22:56, Michael S. Tsirkin wrote:
>>> On Wed, Jul 01, 2026 at 09:16:48PM +0200, Brett Sheffield wrote:
>>>> TL;DR - Commit 1d6e569b7d0c0b2736636749e4be0a27f3cefcb3 causes
>>>> significant performance regressions with TAP interfaces and multithreaded
>>>> network code. Please revert.
>>>>
>>>>
>>>> Librecast is an IPv6 multicast library. One of the tests (0055) fails under
>>>> Linux 7.2-rc1. The test performs data synchronization over IPv6 multicast using a TAP
>>>> interface. This test has run successfully on every stable, LTS and mainline RC
>>>> released in the past year. Every kernel with my Tested-by has run this test.
>>>>
>>>> There have been a bunch of changes to MLDv2 so I started bisecting there, but
>>>> the culprit is actually 1d6e569b7d0c0b2736636749e4be0a27f3cefcb3 "tun/tap &
>>>> vhost-net: avoid ptr_ring tail-drop when a qdisc is present"
>>>>
>>>> Reverting this commit fixes the test.
>>>>
>>>> To eliminate my code and any multicast weirdness, I ran tests with iperf3
>>>> comparing the same host running 7.2-rc1 both with and without 1d6e569b7d0
>>>> reverted.
>>
>> Thank you very much for your bisect!
>>
>> As the author, I am sorry for that regression!
>>
>>>
>>> Thanks a lot for the bisect! Reverting is not out of question, but
>>> just before we do, it is worth analyzing the situation.
>>>
>>> Could you pls tell us
>>> - do you see packet drops?
>>
>> iperf3 shows no TCP retransmissions, so there were never packet drops
>> when the patch was enabled.
>> It is the number after the sender data rate (example: threads 1,
>> reverted has 368 retransmissions/drops).
>>
>>> - does it help to increase the tun queue size?
>>
>> I agree, this would be great to know.
>>
>> However, even then we must act. I am considering IFF_BACKPRESSURE
>> as a feature flag, defaulting to off. It would just enable/disable
>> the stopping logic in tun_net_xmit() and the waking logic
>> in __tun_wake_queue(). If disabled, it would result in the same logic
>> as before.
>>
>> I could provide such a patch as [net] material.
>>
>> Thanks again!
> 
> Or BQL? I quickly wrote a prototype of that and it seems to work well -
> could you help test maybe?

BQL won't fix it I think.
A bigger TUN queue would probably fix it but BQL can only just adjust
to a smaller queue than 500 packets.

Unless you don't take the ptr_ring size as an upper limit for BQL and
resize the ptr_ring on the fly? I don't think this is viable.

I am currently working with others to get BQL working for veth.
TLDR: The issue with software interfaces is that there is no *periodic*
completion process [2]. For hardware there is.
I applied the same veth approach for TUN and it showed to fix
bufferbloat... But again won't fix the issue here I think.

[1] Link: https://lore.kernel.org/netdev/20260612083530.1650245-1-hawk@kernel.org/T/#u
[2] Link: https://lwn.net/Articles/469651/

> 
> 
>>>
>>> Thanks a lot!
>>>
>>>
>>>> CPU: AMD Ryzen 9 9950X

This processor has 2 CCDs. This probably makes the issue worse then it
was for me. My (older) Ryzen 5 5600X only has a single CCD.

Thanks.

>>>>
>>>> [ host ] - [ bridge ] - [ tap ] - [ guest (qemu) ]
>>>>
>>>> Running matching kernels on host and guest, I started iperf3 in server mode on
>>>> the guest and tested from the host so traffic passes through the tap interface.
>>>>
>>>> iperf3 -s -V                 # server
>>>> iperf3 -c guest -P nthreads  # client
>>>>
>>>> 7.2.0-rc1 (threads 1):
>>>>
>>>> [  5]   0.00-10.00  sec  20.2 GBytes  17.4 Gbits/sec    0            sender
>>>> [  5]   0.00-10.00  sec  2.00 GBytes  1.72 Gbits/sec                  receiver
>>>>
>>>> 7.2.0-rc1 (threads 1, reverted):
>>>>
>>>> [  5]   0.00-10.00  sec  15.3 GBytes  13.1 Gbits/sec  368            sender
>>>> [  5]   0.00-10.00  sec  2.00 GBytes  1.72 Gbits/sec                  receiver
>>>>
>>>> 7.2.0-rc1 (threads 2):
>>>>
>>>> [SUM]   0.00-10.00  sec  10.9 GBytes  9.33 Gbits/sec    0             sender
>>>> [SUM]   0.00-10.00  sec  4.00 GBytes  3.43 Gbits/sec                  receiver
>>>>
>>>> 7.2.0-rc1 (threads 2, reverted):
>>>>
>>>> [SUM]   0.00-10.00  sec  15.9 GBytes  13.7 Gbits/sec  1567             sender
>>>> [SUM]   0.00-10.00  sec  4.00 GBytes  3.43 Gbits/sec                  receiver
>>>>
>>>> 7.2.0-rc1 (threads 4):
>>>>
>>>> [SUM]   0.00-10.00  sec  10.9 GBytes  9.33 Gbits/sec    0             sender
>>>> [SUM]   0.00-10.00  sec  8.00 GBytes  6.87 Gbits/sec                  receiver
>>>>
>>>> 7.2.0-rc1 (threads 4, reverted):
>>>>
>>>> [SUM]   0.00-10.00  sec  16.5 GBytes  14.1 Gbits/sec  6701             sender
>>>> [SUM]   0.00-10.00  sec  8.00 GBytes  6.87 Gbits/sec                  receiver
>>>>
>>>> 7.2.0-rc1 (threads 8):
>>>>
>>>> [SUM]   0.00-10.00  sec  10.7 GBytes  9.15 Gbits/sec    0             sender
>>>> [SUM]   0.00-10.01  sec  10.6 GBytes  9.13 Gbits/sec                  receiver
>>>>
>>>> 7.2.0-rc1 (threads 8, reverted):
>>>>
>>>> [SUM]   0.00-10.00  sec  16.2 GBytes  14.0 Gbits/sec  19319             sender
>>>> [SUM]   0.00-10.00  sec  15.7 GBytes  13.5 Gbits/sec                  receiver
>>>>
>>>> 7.2.0-rc1 (threads 16):
>>>>
>>>> [SUM]   0.00-10.00  sec  10.9 GBytes  9.35 Gbits/sec    0             sender
>>>> [SUM]   0.00-10.01  sec  10.9 GBytes  9.32 Gbits/sec                  receiver
>>>>
>>>> 7.2.0-rc1 (threads 16, reverted):
>>>>
>>>> [SUM]   0.00-10.00  sec  14.4 GBytes  12.4 Gbits/sec  43593             sender
>>>> [SUM]   0.00-10.00  sec  14.4 GBytes  12.4 Gbits/sec                  receiver
>>>>
>>>>
>>>> As you can see, the new code works for single threaded, but for all other cases
>>>> there's a significant performance drop. I see this trade-off is mentioned in the
>>>> commit, but the performance drop off is much worse than suggested with the
>>>> current patch.
>>>>
>>>> In our multicast use case data is sent by multiple threads to multiple groups
>>>> simultaneously, this just breaks things to the extent that a <2 second test
>>>> times out after 5 minutes.
>>>>
>>>>
>>>> git bisect start
>>>> # status: waiting for both good and bad commits
>>>> # bad: [dc59e4fea9d83f03bad6bddf3fa2e52491777482] Linux 7.2-rc1
>>>> git bisect bad dc59e4fea9d83f03bad6bddf3fa2e52491777482
>>>> # status: waiting for good commit(s), bad commit known
>>>> # good: [36bdc0e815b4e8a05b9028d8ef8a25e1ead35cc1] net: usb: asix: ax88772: re-add usbnet_link_change() in phylink callbacks
>>>> git bisect good 36bdc0e815b4e8a05b9028d8ef8a25e1ead35cc1
>>>> # good: [db314398f618a3a23315f73c87f7d318eaf06c1b] Merge branch 'net-bridge-mcast-support-exponential-field-encoding'
>>>> git bisect good db314398f618a3a23315f73c87f7d318eaf06c1b
>>>> # bad: [079a028d6327e68cfa5d38b36123637b321c19a7] string: Remove strncpy() from the kernel
>>>> git bisect bad 079a028d6327e68cfa5d38b36123637b321c19a7
>>>> # bad: [f396f4005180928cd9e15e352a6512865d3bc908] Bluetooth: btmtk: fix URB leak in alloc_mtk_intr_urb error path
>>>> git bisect bad f396f4005180928cd9e15e352a6512865d3bc908
>>>> # bad: [ec1806a730a1c0b3d68a7f9afe81514fb0dd7991] netfilter: x_tables: disable 32bit compat interface in user namespaces
>>>> git bisect bad ec1806a730a1c0b3d68a7f9afe81514fb0dd7991
>>>> # good: [50c2d91c5dfa0e465826ec1f8dbad9cdc254bd85] mptcp: do not drop partial packets
>>>> git bisect good 50c2d91c5dfa0e465826ec1f8dbad9cdc254bd85
>>>> # good: [68993ced0f618e36cf33388f1e50223e5e6e78cc] Merge tag 'net-7.1-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
>>>> git bisect good 68993ced0f618e36cf33388f1e50223e5e6e78cc
>>>> # good: [34c78dff59a25110a4ce50c208e42a91490fe615] Merge branch 'net-use-ip_outnoroutes-drop-reason'
>>>> git bisect good 34c78dff59a25110a4ce50c208e42a91490fe615
>>>> # bad: [9587ed8137fb83d93f84b858337412f4500b21e9] Merge branch 'gve-add-support-for-ptp-gettimex64'
>>>> git bisect bad 9587ed8137fb83d93f84b858337412f4500b21e9
>>>> # bad: [83ea7fd73b11dd8cbf4416507a5eac3890b49fb0] net: dsa: microchip: remove unused phylink_mac_link_up() callback
>>>> git bisect bad 83ea7fd73b11dd8cbf4416507a5eac3890b49fb0
>>>> # bad: [f0de88303d5e7e04a1224bc7a00512b5a1c4fe7a] net: make is_skb_wmem() available to modules
>>>> git bisect bad f0de88303d5e7e04a1224bc7a00512b5a1c4fe7a
>>>> # bad: [c411baa463e85a779a7e68a00ba6298770b58c4c] netconsole: move push_ipv6() from netpoll
>>>> git bisect bad c411baa463e85a779a7e68a00ba6298770b58c4c
>>>> # good: [fba362c17d9d9211fc51f272156bb84fc23bdf98] ptr_ring: move free-space check into separate helper
>>>> git bisect good fba362c17d9d9211fc51f272156bb84fc23bdf98
>>>> # bad: [d0273dbe8be1640e597552f81faf1d6c9997d3e3] ipvlan: use netif_receive_skb() in ipvlan_process_multicast()
>>>> git bisect bad d0273dbe8be1640e597552f81faf1d6c9997d3e3
>>>> # bad: [3803065cd6b0630d4161d86aa04e2d1db0f3a0b5] Merge branch 'tun-tap-vhost-net-apply-qdisc-backpressure-on-full-ptr_ring-to-reduce-tx-drops'
>>>> git bisect bad 3803065cd6b0630d4161d86aa04e2d1db0f3a0b5
>>>> # bad: [1d6e569b7d0c0b2736636749e4be0a27f3cefcb3] tun/tap & vhost-net: avoid ptr_ring tail-drop when a qdisc is present
>>>> git bisect bad 1d6e569b7d0c0b2736636749e4be0a27f3cefcb3
>>>> # first bad commit: [1d6e569b7d0c0b2736636749e4be0a27f3cefcb3] tun/tap & vhost-net: avoid ptr_ring tail-drop when a qdisc is present
>>>>
>>>> -- 
>>>> Brett Sheffield (he/him)
>>>> Librecast - Decentralising the Internet with Multicast
>>>> https://librecast.net/
>>>> https://blog.brettsheffield.com/
>>>
> 

