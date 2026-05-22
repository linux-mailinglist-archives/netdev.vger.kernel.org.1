Return-Path: <netdev+bounces-290726-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFAgIscYEGoITgYAu9opvQ
	(envelope-from <netdev+bounces-290726-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 10:50:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C375B0BA6
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 10:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CE4B3011774
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 08:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAC93A7F46;
	Fri, 22 May 2026 08:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=schippers-hamm.de header.i=simon@schippers-hamm.de header.b="GnjZ9deX"
X-Original-To: netdev@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEA83A6F15;
	Fri, 22 May 2026 08:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779439653; cv=none; b=Pq2lcQGQ2UtH0DaV7qjaMNUYZtXYxvIy/t3d9Lw0ygYK9bJu0DFpih/fEm8xaC0XliJIv/LgKe8DnNkuEMjZgOuLScj1F0UDc88PYJzwvA0zn7pIjcmhqFUSM1Pk/jKyLML71tjLJ+Xm9Koiiggj0PQH3NDDwH/+GeAyQfUR0sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779439653; c=relaxed/simple;
	bh=3Z2SRiLRmi9QoHkJJtaarN9nwOLuT96mSOc5HG/JPmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NjeVv3CNhjRJke5mk15BVSmmSxu6FyUqzDy2RpON7py3n5Dq7+CGsH0r5JwzVYIBNQOLh5HnrvvSrDay6297ojLTWEQEmiZm8aHE4giIUJJS1gzWJJ5SUWTMuK7Pvp8Mdd0ikPEG4XXdlkr3X/I/ANcuifXd1zhj7HWYM9oDe1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schippers-hamm.de; spf=pass smtp.mailfrom=schippers-hamm.de; dkim=pass (2048-bit key) header.d=schippers-hamm.de header.i=simon@schippers-hamm.de header.b=GnjZ9deX; arc=none smtp.client-ip=212.227.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schippers-hamm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schippers-hamm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schippers-hamm.de;
	s=s1-ionos; t=1779439633; x=1780044433; i=simon@schippers-hamm.de;
	bh=xOvmaBKTHglqaA3IX338jsMixlAE06VHNb1Wp/6IJqo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GnjZ9deXoGTeLDTCFtGJ4NCuIkX0HHJk4Gp9VzB08iVM+R/wA5RRPy8bJkYQDDgB
	 MraouexUs5YzK0jJ+flSzccdSYWtLkGAyeiI1TWxFoUpecOpR1fyS6PPfGhR1xaVS
	 el7WjK2pgLQb+5bRaUOipKbkTpNj0DMKCukbQ7p0Eo2tqPP/43PIA/C1dKnUlwTyW
	 FwI/bdYueLeAqJxGbe+0eixUC5IH0D6TrDyrDWaKJQWrXhJWjTQdpna+IE8bHWRSL
	 gK1txvqVk6xgTaSnvos1afAhL8zm5UaZLQ/Nac4ARefT/boS+qJLHZZqpHxBI4rlK
	 AeHPmWlCennxkB7FGw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue012
 [212.227.17.165]) with ESMTPSA (Nemesis) id 1MpCz1-1x8DyG39B9-00nQMn; Fri, 22
 May 2026 10:41:08 +0200
Message-ID: <8e8b877b-a7ce-4b2f-9567-64c8dbb48411@schippers-hamm.de>
Date: Fri, 22 May 2026 10:41:04 +0200
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
Content-Language: en-US
From: Simon Schippers <simon@schippers-hamm.de>
In-Reply-To: <4ae9400a-8919-4ffc-8db3-0c334e2aa462@tu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:epIR/on1LaIhH0l4++wbZZb2c+ERMVxzVL+rXMG4lAj/7imVS90
 tdu615SM+kZw5zJSo5iuSXMmEmJ1Uv9x+JsWYd9JcCPCnd+gw6Bb4xG7nEpocGAj3kxztlN
 IItJONWQKulBrft19k90EIDYgToJfuFmPkUr2YJmIW2PJsPTZJWmRwKYLszy4SOY1vq3Mf9
 0D/yF0yviQyCLDQVlpzYg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sw/tZbvtUuw=;OFoS+QxII15AHYarypobvqG+YCs
 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
 H+DZlxfsblQmmOAq6UCLGvmOgRWfh2cL
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[schippers-hamm.de,none];
	R_DKIM_ALLOW(-0.20)[schippers-hamm.de:s=s1-ionos];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290726-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,medium.com:url,veth_bql_bench.sh:url]
