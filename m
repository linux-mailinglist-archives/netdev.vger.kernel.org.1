Return-Path: <netdev+bounces-290691-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOA8Nc4DEGqLSQYAu9opvQ
	(envelope-from <netdev+bounces-290691-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:20:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 733D55AFED9
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B80E302AD2E
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 07:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA99E3043CE;
	Fri, 22 May 2026 07:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-berlin.de header.i=@tu-berlin.de header.b="KOUl2+RP"
X-Original-To: netdev@vger.kernel.org
Received: from mailrelay.tu-berlin.de (mailrelay.tu-berlin.de [130.149.7.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD3E3438AD;
	Fri, 22 May 2026 07:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.149.7.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779434255; cv=none; b=f3zkCoS+S2yQGZnZ6yePRrTuq/nu2T6bMYhC3NLsYkO8xszi+rCiJtFIb1v3rjdMaky2yB8BJgMVQXwpTec33sb9bzotPPA9nKPJNlF1Y8/D4pEveZH0H0GVVuoi6QfIhAfsW9tOTlCalSHpCbfzYEdRpnCSxjzPVHQUNkxsedI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779434255; c=relaxed/simple;
	bh=O/7QA3hMDEl+rstgMui5agIriJQQhGCYLz1fCr+7mSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Iv2J7C1mneALHWcuqi82nqGs08/jUvKoqlH/pq3EQKEkqaLpB1vL+FsDy6zmUz4zAXAlpZk1FqaU0hnexEX8r3p1ZWKpZ27bu6IbPGvlAfZ+WAKY4RF8KyaCOxT2Er5ESBJzZcBKSW6VRoTff9CbkA7DJubU8XO5vEu7hpACT4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-berlin.de; spf=pass smtp.mailfrom=tu-berlin.de; dkim=pass (2048-bit key) header.d=tu-berlin.de header.i=@tu-berlin.de header.b=KOUl2+RP; arc=none smtp.client-ip=130.149.7.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed;
  d=tu-berlin.de; s=dkim-tub26; t=1779434252;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9oWOf/aHh/5Lcx8JXS2leBh1/cj4AyZmSJ3+TnPIZi0=;
  b=KOUl2+RPTgBucNa+QiUfzCg3Ulv0u+fNGBH5qLgMhcgTo3l2ikq2stSY
   JMADme1zwg+omP+0bRQPkBVXpkZ+zXQyJPSMZUK52MXUGUU9F7Ha55GEA
   NvHMQD2qCsV294k+AlULMhD1+GGW7kMCdj69x5nPm/5JzzI3qUhN3DSss
   PfFqdB7W2l1CYMQsuNoJDdrIXfuiWBCxvsrIbFw2cCEPIBxJuAeZ8FvdA
   X8owSHFzz7/fSW/I7cgFdlQWMc8H8sSXNIqDxHpwUV9GkCvIM5tr2TeTw
   ISJPI+suFwl3hzDi7Olba12SSdm5dVcfWRLVW3F7TDC7UbKOqv+mfHHj7
   w==;
X-CSE-ConnectionGUID: 1j+tFTG8RKOAkZ3u2Btt6g==
X-CSE-MsgGUID: BDObot6kQci6pRs/VQjHkQ==
X-IronPort-AV: E=Sophos;i="6.24,161,1774306800"; 
   d="scan'208";a="47598901"
Received: from bulkmail.tu-berlin.de (HELO mail.tu-berlin.de) ([141.23.12.143])
  by mailrelay.tu-berlin.de with ESMTP; 22 May 2026 09:17:30 +0200
Message-ID: <2ca3d5a7-2c13-4df5-b6e7-33ff4e4bb23e@tu-berlin.de>
Date: Fri, 22 May 2026 09:17:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/5] veth: implement Byte Queue Limits (BQL)
 for latency reduction
To: Simon Schippers <simon@schippers-hamm.de>, Jesper Dangaard Brouer
	<hawk@kernel.org>, Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<kernel-team@cloudflare.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20260505132159.241305-1-hawk@kernel.org>
 <20260505132159.241305-4-hawk@kernel.org>
 <ee275aa6-af27-4dac-9afa-da88abde312b@schippers-hamm.de>
 <8f2f7f2e-6aa2-4e5b-b52d-0025b2525579@redhat.com>
 <e3a91545-13cd-4f87-8375-d707865bdbca@schippers-hamm.de>
 <6a597dbd-70bf-4b14-b495-2f7248fd3220@kernel.org>
 <20260508190626.4285fac0@kernel.org>
 <f459b95c-80d5-4e05-84b2-f574c92724de@kernel.org>
 <20260510085602.57c7a081@kernel.org>
 <daa05c21-dcfc-4cc4-aa22-9e25c7f6c743@kernel.org>
 <41023c34-87a3-4e4f-b3ab-3ed53d171910@schippers-hamm.de>
 <b78f002a-8cb9-4857-bf8f-0137e790f644@kernel.org>
 <873511fa-4316-4411-a76b-ec4c5805abd3@schippers-hamm.de>
 <18855e57-f050-411f-9958-d4babcc81ba3@kernel.org>
 <14348957-d061-4124-9bac-45df9cf6686c@schippers-hamm.de>
 <9a57bb41-114e-492b-9eaa-52237675bb7c@schippers-hamm.de>
Content-Language: en-US
From: =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>
In-Reply-To: <9a57bb41-114e-492b-9eaa-52237675bb7c@schippers-hamm.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tu-berlin.de,quarantine];
	R_DKIM_ALLOW(-0.20)[tu-berlin.de:s=dkim-tub26];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290691-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,cloudflare.com,lunn.ch,davemloft.net,google.com,kernel.org,iogearbox.net,gmail.com,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.koeppeler@tu-berlin.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tu-berlin.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[medium.com:url,veth_bql_bench.sh:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,veth_bql_test_virtme.sh:url,tu-berlin.de:mid,tu-berlin.de:dkim]
X-Rspamd-Queue-Id: 733D55AFED9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/19/26 10:51 PM, Simon Schippers wrote:
> On 5/12/26 23:55, Simon Schippers wrote:
>> On 5/12/26 15:54, Jesper Dangaard Brouer wrote:
>>>>> Nope, I'm using a bpftrace program to keep track of the inflight/limit
>>>>> in a BPF hashmap.  Reading from /sys will not be accurate.
>>>> Ah nice.
>>> Add the option --hist to have both NAPI and BQL histograms printed when
>>> script ends.  This will give you an accurate pattern of how inflight and
>>> limit evolves.
>>>
>>>>> I moved the selftests into a github repo [1] to allow us to collaborate
>>>>> and evaluate the changes more easily.  I explicitly kept the new BPF
>>>>> based BQL tracking as a commit[2] for your benefit.
>>>>>
>>>>>    [1] https://github.com/netoptimizer/veth-backpressure-performance-testing/tree/main/selftests
>>>>>
>>>>>    [2] https://github.com/netoptimizer/veth-backpressure-performance-testing/commit/f25c5dc92977
>>>> Thanks for sharing. After minor issues I was able to set it up
>>>> (currently I am just using plain v5, will look at the coalescing patch
>>>> when I find the time):
>>>>
>>>> Can confirm the latency reduction with the default settings, in my case
>>>> 4.888ms to 0.241ms.
>>>>
>>>> With the same script I was also able to see a performance slow down:
>>>> veth_bql_test_virtme.sh --qdisc fq_codel --nrules 0
>>>> --> ~510 Kpps
>>>> Same with --bql-disable
>>>> --> ~570 Kpps
>>>> --> 12% faster
>>>>
>>> Thanks for running these benchmarks.
>>>
>>> Notice that --nrules 0 can easily result in no-queuing (on average),
>>> because the veth NAPI consumer is faster than the producer.  You will
>>> likely see BQL inflight=1 and sink reported avg latency very low
>>> (remember it okay that sink get high latency penalty as long at ping
>>> latency remains low, as that show AQM is working).
>> I ran the benchmarks with --hist and I see what you mean.
>> I have very similar results.
>>
>> Is Jonas way [1] of modifiying pktgen maybe the best option to ensure
>> that the producer is faster than the consumer?
>>
>> [1] Link: https://lore.kernel.org/netdev/e8cdba04-aa9a-45c6-9807-8274b62920df@tu-dortmund.de/
>>
>>> Hi, so what I found is that pktgen does not respect
>>> __QUEUE_STATE_STACK_OFF. So the test data above is invalid, since it
>>> just sent packets even if the BQL "stopped" the queue. So I patched
>>> pktgen with the following:
>>>
>>> -       if (unlikely(netif_xmit_frozen_or_drv_stopped(txq))) {
>>> +       if (unlikely(netif_xmit_frozen_or_stopped(txq))) {
>>
>> After thinking more about the implementation I see possible issues:
>>
>> 1. netdev_tx_completed_queue() never reports more than burst=64 packets:
>>
>> BQL only increments the limit if the queue was starved. That means:
>> "The queue was over-limit in the last interval (the last time completion
>> processing ran), and there is no more data in the queue (i.e. it’s
>> empty)" [2]
>> But as only 64 packets are reported at max, the queue can only grow when
>> it is <= 64 packets. And then it can only stay at a limit >64 until the
>> next decrease of the limit.
>>
>>
>> 2. netdev_tx_completed_queue() is called in irregular intervals:
>>
>> If the consumer is slow it is called approx each tx_coal_usecs.
>> But if the consumer is fast it is called way more frequent, probably
>> in irregular intervals depending on the scheduling.
>> However, "BQL depends on periodic completion interrupts" [2].
>>
>> --> How about adding something like an interrupt that triggers every
>>      10us and calls netdev_tx_completed_queue() with n_bql collected from
>>      (multiple) veth_xdp_rcv runs? That could solve 1. and 2.
> Hi,
>
> I worked on a new version (see attachment) that addresses both issues.
>
> The major change is that instead of tracking the timestamp and packet
> count as local variables in veth_xdp_rcv(), they are now stored
> persistently in veth_rq as struct veth_bql_state. This allows completions
> to accumulate across multiple NAPI poll calls, so
> netdev_tx_completed_queue() can report more than 64 packets at once
> (see point 1). To get the time I am using (the fast) sched_clock() with
> a trick to avoid issues when switching between CPUs.
>
> For point 2, the coalescing deadline is now checked both before the
> receive loop (to flush completions that timed out since the previous
> poll) and after each consumed packet, making completion intervals more
> regular. Still the intervals can be smaller than
> VETH_BQL_COAL_TX_USECS, but I guess this is fine.
>
> I also found out that the BQL limit correlates closely with
> VETH_BQL_COAL_TX_USECS. It essentially reflects the latency we are
> targeting. I raised the default to 100 µs to allow DQL to converge to a
> higher limit (for reaching 255 in the testing below).
>
> With the patched pktgen (respecting __QUEUE_STATE_STACK_XOFF), testing
> shows:
> - --nrules 0: DQL limit reaches (up to) ~255
> - --nrules 10000: DQL limit converges to ~0 (with --gro-disable)
>
> These results are what I would expect from a BQL algorithm, but more
> testing is needed of course.
>
> What do you think?

Hi,

This is exactly what I had in mind for implementing the BQL algorithm
in this case. I did some testing with pktgen of this patch and also
compared it to the v5 version.

You can find an extension of the benchmark script with pktgen here [1],
as well as a wrapper script (veth_bql_bench.sh) to run the test script
with and without --bql-disable to report the difference. I also
configured pktgen to use the qdisc as suggested by Jesper.

Note: bpftrace needs to be disabled, otherwise it becomes the
bottleneck (at least on my machine) and pktgen throughput is halved
when enabled.

Here are the results:

v5 (not time-based):
--nrules 0 --pktgen --no-bpftrace
========================================
Results (average over 10 runs):
========================================
                        BQL on    BQL off
---                    ------    -------
Throughput (pps)      1980871    2169898
Ping RTT avg (ms)       0.065      0.162
Throughput diff         -8.7%   // BQL 8.7% lower throughput
RTT diff               -59.9%   // BQL 60% lower latency
========================================

Simon's time-based version:

Test args: --nrules 0 --pktgen --no-bpftrace
========================================
Results (average over 10 runs):
========================================
                            BQL on      BQL off
---                        ------      -------
Throughput (pps)          2166335      2153398
Ping RTT avg (ms)           0.165        0.165
Throughput diff              0.6%
RTT diff                     0.0%

--pktgen --no-bpftrace --nrules 3500
========================================
Results (average over 10 runs):
========================================
                            BQL on      BQL off
---                        ------      -------
Throughput (pps)            28569        28696
Ping RTT avg (ms)           1.327        8.409
Throughput diff             -0.4%
RTT diff                   -84.2%

Seems to work now as expected.

[1]https://github.com/jkoeppeler/veth-backpressure-performance-testing/tree/pktgen-and-benchmark

Thanks,
Jonas

>
> Thanks!
>
> BTW: I think that this implementation could also work for other
>       software interfaces.
>
>> [2] Link: https://medium.com/@tom_84912/byte-queue-limits-the-unauthorized-biography-61adc5730b83
>>
>>> There is an important gotcha. We actually have micro-burst of queuing
>>> (likely due to scheduling noise). Reading BQL stats from /sys will show
>>> BQL inflight=1, but when using the option --hist is it visible that
>>> @inflight have a long tail (see below signature).  The "qdisc" output
>>> line also shows this happening via requeues increasing (approx 17/sec in
>>> a test with 567Kpps). (this was with the time-based BQL impl).
>> I understand..
>>

