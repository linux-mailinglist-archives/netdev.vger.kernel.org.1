Return-Path: <netdev+bounces-291124-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2l4bLEHREWrRqgYAu9opvQ
	(envelope-from <netdev+bounces-291124-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 18:09:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A68CD5BFC03
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 18:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 91D283004680
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 16:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9809B2FD1CA;
	Sat, 23 May 2026 16:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=schippers-hamm.de header.i=simon@schippers-hamm.de header.b="w0ApESuB"
X-Original-To: netdev@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C529B2E62A9;
	Sat, 23 May 2026 16:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779552572; cv=none; b=dP8gbkw7hT/WxOTxNN6QMjvD3pOKyc5mczVRF+NQ0U7XNkk8ush1FylDHghITxGPHRx0Z0timguF9Dwrg/QGRDEHLqXUob6jY61oAAD3W4lQ7QJq9l6Ls05KmswEfY21WEc92J2BVxRfqrQvT1zc+S//C2WHwnYToFEzdprCipI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779552572; c=relaxed/simple;
	bh=Vg8oaWZx6sLe4tzpE/86tv/JlQm2ujJdAdij7tFK6xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OOjfFVSEMQpt/H+9bEOyyXICj3EEYf9y97/lrdBlyLDTlhrP1ljlS4uPsUhAgH4ztjugCdjh40MGBQl/ie8iPLIRHWaLKrdH2gqVV5lltO2tk7+a9+YBIKc8wwpg+/e1HsgA0FLG2NYUsnZ1t2iO4dgAA6zpbzIDIYsWKw595tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schippers-hamm.de; spf=pass smtp.mailfrom=schippers-hamm.de; dkim=pass (2048-bit key) header.d=schippers-hamm.de header.i=simon@schippers-hamm.de header.b=w0ApESuB; arc=none smtp.client-ip=212.227.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schippers-hamm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schippers-hamm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schippers-hamm.de;
	s=s1-ionos; t=1779552559; x=1780157359; i=simon@schippers-hamm.de;
	bh=CYghfYheMUN7/lzKc+78tvSJPEULY+6KsPWv1BTf5Vc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=w0ApESuBx6hZju4/TBrptlEYgY58+xDSHowPPdvl8B5OZs3MthxMmjNgbUgATGbi
	 ij/mGybdPhCBh/PI29hjFOpDwNGPyPSpc/R9SYFKbZhmUTkJrWpu6TlFO5RvjjNNl
	 xQvDTXNS3lo5/FDeSyPOCw6qXWXTs+ZfFcn3+qEWuzSqfk/c+5EvD/QSdpvqXst3t
	 Ve90e55CgRUyc5F5eEhyIpZn3NnQ6ChCkar0bmVbI2eS6+ReMVoAxwzPYH4xMvhjp
	 01B9xzHuakVJFsVfd8IEG8YQfbsKhe/gA2RitkhcFZ9lr9b7HKlT33Nhu7C3MwObm
	 uA6QTyz+ddtoI8MsBQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue010
 [212.227.15.134]) with ESMTPSA (Nemesis) id 1MysiI-1xDXx72jLO-016x0v; Sat, 23
 May 2026 18:09:19 +0200
Message-ID: <b1c2d2c1-a70a-4bf4-baff-d0ac2f878722@schippers-hamm.de>
Date: Sat, 23 May 2026 18:09:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/5] veth: implement Byte Queue Limits (BQL)
 for latency reduction
To: =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 kernel-team@cloudflare.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
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
 <4ae9400a-8919-4ffc-8db3-0c334e2aa462@tu-berlin.de>
 <8e8b877b-a7ce-4b2f-9567-64c8dbb48411@schippers-hamm.de>
 <463e91cb-6c45-4d91-8737-39779fec5a49@tu-berlin.de>
