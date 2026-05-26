Return-Path: <netdev+bounces-291724-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBopBu+yFWpxYAcAu9opvQ
	(envelope-from <netdev+bounces-291724-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:49:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7175D7E63
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E4A830429B0
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 14:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74CE3FF88A;
	Tue, 26 May 2026 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=schippers-hamm.de header.i=simon@schippers-hamm.de header.b="eIs8Z85X"
X-Original-To: netdev@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602BB26F29C;
	Tue, 26 May 2026 14:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806532; cv=none; b=ja8R2nlkn7PonubivwtwP5LjDINorpYtRc1d4GsKa7XGSPCBdZTaXZ7//zn/KGLwA3MkgQthhByQ50Kr5G7hZXxfF9Ul8sClMilcaEBstb+5fM/bzE2sxTK0Y0KFHnDsa/0i5UYD74f/JLBaoyIgInZaYtrri5TOPPQplP0ypBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806532; c=relaxed/simple;
	bh=z8FXpTssu0A4VQCeQZDNSXNUQ9cEnjG8g4W7U7zhKEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pVNEalYQDfC8Hjo8U+JtuPGDoXz+1ofyRRERUZRBCQcnT3u+t7kvXc+9DZ4acM90Q/GIoSqRSEHpSiE6i44vzNq/1Opl56OMDJLhPnB+LJtPGF9iUI2xjFzYQHoN0kU455P8SGL+sR1PSKK0l+EVSTF7+4YfeyN6Fq0/d2zu8F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schippers-hamm.de; spf=pass smtp.mailfrom=schippers-hamm.de; dkim=pass (2048-bit key) header.d=schippers-hamm.de header.i=simon@schippers-hamm.de header.b=eIs8Z85X; arc=none smtp.client-ip=212.227.126.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schippers-hamm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schippers-hamm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schippers-hamm.de;
	s=s1-ionos; t=1779806522; x=1780411322; i=simon@schippers-hamm.de;
	bh=GTxKi06B8bLk3AVcffRQcTZyFGL04TCNIRYCKf7TXfg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=eIs8Z85XpmzSLXLf2IyGYFrPNfj4taOsS1zWw3Zyy/cRtH/GN9tN1F0KWnohGJhR
	 DWcbMn5X23MUghhUzNzpKcL5DbGYQyOXnFYamh1djFLinsMYhsNg3giUffGLukOTy
	 dk41QFLsTSPpotqYkge82+ALPwGzKI2ETwUSZGawJ2ifvIAQVivjcsMl/VRqACVML
	 ohnsB3x9zl3dXHDn9qDdCMMCdKFr61iFIJtRcEo4tcn1DBqGYE5GAn3uTZoa4DkrY
	 HbZ8UNuAi+Rr8NeWf6LnznaR3jKQJfd0WYN++lQpIqb63wbbgnWUtrcj2IbKpFCur
	 IE1LDVTAhAPvOXVO5A==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue009
 [212.227.15.136]) with ESMTPSA (Nemesis) id 1N1Ofr-1xTq6q1WIN-015sNI; Tue, 26
 May 2026 16:35:55 +0200
Message-ID: <c5b3a7ef-8ec7-4361-80bb-cf06e910350c@schippers-hamm.de>
Date: Tue, 26 May 2026 16:35:47 +0200
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
 <b1c2d2c1-a70a-4bf4-baff-d0ac2f878722@schippers-hamm.de>
 <24d10b53-c545-4141-95a5-5c49c35c5d6c@tu-berlin.de>
Content-Language: en-US
From: Simon Schippers <simon@schippers-hamm.de>
In-Reply-To: <24d10b53-c545-4141-95a5-5c49c35c5d6c@tu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t0uTRR+NqP25gvj7bK1I68oLIfgmIhaVmXyfmMkujLqWJr67Xwv
 OIEV1QQqn9tGaEC/tSSvh0+Y9iJm27Ur+1EpxNuPqHqAHfwn3V5AWecoCOHThZcJyNw1Muw
 qlX4hMwZwaOIiFPH8QAD7CXE3dsnUZbkraEvtPB+jVWBm8uVpuIKdGm6/GBaniKswSc1cwE
 w2Sg5/f51iDgxCVRyDhYA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ly9v/L5lWbg=;q99lI2Q4SPGcK6qFe8wdcSNWm28
 +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
 piINx8ds4m58X/YQqteCFg9AodK6pceI
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[schippers-hamm.de,none];
	R_DKIM_ALLOW(-0.20)[schippers-hamm.de:s=s1-ionos];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291724-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[schippers-hamm.de:mid,schippers-hamm.de:dkim,veth_bql_test_virtme.sh:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,medium.com:url]
