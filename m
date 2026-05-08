Return-Path: <netdev+bounces-285896-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OtSA6v//WkTlwAAu9opvQ
	(envelope-from <netdev+bounces-285896-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 17:22:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 611654F8A01
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 17:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F35EE306D61F
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 15:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBA334FF78;
	Fri,  8 May 2026 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ir6HEYxu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1023FB7F1
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 15:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778253349; cv=none; b=WkmNl5tTGWk6SoBtz3wdcxevoinnUd+ljgCcftU+uDs1++Jh0N45p9CW4EQqHaTj3rqhkdk5wuMDlJ/3VGf3c7b+yTw+55rS+Y9qf7p5wJ9wV78sqpNrtoEF8cPxiXbPejO/tRiiBe45g7CD6MHFbKiBiKEiST4upDcaOilLWgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778253349; c=relaxed/simple;
	bh=QTCFy54J5oT0q57ktVfbNPWs/6RQUoT+/yIYyo5bzkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTgP1ab8OjrPTHWGNtXbveeW19VkRxb3TeBHYCxMVhYk9P/F+1LdM/QrXhqhwxnUWX3gshn5uGSH60of56dADaqggKvpmAKN4MEeWPwX7tNiJwl7wvCnXrttD362TR/BeZ+ocAhQRI8wJKLwgmlhQKe51soj+LPZ5tMoWY/5D/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ir6HEYxu; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2ad4d639db3so11372435ad.0
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 08:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778253346; x=1778858146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oaliql9sqskgI8tL8intOqmIn9GbCLcLJL3l5R2zxMM=;
        b=Ir6HEYxuF1jD8KFdAzUHcMEimZ1BXDVOpgBTRRLDBQirqFxoxf361jYpidJsQ9+zk6
         0uDJWJWY85YTTLH/YGn9IV9VY4EYlStRliUCAjGUoUNZoN/kQXEQmEzmNtQnOIlrsXCb
         LtGV/5HRS8STmeFefz6uu1yy/7PgnHL3j+NUs8AjFq9LzR+6AllyiO+36ADvCT/VtGVw
         bzK26DRnZvGWCWohogjVOanoEIDlqvnjmgR6SbCf2NeI38l2N2xa3J8tBFuNsj+C9HTp
         xmYjgEl5XpBBj/F+PUBsvlx1Npiq4FILa+ZpSV73OE1v3nnqIR3JOSCzWOEZypYGhlNM
         nlmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778253346; x=1778858146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oaliql9sqskgI8tL8intOqmIn9GbCLcLJL3l5R2zxMM=;
        b=B8OcVQR9jCakgUnGXmEvaZLi3R8GdoF7Y4JwctDb5mVCG1pfkz1lRYTrWPNIbbDG2s
         70whIJCVMSMnTxpHHlAtqZglft2UcRN2wf63Af4jz5Cjsbl/KuuwYHptkQ3OUH5X/Dbd
         19lTXmIX5z4e3SpA6XRjjREqmZ5Erqqh0ty8QBHdBAvKlidbqMT7dakIMbxGGFHAtCW8
         sMK3Yj3GPeILNW76QICAdRbhZvpo3AWdws+J/IiQFJBvjJ4kAwkbGQOLslWr9FYQ0d1Y
         pyZ18AlZTQ1llHV2kVAnUt5ALU4ujzNqfBD89EY4BaId8Mz5+wrFcvAGEpA4JLJM0yQJ
         9twQ==
X-Forwarded-Encrypted: i=1; AFNElJ8xjK6VkCnPKOqoWdgEMPNqeTI5W03+Wzn+SNv3s5I8qOVRu8rcoIANsn8Bhoax/Hz1wT3yprY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm0WFj9Zq2awFUDRGQz2YUugfp/RZLxb04+pYpADk3zjx8NH1D
	myjbIj8X/CjenXbKvNloAAMf9yQA/fcO985SHX4skXYs3cGsZTnOcV43
X-Gm-Gg: Acq92OGr1Cqv9vKW709UT/yuVEIKveYPq8/Iisz665rrhXaFs73j6KaXiCPXVwnpFo9
	luDU6uFXAu4GM9Pu+VEKBMSqLYN6HZpzVjDzO3h7tPaKu3bT6Fq6ocNpoMwsTQ/Jjgji9vcsgkv
	bUJpx9myuQwpDcL0aTFyBGrNXumjL2CNOrtBA1uGq1P6xyNCOzuHbLDhREb1YUyPOSKNelJ7vf9
	XAo9kqklfDKtt1QBzjNksT+6iVNq4B7Ym1pD+0K0wNqKTooZMhGA9/aiD+X2/pPf7/8rg7Liglh
	hn3V7ipCDstclCqnKVLC672xEwQ/2BDt7PLSV0emwQp/NaYSzq6XFph7MqG/chC/UX1EaMSL3JQ
	vn4wgLDZXjyeofCAMXp5ssALtPm+B0/e/Blku+GiRXasaQ3PeZ/EXkNc8E+0hUHuf+Xt351/59G
	v6eJX+ZQtDI25dyoyx0xqK/asQ29o=
X-Received: by 2002:a17:902:8b84:b0:2b4:6d92:b002 with SMTP id d9443c01a7336-2ba7a343404mr94812295ad.37.1778253346416;
        Fri, 08 May 2026 08:15:46 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1ec232esm26222665ad.81.2026.05.08.08.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 08:15:45 -0700 (PDT)
Date: Fri, 8 May 2026 08:15:45 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tenzin Ukyab <ukyab@berkeley.edu>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v1 bpf-next 3/8] bpf: tcp: Support bpf_skb_load_bytes()
 for BPF_SOCK_OPS_RCVLOWAT_CB.
