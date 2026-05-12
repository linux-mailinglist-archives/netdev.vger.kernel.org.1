Return-Path: <netdev+bounces-287332-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBJtJPKhA2qw8QEAu9opvQ
	(envelope-from <netdev+bounces-287332-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:56:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EDE52AAB3
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D0E130C1DAE
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 21:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D10D39479B;
	Tue, 12 May 2026 21:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=schippers-hamm.de header.i=simon@schippers-hamm.de header.b="ckgDEjSt"
X-Original-To: netdev@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC44F394789;
	Tue, 12 May 2026 21:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778622938; cv=none; b=aandnD6D6zAXHVCgk0AgEQw0HYoNyd5w8+XohLVyQIXyIzJylh8Gy2/SDmks8UXVadU7PWlZGPbNaahrKvNA+wetX5V/7ofpw/YRexScF04PT2uND5qXFN1eeiTDJlItIT+96ei8dM8bUKcJ1HIEY9+oRPaB4aXKA5Rg5Q0aUPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778622938; c=relaxed/simple;
	bh=9OKfjcLlkQFyI5IhUm8pBNqPEkYkATjEuvPiG0tRQZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YwE5QzwdxKer+CT9y5VBPGNGAn3PvSXLhucKm5NxMUQ7db0r80KjdLUzKmPcGTP7FVfMVmaUO7ZTcOxsVldNJZY9W9EyKJxFLmNz/er1XFlqpoWhkIlpgvK++ZSiBp2J0enqvL/kFYW3C3DcxFQItjR5J2ElfACpLIGAuyghH8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schippers-hamm.de; spf=pass smtp.mailfrom=schippers-hamm.de; dkim=pass (2048-bit key) header.d=schippers-hamm.de header.i=simon@schippers-hamm.de header.b=ckgDEjSt; arc=none smtp.client-ip=212.227.126.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schippers-hamm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schippers-hamm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schippers-hamm.de;
	s=s1-ionos; t=1778622913; x=1779227713; i=simon@schippers-hamm.de;
	bh=0vsePM0CCPre+AfYJpOIIy6ZHx5qmpoR3kgWZ7zEfn8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ckgDEjStOqijFXzQL4aMoaq6MxkzIqrX5Dli2sswMf42M2y6ZYU1dD0Q40AgWXQx
	 iO0eFiylcjJIxNrg3mv1cLTR6KYPpuBV01PraKfUZnpw8T0aK+/T+ECS/bs8db+D/
	 SI58ahyd9q7FGFV9NiPPcWAPWw6MQ0+0mQcCSP7tqEAP2AgQElRz+qwe4QhT+zG7T
	 z/CS3owfnQdXci1B6b9UfrE6r5gpA8waWJhiOljYfayARy5zgh6d4vXoo+25bqCKL
	 pqWsZOnyFld8DO++nuW6974fpBdosS0eNzd7TJpFm9Vl2zfibywaFynkHyEyW3RR9
	 C4FqVg3NeV0bDcaF6Q==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue011
 [212.227.15.134]) with ESMTPSA (Nemesis) id 1M2w4S-1wQEST2HSG-0055a5; Tue, 12
 May 2026 23:55:13 +0200
Message-ID: <14348957-d061-4124-9bac-45df9cf6686c@schippers-hamm.de>
Date: Tue, 12 May 2026 23:55:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/5] veth: implement Byte Queue Limits (BQL)
 for latency reduction
To: Jesper Dangaard Brouer <hawk@kernel.org>, Jakub Kicinski <kuba@kernel.org>
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
Content-Language: en-US
From: Simon Schippers <simon@schippers-hamm.de>
In-Reply-To: <18855e57-f050-411f-9958-d4babcc81ba3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pmIrVMJrkUT4hy5OoYlXCFgRmT/fp1oo6GBh2sVWATwFduZsmrK
 m22lMXCIgacZvBRZea0601KWL/xwoTMaSXgot/gFutjNfQFeCVGD6xgc0xnpc087mXwvWNF
 KT5oy1aaKLUUiiD7zbDVN0UpKqJ5RSUd5omzGF4gG4wpjBUtqFU3NgniV5pJwTviob3Kj37
 HSo639/FyiOOyWf20a/aQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:d/YUiS2CD9w=;C+RSke+QdM+nqUjk738ALOSFRI+
 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
