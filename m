Return-Path: <netdev+bounces-285729-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VKJjDwmr/WlOhgAAu9opvQ
	(envelope-from <netdev+bounces-285729-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 11:21:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 356794F42E7
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 11:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7901C3008448
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 09:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7E03A3E78;
	Fri,  8 May 2026 09:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=schippers-hamm.de header.i=simon@schippers-hamm.de header.b="Xu9LrzYS"
X-Original-To: netdev@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D813A0B3B;
	Fri,  8 May 2026 09:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778232054; cv=none; b=SAT7/3LJb7bxnO49k/F4EcKOx2669T0wHk3Cvx6RO6z+brqRG6TwEU08wMzweoSzBChANzffR2EYQQYV9cqoa41vV8Ub/kmmSbo46o/1RvpjX7bpywo0ZZONKdsWggS+cm9eYKOLmoq04h0+0T65OF5swsQxtNdlFo9u0NFHgeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778232054; c=relaxed/simple;
	bh=oenf9co85HWC6U6Z6yxE2cSzQKfneZ36M1pV4jxCyT8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=t3m3n9MV0CAq3EwTcK1EZDOo+9vw/0UWzv1uPxmjtWorZJ0WShR8gUyYlzqwpqDRptxsJZ/HAyAz1R9LfmHICH4ZfXLTv6Vu9hQm/5Qd0C4YvPwWdF4d2U8imu6mbmKb4eAIYkU+J8ssIBT2hGiaiVbk0sumPbqZ9WMbRF+JAWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schippers-hamm.de; spf=pass smtp.mailfrom=schippers-hamm.de; dkim=pass (2048-bit key) header.d=schippers-hamm.de header.i=simon@schippers-hamm.de header.b=Xu9LrzYS; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schippers-hamm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schippers-hamm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schippers-hamm.de;
	s=s1-ionos; t=1778232008; x=1778836808; i=simon@schippers-hamm.de;
	bh=Hc0GCEPa4JhrvnKii+m3Lykf1LE1GIBL0gGV95D/z88=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Xu9LrzYSxbVNYH/KQzwfwj5bV0VNLuoAFZTDfCVZgcEtaUOs3nX/o6i/tlYuPrkl
	 SVWhSaA+f+KyHAjkSYedMuZUBBbpXrMMPQKF8e47a/sJmjGUh9ZjxRtAFfcHiAgb2
	 spHONZdtEkpXEhenISaIU8i6Yj0PQdP/aYQJKq42ZHR30qN6wTCZ/ppqMEgOn/P7N
	 wAxthuYeM2HSi+x5qKBdzdSYYwqV1W6xaxf+Rk8jd+J5mCaXX3FgoWxfZyLykm23P
	 XVR5DXO2piW4BSpSSZeYUYH2YcX96uR5ImOJz9nsJLSIMqBc5lVbJg0uPCyobMbFV
	 XlqOfl4zCcXsxGZVxw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue108
 [212.227.17.181]) with ESMTPSA (Nemesis) id 1MCsHm-1wCRgm1iIS-00Dqn7; Fri, 08
 May 2026 11:20:08 +0200
Message-ID: <ab56d050-33c9-4f65-94e6-64e1bc2b03b4@schippers-hamm.de>
Date: Fri, 8 May 2026 11:20:05 +0200
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
 <68223314-1a44-4aee-8207-57437ef9f3ab@schippers-hamm.de>
 <3e43117f-356d-4086-a176-abd7fe2e6f0a@kernel.org>
 <21d639fc-e244-486e-8368-8891b3c43215@schippers-hamm.de>
Content-Language: en-US
In-Reply-To: <21d639fc-e244-486e-8368-8891b3c43215@schippers-hamm.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WAXVRmfQ06nU85T0VZPtSVGg7wsnYtNUbsSf7t56ghLd8asTuKq
 SHuNw52IRNqz3QxBsJ1+wtMtPSug/zIsUmutNan0DvKqWhoRn0dwq6D7x3NK1mNz8CVBvoT
 iesOpBf/cEXVEU2MSByE9rKQ0xm2dBxDKG6mRl18aPEz92FHnX0cvrP9+jz5cxbA7hFn5Wh
 eW0UoTTiwT9qFWWN3hjeA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/xrhJ6c1wLo=;wy0A1q7QtPHjyGzaRqW8oZlrR3P
 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
 fovKqiTsxbs=
