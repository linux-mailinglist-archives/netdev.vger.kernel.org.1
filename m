Return-Path: <netdev+bounces-298363-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bd9PIYUsK2qI3gMAu9opvQ
	(envelope-from <netdev+bounces-298363-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 23:45:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF976757BC
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 23:45:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=multikernel-io.20251104.gappssmtp.com header.s=20251104 header.b=c9TXeOPl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298363-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298363-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CA4930B0347
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 21:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF9336CE03;
	Thu, 11 Jun 2026 21:45:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0527321F2D
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 21:45:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781214337; cv=none; b=PxYtff6V0p7OkmNeDgvQmakwrdnPHk2gBcjpjkAUZh/4r3BEGmIhICAoZ4dIHzu8qEOtjHos1+xjIgWPt5l+Jj8B5fWA0ogjdMEJQgsGjQyyenq/77Cryxthw77jo/sG1pHbLoTZk9E9li3gQgz2bpIG+LcKQcLQf8FCvwg6uQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781214337; c=relaxed/simple;
	bh=TWJOGOxVkpA6pYHt2k538f4kz5NIK8nh1QpbIqUzmpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBCC5NUyrbuSnTCv0J+EFYf6F1ro+84nxOs0SdwnI+J255ZCt6QA6XPo/6qmoy0OCg4YZKAz8JXkirvtS8JDdYyxrvOLV2XPi8SoBWGFfkyR8avkNdq+w265SoWFlvuWQd2SLWBIRfuL08gn+Rts+bqtdJcK3bFw2agoMphkJfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io; spf=pass smtp.mailfrom=multikernel.io; dkim=pass (2048-bit key) header.d=multikernel-io.20251104.gappssmtp.com header.i=@multikernel-io.20251104.gappssmtp.com header.b=c9TXeOPl; arc=none smtp.client-ip=74.125.82.45
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1370417c01cso375623c88.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 14:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=multikernel-io.20251104.gappssmtp.com; s=20251104; t=1781214336; x=1781819136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ykQKgx44w3X2k/qU7oxMtTqbK/zBreaZPe3qMH5/aXg=;
        b=c9TXeOPli3AVUUHXMKHoKh0ZJm/vYEW8IDs92gcSyG4niUUrB+J0KIRJRQYwNkXQNn
         8Pcbg4eIJ8MVSTLVKRehwA8nr92w4HEoFEkbACDSifkMc99hb/pdw60x/thf6Cil/4aB
         Tu+HgbL0gB7gwzw7gnyznMhlOuTrmedrM6GcDfLzjxcP6rEQRXmDzt5+fnp7wV+smImg
         0bLkEr0eXa5ZyWwFcJhaAltdq/+qhBZS7xEQqbIjm36M2d8OsBtSmpkD5zLBK9KHwpZ1
         SQQEnSnz1zTgRxOtTBAlCT8MEXp/JFftPzcwHIzZxaieHeRI59IU0Vfs3PVOoAXFQ8pf
         Uk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781214336; x=1781819136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ykQKgx44w3X2k/qU7oxMtTqbK/zBreaZPe3qMH5/aXg=;
        b=hNqqBeis6cK4WesLAf2iLyJnIQ5JnRTLT5kaEz01xe1V04rzRML0gS1cipSabqaJ3h
         ltxuWeM9ltddDoE0eW+YmOUPl/gR8gW0Y7MnIoBSk+7yn++rSh52hK+Jp5qWxLuCuFtt
         8Wus5bz7pLDqcqr7Y/DycokhAM2/8UsTAKGC45SLT2AYyHrzpNSCC2jfZAnffUhBeQGl
         SaY8UURZF2FQZc8l+4B2+xX7TsngMeTY2HCJTxUY+Y6UZm+ybhPceTpCaLfkc5mcr5vr
         KZaYS9ygdF8GyVDhKgr6Rs1EjUTDXUScsHojwklZvhYtxeV+QMwF/XWLnwJQMa3VABwu
         LYwA==
X-Forwarded-Encrypted: i=1; AFNElJ+OiRJ7/k2DvH4BUAt8i0jAyXzO6ZT40E2PHaooeaQksY0t20TUTaAh3Lyvp3cJvlKSb1SvRFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS+seSSNslA51MJJjMFM7PX9uSpePITIZY0H6E8XU+tqzdz4XI
	PgJM2OC6z+p3qquQr1LPN/tpl7GrrE2UL0pa9LQXJnHoyiCBiz9r5JYMxIzCoQiR/6s=
X-Gm-Gg: Acq92OFXIGeDWWDMt8Q7yKXD+7lARMke+ZwV3C5xbvHD16cwI2LxH7pugsTdQX98U4U
	dpiSKzholqmQra4Eaeom1ek+B/rO/QV1MTwPRPWcDXykBKuTWh2UETFELObw3tOs/0zN638nVHj
	uxXf4KajGlldsSYDenYWy/GhLoIRjDXpPH09Xaf+cDT0gMx5Yj52LeZNEL4mfuChnP+hn7xo7x2
	5ElyAM+Hu3GpMM7pPXltKcgJgQKClhS75KyPUy9hOhgA2hKc/FNON+uz6jgZrgXfSMbbLi+MoK6
	LMS8riJwCG6ftldx843eUWfQMKCZV37k8WVUP/yfnr2C5bHJ8eoN1qNjwp9d989Xv1cA89IyMYO
	3YyK2la2oEsVdaxuiEFzqEXfmd0rJBrVkYAHb5Y9DKIxLOjfTQunRhtLj9/r/vcgcolzJAUV+yW
	st7k5L6w66QWgthFrvHnskDVYVCQay2F9NJXISjrkeBqDqRaDS67Busw==
X-Received: by 2002:a05:7300:641b:b0:303:f295:4db2 with SMTP id 5a478bee46e88-3081fcc3778mr100907eec.0.1781214335754;
        Thu, 11 Jun 2026 14:45:35 -0700 (PDT)
Received: from localhost ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081eb8d3c9sm464289eec.26.2026.06.11.14.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 14:45:35 -0700 (PDT)
Date: Thu, 11 Jun 2026 14:45:34 -0700
From: Cong Wang <cwang@multikernel.io>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, Zhang Cen <rollkingzzc@gmail.com>,
	stable@vger.kernel.org, Han Guidong <2045gemini@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Shuah Khan <shuah@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Cong Wang <cong.wang@bytedance.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v2 4/7] bpf, sockmap: keep sk_msg copy state in sync
