Return-Path: <netdev+bounces-285713-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEjyCMyY/WkJgQAAu9opvQ
	(envelope-from <netdev+bounces-285713-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 10:03:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C17C4F373F
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 10:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D7BA30136A2
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 08:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B2C3815D4;
	Fri,  8 May 2026 08:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=schippers-hamm.de header.i=simon@schippers-hamm.de header.b="NzNMn9hc"
X-Original-To: netdev@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3907D2D8796;
	Fri,  8 May 2026 08:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778227317; cv=none; b=gF+J/Nw85J5zBZCP3lJcyS/zm+LBfnvFV7DrGSOaHrfnFQwIUaKuPBy3zBh+hfyCtMG/CvvMlpmBLWgcPCtTS8RmIlMd0ynDOogG5Qmnxi+zbnr/D1gg63Gqyt/ohLR5moI/JG6yAVGkw2JUuBpVzSksvkp5PNAmRtNUZlnkFkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778227317; c=relaxed/simple;
	bh=DtM9ObPC2xf65aMGWDsoX5q+544+1qRuxHxJOa43uz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fundcFGu8TYcswhKR90o1zB7L8bqzh4sPm5PDR6IxMFAPq5jO+lP5EDfLjvrD8Ya0Ty1+0JUKQyflwffz/hILLF2rZGenDzM/dh9uaWy7qN8r46Rg4anBwd1JfqmxlwtRmqx0XKC2Cslz82zT+GJTNyE959WY6mitTxUrUq97iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schippers-hamm.de; spf=pass smtp.mailfrom=schippers-hamm.de; dkim=pass (2048-bit key) header.d=schippers-hamm.de header.i=simon@schippers-hamm.de header.b=NzNMn9hc; arc=none smtp.client-ip=217.72.192.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schippers-hamm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schippers-hamm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schippers-hamm.de;
	s=s1-ionos; t=1778227298; x=1778832098; i=simon@schippers-hamm.de;
	bh=wUz7wotJgjRTinklR0rNCAuguJaX0sqQoR8T0osUFxI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NzNMn9hcN0BAVIDNBlvy8B/0l8n3kQldBvh7Fvp4IYkXL/aZwla04n3QZH9OiBRe
	 X+ja3oXGdcDlpjWr+WikHuxhBto9Toe91VruwHbO/b/6WVIMSeuhSJ9zGYJ/KZCHy
	 1cNbWt7VxOM80/2R1v3PprcuXhppbfhADnBaUsDZW9ycV6ypaTwC/vzBc7/Wfu5/z
	 c2C+9dsid36TF2shnlV74fHfPlozF1HqGNNSe+4a5gHizc07Kng5owR3tQgZWXeMb
	 gv9a6NzLBXoaoFZ3FvkeRJQ7tw1Ygi3JjnluOZxvWHhehcWMtOeNCue5zqfYIYkcl
	 qx8wkE5NBmILkpJUsQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue106
 [212.227.15.152]) with ESMTPSA (Nemesis) id 1MxEYY-1vNlkX2dQ0-00wv6U; Fri, 08
 May 2026 10:01:37 +0200
Message-ID: <21d639fc-e244-486e-8368-8891b3c43215@schippers-hamm.de>
Date: Fri, 8 May 2026 10:01:32 +0200
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
 <68223314-1a44-4aee-8207-57437ef9f3ab@schippers-hamm.de>
 <3e43117f-356d-4086-a176-abd7fe2e6f0a@kernel.org>
Content-Language: en-US
From: Simon Schippers <simon@schippers-hamm.de>
In-Reply-To: <3e43117f-356d-4086-a176-abd7fe2e6f0a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zDwADc0FGBLOBahFsQDxH8onU0V5mTOVVT8x93s3OIkPGtrk20g
 ZSbR4i7DY1CFUq2uEVLBRg1if2CGUiqLYchg4sPlFR+wARrpkWSXi7XHY0psmDlfHuNPyJD
 vLtVnzYwRE+DwCSjVYZ7TFKra8Z/cIIVBcmRCA1oP5DjX8i/Ag7swf/XmRkvkJ97t9fO7PS
 wk1JaheynjW3XEo6SZY5A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:S0c4q/VFQ58=;YP+KTwseffOQyKg9GRt1/4Y4Hx5
 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
 T/eh387HqCI7US2TRd+y0bp8HDBHuX6L
X-Rspamd-Queue-Id: 7C17C4F373F
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
	TAGGED_FROM(0.00)[bounces-285713-lists,netdev=lfdr.de];
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

