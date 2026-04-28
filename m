Return-Path: <netdev+bounces-282122-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGNbBLA+8WmhfAEAu9opvQ
	(envelope-from <netdev+bounces-282122-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:11:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE9748CE76
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CF7A6300AD5D
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 23:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11893624CB;
	Tue, 28 Apr 2026 23:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sSKlpnny"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A710346AFD
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 23:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777417898; cv=none; b=EKgwx/Q91xpYSBxg3GlaNydUL53nFyMuheDeX5ivlGWdjvX1D51BfRLH4mC1zjnDWkKPfZVyGX377Ti6ja5PrsTdnt3KyfQ+G6yuboU2tRHkG1qEx0LXxQuNUyHloQbGpQDB1k4bqBA1sKgW93/pt/NHpkfeUHWb+yiT+KXNmmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777417898; c=relaxed/simple;
	bh=ixHFRedrRsDjIWo8ZhCUDY0RxJ2T5iPhGJIZ9Dkjm9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZDZsQPluSb4l2E8Y/awJLMa2o5mjcHEqNRspz4WSYSH91efQMT2py8gXeOh1ozNBGJsWcED3TtjtLfuIM6QsHtW6bc7JlCFjI58nGjuGcVeIIw333CLIC8YUzxJACqCPmq5d5jtJ+lcIe2Fge8dovunFLESEjxIaTiQGgx+Uc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sSKlpnny; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2b4650d5f5cso45787175ad.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 16:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777417897; x=1778022697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tfg8AMRNhSCKkRnwFOPEeZ1q8QequKtxlIIaaAWdFuY=;
        b=sSKlpnnys2bY7Cmifl4VYJB79zpfMmCB+uoNNvhxR/kkfh0DE3zhRHZe9+XEQnqouM
         V4N/OEejcCy7uzy/NsxLW2svSOo97kQhW/vFoiecFQWasuPZ7Na54mXmZUw4BUBKoiUK
         ZsdrAIlc5IOj7kKkgRh2UQJ06pziyZe/JfJFWAwZ6/ePEV+vNGwBCXI8oAFKUS9cEVgd
         8p/m2GfMgD1tEcWsBp4kxpLEYa0/Ns+NF7XzPmj2E8+UA3h85F+W5torNRlDnagUFM3G
         Ni/3t/kfcT7kG+tI17sLGcW13u2vQ3PSCveCE9yXjwfGxv0IkJeRHPHYdGLVbvSUBHQD
         LvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777417897; x=1778022697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tfg8AMRNhSCKkRnwFOPEeZ1q8QequKtxlIIaaAWdFuY=;
        b=bL3ci+sXNPv/r18C5/hzIcH9kd86irkcw9/+KMZDZTPLhodEDqWONneXXkA3uvEyGu
         OCS6Zz+6xrUS6iatd0zExSYfAhx8jjtz6fexOj0DLhG3PnyRqIizZ0yD+NfihZih7zM/
         p1xVmzjr3N9AOvAjC5hIQUai42WX2hvJvR1BWYn7ZjW8O1sGJMbLd6YPpA4/f39hayXd
         GIgVrLgvF8Mf5U2PZ+1Bhl2+RdV4u/6N8NUPg1u63PSAydZFVqZzqqn15a3n6Jqd0nfo
         /H5W2yijE8QzgURAiYNHZ5rfZpI2628TAF+G0Cwbh7uG2bu7/67S+ATpLWKsgDYc2x4A
         veKA==
X-Forwarded-Encrypted: i=1; AFNElJ+KV+cUfTU2XbvrwrSNDXJKS3EymFjE9PdTQ5pXqdhQR9fEcrWF4QsRCqrN+Mg2GvMWHPv8AAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOteVGgReJAELK2n8JQKtV4KeK1bwftNTHNcppAOLGKPSk+6LL
	MOYHF9VWKbABnc9AFhRZhF7MEx3iJeZ0FA82gEHGgwFibWzDv4UWUo9H
X-Gm-Gg: AeBDieuf5MvE1Hwpiz/Lh6MCCbK3IT23l7ZlzxUTAC+2ZDBmlsqJPh0UJIFJOt9OJOT
	+4FQDm2SSDEoDBS47lnjpYCR33iUSQwZjevijkFV2hY6VamIpfKjfldyJ83c/yrDfYIMmDxQg6B
	tJjZuAPXVw4ChXFSg3A5xhDno3B/G0wAcwsY1Y/TAXDb5AltZCNsgQnLiumCXEGFMvYlRhadUDM
	IVt3iaLk98GcwMwqHTcJvZfwTaJCZdBDtwffJ4PJBCcwyu9lRlusOo+m61rViXqjljzOLj/2yRc
	s1LL8GIxvNQC2RBgBIizA3OCcBC1+JUd7ToSH/TM+ArfCtTTzjMkl6L7DYDNq/TTuosKoOmNlAp
	beSXdO5V+Gw0E1RWspu4xGqRAqcJ7xZFMcVMlA2Cpss9FEe9kTXbuQDkvRYRwpspTFhqnwZszS4
	dks3TDKQuWvCAiOe5RMff0Eh9kK9d8zP3mdQ==
X-Received: by 2002:a17:903:1b2e:b0:2b0:445a:8c7b with SMTP id d9443c01a7336-2b98733d3e1mr11143035ad.15.1777417896541;
        Tue, 28 Apr 2026 16:11:36 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b988772e6dsm2904785ad.16.2026.04.28.16.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 16:11:36 -0700 (PDT)
Date: Tue, 28 Apr 2026 16:11:35 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	aleksander.lobakin@intel.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net v4 8/8] xsk: fix u64 descriptor address truncation on
 32-bit architectures