X-Rspamd-Queue-Id: D8C375B0BA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/22/26 09:14, Jonas K=C3=B6ppeler wrote:
> On 5/19/26 10:51 PM, Simon Schippers wrote:
>> On 5/12/26 23:55, Simon Schippers wrote:
>>> On 5/12/26 15:54, Jesper Dangaard Brouer wrote:
>>>>>> Nope, I'm using a bpftrace program to keep track of the inflight/li=
mit
>>>>>> in a BPF hashmap.  Reading from /sys will not be accurate.
>>>>> Ah nice.
>>>> Add the option --hist to have both NAPI and BQL histograms printed wh=
en
>>>> script ends.  This will give you an accurate pattern of how inflight =
and
>>>> limit evolves.
>>>>
>>>>>> I moved the selftests into a github repo [1] to allow us to collabo=
rate
>>>>>> and evaluate the changes more easily.  I explicitly kept the new BP=
F
>>>>>> based BQL tracking as a commit[2] for your benefit.
>>>>>>
>>>>>>    [1]https://github.com/netoptimizer/veth-backpressure-performance=
-testing/tree/main/selftests
>>>>>>
>>>>>>    [2]https://github.com/netoptimizer/veth-backpressure-performance=
-testing/commit/f25c5dc92977
>>>>> Thanks for sharing. After minor issues I was able to set it up
>>>>> (currently I am just using plain v5, will look at the coalescing pat=
ch
>>>>> when I find the time):
>>>>>
>>>>> Can confirm the latency reduction with the default settings, in my c=
ase
>>>>> 4.888ms to 0.241ms.
>>>>>
>>>>> With the same script I was also able to see a performance slow down:
>>>>> veth_bql_test_virtme.sh --qdisc fq_codel --nrules 0
>>>>> --> ~510 Kpps
>>>>> Same with --bql-disable
>>>>> --> ~570 Kpps
>>>>> --> 12% faster
>>>>>
>>>> Thanks for running these benchmarks.
>>>>
>>>> Notice that --nrules 0 can easily result in no-queuing (on average),
>>>> because the veth NAPI consumer is faster than the producer.  You will
>>>> likely see BQL inflight=3D1 and sink reported avg latency very low
>>>> (remember it okay that sink get high latency penalty as long at ping
>>>> latency remains low, as that show AQM is working).
>>> I ran the benchmarks with --hist and I see what you mean.
>>> I have very similar results.
>>>
>>> Is Jonas way [1] of modifiying pktgen maybe the best option to ensure
>>> that the producer is faster than the consumer?
>>>
>>> [1] Link:https://lore.kernel.org/netdev/e8cdba04-aa9a-45c6-9807-8274b6=
2920df@tu-dortmund.de/
>>>
>>>> Hi, so what I found is that pktgen does not respect
>>>> __QUEUE_STATE_STACK_OFF. So the test data above is invalid, since it
>>>> just sent packets even if the BQL "stopped" the queue. So I patched
>>>> pktgen with the following:
>>>>
>>>> -       if (unlikely(netif_xmit_frozen_or_drv_stopped(txq))) {
>>>> +       if (unlikely(netif_xmit_frozen_or_stopped(txq))) {
>>>
>>> After thinking more about the implementation I see possible issues:
>>>
>>> 1. netdev_tx_completed_queue() never reports more than burst=3D64 pack=
ets:
>>>
>>> BQL only increments the limit if the queue was starved. That means:
>>> "The queue was over-limit in the last interval (the last time completi=
on
>>> processing ran), and there is no more data in the queue (i.e. it=E2=80=
=99s
>>> empty)" [2]
>>> But as only 64 packets are reported at max, the queue can only grow wh=
en
>>> it is <=3D 64 packets. And then it can only stay at a limit >64 until =
the
>>> next decrease of the limit.
>>>
>>>
>>> 2. netdev_tx_completed_queue() is called in irregular intervals:
>>>
>>> If the consumer is slow it is called approx each tx_coal_usecs.
>>> But if the consumer is fast it is called way more frequent, probably
>>> in irregular intervals depending on the scheduling.
>>> However, "BQL depends on periodic completion interrupts" [2].
>>>
>>> --> How about adding something like an interrupt that triggers every
>>>      10us and calls netdev_tx_completed_queue() with n_bql collected f=
rom
>>>      (multiple) veth_xdp_rcv runs? That could solve 1. and 2.
>> Hi,
>>
>> I worked on a new version (see attachment) that addresses both issues.
>>
>> The major change is that instead of tracking the timestamp and packet
>> count as local variables in veth_xdp_rcv(), they are now stored
>> persistently in veth_rq as struct veth_bql_state. This allows completio=
ns
>> to accumulate across multiple NAPI poll calls, so
>> netdev_tx_completed_queue() can report more than 64 packets at once
>> (see point 1). To get the time I am using (the fast) sched_clock() with
>> a trick to avoid issues when switching between CPUs.
>>
>> For point 2, the coalescing deadline is now checked both before the
>> receive loop (to flush completions that timed out since the previous
>> poll) and after each consumed packet, making completion intervals more
>> regular. Still the intervals can be smaller than
>> VETH_BQL_COAL_TX_USECS, but I guess this is fine.
>>
>> I also found out that the BQL limit correlates closely with
>> VETH_BQL_COAL_TX_USECS. It essentially reflects the latency we are
>> targeting. I raised the default to 100 =C2=B5s to allow DQL to converge=
 to a
>> higher limit (for reaching 255 in the testing below).
>>
>> With the patched pktgen (respecting __QUEUE_STATE_STACK_XOFF), testing
>> shows:
>> - --nrules 0: DQL limit reaches (up to) ~255
>> - --nrules 10000: DQL limit converges to ~0 (with --gro-disable)
>>
>> These results are what I would expect from a BQL algorithm, but more
>> testing is needed of course.
>>
>> What do you think?
>=20
> Hi,
>=20
> This is exactly what I had in mind for implementing the BQL algorithm
> in this case. I did some testing with pktgen of this patch and also
> compared it to the v5 version.
>=20
> You can find an extension of the benchmark script with pktgen here [1],
> as well as a wrapper script (veth_bql_bench.sh) to run the test script
> with and without --bql-disable to report the difference. I also
> configured pktgen to use the qdisc as suggested by Jesper.

Great, I will use your pktgen solution from now on.

Didn't know about the qdisc option, is there a performance difference
with/without it? Or is it to have ping working next to pktgen?

Consider to do a pull request :)