Content-Language: en-US
From: Simon Schippers <simon@schippers-hamm.de>
In-Reply-To: <463e91cb-6c45-4d91-8737-39779fec5a49@tu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wAHI8OGDBkslZbMeiX1Ws9DX+3jjHJPCPw/equU1/sy1t3SUbMd
 wsUd8mQwqqAWVDlE/j6UmQiB16fUW2j39hp663kmhWLHs/yhVulj3ZVUDYD05tiVsQC1nn0
 PyecSsB9rvfTwzML5rrFkkHwRFvSeswEK0Bjg2c5ep6ODDJbw7DR43r5hCqeTqfk/5NulNV
 qrkNdhqCsRLavQ8ufN2vQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:laq9K7QavDY=;NX6VdrsBNo7fAsrErVfx2hcp4Xd
 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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[schippers-hamm.de,none];
	R_DKIM_ALLOW(-0.20)[schippers-hamm.de:s=s1-ionos];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291124-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,cloudflare.com,lunn.ch,davemloft.net,google.com,kernel.org,iogearbox.net,gmail.com,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simon@schippers-hamm.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[schippers-hamm.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[medium.com:url,schippers-hamm.de:mid,schippers-hamm.de:dkim,veth_bql_bench.sh:url]
X-Rspamd-Queue-Id: A68CD5BFC03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/22/26 18:26, Jonas K=C3=B6ppeler wrote:
> On 5/22/26 10:41, Simon Schippers wrote:
>> On 5/22/26 09:14, Jonas K=C3=B6ppeler wrote:
>>> On 5/19/26 10:51 PM, Simon Schippers wrote:
>>>> On 5/12/26 23:55, Simon Schippers wrote:
>>>>> On 5/12/26 15:54, Jesper Dangaard Brouer wrote:
>>>>>>>> Nope, I'm using a bpftrace program to keep track of the inflight/=
limit
>>>>>>>> in a BPF hashmap.  Reading from /sys will not be accurate.
>>>>>>> Ah nice.
>>>>>> Add the option --hist to have both NAPI and BQL histograms printed =
when
>>>>>> script ends.  This will give you an accurate pattern of how infligh=
t and
>>>>>> limit evolves.
>>>>>>
>>>>>>>> I moved the selftests into a github repo [1] to allow us to colla=
borate
>>>>>>>> and evaluate the changes more easily.  I explicitly kept the new =
BPF
>>>>>>>> based BQL tracking as a commit[2] for your benefit.
>>>>>>>>
>>>>>>>>     [1]https://github.com/netoptimizer/veth-backpressure-performa=
nce-testing/tree/main/selftests
>>>>>>>>
>>>>>>>>     [2]https://github.com/netoptimizer/veth-backpressure-performa=
nce-testing/commit/f25c5dc92977
>>>>>>> Thanks for sharing. After minor issues I was able to set it up
>>>>>>> (currently I am just using plain v5, will look at the coalescing p=
atch
>>>>>>> when I find the time):
>>>>>>>
>>>>>>> Can confirm the latency reduction with the default settings, in my=
 case
>>>>>>> 4.888ms to 0.241ms.
>>>>>>>
>>>>>>> With the same script I was also able to see a performance slow dow=
n:
>>>>>>> veth_bql_test_virtme.sh --qdisc fq_codel --nrules 0
>>>>>>> --> ~510 Kpps
>>>>>>> Same with --bql-disable
>>>>>>> --> ~570 Kpps
>>>>>>> --> 12% faster
>>>>>>>
>>>>>> Thanks for running these benchmarks.
>>>>>>
>>>>>> Notice that --nrules 0 can easily result in no-queuing (on average)=
,
>>>>>> because the veth NAPI consumer is faster than the producer.  You wi=
ll
>>>>>> likely see BQL inflight=3D1 and sink reported avg latency very low
>>>>>> (remember it okay that sink get high latency penalty as long at pin=
g
>>>>>> latency remains low, as that show AQM is working).
>>>>> I ran the benchmarks with --hist and I see what you mean.
>>>>> I have very similar results.
>>>>>
>>>>> Is Jonas way [1] of modifiying pktgen maybe the best option to ensur=
e
>>>>> that the producer is faster than the consumer?
>>>>>
>>>>> [1] Link:https://lore.kernel.org/netdev/e8cdba04-aa9a-45c6-9807-8274=
b62920df@tu-dortmund.de/
>>>>>
>>>>>> Hi, so what I found is that pktgen does not respect
>>>>>> __QUEUE_STATE_STACK_OFF. So the test data above is invalid, since i=
t
>>>>>> just sent packets even if the BQL "stopped" the queue. So I patched
>>>>>> pktgen with the following:
>>>>>>
>>>>>> -       if (unlikely(netif_xmit_frozen_or_drv_stopped(txq))) {
>>>>>> +       if (unlikely(netif_xmit_frozen_or_stopped(txq))) {
>>>>> After thinking more about the implementation I see possible issues:
>>>>>
>>>>> 1. netdev_tx_completed_queue() never reports more than burst=3D64 pa=
ckets:
>>>>>
>>>>> BQL only increments the limit if the queue was starved. That means:
>>>>> "The queue was over-limit in the last interval (the last time comple=
tion
>>>>> processing ran), and there is no more data in the queue (i.e. it=E2=
=80=99s
>>>>> empty)" [2]
>>>>> But as only 64 packets are reported at max, the queue can only grow =
when
>>>>> it is <=3D 64 packets. And then it can only stay at a limit >64 unti=
l the
>>>>> next decrease of the limit.
>>>>>
>>>>>
>>>>> 2. netdev_tx_completed_queue() is called in irregular intervals:
>>>>>
>>>>> If the consumer is slow it is called approx each tx_coal_usecs.
>>>>> But if the consumer is fast it is called way more frequent, probably
>>>>> in irregular intervals depending on the scheduling.
>>>>> However, "BQL depends on periodic completion interrupts" [2].
>>>>>
>>>>> --> How about adding something like an interrupt that triggers every
>>>>>       10us and calls netdev_tx_completed_queue() with n_bql collecte=
d from
>>>>>       (multiple) veth_xdp_rcv runs? That could solve 1. and 2.
>>>> Hi,
>>>>
>>>> I worked on a new version (see attachment) that addresses both issues=
.
>>>>
>>>> The major change is that instead of tracking the timestamp and packet
>>>> count as local variables in veth_xdp_rcv(), they are now stored
>>>> persistently in veth_rq as struct veth_bql_state. This allows complet=
ions
>>>> to accumulate across multiple NAPI poll calls, so
>>>> netdev_tx_completed_queue() can report more than 64 packets at once
>>>> (see point 1). To get the time I am using (the fast) sched_clock() wi=
th
>>>> a trick to avoid issues when switching between CPUs.
>>>>
>>>> For point 2, the coalescing deadline is now checked both before the
>>>> receive loop (to flush completions that timed out since the previous
>>>> poll) and after each consumed packet, making completion intervals mor=
e
>>>> regular. Still the intervals can be smaller than
>>>> VETH_BQL_COAL_TX_USECS, but I guess this is fine.
>>>>
>>>> I also found out that the BQL limit correlates closely with
>>>> VETH_BQL_COAL_TX_USECS. It essentially reflects the latency we are
>>>> targeting. I raised the default to 100 =C2=B5s to allow DQL to conver=
ge to a
>>>> higher limit (for reaching 255 in the testing below).
>>>>
>>>> With the patched pktgen (respecting __QUEUE_STATE_STACK_XOFF), testin=
g
>>>> shows:
>>>> - --nrules 0: DQL limit reaches (up to) ~255
>>>> - --nrules 10000: DQL limit converges to ~0 (with --gro-disable)
>>>>
>>>> These results are what I would expect from a BQL algorithm, but more
>>>> testing is needed of course.
>>>>
>>>> What do you think?
>>> Hi,
>>>
>>> This is exactly what I had in mind for implementing the BQL algorithm
>>> in this case. I did some testing with pktgen of this patch and also
>>> compared it to the v5 version.
>>>
>>> You can find an extension of the benchmark script with pktgen here [1]=
,
>>> as well as a wrapper script (veth_bql_bench.sh) to run the test script
>>> with and without --bql-disable to report the difference. I also
>>> configured pktgen to use the qdisc as suggested by Jesper.
>> Great, I will use your pktgen solution from now on.
>>
>> Didn't know about the qdisc option, is there a performance difference
>> with/without it? Or is it to have ping working next to pktgen?
>=20
> Did not see any big difference performance-wise, but as you say, ping
> works better with pktgen then.
>=20
>> Consider to do a pull request :)
>>
>>> Note: bpftrace needs to be disabled, otherwise it becomes the
>>> bottleneck (at least on my machine) and pktgen throughput is halved
>>> when enabled.
>> Good to know.
>>
>>> Here are the results:
>>>
>>> v5 (not time-based):
>>> --nrules 0 --pktgen --no-bpftrace
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> Results (average over 10 runs):
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>                         BQL on    BQL off
>>> ---                    ------    -------
>>> Throughput (pps)      1980871    2169898
>>> Ping RTT avg (ms)       0.065      0.162
>>> Throughput diff         -8.7%   // BQL 8.7% lower throughput
>>> RTT diff               -59.9%   // BQL 60% lower latency
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>> Simon's time-based version:
>>>
>>> Test args: --nrules 0 --pktgen --no-bpftrace
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> Results (average over 10 runs):
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>                             BQL on      BQL off
>>> ---                        ------      -------
>>> Throughput (pps)          2166335      2153398
>>> Ping RTT avg (ms)           0.165        0.165
>>> Throughput diff              0.6%
>>> RTT diff                     0.0%
>>>
>>> --pktgen --no-bpftrace --nrules 3500
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> Results (average over 10 runs):
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>                             BQL on      BQL off
>>> ---                        ------      -------
>>> Throughput (pps)            28569        28696
>>> Ping RTT avg (ms)           1.327        8.409
>>> Throughput diff             -0.4%
>>> RTT diff                   -84.2%
>>>
>> I think we should run benchmarks against the stock net-next to
>> be safe.
>=20
> --nrules 0 --pktgen --no-bpftrace
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Results (average over 10 runs):
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>                      net-next
> ---                  -------
> Throughput (pps)     2285421
> Ping RTT avg (ms)    0.161
>=20
> (slightly adjusted the output to better communicate the results)
>=20
> So in my case this means BQL implementation has ~5% lower throughput
> compared to net-next. But please double check.
>=20

Yes, I will benchmark myself.

There are probably some places where we can gain performance.
For example, I see ptr_ring_empty() which could be swapped for
__ptr_ring_empty() which would save a spinlock and unlock.

>>> Seems to work now as expected.
>> Yes, but I think we have to keep these points in mind:
>>
>> 1. Limit/Inflight can be bigger than VETH_RING_SIZE, because
>>     packets can be enqueued in the same time as they are read out,
>>     so netdev_tx_completed_queue() can theoretically be called with
>>     many number of packets.
>>     I do not think it is deal-breaking though.
>>     I could see such high limits/inflights when looking at the /sys
>>     BQL statistics..
>=20
> For me this makes sense, that inflight just means the number of
> packets not yet 'completed' or the number of packets that you
> can send between two completion calls. I think this is not specific

=46rom my understanding, I do think that this behavior is
pretty specific.

Typically BQL-enabled NIC drivers clear packets out of some
internal buffer in their completion interrupt (or something
similar). And after that they call netdev_tx_completed_queue().

> to this implementation. But for long intervals this might result in
> some problems because you can just fill the veth_ring to its capacity
> quickly, and increasing latency if the receiver is slow.

Yes, but I think the latency can only be approx. as big as the
interval (can be higher with GRO enabled).

> To illustrate this have a look at [1]. There are some plots that
> show the rtt vs. tx-usec config depending on nrules.
>=20
> [1] https://github.com/jkoeppeler/veth-backpressure-performance-testing/=
tree/pktgen-and-benchmark/results/tx-usecs
>=20

Nice plots! Great for finding a sane default value.

>> 2. sched_clock() is only valid on the same CPU. When a different
>>     CPU starts executing its sched_clock() can be in the past compared
>>     to the sched_clock() value saved by the previous CPU.
>>     My trick...
>>     min(s->time, sched_clock())
>>     ... avoids potentially extremely long intervals between
>>     netdev_tx_completed_queue() calls but is not perfect of course.
>>     I think CPU hopping happens rarely enough for this to matter..
>>     And also we have to keep this in mind [1]:
>>     "An architecture may or may not provide an implementation of
>>     sched_clock() on its own. If a local implementation is not provided=
,
>>     the system jiffy counter will be used as sched_clock()."
>=20
> So the problem with this is that with jiffies you have like millisecond
> interval granularity, which might be too long in order to work properly.
> Given the receiver completes 128 packet in 1ms (queue_completed interval=
),
> the bql will set the limit at 256. Then the tx thread can quickly fill
> the ring, and it then basically stopped until the 1ms interval is over.
>=20


Linux Mint only has 100Hz jiffies :^)