Message-ID: <afE7EFYdrNg1u_g2@devvm7509.cco0.facebook.com>
References: <20260424053816.27965-1-kerneljasonxing@gmail.com>
 <20260424053816.27965-9-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260424053816.27965-9-kerneljasonxing@gmail.com>
X-Rspamd-Queue-Id: 0CE9748CE76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282122-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,vger.kernel.org,tencent.com];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On 04/24, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> In copy mode TX, xsk_skb_destructor_set_addr() stores the 64-bit
> descriptor address into skb_shinfo(skb)->destructor_arg (void *) via a
> uintptr_t cast:
> 
>     skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
> 
> On 32-bit architectures uintptr_t is 32 bits, so the upper 32 bits of
> the descriptor address are silently dropped. In unaligned mode the chunk
> offset is encoded in bits 48-63 of the descriptor address
> (XSK_UNALIGNED_BUF_OFFSET_SHIFT = 48), meaning the offset is lost
> entirely. The completion queue then returns a truncated address to
> userspace, making buffer recycling impossible.
> 
> Fix this by handling the 32-bit case in the destructor_arg helpers:
> 
> - xsk_skb_destructor_set_addr(): on !CONFIG_64BIT, allocate an
>   xsk_addrs struct via kmem_cache_zalloc() to store the full u64
>   address. Leave num_descs as 0 (zalloc) so that the subsequent
>   xsk_inc_num_desc() brings it to the correct count of 1.
> 
> - xsk_skb_destructor_is_addr(): on !CONFIG_64BIT, return true only
>   when destructor_arg is NULL (not yet set), false when it points to
>   an xsk_addrs struct.
> 
> - xsk_skb_init_misc(): call xsk_skb_destructor_set_addr() first
>   before touching any other skb fields; on failure return early so
>   the skb destructor is never changed from sock_wfree.
> 
> The existing xsk_consume_skb() already handles 32-bit correctly after
> these changes: xsk_skb_destructor_is_addr() returns false for any
> allocated xsk_addrs, so the kmem_cache_free path is always taken.
> 
> The overhead is one extra kmem_cache_zalloc per first descriptor on
> 32-bit only; 64-bit builds are completely unchanged.
> 
> Closes: https://lore.kernel.org/all/20260419045824.D9E5EC2BCAF@smtp.kernel.org/
> Fixes: 0ebc27a4c67d ("xsk: avoid data corruption on cq descriptor number")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/xdp/xsk.c | 38 +++++++++++++++++++++++++++++++-------
>  1 file changed, 31 insertions(+), 7 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index ed96f6ec8ff2..fe88f47741b5 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -558,7 +558,10 @@ static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
>  
>  static bool xsk_skb_destructor_is_addr(struct sk_buff *skb)
>  {
> -	return (uintptr_t)skb_shinfo(skb)->destructor_arg & 0x1UL;
> +	if (IS_ENABLED(CONFIG_64BIT))
> +		return (uintptr_t)skb_shinfo(skb)->destructor_arg & 0x1UL;
> +	else
> +		return !skb_shinfo(skb)->destructor_arg;

Don't understand why we need to special case CONFIG_64BIT here?
Shouldn't the same existing condition work on 32bit?

>  }
>  
>  static u64 xsk_skb_destructor_get_addr(struct sk_buff *skb)
> @@ -566,9 +569,21 @@ static u64 xsk_skb_destructor_get_addr(struct sk_buff *skb)
>  	return (u64)((uintptr_t)skb_shinfo(skb)->destructor_arg & ~0x1UL);
>  }
>  
> -static void xsk_skb_destructor_set_addr(struct sk_buff *skb, u64 addr)
> +static int xsk_skb_destructor_set_addr(struct sk_buff *skb, u64 addr)
>  {

[..]

> +	if (!IS_ENABLED(CONFIG_64BIT)) {
> +		struct xsk_addrs *xsk_addr;
> +
> +		xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
> +		if (!xsk_addr)
> +			return -ENOMEM;
> +		xsk_addr->addrs[0] = addr;
> +		skb_shinfo(skb)->destructor_arg = (void *)xsk_addr;
> +		return 0;
> +	}
> +
>  	skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
> +	return 0;

I think this is gonna be a 3rd copy paste of the same logic? Let's
move to a new helper and replace existing kmem_cache_zalloc places?

xsk_skb_destructor_alloc_list(prev_addr) ?

