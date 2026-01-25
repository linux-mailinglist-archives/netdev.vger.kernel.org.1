Return-Path: <netdev+bounces-253198-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCuRBTx3dmnqQwEAu9opvQ
	(envelope-from <netdev+bounces-253198-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 21:04:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3151F824E3
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 21:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC1C13014C04
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 20:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABD23002B6;
	Sun, 25 Jan 2026 20:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="l+AlK7BD"
X-Original-To: netdev@vger.kernel.org
Received: from mx06lb.world4you.com (mx06lb.world4you.com [81.19.149.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F8F2F0C74
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 20:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769371389; cv=none; b=U/8h0/phRrW9W14678JOdb6lN9/lXFmecpaPCMoxbJoqBH0RQp70dqPwLVwl0zg/ayzhdT15HjPTM6zxYwMBQBhjjevR8U5ArOeG1OpI53T6lE6V4hWXgChXczhqpFqOzycFHXOHbVLM4tY46Ca/L7356/ioL1V2VodfdW2JIcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769371389; c=relaxed/simple;
	bh=RkiXarviRg6mpYmPu0208z/+w4nGINNmHi30Sk+5fEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K96qv7qMDXnwAld9uo3NQlmLRZ68SkTW1+xI8+r/hHwnMqE/oyd0ktOivtgpH1LpfDd3K98E5dOphYTRptK65CMxhkthF4l8EBNeS+pWurRlLWVy62zrz473O/ROghWDckXgwJp10GoKECPMK3+AlSbLTBgYVuTcYBGPfNWUgk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=l+AlK7BD; arc=none smtp.client-ip=81.19.149.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nBDdxQXK2B7Rs6+Zift7NjkUBG5ooCJiDlCkV+4+Ros=; b=l+AlK7BDiR2ZyFbeQ0t3sko5+k
	jqWhimJo2TTR2R/frJQm/TN1KhFsmXRfhUw2Zk7kidV4jjTRjhbYSIS1uBbeKslxC723CS9WTAAdd
	lGZO2fQJeCpEENfVfFXC197/vumEqZiiKPJoajAfFIA1Oc+NKv9TjZYQ8QflSduV8r78=;
Received: from [188.23.33.245] (helo=[10.0.0.160])
	by mx06lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1vk63L-000000000uY-3Ehg;
	Sun, 25 Jan 2026 20:45:45 +0100
Message-ID: <9d21ddb4-5e7d-4dfa-9ee4-ecdf73499f5b@engleder-embedded.com>
Date: Sun, 25 Jan 2026 20:45:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] net: extend ndo_get_tstamp for other
 timestamp types
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Kevin Yang <yyd@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Joshua Washington <joshwash@google.com>,
 Richard Cochran <richardcochran@gmail.com>
References: <20260121160458.990785-1-yyd@google.com>
 <20260121160458.990785-2-yyd@google.com>
 <c5ba02dd-e81f-4590-9e35-90c9b2c33bee@engleder-embedded.com>
 <willemdebruijn.kernel.13b62cc180aaa@gmail.com>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <willemdebruijn.kernel.13b62cc180aaa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[engleder-embedded.com:s=dkim11];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[engleder-embedded.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253198-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,google.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[engleder-embedded.com:-];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gerhard@engleder-embedded.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,lunn.ch,davemloft.net,redhat.com,gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,engleder-embedded.com:mid]
X-Rspamd-Queue-Id: 3151F824E3
X-Rspamd-Action: no action

On 22.01.26 23:28, Willem de Bruijn wrote:
> Gerhard Engleder wrote:
>> On 21.01.26 17:04, Kevin Yang wrote:
>>> Network device hardware timestamps (hwtstamps) and the system's
>>> clock (ktime) often originate from different clock domains.
>>> This makes it hard to directly calculate the duration between
>>> a hardware-timestamped event and a system-time event by simple
>>> subtraction.
>>>
>>> This patch extends ndo_get_tstamp to allow a netdev to provide
>>> a hwtstamp into the system's CLOCK_REALTIME domain. This allows a
>>> driver to either perform a conversion by estimating or, if the
>>> clocks are kept synchronized, return the original timestamp directly.
>>> Other clock domains, e.g. CLOCK_MONOTONIC_RAW can also be added when
>>> a use surfaces.
>>>
>>> This is useful for features that need to measure the delay between
>>> a packet's hardware arrival/departure and a later software event.
>>> For example, the TCP stack can use this to measure precise
>>> packet receive delays, which is a requirement for the upcoming
>>> TCP Swift [1] congestion control algorithm.
>>>
>>> [1] Kumar, Gautam, et al. "Swift: Delay is simple and effective
>>> for congestion control in the datacenter." Proceedings of the
>>> Annual conference of the ACM Special Interest Group on Data
>>> Communication on the applications, technologies, architectures,
>>> and protocols for computer communication. 2020.
>>>
>>> Signed-off-by: Kevin Yang <yyd@google.com>
>>> Reviewed-by: Willem de Bruijn <willemb@google.com>
>>
>> Like Jakub in his reply
>> https://lore.kernel.org/netdev/20260119115710.6fdde8c0@kernel.org/
>> for me also the question why this is a driver implementation came to my
>> mind.
>>
>> With vclocks it is already possible to get timestamps for arbitrary
>> clock domains in parallel. So it is already possible to synchronize
>> the hwtstamp to CLOCK_REALTIME, CLOCK_MONOTONIC, ... in parallel.
>> Therefore, user space synchronisation is needed, but e.g. ptp4l does
>> a much better synchronisation job than your solution.
>>
>> Maybe CLOCK_REALTIME is not supported by ptp4l, because due to daytime
>> saving this clock jumps. IMO these jumps will also be problem for
>> your solution, as it will lead to wrong delays two times a year.
>> So usually CLOCK_TAI or CLOCK_MONOTONIC would be a better choice.
>>
>> To sum up: IMO you suggest a driver specific in-kernel solution where
>> already a driver independent user space solution with higher accuracy
>> exists.
> 
> Definitely a promising alternative.
> 
> With multiple netdevices, a TCP listener socket may receive packets
> from all devices. This would need new infrastructure to lookup the
> correct vclock for a given net_device, cannot hardcode a choice with
> SOF_TIMESTAMPING_BIND_PHC.
> 
> And this needs to happen for every packet, so with minimal overhead.
> 
> Though for established connections the expectation will be that
> packets generally arrive on the same netdevice. Bar infrequent path
> changes such as from sk_rethink_txhash on the peer. So there this
> value can perhaps be cached.
> 
> It would still have to be learned by the kernel, no explicit
> setsockopt.

Maybe it would also be an option, that the kernel learns with which
clock domain the timestamps of the PHC and vclocks correlate. Then
the TCP stack could calculate the delay if it finds a valid e.g.
CLOCK_MONOTONIC timestamp in the packet. This would make the
TCP listener socket independent from the devices. Just an idea, without
thinking about implementation details.

Gerhard


