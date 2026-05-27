Return-Path: <netdev+bounces-292198-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAbqEpWvFmokogcAu9opvQ
	(envelope-from <netdev+bounces-292198-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:47:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 879675E14A3
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1ED1305A71E
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 08:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F733DE422;
	Wed, 27 May 2026 08:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=schippers-hamm.de header.i=simon@schippers-hamm.de header.b="pNJYof3h"
X-Original-To: netdev@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F04E377009;
	Wed, 27 May 2026 08:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779871504; cv=none; b=bUkJFI5/EP/LwIgxdtJmUsAhOlMAlO/VlHmbBxHqaZmlO1wETaqviLG1k1SX50ATz0sExjyzZ54AXxEYWoebCPSWYxRs6ktr3/j+dso/hMjzv30MRAnAdy71bVct7XW0DHiVcpf1lNMFIIK7j3XPFA/ipWBYsoah3yq3Tmuvm04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779871504; c=relaxed/simple;
	bh=XX1GbH64x35fuWFNo/SQ2/x+8KQpJKIax2C5VfJhvFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mpNUQroVYEKiyyqBKI+/QdzfK9LWZD5Tznzp1G4bJGEBNxSubrMmqug7pWGWZvJfXZxCHY4SmPa9UCNofXdf6CRJnXrSQSlmcaOcRyA61Cy0SFuJjDf5Cmn2GiAPMDYeW/ihnabYOCqbDHtJz9iLMUcWKYUgcmkuk1UhvJUr/j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schippers-hamm.de; spf=pass smtp.mailfrom=schippers-hamm.de; dkim=pass (2048-bit key) header.d=schippers-hamm.de header.i=simon@schippers-hamm.de header.b=pNJYof3h; arc=none smtp.client-ip=212.227.17.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schippers-hamm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schippers-hamm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schippers-hamm.de;
	s=s1-ionos; t=1779871496; x=1780476296; i=simon@schippers-hamm.de;
	bh=6o+Z8qEV5bOs+HS0eW5p+DnEH2JHVvHeYJoKtbo+yk4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pNJYof3h16DmZpmP3HmoWfeTUjz9jjaoU/KVQNcmoW4RcG+z6ZvsxXN+jns5u1lg
	 iNJIGwg7FMsH9TuM7q1bN2a9bHIdlIe1YZiYSW8TzKpkK4bNkBzBAxOk7cBlTunLL
	 blSPfvspj1kXcI5PWYT29KXqc5huWOMidBM5gVpl+qhqQJZXZNLyGz5v9RhuFJtEN
	 cwx9JhDOm637wfHD+9GzFqg3ZzUoT9NydN0WkQbs+M2o4TDs0/23S5Uvxz+MSvBMV
	 5tk1OtjUu0kWlPHB4ewSy1qXMTvE6T7aPMsVV1ftuICaGdR2M/BEOxyWkFSBtcTGJ
	 FpoZ457WMQNW7uMDnw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue107
 [212.227.15.153]) with ESMTPSA (Nemesis) id 1MLQgv-1wjYDM2tQh-00P6ec; Wed, 27
 May 2026 10:38:55 +0200
Message-ID: <e55f4be1-334c-4623-b030-43d17a25b250@schippers-hamm.de>
Date: Wed, 27 May 2026 10:38:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/5] veth: implement Byte Queue Limits (BQL)
 for latency reduction
To: Jesper Dangaard Brouer <hawk@kernel.org>,
 =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 kernel-team@cloudflare.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260505132159.241305-1-hawk@kernel.org>
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
 <e8be86b4-052f-4f4f-9cb9-2fb12d1e8922@schippers-hamm.de>
 <80dc574b-f2da-4f04-8bc8-1b0793b1f296@kernel.org>
