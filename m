Return-Path: <netdev+bounces-257560-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qD2TJ5n3hWnHIgQAu9opvQ
	(envelope-from <netdev+bounces-257560-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 15:15:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02680FEB04
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 15:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44A01303DA93
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 14:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E916F3EF0CE;
	Fri,  6 Feb 2026 14:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtY6Pa4i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C673D3EF0C2;
	Fri,  6 Feb 2026 14:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770387292; cv=none; b=gEOtCWQB9ggTKs2zldX2HrPngnkEiqKBDCJYDnpgidqne8SBs1KX0pjr6b5BSmOsPA1mLO5V9bFPsLG1oYaa6++w3kNavG83oA2P4jKbgcCfuY0LdiN8phW2lGod5gj+UyfdZ6wmKhUrU0PToWLMKiux0/0t6FEViLWk+YzAwOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770387292; c=relaxed/simple;
	bh=sdRRT+SBk1wu0tv1Ig3EjPncHzNUEQZl7cQ0SQTz2lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fMRPbgV2eq5Ev5oU3KsnEoKlnSiPfc+96boAiw37nW6ZGtG/4Cb6JvlUVSv62xwdDmbkcsgxhL0QHn/f6z6ployaw/i8BF8XN2lnDX07Hh2f6WVvW3tcykdhf5joT6qN9Ko3ZJjFN3kGu364rOyLzoizKfd1jOVMM8agyz12KKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtY6Pa4i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95E7C19421;
	Fri,  6 Feb 2026 14:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770387292;
	bh=sdRRT+SBk1wu0tv1Ig3EjPncHzNUEQZl7cQ0SQTz2lk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UtY6Pa4iRbUGTCHrQV1Emxn3dyaUTIVjXT8pyPCe+1uF9XrKZ7DJOjkL/dGlQ3h6b
	 4t5ElPj7bYm/khLMAxOGih8yWLvNmj392O9AesL9M5XOK93gsj79i51rxLtLYiUlxS
	 Zjeet9pEshne7JLqmfwn27hP5D412PRUe26mJAtVOwudywTfepWMfrnYsWSLqlHkeD
	 hQnftOOXrl6u8T7yxMz0HNCpStVxbqy5PWBszfXrs5CnrDaReeB9xY9aylapsvKpWZ
	 18r/EcAXNqyARNdDBxI3o143nXawdJuAJpA576IvMxERafg3KiFiM8DJ9HQLIniEPO
	 rI30+p4m/wNLw==
Message-ID: <26e54152-e576-4292-b6ba-d50cf7cc8aa2@kernel.org>
Date: Fri, 6 Feb 2026 15:14:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/6] net: sched: introduce qdisc-specific drop
 reason tracing
To: atenart@redhat.com, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@redhat.com>, netdev@vger.kernel.org,
 Eric Dumazet <eric.dumazet@gmail.com>, Paolo Abeni <pabeni@redhat.com>
Cc: bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, horms@kernel.org,
 jiri@resnulli.us, edumazet@google.com, xiyou.wangcong@gmail.com,
 jhs@mojatatu.com, carges@cloudflare.com, kernel-team@cloudflare.com,
 "David S. Miller" <davem@davemloft.net>
References: <177032644012.1975497.16411100029657607833.stgit@firesoul>
 <177032649028.1975497.12663177216553780756.stgit@firesoul>
 <87sebez099.fsf@toke.dk>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <87sebez099.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257560-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,resnulli.us,google.com,gmail.com,mojatatu.com,cloudflare.com,davemloft.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 02680FEB04
X-Rspamd-Action: no action



