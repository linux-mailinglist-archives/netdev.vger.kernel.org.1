Return-Path: <netdev+bounces-294684-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kTMpOUznH2p8sAAAu9opvQ
	(envelope-from <netdev+bounces-294684-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:35:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D61635BF3
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:35:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tu-berlin.de header.s=dkim-tub26 header.b=bGLabq9j;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294684-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294684-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=tu-berlin.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F993315A767
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 08:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19564219F8;
	Wed,  3 Jun 2026 08:28:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailrelay.tu-berlin.de (mailrelay.tu-berlin.de [130.149.7.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1D3421F0E;
	Wed,  3 Jun 2026 08:28:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780475301; cv=none; b=jUNGJ25+d5sne6hu/DFpE/qwhAwS/z4coYdaQftcFtWLuqyHB6gVnwl7pAyl6gMap3UzZ2r6p5Ha9geGubZg3qio1kP8vka3kt32TGkxZv88vaTCySWriv7fM167wVU9yBVf4LkilV7eSGolTp+PGDGRRF+OEiUoI74VBxfEEFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780475301; c=relaxed/simple;
	bh=NbiC0nkA2E7pSau2zZGMlE9xqPeX2IqbAUQsvrU6Bdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ak6bfi3M3TimZwdir2OunEu2XgQe7VxfiGnPl0/Q0jv9+YmFuWYTAP/Cm5ha16GZO/AZGOUNrfpb2sdJwjRdA5UndouS8a4phygdJlrB5O5pDu7h9rEzNLijs4kg/sqnC+VfplQ5lm8/p12cz94QX3KSkUXIhTQYIxczCcOO3rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-berlin.de; spf=pass smtp.mailfrom=tu-berlin.de; dkim=pass (2048-bit key) header.d=tu-berlin.de header.i=@tu-berlin.de header.b=bGLabq9j; arc=none smtp.client-ip=130.149.7.70
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed;
  d=tu-berlin.de; s=dkim-tub26; t=1780475297;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kllgp+5e73EpTFd+zeCHCvSfGkA31GpIR6WCqaIcFYU=;
  b=bGLabq9jo/OVRTyO3uXNG8dJaIty5xez12hWtKgkPyrRPph5qfubEPr3
   RSrYa8NoEGM/mbDL5OxXLuSdKfQC/GRZz6pLONX6MDoGVywe7yTNQVzuQ
   Ps0FVMdvY05L+pphcN4jsov1YxBRbxCiK3nFFSAPk/4aRAtj0scXK3hBK
   twOKPWQxTrMhNtw4hV9GVehY5eqSmXbqSTyvoC25BCyhqUZHBoK8/ByO3
   S88Tsk6UftZsiFEMDsXGM23r+yBQdgrMwSzlfZco/TGEwDVj2TYXPZHnH
   FSlhGLKJe3xTJZcXt4aoGjTg7Aoc22cDtDrYdWjZl1YMbdfCrdB3kJPKS
   Q==;
X-CSE-ConnectionGUID: 7lZ8/bCBQd6v7vxaYyTgZw==
X-CSE-MsgGUID: /O3ohytHQYy/kO1DtP16cw==
X-IronPort-AV: E=Sophos;i="6.24,184,1774306800"; 
   d="scan'208";a="48183097"
Received: from bulkmail.tu-berlin.de (HELO mail.tu-berlin.de) ([141.23.12.143])
  by mailrelay.tu-berlin.de with ESMTP; 03 Jun 2026 10:28:09 +0200
Message-ID: <866cd367-5d53-46c3-b2f8-b0989a1d462d@tu-berlin.de>
Date: Wed, 3 Jun 2026 10:28:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 5/5] veth: time-based BQL completion
 coalescing via ethtool tx-usecs
To: Simon Schippers <simon.schippers@tu-dortmund.de>, <hawk@kernel.org>,
	<netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20260527135418.1166665-1-hawk@kernel.org>
 <20260527135418.1166665-6-hawk@kernel.org>
 <2affe9f4-56a7-4482-931f-9d98cfdf09fd@tu-berlin.de>
 <db5b7f7e-135c-40f0-a740-057bc6623e6c@tu-dortmund.de>
 <865f31e5-4e90-4dc0-890f-b5796948b590@tu-berlin.de>
 <55b23925-9676-4005-8c13-ea7001190abb@tu-dortmund.de>
 <e3d28da7-0fe3-4970-865c-9f51346e01fd@tu-berlin.de>
 <53dc682c-f3df-485a-91f6-74212554cd10@tu-dortmund.de>
Content-Language: en-US
From: =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>
Autocrypt: addr=j.koeppeler@tu-berlin.de; keydata=
 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
In-Reply-To: <53dc682c-f3df-485a-91f6-74212554cd10@tu-dortmund.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tu-berlin.de,quarantine];
	R_DKIM_ALLOW(-0.20)[tu-berlin.de:s=dkim-tub26];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294684-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:simon.schippers@tu-dortmund.de,m:hawk@kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[j.koeppeler@tu-berlin.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tu-berlin.de:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.koeppeler@tu-berlin.de,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 43D61635BF3

On 6/2/26 17:37, Simon Schippers wrote:
> On 6/2/26 09:24, Jonas Köppeler wrote:
>> On 6/1/26 6:16 PM, Simon Schippers wrote:
>>
>>> On 6/1/26 16:03, Jonas Köppeler wrote:
>>>> On 6/1/26 2:00 PM, Simon Schippers wrote:
>>>>> On 5/28/26 09:46, Jonas Köppeler wrote:
>>>>>> On 5/27/26 3:54 PM, hawk@kernel.org wrote:
>>>>>>> From: Simon Schippers <simon.schippers@tu-dortmund.de>
>>>>>>>
>>>>>>> Per-packet BQL completion forces DQL to converge on limit=2, causing
>>>>>>> excessive NAPI scheduling overhead and qdisc requeues.
>>>>>>>
>>>>>>> Accumulate BQL completions and flush them when a configurable time
>>>>>>> threshold is exceeded, letting DQL discover a limit that bounds actual
>>>>>>> queuing delay to the configured interval. Coalescing state persists
>>>>>>> across NAPI polls in struct veth_rq so completions can accumulate
>>>>>>> beyond a single budget=64 cycle.
>>>>>>>
>>>>>>> Add ethtool tx-usecs support for runtime tuning. Default is 100 us;
>>>>>>> setting tx-usecs to 0 disables coalescing and falls back to per-packet
>>>>>>> completion.
>>>>>>>
>>>>>>>       ethtool -C <veth-dev> tx-usecs 500  # 500us coalescing
>>>>>>>       ethtool -C <veth-dev> tx-usecs 0    # per-packet (no coalescing)
>>>>>>>
>>>>>>> Co-developed-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>>>>>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>>>>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
>>>>>> Tested-by: Jonas Köppeler<j.koeppeler@tu-berlin.de>
>>>>>>
>>>>> Thanks for your testing!
>>>>>
>>>>> However, I have issues reproducing.
>>>>> I run bare metal (without virtme) with v6 + your pktgen patch
>>>>> and I am on the branch pktgen-and-benchmark, commit
>>>>> "results: add veth-bql measurements":
>>>>>
>>>>> 1. ping fails with 100% packet loss ~20% of the times with --pktgen.
>>>>>       When this happens the avg ping of this run is mistakenly set
>>>>>       to 0.0 ms, which distorts the results.
>>>>>       I fixed it locally by rerunning when this happens.
>>>>>
>>>>> 2. pktgen runs with > 3 Mpps even with --nrules 10000, see log below.
>>>>>       I see that this is because of qdisc drops.
>>>>>       I also tried pfifo and sfq but with the same result.
>>>>>       I spent quite some time on it but I do not know a fix.
>>>>>
>>>>> Do you have an idea?
>>>>> Thanks!
>>>> Hi,
>>>> yes there are some changes missing in the test script.
>>>> I have pushed it now, sorry. This should fix 1.
>>> I pulled it and ran...
>>>
>>> sudo ./veth_bql_sweep.sh --runs 1 --pktgen --duration 20 --qdisc fq_codel --no-bpftrace
>>>
>>> ... but still 8/32=1/4 of the pings are zero, I do not see
>>> a pattern.
>>>
>>>
>>> I grabbed the logs from /tmp and this is what a failing
>>> ping looks like:
>>>
>>> PING 10.99.0.2 (10.99.0.2) 56(84) bytes of data.
>>>
>>> --- 10.99.0.2 ping statistics ---
>>> 97 packets transmitted, 0 received, 100% packet loss, time 19967ms
>>>
>>>
>>> Feels like a race or something..
>>> Can you reproduce with the exact command?
>>> I think you need --runs 1, else it just averages over multiple
>>> runs.
>> Sorry, no I could not reproduce this. I used the exact same
>> command as you did, and I am using net-next/main + v6 patches.
>> I have 0% ping loss across all tests. Does the ping loss
>> happen regardless of the qdisc?
>>
> Yes, it happens for each qdisc I tested.
> As a fix I changed the script to rerun if this happens.

I was able to reproduce it and I think it is because you are lacking
support of the qdiscs, and thus you will fallback to pfifo, this
explains why it occasionally will drop all packets.

>
> With that I ran the benchmark and also created a script to have
> the result as an ASCII table.
> I think it would make sense to include something like this in
> the commit message.
>
> Throughput (pps)
> ==================================================
> nrules |   0us | 100us | 1000us | 10000us || stock
> -------+-------+-------+--------+---------++------
>       0 | 1.65M | 1.75M |  1.74M |   1.74M || 1.73M
>     100 |  684K |  755K |   730K |    728K ||  744K
>    1000 |  119K |  126K |   126K |    125K ||  126K
>   10000 |   13K |   12K |    13K |     13K ||   13K
>
>
> Ping RTT ms (avg)
> ==================================================
> nrules |   0us | 100us | 1000us | 10000us || stock
> -------+-------+-------+--------+---------++------
>       0 | 0.016 | 0.138 |  0.137 |   0.135 || 0.133
>     100 | 0.029 | 0.185 |  0.310 |   0.315 || 0.310
>    1000 | 0.137 | 0.321 |   1.66 |    1.81 ||  1.78
>   10000 |  1.22 |  1.87 |   3.02 |    16.0 ||  17.2

Yes, good idea. I think we should report p99 + max_ping and not the avg.

>
>>>> Regarding 2.: do not look at the pktgen output, in the
>>>> new version you will see something like "goodput",
>>>> which is the number you should look for.
>>>> Pktgen will report at what speed it enqueued packets in
>>>> the qdisc.
>>> Exactly. Now it works. Had a single outlier but apart from that
>>> everything is fine.
>>>
>>> Thanks,
>>> Simon
>>>
>>>> Let me know if it worked.
>>>> Best,
>>>> Jonas
>>>>

