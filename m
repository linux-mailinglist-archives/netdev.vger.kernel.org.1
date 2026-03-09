Return-Path: <netdev+bounces-265555-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJplAtzOrmnEIwIAu9opvQ
	(envelope-from <netdev+bounces-265555-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 14:45:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F473239EDA
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 14:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2FE430158B0
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 13:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F91E3BFE5E;
	Mon,  9 Mar 2026 13:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ChsA1u7/"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBA038BF87;
	Mon,  9 Mar 2026 13:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773063848; cv=none; b=umG/gcPKgPKLqy70jgAU3/uw4fLiW5I1R7VU5WTsaep5wxOgGNWC5tMmpMbnJkLMpZ/kcUbRcxUHsBfnOOMm4hcXP6fp0gc0OdsRNjWhnyz2MGPF1UGPg2k6pQ2PakLLLpRVi00/bd9vezfLPtA/s8ghkVD5+YSPwJ9jxTouYfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773063848; c=relaxed/simple;
	bh=5kJQogRZBW3Er5b0nNBRNiUdi359L4TCi+FN2N+XQTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cogPrK9KC7mvUj3MoOEtX4ex9YaWim8LIJh6mAyRHTOqcFNNWdt1Ec/1vC32E7caB3ypOqW+mJYzMreCWa9+pc59OQwjTgoFIcuj+6MC3viLOFs4v1MLV/6PiN4V1U5ej6M1rUXOkQVvd20QQjCn6f8rL29b/KtTbIpdz6D4u8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ChsA1u7/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kFLbOMw//S4QUuAdZUf1MLolkl75tvPL0uBSQam12vs=; b=ChsA1u7/t8pUpXioGIjYHkAuPL
	gR5iXJ9hBUHGmikLiDQOwbq+Q3DfYNx0dhGrutfMG1Nd4K8u+6mCTOPx/QuppTIxv9hSMMCvxKaG2
	vz8YBq+ObVoVR6O1vTSKAtv0hRPcz4irv+t1mKdhtWf7msB9jp7HRtWNHiZNXm8apeYrmf/DcYgod
	wwl23L0qspalSpWJyxyWITPw3STLJ99fijRlbFAVAaSj9GImxYL+vmNXVdOyz94DaKy4SUOwg/kMd
	St2WTmsOr6BbmjsGLA8eYhtJ27Osu3Jsg4K9i7qDNW9FSBDhx/pR0GjlJJnMNZSrYYrBGfpvGA6p4
	rqqRhGtQ==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzatu-00000005bV0-0JfA;
	Mon, 09 Mar 2026 13:44:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D8B5F300FB6; Mon, 09 Mar 2026 14:43:55 +0100 (CET)
Date: Mon, 9 Mar 2026 14:43:55 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Elver <elver@google.com>
Subject: Re: [PATCH] locking/local_lock: Reduce local_[un]lock_nested_bh()
 overhead
Message-ID: <20260309134355.GC606826@noisy.programming.kicks-ass.net>
References: <20260309122055.1226507-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309122055.1226507-1-edumazet@google.com>
X-Rspamd-Queue-Id: 6F473239EDA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linutronix.de,vger.kernel.org,gmail.com,kernel.org,redhat.com,google.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	TAGGED_FROM(0.00)[bounces-265555-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,noisy.programming.kicks-ass.net:mid,infradead.org:dkim]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 12:20:55PM +0000, Eric Dumazet wrote:

> diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
> index b8830148a8591c17c22e36470fbc13ff5c354955..40c2da54a0b720265be7b6327e0922a49befd8fc 100644
> --- a/include/linux/local_lock.h
> +++ b/include/linux/local_lock.h
> @@ -94,12 +94,19 @@ DEFINE_LOCK_GUARD_1(local_lock_irqsave, local_lock_t __percpu,
>  		    local_unlock_irqrestore(_T->lock, _T->flags),
>  		    unsigned long flags)
>  
> +#if defined(WARN_CONTEXT_ANALYSIS) || defined(CONFIG_PREEMPT_RT) || \
> +    defined(CONFIG_DEBUG_LOCK_ALLOC)
>  #define local_lock_nested_bh(_lock)				\
>  	__local_lock_nested_bh(__this_cpu_local_lock(_lock))
>  
>  #define local_unlock_nested_bh(_lock)				\
>  	__local_unlock_nested_bh(__this_cpu_local_lock(_lock))
>  
> +#else
> +static inline void local_lock_nested_bh(local_lock_t *_lock) {}
> +static inline void local_unlock_nested_bh(local_lock_t *__lock) {}
> +#endif

This isn't going to work; WARN_CONTEXT_ANALYSIS is unconditional on
clang >= 22.1

How come that this isn't DCEd properly?