Message-ID: <aissftWzD7cdgz8y@pop-os.localdomain>
References: <20260611123538.156005-1-jiayuan.chen@linux.dev>
 <20260611123538.156005-5-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611123538.156005-5-jiayuan.chen@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[multikernel-io.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298363-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[multikernel.io];
	FORGED_SENDER(0.00)[cwang@multikernel.io,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[31];
	FORGED_RECIPIENTS(0.00)[m:jiayuan.chen@linux.dev,m:bpf@vger.kernel.org,m:rollkingzzc@gmail.com,m:stable@vger.kernel.org,m:2045gemini@gmail.com,m:john.fastabend@gmail.com,m:daniel@iogearbox.net,m:sdf@fomichev.me,m:martin.lau@linux.dev,m:ast@kernel.org,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jakub@cloudflare.com,m:shuah@kernel.org,m:hawk@kernel.org,m:rhkrqnwk98@gmail.com,m:ihor.solodrai@linux.dev,m:cong.wang@bytedance.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,iogearbox.net,fomichev.me,linux.dev,kernel.org,etsalapatis.com,davemloft.net,google.com,redhat.com,cloudflare.com,bytedance.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cwang@multikernel.io,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[multikernel-io.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pop-os.localdomain:mid,multikernel.io:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,multikernel-io.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CCF976757BC

On Thu, Jun 11, 2026 at 08:34:12PM +0800, Jiayuan Chen wrote:
> @@ -2794,6 +2835,8 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
>  {
>  	struct scatterlist sge, nsge, nnsge, rsge = {0}, *psge;
>  	u32 new, i = 0, l = 0, space, copy = 0, offset = 0;
> +	bool sge_copy = false, nsge_copy = false, nnsge_copy = false;

Reverse xmas tree style is preferred by netdev, see 
Documentation/process/maintainer-netdev.rst

 
>  BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
> @@ -3027,8 +3098,10 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
>  	 */
>  	if (start != offset) {
>  		struct scatterlist *nsge, *sge = sk_msg_elem(msg, i);
> +		u32 sge_idx = i;
>  		int a = start - offset;
>  		int b = sge->length - pop - a;
> +		bool sge_copy = sk_msg_elem_is_copy(msg, sge_idx);

Ditto


Thanks,
Cong

