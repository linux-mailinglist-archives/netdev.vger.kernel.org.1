Return-Path: <netdev+bounces-286586-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QE46N1+sAWoMhwEAu9opvQ
	(envelope-from <netdev+bounces-286586-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:15:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4414050BBAB
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FB51305749C
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CEE3C4576;
	Mon, 11 May 2026 10:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=schippers-hamm.de header.i=simon@schippers-hamm.de header.b="tcPPCTrc"
X-Original-To: netdev@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926C42FFDE3;
	Mon, 11 May 2026 10:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778494242; cv=none; b=sxn8v92D0vXbXbARt3tL54I7GXyA5BtcUlKBiuPppVLabrdERoH/bg91kO23D5gcKXtOwC1HENxnlefHJU9jKo0e6WKUHXb/EOnmPQBCpo7A4M793DzOTnOnkx8jFP5ekDy6MFFGk3IVH/UYKwSsjUcg3iAIIBu/FcpYOw2J0Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778494242; c=relaxed/simple;
	bh=Qz9kpg/HS0cFlZE/TwFxVNmoXERLtHXlJY68fxjj6qA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EbIw102oXrjN/BE94TcFd1Gb8rUi5iW7aC6kuLlmFWEEFJQdYPcuG8WaKD/qVkMvwHJ9f05RPli6qScgyKfu3uMXD5RKPitpuhTAPGUFy3UzSmGOCX7MBcSmdxExA3LQ0Z3DK0fgH/Yoid9t3FscvBsjfjv6v0m0cNCw4ZDXiHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schippers-hamm.de; spf=pass smtp.mailfrom=schippers-hamm.de; dkim=pass (2048-bit key) header.d=schippers-hamm.de header.i=simon@schippers-hamm.de header.b=tcPPCTrc; arc=none smtp.client-ip=212.227.126.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schippers-hamm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schippers-hamm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schippers-hamm.de;
	s=s1-ionos; t=1778494222; x=1779099022; i=simon@schippers-hamm.de;
	bh=UkLOFwSIv0ZeMA04rMv1O9GYe4NK09leTU5z8PTBxOU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tcPPCTrcSfTJgiq3ZVeonnCyXGftoGWAOmpOOL7S9698YfkKOlO2kyn5TDKRXEpq
	 bsMdhnbUJ2Z1/xUAsgHgyrtsNRfeo7tDqPEcIeyERpryxvMufsOIDVE/+/sk995c9
	 A1hdE2aXdvuItcWPOKyWw08hHm2P3+MMmyJZg4vWmY5m6ujK+ewtB02L/5iLPqOf/
	 /8SAAehlhfhvwRsLkIMFXn8w9NNgjMMnKUTfw3LpNiHknTiowTeAnJdcv24DuJq1m
	 M2x7aN8a+nn9yKqphT72aPvJ48vqcLGUPkNqk4vfyqRLIbsI4ZdcwaztM+ztPrbn2
	 H0u8f9hfYGDtj4cG3w==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue012
 [212.227.15.136]) with ESMTPSA (Nemesis) id 1Mq1GE-1x9AJB0U9C-00pEe9; Mon, 11
 May 2026 11:55:51 +0200
