Return-Path: <netdev+bounces-300584-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v1D1CF+hNGpxdQYAu9opvQ
	(envelope-from <netdev+bounces-300584-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 03:54:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B10D46A3963
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 03:54:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=KbKrnDKg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300584-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300584-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 661F830378B8
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 01:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B9F3368BA;
	Fri, 19 Jun 2026 01:54:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957733346A0
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 01:54:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781834065; cv=none; b=hOaCcZLVmi7wQo2i+mYH91U82D/b/aymkLsLE9obWujVwLaM/I/2w+pDZp0lRvadgBvVO5jN16O/rlGXISlwDz3obYp181LB6jFh1LYocJCFi2nS3GcPDM/9ubQnSBgXI5lCypsFQVnbTYj3iwQlFaEwTvkLTJ6WE4ZnrGFb2/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781834065; c=relaxed/simple;
	bh=F54uGKLXdXw8RyXpmpClJJ7IJaFDWg2C7EZ6wH5z/xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0mYdrO4dDXDS58PBo8ocl9Z3ZdJNyQKzF3N3v9YVepTEUkyp8UvZtvHy0US3A5MjfCkk/Sselu0SllGTlAHTe5Xb6RJzsic1XV1IvQV0AsdjItJaRVAIsHD3hO3uf0DPglHa/Z8z3wOq9zU9bZAv5FlGOUdzz/Mis4BjKtGGyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbKrnDKg; arc=none smtp.client-ip=209.85.210.179
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8453bcf7276so923678b3a.2
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 18:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781834064; x=1782438864; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+Ap11umBm5DdvodyMZh7hH54B56SBafq3wrv+UubuQw=;
        b=KbKrnDKgNXGcEvUfwGwsJNSBAdegJy4zOsyu9szg4AUt50B12gqc13Obhly6DC+g2V
         HgYEYo+VsiT5uKJS/GDGjd7GJWauhQd6nAinCJf222cGraXIhI5oAGOdRU47tTNbAOX+
         KXSZg6WncWNnURY0rQCL3vOOMTG0gFzU+9N/A5ZhKGUOS29IRaEPzQR8mF2+1aQSdt5o
         fK1zdF1RmG7RvOeR9OBNaL6BFKVdO3gV+6aWx2hc1UBiVsHJqXq5Ov4/wN491R5D+lyc
         xpyqWbG7GLkaFcmlWHKSVXuw3UCjLNMq6nqLT+AsAFpZiO6FWsfsPK3Av24hbIqfT1ZZ
         13Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781834064; x=1782438864;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ap11umBm5DdvodyMZh7hH54B56SBafq3wrv+UubuQw=;
        b=mX0McSFxz2if9Ehcs5THZt+9gr4YMkdiBMJzVGsM3FVnlxvJmRrrEIECQG2Lo1GWHy
         nLoktOWAeutNOTMJshjA1xwMS7a0+3WGeSBeqTdDET3zJZAOGkOXvE0cpuJAslEZ2MJg
         qbGw96Zfzg+cJyEyqKvrNmG/+GPwIDD4U54XRm0Dc6wsQHtbbSYI/m+JpSkTtG1IPaBX
         dfu+TjRsM5MR1GA9EG0f4eFnEFs7KY8o+lF1wZcda3yCGozUcSzyBBw+aejHhvLrrfZM
         +ZBrKsQ5epYW/v4yXQtxg/bOkEI4+i5Vn4k8iAEoKpqHuicoB19pEMUGpUITykBuQmx0
         Jf4g==
X-Forwarded-Encrypted: i=1; AFNElJ8S8p5il0N7/BY3mvWV2egIP58dIG/kIKitAM7wxinaeUopnTWtDChqFTwc4OWdcX5uWPNUpsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIOwTM9O7EqdyUlMcUKG0LlDNE4c1BomDXs0UhQr76J3sQQBYV
	dq4EDQYQndJirKOu9NmbdjtZiTI/+bwgKNdv6xXKGnp77GxqJDMXNGF6B9NK5A==
X-Gm-Gg: AfdE7clQXwmCZVe68SzP6+krs5i97tmwxR7daNQ1yf49QG7slzmgy9LCrgbDKmTbrgc
	YVIVCXGNpoGXx1KfLKkgtM7v0WgdU6YGVWSqGXn56sE3vfYOtYP/MK2dVRAXIwlIhVc7E0ltmf7
	nL3ghpTSToftpuyX2MCZYfcAqHwJmetANQ9/uOCCgjdC+QzLMC7PBLRuK97bI9AKyi1iBEWHAor
	F+TyNU4YRUEQ8E3SEGbbWDXG6Y3xczt9732WfC3siAE77lxHnGLKC1fNci+YjXT7+bItKZaCNxW
	6weC+n6+496Bnd+YI9xSBqXT8dV7ofynU3IywQB262fRRSLkBY7gUf/4N18r4jPPCUwqIiJwFLZ
	W9AboZE4Ro9ndZTbI3OeTI5sFZ5q9kijq9RgsVdQZVTm9vGvBpCzr0MJ5BFz/6ttB66d254pkPT
	i5K6XAPMd2Lk14Iv2XIb5wMlD96dGNXHCDUsoZb3Dn/0CvpgfA
X-Received: by 2002:a05:6a00:2e22:b0:845:3fe5:cddd with SMTP id d2e1a72fcca58-845508bc039mr1411984b3a.36.1781834063813;
        Thu, 18 Jun 2026 18:54:23 -0700 (PDT)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845536758ddsm481839b3a.15.2026.06.18.18.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 18:54:23 -0700 (PDT)
Date: Fri, 19 Jun 2026 01:54:16 +0000
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH bpf v3 1/2] bpf, sockmap: fix use-after-free when the
 stream parser resizes the skb
