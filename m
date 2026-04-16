Return-Path: <netdev+bounces-279070-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGm7JL3x4GkZnwAAu9opvQ
	(envelope-from <netdev+bounces-279070-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 16:27:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AD25240F8DF
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 16:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DEC6530131C9
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 14:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF283DF018;
	Thu, 16 Apr 2026 14:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="D2eODzek"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12B13DEAC1
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 14:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776349612; cv=none; b=S+6Wy6vA+BaCZBiNKOYRYhPz3/QIFN7S+JFXfL+xcx+tCJCQs2q8rUC6jmmeW4mDpn8mb2OAOZOmUdqnKkgumC+JFxRFxaVNvj9cx/2ziH5qNK7DkA9rwH5Ozja3ktXTJwYYBX5nXrUiBgnAJF9ECwB4cC0yacSnNxu6JnxOaQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776349612; c=relaxed/simple;
	bh=+ihRt159uDvL5POKuTFYrUQrN+nOHKn/wmFeBTjQ8PU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=U++r36uICTSxfbOT1TKpRSmZxTGbF6+9E7stvyxAok7rEJqY9lwoYuXLLdtqJIuvC4OrLyFtUJSPgSCrMxwkZjRgO0hq0uy+hGYp7JCS7MbiVOFMIhOtswCgLtSt5H22njgWus30J6QdAQ9qQbbOfnja/0gb8sueMJn3cdSWKVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=D2eODzek; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2e221a71e19so530975eec.0
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 07:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1776349609; x=1776954409; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8v+obRShzSvZ2yzdjqq0ScZzC9F5RXeUMbtvLHvstk=;
        b=D2eODzek1m1dEqfD7qSAVgbyTV+MyOeLxa5HQR5esESnXiSr3tAPBRP+1pXqxcNBwy
         WmUQaxK4XbLTDtJP75r7ctiHgPlDfX1ZnHTWKfD27gQ3rAOAXl7TC51koVwj1kkDEw/B
         Qvip0lt6QQdRh5ro09uoMppnelNjmG8e+iebEkp5k8LsVGgbiS2lcp48szOyc/9BBgm2
         ZH4+Yn/9D1L9/mgaGa3CBq+gEHd2+ww7WpvrPeskR7sq3wQZD/nBKh4MxX1nq+znKE+C
         1as70PB0roi4Cfv1FHvrjKt9LXzHflGHKmJqOcKmgH6ThvnYuQPQkGo1ipKdkEtWKyBQ
         sLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776349609; x=1776954409;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B8v+obRShzSvZ2yzdjqq0ScZzC9F5RXeUMbtvLHvstk=;
        b=ZD06RfLSnh9FTK3fqGmoXir9hUsKjqLAB3by2N/CRNdsx+1f4C05bxpYT0P8VJX4jP
         Yq6CNqP/2EGzZCFZzkfFWK6wPXNX28LwOy5Lxo59x7dYtQk2M/ncXOl8yj4+T2BHij7z
         y0GoA0V7yu0mb2R6hzu/TT4HMl4mWaIG4EsE1A1rbYl3QdTxvbOsj43DfuZ3uP7HOZPm
         Od2/to7jTQmZ+S01ZkY7ye7RqUcl8ExqZySn2m8DieX+s1pIXVFw07Q+ZMYQxYISaV1P
         Kqc6sd3AYyxpmgUd1DHaraZnG8Mn5NPULhciDeN6G2P6gpsSowikDq2NBUjjOZWgcz3R
         2iMw==
X-Forwarded-Encrypted: i=1; AFNElJ+eCqwjtSK9VPixdmzFYytBQBUmZx3BpaJ5gJlWt/dsOUhOerRpXFNMv06SQ8ba8KZss08yWck=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEmgUAqgQ2lDQgE4TzYSP9VKkZr4FxtPTci2Q/LshkA2NgynNg
	IB7wUBBvybaAOWxf34neklO3rh4MfoFeaD9+h/FhsOLzL/IMtj4DUXPNwlTKLDZ6XA==
X-Gm-Gg: AeBDietPtT3C+7m6ZhrvR90Ix6NLU37ZgtUaEBEGYKzPI7G/6Pl9zr1swv0vFD48RPi
	wZs6p1p/TymVTuXfon8A0wcLySTF/g8m4fSzWj3j8/mWdAc3A3+pncclTlUE/tq7p4beVVgQqME
	1fCGZzYcarepZNsz9FTCq5rHmv5TXZisd24i83XZ/894Po+AJAWD0SK+WpiC4fnRzKhRwC7uo6v
	/vti6MMUm4vbTeX/3bhOGMV09PbHkS0wcJ84e7r+9/BuKCdUjFv9hgq/+1XSv8nRewUIvXUL4Nh
	0CYV6giofqAPFbWsxP6TYU8PoNfLXXmsark21u24Ke+reWFTn7t1UGD1Dxe2LeftVs/rOiG04mf
	V+aJ7ZJu7UwQAeCJBnqKiY62A03L9AsmN1hHvQwT/4CUlOECEECGa4timhZ7AFwDI3aBADDXgJD
	4oCj61iRbmGn68hcLo1gjRctzTYaYPSWUufA==
X-Received: by 2002:a05:7301:1691:b0:2e1:e5c0:7992 with SMTP id 5a478bee46e88-2e1e5c07da4mr1262505eec.8.1776349608900;
        Thu, 16 Apr 2026 07:26:48 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c54:4d67::1c9d? ([2804:14d:5c54:4d67::1c9d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8f569f4bsm7303516eec.21.2026.04.16.07.26.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 07:26:48 -0700 (PDT)
Message-ID: <8070149c-87c8-4d9c-ae12-6b9a956fb763@mojatatu.com>
Date: Thu, 16 Apr 2026 11:26:38 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Victor Nogueira <victor@mojatatu.com>
Subject: Re: [PATCH v1 net 1/1] net/sched: sch_dualpi2: fix limit/memlimit
 enforcement when dequeueing L-queue
To: chia-yu.chang@nokia-bell-labs.com, linux-hardening@vger.kernel.org,
 kees@kernel.org, gustavoars@kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 horms@kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
References: <20260413163711.56191-1-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
In-Reply-To: <20260413163711.56191-1-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279070-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[nokia-bell-labs.com,vger.kernel.org,kernel.org,mojatatu.com,resnulli.us,davemloft.net,google.com,redhat.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DMARC_NA(0.00)[mojatatu.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mojatatu.com:mid]
X-Rspamd-Queue-Id: AD25240F8DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 13/04/2026 13:37, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Fix dualpi2_change() to correctly enforce updated limit and memlimit values
> after a configuration change of the dualpi2 qdisc.
> 
> Before this patch, dualpi2_change() always attempted to dequeue packets via
> the root qdisc (C-queue) when reducing backlog or memory usage, and
> unconditionally assumed that a valid skb will be returned. When traffic
> classification results in packets being queued in the L-queue while the
> C-queue is empty, this leads to a NULL skb dereference during limit or
> memlimit enforcement.
> 
> This is fixed by first dequeuing from the C-queue path if it is non-empty.
> Once the C-queue is empty, packets are dequeued directly from the L-queue.s
> Return values from qdisc_dequeue_internal() are checked for both queues. When
> dequeuing from the L-queue, the parent qdisc qlen and backlog counters are
> updated explicitly to keep overall qdisc statistics consistent.
> [...]
> ---
>   net/sched/sch_dualpi2.c | 24 +++++++++++++++++++-----
>   1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
> index 6d7e6389758d..56d4422970b6 100644
> --- a/net/sched/sch_dualpi2.c
> +++ b/net/sched/sch_dualpi2.c
> @@ -872,11 +872,25 @@ static int dualpi2_change(struct Qdisc *sch, struct nlattr *opt,
>   	old_backlog = sch->qstats.backlog;
>   	while (qdisc_qlen(sch) > sch->limit ||
>   	       q->memory_used > q->memory_limit) {
> -		struct sk_buff *skb = qdisc_dequeue_internal(sch, true);
> -
> -		q->memory_used -= skb->truesize;
> -		qdisc_qstats_backlog_dec(sch, skb);
> -		rtnl_qdisc_drop(skb, sch);
> +		int c_len = qdisc_qlen(sch) - qdisc_qlen(q->l_queue);
> +		struct sk_buff *skb = NULL;
> +
> +		if (c_len) {
> +			skb = qdisc_dequeue_internal(sch, true);
> +			if (!skb)
> +				break;
> +			q->memory_used -= skb->truesize;
> +			rtnl_qdisc_drop(skb, sch);
> +		} else if (qdisc_qlen(q->l_queue)) {
> +			skb = qdisc_dequeue_internal(q->l_queue, true);
> +			if (!skb)
> +				break;
> +			q->memory_used -= skb->truesize;
> +			rtnl_qdisc_drop(skb, q->l_queue);
> +			/* Keep the overall qdisc stats consistent */
> +			--sch->q.qlen;
> +			qdisc_qstats_backlog_dec(sch, skb);

Sashiko is hallucinating saying this will cause a UAF, it won't.
However it is good to maintain a consistent order here.
For example, see how sch_choke is doing [1].

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/tree/net/sched/sch_choke.c?id=1f5ffc672165ff851063a5fd044b727ab2517ae3#n394

cheers,
Victor

