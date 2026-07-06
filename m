Return-Path: <netdev+bounces-305122-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LFZ5BwzWS2qCbAEAu9opvQ
	(envelope-from <netdev+bounces-305122-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 18:21:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12551713290
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 18:21:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=DQ7DIJh1;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305122-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305122-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AB41D317104C
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 15:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076793AB289;
	Mon,  6 Jul 2026 15:28:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3BF395D8F
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 15:28:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783351723; cv=none; b=Tx9dXHudEdVTAtgJv4Ej+J3usa6brF4XCOxCsGj5nHwot8Ih4Pr002nb4svuoqlHojQoQetcE1pKCQA3dLKI4S4ZCQf4bbL+NLTJNr+w3ArwvrCtLZfHQY/13iEByJ28h56+RtRmc5MPMRKwdxoUFTCgaLc1ZNc2aVmWA97bCwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783351723; c=relaxed/simple;
	bh=15t0/qvIPb1m6EhxMeWqoRsVHolGR6WdnX9O2YeniAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPbUxs1F2uJkcOetaGeUgfaIKO/SyTUYs6rxXkLQT1s/aRaAWfJKmvyQ3XJbJ22c3qXLZZeZ6PoMxGkyjNHUnoM50PW3oN7tl9UCAND4MMU4yqxas+YnMUtno5lT9AotmrDYqeFVul1eyo4rYUqsEzghydnPtNx00HsrWqq55rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQ7DIJh1; arc=none smtp.client-ip=209.85.128.50
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493bfe9f886so17572395e9.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 08:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783351721; x=1783956521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DfJaHoVGgMxmKw1/mr0PURm5kBPKEP+5FPobOp8bfyg=;
        b=DQ7DIJh1SQQhXa4vc9BDjG9OQ0jt1ib71DyWW6DVs8eSHI1xCHY5/iS4SducTMaEnl
         Ro2CM5AgP7+voT2A2HlNaEkT07YVL7Ry9NnM1oy++cy/7b8kZBjcOuHzfcgGgMq0QdfH
         y+GL2zXjq7Xkbr8amo8kWYcC26jN7SmH0reXkHqjlgP42PtRuBxd5WqWb5PZ+OdYO9wN
         k3URRZN+FG2tXutYg5jsgVmh+Wg1uTQIooYDb1/N6TIt2jeaAXmuV5UuirOkB153LYT/
         8DTYKeD56huaHYUUP4if/trQncweLf02E0AWe3Kp5DPPAgWJtae0Gw+XWQJwSfns+3qZ
         Yobg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783351721; x=1783956521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DfJaHoVGgMxmKw1/mr0PURm5kBPKEP+5FPobOp8bfyg=;
        b=GACQYH//djk2vAPLJ+gcatkG5DkGl8JjRTFiArbPUr2mHKnSWSgulDdnh2qoq7mu/Y
         OUL0mvP5c9xKfFu5nmAsjciIPMOoyCBAiJWmdilqMj6O/J2YFCUuOr5Tqf5dA+WU708d
         Uz6Ga9bnix4ntZxhaFK4RWFYIfGeNARF4MQwVYrUyzO8QuMqb4u3RVFsIAnOyDcjBeGx
         IX8zrpM9aIO3/NExTSuiXyYYNjomdfWwo0WtjFyNOyVQS3dg25N/qr3HUMKHS8SGXUxB
         2b6QgfKcVnawf41/nfa2fI2Ro8EfGKOqrV0nn8BKbDQbyS9oBZPjMnvgJPTwRnxdNtNT
         5pTQ==
X-Forwarded-Encrypted: i=1; AHgh+RrSLZVg5+HhojbqW8wypN38VH+WtKnHuVOOXRsNmkId2USLRDjjCgIY8Kiw8srqjxKPpeq8sHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUKFu7YJHf44HyFaYNkMF+5dmu0sxT64ldWtk4RbjHoVlzl6T3
	zRmlE4nWukH8PCbWzAwyYPX6E86eB7UfHU2XlJrlezMc7mk/12A3cldG
X-Gm-Gg: AfdE7cldzaaefDkDhjKmqaOV7SdxdNM7Te/VBMZSrPi8LyNoHdIhx08NRUoj1YXOt8g
	12fefFZPHrVAtVQK71D9VI6aP0bCnN6jUm3nnA0FmjdCNHgpvZL8izy3VzWsnTmeh8y/2UkePb5
	waY5pTn+V7/1TBKzbASEftazTBaGeEuMtgGpazccDsXe8/3cjmTRDOXY6Xi4al/byMwXUP7vpfL
	jBEVOrQq7xxYGHX/MfHc16nDBrSjbZ7u7qaVFvV1D0Wqh5JPKts381iLondOrrm+UyDxMLqT9Fk
	xQu5T0vnBjrmPvvsYdXON30gBRUzb/8pOe51Ngb1XiUUO9/X8CGtgwZPal9+/6NN8MrhlynQxWJ
	q75pNC20sFPaKXAoDu1rRY+qZWavMgF/E+6tQIYum7evz/U/uu5DSlqydiN6WAaUdcYLeCGTTmw
	dQ4bI6Ocd+qmc2UnX44ANKCSfupQcTtxVw/7NYFp56Jz50
X-Received: by 2002:a05:600c:4187:b0:493:aa24:792b with SMTP id 5b1f17b1804b1-493df26ed69mr5504085e9.22.1783351720354;
        Mon, 06 Jul 2026 08:28:40 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039bcdasm26402301f8f.21.2026.07.06.08.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 08:28:39 -0700 (PDT)
Date: Mon, 6 Jul 2026 17:28:37 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com,
	kuba@kernel.org, liamwisehart@meta.com, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org,
	martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com,
	ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next 2/6] bpf: Add ksock kfuncs
