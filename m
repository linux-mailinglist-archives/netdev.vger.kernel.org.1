Return-Path: <netdev+bounces-283290-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPPxMb8P9WnIHwIAu9opvQ
	(envelope-from <netdev+bounces-283290-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 22:40:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C924AF8C8
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 22:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE65730151D6
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 20:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA3A421F1C;
	Fri,  1 May 2026 20:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="aPaEvqZV"
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0358B311958
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 20:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777667781; cv=none; b=GTGurbPSVqrI3+4gl7Eq7lvq2IVNc6R/FWREHdUekWTr6Zone2Wfmfo75Hd08Va+dQA4iThdgbodmziOt+bxPYPSJrqn/Y7oTEL8/fYOLR66iljTn+YYZRKKgo5Brrwfyi40fEBDDXz5utZc8avDCAHV01Hwk1kczk38OSJJWDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777667781; c=relaxed/simple;
	bh=T0lzHt3k2SflcgeBXqnPgMQIkF6Lsb5wQUoirQMnWHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D+/ed+55gXveI68BtgSfiu+/Joh/gGOVazrQI62RPe/n0ohR1BvpfsUbj91u/wR7ibxU9MU0bZlfWxhr7J7FZkPk9UYO+bA3vG8xfA6xUAKzNRMrJSFOb+KMoKrIWYR5Ua5BCrF+x2jDt36hjxWL30A4dBQQ/Av8mSKHPn9feW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=aPaEvqZV; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1777667758;
	bh=T0lzHt3k2SflcgeBXqnPgMQIkF6Lsb5wQUoirQMnWHg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=aPaEvqZVKZCgGHV3/UOG3BOYQUnLYioUmoy6S8NZVzTEp2ZvdRxNTogS5rF+ub4jL
	 o5ViRGlCg2BIJGmrtXZjm0ktziizzT2TXgi7K/p0WQJJrtLE2T82+BHqdoFH3zDOAE
	 c0wIRj1edUWsP9M0x7K8dKRiCFnAVBKsC6XHlGUY=
Received: from [IPV6:2a01:599:222:5292:7ab9:9848:5d84:7612] (tmo-072-87.customers.d1-online.com [80.187.72.87])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.18.2/8.18.2) with ESMTPSA id 641KZt8c005866
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 1 May 2026 22:35:55 +0200 (CEST)
Message-ID: <e8cdba04-aa9a-45c6-9807-8274b62920df@tu-dortmund.de>
Date: Fri, 1 May 2026 22:35:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/5] selftests: net: add veth BQL stress test
To: =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
        Jesper Dangaard Brouer <hawk@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        horms@kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
        kernel-team@cloudflare.com, kuba@kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com