X-Rspamd-Queue-Id: 5D7175D7E63
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/26/26 11:54, Jonas K=C3=B6ppeler wrote:
> On 5/23/26 6:09 PM, Simon Schippers wrote:
>> On 5/22/26 18:26, Jonas K=C3=B6ppeler wrote:
>>> On 5/22/26 10:41, Simon Schippers wrote:
>>>> On 5/22/26 09:14, Jonas K=C3=B6ppeler wrote:
>>>>> On 5/19/26 10:51 PM, Simon Schippers wrote:
>>>>>> On 5/12/26 23:55, Simon Schippers wrote:
>>>>>>> On 5/12/26 15:54, Jesper Dangaard Brouer wrote:
>>>>>>>>>> Nope, I'm using a bpftrace program to keep track of the infligh=
t/limit
>>>>>>>>>> in a BPF hashmap.  Reading from /sys will not be accurate.
>>>>>>>>> Ah nice.
>>>>>>>> Add the option --hist to have both NAPI and BQL histograms printe=
d when
>>>>>>>> script ends.  This will give you an accurate pattern of how infli=
ght and
>>>>>>>> limit evolves.
>>>>>>>>
>>>>>>>>>> I moved the selftests into a github repo [1] to allow us to col=
laborate
>>>>>>>>>> and evaluate the changes more easily.  I explicitly kept the ne=
w BPF
>>>>>>>>>> based BQL tracking as a commit[2] for your benefit.
>>>>>>>>>>
>>>>>>>>>>      [1]https://github.com/netoptimizer/veth-backpressure-perfo=
rmance-testing/tree/main/selftests
>>>>>>>>>>
>>>>>>>>>>      [2]https://github.com/netoptimizer/veth-backpressure-perfo=
rmance-testing/commit/f25c5dc92977
>>>>>>>>> Thanks for sharing. After minor issues I was able to set it up
>>>>>>>>> (currently I am just using plain v5, will look at the coalescing=
 patch
>>>>>>>>> when I find the time):
>>>>>>>>>
>>>>>>>>> Can confirm the latency reduction with the default settings, in =
my case
>>>>>>>>> 4.888ms to 0.241ms.
>>>>>>>>>
>>>>>>>>> With the same script I was also able to see a performance slow d=
own:
>>>>>>>>> veth_bql_test_virtme.sh --qdisc fq_codel --nrules 0
>>>>>>>>> --> ~510 Kpps
>>>>>>>>> Same with --bql-disable
>>>>>>>>> --> ~570 Kpps
>>>>>>>>> --> 12% faster
>>>>>>>>>
>>>>>>>> Thanks for running these benchmarks.
>>>>>>>>
>>>>>>>> Notice that --nrules 0 can easily result in no-queuing (on averag=
e),
>>>>>>>> because the veth NAPI consumer is faster than the producer.  You =
will
>>>>>>>> likely see BQL inflight=3D1 and sink reported avg latency very lo=
w
>>>>>>>> (remember it okay that sink get high latency penalty as long at p=
ing
>>>>>>>> latency remains low, as that show AQM is working).
>>>>>>> I ran the benchmarks with --hist and I see what you mean.
>>>>>>> I have very similar results.
>>>>>>>
>>>>>>> Is Jonas way [1] of modifiying pktgen maybe the best option to ens=
ure
>>>>>>> that the producer is faster than the consumer?
>>>>>>>
>>>>>>> [1] Link:https://lore.kernel.org/netdev/e8cdba04-aa9a-45c6-9807-82=
74b62920df@tu-dortmund.de/
>>>>>>>
>>>>>>>> Hi, so what I found is that pktgen does not respect
>>>>>>>> __QUEUE_STATE_STACK_OFF. So the test data above is invalid, since=
 it