Content-Language: en-US
From: Simon Schippers <simon@schippers-hamm.de>
In-Reply-To: <80dc574b-f2da-4f04-8bc8-1b0793b1f296@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z28hEpM6RoXsF/wd+cQFLKgP5bi5N/VNjAniYz5iH5qGAb1Qi/O
 fxSNlRqdkSugaiVwrvBiz1pB5znLiveHkxqNv5IzzGrBakGGo14wWHiH+y77ikKyXOduuiE
 bdex+wQlo0Xuomw41NVrS+3NTOpMZ9HoY5GOTo4wr4MQ10ZW0mB/tAsI9v2Eg2M047cqtz9
 9VrvxgjGdhdOa2eLMCyGQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zd5ERNlsKjI=;PN+waDjd+U4HiArES2JV+renc3y
 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
 kJwGobCIJnGBenf8qAg76MI/Jjq/sX3+
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[schippers-hamm.de,none];
	R_DKIM_ALLOW(-0.20)[schippers-hamm.de:s=s1-ionos];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292198-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 879675E14A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/27/26 09:38, Jesper Dangaard Brouer wrote:
>=20
>=20
> On 26/05/2026 17.07, Simon Schippers wrote:
>> On 5/26/26 16:55, Jonas K=C3=B6ppeler wrote:
>>> On 5/26/26 4:35 PM, Simon Schippers wrote:
>>>> On 5/26/26 11:54, Jonas K=C3=B6ppeler wrote:
>>>>> On 5/23/26 6:09 PM, Simon Schippers wrote:
>>>>>> On 5/22/26 18:26, Jonas K=C3=B6ppeler wrote:
>>>>>>> On 5/22/26 10:41, Simon Schippers wrote:
>>>>>>>> On 5/22/26 09:14, Jonas K=C3=B6ppeler wrote:
>>>>>>>>> On 5/19/26 10:51 PM, Simon Schippers wrote:
>>>>>>>>>> On 5/12/26 23:55, Simon Schippers wrote:
>>>>>>>>>>> On 5/12/26 15:54, Jesper Dangaard Brouer wrote:
>>>>>>>>>>>>>> Nope, I'm using a bpftrace program to keep track of the inf=
light/limit
>>>>>>>>>>>>>> in a BPF hashmap.  Reading from /sys will not be accurate.
>>>>>>>>>>>>> Ah nice.
>>>>>>>>>>>> Add the option --hist to have both NAPI and BQL histograms pr=
inted when
>>>>>>>>>>>> script ends.  This will give you an accurate pattern of how i=
nflight and
>>>>>>>>>>>> limit evolves.
>>>>>>>>>>>>
>>>>>>>>>>>>>> I moved the selftests into a github repo [1] to allow us to=
 collaborate
>>>>>>>>>>>>>> and evaluate the changes more easily.  I explicitly kept th=
e new BPF
>>>>>>>>>>>>>> based BQL tracking as a commit[2] for your benefit.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>        [1] https://github.com/netoptimizer/veth-backpressur=
e-performance-testing/tree/main/selftests
>=20
> [... cut ...]
>=20
>>>>
>>>> I will wait for your new measurements, but there is no argument
>>>> against a default tx-usecs of ~100us for now, right?
>>> Yes, I think 100us is perfectly fine. I guess most of it was
>>> just my curiosity why the latency values are as they are =F0=9F=99=82
>> Which is great, because I was wondering the same =F0=9F=99=82
>>
>=20
> Thank you Jonas and Simon for testing this via[1] on your systems.
>=20
> One performance concern from my side is if/when BQL limit goes below 8
> packets. This will cause cache-line bouncing and many qdisc requeues
> between the two CPUs.  Notice that 8 packets for the ptr_ring is one

I think the qdisc requeues are an issue of dc82a33297fc ("veth: apply
qdisc backpressure on full ptr_ring to reduce TX drops").

It could be solved by stopping the netdev queue after inserting
the last element like I did in my tun tap implementation [1].
I know, you also did this before in a previous implementation, but
the required re-check used __ptr_ring_empty() which is not allowed as
producer.
That is the reason why I introduced the new __ptr_ring_check_produce()
in [1] which is safe for the producer to call.

[1] Link: https://lore.kernel.org/netdev/20260510151529.43895-5-simon.schi=
ppers@tu-dortmund.de/

> cache-line. This is why I suggested defaulting BQL min_limit to be 8.
> This would work in combination with the tx-usecs coalesce tuning as a
> lower bound.

Yes, it would work but I think it is fine as-is.
BQL will only choose such a small limit if the consumer is really
slow anyway.


