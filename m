Return-Path: <netdev+bounces-291739-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SENrJ2bAFWrYZgcAu9opvQ
	(envelope-from <netdev+bounces-291739-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:46:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F22D35D8FF5
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4602F31D0E68
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15143CFF5F;
	Tue, 26 May 2026 15:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=schippers-hamm.de header.i=simon@schippers-hamm.de header.b="2KFi387o"
X-Original-To: netdev@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29DC3CC7CA;
	Tue, 26 May 2026 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779808045; cv=none; b=m0Mt2SnWxdtbvZxTfzgAkUGw7yVFIcjJ/7gA9bAeD8EvhDISlJb3TFXA5bA4O/uSatEowZaIsG0VvMsjIDOMqxn8TcWEWm4cYd4gOmmHYU/jwb0lNbPpr3iHHu3zLd2F1iW0sR3hIf/qyQPkPJh0PgxmR98YnsYlZaKbeQUOysc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779808045; c=relaxed/simple;
	bh=aYlSd9OAcssm7q9W8IFiAHwXRxUduuQVeocoxlaEQVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=REgIGeahsHiFjDv8P0vPEugDbByC+YfXpd6aF+2yjmsL4FCrcfsB3mAc/L8QEbZ65+SEgIq4GBsUD3tX2az+NG4bPKEo4htGltRgtnzg7xP57KY9tMzQVNR/EhmK0tYXcbg3+s7Lp5vQqA1nxQzOvYFIJbLy5gvWAkMO7uIYXzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schippers-hamm.de; spf=pass smtp.mailfrom=schippers-hamm.de; dkim=pass (2048-bit key) header.d=schippers-hamm.de header.i=simon@schippers-hamm.de header.b=2KFi387o; arc=none smtp.client-ip=212.227.126.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schippers-hamm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schippers-hamm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schippers-hamm.de;
	s=s1-ionos; t=1779808039; x=1780412839; i=simon@schippers-hamm.de;
	bh=CmARyeB4XxivvBPN3mz3K6Csjm6OL2B3/Uxjahs3kh4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=2KFi387oWebHqyQVFs1bH7afcH2J8tvFBQRYEcO0i8K0qPtAAc42YXkO0p/5BZMc
	 tfrF9ugYlDXx4pPpWdx7bclfgX36XiJ/sE73u7CnTyjp0NQgBYyOdrCFA8de6vT8X
	 g649L8KrED7Ld/6bqnn8UKDiRsUm912AKLk9p3+5x2vTBLwdpS+ieHwB6yEtIsrl7
	 Y2w0G8sE037Ouil80D1KjBKQu+GfZ/ON9jKH6TSoclCR6MwRrLN07DdRaFYX2Oxvw
	 218R06Q/ounkf7fZf+5qHL1sefTO5/P7wvW2/co2uQXbw+4SxcGoh1J3xmnu0OOZa
	 l5aEH0y70Of3haDPsw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue011
 [212.227.17.165]) with ESMTPSA (Nemesis) id 1Mtf39-1xJzrc21mx-013Zrj; Tue, 26
 May 2026 17:07:19 +0200
Message-ID: <e8be86b4-052f-4f4f-9cb9-2fb12d1e8922@schippers-hamm.de>
Date: Tue, 26 May 2026 17:07:11 +0200
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
 <d23fd8e0-a0d3-4197-a130-2340d1c28fe0@tu-berlin.de>
Content-Language: en-US
From: Simon Schippers <simon@schippers-hamm.de>
In-Reply-To: <d23fd8e0-a0d3-4197-a130-2340d1c28fe0@tu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZW2v8ig5je6O7jWi2SMYl5TTwQCnAI1eZDTgyytO00re6svOI89
 L1n7RTXyvEiERfKcBUE4Nq+HcRakRygfP067PYoMeKXTlD1lur8Rn82nstt9hJt7ICmOry5
 YkN3Uy2HBc+EAqNcWB8LyorEDVSnnKw0MwmSHmJqdhTKt5O24G3U1L49mwgO2NYNhnJmMiA
 XgvYz8KUlnEEz3g6fiGKg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:a5UXCWlK6jQ=;10AJXoaWVMGHWwcVmxHzAjy5hme
 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
 EkshuyBQivUZF2fJUYQrAkxbDOfT0f7G
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[schippers-hamm.de,none];
	R_DKIM_ALLOW(-0.20)[schippers-hamm.de:s=s1-ionos];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291739-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,veth_bql_test_virtme.sh:url,schippers-hamm.de:mid,schippers-hamm.de:dkim,veth_bql_bench.sh:url,medium.com:url]
