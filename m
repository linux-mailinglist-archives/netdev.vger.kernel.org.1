Return-Path: <netdev+bounces-285482-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJ7LDC3y/GlmVgAAu9opvQ
	(envelope-from <netdev+bounces-285482-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 22:12:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D97E4EE45C
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 22:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EC143031E89
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 20:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEED436AB77;
	Thu,  7 May 2026 20:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=schippers-hamm.de header.i=simon@schippers-hamm.de header.b="hGLgMPXl"
X-Original-To: netdev@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6026035E950;
	Thu,  7 May 2026 20:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778184735; cv=none; b=HcNhKoLtaW8jANX02YdZaFAc9voQHRihqBFu/UbAxiQGRkpJDsfSgc9n9whTO4Qa5eGDeSAHhd6TudDlJvungedHNVqz3Wpv1MCvH60fPIVdoc0WkKKZrJTzIWfX1mK6ve6HcQmzpde/e600qdGWZt3Jn9MEH0WR3I6rtZHL5RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778184735; c=relaxed/simple;
	bh=7s/4adQpQg3g9cdxL1pqHwK0tsim71iGO8AnG9gX20M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SQ8u3bwaCEqwFaxuIxBNjP06nEGLM2F/sfFGsThNp2rbTqyCE4K6oxnUSt2v78OGTBDnYwGOyqMbgtwFHDicQri8ZO7JwdYCaFB5sgNySli/fY7jZheTfrdyoQSqozvCW+ne9cOzjhbSl/sgtIG7eqr1iu9gHcdAmDK4dzcj6Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schippers-hamm.de; spf=pass smtp.mailfrom=schippers-hamm.de; dkim=pass (2048-bit key) header.d=schippers-hamm.de header.i=simon@schippers-hamm.de header.b=hGLgMPXl; arc=none smtp.client-ip=212.227.126.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schippers-hamm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schippers-hamm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schippers-hamm.de;
	s=s1-ionos; t=1778184727; x=1778789527; i=simon@schippers-hamm.de;
	bh=5OMntRvUYVrF4y3sfizXFvoNLUAkQ7WvIogA+XQ/6VM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hGLgMPXlX5F33ZmNKxoTCrlF899OeSLxlCdk7xOMNnq5TJlM6Q/MRDJ1CKxi4Ng/
	 FHIvuDf6uLnbHfiZOJrGg+WjCIEAisSD+GC5cYK+KYQh7gMFOtrFCaPPEUneoGS35
	 2HzfLj26WVCbif+980q+mWxTo+diPm6xAOIRWN/TqG/BxuUsjIerH9xiKUw3xwX2w
	 wWkoal4o5FMR2IDcZ9T/DGuwwwdwbGao2e6OJ2CE5J+yIMOQrgK9EHSEgYUHu74v4
	 DzaavFNArCp79i3l2jg+MAgHJXY/uGgvrUvXJSxD5x7XuFtWIa9k5CaSkEJNmbnx1
	 Dy+k18Oqvt3UoGBAFg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue009
 [212.227.17.165]) with ESMTPSA (Nemesis) id 1M8QNs-1wGfDy3kxc-00AIPQ; Thu, 07
 May 2026 22:12:07 +0200
Message-ID: <68223314-1a44-4aee-8207-57437ef9f3ab@schippers-hamm.de>
Date: Thu, 7 May 2026 22:12:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/5] veth: implement Byte Queue Limits (BQL)
 for latency reduction
To: Jesper Dangaard Brouer <hawk@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: kernel-team@cloudflare.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260505132159.241305-1-hawk@kernel.org>
 <20260505132159.241305-4-hawk@kernel.org>
 <ee275aa6-af27-4dac-9afa-da88abde312b@schippers-hamm.de>
 <8f2f7f2e-6aa2-4e5b-b52d-0025b2525579@redhat.com>
 <e3a91545-13cd-4f87-8375-d707865bdbca@schippers-hamm.de>
 <6a597dbd-70bf-4b14-b495-2f7248fd3220@kernel.org>
Content-Language: en-US
From: Simon Schippers <simon@schippers-hamm.de>
In-Reply-To: <6a597dbd-70bf-4b14-b495-2f7248fd3220@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QCywI0hdiv3Q6UFnj9I4c6dnI+uaxvvcdbGaOz+JnRkI+r0aqtu
 RRImD4uH45u+VbhN5dcvEwQ213WwF++9+RNJsIefj9TrGaIl5rufckc8naupz/FMJWBhU3c
 rqsbHuYXjKS50lbt9cqY4Cjjq/1R3w7hLC2+KWHOQMn6q3L3AfU7nyfb40dB2E//uOkFuiM
 r7XLsQMWNxIeTdV1G/9Cw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:M70IqaqnKkE=;6tWWpHrg8Ntyt7nE38p7yzIvbKZ
 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
