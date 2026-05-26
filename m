Return-Path: <netdev+bounces-291728-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLxWLQ2+FWrYZgcAu9opvQ
	(envelope-from <netdev+bounces-291728-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:36:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B37E5D8DA0
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADC03304CA4B
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 14:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604924028EE;
	Tue, 26 May 2026 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-berlin.de header.i=@tu-berlin.de header.b="Ygm9wxIx"
X-Original-To: netdev@vger.kernel.org
Received: from mailrelay.tu-berlin.de (mailrelay.tu-berlin.de [130.149.7.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFAA400E19;
	Tue, 26 May 2026 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.149.7.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779807336; cv=none; b=FqL9+s/smvLD+XFdGn/DLn0y2EK9aaC7PJgeofjrSE0knJKUrIeJP4JDu+F9oB/Llm+Emd49QnuCuPG57QMOfOAtIRVjEcKW9WhbgfDMsfK17W6irjQrEMgQKpu/d/LyC1rE9soqBRaX5DSSOuHQmO1tbhtFVExNHgbPyQPvanA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779807336; c=relaxed/simple;
	bh=P6hElEIJNpofBMBo26mVoYneZRR7MGb5gF6y3qecHAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rbNMkp5rMtttipxKMe2HHFC1HRM0Dsj7vVuCufBCfZsdZipzJOPeBwbenN1aN/EgY97M3UnyjrB05MdKJXuWEL8TuO8G3aC2TwiQW4E/TFS8PO1R3aMmcDYCn7b+fq65Ae/JKrgb40b12kLaa1ASquZtg22hNvefkIvTgMgjSYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-berlin.de; spf=pass smtp.mailfrom=tu-berlin.de; dkim=pass (2048-bit key) header.d=tu-berlin.de header.i=@tu-berlin.de header.b=Ygm9wxIx; arc=none smtp.client-ip=130.149.7.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed;
  d=tu-berlin.de; s=dkim-tub26; t=1779807331;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pyWNwxbolqunvPZBZ+GILBJOR5SsKBcQghypzBDNI94=;
  b=Ygm9wxIx3RB4qt7GgaPU2LUbKDXA0HPM2Gddh/YwegivGZkXXD/LVlb9
   /fJ+vsS63u9i5JtGz/wsLlPAzdV1ovR3GO0vvGSeGbQ9W7Dx+eO726Btr
   S1hVQbDiw0matFzW4YRfjeesE7EC/KAUllTPoNLfBy0Se4aN8aIX2kLsL
   zA4VWWci1fBf4hXI1ELSzaOsmeEh3PBDa0I//pEijG77GuM/r9eNw/OzB
   Y8E5xIDcN3N9mP4Kt5qm9wVjOMk0WTmRywWLgYhgNbCRd/T8SL9RuWZNx
   T0oI+xokbTMgJyl0IwsIjTIkFVfk2QCC7ox2dQ5wIvxe6iyBhqmV1rojc
   A==;
X-CSE-ConnectionGUID: 23emey4AT5WKbCEEDO/JsA==
X-CSE-MsgGUID: EDHV3WqQRPudzcXqJAranQ==
X-IronPort-AV: E=Sophos;i="6.24,169,1774306800"; 
   d="scan'208";a="47775147"
Received: from postcard.tu-berlin.de (HELO mail.tu-berlin.de) ([141.23.12.142])
  by mailrelay.tu-berlin.de with ESMTP; 26 May 2026 16:55:28 +0200
Message-ID: <d23fd8e0-a0d3-4197-a130-2340d1c28fe0@tu-berlin.de>
Date: Tue, 26 May 2026 16:55:26 +0200
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
 <4ae9400a-8919-4ffc-8db3-0c334e2aa462@tu-berlin.de>
 <8e8b877b-a7ce-4b2f-9567-64c8dbb48411@schippers-hamm.de>
 <463e91cb-6c45-4d91-8737-39779fec5a49@tu-berlin.de>
 <b1c2d2c1-a70a-4bf4-baff-d0ac2f878722@schippers-hamm.de>
 <24d10b53-c545-4141-95a5-5c49c35c5d6c@tu-berlin.de>
 <c5b3a7ef-8ec7-4361-80bb-cf06e910350c@schippers-hamm.de>
Content-Language: en-US
From: =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>
In-Reply-To: <c5b3a7ef-8ec7-4361-80bb-cf06e910350c@schippers-hamm.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tu-berlin.de,quarantine];
	R_DKIM_ALLOW(-0.20)[tu-berlin.de:s=dkim-tub26];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291728-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,medium.com:url,veth_bql_test_virtme.sh:url,veth_bql_bench.sh:url,tu-berlin.de:mid,tu-berlin.de:dkim]
X-Rspamd-Queue-Id: 1B37E5D8DA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/26/26 4:35 PM, Simon Schippers wrote:
> On 5/26/26 11:54, Jonas Köppeler wrote:
>> On 5/23/26 6:09 PM, Simon Schippers wrote:
>>> On 5/22/26 18:26, Jonas Köppeler wrote:
>>>> On 5/22/26 10:41, Simon Schippers wrote:
>>>>> On 5/22/26 09:14, Jonas Köppeler wrote:
>>>>>> On 5/19/26 10:51 PM, Simon Schippers wrote:
>>>>>>> On 5/12/26 23:55, Simon Schippers wrote:
>>>>>>>> On 5/12/26 15:54, Jesper Dangaard Brouer wrote:
>>>>>>>>>>> Nope, I'm using a bpftrace program to keep track of the inflight/limit
>>>>>>>>>>> in a BPF hashmap.  Reading from /sys will not be accurate.
>>>>>>>>>> Ah nice.
>>>>>>>>> Add the option --hist to have both NAPI and BQL histograms printed when
>>>>>>>>> script ends.  This will give you an accurate pattern of how inflight and
>>>>>>>>> limit evolves.
>>>>>>>>>
>>>>>>>>>>> I moved the selftests into a github repo [1] to allow us to collaborate
>>>>>>>>>>> and evaluate the changes more easily.  I explicitly kept the new BPF
>>>>>>>>>>> based BQL tracking as a commit[2] for your benefit.
>>>>>>>>>>>
>>>>>>>>>>>       [1]https://github.com/netoptimizer/veth-backpressure-performance-testing/tree/main/selftests
>>>>>>>>>>>
>>>>>>>>>>>       [2]https://github.com/netoptimizer/veth-backpressure-performance-testing/commit/f25c5dc92977
>>>>>>>>>> Thanks for sharing. After minor issues I was able to set it up
>>>>>>>>>> (currently I am just using plain v5, will look at the coalescing patch
>>>>>>>>>> when I find the time):
>>>>>>>>>>
>>>>>>>>>> Can confirm the latency reduction with the default settings, in my case
>>>>>>>>>> 4.888ms to 0.241ms.
>>>>>>>>>>
>>>>>>>>>> With the same script I was also able to see a performance slow down:
>>>>>>>>>> veth_bql_test_virtme.sh --qdisc fq_codel --nrules 0
>>>>>>>>>> --> ~510 Kpps
>>>>>>>>>> Same with --bql-disable
>>>>>>>>>> --> ~570 Kpps
>>>>>>>>>> --> 12% faster
>>>>>>>>>>
>>>>>>>>> Thanks for running these benchmarks.
>>>>>>>>>
>>>>>>>>> Notice that --nrules 0 can easily result in no-queuing (on average),
>>>>>>>>> because the veth NAPI consumer is faster than the producer.  You will
>>>>>>>>> likely see BQL inflight=1 and sink reported avg latency very low
>>>>>>>>> (remember it okay that sink get high latency penalty as long at ping
>>>>>>>>> latency remains low, as that show AQM is working).
>>>>>>>> I ran the benchmarks with --hist and I see what you mean.
>>>>>>>> I have very similar results.
>>>>>>>>
>>>>>>>> Is Jonas way [1] of modifiying pktgen maybe the best option to ensure
>>>>>>>> that the producer is faster than the consumer?
>>>>>>>>
>>>>>>>> [1] Link:https://lore.kernel.org/netdev/e8cdba04-aa9a-45c6-9807-8274b62920df@tu-dortmund.de/
>>>>>>>>
>>>>>>>>> Hi, so what I found is that pktgen does not respect
>>>>>>>>> __QUEUE_STATE_STACK_OFF. So the test data above is invalid, since it
>>>>>>>>> just sent packets even if the BQL "stopped" the queue. So I patched
>>>>>>>>> pktgen with the following:
>>>>>>>>>
>>>>>>>>> -       if (unlikely(netif_xmit_frozen_or_drv_stopped(txq))) {
>>>>>>>>> +       if (unlikely(netif_xmit_frozen_or_stopped(txq))) {
>>>>>>>> After thinking more about the implementation I see possible issues:
>>>>>>>>
>>>>>>>> 1. netdev_tx_completed_queue() never reports more than burst=64 packets:
>>>>>>>>
>>>>>>>> BQL only increments the limit if the queue was starved. That means:
>>>>>>>> "The queue was over-limit in the last interval (the last time completion
>>>>>>>> processing ran), and there is no more data in the queue (i.e. it’s
>>>>>>>> empty)" [2]
>>>>>>>> But as only 64 packets are reported at max, the queue can only grow when
>>>>>>>> it is <= 64 packets. And then it can only stay at a limit >64 until the
>>>>>>>> next decrease of the limit.
>>>>>>>>
>>>>>>>>
>>>>>>>> 2. netdev_tx_completed_queue() is called in irregular intervals:
>>>>>>>>
>>>>>>>> If the consumer is slow it is called approx each tx_coal_usecs.
>>>>>>>> But if the consumer is fast it is called way more frequent, probably
>>>>>>>> in irregular intervals depending on the scheduling.
>>>>>>>> However, "BQL depends on periodic completion interrupts" [2].
>>>>>>>>
>>>>>>>> --> How about adding something like an interrupt that triggers every
>>>>>>>>         10us and calls netdev_tx_completed_queue() with n_bql collected from
>>>>>>>>         (multiple) veth_xdp_rcv runs? That could solve 1. and 2.
>>>>>>> Hi,
>>>>>>>
>>>>>>> I worked on a new version (see attachment) that addresses both issues.
>>>>>>>
>>>>>>> The major change is that instead of tracking the timestamp and packet
>>>>>>> count as local variables in veth_xdp_rcv(), they are now stored
>>>>>>> persistently in veth_rq as struct veth_bql_state. This allows completions
>>>>>>> to accumulate across multiple NAPI poll calls, so
>>>>>>> netdev_tx_completed_queue() can report more than 64 packets at once
>>>>>>> (see point 1). To get the time I am using (the fast) sched_clock() with
>>>>>>> a trick to avoid issues when switching between CPUs.
>>>>>>>
>>>>>>> For point 2, the coalescing deadline is now checked both before the
>>>>>>> receive loop (to flush completions that timed out since the previous
>>>>>>> poll) and after each consumed packet, making completion intervals more
>>>>>>> regular. Still the intervals can be smaller than
>>>>>>> VETH_BQL_COAL_TX_USECS, but I guess this is fine.
>>>>>>>
>>>>>>> I also found out that the BQL limit correlates closely with
>>>>>>> VETH_BQL_COAL_TX_USECS. It essentially reflects the latency we are
>>>>>>> targeting. I raised the default to 100 µs to allow DQL to converge to a
>>>>>>> higher limit (for reaching 255 in the testing below).
>>>>>>>
>>>>>>> With the patched pktgen (respecting __QUEUE_STATE_STACK_XOFF), testing
>>>>>>> shows:
>>>>>>> - --nrules 0: DQL limit reaches (up to) ~255
>>>>>>> - --nrules 10000: DQL limit converges to ~0 (with --gro-disable)
>>>>>>>
>>>>>>> These results are what I would expect from a BQL algorithm, but more
>>>>>>> testing is needed of course.
>>>>>>>
>>>>>>> What do you think?
>>>>>> Hi,
>>>>>>
>>>>>> This is exactly what I had in mind for implementing the BQL algorithm
>>>>>> in this case. I did some testing with pktgen of this patch and also
>>>>>> compared it to the v5 version.
>>>>>>
>>>>>> You can find an extension of the benchmark script with pktgen here [1],
>>>>>> as well as a wrapper script (veth_bql_bench.sh) to run the test script
>>>>>> with and without --bql-disable to report the difference. I also
>>>>>> configured pktgen to use the qdisc as suggested by Jesper.
>>>>> Great, I will use your pktgen solution from now on.
>>>>>
>>>>> Didn't know about the qdisc option, is there a performance difference
>>>>> with/without it? Or is it to have ping working next to pktgen?
>>>> Did not see any big difference performance-wise, but as you say, ping
>>>> works better with pktgen then.
>>>>
>>>>> Consider to do a pull request :)
>>>>>
>>>>>> Note: bpftrace needs to be disabled, otherwise it becomes the
>>>>>> bottleneck (at least on my machine) and pktgen throughput is halved
>>>>>> when enabled.
>>>>> Good to know.
>>>>>
>>>>>> Here are the results:
>>>>>>
>>>>>> v5 (not time-based):
>>>>>> --nrules 0 --pktgen --no-bpftrace
>>>>>> ========================================
>>>>>> Results (average over 10 runs):
>>>>>> ========================================
>>>>>>                           BQL on    BQL off
>>>>>> ---                    ------    -------
>>>>>> Throughput (pps)      1980871    2169898
>>>>>> Ping RTT avg (ms)       0.065      0.162
>>>>>> Throughput diff         -8.7%   // BQL 8.7% lower throughput
>>>>>> RTT diff               -59.9%   // BQL 60% lower latency
>>>>>> ========================================
>>>>>>
>>>>>> Simon's time-based version:
>>>>>>
>>>>>> Test args: --nrules 0 --pktgen --no-bpftrace
>>>>>> ========================================
>>>>>> Results (average over 10 runs):
>>>>>> ========================================
>>>>>>                               BQL on      BQL off
>>>>>> ---                        ------      -------
>>>>>> Throughput (pps)          2166335      2153398
>>>>>> Ping RTT avg (ms)           0.165        0.165
>>>>>> Throughput diff              0.6%
>>>>>> RTT diff                     0.0%
>>>>>>
>>>>>> --pktgen --no-bpftrace --nrules 3500
>>>>>> ========================================
>>>>>> Results (average over 10 runs):
>>>>>> ========================================
>>>>>>                               BQL on      BQL off
>>>>>> ---                        ------      -------
>>>>>> Throughput (pps)            28569        28696
>>>>>> Ping RTT avg (ms)           1.327        8.409
>>>>>> Throughput diff             -0.4%
>>>>>> RTT diff                   -84.2%
>>>>>>
>>>>> I think we should run benchmarks against the stock net-next to
>>>>> be safe.
>>>> --nrules 0 --pktgen --no-bpftrace
>>>> ========================================
>>>> Results (average over 10 runs):
>>>> ========================================
>>>>                        net-next
>>>> ---                  -------
>>>> Throughput (pps)     2285421
>>>> Ping RTT avg (ms)    0.161
>>>>
>>>> (slightly adjusted the output to better communicate the results)
>>>>
>>>> So in my case this means BQL implementation has ~5% lower throughput
>>>> compared to net-next. But please double check.
>>>>
>>> Yes, I will benchmark myself.
>>>
>>> There are probably some places where we can gain performance.
>>> For example, I see ptr_ring_empty() which could be swapped for
>>> __ptr_ring_empty() which would save a spinlock and unlock.
>>>
>>>>>> Seems to work now as expected.
>>>>> Yes, but I think we have to keep these points in mind:
>>>>>
>>>>> 1. Limit/Inflight can be bigger than VETH_RING_SIZE, because
>>>>>       packets can be enqueued in the same time as they are read out,
>>>>>       so netdev_tx_completed_queue() can theoretically be called with
>>>>>       many number of packets.
>>>>>       I do not think it is deal-breaking though.
>>>>>       I could see such high limits/inflights when looking at the /sys
>>>>>       BQL statistics..
>>>> For me this makes sense, that inflight just means the number of
>>>> packets not yet 'completed' or the number of packets that you
>>>> can send between two completion calls. I think this is not specific
>>>   From my understanding, I do think that this behavior is
>>> pretty specific.
>>>
>>> Typically BQL-enabled NIC drivers clear packets out of some
>>> internal buffer in their completion interrupt (or something
>>> similar). And after that they call netdev_tx_completed_queue().
>> You are right, because descriptors are freed at the same time when they are accounted for.
>>
>>>> to this implementation. But for long intervals this might result in
>>>> some problems because you can just fill the veth_ring to its capacity
>>>> quickly, and increasing latency if the receiver is slow.
>>> Yes, but I think the latency can only be approx. as big as the
>>> interval (can be higher with GRO enabled).
>> I think it's more like ~2.x times added latency in the worst case,
>> which is normal BQL behavior, but for large intervals 2x is a lot.
>> Of course this value is also capped by the time it takes to process
>> the 256 packets that fit in the ring buffer.
>>
>> For example, for a test run with fq_codel and 20K rules, and a ping
>> baseline of 1.7 ms without pktgen load, the results are:
>> tx-usecs   p99_ping_rtt (ms)
>> --------   -----------------
>>       0           5.223
>>     100           6.910
>>     500           7.197
>>    1000           6.967
>>    5000          16.233
>>   10000          25.033
>>   20000          44.133
>>
>> Also, the interval is sometimes dominated by the processing time of
>> a packet batch (and other effects). The default is 8 packets/batch
>> (see gro_normal_batch). This means that for 7 packets you see
>> processing times on the order of a few hundred nanoseconds, but for
>> the 8th you see the processing time of the whole batch (see table below).
>> With a ruleset > 1000 entries, this exceeds the default tx-usecs value,
>> which is why the p99 RTT increase is even larger than 2x tx-usecs
>> -- as you can see in the table for tx-usecs values 0-5000.
>>
>> tx-usecs 0 nrules 0
>> Percentile   per-packet processing time (µs)
>> ----------   -------------
>>      p5             0.316
>>     p25             0.382
>>     p50             0.442
>>     p75             0.508 -- fast enqueue to skb_list
>>     p95            68.304 -- batch processing time
>>
>> Setting gro_normal_batch to 1 makes the interval times more
>> accurate and improves p99 RTT slightly, though it's still > 2x the
>> tx-usecs latency increase.
>>
>> However, using smaller values > 0 means that you can benefit
>> from bql, but the actual interval might be larger than the
>> configured value. I do not think this is a deal breaker, but
>> something worth noting where the latencies come from.
> I understand and agree with your points.
> I also do not see anything deal-breaking.
> Yes, there is no guarantee for the latency, but BQL
> is best-effort anyway.
>
> I will wait for your new measurements, but there is no argument
> against a default tx-usecs of ~100us for now, right?

Yes, I think 100us is perfectly fine. I guess most of it was
just my curiosity why the latency values are as they are :)
But it feels like this will need some documentation, because
as we have seen, some values are a little different
from what you expect from bql. Inflight > veth_ring_size,
tx-usecs not necessarily achieving the configured value,
inflight can get stuck > 0. Wdyt?
But I think it works nicely overall.

