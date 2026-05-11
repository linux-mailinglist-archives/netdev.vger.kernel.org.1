Return-Path: <netdev+bounces-286825-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kD4sGY8/Amo/pgEAu9opvQ
	(envelope-from <netdev+bounces-286825-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 22:43:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F17515F9C
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 22:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB9143010614
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A303A75A7;
	Mon, 11 May 2026 20:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=schippers-hamm.de header.i=simon@schippers-hamm.de header.b="BVFKdiNw"
X-Original-To: netdev@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEE637C914;
	Mon, 11 May 2026 20:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778532236; cv=none; b=EQDZfxJXjd7KTRSTIo5jpy7uz1GwrnxGqueX4QgffZttuG3vFJjTcApOTmX7B/XA1XQC5x54q4Uk7YDw37RlFppDGEvXAgc+2lC+I1trM/hJwUKItaFshpywLRkFW/E6VVAxTxvX3mkNbP6ZMe6QMDWtDD1fWkig8OJM12OEe38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778532236; c=relaxed/simple;
	bh=fUq0qU4cBxsTW9R3sz9BsqAquhnqg6IDPdsdpb1bsKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NtgR5aZfb0TSoFUq7fkoL7wWFarjwbPMInSdWjOJqFnh0pjqamYRDjE1N6I0dvT7hLzn9aOOSvLHyifZZtMtLm2YfcWybgx9fBClBi30roOkPl3GydkKzMSHdHOGDHjaFVHsvZJx7JbwE9TstSNA+RVSK2k4BmZpKfQNNeR89CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schippers-hamm.de; spf=pass smtp.mailfrom=schippers-hamm.de; dkim=pass (2048-bit key) header.d=schippers-hamm.de header.i=simon@schippers-hamm.de header.b=BVFKdiNw; arc=none smtp.client-ip=212.227.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schippers-hamm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schippers-hamm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schippers-hamm.de;
	s=s1-ionos; t=1778532227; x=1779137027; i=simon@schippers-hamm.de;
	bh=t0+Rudo8AN3qE03sMG+W9/hxi3E1ce4JHhEtWuG3pHM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BVFKdiNwTJRso527IfRjf0AzxdwLnVwwN7SgmkXOs3v+ZNO5Z4RQPh46OWKW6wow
	 MvHWP+xNEL7PbA6+zFhak5Qgt5SJLl+0k0ovzqny1hqbQRyBPcOLNjYx9mTqUYkLc
	 vTjan0AH/4HHAm3h9aA3P+b9RTN0+TFmhDk7+QQfnLb2/w9Ls1wzUkD1kTXUJG6SU
	 n+aFjI54NIIkJM2IzJIZz2tx2fvx0jVZLBNbSlQR6Ep1JGl7TO3W2UxrhoXmApGm5
	 yBygoOHYzyg18WnHCcmAFMi4+YJoikwEaSQOCQIB+6gqeaGOMWo++wWS/6R7sJTgy
	 mjrYcaH/IQa89WxYdQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue010
 [212.227.17.165]) with ESMTPSA (Nemesis) id 1Mj8a5-1x1cxM2qBh-00mmTM; Mon, 11
 May 2026 22:37:42 +0200
Message-ID: <873511fa-4316-4411-a76b-ec4c5805abd3@schippers-hamm.de>
Date: Mon, 11 May 2026 22:37:34 +0200
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
Content-Language: en-US
From: Simon Schippers <simon@schippers-hamm.de>
In-Reply-To: <b78f002a-8cb9-4857-bf8f-0137e790f644@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8ofPttGkX9GjGw2ZZhl5GupZXX67Fj1OAmIQJmLA0f/tXsOkwLS
 PoGPFcCbkcsc43il4IzAQhetCYIHj0UwujzSv4MrVSu5jNJjU6FaAnNWXLxe3ZqyJ7xvJFL
 BrucUhpd2k7zuTioGGcZgUt1HYImuan/aXunhLJJvmqpjOy2i5qSe/2xsChAYc/ICWIv2rW
 eC6KRKRLgnbiIUr21AaOw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5/ldXUM27sk=;yJIc0Ks/XPcwid3LSXWDx+4n7WB
 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
X-Rspamd-Queue-Id: 04F17515F9C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[schippers-hamm.de,none];
	R_DKIM_ALLOW(-0.20)[schippers-hamm.de:s=s1-ionos];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286825-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,veth_bql_test_virtme.sh:url]
X-Rspamd-Action: no action