X-Rspamd-Queue-Id: F22D35D8FF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/26/26 16:55, Jonas K=C3=B6ppeler wrote:
> On 5/26/26 4:35 PM, Simon Schippers wrote:
>> On 5/26/26 11:54, Jonas K=C3=B6ppeler wrote:
>>> On 5/23/26 6:09 PM, Simon Schippers wrote:
>>>> On 5/22/26 18:26, Jonas K=C3=B6ppeler wrote:
>>>>> On 5/22/26 10:41, Simon Schippers wrote:
>>>>>> On 5/22/26 09:14, Jonas K=C3=B6ppeler wrote:
>>>>>>> On 5/19/26 10:51 PM, Simon Schippers wrote:
>>>>>>>> On 5/12/26 23:55, Simon Schippers wrote:
>>>>>>>>> On 5/12/26 15:54, Jesper Dangaard Brouer wrote:
>>>>>>>>>>>> Nope, I'm using a bpftrace program to keep track of the infli=
ght/limit
>>>>>>>>>>>> in a BPF hashmap.  Reading from /sys will not be accurate.
>>>>>>>>>>> Ah nice.
>>>>>>>>>> Add the option --hist to have both NAPI and BQL histograms prin=
ted when
>>>>>>>>>> script ends.  This will give you an accurate pattern of how inf=
light and
>>>>>>>>>> limit evolves.
>>>>>>>>>>
>>>>>>>>>>>> I moved the selftests into a github repo [1] to allow us to c=
ollaborate
>>>>>>>>>>>> and evaluate the changes more easily.  I explicitly kept the =
new BPF
>>>>>>>>>>>> based BQL tracking as a commit[2] for your benefit.
>>>>>>>>>>>>
>>>>>>>>>>>>       [1]https://github.com/netoptimizer/veth-backpressure-pe=
rformance-testing/tree/main/selftests
>>>>>>>>>>>>
>>>>>>>>>>>>       [2]https://github.com/netoptimizer/veth-backpressure-pe=
rformance-testing/commit/f25c5dc92977
>>>>>>>>>>> Thanks for sharing. After minor issues I was able to set it up
>>>>>>>>>>> (currently I am just using plain v5, will look at the coalesci=
ng patch
>>>>>>>>>>> when I find the time):
>>>>>>>>>>>
>>>>>>>>>>> Can confirm the latency reduction with the default settings, i=
n my case
>>>>>>>>>>> 4.888ms to 0.241ms.
>>>>>>>>>>>
>>>>>>>>>>> With the same script I was also able to see a performance slow=
 down:
>>>>>>>>>>> veth_bql_test_virtme.sh --qdisc fq_codel --nrules 0
>>>>>>>>>>> --> ~510 Kpps
>>>>>>>>>>> Same with --bql-disable
>>>>>>>>>>> --> ~570 Kpps
>>>>>>>>>>> --> 12% faster
>>>>>>>>>>>
>>>>>>>>>> Thanks for running these benchmarks.
>>>>>>>>>>
>>>>>>>>>> Notice that --nrules 0 can easily result in no-queuing (on aver=
age),
>>>>>>>>>> because the veth NAPI consumer is faster than the producer.  Yo=
u will
>>>>>>>>>> likely see BQL inflight=3D1 and sink reported avg latency very =
low
>>>>>>>>>> (remember it okay that sink get high latency penalty as long at=
 ping
>>>>>>>>>> latency remains low, as that show AQM is working).
>>>>>>>>> I ran the benchmarks with --hist and I see what you mean.
>>>>>>>>> I have very similar results.
>>>>>>>>>
>>>>>>>>> Is Jonas way [1] of modifiying pktgen maybe the best option to e=
nsure
>>>>>>>>> that the producer is faster than the consumer?
>>>>>>>>>
>>>>>>>>> [1] Link:https://lore.kernel.org/netdev/e8cdba04-aa9a-45c6-9807-=
8274b62920df@tu-dortmund.de/
>>>>>>>>>
>>>>>>>>>> Hi, so what I found is that pktgen does not respect
>>>>>>>>>> __QUEUE_STATE_STACK_OFF. So the test data above is invalid, sin=
ce it
>>>>>>>>>> just sent packets even if the BQL "stopped" the queue. So I pat=
ched
>>>>>>>>>> pktgen with the following:
>>>>>>>>>>
>>>>>>>>>> -       if (unlikely(netif_xmit_frozen_or_drv_stopped(txq))) {
>>>>>>>>>> +       if (unlikely(netif_xmit_frozen_or_stopped(txq))) {
>>>>>>>>> After thinking more about the implementation I see possible issu=
es:
>>>>>>>>>
>>>>>>>>> 1. netdev_tx_completed_queue() never reports more than burst=3D6=
4 packets:
>>>>>>>>>
>>>>>>>>> BQL only increments the limit if the queue was starved. That mea=
ns:
>>>>>>>>> "The queue was over-limit in the last interval (the last time co=
mpletion
>>>>>>>>> processing ran), and there is no more data in the queue (i.e. it=
=E2=80=99s
>>>>>>>>> empty)" [2]
>>>>>>>>> But as only 64 packets are reported at max, the queue can only g=
row when
>>>>>>>>> it is <=3D 64 packets. And then it can only stay at a limit >64 =
until the
>>>>>>>>> next decrease of the limit.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> 2. netdev_tx_completed_queue() is called in irregular intervals:
>>>>>>>>>
>>>>>>>>> If the consumer is slow it is called approx each tx_coal_usecs.
>>>>>>>>> But if the consumer is fast it is called way more frequent, prob=
ably
>>>>>>>>> in irregular intervals depending on the scheduling.
>>>>>>>>> However, "BQL depends on periodic completion interrupts" [2].
>>>>>>>>>
>>>>>>>>> --> How about adding something like an interrupt that triggers e=
very
>>>>>>>>>         10us and calls netdev_tx_completed_queue() with n_bql co=
llected from
>>>>>>>>>         (multiple) veth_xdp_rcv runs? That could solve 1. and 2.
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> I worked on a new version (see attachment) that addresses both is=
sues.
>>>>>>>>
>>>>>>>> The major change is that instead of tracking the timestamp and pa=
cket
>>>>>>>> count as local variables in veth_xdp_rcv(), they are now stored
>>>>>>>> persistently in veth_rq as struct veth_bql_state. This allows com=
pletions
>>>>>>>> to accumulate across multiple NAPI poll calls, so
>>>>>>>> netdev_tx_completed_queue() can report more than 64 packets at on=
ce
>>>>>>>> (see point 1). To get the time I am using (the fast) sched_clock(=
) with
>>>>>>>> a trick to avoid issues when switching between CPUs.
>>>>>>>>
>>>>>>>> For point 2, the coalescing deadline is now checked both before t=
he
>>>>>>>> receive loop (to flush completions that timed out since the previ=
ous
>>>>>>>> poll) and after each consumed packet, making completion intervals=
 more
>>>>>>>> regular. Still the intervals can be smaller than
>>>>>>>> VETH_BQL_COAL_TX_USECS, but I guess this is fine.
>>>>>>>>
>>>>>>>> I also found out that the BQL limit correlates closely with
>>>>>>>> VETH_BQL_COAL_TX_USECS. It essentially reflects the latency we ar=
e
>>>>>>>> targeting. I raised the default to 100 =C2=B5s to allow DQL to co=
nverge to a
>>>>>>>> higher limit (for reaching 255 in the testing below).
>>>>>>>>
>>>>>>>> With the patched pktgen (respecting __QUEUE_STATE_STACK_XOFF), te=
sting
>>>>>>>> shows:
>>>>>>>> - --nrules 0: DQL limit reaches (up to) ~255
>>>>>>>> - --nrules 10000: DQL limit converges to ~0 (with --gro-disable)
>>>>>>>>
>>>>>>>> These results are what I would expect from a BQL algorithm, but m=
ore
>>>>>>>> testing is needed of course.
>>>>>>>>
>>>>>>>> What do you think?
>>>>>>> Hi,
>>>>>>>
>>>>>>> This is exactly what I had in mind for implementing the BQL algori=
thm
>>>>>>> in this case. I did some testing with pktgen of this patch and als=
o
>>>>>>> compared it to the v5 version.
>>>>>>>
>>>>>>> You can find an extension of the benchmark script with pktgen here=
 [1],
>>>>>>> as well as a wrapper script (veth_bql_bench.sh) to run the test sc=
ript
>>>>>>> with and without --bql-disable to report the difference. I also
>>>>>>> configured pktgen to use the qdisc as suggested by Jesper.
>>>>>> Great, I will use your pktgen solution from now on.
>>>>>>
>>>>>> Didn't know about the qdisc option, is there a performance differen=
ce
>>>>>> with/without it? Or is it to have ping working next to pktgen?
>>>>> Did not see any big difference performance-wise, but as you say, pin=
g
>>>>> works better with pktgen then.
>>>>>
>>>>>> Consider to do a pull request :)
>>>>>>
>>>>>>> Note: bpftrace needs to be disabled, otherwise it becomes the
>>>>>>> bottleneck (at least on my machine) and pktgen throughput is halve=
d
>>>>>>> when enabled.
>>>>>> Good to know.
>>>>>>
>>>>>>> Here are the results:
>>>>>>>
>>>>>>> v5 (not time-based):
>>>>>>> --nrules 0 --pktgen --no-bpftrace
>>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>>> Results (average over 10 runs):
>>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>>>                           BQL on    BQL off
>>>>>>> ---                    ------    -------
>>>>>>> Throughput (pps)      1980871    2169898
>>>>>>> Ping RTT avg (ms)       0.065      0.162
>>>>>>> Throughput diff         -8.7%   // BQL 8.7% lower throughput
>>>>>>> RTT diff               -59.9%   // BQL 60% lower latency
>>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>>>
>>>>>>> Simon's time-based version:
>>>>>>>
>>>>>>> Test args: --nrules 0 --pktgen --no-bpftrace
>>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>>> Results (average over 10 runs):
>>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>>>                               BQL on      BQL off
>>>>>>> ---                        ------      -------
>>>>>>> Throughput (pps)          2166335      2153398
>>>>>>> Ping RTT avg (ms)           0.165        0.165
>>>>>>> Throughput diff              0.6%
>>>>>>> RTT diff                     0.0%
>>>>>>>
>>>>>>> --pktgen --no-bpftrace --nrules 3500
>>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>>> Results (average over 10 runs):
>>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>>>                               BQL on      BQL off
>>>>>>> ---                        ------      -------
>>>>>>> Throughput (pps)            28569        28696
>>>>>>> Ping RTT avg (ms)           1.327        8.409
>>>>>>> Throughput diff             -0.4%
>>>>>>> RTT diff                   -84.2%
>>>>>>>
>>>>>> I think we should run benchmarks against the stock net-next to
>>>>>> be safe.
>>>>> --nrules 0 --pktgen --no-bpftrace
>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>> Results (average over 10 runs):
>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>                        net-next
>>>>> ---                  -------
>>>>> Throughput (pps)     2285421
>>>>> Ping RTT avg (ms)    0.161
>>>>>
>>>>> (slightly adjusted the output to better communicate the results)
>>>>>
>>>>> So in my case this means BQL implementation has ~5% lower throughput
>>>>> compared to net-next. But please double check.
>>>>>
>>>> Yes, I will benchmark myself.
>>>>
>>>> There are probably some places where we can gain performance.
>>>> For example, I see ptr_ring_empty() which could be swapped for
>>>> __ptr_ring_empty() which would save a spinlock and unlock.
>>>>
>>>>>>> Seems to work now as expected.
>>>>>> Yes, but I think we have to keep these points in mind:
>>>>>>
>>>>>> 1. Limit/Inflight can be bigger than VETH_RING_SIZE, because
>>>>>>       packets can be enqueued in the same time as they are read out=
,
>>>>>>       so netdev_tx_completed_queue() can theoretically be called wi=
th
>>>>>>       many number of packets.
>>>>>>       I do not think it is deal-breaking though.
>>>>>>       I could see such high limits/inflights when looking at the /s=
ys
>>>>>>       BQL statistics..
>>>>> For me this makes sense, that inflight just means the number of
>>>>> packets not yet 'completed' or the number of packets that you
>>>>> can send between two completion calls. I think this is not specific
>>>>   From my understanding, I do think that this behavior is
>>>> pretty specific.
>>>>
>>>> Typically BQL-enabled NIC drivers clear packets out of some
>>>> internal buffer in their completion interrupt (or something
>>>> similar). And after that they call netdev_tx_completed_queue().
>>> You are right, because descriptors are freed at the same time when the=
y are accounted for.
>>>
>>>>> to this implementation. But for long intervals this might result in
>>>>> some problems because you can just fill the veth_ring to its capacit=
y
>>>>> quickly, and increasing latency if the receiver is slow.
>>>> Yes, but I think the latency can only be approx. as big as the
>>>> interval (can be higher with GRO enabled).
>>> I think it's more like ~2.x times added latency in the worst case,
>>> which is normal BQL behavior, but for large intervals 2x is a lot.
>>> Of course this value is also capped by the time it takes to process
>>> the 256 packets that fit in the ring buffer.
>>>
>>> For example, for a test run with fq_codel and 20K rules, and a ping
>>> baseline of 1.7 ms without pktgen load, the results are:
>>> tx-usecs   p99_ping_rtt (ms)
>>> --------   -----------------
>>>       0           5.223
>>>     100           6.910
>>>     500           7.197
>>>    1000           6.967
>>>    5000          16.233
>>>   10000          25.033
>>>   20000          44.133
>>>
>>> Also, the interval is sometimes dominated by the processing time of
>>> a packet batch (and other effects). The default is 8 packets/batch
>>> (see gro_normal_batch). This means that for 7 packets you see
>>> processing times on the order of a few hundred nanoseconds, but for
>>> the 8th you see the processing time of the whole batch (see table belo=
w).
>>> With a ruleset > 1000 entries, this exceeds the default tx-usecs value=
,
>>> which is why the p99 RTT increase is even larger than 2x tx-usecs
>>> -- as you can see in the table for tx-usecs values 0-5000.
>>>
>>> tx-usecs 0 nrules 0
>>> Percentile   per-packet processing time (=C2=B5s)
>>> ----------   -------------
>>>      p5             0.316
>>>     p25             0.382
>>>     p50             0.442
>>>     p75             0.508 -- fast enqueue to skb_list
>>>     p95            68.304 -- batch processing time
>>>
>>> Setting gro_normal_batch to 1 makes the interval times more
>>> accurate and improves p99 RTT slightly, though it's still > 2x the
>>> tx-usecs latency increase.
>>>
>>> However, using smaller values > 0 means that you can benefit
>>> from bql, but the actual interval might be larger than the
>>> configured value. I do not think this is a deal breaker, but
>>> something worth noting where the latencies come from.
>> I understand and agree with your points.
>> I also do not see anything deal-breaking.
>> Yes, there is no guarantee for the latency, but BQL
>> is best-effort anyway.
>>
>> I will wait for your new measurements, but there is no argument
>> against a default tx-usecs of ~100us for now, right?
>=20
> Yes, I think 100us is perfectly fine. I guess most of it was
> just my curiosity why the latency values are as they are :)