>>>>>>>> just sent packets even if the BQL "stopped" the queue. So I patch=
ed
>>>>>>>> pktgen with the following:
>>>>>>>>
>>>>>>>> -       if (unlikely(netif_xmit_frozen_or_drv_stopped(txq))) {
>>>>>>>> +       if (unlikely(netif_xmit_frozen_or_stopped(txq))) {
>>>>>>> After thinking more about the implementation I see possible issues=
:
>>>>>>>
>>>>>>> 1. netdev_tx_completed_queue() never reports more than burst=3D64 =
packets:
>>>>>>>
>>>>>>> BQL only increments the limit if the queue was starved. That means=
:
>>>>>>> "The queue was over-limit in the last interval (the last time comp=
letion
>>>>>>> processing ran), and there is no more data in the queue (i.e. it=
=E2=80=99s
>>>>>>> empty)" [2]
>>>>>>> But as only 64 packets are reported at max, the queue can only gro=
w when
>>>>>>> it is <=3D 64 packets. And then it can only stay at a limit >64 un=
til the
>>>>>>> next decrease of the limit.
>>>>>>>
>>>>>>>
>>>>>>> 2. netdev_tx_completed_queue() is called in irregular intervals:
>>>>>>>
>>>>>>> If the consumer is slow it is called approx each tx_coal_usecs.
>>>>>>> But if the consumer is fast it is called way more frequent, probab=
ly
>>>>>>> in irregular intervals depending on the scheduling.
>>>>>>> However, "BQL depends on periodic completion interrupts" [2].
>>>>>>>
>>>>>>> --> How about adding something like an interrupt that triggers eve=
ry
>>>>>>>        10us and calls netdev_tx_completed_queue() with n_bql colle=
cted from
>>>>>>>        (multiple) veth_xdp_rcv runs? That could solve 1. and 2.
>>>>>> Hi,
>>>>>>
>>>>>> I worked on a new version (see attachment) that addresses both issu=
es.
>>>>>>
>>>>>> The major change is that instead of tracking the timestamp and pack=
et
>>>>>> count as local variables in veth_xdp_rcv(), they are now stored
>>>>>> persistently in veth_rq as struct veth_bql_state. This allows compl=
etions
>>>>>> to accumulate across multiple NAPI poll calls, so
>>>>>> netdev_tx_completed_queue() can report more than 64 packets at once
>>>>>> (see point 1). To get the time I am using (the fast) sched_clock() =
with
>>>>>> a trick to avoid issues when switching between CPUs.
>>>>>>
>>>>>> For point 2, the coalescing deadline is now checked both before the
>>>>>> receive loop (to flush completions that timed out since the previou=
s
>>>>>> poll) and after each consumed packet, making completion intervals m=
ore
>>>>>> regular. Still the intervals can be smaller than
>>>>>> VETH_BQL_COAL_TX_USECS, but I guess this is fine.
>>>>>>
>>>>>> I also found out that the BQL limit correlates closely with
>>>>>> VETH_BQL_COAL_TX_USECS. It essentially reflects the latency we are
>>>>>> targeting. I raised the default to 100 =C2=B5s to allow DQL to conv=
erge to a
>>>>>> higher limit (for reaching 255 in the testing below).
>>>>>>
>>>>>> With the patched pktgen (respecting __QUEUE_STATE_STACK_XOFF), test=
ing
>>>>>> shows:
>>>>>> - --nrules 0: DQL limit reaches (up to) ~255
>>>>>> - --nrules 10000: DQL limit converges to ~0 (with --gro-disable)
>>>>>>
>>>>>> These results are what I would expect from a BQL algorithm, but mor=
e
>>>>>> testing is needed of course.
>>>>>>
>>>>>> What do you think?
>>>>> Hi,
>>>>>
>>>>> This is exactly what I had in mind for implementing the BQL algorith=
m
>>>>> in this case. I did some testing with pktgen of this patch and also
>>>>> compared it to the v5 version.
>>>>>
>>>>> You can find an extension of the benchmark script with pktgen here [=
1],
>>>>> as well as a wrapper script (veth_bql_bench.sh) to run the test scri=
pt
>>>>> with and without --bql-disable to report the difference. I also
>>>>> configured pktgen to use the qdisc as suggested by Jesper.
>>>> Great, I will use your pktgen solution from now on.
>>>>
>>>> Didn't know about the qdisc option, is there a performance difference
>>>> with/without it? Or is it to have ping working next to pktgen?
>>> Did not see any big difference performance-wise, but as you say, ping
>>> works better with pktgen then.
>>>
>>>> Consider to do a pull request :)
>>>>
>>>>> Note: bpftrace needs to be disabled, otherwise it becomes the
>>>>> bottleneck (at least on my machine) and pktgen throughput is halved
>>>>> when enabled.
>>>> Good to know.
>>>>
>>>>> Here are the results:
>>>>>
>>>>> v5 (not time-based):
>>>>> --nrules 0 --pktgen --no-bpftrace
>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>> Results (average over 10 runs):
>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>                          BQL on    BQL off
>>>>> ---                    ------    -------
>>>>> Throughput (pps)      1980871    2169898
>>>>> Ping RTT avg (ms)       0.065      0.162
>>>>> Throughput diff         -8.7%   // BQL 8.7% lower throughput
>>>>> RTT diff               -59.9%   // BQL 60% lower latency
>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>
>>>>> Simon's time-based version:
>>>>>
>>>>> Test args: --nrules 0 --pktgen --no-bpftrace
>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>> Results (average over 10 runs):
>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>                              BQL on      BQL off
>>>>> ---                        ------      -------
>>>>> Throughput (pps)          2166335      2153398
>>>>> Ping RTT avg (ms)           0.165        0.165
>>>>> Throughput diff              0.6%
>>>>> RTT diff                     0.0%
>>>>>
>>>>> --pktgen --no-bpftrace --nrules 3500
>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>> Results (average over 10 runs):
>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>                              BQL on      BQL off
>>>>> ---                        ------      -------
>>>>> Throughput (pps)            28569        28696
>>>>> Ping RTT avg (ms)           1.327        8.409
>>>>> Throughput diff             -0.4%
>>>>> RTT diff                   -84.2%
>>>>>
>>>> I think we should run benchmarks against the stock net-next to
>>>> be safe.
>>> --nrules 0 --pktgen --no-bpftrace
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> Results (average over 10 runs):
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>                       net-next
>>> ---                  -------
>>> Throughput (pps)     2285421
>>> Ping RTT avg (ms)    0.161
>>>
>>> (slightly adjusted the output to better communicate the results)
>>>
>>> So in my case this means BQL implementation has ~5% lower throughput
>>> compared to net-next. But please double check.
>>>
>> Yes, I will benchmark myself.
>>
>> There are probably some places where we can gain performance.
>> For example, I see ptr_ring_empty() which could be swapped for
>> __ptr_ring_empty() which would save a spinlock and unlock.
>>
>>>>> Seems to work now as expected.
>>>> Yes, but I think we have to keep these points in mind:
>>>>
>>>> 1. Limit/Inflight can be bigger than VETH_RING_SIZE, because
>>>>      packets can be enqueued in the same time as they are read out,
>>>>      so netdev_tx_completed_queue() can theoretically be called with
>>>>      many number of packets.
>>>>      I do not think it is deal-breaking though.
>>>>      I could see such high limits/inflights when looking at the /sys
>>>>      BQL statistics..
>>> For me this makes sense, that inflight just means the number of
>>> packets not yet 'completed' or the number of packets that you
>>> can send between two completion calls. I think this is not specific
>>  From my understanding, I do think that this behavior is
>> pretty specific.
>>
>> Typically BQL-enabled NIC drivers clear packets out of some
>> internal buffer in their completion interrupt (or something
>> similar). And after that they call netdev_tx_completed_queue().
>=20
> You are right, because descriptors are freed at the same time when they =
are accounted for.
>=20
>>> to this implementation. But for long intervals this might result in
>>> some problems because you can just fill the veth_ring to its capacity
>>> quickly, and increasing latency if the receiver is slow.
>> Yes, but I think the latency can only be approx. as big as the
>> interval (can be higher with GRO enabled).
>=20
> I think it's more like ~2.x times added latency in the worst case,
> which is normal BQL behavior, but for large intervals 2x is a lot.
> Of course this value is also capped by the time it takes to process
> the 256 packets that fit in the ring buffer.
>=20
> For example, for a test run with fq_codel and 20K rules, and a ping
> baseline of 1.7 ms without pktgen load, the results are:
> tx-usecs   p99_ping_rtt (ms)
> --------   -----------------
>      0           5.223
>    100           6.910
>    500           7.197
>   1000           6.967
>   5000          16.233
>  10000          25.033
>  20000          44.133
>=20
> Also, the interval is sometimes dominated by the processing time of
> a packet batch (and other effects). The default is 8 packets/batch
> (see gro_normal_batch). This means that for 7 packets you see
> processing times on the order of a few hundred nanoseconds, but for
> the 8th you see the processing time of the whole batch (see table below)=
.
> With a ruleset > 1000 entries, this exceeds the default tx-usecs value,
> which is why the p99 RTT increase is even larger than 2x tx-usecs
> -- as you can see in the table for tx-usecs values 0-5000.
>=20
> tx-usecs 0 nrules 0
> Percentile   per-packet processing time (=C2=B5s)
> ----------   -------------
>     p5             0.316
>    p25             0.382
>    p50             0.442
>    p75             0.508 -- fast enqueue to skb_list
>    p95            68.304 -- batch processing time
>=20
> Setting gro_normal_batch to 1 makes the interval times more
> accurate and improves p99 RTT slightly, though it's still > 2x the
> tx-usecs latency increase.
>=20
> However, using smaller values > 0 means that you can benefit
> from bql, but the actual interval might be larger than the
> configured value. I do not think this is a deal breaker, but
> something worth noting where the latencies come from.