X-Rspamd-Queue-Id: 356794F42E7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[schippers-hamm.de,none];
	R_DKIM_ALLOW(-0.20)[schippers-hamm.de:s=s1-ionos];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285729-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action



On 5/8/26 10:01, Simon Schippers wrote:
> On 5/7/26 22:45, Jesper Dangaard Brouer wrote:
>>
>>
>> On 07/05/2026 22.12, Simon Schippers wrote:
>>> On 5/7/26 21:09, Jesper Dangaard Brouer wrote:
>>>>
>>>>
>>>> On 07/05/2026 16.46, Simon Schippers wrote:
>>>>>
>>>>>
>>>>> On 5/7/26 16:34, Paolo Abeni wrote:
>>>>>> On 5/7/26 8:54 AM, Simon Schippers wrote:
>>>>>>> On 5/5/26 15:21, hawk@kernel.org wrote:
>>>>>>>> @@ -928,9 +968,13 @@ static int veth_xdp_rcv(struct veth_rq *rq, =
int budget,
>>>>>>>>                }
>>>>>>>>            } else {
>>>>>>>>                /* ndo_start_xmit */
>>>>>>>> -            struct sk_buff *skb =3D ptr;
>>>>>>>> +            bool bql_charged =3D veth_ptr_is_bql(ptr);
>>>>>>>> +            struct sk_buff *skb =3D veth_ptr_to_skb(ptr);
>>>>>>>>                  stats->xdp_bytes +=3D skb->len;
>>>>>>>> +            if (peer_txq && bql_charged)
>>>>>>>> +                netdev_tx_completed_queue(peer_txq, 1, VETH_BQL_=
UNIT);
>>>>>>>
>>>>>>> In the discussion with Jonas [1], I left a comment explaining why =
I think
>>>>>>> this doesn=E2=80=99t work.
>>>>>>>
>>>>
>>>> I've experimented with doing the "completion" at NAPI-end in
>>>> veth_poll(), but that resulted in BQL limit being 128 packets, which
>>>> leads to bad latency results (not acceptable).
>>>> (See detailed report later)
>>>>
>>>>
>>>>>>> I still think first that adding an option to modify the hard-coded
>>>>>>> VETH_RING_SIZE is the way to go.
>>>>>>>
>>>>
>>>> Not against being able to modify VETH_RING_SIZE, but I don't think it=
 is
>>>> the solution here.
>>>>
>>>> The simply solution is the configure BQL limit_min:
>>>>   `/sys/class/net/<dev>/queues/tx-N/byte_queue_limits/limit_min`
>>>>
>>>> My experiments (below) find that limit_min=3D8 is gives good performa=
nce.
>>>> We can simply set default to 8 as this still allows userspace to chan=
ge
>>>> this later if lower latency is preferred.
>>>>
>>>>>>> Thanks!
>>>>>>>
>>>>>>> [1] Link: https://lore.kernel.org/netdev/e8cdba04-aa9a-45c6-9807-8=
274b62920df@tu-dortmund.de/
>>>>>>
>>>>>> In the above discussion a 20% regression is reported, which IMHO ca=
n't
>>>>>> be ignored. Still the tput figures in the data are extremely low,
>>>>>> something is possibly off?!? I would expect a few Mpps with pktgen =
on
>>>>>> top of veth, while the reported data is ~20-30Kpps.
>>>>>>
>>>>>> /P
>>>>>>
>>>>>
>>>>> The ~20-30Kpps occur when thousands of iptables rules are applied an=
d
>>>>> an UDP userspace application is sending.
>>>>>
>>>>> And there is a 20% pktgen regression (no iptables rules applied).
>>>>>
>>>>
>>>> The pktgen test is a little dubious/weird and Jonas had to modify pkt=
gen
>>>> to test this.   John Fastabend added a config to pktgen that allows u=
s
>>>> to benchmarking egress qdisc path, this might be better to use this.
>>>> The samples/pktgen/pktgen_bench_xmit_mode_queue_xmit.sh is a demo usa=
ge.
>>>>
>>>> If redoing the tests, can you adjust limit_min to see the effect?
>>>>   /sys/class/net/<dev>/queues/tx-N/byte_queue_limits/limit_min
>>>>
>>>> 20% throughput performance regression is of-cause too much, but I wil=
l
>>>> remind us, that adding a qdisc will "cost" some overhead, that is a
>>>> configuration choice.  Our purpose here is to reduce bufferbloat and
>>>> latency, not optimize for throughput.
>>>>
>>>>
>>>>> I am pretty sure the reason is because the BQL limit is stuck at 2
>>>>> packets (because the completed queue is always called with 1 packet
>>>>> and not in a interrupt/timer with multiple packets...).
>>>>>
>>>>
>>>> I've run a lot of experiments, which I made AI write a report over, s=
ee attachment.  The TL;DR is that best performance vs latency tradeoff is =
defaulting BQL/DQL limit_min to be 8 packets.
>>>>
>>>> I fear this patchset will stall forever, if we keep searching for a p=
erfect solution without any overhead.  The qdisc layer will be a baseline =
overhead.  The limit=3D2 packets is actually the optimal darkbuffer queue =
size, but I acknowledge that this causes too many qdisc requeue events (le=
ading to overhead).  I suggest that I add another patch in V6, that defaul=
ts limit_min to 8 (separate patch to make it easier to revert/adjust later=
).
>>>>
>>>> I've talked with Jonas, and we want to experiment with different solu=
tions to make BQL/DQL work better with virtual devices.
>>>>
>>>> This patchset helps our (production) use-case reduce mice-flow latenc=
y
>>>> from approx 22ms to 1.3ms for latency under-load.  Due to the consume=
r
>>>> namespace being the bottleneck the requeue overhead is negligible in
>>>> comparison.
>>>>
>>>> -Jesper
>>>
>>> First of all thanks for you work and I really see the advantages of
>>> avoiding bufferbloat :)
>>>
>>> But the key of the BQL algorithm, which is the *dynamic* adaption of t=
he
>>> limit, is not working. Always calling netdev_completed_queue() with
>>> 1 packet results in a static limit of 2 packets (as seen by Jonas
>>> measurements), which you force up to 8 packets.
>>>
>>> So in the end this patchset has the same effect as just setting
>>> VETH_RING_SIZE to 8 (and giving an option to change this value).
>>>
>>
>> I've code up a time based BQL implementation, see attachment.
>> WDYT?
>>
>> --Jesper
>>
>=20
> A step in the right direction, but I dislike that you call
> netdev_sent_queue() with at least 1 packet (never 0 packets).
> I am not sure if it works, and I am not sure about the parameter.
>=20

Rethinking of it this could be fine, but really needs testing because:

The weird thing is that is that BQL's inflight !=3D number of packets
in the ring and BQL's limit !=3D "current ring size". Instead the BQL
limit describes the number of maximal allowed packets between
calls of netdev_sent_queue().



I messed up in my approach below. Forget it :P

>=20
> I would propose doing it like other BQL implementations do
> (for example usbnet for which I adapted BQL [1] :) ):
>=20
> Call netdev_sent_queue() with n_bql in a periodic work. n_bql would
> still be counted in veth_xdp_rcv() like you currently do (synchronized
> with the work via ring.consumer_lock?).
>=20
> The only weird thing that remains is that BQL's inflight !=3D number of
> packets in the ring and BQL's limit !=3D "current ring size". Instead
> the BQL limit describes the number of maximal allowed packets between
> calls of netdev_sent_queue(), which occur periodically in a somewhat
> fixed time interval.
> I guess that could be fine, but it surely needs testing.
>=20
> [1] Link: https://lore.kernel.org/netdev/20251106175615.26948-1-simon.sc=
hippers@tu-dortmund.de/
>=20

