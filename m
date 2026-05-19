Return-Path: <netdev+bounces-289610-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEUIMw7PDGrImQUAu9opvQ
	(envelope-from <netdev+bounces-289610-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 22:58:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6ED584F34
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 22:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2BE93026C05
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7353D904F;
	Tue, 19 May 2026 20:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=schippers-hamm.de header.i=simon@schippers-hamm.de header.b="OXit4d4J"
X-Original-To: netdev@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51553C0619;
	Tue, 19 May 2026 20:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779224271; cv=none; b=kHGHyc/gPDfnLjrIUR8kmoquaJvbzf8iUMW2WQPNvsgF7ygZMsEJsW6Z31uDyiAi6bI0YFXTV0RIiuc3Au/+CFqlYOS7KWskQgA8OddXrXaztIIvrvpZHh7vpYFhh0rfVYdaSXWgG8/zH62SvsAR7XwuvZAlNbQb/Y63+XvmEoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779224271; c=relaxed/simple;
	bh=vs/d5bAucSv79wcOeHlFbt3LsD7ZbZYxwfVwglqc518=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:Cc:
	 References:In-Reply-To; b=GuW3zuVkVyG5lrZx+mNLR1yUTW8HNLakW2TMxTyDkdaqZ5rvhZxjuHVEWvjSvAsQSnahef5V/3jCnAaQnXRb4tQUj52vVI69E1rr+4k6ncLDpTaSRg1zXW/NSxZJjGM46HSqjUqI1jW9QDr3QV8uF3zISoOLYyUe2cFhK6WXcHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schippers-hamm.de; spf=pass smtp.mailfrom=schippers-hamm.de; dkim=pass (2048-bit key) header.d=schippers-hamm.de header.i=simon@schippers-hamm.de header.b=OXit4d4J; arc=none smtp.client-ip=212.227.17.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schippers-hamm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schippers-hamm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schippers-hamm.de;
	s=s1-ionos; t=1779224253; x=1779829053; i=simon@schippers-hamm.de;
	bh=2f7eQ3VNH4yzRHWS2Pg7xeYIfWN2KvwiyjNa6JQ6l/Y=;
	h=X-UI-Sender-Class:Content-Type:Message-ID:Date:MIME-Version:
	 Subject:From:To:Cc:References:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OXit4d4JBpKMf7RxWEpg9XGFVDp1Y5P8rjB9ocmVJIh0xiw3IyYHqsizy6n2f9Vs
	 uHIjSnDSHjBwgppg233zuEHaRi2Evx5yx0LJBwwtBbaopvJsVXBDrmEI1odiSXjnd
	 Tpq6AbVNM4SOlPruTRkKrb9fWtLKA4PMTeSJCtxA38hzcRDEHW9udLBkPy+pwEw8C
	 /A434miiN+4bnRR30Y2LQr5BH78bhD1KQPUWxMfoNk5GPiXNRPlGRpVs0rsiqLE9a
	 7tqM6aDPwA8hgblLUBT1d6VebAIhiHZWxMhv7UDF888aitYU76o/6HBbbNV3/K1oG
	 djFj3hGjikg8jURh8g==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue109
 [212.227.17.181]) with ESMTPSA (Nemesis) id 1N2E9Y-1xM6a72icQ-017sxu; Tue, 19
 May 2026 22:51:37 +0200
Content-Type: multipart/mixed; boundary="------------IuFoUowCST6hi2f0SK0gC58s"
Message-ID: <9a57bb41-114e-492b-9eaa-52237675bb7c@schippers-hamm.de>
Date: Tue, 19 May 2026 22:51:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/5] veth: implement Byte Queue Limits (BQL)
 for latency reduction
From: Simon Schippers <simon@schippers-hamm.de>
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
 <14348957-d061-4124-9bac-45df9cf6686c@schippers-hamm.de>