Which is great, because I was wondering the same :)

> But it feels like this will need some documentation, because
> as we have seen, some values are a little different
> from what you expect from bql. Inflight > veth_ring_size,
> tx-usecs not necessarily achieving the configured value,
> inflight can get stuck > 0. Wdyt?
> But I think it works nicely overall.
>=20

Exactly, we should get ready for a v6 soon.

And I think we should move the BQL logic into a seperate .h file
as a library. Then it is also usable for TUN/TAP in the future.

Let's amend the commits. Should we do this on Github?

>>> Also worth noting: using fq_codel is better to use in this
>>> case because it can fast track sparse flows. using sfq the
>>> ping packet can get head of line blocked by the current quantum
>>> of sfq, if my understanding is correct.
>> Why don't we use a prio qdisc where ping gets prioritized?
>> Then we do not have to worry about head of line blocking on
>> the qdisc layer and instead can concentrate on veth.
>>
>>>>> To illustrate this have a look at [1]. There are some plots that
>>>>> show the rtt vs. tx-usec config depending on nrules.
>>>>>
>>>>> [1] https://github.com/jkoeppeler/veth-backpressure-performance-test=
ing/tree/pktgen-and-benchmark/results/tx-usecs
>>>>>
>>>> Nice plots! Great for finding a sane default value.
>>> I did some more measurements to better understand whats
>>> happening. I will upload the results latest by tomorrow
>>> to the github repository mentioned above.
>>>
>>>>>> 2. sched_clock() is only valid on the same CPU. When a different
>>>>>>       CPU starts executing its sched_clock() can be in the past com=
pared
>>>>>>       to the sched_clock() value saved by the previous CPU.
>>>>>>       My trick...
>>>>>>       min(s->time, sched_clock())
>>>>>>       ... avoids potentially extremely long intervals between
>>>>>>       netdev_tx_completed_queue() calls but is not perfect of cours=
e.
>>>>>>       I think CPU hopping happens rarely enough for this to matter.=
.
>>>>>>       And also we have to keep this in mind [1]:
>>>>>>       "An architecture may or may not provide an implementation of
>>>>>>       sched_clock() on its own. If a local implementation is not pr=
ovided,
>>>>>>       the system jiffy counter will be used as sched_clock()."
>>>>> So the problem with this is that with jiffies you have like millisec=
ond
>>>>> interval granularity, which might be too long in order to work prope=
rly.
>>>>> Given the receiver completes 128 packet in 1ms (queue_completed inte=
rval),
>>>>> the bql will set the limit at 256. Then the tx thread can quickly fi=
ll
>>>>> the ring, and it then basically stopped until the 1ms interval is ov=
er.
>>>>>
>>>> Linux Mint only has 100Hz jiffies :^)
>>> ok so 10ms granularity. Effectively disables BQL for the most part.
>>> However, you can still benefit if your receive side is very slow.
>>>
>>>> I think you misunderstand something.
>>>>
>>>> +    if (peer_txq && state->n_bql && ptr_ring_empty(&rq->xdp_ring)) {
>>              // Pairs with smp_wmb() in __ptr_ring_produce()
>>
>>>> +        smp_rmb();
>>>> +        if (test_bit(__QUEUE_STATE_STACK_XOFF, &peer_txq->state))
>>>> +            veth_bql_complete(state, peer_txq);
>>>> +    }
>>>>
>>>> This snippet completes whenever the queue is empty and the
>>>> netdev queue is stopped due to BQL.
>>>> So then the interval is smaller than 1ms.
>>>> I think, that is the reason why the pps is fine for 1ms in
>>>> your benchmarks.
>>> Without that snippet the queue stalls during ramp-up and
>>> throughput never gets off the ground. But once the BQL limit has
>>> stabilized, the snippet is no longer invoked -- with --nrules 0
>>> the queue is never stopped, and with a slow receiver the queue is
>>> not empty. So the snippet is needed for correct ramp-up, but it
>>> doesn't affect steady-state throughput in these tests. This is also
>>> confirmed by a test where I measure the time between intervals.
>>> For 1000us across all nrules configurations the time ranges between
>>> 1000-1400us.
>> Yes, I agree. It only acts in the case of starvation (see [1])
>> and I think it is an advantage that we react faster compared
>> to other BQL implementations.
>>
>> Additionally the snippet is *required* because if the ring
>> is empty and the txq stopped due to BQL, there are no more
>> veth_xdp_recv() calls, permanently stalling everything.
>> That is the reason for the memory barrier pairing in the snippet.
>>
>> [1] Link: https://medium.com/@tom_84912/byte-queue-limits-the-unauthori=
zed-biography-61adc5730b83
>>
>>> The variance of the time between intervals is also quite good in
>>> general, but not always exact the configured value. For most cases
>>> +-5% from p50 value of the real interval.
>>> Migrations between CPUs can also shorten an interval: if the new
>>> CPU's sched_clock() is ahead of the previous one (say by 15 ms),
>>> the apparent elapsed time within the current interval is inflated,
>>> so only ~5 ms of real time remains before the deadline fires (with
>>> the configured tx-usecs at 20 ms). Without migrations the interval
>>> stays consistently close to the configured value. I don't think
>>> this is a problem in practice -- it just adds some variance to the
>>> p5 of the measured interval.
>> Yes, and then we mistakenly decrease the BQL limit once.
>> But we react fast on that starvation. So its fine.
>>
>>>>> I don't know how much this matters in practice. Not sure which archi=
tectures still hit the jiffies fallback.When in doubt we could disable BQL=
 for those, or pin it to a "virtual queue size" via limit_min / limit_max =
