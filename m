Return-Path: <netdev+bounces-292167-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJjeFxyoFmrEoAcAu9opvQ
	(envelope-from <netdev+bounces-292167-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:15:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 661EC5E0F0E
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 58B013006821
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 08:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB0B30B533;
	Wed, 27 May 2026 08:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=schippers-hamm.de header.i=simon@schippers-hamm.de header.b="P0pOriXP"
X-Original-To: netdev@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB933D412A;
	Wed, 27 May 2026 08:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779869719; cv=none; b=gEakJK5CDoCCySCVjkPg7XYV7MeAvWbpF1/yblhaiMTeUl1ZusCh7VlTmNdw9ppQs2u2fSjDfiG+9yxVLk+XgTyw9/TQL7HhGqKKB89AigrYulVzp05wT1ZLX0xKEHOU739u84ZSCarPtJXen+/D5PJL16FB0AmWkcGFWYAlZw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779869719; c=relaxed/simple;
	bh=awyugumM3qo46MIVZx+zXmGVa3RYVUzF2YfyxbAk7kY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AXIdEi7zU/8RxkC9zl48ww3pTf9ridGqtJjHg9AqFKD3K9e9zyVLHU9iISd327Mvpdba2IvVmyt4rTC2Oy/6L/5H8P9HLblOEzpf37SdbtbvFJle2g9V4AHw2IWYt+3hHdhLdLoexYyU5ZjS5iyEyvKgoMv+LYM6Mzpm1/4leM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schippers-hamm.de; spf=pass smtp.mailfrom=schippers-hamm.de; dkim=pass (2048-bit key) header.d=schippers-hamm.de header.i=simon@schippers-hamm.de header.b=P0pOriXP; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schippers-hamm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schippers-hamm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schippers-hamm.de;
	s=s1-ionos; t=1779869712; x=1780474512; i=simon@schippers-hamm.de;
	bh=f3Lohq8QkJslkmRARTq1SuDTwuwePjcsabJjeIQHvZM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=P0pOriXPUIl8XqZW7PJmHjFxAGPiLg5BQRXTX1/REAqj45p8HfEhk60t2smMaWfu
	 nYWbK2tNyvhGa2sMMeIhQtDpWiQRCoH67uEq05qvOYx7rxWefETTU5G9TMo29bDso
	 s6aaAkwChL8ZmNKkUs06JHeoxvKNXelDdsp89+4hx5UiCNDNKR+BluGtV69fLuU/X
	 O6Pqw+B0uOuplCM3vLG7DRSEG31SYaPVyWKqgmEorb7ko5QN+nf0QSG61ywGKBFFU
	 dNc1xd+v0Ky7LiUIZWoNRSdTuYiT9ytGzMQEjA0T+RBKn6BYTXqO21snoa5yZnjeP
	 n7YV+tyVJyYT85WgJA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue107
 [212.227.15.153]) with ESMTPSA (Nemesis) id 1M1ZQT-1wU5G93wHT-005ELU; Wed, 27
 May 2026 10:00:07 +0200
Message-ID: <ab6f0519-0b87-4b57-9a35-92edf3fd7f5a@schippers-hamm.de>
Date: Wed, 27 May 2026 09:59:56 +0200
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
X-Provags-ID: V03:K1:5rcKy/WcrljJurdI9KzFMNJmeY1XyCnPuqniL3I3Wy7nLTefg3Y
 5NFTTxgwSUMYfrbz+Oc1+wirmx15tK92MNmcYGrvoUFblBsYAe/npGSoUTiZPdAs15edDVR
 wesIU+iHpE1PsaWEBRl9lDJYzSmR1G3SY14HC19QWVZIi42BBOqBCKdxeZPakcbRuyilOLW
 89dF4ov+DQ17LzbRU7Rtw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bWSy5q9ZbcQ=;LhDbvD6KyTDnRg0TM/XlN2A64r0
 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
 H7Rks3Q/tO9SEeURSW2wbesAJbcbLmfa
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[schippers-hamm.de,none];
	R_DKIM_ALLOW(-0.20)[schippers-hamm.de:s=s1-ionos];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292167-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 661EC5E0F0E
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
> cache-line. This is why I suggested defaulting BQL min_limit to be 8.
> This would work in combination with the tx-usecs coalesce tuning as a
> lower bound.
>=20
>=20
>>> But it feels like this will need some documentation, because
>>> as we have seen, some values are a little different
>>> from what you expect from bql. Inflight > veth_ring_size,
>>> tx-usecs not necessarily achieving the configured value,
>>> inflight can get stuck > 0. Wdyt?
>>> But I think it works nicely overall.
>>>
>> Exactly, we should get ready for a v6 soon.
>>
>=20
> I want to send out a V6 today (and I'm busy rest of week).
> I'm simply going to include Simon's patch[2]. Then we can iterate on
> that email thread, making it easier for people to reply inline to the
> code changes.
>=20
> [2] https://lore.kernel.org/all/9a57bb41-114e-492b-9eaa-52237675bb7c@sch=
ippers-hamm.de/
>=20

Sure, but please address those 2 nits:
- replace unlikely(!ring->size) || __ptr_ring_full(ring)
  with unlikely(__ptr_ring_check_produce(ring))
- replace ptr_ring_empty() with __ptr_ring_empty()

Apart from that I think the code is fine.
Just the commit messages need changes but we can adapt them later.

>> And I think we should move the BQL logic into a seperate .h file
>> as a library. Then it is also usable for TUN/TAP in the future.
>>
>=20
> I like the idea, but refactoring into a library seems out-of-scope for
> this patchset.  As a first step, let us see if this works for veth
> driver use-case.  I do encourage Simon to refactor when doing the work
> for TUN/TAP in the future.

Okay, fair point. I do not have a problem with that.

I did this split in [1] but we can ignore that for now.

[1] Link: https://github.com/jkoeppeler/veth-backpressure-performance-test=
ing/pull/1

>=20
> Alternatively netdev maintainers can choose to apply V5 patchset and we
> can iterate on finding the right ethtool coalesce parameters for veth
> and create a .h "library" file for this.
>=20
>=20
>> Let's amend the commits. Should we do this on Github?
>=20
> Kernel development for netdev [3] happens on the mailing list with patch=
es via email.

Okay :)

Thanks!

>=20
> --Jesper
>=20
> [3] https://kernel.org/doc/html/latest/process/maintainer-netdev.html
>=20