References: <20260324174719.1224337-7-hawk@kernel.org>
 <02a713ac-f794-416f-9d69-95ea98d515b6@tu-dortmund.de>
 <1c435d90-8d08-4ac1-8b84-cc72c0b4e30f@tu-berlin.de>
 <7bc8edc9-1b46-471a-9a6e-cd2c27aebcfc@tu-dortmund.de>
 <e599e4e9-3440-4a20-9911-c75edad7850e@kernel.org>
 <a841e7ed-eee0-4069-bd0d-ab043a1509c5@tu-berlin.de>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <a841e7ed-eee0-4069-bd0d-ab043a1509c5@tu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 25C924AF8C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tu-dortmund.de,none];
	R_DKIM_ALLOW(-0.20)[tu-dortmund.de:s=unimail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283290-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tu-dortmund.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 5/1/26 10:43, Jonas Köppeler wrote:
> On 4/30/26 2:31 PM, Jesper Dangaard Brouer wrote:
>>
>>
>> On 30/04/2026 11.45, Simon Schippers wrote:
>>> On 4/30/26 11:17, Jonas Köppeler wrote:
>>>> On 3/28/26 4:19 PM, Simon Schippers wrote:
>>>>> Hi, thanks for your work! I am really interested in this patchset.
>>>>>
>>>>> I am planning to submit a similar patch set (see [1]) for the tun/tap
>>>>> driver, where I am currently implementing qdisc backpressure similar
>>>>> to that used in veth.
>>>>>
>>>>> Can you run pktgen [2] to see if there is a regression?
>>>>> I think that there might be a slowdown due to BQL not choosing a big
>>>>> enough queue size.
>>>> I ran some tests using pktgen by replacing the trafficgen from the
>>>> selftest with samples/pktgen/pktgen_sample01_simple.sh (Patch v3)
>>>> and used --nrules 0. In general the throughput is quite similar:
>>>>
>>>> BQL disabled (using --bql-disable):
>>>>    2378694pps 1141Mb/sec (1141773120bps) errors: 0
>>>>    2400898pps 1152Mb/sec (1152431040bps) errors: 0
>>>>    2358125pps 1131Mb/sec (1131900000bps) errors: 0
>>>>    2402034pps 1152Mb/sec (1152976320bps) errors: 0
>>>>    2362061pps 1133Mb/sec (1133789280bps) errors: 0
>>>>    2416301pps 1159Mb/sec (1159824480bps) errors: 0
>>>>    2398496pps 1151Mb/sec (1151278080bps) errors: 0
>>>>    2415200pps 1159Mb/sec (1159296000bps) errors: 0
>>>>    2375921pps 1140Mb/sec (1140442080bps) errors: 0
>>>>    2427419pps 1165Mb/sec (1165161120bps) errors: 0
>>>>    2382461pps 1143Mb/sec (1143581280bps) errors: 0
>>>>
>>>>    mean: 2392510pps
>>>>
>>>> BQL enabled:
>>>>    2159545pps 1036Mb/sec (1036581600bps) errors: 0
>>>>    2321899pps 1114Mb/sec (1114511520bps) errors: 0
>>>>    2477853pps 1189Mb/sec (1189369440bps) errors: 0
>>>>    2447857pps 1174Mb/sec (1174971360bps) errors: 0
>>>>    2400284pps 1152Mb/sec (1152136320bps) errors: 0
>>>>    2442841pps 1172Mb/sec (1172563680bps) errors: 0
>>>>    2442540pps 1172Mb/sec (1172419200bps) errors: 0
>>>>    2410585pps 1157Mb/sec (1157080800bps) errors: 0
>>>>    2395902pps 1150Mb/sec (1150032960bps) errors: 0
>>>>    2393260pps 1148Mb/sec (1148764800bps) errors: 0
>>>>    2401959pps 1152Mb/sec (1152940320bps) errors: 0
>>>>
>>>>    mean: 2390411pps
>>>>
>>>> BQL enabled is ~2099pps (~0.09%) lower than BQL disabled.
>>>
>>> Sounds great!
>>>
>>> One more thing:
>>> Could you check what BQL limit settles during the test run using
>>> something like:
>>>
>>> watch -n 0.1 'cat /sys/class/net/XXXXX/queues/tx-0/byte_queue_limits/limit'
>>
>> FYI: The selftest already tracks BQL "limit" and "inflight".
>> - Jonas can just report those BQL inflight logs
>>
>> +print_periodic_stats() {
>> +    local elapsed="$1"
>> +
>> +    # BQL stats and watchdog counter
>> +    WD_CNT=$(cat /sys/class/net/${VETH_A}/queues/tx-0/tx_timeout \
>> +        2>/dev/null) || WD_CNT="?"
>> +    if [ -n "$BQL_DIR" ] && [ -d "$BQL_DIR" ]; then
>> +        INFLIGHT=$(cat "$BQL_DIR/inflight" 2>/dev/null || echo "?")
>> +        LIMIT=$(cat "$BQL_DIR/limit" 2>/dev/null || echo "?")
>> +        echo "  [${elapsed}s] BQL inflight=${INFLIGHT} limit=${LIMIT}" \
>> +            "watchdog=${WD_CNT}"
>> +    else
>> +        echo "  [${elapsed}s] watchdog=${WD_CNT} (no BQL sysfs)"
>> +    fi
>>
> Hi, so what I found is that pktgen does not respect
> __QUEUE_STATE_STACK_OFF. So the test data above is invalid, since it
> just sent packets even if the BQL "stopped" the queue. So I patched
> pktgen with the following:
> 
> -       if (unlikely(netif_xmit_frozen_or_drv_stopped(txq))) {
> +       if (unlikely(netif_xmit_frozen_or_stopped(txq))) {
> 
> Test run with --nrules 0
> 
> BQL disabled (using --bql-disable):
> inflight packets is always around 200 packets and throughput
> 2264138pps 1086Mb/sec (1086786240bps)
> 
> BQL enabled:
> inflight packet is always 3 packets (with some exception that
> sometimes its even 0) and throughput is degraded:
> 1813455pps 870Mb/sec (870458400bps)
> limit is 2.
> 
> BQL enabled is roughly 20% worse in throughput.

Good findings.

> 
> Test run with --nrules 3500
> 
> BQL disabled: Inflight ~200, throughput: 27161pps 13Mb/sec
> BQL enabled:  Inflight 3 (limit 2),    throughput: 26085pps 12Mb/sec
> BQL ~4% worse.
> 
> Test run with --nrules 5000
> 
> BQL disabled: Inflight ~200, throughput: 19395pps 9Mb/sec
> BQL enabled:  Inflight 3 (limit 2),    throughput: 20423pps 9Mb/sec
> BQL ~5.3% better.
> 
> So it seems that BQL will always steer to a limit of 2. Could this be
> a result of that we call netdev_tx_completed_queue for every packet?
> 
> Looking at the comment above netdev_tx_completed_queue in
> include/linux/netdevice.h:
> 
>   "Must be called at most once per TX completion round (and not per
>    individual packet), so that BQL can adjust its limits appropriately."
> 
> This is consistent with what Tom Herbert stated in the original BQL
> cover letter [1]:
> 
>   "BQL accounting is in the transmit path for every packet, and the
>    function to recompute the byte limit is run once per transmit
>    completion."

Yes, exactly that will be the problem here.
There must be a periodic transmit completion but there is not.

Adding something like a tasklet for calling netdev_tx_completed_queue()
periodically feels wrong. And veth_tx_timeout() is also not suited
for that. And calling it on ptr_ring_empty() is probably also wrong.

I guess there must be a new "BQL" algorithm just for
software interfaces which considers:
1. Context Switching (bigger ring size better)
2. Cache locality (smaller ring size better)
3. Bufferbloat (time limit in ring?)

I think it is a hard problem.

How about first adding a option to modify the VETH_RING_SIZE?

> 
> [1] https://lwn.net/Articles/469652/
> 
> Jonas
> 
>>> I guess it will just choose the ptr_ring size as limit in this case,
>>> but it would be nice if you could briefly verify this :)
>>>
>>> Thanks!
>>>
>>>>
>>>>> Thanks!
>>>>>
>>>>> [1] Link:https://lore.kernel.org/all/20260312130639.138988-1-simon.schippers@tu-dortmund.de/
>>>>> [2] Link:https://www.kernel.org/doc/html/latest/networking/pktgen.html
>>