Message-ID: <41023c34-87a3-4e4f-b3ab-3ed53d171910@schippers-hamm.de>
Date: Mon, 11 May 2026 11:55:46 +0200
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
Content-Language: en-US
From: Simon Schippers <simon@schippers-hamm.de>
In-Reply-To: <daa05c21-dcfc-4cc4-aa22-9e25c7f6c743@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ooYqc/zrl1aUI/C0NK5cJ8I5Ix6X2RKup/9iRqBAMhsFc2c1ciN
 d06pIv4q+1GQtF1C7815sHLqpU44X5Zi0YZp94iibLKFHR6MR/lOnAyBFwNasYzoi0CQUK8
 xwQU6Bsrd3i3jHGIxBkk5Lu0+gJfx1gCJ0pytst4zdLP5vkq5DG/CqK6692hLh5v1HDMVrx
 LG2HJ/7NpmqNujlliiQAg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:x9YASn3Q0N8=;pRVWsaTwVHJbKS4ZMMM+1J75ABr
 Ryi9pFKo1rlDhjCDtAtxmjdxAi9hYJiJRpuLBV0oFDQVdVz0duBPx93xVn02iemHuglLfCCtf
 LC+cAQHlXu7s0dGOlTOu5YDHigWnwfa2woCkMSC8e3g5Cvwc9undZaBS+2UMjijXSxlnxvtap
 SlVBsW+Xg0S5TQ7Y7LH3yupvS9/0kxjAKt3oh1VDkW3cV0QKA3CG0KuoH6FnfugVg1EXtZ+U2
 dNcAtk2pBH1XZjnpCiq4WXp1xvNlYo1MtLLCQOm8mnTKIB2FbSubBtG+Osg9ivl5xsEnLIMJd
 RRxDzoTirwUGGg2F3wEQLgQwZPeH6LaNxVBJ3UytOWi9bD2/6XHVVAXbyZ4Sno4MVpNJvMz0W
 hzIFPbO/QMqxWI/eDjVtSdM+/hbirdhBRNAF2eQPKO+GCohhVvFJCxIn3K627MtNyTD6u1Bg4
 f7/ZBig0egxOpIUpoVIvngq/b1qDvPsDcawiNEE6iSXIVGRi8v7pYNV3MrAP33fCo1JOFDOUw
 Z4CMN1awnwLmF4jAySr08tqTimwK1pnBBu/ogUuiqAhpQ2+aHiy3VHY9kdLYuUtW/0qEFpAMj
 EBWO9BEpPYgoceq5Wwc7DQ1UlnXWv+iSAklGZ/SWH4JD93qNbTKIbYyZV8nIUGXcuiwI3yoSZ
 CVvl7X022VJ2onsaNvPoRXj2G2SBSsrUEcHGekYVOjWRFVQlHBX/YrRovdW/A+RZYVnB8yaTG
 hZ6PFIGFF2Uh+a0D7RQayW2fYYicPZTsyf7sGt7BwUG/9Nwe86nJStozlQAcaHAyQnHxdyZF2
 lgjiwPjk5pOWrzjeKPhr4M/r8aNjrZ1CjopDN89vgcV+9ZfSnCD5pIAJ1Vn9FkBi596rigprL
 Ki+SfbCGw4E+/ouFv3VJy6LUntKEXG9jJiIoK/lyHXCQm9FMutEsLJcd5r87dnPISAjEmCM9b
 UyQj4Q4jdKJ6nmVi8THDzIvUXsFXpxdjEm/7HnzuqKArp/ijm3ohl/box5n/g6VRhPq7iNmPD
 Czde+rYq0b7MhrnGXM96Bom2vwHQgYtx6KciU/hBQ2fgbppch8J95p8zDqCrqxURC1o794IsN
 0aDrlv0v0IQdDz3Flh5SsKiFFKtnwJ5Z180yRIAISXTWo22we689/DsIZQbJfikbsZjg1q6Yl
 PL7be4Tz25ApSXx/alwLSblJl/wnUBF5ZRIYlsRoHZq86XWaxfFWApsep2TdCNGTbSKc6mnRD
 XHKz4pEtyXsGg2NqRCB3eYD6doiujdQaETBDJc5S/hpxswIHPrNYl5V0MHBc7j1k8bFcfrHsN
 YfKmPxF+XHeSdsCreEuclBKw9+aMPHDw5Ra+ZZ2Tulb2R3vkE99gZ4/Q7PRnoQyawx1VTEtAo
 2rCvgnwCAT2OV5Vpo9FC/725U3lkKeBf94bPDxBRVKu9MstOrsoYq6bq5B7Pj5jueVbfuVaxB
 ZcjGX+FHEe0zd7C6L6+BHTd3CSN9sxyxdvtyCUer9VUZtXFSJ+a5EglK8TKDWi+PWYWsOyvoi
 Yb4Zj6i9Mu8bo6AWG14kVtmLNK3NXnVexl8rZhaI3sENkUq9xFqw3ReufHDges0MPwqnpRsZP
 rmm9dLe6/dvyEf/eCT1jHZAqGyTmwiPSb6qduwO7R27ZAvwcEEWHoHbhvy5UlcYLc+jQ2mxuG
 yXMrYyltm4YFYa2N8tnDzK9o1oF6owN4pTlTOdbShkOXgExaMNJunn0m3Xe15o9KjBhrAO5/p
 WUIJrknVzFnWaKpjcK+JNGJGOfbHtD1kXqDQJZU0OefRigRM63Mu9CiOIsjxC4hy/lCUsv0TA
 utbRb/Tt6NDpokCRS7xgzc+k9vyd19TDvsOU/FiXGKI0ENhWkE26nZtvskSBn0+rUGogMvgz1
 t1oWw1zOoDUlfL+kAs/ztnqzPoiE7r7jX9+SsuLi486xZacBqlydkmjJer7SvvKSh7yyd9fkI
 hlzeA72bO6mTa5sK3mXsW42heleVTe8sMuMhsP9dgKYD+oVjFzaDbdQkp/twBTHS5FcvU98Cj
 nGhg3MtXK12sY8rCy2NgYxzoulW/0snpuJ/xQD8/gU/nBXsVduUglEqRVDPZO2l9XwGG7tXcT
 d8NRx/zGRhhrS3AvMS+iXqSH57WvGx0j