Message-ID: <akvJpSXmBOn88GtV@gmail.com>
References: <20260706093525.13030-3-mahe.tardy@gmail.com>
 <268078861c26e02c25e9e882bccc607bedf580ae3c1d7e06562c48b85450f1a7@mail.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <268078861c26e02c25e9e882bccc607bedf580ae3c1d7e06562c48b85450f1a7@mail.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,kernel.org,iogearbox.net,davemloft.net,gmail.com,google.com,meta.com,linux.dev,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305122-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS(0.00)[m:bot+bpf-ci@kernel.org,m:bpf@vger.kernel.org,m:andrew+netdev@lunn.ch,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:davem@davemloft.net,m:eddyz87@gmail.com,m:edumazet@google.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:liamwisehart@meta.com,m:martin.lau@linux.dev,m:pabeni@redhat.com,m:song@kernel.org,m:netdev@vger.kernel.org,m:martin.lau@kernel.org,m:yonghong.song@linux.dev,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:bot@kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 12551713290

On Mon, Jul 06, 2026 at 10:30:04AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
> > new file mode 100644
> > index 000000000000..8bde734bc917
> > --- /dev/null
> > +++ b/net/core/bpf_ksock.c
> 
> [ ... ]
> 
> > @@ -0,0 +1,516 @@
> 
> [ ... ]
> 
> > +static int __init bpf_ksock_kfunc_init(void)
> > +{
> > +	int ret;
> > +	const struct btf_id_dtor_kfunc bpf_ksock_dtors[] = {
> > +		{
> > +			.btf_id = bpf_ksock_dtor_ids[0],
> > +			.kfunc_btf_id = bpf_ksock_dtor_ids[1],
> > +		},
> > +	};
> > +
> > +	ret = register_pernet_subsys(&bpf_ksock_net_ops);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
> > +					&ksock_init_kfunc_set);
> > +	if (ret) {
> > +		unregister_pernet_subsys(&bpf_ksock_net_ops);
> > +		return ret;
> > +	}
> > +
> > +	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
> > +					&ksock_kfunc_set);
> > +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM,
> > +					       &ksock_kfunc_set);
> > +	return ret = ret ?: register_btf_id_dtor_kfuncs(bpf_ksock_dtors,
> > +						 ARRAY_SIZE(bpf_ksock_dtors),
> > +						 THIS_MODULE);
>                                 ^^^^
> 
> This isn't a bug, but in the final return statement the assignment
> to ret looks like a dead store since the value is returned right
> away. Could this just be:
> 
>     return ret ?: register_btf_id_dtor_kfuncs(bpf_ksock_dtors,
>                                               ARRAY_SIZE(bpf_ksock_dtors),
>                                               THIS_MODULE);

Indeed, this is relic of changes trying to get the cleanup part right,
see the other message from sashiko on the same patch.

> 
> > +}
> > +
> > +late_initcall(bpf_ksock_kfunc_init);
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28783010022


