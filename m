Return-Path: <netdev+bounces-252040-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOwAI38/cWnKfQAAu9opvQ
	(envelope-from <netdev+bounces-252040-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 22:05:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 671045DC66
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 22:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8169836A14C
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 19:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAD53ACA7A;
	Wed, 21 Jan 2026 19:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2YdqJFD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F5D399A48;
	Wed, 21 Jan 2026 19:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769022816; cv=none; b=tiz0xXhbtdM5Vk8wJS3jsi7NiYCLxgcdrVed2SM4gc+SYpkkkJboGvqYy3QTH7lfVyDW6fMmU7YkHFuCWUIuoMMG/sLr9d47f8Nvhmq65P9OmfQjHoH99BF7iC4NQVABSLpBsLtDYu67Qol8skCKpRFIdk7I2ObOq5O2mJ93LN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769022816; c=relaxed/simple;
	bh=frjdgFHf9a79mI7D3cY4adbV50gFplryV6+N2KLJSm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cAtpp+eShpmhQEZgxMIe9a979XrYFyuYky3YmxcqjrnrRZjeEhqJT3KdMpd/mIzpATmv95AkUPiVH8wS7ygSo7bmnwambn4RRZ4M8wUJSanB0nFt0WiFy12+jpXHt8q6xqFurhzgnocQ4y1vHzyPT9eg5i+kuK1WzKxjJb+Syzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2YdqJFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86EA0C19422;
	Wed, 21 Jan 2026 19:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769022815;
	bh=frjdgFHf9a79mI7D3cY4adbV50gFplryV6+N2KLJSm4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X2YdqJFDAcjvY2ZLHHPKqMNVZ9pI2//cnu/sr0DCm9ubZ20cqKxVbMmMjppw1U8Ct
	 nacGz3CiLNBEdi0hl7FnVT82fVeE93J3JqfO7BZT2r6zeUX++YQRZMDuazzBLWp6vX
	 EmgAV8jqZcgRLmEbIOw5uYioW4Dc9kH3mIC4G3kHuxgGclDClxDuagT4KczHnl4z/L
	 x/wImFBKYj+TAZDhgfBtiVEJqir61rfq2xuGNQTZa8pZvrvrWmGQ9Pl280E/6ed7ga
	 XwNb7oojNfTNJX1JMgnVk+HfhcnPU7ekDfPXnNGGB+q+UCyMQWfE9gvsy1NJjN6twJ
	 DjGmJX1L2mUZQ==
Message-ID: <412b91a2-15f3-4a5f-8f1a-249c9d79cb41@kernel.org>
Date: Wed, 21 Jan 2026 20:13:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] net: sched: sfq: add detailed drop reasons
 for monitoring
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 carges@cloudflare.com, kernel-team@cloudflare.com,
 Yan Zhai <yan@cloudflare.com>
References: <176847978787.939583.16722243649193888625.stgit@firesoul>
 <1bbbb306-d497-4143-a714-b126ecc41a06@kernel.org>
 <20260120162616.463c8af1@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20260120162616.463c8af1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,redhat.com,toke.dk,cloudflare.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252040-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 671045DC66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr




On 21/01/2026 01.26, Jakub Kicinski wrote:
> On Fri, 16 Jan 2026 11:40:06 +0100 Jesper Dangaard Brouer wrote:
>> On 15/01/2026 13.23, Jesper Dangaard Brouer wrote:
>>> Add specific drop reasons to SFQ qdisc to improve packet drop observability
>>> and monitoring capabilities. This change replaces generic qdisc_drop()
>>> calls with qdisc_drop_reason() to provide granular metrics about different
>>> drop scenarios in production environments.
>>>
>>> Two new drop reasons are introduced:
>>>
>>> - SKB_DROP_REASON_QDISC_MAXFLOWS: Used when a new flow cannot be created
>>>     because the maximum number of flows (flows parameter) has been
>>>     reached and no free flow slots are available.
>>>
>>> - SKB_DROP_REASON_QDISC_MAXDEPTH: Used when a flow's queue length exceeds
>>>     the per-flow depth limit (depth parameter), triggering either tail drop
>>>     or head drop depending on headdrop configuration.
>>
>> I noticed commit 5765c7f6e317 ("net_sched: sch_fq: add three
>> drop_reason") (Author: Eric Dumazet).
>>
>>    SKB_DROP_REASON_FQ_BAND_LIMIT: Per-band packet limit exceeded
>>    SKB_DROP_REASON_FQ_HORIZON_LIMIT: Packet timestamp too far in future
>>    SKB_DROP_REASON_FQ_FLOW_LIMIT: Per-flow packet limit exceeded
>>
>> Should I/we make SKB_DROP_REASON_QDISC_MAXDEPTH specific for SFQ ?
>> Like naming it = SKB_DROP_REASON_SFQ_MAXDEPTH ?
> 
> FWIW FLOW_LIMIT is more intuitive to me, but I'm mostly dealing with
> fq so probably because that's the param name there.
> 
> I'd prefer the reuse (just MAXDEPTH, I don't see equivalent of
> MAXFLOWS?). We assign multiple names the same values in the enum to
> avoid breaking FQ users.

I've taken a detailed look at how we consume this in production and what
Prometheus metrics that we generate. My conclusion is that, we want to
keep the Eric's approach of having qdisc specific drop-reason (that
relates to qdisc tunables), but extend this with a prefix
"SKB_DROP_REASON_QDISC_xxx". This is what I implemented in [v2] like
"SKB_DROP_REASON_QDISC_SFQ_MAXFLOWS".  The QDISC_ prefix enables pattern
matching for qdisc-related drops allowing monitoring tools to match this
for categorizing new/future drop reasons into same qdisc category.

For Prometheus drop_reason metrics the decision was to omit the
net_device label to keep the metric counts manageable and avoid
exploding the number of time series (lower cardinality, less storage).
Without qdisc-specific names in the enum, we'd be forced to add back the
net_device label, which would explode our time series count.

The FQ flow_limit and SFQ depth parameters have different semantics: FQ
uses exact flow classification while SFQ uses stochastic hashing. They
also have different defaults (FQ: 100 packets, SFQ: 127 packets). Having
the same drop_reason for both would obscure which qdisc's tunable needs
adjustment when analyzing production drops.

Having more enum numbers for drop reasons is essentially free, while
keeping metrics per net_device is expensive in terms of storage and
query performance.

--Jesper

[v2] 
https://lore.kernel.org/all/176885213069.1172320.14270453855073120526.stgit@firesoul/