X-Rspamd-Queue-Id: 8D97E4EE45C
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
	TAGGED_FROM(0.00)[bounces-285482-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cloudflare.com,lunn.ch,davemloft.net,google.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/7/26 21:09, Jesper Dangaard Brouer wrote:
>=20
>=20
> On 07/05/2026 16.46, Simon Schippers wrote:
>>
>>
>> On 5/7/26 16:34, Paolo Abeni wrote:
>>> On 5/7/26 8:54 AM, Simon Schippers wrote:
>>>> On 5/5/26 15:21, hawk@kernel.org wrote:
>>>>> @@ -928,9 +968,13 @@ static int veth_xdp_rcv(struct veth_rq *rq, int=
 budget,
>>>>>               }
>>>>>           } else {
>>>>>               /* ndo_start_xmit */
>>>>> -            struct sk_buff *skb =3D ptr;
>>>>> +            bool bql_charged =3D veth_ptr_is_bql(ptr);
>>>>> +            struct sk_buff *skb =3D veth_ptr_to_skb(ptr);
>>>>>                 stats->xdp_bytes +=3D skb->len;
>>>>> +            if (peer_txq && bql_charged)
>>>>> +                netdev_tx_completed_queue(peer_txq, 1, VETH_BQL_UNI=
T);
>>>>
>>>> In the discussion with Jonas [1], I left a comment explaining why I t=
hink
>>>> this doesn=E2=80=99t work.
>>>>
>=20
> I've experimented with doing the "completion" at NAPI-end in
> veth_poll(), but that resulted in BQL limit being 128 packets, which
> leads to bad latency results (not acceptable).
> (See detailed report later)
>=20
>=20
>>>> I still think first that adding an option to modify the hard-coded
>>>> VETH_RING_SIZE is the way to go.
>>>>
>=20
> Not against being able to modify VETH_RING_SIZE, but I don't think it is
> the solution here.
>=20
> The simply solution is the configure BQL limit_min:
>  `/sys/class/net/<dev>/queues/tx-N/byte_queue_limits/limit_min`
>=20
> My experiments (below) find that limit_min=3D8 is gives good performance=
.
> We can simply set default to 8 as this still allows userspace to change
> this later if lower latency is preferred.
>=20
>>>> Thanks!
>>>>
>>>> [1] Link: https://lore.kernel.org/netdev/e8cdba04-aa9a-45c6-9807-8274=
b62920df@tu-dortmund.de/
>>>
>>> In the above discussion a 20% regression is reported, which IMHO can't
>>> be ignored. Still the tput figures in the data are extremely low,
>>> something is possibly off?!? I would expect a few Mpps with pktgen on
>>> top of veth, while the reported data is ~20-30Kpps.
>>>
>>> /P
>>>
>>
>> The ~20-30Kpps occur when thousands of iptables rules are applied and
>> an UDP userspace application is sending.
>>
>> And there is a 20% pktgen regression (no iptables rules applied).
>>
>=20
> The pktgen test is a little dubious/weird and Jonas had to modify pktgen
> to test this.   John Fastabend added a config to pktgen that allows us
> to benchmarking egress qdisc path, this might be better to use this.
> The samples/pktgen/pktgen_bench_xmit_mode_queue_xmit.sh is a demo usage.
>=20
> If redoing the tests, can you adjust limit_min to see the effect?
>  /sys/class/net/<dev>/queues/tx-N/byte_queue_limits/limit_min
>=20
> 20% throughput performance regression is of-cause too much, but I will
> remind us, that adding a qdisc will "cost" some overhead, that is a
> configuration choice.  Our purpose here is to reduce bufferbloat and
> latency, not optimize for throughput.
>=20
>=20
>> I am pretty sure the reason is because the BQL limit is stuck at 2
>> packets (because the completed queue is always called with 1 packet
>> and not in a interrupt/timer with multiple packets...).
>>
>=20
> I've run a lot of experiments, which I made AI write a report over, see =
attachment.  The TL;DR is that best performance vs latency tradeoff is def=
aulting BQL/DQL limit_min to be 8 packets.
>=20
> I fear this patchset will stall forever, if we keep searching for a perf=
ect solution without any overhead.  The qdisc layer will be a baseline ove=
rhead.  The limit=3D2 packets is actually the optimal darkbuffer queue siz=
e, but I acknowledge that this causes too many qdisc requeue events (leadi=
ng to overhead).  I suggest that I add another patch in V6, that defaults =
limit_min to 8 (separate patch to make it easier to revert/adjust later).
>=20
> I've talked with Jonas, and we want to experiment with different solutio=
ns to make BQL/DQL work better with virtual devices.
>=20
> This patchset helps our (production) use-case reduce mice-flow latency
> from approx 22ms to 1.3ms for latency under-load.  Due to the consumer
> namespace being the bottleneck the requeue overhead is negligible in
> comparison.
>=20
> -Jesper

First of all thanks for you work and I really see the advantages of
avoiding bufferbloat :)

But the key of the BQL algorithm, which is the *dynamic* adaption of the
limit, is not working. Always calling netdev_completed_queue() with
1 packet results in a static limit of 2 packets (as seen by Jonas
measurements), which you force up to 8 packets.

So in the end this patchset has the same effect as just setting
VETH_RING_SIZE to 8 (and giving an option to change this value).