I understand and agree with your points.
I also do not see anything deal-breaking.
Yes, there is no guarantee for the latency, but BQL
is best-effort anyway.

I will wait for your new measurements, but there is no argument
against a default tx-usecs of ~100us for now, right?

>=20
> Also worth noting: using fq_codel is better to use in this
> case because it can fast track sparse flows. using sfq the
> ping packet can get head of line blocked by the current quantum
> of sfq, if my understanding is correct.

Why don't we use a prio qdisc where ping gets prioritized?=20
Then we do not have to worry about head of line blocking on
the qdisc layer and instead can concentrate on veth.

>=20
>>> To illustrate this have a look at [1]. There are some plots that
>>> show the rtt vs. tx-usec config depending on nrules.
>>>
>>> [1] https://github.com/jkoeppeler/veth-backpressure-performance-testin=
g/tree/pktgen-and-benchmark/results/tx-usecs
>>>
>> Nice plots! Great for finding a sane default value.
>=20
> I did some more measurements to better understand whats
> happening. I will upload the results latest by tomorrow
> to the github repository mentioned above.
>=20
>>>> 2. sched_clock() is only valid on the same CPU. When a different
>>>>      CPU starts executing its sched_clock() can be in the past compar=
ed
>>>>      to the sched_clock() value saved by the previous CPU.
>>>>      My trick...
>>>>      min(s->time, sched_clock())
>>>>      ... avoids potentially extremely long intervals between
>>>>      netdev_tx_completed_queue() calls but is not perfect of course.
>>>>      I think CPU hopping happens rarely enough for this to matter..
>>>>      And also we have to keep this in mind [1]:
>>>>      "An architecture may or may not provide an implementation of
>>>>      sched_clock() on its own. If a local implementation is not provi=
ded,
>>>>      the system jiffy counter will be used as sched_clock()."
>>> So the problem with this is that with jiffies you have like millisecon=
d
>>> interval granularity, which might be too long in order to work properl=
y.
>>> Given the receiver completes 128 packet in 1ms (queue_completed interv=
al),
>>> the bql will set the limit at 256. Then the tx thread can quickly fill
>>> the ring, and it then basically stopped until the 1ms interval is over=
.
>>>
>>
>> Linux Mint only has 100Hz jiffies :^)
>=20
> ok so 10ms granularity. Effectively disables BQL for the most part.
> However, you can still benefit if your receive side is very slow.
>=20
>>
>> I think you misunderstand something.
>>
>> +    if (peer_txq && state->n_bql && ptr_ring_empty(&rq->xdp_ring)) {

            // Pairs with smp_wmb() in __ptr_ring_produce()

>> +        smp_rmb();
>> +        if (test_bit(__QUEUE_STATE_STACK_XOFF, &peer_txq->state))
>> +            veth_bql_complete(state, peer_txq);
>> +    }
>>
>> This snippet completes whenever the queue is empty and the
>> netdev queue is stopped due to BQL.
>> So then the interval is smaller than 1ms.
>> I think, that is the reason why the pps is fine for 1ms in
>> your benchmarks.
>=20
> Without that snippet the queue stalls during ramp-up and
> throughput never gets off the ground. But once the BQL limit has
> stabilized, the snippet is no longer invoked -- with --nrules 0
> the queue is never stopped, and with a slow receiver the queue is
> not empty. So the snippet is needed for correct ramp-up, but it
> doesn't affect steady-state throughput in these tests. This is also
> confirmed by a test where I measure the time between intervals.
> For 1000us across all nrules configurations the time ranges between
> 1000-1400us.