On 06/02/2026 10.31, Toke Høiland-Jørgensen wrote:
> Jesper Dangaard Brouer <hawk@kernel.org> writes:
> 
>> Create new enum qdisc_drop_reason and trace_qdisc_drop tracepoint
>> for qdisc layer drop diagnostics with direct qdisc context visibility.
>>
>> The new tracepoint includes qdisc handle, parent, kind (name), and
>> device information. Existing SKB_DROP_REASON_QDISC_DROP is retained
>> for backwards compatibility via kfree_skb_reason().
>>
>> Convert FQ, FQ_CoDel, CoDel, SFB, and pfifo_fast to use the new
>> infrastructure.
>>
>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
[...]
>> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
>> index a7b7abd66e21..3d8d284e05c8 100644
>> --- a/include/net/dropreason-core.h
>> +++ b/include/net/dropreason-core.h
>> @@ -68,12 +68,6 @@
>>   	FN(SECURITY_HOOK)		\
>>   	FN(QDISC_DROP)			\
>>   	FN(QDISC_BURST_DROP)		\
>> -	FN(QDISC_OVERLIMIT)		\
>> -	FN(QDISC_CONGESTED)		\
>> -	FN(CAKE_FLOOD)			\
>> -	FN(FQ_BAND_LIMIT)		\
>> -	FN(FQ_HORIZON_LIMIT)		\
>> -	FN(FQ_FLOW_LIMIT)		\
>>   	FN(CPU_BACKLOG)			\
>>   	FN(XDP)				\
>>   	FN(TC_INGRESS)			\
>> @@ -371,8 +365,10 @@ enum skb_drop_reason {
>>   	/** @SKB_DROP_REASON_SECURITY_HOOK: dropped due to security HOOK */
>>   	SKB_DROP_REASON_SECURITY_HOOK,
>>   	/**
>> -	 * @SKB_DROP_REASON_QDISC_DROP: dropped by qdisc when packet outputting (
>> -	 * failed to enqueue to current qdisc)
>> +	 * @SKB_DROP_REASON_QDISC_DROP: dropped by qdisc during enqueue or
>> +	 * dequeue. More specific drop reasons are available via the
>> +	 * qdisc:qdisc_drop tracepoint, which also provides qdisc handle
>> +	 * and name for identifying the source.
> 
> IIUC, this is not needed, see below:
> 
> [...]
> 
>> @@ -37,6 +37,24 @@
>>   const struct Qdisc_ops *default_qdisc_ops = &pfifo_fast_ops;
>>   EXPORT_SYMBOL(default_qdisc_ops);
>>   
>> +void tcf_kfree_skb_list(struct sk_buff *skb, struct Qdisc *q,
>> +			struct netdev_queue *txq,
>> +			struct net_device *dev)
>> +{
>> +	while (unlikely(skb)) {
>> +		struct sk_buff *next = skb->next;
>> +		enum qdisc_drop_reason reason = tcf_get_qdisc_drop_reason(skb);
>> +
>> +		prefetch(next);
>> +		/* Catch wrong enum: skb_drop_reason vs qdisc_drop_reason */
>> +		WARN_ON_ONCE(reason && reason < __QDISC_DROP_REASON);
>> +		trace_qdisc_drop(q, txq, dev, skb, reason);
>> +		kfree_skb_reason(skb, SKB_DROP_REASON_QDISC_DROP);
> 
> AFAIU, the idea here is that you just pass the same 'reason' value to
> kfree_skb_reason(). Because of the subsys shift and offset, these will
> all be unique values, so anyone just watching the old tracepoint will
> get QDISC_DROP_* reasons with no context, and if you want the context
> you listen to the qdisc_drop tracepoint.

I'm already changing this code in V3, as syzbot revealed that some
existing skb_drop_reason's do arrive here, which is the TC filter drop
reasons (SKB_DROP_REASON_TC_*).  We primarily need subsys encoding as
we share the SKB->cb area.

This is the new code, that pass 'reason' through:

  /* TC classifier and qdisc share drop_reason storage.
   * Check subsystem mask to identify qdisc drop reasons,
   * else pass through skb_drop_reason set by TC classifier.
   */
  if ((reason & SKB_DROP_REASON_SUBSYS_MASK) == __QDISC_DROP_REASON) {
  	trace_qdisc_drop(q, txq, dev, skb, reason);
  	skb_reason = SKB_DROP_REASON_QDISC_DROP;
  } else {
  	skb_reason = (enum skb_drop_reason)reason;
  }
  kfree_skb_reason(skb, skb_reason);

I do realize that the reason is now a unique value, that in principle
could be passed through, *BUT* that will break existing userspace
tools.  E.g. the `perf trace -e skb:kfree_skb` cannot decode these to
strings. (The net/core/drop_monitor.c also need special handling.)
I actually want to give userspace a *single* SKB_DROP_REASON_QDISC_DROP
reason (that existing tools already knows).

Leaking extra qdisc drop reasons is not helpful to consume as it is not
actionable without knowing the qdisc. A QDISC_DROP_OVERLIMIT from FQ is
very different from one in CAKE - knowing just the reason without the
qdisc type/config is insufficient for debugging. The trace_qdisc_drop
tracepoint provides both the reason AND the qdisc context together

I've talked to our "consumer" tool developers and our plan is to try
attach to new tracepoint, if that is successful we change the existing
SKB_DROP_REASON_QDISC_DROP sampling rate to be zero.


--Jesper