>> Also worth noting: using fq_codel is better to use in this
>> case because it can fast track sparse flows. using sfq the
>> ping packet can get head of line blocked by the current quantum
>> of sfq, if my understanding is correct.
> Why don't we use a prio qdisc where ping gets prioritized?
> Then we do not have to worry about head of line blocking on
> the qdisc layer and instead can concentrate on veth.
>
>>>> To illustrate this have a look at [1]. There are some plots that
>>>> show the rtt vs. tx-usec config depending on nrules.
>>>>
>>>> [1] https://github.com/jkoeppeler/veth-backpressure-performance-testing/tree/pktgen-and-benchmark/results/tx-usecs
>>>>
>>> Nice plots! Great for finding a sane default value.
>> I did some more measurements to better understand whats
>> happening. I will upload the results latest by tomorrow
>> to the github repository mentioned above.
>>
>>>>> 2. sched_clock() is only valid on the same CPU. When a different
>>>>>       CPU starts executing its sched_clock() can be in the past compared
>>>>>       to the sched_clock() value saved by the previous CPU.
>>>>>       My trick...
>>>>>       min(s->time, sched_clock())
>>>>>       ... avoids potentially extremely long intervals between
>>>>>       netdev_tx_completed_queue() calls but is not perfect of course.
>>>>>       I think CPU hopping happens rarely enough for this to matter..
>>>>>       And also we have to keep this in mind [1]:
>>>>>       "An architecture may or may not provide an implementation of
>>>>>       sched_clock() on its own. If a local implementation is not provided,
>>>>>       the system jiffy counter will be used as sched_clock()."
>>>> So the problem with this is that with jiffies you have like millisecond
>>>> interval granularity, which might be too long in order to work properly.
>>>> Given the receiver completes 128 packet in 1ms (queue_completed interval),
>>>> the bql will set the limit at 256. Then the tx thread can quickly fill
>>>> the ring, and it then basically stopped until the 1ms interval is over.
>>>>
>>> Linux Mint only has 100Hz jiffies :^)
>> ok so 10ms granularity. Effectively disables BQL for the most part.
>> However, you can still benefit if your receive side is very slow.
>>
>>> I think you misunderstand something.
>>>
>>> +    if (peer_txq && state->n_bql && ptr_ring_empty(&rq->xdp_ring)) {
>              // Pairs with smp_wmb() in __ptr_ring_produce()
>
>>> +        smp_rmb();
>>> +        if (test_bit(__QUEUE_STATE_STACK_XOFF, &peer_txq->state))
>>> +            veth_bql_complete(state, peer_txq);
>>> +    }
>>>
>>> This snippet completes whenever the queue is empty and the
>>> netdev queue is stopped due to BQL.
>>> So then the interval is smaller than 1ms.
>>> I think, that is the reason why the pps is fine for 1ms in
>>> your benchmarks.
>> Without that snippet the queue stalls during ramp-up and
>> throughput never gets off the ground. But once the BQL limit has
>> stabilized, the snippet is no longer invoked -- with --nrules 0
>> the queue is never stopped, and with a slow receiver the queue is
>> not empty. So the snippet is needed for correct ramp-up, but it
>> doesn't affect steady-state throughput in these tests. This is also
>> confirmed by a test where I measure the time between intervals.
>> For 1000us across all nrules configurations the time ranges between
>> 1000-1400us.
> Yes, I agree. It only acts in the case of starvation (see [1])
> and I think it is an advantage that we react faster compared
> to other BQL implementations.
>
> Additionally the snippet is *required* because if the ring
> is empty and the txq stopped due to BQL, there are no more
> veth_xdp_recv() calls, permanently stalling everything.
> That is the reason for the memory barrier pairing in the snippet.
>
> [1] Link: https://medium.com/@tom_84912/byte-queue-limits-the-unauthorized-biography-61adc5730b83
>
>> The variance of the time between intervals is also quite good in
>> general, but not always exact the configured value. For most cases
>> +-5% from p50 value of the real interval.
>> Migrations between CPUs can also shorten an interval: if the new
>> CPU's sched_clock() is ahead of the previous one (say by 15 ms),
>> the apparent elapsed time within the current interval is inflated,
>> so only ~5 ms of real time remains before the deadline fires (with
>> the configured tx-usecs at 20 ms). Without migrations the interval
>> stays consistently close to the configured value. I don't think
>> this is a problem in practice -- it just adds some variance to the
>> p5 of the measured interval.
> Yes, and then we mistakenly decrease the BQL limit once.
> But we react fast on that starvation. So its fine.
>
>>>> I don't know how much this matters in practice. Not sure which architectures still hit the jiffies fallback.When in doubt we could disable BQL for those, or pin it to a "virtual queue size" via limit_min / limit_max similar to the v5 behavior and call queue_completed for every packet. Wdyt?
>>> Yes, probably not relevant, I think I would just disable it for those
>>> architectures, avoiding possible regressions.
>>>
>>>>> 3. Inflight can be stuck at a value>0 for a long time when packet
>>>>>       enqueueing stops. Only when packets are enqueued again,
>>>>>       (on the next veth_xdp_rcv() call,) netdev_tx_completed_queue() is
>>>>>       executed and inflight is set to 0 again.
>>>>>       Can also be seen when looking at the /sys BQL statistics.
>>>> This happens if the ring empties before the next queue_completed fires,
>>>> right?
>>>>
>>> Exactly.
>>>
>>>> Another thing: Is it counterintuitive to set the tx_usec_coal on the
>>>> receive device? Because this is a bql related config that is normally
>>>> configured on the TX side?
>>> Yes, I would say so.
>>>
>>>>> BTW: Yesterday, I worked on and refactored the code into its own .h
>>>>>         file as a library and it also works fine for TUN/TAP (+vhost-net)
>>>>>         for me :)
>>>> Nice! Thank you.
>>>> Jonas
>>>>
>>>>> Thanks for your work!
>>>>> Simon
>>>>>
>>>>> [1] Link: https://docs.kernel.org/timers/timekeeping.html
>>>>>
>>>>>> [1]https://github.com/jkoeppeler/veth-backpressure-performance-testing/tree/pktgen-and-benchmark
>>>>>>
>>>>>> Thanks,
>>>>>> Jonas
>>>>>>
>>>>>>> Thanks!
>>>>>>>
>>>>>>> BTW: I think that this implementation could also work for other
>>>>>>>          software interfaces.
>>>>>>>
>>>>>>>> [2] Link:https://medium.com/@tom_84912/byte-queue-limits-the-unauthorized-biography-61adc5730b83
>>>>>>>>
>>>>>>>>> There is an important gotcha. We actually have micro-burst of queuing
>>>>>>>>> (likely due to scheduling noise). Reading BQL stats from /sys will show
>>>>>>>>> BQL inflight=1, but when using the option --hist is it visible that
>>>>>>>>> @inflight have a long tail (see below signature).  The "qdisc" output
>>>>>>>>> line also shows this happening via requeues increasing (approx 17/sec in
>>>>>>>>> a test with 567Kpps). (this was with the time-based BQL impl).
>>>>>>>> I understand..
>>>>>>>>