similar to the v5 behavior and call queue_completed for every packet. Wdyt=
?
>>>> Yes, probably not relevant, I think I would just disable it for those
>>>> architectures, avoiding possible regressions.
>>>>
>>>>>> 3. Inflight can be stuck at a value>0 for a long time when packet
>>>>>>       enqueueing stops. Only when packets are enqueued again,
>>>>>>       (on the next veth_xdp_rcv() call,) netdev_tx_completed_queue(=
) is
>>>>>>       executed and inflight is set to 0 again.
>>>>>>       Can also be seen when looking at the /sys BQL statistics.
>>>>> This happens if the ring empties before the next queue_completed fir=
es,
>>>>> right?
>>>>>
>>>> Exactly.
>>>>
>>>>> Another thing: Is it counterintuitive to set the tx_usec_coal on the
>>>>> receive device? Because this is a bql related config that is normall=
y
>>>>> configured on the TX side?
>>>> Yes, I would say so.
>>>>
>>>>>> BTW: Yesterday, I worked on and refactored the code into its own .h
>>>>>>         file as a library and it also works fine for TUN/TAP (+vhos=
t-net)
>>>>>>         for me :)
>>>>> Nice! Thank you.
>>>>> Jonas
>>>>>
>>>>>> Thanks for your work!
>>>>>> Simon
>>>>>>
>>>>>> [1] Link: https://docs.kernel.org/timers/timekeeping.html
>>>>>>
>>>>>>> [1]https://github.com/jkoeppeler/veth-backpressure-performance-tes=
ting/tree/pktgen-and-benchmark
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Jonas
>>>>>>>
>>>>>>>> Thanks!
>>>>>>>>
>>>>>>>> BTW: I think that this implementation could also work for other
>>>>>>>>          software interfaces.
>>>>>>>>
>>>>>>>>> [2] Link:https://medium.com/@tom_84912/byte-queue-limits-the-una=
uthorized-biography-61adc5730b83
>>>>>>>>>
>>>>>>>>>> There is an important gotcha. We actually have micro-burst of q=
ueuing
>>>>>>>>>> (likely due to scheduling noise). Reading BQL stats from /sys w=
ill show
>>>>>>>>>> BQL inflight=3D1, but when using the option --hist is it visibl=
e that
>>>>>>>>>> @inflight have a long tail (see below signature).  The "qdisc" =
output
>>>>>>>>>> line also shows this happening via requeues increasing (approx =
17/sec in
>>>>>>>>>> a test with 567Kpps). (this was with the time-based BQL impl).
>>>>>>>>> I understand..
>>>>>>>>>