Yes, I agree. It only acts in the case of starvation (see [1])
and I think it is an advantage that we react faster compared
to other BQL implementations.

Additionally the snippet is *required* because if the ring
is empty and the txq stopped due to BQL, there are no more
veth_xdp_recv() calls, permanently stalling everything.
That is the reason for the memory barrier pairing in the snippet.

[1] Link: https://medium.com/@tom_84912/byte-queue-limits-the-unauthorized=
-biography-61adc5730b83

>=20
> The variance of the time between intervals is also quite good in
> general, but not always exact the configured value. For most cases
> +-5% from p50 value of the real interval.
> Migrations between CPUs can also shorten an interval: if the new
> CPU's sched_clock() is ahead of the previous one (say by 15 ms),
> the apparent elapsed time within the current interval is inflated,
> so only ~5 ms of real time remains before the deadline fires (with
> the configured tx-usecs at 20 ms). Without migrations the interval
> stays consistently close to the configured value. I don't think
> this is a problem in practice -- it just adds some variance to the
> p5 of the measured interval.

Yes, and then we mistakenly decrease the BQL limit once.
But we react fast on that starvation. So its fine.

>=20
>>> I don't know how much this matters in practice. Not sure which archite=
ctures still hit the jiffies fallback.When in doubt we could disable BQL f=
or those, or pin it to a "virtual queue size" via limit_min / limit_max si=
milar to the v5 behavior and call queue_completed for every packet. Wdyt?
>> Yes, probably not relevant, I think I would just disable it for those
>> architectures, avoiding possible regressions.
>>
>>>> 3. Inflight can be stuck at a value>0 for a long time when packet
>>>>      enqueueing stops. Only when packets are enqueued again,
>>>>      (on the next veth_xdp_rcv() call,) netdev_tx_completed_queue() i=
s
>>>>      executed and inflight is set to 0 again.
>>>>      Can also be seen when looking at the /sys BQL statistics.
>>> This happens if the ring empties before the next queue_completed fires=
,
>>> right?
>>>
>> Exactly.
>>
>>> Another thing: Is it counterintuitive to set the tx_usec_coal on the
>>> receive device? Because this is a bql related config that is normally
>>> configured on the TX side?
>> Yes, I would say so.
>>
>>>> BTW: Yesterday, I worked on and refactored the code into its own .h
>>>>        file as a library and it also works fine for TUN/TAP (+vhost-n=
et)
>>>>        for me :)
>>> Nice! Thank you.
>>> Jonas
>>>
>>>> Thanks for your work!
>>>> Simon
>>>>
>>>> [1] Link: https://docs.kernel.org/timers/timekeeping.html
>>>>
>>>>> [1]https://github.com/jkoeppeler/veth-backpressure-performance-testi=
ng/tree/pktgen-and-benchmark
>>>>>
>>>>> Thanks,
>>>>> Jonas
>>>>>
>>>>>> Thanks!
>>>>>>
>>>>>> BTW: I think that this implementation could also work for other
>>>>>>         software interfaces.
>>>>>>
>>>>>>> [2] Link:https://medium.com/@tom_84912/byte-queue-limits-the-unaut=
horized-biography-61adc5730b83
>>>>>>>
>>>>>>>> There is an important gotcha. We actually have micro-burst of que=
uing
>>>>>>>> (likely due to scheduling noise). Reading BQL stats from /sys wil=
l show
>>>>>>>> BQL inflight=3D1, but when using the option --hist is it visible =
that
>>>>>>>> @inflight have a long tail (see below signature).  The "qdisc" ou=
tput
>>>>>>>> line also shows this happening via requeues increasing (approx 17=
/sec in
>>>>>>>> a test with 567Kpps). (this was with the time-based BQL impl).
>>>>>>> I understand..
>>>>>>>

