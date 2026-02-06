Return-Path: <netdev+bounces-257613-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIWzCc4Xhmk1JgQAu9opvQ
	(envelope-from <netdev+bounces-257613-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 17:33:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0743610050A
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 17:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CA9873023010
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 16:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346AE328B75;
	Fri,  6 Feb 2026 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kk+dnzRd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XkoqS4ha"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9C52D59E8
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 16:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770395479; cv=none; b=gWfejnHBqyBIyxlR7c6e8ZsXFuV/3+ukmao3NTy9YbXENRL59yqcgKLj03Z6ndHUEv63vm7S2YqlaC3aiIp6r6w6B5Vq/Ed2TmlxVCwfgGh7nGKrX+nk2yzK2kqhuGSqIrGfl6S4gAPzjwDe/TtmWnahyhQMTJHpbfHUeyY3BEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770395479; c=relaxed/simple;
	bh=Kz6VlKLGOivI2j8Zpd0GccMoSZbri7XMc/sAdgFnrdA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qiOeQx+n74zlo4/1Tpb8iF73+5uqAZxWH5IWuwvk1rSYXSMLnllyiA/k17HLEyfA/ZgnbCFCDexDZwYRw4/Ifm1w2Wia/GA9h1pyCszLe3JShxI4UQiRsCTa3wpLVf77qL+nqKqAD0K8k5GUAEHC8HvatV05rx/F7kpT5MeDLVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kk+dnzRd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XkoqS4ha; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770395477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+SJLfwbv+tziNl+CajzkO+HCkJScusVZPIA6PyKKQWs=;
	b=Kk+dnzRdDqlzTdy2429NLkNJEdWmzeN8f+U+uY9YyAGyM+YE+rg1ZQIYKPBA5Qb8I7pGv8
	qNQkZJvHMTCms8U1e8shQ1c3jZfGqg49e9zkRh/N/DnlcGih7I1yaEHr5vFaaZDZAJ6+Kl
	dMDZgOXZJR1ahRc1sFfpDp5etwl0U4c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-4c04KYK7MVOtr8wGAZs2-w-1; Fri, 06 Feb 2026 11:31:12 -0500
X-MC-Unique: 4c04KYK7MVOtr8wGAZs2-w-1
X-Mimecast-MFC-AGG-ID: 4c04KYK7MVOtr8wGAZs2-w_1770395471
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-482eec44485so19370115e9.3
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 08:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770395471; x=1771000271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+SJLfwbv+tziNl+CajzkO+HCkJScusVZPIA6PyKKQWs=;
        b=XkoqS4hae2ubZqwP+LENoeREusddyKTVMTvEcMmHj55tIMVB5qDh90Udgfee4taB0I
         xh1snEAjdYNsWJ1HcLjAl5bHTK+ZZGU2cc1jnO9o+Yb8p9Z4rV8xYOIca0fYs7LFbVWk
         rvrL23qG+/JoVk0MzTCidE9BemEZpDCujXRhZbJJL68q9Rf+2y6ycr0paD4Uy8psXPcF
         m6Kth0/cO/5Q20U8m9CXZG0i3U2EWaniNEnu5Sc51c1Pp0J3j7DNmdWVsqm9egz1zTTd
         I3qXHXu1o8wJO89ZZIjZFuZgu1DkIs2+r7NHRcHMCxlj6TEEGsXBDud9pNv3Ini8KQIA
         oPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770395471; x=1771000271;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+SJLfwbv+tziNl+CajzkO+HCkJScusVZPIA6PyKKQWs=;
        b=Jp4/62Sdoay4RBCQwNMs1m7iPcvBXVa1u0Ae0Y3K9hNWhuTrg7zpjO1wv8/Tk1rhDg
         YsLvFmSD71PTwY+2BbSTcmP1wBEZYEJcP0JrrNxp0kaNnEXzOaNVKPh54YBuNk0Hcme5
         DhV0N3qqKpUJqhnzmy4s1WYoT5aa4dglyOIXX7zOSpkdqs1diw8Hc3JDIFT/KY0e06ub
         kc8WHW4CVJmVLCydJsq0M3gh/omS8ohISLBf+BZmoDHw+d0Djd/upCzhzAY6Yxf6Nc9M
         j1yNQ4SXISElKMxEd/hODe5RxPHl0EUoBtZnikovCP8HXlmKmQuxoUtgkEri5StqEOoV
         08jA==
X-Forwarded-Encrypted: i=1; AJvYcCWDdx0NPNSM5pGHgWsCYRm4tWF0AXgTybwK72bJrTiwEQU9H8zW/m5C3YDXBlWaHxnGtDdYAFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMxIbpxZbfZVxl6+HGn9DyKvKKTV4aObWgKqQ86JrRVHT1DonL
	Na1rvbzGaD5HzXfvLDWRRF3LVqDgvWKQUmpfkpdvfS+WI/fDn2GRHzeNA1usnSpg9OCQTLor9ln
	e4mjX0muj1nnXCzGLCVfC+vWAUESM0M0OWnB6qPOGbhiNQG2x1AOuTYMLbg==
X-Gm-Gg: AZuq6aL+1lGKjqWQNzx+9kf+VF9tdJA42CwItNQ8HhPtpHzw7ZHe+C/Pbwxjr7AoYtZ
	ykOJty2ALEcl9gRJlyGVltAgO1uWOCWz/XjNq6ITc7AmN4VLnYea6Ee/ZF5vyeCeYM6seGmBKTV
	ZHwOPM238xG+WvbX+AhtwfqOfdgoiitXuthvcKEBkgjKLxBe7XqNgEgEqr4eQP6VX4sm3H/LdFL
	GaQcrpj94MvlurKPip20yotL3wLLpFuR/GPgkij+hoeR//sdCxm1lmefvDa/yOc4krPlTAGMb6R
	RNNVhbD25uA3DuZdxYuaKeMbv0zuze5i80tnmie5qru28S66nWS/nzpa83DR1WzkI9WKy0TBxiS
	7A1RogXjOoqjO4MslqEpNi3cLNWhU45gWeLEf
X-Received: by 2002:a05:600c:6209:b0:480:690e:f14a with SMTP id 5b1f17b1804b1-483201ee840mr45285915e9.14.1770395471113;
        Fri, 06 Feb 2026 08:31:11 -0800 (PST)
X-Received: by 2002:a05:600c:6209:b0:480:690e:f14a with SMTP id 5b1f17b1804b1-483201ee840mr45285655e9.14.1770395470671;
        Fri, 06 Feb 2026 08:31:10 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4362974527fsm7668591f8f.31.2026.02.06.08.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 08:31:09 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id BAB954FE2B9; Fri, 06 Feb 2026 17:31:08 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, atenart@redhat.com,
 netdev@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>, Paolo Abeni
 <pabeni@redhat.com>
Cc: bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, horms@kernel.org,
 jiri@resnulli.us, edumazet@google.com, xiyou.wangcong@gmail.com,
 jhs@mojatatu.com, carges@cloudflare.com, kernel-team@cloudflare.com,
 "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next v2 1/6] net: sched: introduce qdisc-specific
 drop reason tracing
In-Reply-To: <26e54152-e576-4292-b6ba-d50cf7cc8aa2@kernel.org>
References: <177032644012.1975497.16411100029657607833.stgit@firesoul>
 <177032649028.1975497.12663177216553780756.stgit@firesoul>
 <87sebez099.fsf@toke.dk> <26e54152-e576-4292-b6ba-d50cf7cc8aa2@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 06 Feb 2026 17:31:08 +0100
Message-ID: <87pl6hzveb.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.13 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.53)[subject];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257613-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,resnulli.us,google.com,gmail.com,mojatatu.com,cloudflare.com,davemloft.net];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,toke.dk:mid];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0743610050A
X-Rspamd-Action: no action

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> On 06/02/2026 10.31, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Jesper Dangaard Brouer <hawk@kernel.org> writes:
>>=20
>>> Create new enum qdisc_drop_reason and trace_qdisc_drop tracepoint
>>> for qdisc layer drop diagnostics with direct qdisc context visibility.
>>>
>>> The new tracepoint includes qdisc handle, parent, kind (name), and
>>> device information. Existing SKB_DROP_REASON_QDISC_DROP is retained
>>> for backwards compatibility via kfree_skb_reason().
>>>
>>> Convert FQ, FQ_CoDel, CoDel, SFB, and pfifo_fast to use the new
>>> infrastructure.
>>>
>>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> [...]
>>> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-cor=
e.h
>>> index a7b7abd66e21..3d8d284e05c8 100644
>>> --- a/include/net/dropreason-core.h
>>> +++ b/include/net/dropreason-core.h
>>> @@ -68,12 +68,6 @@
>>>   	FN(SECURITY_HOOK)		\
>>>   	FN(QDISC_DROP)			\
>>>   	FN(QDISC_BURST_DROP)		\
>>> -	FN(QDISC_OVERLIMIT)		\
>>> -	FN(QDISC_CONGESTED)		\
>>> -	FN(CAKE_FLOOD)			\
>>> -	FN(FQ_BAND_LIMIT)		\
>>> -	FN(FQ_HORIZON_LIMIT)		\
>>> -	FN(FQ_FLOW_LIMIT)		\
>>>   	FN(CPU_BACKLOG)			\
>>>   	FN(XDP)				\
>>>   	FN(TC_INGRESS)			\
>>> @@ -371,8 +365,10 @@ enum skb_drop_reason {
>>>   	/** @SKB_DROP_REASON_SECURITY_HOOK: dropped due to security HOOK */
>>>   	SKB_DROP_REASON_SECURITY_HOOK,
>>>   	/**
>>> -	 * @SKB_DROP_REASON_QDISC_DROP: dropped by qdisc when packet outputti=
ng (
>>> -	 * failed to enqueue to current qdisc)
>>> +	 * @SKB_DROP_REASON_QDISC_DROP: dropped by qdisc during enqueue or
>>> +	 * dequeue. More specific drop reasons are available via the
>>> +	 * qdisc:qdisc_drop tracepoint, which also provides qdisc handle
>>> +	 * and name for identifying the source.
>>=20
>> IIUC, this is not needed, see below:
>>=20
>> [...]
>>=20
>>> @@ -37,6 +37,24 @@
>>>   const struct Qdisc_ops *default_qdisc_ops =3D &pfifo_fast_ops;
>>>   EXPORT_SYMBOL(default_qdisc_ops);
>>>=20=20=20
>>> +void tcf_kfree_skb_list(struct sk_buff *skb, struct Qdisc *q,
>>> +			struct netdev_queue *txq,
>>> +			struct net_device *dev)
>>> +{
>>> +	while (unlikely(skb)) {
>>> +		struct sk_buff *next =3D skb->next;
>>> +		enum qdisc_drop_reason reason =3D tcf_get_qdisc_drop_reason(skb);
>>> +
>>> +		prefetch(next);
>>> +		/* Catch wrong enum: skb_drop_reason vs qdisc_drop_reason */
>>> +		WARN_ON_ONCE(reason && reason < __QDISC_DROP_REASON);
>>> +		trace_qdisc_drop(q, txq, dev, skb, reason);
>>> +		kfree_skb_reason(skb, SKB_DROP_REASON_QDISC_DROP);
>>=20
>> AFAIU, the idea here is that you just pass the same 'reason' value to
>> kfree_skb_reason(). Because of the subsys shift and offset, these will
>> all be unique values, so anyone just watching the old tracepoint will
>> get QDISC_DROP_* reasons with no context, and if you want the context
>> you listen to the qdisc_drop tracepoint.
>
> I'm already changing this code in V3, as syzbot revealed that some
> existing skb_drop_reason's do arrive here, which is the TC filter drop
> reasons (SKB_DROP_REASON_TC_*).  We primarily need subsys encoding as
> we share the SKB->cb area.
>
> This is the new code, that pass 'reason' through:
>
>   /* TC classifier and qdisc share drop_reason storage.
>    * Check subsystem mask to identify qdisc drop reasons,
>    * else pass through skb_drop_reason set by TC classifier.
>    */
>   if ((reason & SKB_DROP_REASON_SUBSYS_MASK) =3D=3D __QDISC_DROP_REASON) {
>   	trace_qdisc_drop(q, txq, dev, skb, reason);
>   	skb_reason =3D SKB_DROP_REASON_QDISC_DROP;
>   } else {
>   	skb_reason =3D (enum skb_drop_reason)reason;
>   }
>   kfree_skb_reason(skb, skb_reason);
>
> I do realize that the reason is now a unique value, that in principle
> could be passed through, *BUT* that will break existing userspace
> tools.  E.g. the `perf trace -e skb:kfree_skb` cannot decode these to
> strings. (The net/core/drop_monitor.c also need special handling.)

Ah, that's a bit unfortunate. I assumed the tools would handle these
correctly automatically :(

> I actually want to give userspace a *single* SKB_DROP_REASON_QDISC_DROP
> reason (that existing tools already knows).
>
> Leaking extra qdisc drop reasons is not helpful to consume as it is not
> actionable without knowing the qdisc. A QDISC_DROP_OVERLIMIT from FQ is
> very different from one in CAKE - knowing just the reason without the
> qdisc type/config is insufficient for debugging. The trace_qdisc_drop
> tracepoint provides both the reason AND the qdisc context together

Depends; if you only have one of those installed on your system it'll do
just fine :)

In any case we're changing things here (removing reasons, or changing
them). I would lean towards having more information available (i.e.,
passing through the reason), but if common tools can't decode them,
that's a bit of a bummer.

I suppose it'll be too much churn to start out with the single reason,
then fix the tools to understand subsystem drop reasons, then change it
again?

-Toke