On 5/11/26 20:08, Jesper Dangaard Brouer wrote:
>=20
>=20
> On 11/05/2026 11.55, Simon Schippers wrote:
>> On 5/11/26 10:11, Jesper Dangaard Brouer wrote:
>>>
>>>
>>> On 10/05/2026 17.56, Jakub Kicinski wrote:
>>>> On Sat, 9 May 2026 11:09:51 +0200 Jesper Dangaard Brouer wrote:
>>>>> On 09/05/2026 04.06, Jakub Kicinski wrote:
>>>>>> On Thu, 7 May 2026 21:09:09 +0200 Jesper Dangaard Brouer wrote:
>>>>>>> Not against being able to modify VETH_RING_SIZE, but I don't think=
 it is
>>>>>>> the solution here.
>>>>>>
>>>>>> Was it evaluated, tho?
>>>>>>
>>>>>> It's obviously super easy these days have AI spew no end of complex
>>>>>> code. So it'd be great to have some solid, ideally production-like
>>>>>> data to back this all up.
>>>>>>
>>>>>> VETH_RING_SIZE seems trivial, ethtool set ringparam
>>>>>
>>>>> No, unfortunately we cannot just decrease the VETH_RING_SIZE.
>>>>
>>>> To be clear - I said may it configurable with ethtool -G
>>>> not change the default.
>>>>
>>>
>>> Sure, I understand the desire to make VETH_RING_SIZE configurable.
>>> If doing so we are making Linux network stack harder to tune and setup
>>> correctly. E.g. adding a qdisc to veth would also require changing the
>>> ring size, but if system also uses XDP then tuning below 64 (likely 12=
8)
>>> will lead to hard-to-find packet drops.
>>
>> I mean 64 still could be a 4x improvement at least.
>>
>=20
> No not really, setting it to 64 will give same (bad) latency from "BQL
> off" which that patchset is trying to address.
>=20
>>>
>>> I prefer adding something (like BQL) that auto-tune how much of the ri=
ng
>>> queue we are using.  Good queues function as shock absorbers when
>>> concurrent processes in the OS have scheduling noise.
>>>
>>> I acknowledge that Simon Schippers found that the BQL implementation w=
as
>>> actually not auto-tuning.  We need to work on this, my prototype
>>> implementation [1] [2] works surprisingly well.
>>>
>>>
>>> - [1] https://lore.kernel.org/all/3e43117f-356d-4086-a176-abd7fe2e6f0a=
@kernel.org/2-09-veth-time-based-bql-coalescing.patch
>>> - [2] https://lore.kernel.org/all/3e43117f-356d-4086-a176-abd7fe2e6f0a=
@kernel.org/
>>>
>>>
>>>>> The reason is that XDP-redirect into veth don't have any
>>>>> back-pressure and would simply drop packets if queue size becomes
>>>>> less than the NAPI budget (64). (Yes, we use both normal path and
>>>>> XDP-redirect in production).
>>>>
>>>> Doesn't this mean you have a queue which is not under BQL control?
>>>>
>>>
>>> It is a matter of perspective. BQL needs between 17-55 elements in the
>>> 256 queue.  At the same time we handle if the ring runs full, e.g. due
>>> to a sudden burst of XDP redirected packets, which pushes packets into
>>> the qdisc layer.
>>
>> You are checking inflight/limit in /sys directory to get the 17-55
>> number, right?
>>
>=20
> Nope, I'm using a bpftrace program to keep track of the inflight/limit
> in a BPF hashmap.  Reading from /sys will not be accurate.

Ah nice.

>=20
> I moved the selftests into a github repo [1] to allow us to collaborate
> and evaluate the changes more easily.  I explicitly kept the new BPF
> based BQL tracking as a commit[2] for your benefit.
>=20
>  [1] https://github.com/netoptimizer/veth-backpressure-performance-testi=
ng/tree/main/selftests
>=20
>  [2] https://github.com/netoptimizer/veth-backpressure-performance-testi=
ng/commit/f25c5dc92977

Thanks for sharing. After minor issues I was able to set it up
(currently I am just using plain v5, will look at the coalescing patch
when I find the time):

Can confirm the latency reduction with the default settings, in my case
4.888ms to 0.241ms.

With the same script I was also able to see a performance slow down:
veth_bql_test_virtme.sh --qdisc fq_codel --nrules 0
=2D-> ~510 Kpps
Same with --bql-disable
=2D-> ~570 Kpps
=2D-> 12% faster

>=20
> Sorry for cutting the remaining of the message, but I ran out of time,
> as things are a bit challenging/hectic here at Cloudflare at the moment.
>=20
> --Jesper

All good, just ignore it. I think I misunderstood something anyway.


