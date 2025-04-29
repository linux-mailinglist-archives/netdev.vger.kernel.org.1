Return-Path: <netdev+bounces-186809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3DCAA1621
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 19:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A20BE16D767
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 17:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D01250C15;
	Tue, 29 Apr 2025 17:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YlIigFi5"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3B1233713
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 17:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947810; cv=none; b=Rm6tOT4mD2uaxFGRtc8jHD8vd05IbFgJpJKONfpgXRWZlmggnCi5ZCMtzpDVV7pEXGAEPJNqsL/r3lB6ArO2fcJn7o2dc7rCh0pVO89unSsNx7ArdRAiMiosfVaMZMQBifg2TkZzhOZ/tRosViWNlMYYvYPWVb2di7OQ9LYbJDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947810; c=relaxed/simple;
	bh=zcsVVeTA0p6UAc+EOvSEtRfxfVwh/1UWE5hbRidnBTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IwG2XwJbel7S60QcKr5y9jt2bQIXZd1NLvC4kJxFcDLmD0cEIreGtcUxuQK6SUnkfCl1kjsz9aoJlDQtuHd/ud935DE77O/IIDNAiWJcw30AJPL/GENaeFSOU8h8znBggIOI3pI4+fX/Mv9P3trDVx8esswUpcounfklbjwK1qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YlIigFi5; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ae064b92-1d9d-47a8-ac26-1172076e5bcb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745947804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ATlrEW58fdp+KUFferXGbfoEARKyrYWPAY00eE8UZW4=;
	b=YlIigFi5S2mnIfIGqYTeDe5OGnSXQrd72C2kK7dAgo/qZCClJTdzvcDcgEeT7td+mv33bU
	eFRRPqVh93UqKTUVGIgjOOGhww4xs6c8YgUxg1aa93GR5zcGxPOpCC4h6j9CVytbDuF7/0
	72kMI/fxL9AAnRLjv+7HXibLk7k/xPI=
Date: Tue, 29 Apr 2025 10:29:48 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next/net] bpf: net_sched: Fix using bpf qdisc as
 default qdisc
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, xiyou.wangcong@gmail.com, kernel-team@meta.com
References: <20250422225808.3900221-1-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250422225808.3900221-1-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/22/25 3:58 PM, Amery Hung wrote:
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index db6330258dda..1cda7e7feb32 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -208,7 +208,7 @@ static struct Qdisc_ops *qdisc_lookup_default(const char *name)
>   
>   	for (q = qdisc_base; q; q = q->next) {
>   		if (!strcmp(name, q->id)) {
> -			if (!try_module_get(q->owner))
> +			if (!bpf_try_module_get(q, q->owner))
>   				q = NULL;
>   			break;
>   		}
> @@ -238,7 +238,7 @@ int qdisc_set_default(const char *name)
>   
>   	if (ops) {
>   		/* Set new default */
> -		module_put(default_qdisc_ops->owner);
> +		bpf_module_put(ops, default_qdisc_ops->owner);

The first arg, should it be the "default_qdisc_ops" instead?


>   		default_qdisc_ops = ops;
>   	}
>   	write_unlock(&qdisc_mod_lock);