On 5/7/26 22:45, Jesper Dangaard Brouer wrote:
>=20
>=20
> On 07/05/2026 22.12, Simon Schippers wrote:
>> On 5/7/26 21:09, Jesper Dangaard Brouer wrote:
>>>
>>>
>>> On 07/05/2026 16.46, Simon Schippers wrote:
>>>>
>>>>
>>>> On 5/7/26 16:34, Paolo Abeni wrote:
>>>>> On 5/7/26 8:54 AM, Simon Schippers wrote:
>>>>>> On 5/5/26 15:21, hawk@kernel.org wrote:
>>>>>>> @@ -928,9 +968,13 @@ static int veth_xdp_rcv(struct veth_rq *rq, i=
nt budget,
>>>>>>>                }
>>>>>>>            } else {
>>>>>>>                /* ndo_start_xmit */
>>>>>>> -            struct sk_buff *skb =3D ptr;
>>>>>>> +            bool bql_charged =3D veth_ptr_is_bql(ptr);
>>>>>>> +            struct sk_buff *skb =3D veth_ptr_to_skb(ptr);
>>>>>>>                  stats->xdp_bytes +=3D skb->len;
>>>>>>> +            if (peer_txq && bql_charged)
>>>>>>> +                netdev_tx_completed_queue(peer_txq, 1, VETH_BQL_U=
NIT);
>>>>>>
>>>>>> In the discussion with Jonas [1], I left a comment explaining why I=
 think
>>>>>> this doesn=E2=80=99t work.
>>>>>>
>>>
>>> I've experimented with doing the "completion" at NAPI-end in
>>> veth_poll(), but that resulted in BQL limit being 128 packets, which
>>> leads to bad latency results (not acceptable).
>>> (See detailed report later)
>>>
>>>
>>>>>> I still think first that adding an option to modify the hard-coded
>>>>>> VETH_RING_SIZE is the way to go.
>>>>>>
>>>
>>> Not against being able to modify VETH_RING_SIZE, but I don't think it =
is
>>> the solution here.
>>>
>>> The simply solution is the configure BQL limit_min:
>>>   `/sys/class/net/<dev>/queues/tx-N/byte_queue_limits/limit_min`
>>>
>>> My experiments (below) find that limit_min=3D8 is gives good performan=
ce.
>>> We can simply set default to 8 as this still allows userspace to chang=
e
>>> this later if lower latency is preferred.
>>>
>>>>>> Thanks!
>>>>>>
>>>>>> [1] Link: https://lore.kernel.org/netdev/e8cdba04-aa9a-45c6-9807-82=
74b62920df@tu-dortmund.de/
>>>>>
>>>>> In the above discussion a 20% regression is reported, which IMHO can=
't
>>>>> be ignored. Still the tput figures in the data are extremely low,
>>>>> something is possibly off?!? I would expect a few Mpps with pktgen o=
n
>>>>> top of veth, while the reported data is ~20-30Kpps.
>>>>>
>>>>> /P
>>>>>
>>>>
>>>> The ~20-30Kpps occur when thousands of iptables rules are applied and
>>>> an UDP userspace application is sending.
>>>>
>>>> And there is a 20% pktgen regression (no iptables rules applied).
>>>>
>>>
>>> The pktgen test is a little dubious/weird and Jonas had to modify pktg=
en
>>> to test this.   John Fastabend added a config to pktgen that allows us
>>> to benchmarking egress qdisc path, this might be better to use this.
>>> The samples/pktgen/pktgen_bench_xmit_mode_queue_xmit.sh is a demo usag=
e.
>>>
>>> If redoing the tests, can you adjust limit_min to see the effect?
>>>   /sys/class/net/<dev>/queues/tx-N/byte_queue_limits/limit_min
>>>
>>> 20% throughput performance regression is of-cause too much, but I will
>>> remind us, that adding a qdisc will "cost" some overhead, that is a
>>> configuration choice.  Our purpose here is to reduce bufferbloat and
>>> latency, not optimize for throughput.
>>>
>>>
>>>> I am pretty sure the reason is because the BQL limit is stuck at 2
>>>> packets (because the completed queue is always called with 1 packet
>>>> and not in a interrupt/timer with multiple packets...).
>>>>
>>>
>>> I've run a lot of experiments, which I made AI write a report over, se=
e attachment.  The TL;DR is that best performance vs latency tradeoff is d=
efaulting BQL/DQL limit_min to be 8 packets.
>>>
>>> I fear this patchset will stall forever, if we keep searching for a pe=
rfect solution without any overhead.  The qdisc layer will be a baseline o=
verhead.  The limit=3D2 packets is actually the optimal darkbuffer queue s=
ize, but I acknowledge that this causes too many qdisc requeue events (lea=
ding to overhead).  I suggest that I add another patch in V6, that default=
s limit_min to 8 (separate patch to make it easier to revert/adjust later)=
.
>>>
>>> I've talked with Jonas, and we want to experiment with different solut=
ions to make BQL/DQL work better with virtual devices.
>>>
>>> This patchset helps our (production) use-case reduce mice-flow latency
>>> from approx 22ms to 1.3ms for latency under-load.  Due to the consumer
>>> namespace being the bottleneck the requeue overhead is negligible in
>>> comparison.
>>>
>>> -Jesper
>>
>> First of all thanks for you work and I really see the advantages of
>> avoiding bufferbloat :)
>>
>> But the key of the BQL algorithm, which is the *dynamic* adaption of th=
e
>> limit, is not working. Always calling netdev_completed_queue() with
>> 1 packet results in a static limit of 2 packets (as seen by Jonas
>> measurements), which you force up to 8 packets.
>>
>> So in the end this patchset has the same effect as just setting
>> VETH_RING_SIZE to 8 (and giving an option to change this value).
>>
>=20
> I've code up a time based BQL implementation, see attachment.
> WDYT?
>=20
> --Jesper
>=20

A step in the right direction, but I dislike that you call
netdev_sent_queue() with at least 1 packet (never 0 packets).
I am not sure if it works, and I am not sure about the parameter.


I would propose doing it like other BQL implementations do
(for example usbnet for which I adapted BQL [1] :) ):

Call netdev_sent_queue() with n_bql in a periodic work. n_bql would
still be counted in veth_xdp_rcv() like you currently do (synchronized
with the work via ring.consumer_lock?).

The only weird thing that remains is that BQL's inflight !=3D number of
packets in the ring and BQL's limit !=3D "current ring size". Instead
the BQL limit describes the number of maximal allowed packets between
calls of netdev_sent_queue(), which occur periodically in a somewhat
fixed time interval.
I guess that could be fine, but it surely needs testing.

[1] Link: https://lore.kernel.org/netdev/20251106175615.26948-1-simon.schi=
ppers@tu-dortmund.de/