>=20
> Note: bpftrace needs to be disabled, otherwise it becomes the
> bottleneck (at least on my machine) and pktgen throughput is halved
> when enabled.

Good to know.

>=20
> Here are the results:
>=20
> v5 (not time-based):
> --nrules 0 --pktgen --no-bpftrace
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Results (average over 10 runs):
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>                        BQL on    BQL off
> ---                    ------    -------
> Throughput (pps)      1980871    2169898
> Ping RTT avg (ms)       0.065      0.162
> Throughput diff         -8.7%   // BQL 8.7% lower throughput
> RTT diff               -59.9%   // BQL 60% lower latency
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Simon's time-based version:
>=20
> Test args: --nrules 0 --pktgen --no-bpftrace
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Results (average over 10 runs):
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>                            BQL on      BQL off
> ---                        ------      -------
> Throughput (pps)          2166335      2153398
> Ping RTT avg (ms)           0.165        0.165
> Throughput diff              0.6%
> RTT diff                     0.0%
>=20
> --pktgen --no-bpftrace --nrules 3500
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Results (average over 10 runs):
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>                            BQL on      BQL off
> ---                        ------      -------
> Throughput (pps)            28569        28696
> Ping RTT avg (ms)           1.327        8.409
> Throughput diff             -0.4%
> RTT diff                   -84.2%
>=20

I think we should run benchmarks against the stock net-next to
be safe.

> Seems to work now as expected.

Yes, but I think we have to keep these points in mind:

1. Limit/Inflight can be bigger than VETH_RING_SIZE, because
   packets can be enqueued in the same time as they are read out,
   so netdev_tx_completed_queue() can theoretically be called with
   many number of packets.
   I do not think it is deal-breaking though.
   I could see such high limits/inflights when looking at the /sys
   BQL statistics..

2. sched_clock() is only valid on the same CPU. When a different
   CPU starts executing its sched_clock() can be in the past compared
   to the sched_clock() value saved by the previous CPU.
   My trick...
   min(s->time, sched_clock())
   ... avoids potentially extremely long intervals between
   netdev_tx_completed_queue() calls but is not perfect of course.
   I think CPU hopping happens rarely enough for this to matter..
   And also we have to keep this in mind [1]:
   "An architecture may or may not provide an implementation of
   sched_clock() on its own. If a local implementation is not provided,
   the system jiffy counter will be used as sched_clock()."

3. Inflight can be stuck at a value>0 for a long time when packet
   enqueueing stops. Only when packets are enqueued again,
   (on the next veth_xdp_rcv() call,) netdev_tx_completed_queue() is
   executed and inflight is set to 0 again.
   Can also be seen when looking at the /sys BQL statistics.

BTW: Yesterday, I worked on and refactored the code into its own .h
     file as a library and it also works fine for TUN/TAP (+vhost-net)
     for me :)

Thanks for your work!
Simon

[1] Link: https://docs.kernel.org/timers/timekeeping.html

>=20
> [1]https://github.com/jkoeppeler/veth-backpressure-performance-testing/t=
ree/pktgen-and-benchmark
>=20
> Thanks,
> Jonas
>=20
>> Thanks!
>>
>> BTW: I think that this implementation could also work for other
>>       software interfaces.
>>
>>> [2] Link:https://medium.com/@tom_84912/byte-queue-limits-the-unauthori=
zed-biography-61adc5730b83
>>>
>>>> There is an important gotcha. We actually have micro-burst of queuing
>>>> (likely due to scheduling noise). Reading BQL stats from /sys will sh=
ow
>>>> BQL inflight=3D1, but when using the option --hist is it visible that
>>>> @inflight have a long tail (see below signature).  The "qdisc" output
>>>> line also shows this happening via requeues increasing (approx 17/sec=
 in
>>>> a test with 567Kpps). (this was with the time-based BQL impl).
>>> I understand..
>>>