Content-Language: en-US
In-Reply-To: <14348957-d061-4124-9bac-45df9cf6686c@schippers-hamm.de>
X-Provags-ID: V03:K1:osEQp84Qm25LQM0qX930ggbTLDGlZkM1I5/88767+Xs7Y7Yb5lO
 Ql+bJeUoalclylDHWkoJI7qxdbAPjy6U0nLtHtrw85CBMJ7RFpDP9sNRsRzwU3K+J3mRDWF
 7TrWjr3tCCkaSO0lQHWU7QNepd65AuzESJLEzCrZbmQF2k2M/vWHzSxOYP6MGZtDrJ2V6Um
 5z78WIrvVa7Ffb4A/za7Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vzcDY0bFM4U=;jJ+VTeItsY9MBROTDbhDvHnBh9L
 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
 hEC6bOHaJjc=
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[schippers-hamm.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[schippers-hamm.de:s=s1-ionos];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289610-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[schippers-hamm.de:+];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simon@schippers-hamm.de,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,cloudflare.com,lunn.ch,davemloft.net,google.com,kernel.org,iogearbox.net,gmail.com,fomichev.me];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,medium.com:url,schippers-hamm.de:mid,schippers-hamm.de:dkim,tu-dortmund.de:email]
X-Rspamd-Queue-Id: 1F6ED584F34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a multi-part message in MIME format.
--------------IuFoUowCST6hi2f0SK0gC58s
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 5/12/26 23:55, Simon Schippers wrote:
> On 5/12/26 15:54, Jesper Dangaard Brouer wrote:
>>>> Nope, I'm using a bpftrace program to keep track of the inflight/limi=
t
>>>> in a BPF hashmap.  Reading from /sys will not be accurate.
>>>
>>> Ah nice.
>>
>> Add the option --hist to have both NAPI and BQL histograms printed when
>> script ends.  This will give you an accurate pattern of how inflight an=
d
>> limit evolves.
>>
>>>>
>>>> I moved the selftests into a github repo [1] to allow us to collabora=
te
>>>> and evaluate the changes more easily.  I explicitly kept the new BPF
>>>> based BQL tracking as a commit[2] for your benefit.
>>>>
>>>>   [1] https://github.com/netoptimizer/veth-backpressure-performance-t=
esting/tree/main/selftests
>>>>
>>>>   [2] https://github.com/netoptimizer/veth-backpressure-performance-t=
esting/commit/f25c5dc92977
>>>
>>> Thanks for sharing. After minor issues I was able to set it up
>>> (currently I am just using plain v5, will look at the coalescing patch
>>> when I find the time):
>>>
>>> Can confirm the latency reduction with the default settings, in my cas=
e
>>> 4.888ms to 0.241ms.
>>>
>>> With the same script I was also able to see a performance slow down:
>>> veth_bql_test_virtme.sh --qdisc fq_codel --nrules 0
>>> --> ~510 Kpps
>>> Same with --bql-disable
>>> --> ~570 Kpps
>>> --> 12% faster
>>>
>>
>> Thanks for running these benchmarks.
>>
>> Notice that --nrules 0 can easily result in no-queuing (on average),
>> because the veth NAPI consumer is faster than the producer.  You will
>> likely see BQL inflight=3D1 and sink reported avg latency very low
>> (remember it okay that sink get high latency penalty as long at ping
>> latency remains low, as that show AQM is working).
>=20
> I ran the benchmarks with --hist and I see what you mean.
> I have very similar results.
>=20
> Is Jonas way [1] of modifiying pktgen maybe the best option to ensure
> that the producer is faster than the consumer?
>=20
> [1] Link: https://lore.kernel.org/netdev/e8cdba04-aa9a-45c6-9807-8274b62=
920df@tu-dortmund.de/
>=20
>> Hi, so what I found is that pktgen does not respect
>> __QUEUE_STATE_STACK_OFF. So the test data above is invalid, since it
>> just sent packets even if the BQL "stopped" the queue. So I patched
>> pktgen with the following:
>>
>> -       if (unlikely(netif_xmit_frozen_or_drv_stopped(txq))) {
>> +       if (unlikely(netif_xmit_frozen_or_stopped(txq))) {
>=20
>=20
> After thinking more about the implementation I see possible issues:
>=20
> 1. netdev_tx_completed_queue() never reports more than burst=3D64 packet=
s:
>=20
> BQL only increments the limit if the queue was starved. That means:
> "The queue was over-limit in the last interval (the last time completion
> processing ran), and there is no more data in the queue (i.e. it=E2=80=
=99s
> empty)" [2]
> But as only 64 packets are reported at max, the queue can only grow when
> it is <=3D 64 packets. And then it can only stay at a limit >64 until th=
e
> next decrease of the limit.=20
>=20
>=20
> 2. netdev_tx_completed_queue() is called in irregular intervals:
>=20
> If the consumer is slow it is called approx each tx_coal_usecs.
> But if the consumer is fast it is called way more frequent, probably
> in irregular intervals depending on the scheduling.
> However, "BQL depends on periodic completion interrupts" [2].
>=20
> --> How about adding something like an interrupt that triggers every
>     10us and calls netdev_tx_completed_queue() with n_bql collected from
>     (multiple) veth_xdp_rcv runs? That could solve 1. and 2.=20

Hi,

I worked on a new version (see attachment) that addresses both issues.

The major change is that instead of tracking the timestamp and packet
count as local variables in veth_xdp_rcv(), they are now stored
persistently in veth_rq as struct veth_bql_state. This allows completions
to accumulate across multiple NAPI poll calls, so
netdev_tx_completed_queue() can report more than 64 packets at once
(see point 1). To get the time I am using (the fast) sched_clock() with
a trick to avoid issues when switching between CPUs.

For point 2, the coalescing deadline is now checked both before the
receive loop (to flush completions that timed out since the previous
poll) and after each consumed packet, making completion intervals more
regular. Still the intervals can be smaller than
VETH_BQL_COAL_TX_USECS, but I guess this is fine.

I also found out that the BQL limit correlates closely with
VETH_BQL_COAL_TX_USECS. It essentially reflects the latency we are
targeting. I raised the default to 100 =C2=B5s to allow DQL to converge to=
 a
higher limit (for reaching 255 in the testing below).

With the patched pktgen (respecting __QUEUE_STATE_STACK_XOFF), testing
shows:
- --nrules 0: DQL limit reaches (up to) ~255
- --nrules 10000: DQL limit converges to ~0 (with --gro-disable)

These results are what I would expect from a BQL algorithm, but more
testing is needed of course.

What do you think?

Thanks!

BTW: I think that this implementation could also work for other
     software interfaces.

>=20
> [2] Link: https://medium.com/@tom_84912/byte-queue-limits-the-unauthoriz=
ed-biography-61adc5730b83
>=20
>>
>> There is an important gotcha. We actually have micro-burst of queuing
>> (likely due to scheduling noise). Reading BQL stats from /sys will show
>> BQL inflight=3D1, but when using the option --hist is it visible that
>> @inflight have a long tail (see below signature).  The "qdisc" output
>> line also shows this happening via requeues increasing (approx 17/sec i=
n
>> a test with 567Kpps). (this was with the time-based BQL impl).
>=20
> I understand..
>=20

--------------IuFoUowCST6hi2f0SK0gC58s
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-veth-time-based-BQL-completion-coalescing-via-ethtoo.patch"
Content-Disposition: attachment;
 filename*0="0001-veth-time-based-BQL-completion-coalescing-via-ethtoo.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA0YWY4MGQzZGI0YjgyOGM2ZmZkYjgxYTQ0YzhiNjIyN2IzMThlN2RhIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTaW1vbiBTY2hpcHBlcnMgPHNpbW9uLnNjaGlwcGVy
c0B0dS1kb3J0bXVuZC5kZT4KRGF0ZTogVHVlLCAxMiBNYXkgMjAyNiAxNzozNDo1NCArMDIw
MApTdWJqZWN0OiBbUEFUQ0hdIHZldGg6IHRpbWUtYmFzZWQgQlFMIGNvbXBsZXRpb24gY29h
bGVzY2luZyB2aWEgZXRodG9vbAogdHgtdXNlY3MKCkJ1ZmZlcmJsb2F0IGlzIGZ1bmRhbWVu
dGFsbHkgYSBsYXRlbmN5IHByb2JsZW0gLS0gd2hhdCBtYXR0ZXJzIGlzIHRoZQp0aW1lIHBh
Y2tldHMgc3BlbmQgd2FpdGluZyBpbiBxdWV1ZXMsIGFzIHBlcmNlaXZlZCBieSB1c2VycyBh
bmQKYXBwbGljYXRpb25zLiBCYXNlIEJRTCBjb21wbGV0aW9uIGNvYWxlc2Npbmcgb24gZWxh
cHNlZCB0aW1lIHJhdGhlcgp0aGFuIHBhY2tldCBjb3VudHMgdG8gZGlyZWN0bHkgY29udHJv
bCBxdWV1aW5nIGRlbGF5LgoKQWRkIGV0aHRvb2wgdHgtdXNlY3Mgc3VwcG9ydCB0byB2ZXRo
IGZvciB0dW5pbmcgQlFMIGNvbXBsZXRpb24KY29hbGVzY2luZy4gSW5zdGVhZCBvZiBjb21w
bGV0aW5nIEJRTCBwZXItcGFja2V0ICh3aGljaCBmb3JjZXMgRFFMIHRvCmxpbWl0PTIgd2l0
aCBoaWdoIE5BUEkgc2NoZWR1bGluZyBvdmVyaGVhZCkgb3IgcGVyLU5BUEktcG9sbCAod2hp
Y2gKb3Zlci1idWZmZXJzIGF0IGJ1ZGdldD02NCksIGFjY3VtdWxhdGUgY29tcGxldGlvbnMg
YW5kIGZsdXNoIHRoZW0gd2hlbgphIGNvbmZpZ3VyYWJsZSB0aW1lIHRocmVzaG9sZCBpcyBl
eGNlZWRlZC4gVGhpcyBsZXRzIERRTCBkaXNjb3ZlciBhCmxpbWl0IHRoYXQgYm91bmRzIHRo
ZSBhY3R1YWwgcXVldWluZyBkZWxheSB0byB0aGUgY29uZmlndXJlZCBpbnRlcnZhbC4KCkNv
YWxlc2Npbmcgc3RhdGUgKHRpbWVzdGFtcCArIHBlbmRpbmcgY291bnQpIGlzIHN0b3JlZCBp
biBzdHJ1Y3QKdmV0aF9icWxfc3RhdGUgZW1iZWRkZWQgaW4gdmV0aF9ycSwgcGVyc2lzdGlu
ZyBhY3Jvc3MgTkFQSSBwb2xscyBzbwp0aGF0IGNvbXBsZXRpb25zIHdob3NlIGRlYWRsaW5l
IGV4cGlyZWQgaW4gYSBwcmV2aW91cyBwb2xsIGFyZSByZWxlYXNlZAphdCB0aGUgc3RhcnQg
b2YgdGhlIG5leHQgb25lLgoKVHdvIGhlbHBlcnMgY2VudHJhbGlzZSB0aGUgbG9naWM6CiAg
dmV0aF9icWxfY29tcGxldGUoKSAgICAgICAtIGZsdXNoICsgcmVzZXQgc3RhdGUKICB2ZXRo
X2JxbF9tYXliZV9jb21wbGV0ZSgpIC0gZmx1c2ggb25seSBpZiBkZWFkbGluZSBlbGFwc2Vk
CgpBIG1pbihzdGF0ZS0+dGltZSwgc2NoZWRfY2xvY2soKSkgZ3VhcmQgYXQgdmV0aF94ZHBf
cmN2KCkgZW50cnkKcHJldmVudHMgdGhlIGNvYWxlc2NpbmcgZGVhZGxpbmUgZnJvbSBzdGFs
bGluZyBpZiBOQVBJIG1pZ3JhdGVzIHRvIGEKQ1BVIHdob3NlIHNjaGVkX2Nsb2NrKCkgaXMg
c2xpZ2h0bHkgYmVoaW5kIHRoZSBzdG9yZWQgdGltZXN0YW1wLgoKQXQgZW5kLW9mLWZ1bmN0
aW9uLCBwZW5kaW5nIGNvbXBsZXRpb25zIGFyZSByZWxlYXNlZCBpbW1lZGlhdGVseSBvbmx5
CndoZW4gdGhlIHJpbmcgaGFzIGRyYWluZWQgYW5kIF9fUVVFVUVfU1RBVEVfU1RBQ0tfWE9G
RiBpcyBzZXQsIGVuc3VyaW5nCkRRTCBiYWNrcHJlc3N1cmUgaXMgbGlmdGVkIHdpdGhvdXQg
YnlwYXNzaW5nIGNvYWxlc2NpbmcgaW4gdGhlIGNvbW1vbgpjYXNlLiBUaGUgc21wX3JtYigp
IGlzIHBhaXJlZCB3aXRoIHNtcF93bWIoKSBpbiBfX3B0cl9yaW5nX3Byb2R1Y2UoKS4KCmJx
bF9zdGF0ZSBpcyBpbml0aWFsaXNlZCBhdCBOQVBJIGVuYWJsZSAoc2NoZWRfY2xvY2soKSB0
aW1lc3RhbXApIGFuZApjbGVhcmVkIGF0IE5BUEkgdGVhcmRvd24sIHdoZXJlIG5ldGRldl90
eF9yZXNldF9xdWV1ZSgpIGFscmVhZHkgcmVzZXRzCkRRTCBvbiB0aGUgcGVlciBzaWRlLgoK
RGVmYXVsdCB0eC11c2VjcyByYWlzZWQgdG8gMTAwIHVzICh3YXMgMTAgdXMpIHRvIGFsbG93
IERRTCB0byBjb252ZXJnZQp0byBhIG1vcmUgdXNlZnVsIGxpbWl0LiBTZXR0aW5nIHR4LXVz
ZWNzIHRvIDAgZGlzYWJsZXMgY29hbGVzY2luZyBhbmQKZmFsbHMgYmFjayB0byBwZXItcGFj
a2V0IGNvbXBsZXRpb24gKGxpbWl0PTIsIGxvd2VzdCBsYXRlbmN5KS4KClVzYWdlOgogIGV0
aHRvb2wgLUMgPHZldGgtZGV2PiB0eC11c2VjcyA1MDAgICAjIDUwMHVzIGNvYWxlc2NpbmcK
ICBldGh0b29sIC1DIDx2ZXRoLWRldj4gdHgtdXNlY3MgMCAgICAgIyBwZXItcGFja2V0IChu
byBjb2FsZXNjaW5nKQoKRGV2ZWxvcGVkLWJ5OiBKZXNwZXIgRGFuZ2FhcmQgQnJvdWVyIDxo
YXdrQGtlcm5lbC5vcmc+CkRldmVsb3BlZC1ieTogU2ltb24gU2NoaXBwZXJzIDxzaW1vbi5z
Y2hpcHBlcnNAdHUtZG9ydG11bmQuZGU+ClNpZ25lZC1vZmYtYnk6IFNpbW9uIFNjaGlwcGVy
cyA8c2ltb24uc2NoaXBwZXJzQHR1LWRvcnRtdW5kLmRlPgotLS0KIGRyaXZlcnMvbmV0L3Zl
dGguYyB8IDk1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Ky0KIDEgZmlsZSBjaGFuZ2VkLCA5MyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZldGguYyBiL2RyaXZlcnMvbmV0L3ZldGguYwpp
bmRleCA0MTAzZDI5OGFhOWIuLmM5ZDUzZWE5NTk4YiAxMDA2NDQKLS0tIGEvZHJpdmVycy9u
ZXQvdmV0aC5jCisrKyBiL2RyaXZlcnMvbmV0L3ZldGguYwpAQCAtNDMsNiArNDMsNyBAQAog
CiAjZGVmaW5lIFZFVEhfWERQX1RYX0JVTEtfU0laRQkxNgogI2RlZmluZSBWRVRIX1hEUF9C
QVRDSAkJMTYKKyNkZWZpbmUgVkVUSF9CUUxfQ09BTF9UWF9VU0VDUwkxMDAJLyogZGVmYXVs
dCB0eC11c2VjcyBmb3IgQlFMIGJhdGNoaW5nICovCiAKIHN0cnVjdCB2ZXRoX3N0YXRzIHsK
IAl1NjQJcnhfZHJvcHM7CkBAIC02Miw2ICs2MywxMSBAQCBzdHJ1Y3QgdmV0aF9ycV9zdGF0
cyB7CiAJc3RydWN0IHU2NF9zdGF0c19zeW5jCXN5bmNwOwogfTsKIAorc3RydWN0IHZldGhf
YnFsX3N0YXRlIHsKKwl1NjQJdGltZTsJLyogc2NoZWRfY2xvY2soKSB3aGVuIGN1cnJlbnQg
Y29hbGVzY2luZyB3aW5kb3cgc3RhcnRlZCAqLworCWludAluX2JxbDsJLyogQlFMIGNvbXBs
ZXRpb25zIGJhdGNoZWQgaW4gdGhlIGN1cnJlbnQgd2luZG93ICovCit9OworCiBzdHJ1Y3Qg
dmV0aF9ycSB7CiAJc3RydWN0IG5hcGlfc3RydWN0CXhkcF9uYXBpOwogCXN0cnVjdCBuYXBp
X3N0cnVjdCBfX3JjdSAqbmFwaTsgLyogcG9pbnRzIHRvIHhkcF9uYXBpIHdoZW4gdGhlIGxh
dHRlciBpcyBpbml0aWFsaXplZCAqLwpAQCAtNjksNiArNzUsNyBAQCBzdHJ1Y3QgdmV0aF9y
cSB7CiAJc3RydWN0IGJwZl9wcm9nIF9fcmN1CSp4ZHBfcHJvZzsKIAlzdHJ1Y3QgeGRwX21l
bV9pbmZvCXhkcF9tZW07CiAJc3RydWN0IHZldGhfcnFfc3RhdHMJc3RhdHM7CisJc3RydWN0
IHZldGhfYnFsX3N0YXRlCWJxbF9zdGF0ZTsKIAlib29sCQkJcnhfbm90aWZ5X21hc2tlZDsK
IAlzdHJ1Y3QgcHRyX3JpbmcJCXhkcF9yaW5nOwogCXN0cnVjdCB4ZHBfcnhxX2luZm8JeGRw
X3J4cTsKQEAgLTgxLDYgKzg4LDcgQEAgc3RydWN0IHZldGhfcHJpdiB7CiAJc3RydWN0IGJw
Zl9wcm9nCQkqX3hkcF9wcm9nOwogCXN0cnVjdCB2ZXRoX3JxCQkqcnE7CiAJdW5zaWduZWQg
aW50CQlyZXF1ZXN0ZWRfaGVhZHJvb207CisJdW5zaWduZWQgaW50CQl0eF9jb2FsX3VzZWNz
OwkvKiBCUUwgY29tcGxldGlvbiBjb2FsZXNjaW5nICovCiB9OwogCiBzdHJ1Y3QgdmV0aF94
ZHBfdHhfYnEgewpAQCAtMjY1LDcgKzI3MywzMCBAQCBzdGF0aWMgdm9pZCB2ZXRoX2dldF9j
aGFubmVscyhzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAogc3RhdGljIGludCB2ZXRoX3NldF9j
aGFubmVscyhzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAogCQkJICAgICBzdHJ1Y3QgZXRodG9v
bF9jaGFubmVscyAqY2gpOwogCitzdGF0aWMgaW50IHZldGhfZ2V0X2NvYWxlc2NlKHN0cnVj
dCBuZXRfZGV2aWNlICpkZXYsCisJCQkgICAgc3RydWN0IGV0aHRvb2xfY29hbGVzY2UgKmVj
LAorCQkJICAgIHN0cnVjdCBrZXJuZWxfZXRodG9vbF9jb2FsZXNjZSAqa2VybmVsX2NvYWws
CisJCQkgICAgc3RydWN0IG5ldGxpbmtfZXh0X2FjayAqZXh0YWNrKQoreworCXN0cnVjdCB2
ZXRoX3ByaXYgKnByaXYgPSBuZXRkZXZfcHJpdihkZXYpOworCisJZWMtPnR4X2NvYWxlc2Nl
X3VzZWNzID0gcHJpdi0+dHhfY29hbF91c2VjczsKKwlyZXR1cm4gMDsKK30KKworc3RhdGlj
IGludCB2ZXRoX3NldF9jb2FsZXNjZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAorCQkJICAg
IHN0cnVjdCBldGh0b29sX2NvYWxlc2NlICplYywKKwkJCSAgICBzdHJ1Y3Qga2VybmVsX2V0
aHRvb2xfY29hbGVzY2UgKmtlcm5lbF9jb2FsLAorCQkJICAgIHN0cnVjdCBuZXRsaW5rX2V4
dF9hY2sgKmV4dGFjaykKK3sKKwlzdHJ1Y3QgdmV0aF9wcml2ICpwcml2ID0gbmV0ZGV2X3By
aXYoZGV2KTsKKworCXByaXYtPnR4X2NvYWxfdXNlY3MgPSBlYy0+dHhfY29hbGVzY2VfdXNl
Y3M7CisJcmV0dXJuIDA7Cit9CisKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZXRodG9vbF9vcHMg
dmV0aF9ldGh0b29sX29wcyA9IHsKKwkuc3VwcG9ydGVkX2NvYWxlc2NlX3BhcmFtcyA9IEVU
SFRPT0xfQ09BTEVTQ0VfVFhfVVNFQ1MsCiAJLmdldF9kcnZpbmZvCQk9IHZldGhfZ2V0X2Ry
dmluZm8sCiAJLmdldF9saW5rCQk9IGV0aHRvb2xfb3BfZ2V0X2xpbmssCiAJLmdldF9zdHJp
bmdzCQk9IHZldGhfZ2V0X3N0cmluZ3MsCkBAIC0yNzUsNiArMzA2LDggQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCBldGh0b29sX29wcyB2ZXRoX2V0aHRvb2xfb3BzID0gewogCS5nZXRfdHNf
aW5mbwkJPSBldGh0b29sX29wX2dldF90c19pbmZvLAogCS5nZXRfY2hhbm5lbHMJCT0gdmV0
aF9nZXRfY2hhbm5lbHMsCiAJLnNldF9jaGFubmVscwkJPSB2ZXRoX3NldF9jaGFubmVscywK
KwkuZ2V0X2NvYWxlc2NlCQk9IHZldGhfZ2V0X2NvYWxlc2NlLAorCS5zZXRfY29hbGVzY2UJ
CT0gdmV0aF9zZXRfY29hbGVzY2UsCiB9OwogCiAvKiBnZW5lcmFsIHJvdXRpbmVzICovCkBA
IC05MzcsMTMgKzk3MCw0NSBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnZldGhfeGRwX3Jj
dl9za2Ioc3RydWN0IHZldGhfcnEgKnJxLAogCXJldHVybiBOVUxMOwogfQogCitzdGF0aWMg
dm9pZCB2ZXRoX2JxbF9jb21wbGV0ZShzdHJ1Y3QgdmV0aF9icWxfc3RhdGUgKnN0YXRlLAor
CQkJICAgICAgc3RydWN0IG5ldGRldl9xdWV1ZSAqcGVlcl90eHEpCit7CisJbmV0ZGV2X3R4
X2NvbXBsZXRlZF9xdWV1ZShwZWVyX3R4cSwgc3RhdGUtPm5fYnFsLAorCQkJCSAgc3RhdGUt
Pm5fYnFsICogVkVUSF9CUUxfVU5JVCk7CisJc3RhdGUtPm5fYnFsID0gMDsKKwlzdGF0ZS0+
dGltZSA9IHNjaGVkX2Nsb2NrKCk7Cit9CisKK3N0YXRpYyB2b2lkIHZldGhfYnFsX21heWJl
X2NvbXBsZXRlKHN0cnVjdCB2ZXRoX2JxbF9zdGF0ZSAqc3RhdGUsCisJCQkJICAgIHN0cnVj
dCBuZXRkZXZfcXVldWUgKnBlZXJfdHhxLAorCQkJCSAgICB1NjQgY29hbGVzY2luZ19ucykK
K3sKKwlpZiAoc3RhdGUtPm5fYnFsICYmIHNjaGVkX2Nsb2NrKCkgPj0gc3RhdGUtPnRpbWUg
KyBjb2FsZXNjaW5nX25zKQorCQl2ZXRoX2JxbF9jb21wbGV0ZShzdGF0ZSwgcGVlcl90eHEp
OworfQorCiBzdGF0aWMgaW50IHZldGhfeGRwX3JjdihzdHJ1Y3QgdmV0aF9ycSAqcnEsIGlu
dCBidWRnZXQsCiAJCQlzdHJ1Y3QgdmV0aF94ZHBfdHhfYnEgKmJxLAogCQkJc3RydWN0IHZl
dGhfc3RhdHMgKnN0YXRzLAogCQkJc3RydWN0IG5ldGRldl9xdWV1ZSAqcGVlcl90eHEpCiB7
CisJc3RydWN0IHZldGhfYnFsX3N0YXRlICpzdGF0ZSA9ICZycS0+YnFsX3N0YXRlOwogCWlu
dCBpLCBkb25lID0gMCwgbl94ZHBmID0gMDsKIAl2b2lkICp4ZHBmW1ZFVEhfWERQX0JBVENI
XTsKKwlzdHJ1Y3QgdmV0aF9wcml2ICpwcml2OworCXU2NCBicWxfZmx1c2hfbnM7CisKKwlw
cml2ID0gbmV0ZGV2X3ByaXYocnEtPmRldik7CisJYnFsX2ZsdXNoX25zID0gKHU2NClwcml2
LT50eF9jb2FsX3VzZWNzICogMTAwMDsKKworCS8qIENsYW1wIHN0b3JlZCB0aW1lc3RhbXAg
aW4gY2FzZSB3ZSBtaWdyYXRlZCB0byBhIENQVSB3aXRoIGEgYmVoaW5kCisJICogc2NoZWRf
Y2xvY2soKTsgcHJldmVudHMgdGhlIGRlYWRsaW5lIGZyb20gbmV2ZXIgZmlyaW5nLgorCSAq
LworCXN0YXRlLT50aW1lID0gbWluKHN0YXRlLT50aW1lLCBzY2hlZF9jbG9jaygpKTsKKwor
CS8qIEZsdXNoIGNvbXBsZXRpb25zIHRoYXQgdGltZWQgb3V0IHNpbmNlIHRoZSBwcmV2aW91
cyBOQVBJIHBvbGwuICovCisJaWYgKHBlZXJfdHhxICYmIGJxbF9mbHVzaF9ucykKKwkJdmV0
aF9icWxfbWF5YmVfY29tcGxldGUoc3RhdGUsIHBlZXJfdHhxLCBicWxfZmx1c2hfbnMpOwog
CiAJZm9yIChpID0gMDsgaSA8IGJ1ZGdldDsgaSsrKSB7CiAJCXZvaWQgKnB0ciA9IF9fcHRy
X3JpbmdfY29uc3VtZSgmcnEtPnhkcF9yaW5nKTsKQEAgLTk3Miw4ICsxMDM3LDE2IEBAIHN0
YXRpYyBpbnQgdmV0aF94ZHBfcmN2KHN0cnVjdCB2ZXRoX3JxICpycSwgaW50IGJ1ZGdldCwK
IAkJCXN0cnVjdCBza19idWZmICpza2IgPSB2ZXRoX3B0cl90b19za2IocHRyKTsKIAogCQkJ
c3RhdHMtPnhkcF9ieXRlcyArPSBza2ItPmxlbjsKLQkJCWlmIChwZWVyX3R4cSAmJiBicWxf
Y2hhcmdlZCkKLQkJCQluZXRkZXZfdHhfY29tcGxldGVkX3F1ZXVlKHBlZXJfdHhxLCAxLCBW
RVRIX0JRTF9VTklUKTsKKwkJCWlmIChwZWVyX3R4cSAmJiBicWxfY2hhcmdlZCkgeworCQkJ
CWlmICghYnFsX2ZsdXNoX25zKSB7CisJCQkJCW5ldGRldl90eF9jb21wbGV0ZWRfcXVldWUo
cGVlcl90eHEsIDEsCisJCQkJCQkJCSAgVkVUSF9CUUxfVU5JVCk7CisJCQkJfSBlbHNlIHsK
KwkJCQkJc3RhdGUtPm5fYnFsKys7CisJCQkJCXZldGhfYnFsX21heWJlX2NvbXBsZXRlKHN0
YXRlLCBwZWVyX3R4cSwKKwkJCQkJCQkJYnFsX2ZsdXNoX25zKTsKKwkJCQl9CisJCQl9CiAK
IAkJCXNrYiA9IHZldGhfeGRwX3Jjdl9za2IocnEsIHNrYiwgYnEsIHN0YXRzKTsKIAkJCWlm
IChza2IpIHsKQEAgLTk4OSw2ICsxMDYyLDE2IEBAIHN0YXRpYyBpbnQgdmV0aF94ZHBfcmN2
KHN0cnVjdCB2ZXRoX3JxICpycSwgaW50IGJ1ZGdldCwKIAlpZiAobl94ZHBmKQogCQl2ZXRo
X3hkcF9yY3ZfYnVsa19za2IocnEsIHhkcGYsIG5feGRwZiwgYnEsIHN0YXRzKTsKIAorCS8q
IElmIHRoZSByaW5nIGlzIG5vdyBlbXB0eSBhbmQgdGhlIHBlZXIgVFggcXVldWUgaXMgc3Rh
bGxlZCBieSBEUUwKKwkgKiBiYWNrcHJlc3N1cmUsIHJlbGVhc2UgY29tcGxldGlvbnMgaW1t
ZWRpYXRlbHkgdG8gdW5ibG9jayBpdC4KKwkgKiBUaGUgc21wX3JtYigpIGlzIHBhaXJlZCB3
aXRoIHNtcF93bWIoKSBpbiBfX3B0cl9yaW5nX3Byb2R1Y2UoKS4KKwkgKi8KKwlpZiAocGVl
cl90eHEgJiYgc3RhdGUtPm5fYnFsICYmIHB0cl9yaW5nX2VtcHR5KCZycS0+eGRwX3Jpbmcp
KSB7CisJCXNtcF9ybWIoKTsKKwkJaWYgKHRlc3RfYml0KF9fUVVFVUVfU1RBVEVfU1RBQ0tf
WE9GRiwgJnBlZXJfdHhxLT5zdGF0ZSkpCisJCQl2ZXRoX2JxbF9jb21wbGV0ZShzdGF0ZSwg
cGVlcl90eHEpOworCX0KKwogCXU2NF9zdGF0c191cGRhdGVfYmVnaW4oJnJxLT5zdGF0cy5z
eW5jcCk7CiAJcnEtPnN0YXRzLnZzLnhkcF9yZWRpcmVjdCArPSBzdGF0cy0+eGRwX3JlZGly
ZWN0OwogCXJxLT5zdGF0cy52cy54ZHBfYnl0ZXMgKz0gc3RhdHMtPnhkcF9ieXRlczsKQEAg
LTEwOTMsNiArMTE3Niw4IEBAIHN0YXRpYyBpbnQgX192ZXRoX25hcGlfZW5hYmxlX3Jhbmdl
KHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsIGludCBzdGFydCwgaW50IGVuZCkKIAogCQluYXBp
X2VuYWJsZSgmcnEtPnhkcF9uYXBpKTsKIAkJcmN1X2Fzc2lnbl9wb2ludGVyKHByaXYtPnJx
W2ldLm5hcGksICZwcml2LT5ycVtpXS54ZHBfbmFwaSk7CisJCXJxLT5icWxfc3RhdGUudGlt
ZSA9IHNjaGVkX2Nsb2NrKCk7CisJCXJxLT5icWxfc3RhdGUubl9icWwgPSAwOwogCX0KIAog
CXJldHVybiAwOwpAQCAtMTEzNCw2ICsxMjE5LDggQEAgc3RhdGljIHZvaWQgdmV0aF9uYXBp
X2RlbF9yYW5nZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LCBpbnQgc3RhcnQsIGludCBlbmQp
CiAJCXN0cnVjdCB2ZXRoX3JxICpycSA9ICZwcml2LT5ycVtpXTsKIAogCQlycS0+cnhfbm90
aWZ5X21hc2tlZCA9IGZhbHNlOworCQlycS0+YnFsX3N0YXRlLm5fYnFsID0gMDsKKwkJcnEt
PmJxbF9zdGF0ZS50aW1lID0gMDsKIAkJcHRyX3JpbmdfY2xlYW51cCgmcnEtPnhkcF9yaW5n
LCB2ZXRoX3B0cl9mcmVlKTsKIAl9CiAKQEAgLTE4MTMsNiArMTkwMCw4IEBAIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgeGRwX21ldGFkYXRhX29wcyB2ZXRoX3hkcF9tZXRhZGF0YV9vcHMgPSB7
CiAKIHN0YXRpYyB2b2lkIHZldGhfc2V0dXAoc3RydWN0IG5ldF9kZXZpY2UgKmRldikKIHsK
KwlzdHJ1Y3QgdmV0aF9wcml2ICpwcml2ID0gbmV0ZGV2X3ByaXYoZGV2KTsKKwogCWV0aGVy
X3NldHVwKGRldik7CiAKIAlkZXYtPnByaXZfZmxhZ3MgJj0gfklGRl9UWF9TS0JfU0hBUklO
RzsKQEAgLTE4MzgsNiArMTkyNyw4IEBAIHN0YXRpYyB2b2lkIHZldGhfc2V0dXAoc3RydWN0
IG5ldF9kZXZpY2UgKmRldikKIAlkZXYtPm1heF9tdHUgPSBFVEhfTUFYX01UVTsKIAlkZXYt
PndhdGNoZG9nX3RpbWVvID0gbXNlY3NfdG9famlmZmllcygxNjAwMCk7CiAKKwlwcml2LT50
eF9jb2FsX3VzZWNzID0gVkVUSF9CUUxfQ09BTF9UWF9VU0VDUzsKKwogCWRldi0+aHdfZmVh
dHVyZXMgPSBWRVRIX0ZFQVRVUkVTOwogCWRldi0+aHdfZW5jX2ZlYXR1cmVzID0gVkVUSF9G
RUFUVVJFUzsKIAlkZXYtPm1wbHNfZmVhdHVyZXMgPSBORVRJRl9GX0hXX0NTVU0gfCBORVRJ
Rl9GX0dTT19TT0ZUV0FSRTsKLS0gCjIuNDMuMAoK

--------------IuFoUowCST6hi2f0SK0gC58s--

