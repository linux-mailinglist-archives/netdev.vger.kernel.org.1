Return-Path: <netdev+bounces-282736-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAsCHEIm82mZxgEAu9opvQ
	(envelope-from <netdev+bounces-282736-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 11:52:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D094A0369
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 11:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91F2830078BD
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 09:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF353FFAA0;
	Thu, 30 Apr 2026 09:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="aH0YYmPC"
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7823F3AE19C
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 09:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777542349; cv=none; b=eaiwQUVVVG0zeLWqBV3RJb/7aw6BPYw7ynLL7R2FnyABz7xEMF+dqCAc0r7yfvzxSJJ9AZ0ePTvs3BX7dvrLmY7ZQlrQmequ02cSERUGWpU7pPF6jWqFn5EwimkswpHK0YoF04M60P/ydi1P6jgjPiv4pIagvtdwHDnkA3VeYrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777542349; c=relaxed/simple;
	bh=QDslXe+wxXz5Sle2ZLJzuC1bnySYRgtXv3okkVLqu5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U+hMABiYcOFt6IWXMQ4EoOHYlcVxqY2Kvkdfvps/Ssd1wjAhoqC4tCeYy4SEYpybk90WCFZbMsNzjEg+ZxK+bHntDrqA+37h8UiaRZEmPaFuh/UanGEv7ZSuFLaQBWOOSq9Igo7obqckdoxSkPXBJf0xRJng8Kowp8wy2aBg38E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=aH0YYmPC; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1777542327;
	bh=QDslXe+wxXz5Sle2ZLJzuC1bnySYRgtXv3okkVLqu5g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=aH0YYmPCsnknvGmIaOKTwAjqO0F8P7l7dCNyLzCUAqStulfZVer3U3XddZnaItI7h
	 ZUqkhDpQkZ60eyKO1LfKRseletXxRX3PJcEF3BwM4ao6wwn1aXlplcpH9qBnuXcnEm
	 0KqX+FT7s5siIV3fu3zCpVnO1gy8qgieNw9abaw4=
Received: from [129.217.186.229] ([129.217.186.229])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.18.2/8.18.2) with ESMTPSA id 63U9jEZE021677
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 11:45:15 +0200 (CEST)
Message-ID: <7bc8edc9-1b46-471a-9a6e-cd2c27aebcfc@tu-dortmund.de>
Date: Thu, 30 Apr 2026 11:45:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/5] selftests: net: add veth BQL stress test
To: =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
        hawk@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        horms@kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
        kernel-team@cloudflare.com, kuba@kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com
References: <20260324174719.1224337-7-hawk@kernel.org>
 <02a713ac-f794-416f-9d69-95ea98d515b6@tu-dortmund.de>
 <1c435d90-8d08-4ac1-8b84-cc72c0b4e30f@tu-berlin.de>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <1c435d90-8d08-4ac1-8b84-cc72c0b4e30f@tu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 35D094A0369
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tu-dortmund.de,none];
	R_DKIM_ALLOW(-0.20)[tu-dortmund.de:s=unimail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282736-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tu-dortmund.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tu-dortmund.de:dkim,tu-dortmund.de:mid]

On 4/30/26 11:17, Jonas Köppeler wrote:
> On 3/28/26 4:19 PM, Simon Schippers wrote:
>> Hi, thanks for your work! I am really interested in this patchset.
>>
>> I am planning to submit a similar patch set (see [1]) for the tun/tap
>> driver, where I am currently implementing qdisc backpressure similar
>> to that used in veth.
>>
>> Can you run pktgen [2] to see if there is a regression?
>> I think that there might be a slowdown due to BQL not choosing a big
>> enough queue size.
> I ran some tests using pktgen by replacing the trafficgen from the
> selftest with samples/pktgen/pktgen_sample01_simple.sh (Patch v3)
> and used --nrules 0. In general the throughput is quite similar:
> 
> BQL disabled (using --bql-disable):
>   2378694pps 1141Mb/sec (1141773120bps) errors: 0
>   2400898pps 1152Mb/sec (1152431040bps) errors: 0
>   2358125pps 1131Mb/sec (1131900000bps) errors: 0
>   2402034pps 1152Mb/sec (1152976320bps) errors: 0
>   2362061pps 1133Mb/sec (1133789280bps) errors: 0
>   2416301pps 1159Mb/sec (1159824480bps) errors: 0
>   2398496pps 1151Mb/sec (1151278080bps) errors: 0
>   2415200pps 1159Mb/sec (1159296000bps) errors: 0
>   2375921pps 1140Mb/sec (1140442080bps) errors: 0
>   2427419pps 1165Mb/sec (1165161120bps) errors: 0
>   2382461pps 1143Mb/sec (1143581280bps) errors: 0
> 
>   mean: 2392510pps
> 
> BQL enabled:
>   2159545pps 1036Mb/sec (1036581600bps) errors: 0
>   2321899pps 1114Mb/sec (1114511520bps) errors: 0
>   2477853pps 1189Mb/sec (1189369440bps) errors: 0
>   2447857pps 1174Mb/sec (1174971360bps) errors: 0
>   2400284pps 1152Mb/sec (1152136320bps) errors: 0
>   2442841pps 1172Mb/sec (1172563680bps) errors: 0
>   2442540pps 1172Mb/sec (1172419200bps) errors: 0
>   2410585pps 1157Mb/sec (1157080800bps) errors: 0
>   2395902pps 1150Mb/sec (1150032960bps) errors: 0
>   2393260pps 1148Mb/sec (1148764800bps) errors: 0
>   2401959pps 1152Mb/sec (1152940320bps) errors: 0
> 
>   mean: 2390411pps
> 
> BQL enabled is ~2099pps (~0.09%) lower than BQL disabled.

Sounds great!

One more thing:
Could you check what BQL limit settles during the test run using
something like:

watch -n 0.1 'cat /sys/class/net/XXXXX/queues/tx-0/byte_queue_limits/limit'

I guess it will just choose the ptr_ring size as limit in this case,
but it would be nice if you could briefly verify this :)

Thanks!

> 
>> Thanks!
>>
>> [1] Link:https://lore.kernel.org/all/20260312130639.138988-1-simon.schippers@tu-dortmund.de/
>> [2] Link:https://www.kernel.org/doc/html/latest/networking/pktgen.html