I think you misunderstand something.

+	if (peer_txq && state->n_bql && ptr_ring_empty(&rq->xdp_ring)) {
+		smp_rmb();
+		if (test_bit(__QUEUE_STATE_STACK_XOFF, &peer_txq->state))
+			veth_bql_complete(state, peer_txq);
+	}

This snippet completes whenever the queue is empty and the
netdev queue is stopped due to BQL.
So then the interval is smaller than 1ms.
I think, that is the reason why the pps is fine for 1ms in
your benchmarks.

> I don't know how much this matters in practice. Not sure which architect=
ures still hit the jiffies fallback.When in doubt we could disable BQL for=
 those, or pin it to a "virtual queue size" via limit_min / limit_max simi=
lar to the v5 behavior and call queue_completed for every packet. Wdyt?

Yes, probably not relevant, I think I would just disable it for those
architectures, avoiding possible regressions.

>=20
>> 3. Inflight can be stuck at a value>0 for a long time when packet
>>     enqueueing stops. Only when packets are enqueued again,
>>     (on the next veth_xdp_rcv() call,) netdev_tx_completed_queue() is
>>     executed and inflight is set to 0 again.
>>     Can also be seen when looking at the /sys BQL statistics.
>=20
> This happens if the ring empties before the next queue_completed fires,
> right?
>=20