X-Rspamd-Queue-Id: E5EDE52AAB3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[schippers-hamm.de,none];
	R_DKIM_ALLOW(-0.20)[schippers-hamm.de:s=s1-ionos];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287332-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,cloudflare.com,lunn.ch,davemloft.net,google.com,kernel.org,iogearbox.net,gmail.com,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[medium.com:url,veth_bql_test_virtme.sh:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,schippers-hamm.de:mid,schippers-hamm.de:dkim]
X-Rspamd-Action: no action

On 5/12/26 15:54, Jesper Dangaard Brouer wrote:
>>> Nope, I'm using a bpftrace program to keep track of the inflight/limit
>>> in a BPF hashmap.  Reading from /sys will not be accurate.
>>
>> Ah nice.
>=20
> Add the option --hist to have both NAPI and BQL histograms printed when
> script ends.  This will give you an accurate pattern of how inflight and
> limit evolves.
>=20
>>>
>>> I moved the selftests into a github repo [1] to allow us to collaborat=
e
>>> and evaluate the changes more easily.  I explicitly kept the new BPF
>>> based BQL tracking as a commit[2] for your benefit.
>>>
>>>   [1] https://github.com/netoptimizer/veth-backpressure-performance-te=
sting/tree/main/selftests
>>>
>>>   [2] https://github.com/netoptimizer/veth-backpressure-performance-te=
sting/commit/f25c5dc92977
>>
>> Thanks for sharing. After minor issues I was able to set it up
>> (currently I am just using plain v5, will look at the coalescing patch
>> when I find the time):
>>
>> Can confirm the latency reduction with the default settings, in my case
>> 4.888ms to 0.241ms.
>>
>> With the same script I was also able to see a performance slow down:
>> veth_bql_test_virtme.sh --qdisc fq_codel --nrules 0
>> --> ~510 Kpps
>> Same with --bql-disable
>> --> ~570 Kpps
>> --> 12% faster
>>
>=20
> Thanks for running these benchmarks.
>=20
> Notice that --nrules 0 can easily result in no-queuing (on average),
> because the veth NAPI consumer is faster than the producer.  You will
> likely see BQL inflight=3D1 and sink reported avg latency very low
> (remember it okay that sink get high latency penalty as long at ping
> latency remains low, as that show AQM is working).

I ran the benchmarks with --hist and I see what you mean.
I have very similar results.

Is Jonas way [1] of modifiying pktgen maybe the best option to ensure
that the producer is faster than the consumer?

[1] Link: https://lore.kernel.org/netdev/e8cdba04-aa9a-45c6-9807-8274b6292=
0df@tu-dortmund.de/