X-Rspamd-Queue-Id: 4414050BBAB
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
	TAGGED_FROM(0.00)[bounces-286586-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[schippers-hamm.de:mid,schippers-hamm.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/11/26 10:11, Jesper Dangaard Brouer wrote:
>=20
>=20
> On 10/05/2026 17.56, Jakub Kicinski wrote:
>> On Sat, 9 May 2026 11:09:51 +0200 Jesper Dangaard Brouer wrote:
>>> On 09/05/2026 04.06, Jakub Kicinski wrote:
>>>> On Thu, 7 May 2026 21:09:09 +0200 Jesper Dangaard Brouer wrote:
>>>>> Not against being able to modify VETH_RING_SIZE, but I don't think i=
t is
>>>>> the solution here.
>>>>
>>>> Was it evaluated, tho?
>>>>
>>>> It's obviously super easy these days have AI spew no end of complex
>>>> code. So it'd be great to have some solid, ideally production-like
>>>> data to back this all up.
>>>>
>>>> VETH_RING_SIZE seems trivial, ethtool set ringparam
>>>
>>> No, unfortunately we cannot just decrease the VETH_RING_SIZE.
>>
>> To be clear - I said may it configurable with ethtool -G
>> not change the default.
>>
>=20
> Sure, I understand the desire to make VETH_RING_SIZE configurable.
> If doing so we are making Linux network stack harder to tune and setup
> correctly. E.g. adding a qdisc to veth would also require changing the
> ring size, but if system also uses XDP then tuning below 64 (likely 128)
> will lead to hard-to-find packet drops.

I mean 64 still could be a 4x improvement at least.

>=20
> I prefer adding something (like BQL) that auto-tune how much of the ring
> queue we are using.  Good queues function as shock absorbers when
> concurrent processes in the OS have scheduling noise.
>=20
> I acknowledge that Simon Schippers found that the BQL implementation was
> actually not auto-tuning.  We need to work on this, my prototype
> implementation [1] [2] works surprisingly well.
>=20
>=20
> - [1] https://lore.kernel.org/all/3e43117f-356d-4086-a176-abd7fe2e6f0a@k=
ernel.org/2-09-veth-time-based-bql-coalescing.patch
> - [2] https://lore.kernel.org/all/3e43117f-356d-4086-a176-abd7fe2e6f0a@k=
ernel.org/
>=20
>=20
>>> The reason is that XDP-redirect into veth don't have any
>>> back-pressure and would simply drop packets if queue size becomes
>>> less than the NAPI budget (64). (Yes, we use both normal path and
>>> XDP-redirect in production).
>>
>> Doesn't this mean you have a queue which is not under BQL control?
>>
>=20
> It is a matter of perspective. BQL needs between 17-55 elements in the
> 256 queue.  At the same time we handle if the ring runs full, e.g. due
> to a sudden burst of XDP redirected packets, which pushes packets into
> the qdisc layer.

You are checking inflight/limit in /sys directory to get the 17-55
number, right?

I think those elements are not really in the queue.

As written before:
The weird thing in this implementation is that is that BQL's inflight
!=3D number of packets in the ring and BQL's limit !=3D "current ring size=
".
Instead the BQL limit describes the number of maximal allowed packets
between calls of netdev_sent_queue().
And in our case here we do not complete (in our case forward) the
packets when calling netdev_sent_queue() but instead immediately and
therefore they are not in the queue anymore when netdev_sent_queue() is
called.

Also that means that the number strongly depends on the
VETH_BQL_COAL_TX_USECS parameter.
For a fixed PPS the limit should be approx.:

Limit =3D VETH_BQL_COAL_TX_USECS * PPS

Assuming the default 10us coal and a fixed 1 MPPS:

Limit =3D 0.00001s * 1_000_000 =3D 10 packet

Can you follow my theory?

Judging from that I personally think VETH_BQL_COAL_TX_USECS needs to
bigger. More like 100us/1ms. With 10us the bql limit gets adjusted
very often I think..

Thanks.

>=20
>=20
>>> My benchmarking shows that an optimal BQL limit is dynamically
>>> adjusted between 17-55 depending on veth consumer namespace
>>> overhead/speed, when balancing throughput and latency.
>>
>> Testing with prod-approximating traffic pattern and load would be great=
.
>=20
> That is what I'm doing.  I'm testing with prod-approximating traffic
> pattern and changing the number of iptables rules to simulate the
> overhead I measured from production.  I think I explained this in the
> cover letter. We are going to use this in a production environment (to
> be clear).
>=20
> Simon found an issue testing the overload scenario.
>=20
> --Jesper
>=20