Exactly.

> Another thing: Is it counterintuitive to set the tx_usec_coal on the
> receive device? Because this is a bql related config that is normally
> configured on the TX side?

Yes, I would say so.

>=20
>> BTW: Yesterday, I worked on and refactored the code into its own .h
>>       file as a library and it also works fine for TUN/TAP (+vhost-net)
>>       for me :)
>=20
> Nice! Thank you.
> Jonas
>=20
>>
>> Thanks for your work!
>> Simon
>>
>> [1] Link: https://docs.kernel.org/timers/timekeeping.html
>>
>>> [1]https://github.com/jkoeppeler/veth-backpressure-performance-testing=
/tree/pktgen-and-benchmark
>>>
>>> Thanks,
>>> Jonas
>>>
>>>> Thanks!
>>>>
>>>> BTW: I think that this implementation could also work for other
>>>>        software interfaces.
>>>>
>>>>> [2] Link:https://medium.com/@tom_84912/byte-queue-limits-the-unautho=
rized-biography-61adc5730b83
>>>>>
>>>>>> There is an important gotcha. We actually have micro-burst of queui=
ng
>>>>>> (likely due to scheduling noise). Reading BQL stats from /sys will =
show
>>>>>> BQL inflight=3D1, but when using the option --hist is it visible th=
at
>>>>>> @inflight have a long tail (see below signature).  The "qdisc" outp=
ut
>>>>>> line also shows this happening via requeues increasing (approx 17/s=
ec in
>>>>>> a test with 567Kpps). (this was with the time-based BQL impl).
>>>>> I understand..
>>>>>