> Hi, so what I found is that pktgen does not respect
> __QUEUE_STATE_STACK_OFF. So the test data above is invalid, since it
> just sent packets even if the BQL "stopped" the queue. So I patched
> pktgen with the following:
>=20
> -       if (unlikely(netif_xmit_frozen_or_drv_stopped(txq))) {
> +       if (unlikely(netif_xmit_frozen_or_stopped(txq))) {


After thinking more about the implementation I see possible issues:

1. netdev_tx_completed_queue() never reports more than burst=3D64 packets:

BQL only increments the limit if the queue was starved. That means:
"The queue was over-limit in the last interval (the last time completion
processing ran), and there is no more data in the queue (i.e. it=E2=80=99s
empty)" [2]
But as only 64 packets are reported at max, the queue can only grow when
it is <=3D 64 packets. And then it can only stay at a limit >64 until the
next decrease of the limit.=20


2. netdev_tx_completed_queue() is called in irregular intervals:

If the consumer is slow it is called approx each tx_coal_usecs.
But if the consumer is fast it is called way more frequent, probably
in irregular intervals depending on the scheduling.
However, "BQL depends on periodic completion interrupts" [2].

=2D-> How about adding something like an interrupt that triggers every
    10us and calls netdev_tx_completed_queue() with n_bql collected from
    (multiple) veth_xdp_rcv runs? That could solve 1. and 2.=20

[2] Link: https://medium.com/@tom_84912/byte-queue-limits-the-unauthorized=
-biography-61adc5730b83

>=20
> There is an important gotcha. We actually have micro-burst of queuing
> (likely due to scheduling noise). Reading BQL stats from /sys will show
> BQL inflight=3D1, but when using the option --hist is it visible that
> @inflight have a long tail (see below signature).  The "qdisc" output
> line also shows this happening via requeues increasing (approx 17/sec in
> a test with 567Kpps). (this was with the time-based BQL impl).

I understand..

>=20
>=20
>>>
>>> Sorry for cutting the remaining of the message, but I ran out of time,
>>> as things are a bit challenging/hectic here at Cloudflare at the momen=
t.
>>>
>>> --Jesper
>>
>> All good, just ignore it. I think I misunderstood something anyway.
>=20
> Okay, I'll ignore it as I couldn't make sense of it ;-)
> --Jesper
>=20
>=20
>=20
> --- BQL inflight histogram (VETH_BQL_UNIT=3D1, values =3D packets) ---
> @inflight:
> [0, 1)            306565 |@      |
> [1, 2)           9250454 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@@|
> [2, 3)           5561919 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@      |
> [3, 4)            354341 |@      |
> [4, 5)             50137 |      |
> [5, 6)             16771 |      |
> [6, 7)              6001 |      |
> [7, 8)              3076 |      |
> [8, 9)              1949 |      |
> [9, 10)             1965 |      |
> [10, 11)            1954 |      |
> [11, 12)            1914 |      |
> [12, 13)            1732 |      |
> [13, 14)            1559 |      |
> [14, 15)            1405 |      |
> [15, 16)            1269 |      |
> [16, 17)            1194 |      |
> [17, 18)            1190 |      |
> [18, 19)            1148 |      |
> [19, 20)            1079 |      |
> [20, 21)            1008 |      |
> [21, 22)             951 |      |
> [22, 23)             870 |      |
> [23, 24)             826 |      |
> [24, 25)             775 |      |
> [25, 26)             764 |      |
> [26, 27)             740 |      |
> [27, 28)             714 |      |
> [28, 29)             665 |      |
> [29, 30)             626 |      |
> [30, 31)             607 |      |
> [31, 32)             601 |      |
> [32, 33)             583 |      |
> [33, 34)             593 |      |
> [34, 35)             574 |      |
> [35, 36)             562 |      |
> [36, 37)             554 |      |
> [37, 38)             538 |      |
> [38, 39)             528 |      |
> [39, 40)             525 |      |
> [40, 41)             512 |      |
> [41, 42)             542 |      |
> [42, 43)             529 |      |
> [43, 44)             526 |      |
> [44, 45)             513 |      |
> [45, 46)             503 |      |
> [46, 47)             485 |      |
> [47, 48)             480 |      |
> [48, 49)             473 |      |
> [49, 50)             474 |      |
> [50, 51)             476 |      |
> [51, 52)             476 |      |
> [52, 53)             465 |      |
> [53, 54)             454 |      |
> [54, 55)             446 |      |
> [55, 56)             430 |      |
> [56, 57)             425 |      |
> [57, 58)             425 |      |
> [58, 59)             422 |      |
> [59, 60)             407 |      |
> [60, 61)             390 |      |
> [61, 62)             370 |      |
> [62, 63)             354 |      |
> [63, 64)             343 |      |
> [64, 65)             325 |      |
> [65, 66)             303 |      |
> [66, 67)             158 |      |
> [67, 68)             136 |      |
> [68, 69)             124 |      |
> [69, 70)             110 |      |
> [70, 71)              99 |      |
> [71, 72)              94 |      |
> [72, 73)              82 |      |
> [73, 74)              74 |      |
> [74, 75)              58 |      |
> [75, 76)              52 |      |
> [76, 77)              45 |      |
> [77, 78)              40 |      |
> [78, 79)              39 |      |
> [79, 80)              38 |      |
> [80, 81)              21 |      |
> [81, 82)               4 |      |
> [82, 83)               4 |      |
> [83, 84)               4 |      |
> [84, 85)               2 |      |
> [85, 86)               2 |      |
> [86, 87)               2 |      |
> [87, 88)               2 |      |
> [88, 89)               1 |      |
>=20
>=20
> --- BQL limit histogram (auto-tuned, values =3D packets) ---
> @limit_val:
> [61, 62)          221346 |@      |
> [62, 63)               0 |      |
> [63, 64)          772169 |@@@      |
> [64, 65)        10053949 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@@|
> [65, 66)               0 |      |
> [66, 67)               0 |      |
> [67, 68)               0 |      |
> [68, 69)               0 |      |
> [69, 70)               0 |      |
> [70, 71)          457838 |@@      |
> [71, 72)               0 |      |
> [72, 73)          610198 |@@@      |
> [73, 74)               0 |      |
> [74, 75)               0 |      |
> [75, 76)               0 |      |
> [76, 77)               0 |      |
> [77, 78)               0 |      |
> [78, 79)         2328284 |@@@@@@@@@@@@      |
> [79, 80)         1150181 |@@@@@      |
>=20
> @inflight_stats: count 15593965, average 1, total 23078061
>=20
> @limit_stats: count 15593965, average 67, total 1054054856
>=20
>=20