Message-ID: <ybczxlhdqo3rlhhob2zlmss2nxluli4y4k6vj5vophm6hyangc@cnts5oueqlph>
References: <20260618102718.2331468-1-rhkrqnwk98@gmail.com>
 <20260618102718.2331468-2-rhkrqnwk98@gmail.com>
 <34f330b8-60d2-4647-a6b4-a5b001c3715d@linux.dev>
 <ajQwWe4SC1M7MtJa@john-p8>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajQwWe4SC1M7MtJa@john-p8>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300584-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:john.fastabend@gmail.com,m:jiayuan.chen@linux.dev,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kuba@kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cnts5oueqlph:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B10D46A3963

On Thu, Jun 18, 2026 at 11:01:58AM -0700, John Fastabend wrote:
>On Thu, Jun 18, 2026 at 07:56:34PM +0800, Jiayuan Chen wrote:
>>
>>On 6/18/26 6:27 PM, Sechang Lim wrote:
>>>sk_psock_strp_parse() runs the BPF_PROG_TYPE_SK_SKB stream-parser program
>>>to find the length of the next message. strparser assembles a message out
>>>of several received skbs by chaining them onto the head's frag_list and
>>>recording where to append the next one in strp->skb_nextp:
>>>
>>>	*strp->skb_nextp = skb;
>>>	strp->skb_nextp = &skb->next;
>>>
>>>and then calls the parser on the head:
>>>
>>>	len = (*strp->cb.parse_msg)(strp, head);
>>
>>[...]
>>
>>>unaffected and may still modify the skb.
>>>
>>>Fixes: 8a31db561566 ("bpf: add access to sock fields and pkt data from sk_skb programs")
>>
>>Is the Fixes tag correct ?
>>
>>Anyway, I don't think this patch is a fix; it's more of a hardening. 
>>So no Fixes tag needed, IMO.

Thanks for your review, dropping the Fixes tag in v4.

>>
>>
>>>Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
>>>---
>
>[...]
>
>>
>>
>>CI failed:
>>https://github.com/kernel-patches/bpf/actions/runs/27754218839/job/82113319982
>>   Failed stream parser bpf prog attach
>>
>>Hi John
>>I noticed that bpf_skb_pull_data was added to the skmsg test:
>>https://github.com/torvalds/linux/commit/82a8616889d506cb690cfc0afb2ccadda120461d
>>
>>Can we drop bpf_skb_pull_data in parser prog(sockmap_parse_prog.c‎) ?
>>And are there any scenarios where we need to modify skb len when 
>>using strparser ?
>
>We should never modify the skb from strparser. Just remove any tests
>that do this and state its not safe. We haven't used strparser progs
>for a long time anyways.

Thanks for your review. Will do in v4. 

Best,
Sechang