Message-ID: <af390TgIj5sDABvi@devvm7509.cco0.facebook.com>
References: <20260508073355.3916746-1-kuniyu@google.com>
 <20260508073355.3916746-4-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260508073355.3916746-4-kuniyu@google.com>
X-Rspamd-Queue-Id: 611654F8A01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285896-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bpf_sock_ops.data:url,devvm7509.cco0.facebook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 05/08, Kuniyuki Iwashima wrote:
> When a TCP skb is queued to sk->sk_receive_queue, BPF SOCK_OPS
> prog can be called with BPF_SOCK_OPS_RCVLOWAT_CB.
> 
> In this hook, we want to parse the RPC descriptor in the skb
> and adjust sk->sk_rcvlowat based on the RPC frame size.
> 
> However, we cannot access payload via bpf_sock_ops.data on
> modern NICs with TCP header/data split on as the payload is
> not placed in the linear area.
> 
> Let's support bpf_skb_load_bytes() for BPF_SOCK_OPS_RCVLOWAT_CB.
> 
> Two notes:
> 
>   1) bpf_sock_ops_kern.skb will be NULL when the BPF prog is
>       invoked from recvmsg().
> 
>   2) Access to bpf_sock_ops.data will be disabled by passing
>       0 end_offset to bpf_skops_init_skb().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  net/core/filter.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 5fa9189eb772..94d07a15b2ab 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -7718,6 +7718,38 @@ static const struct bpf_func_proto bpf_sk_assign_proto = {
>  	.arg3_type	= ARG_ANYTHING,
>  };
>  
> +BPF_CALL_4(bpf_sock_ops_skb_load_bytes, struct bpf_sock_ops_kern *, bpf_sock,
> +	   u32, offset, void *, to, u32, len)
> +{
> +	int err;
> +
> +	if (bpf_sock->op != BPF_SOCK_OPS_RCVLOWAT_CB) {
> +		err = -EOPNOTSUPP;
> +		goto err_clear;
> +	}
> +
> +	if (!bpf_sock->skb) {
> +		err = -EPERM;
> +		goto err_clear;
> +	}
> +
> +	return ____bpf_skb_load_bytes(bpf_sock->skb, offset, to, len);

nit: wondering whether it's better to use __bpf_skb_load_bytes (which
wraps BPF_CALL_4's ____bpf_skb_load_bytes) here? Seems a bit less
magic and used already by dynptr?

