Return-Path: <netdev+bounces-274848-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2G9aIaIkz2notAYAu9opvQ
	(envelope-from <netdev+bounces-274848-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 04:23:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F126B3905BE
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 04:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E094C302F7EB
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 02:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11932346ADC;
	Fri,  3 Apr 2026 02:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IOVQiMgU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE5D326945
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 02:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775183006; cv=pass; b=KH+2FZWJOCyhWPmmJPlWTP/P0tY29ITqmGXoXNoOJfL7wadfqDuknfNTtqKQIW8NLYXWtitMUjMkJ0FpACKgdnfKJUPesrARLS0U0oNZHUKUyeNuPEzSQ0QIWr8XFHNpk8b7D5WPP340SoHcbYuWAtYK+wZNI3sUIiCaneWWWIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775183006; c=relaxed/simple;
	bh=QPNniyPcPD8NCEHVl1+tqiO6u9fwEmcwYqCSe4cH26w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOtGA8rwLDWnobm8Ng4sHikF998vedfhTVnYXEM21Q8uWRP8XlL/bUVU9i6gdWeO8gCwOxLHEfghYzGMtu/UObx7jAmPdIlXfQXim5TCVTGo1qN3v6223Bct7rnsUzBDMaHMI/hYGxgCCQPpih2Ko9rcJFCnqO2sA32YNiO9HAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IOVQiMgU; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7a469383e0bso7305697b3.2
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 19:23:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775183004; cv=none;
        d=google.com; s=arc-20240605;
        b=D1yUVis23pdvYVJXaAeD0Cpy9Sq+o/oSZsQ2VMDFKkCaiyhtIUMxCPk2hhnISFRuxs
         G5RDDJ1+h/KCvZvESh8TGybqXUlktBuLMC5oY/ViJClcA1fSt4N26EAcatw5yv89BXvg
         1kEwTjJ+5FhrXZzN2IxnS1uEs3FiMaaqjKzxUiLNL7bo3LwpMFhlTfTsBbPSHbn2WqQl
         bGyrwGXGzzxY4V17PvgWvj7abzE7KAOCiZc646giujoupm1OeCaIxek8K4s3RVI2HlYH
         wHzDQD/DNM2v0nVGfmsr3okkOTMNIL7VbiZlOpwhkq0Z2SytIFbKvwli5iOxe6VQ//HM
         PPWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HIy8iHuqOlscN7DzgEOqWCvFHIn3PjfNELBdpX/HHL4=;
        fh=Vrl0tC0K7iMFQCrmxkD6d35+wTFsGeFXqIz4yPfOt0s=;
        b=JxptHg0z58a8F58t7B3Ds01+i1ddxaIro5EwCTRzRrnWVBgxzqk9cRwi8Kd49oWBLj
         0fcSlX+wnmdZRBLCapPi3eT79cHs8cVhl4TjxyJSdnvs10hd8/cEgqs8+BEfniDM3dOx
         S2ou3ajJernwJKuZYHQ5eSP1XZdPVetFs50bpxgf2MmOPwjMX6iCIqK6uLIQ+Ih45iAC
         +ihjTQ1QIYIlYPH5TQhtg9QPHcYSdO2uIoPiFP5BYyrztNlejI0tWDBUdJqW8kaRG6PN
         hkcHkZzE7OMCnYWANKfyOIFViuOVg5iC37pyBFSvrDXuHKgk4ZPIQId1F6GGpE8CxLLA
         Iv7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775183004; x=1775787804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HIy8iHuqOlscN7DzgEOqWCvFHIn3PjfNELBdpX/HHL4=;
        b=IOVQiMgU1KjvK0aa8Omw7nl/AzNXB758nAWINmMvo9ICxyN4yTqkaQywzfiuSpKPV2
         FJTZjtKCPN9sAzdNOOxx7nlFNXCvrIthLdZxKe8QDsR0YyoZihiLlbb8040gSIYVPxjx
         13Chk7Oob+9fUdOxe/rxmNsJa3Q9q1flGnNJOtoe8yps2mNn2jrI/cHNf4Pbe6ncWfSF
         k6dLwT30b9orcCXYvUSfZ4MQWZhKOS/N7eN0XqFTtS8hfEgSYSbmNX7gaPRvj3DESkMA
         eTFQ3Ph9sDM4sY4gVcaZAc7pQBeJh7SqjrDXhWPhTyPMbw6usUyRlL71QWYWsYIXG7qS
         /8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775183004; x=1775787804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HIy8iHuqOlscN7DzgEOqWCvFHIn3PjfNELBdpX/HHL4=;
        b=U3G3vS0+JHWMKE+KAwFNk82WrYRDQP2qHQulDlEBy39wGnOQab2faR1fPgCuIFAebU
         70BGaxzN/KXXBp6LiazQf+5UdPrZoDGyGZgniPalWue1F63pNl+MTAKsWNypemWRM8MX
         xrjq4O7JjXYIulqvMNDC7OGHr4DE0AvCHNk3styoY2HknOh+bgeLHQlUgJy40D+uk/3g
         cKR4OMKnOP1xvg5kO66hG7XMnCeRVABKwwA6NrQNIuNe/5mQTPsP/Vv2+4olNcRZTiG7
         ANnq2mzquZN5CFNKgrmHkcQrqJVdlN3TU7CmgNZdAw4KQbos9yc/EOnETLxLLNtBlL+J
         WlSg==
X-Gm-Message-State: AOJu0Yxmd7ZrAHZBXzLHAR5hFGPnmhMA9c2it4gYnFnWMjWNHFno2NyX
	Zoldh9/e6LpxtnLtJlNM4cVBGjwCDzKFstLTlBGd7VyOwVj5712YF1iEV7TEwE5PQAqB5IEQwMa
	5JI9YBmrLrLZj5VM/SYYxYoKoAIsJhD5ZF//WGoWV
X-Gm-Gg: AeBDietluabD+uVtEiIkHI27CIbNMZS0ziABmtfgXd9PZSi1iJBoPWc/cpJ/QlCVT6n
	vvzBCBJpC97dD3QFjWkiCNaGR47mdub5zkH3nAFxIdHoTyXNibSBZNDEAMgRx7godCN5NA4xQwm
	R7kltPTP5HcwmXz2R0M3JQnpkzzwo4Q4m2IM05XsGpeMq1IXXvkFr4CPyxd+rh5UGWb4lfBZhIh
	R+55uGUeOAlYAbrdrvPJBJv0bxKaQM1bva7UrEfpd5liQbyvbKRWKZ/SvSK22U7PQGtJb+WOdYv
	QRbmDjs=
X-Received: by 2002:a05:690c:dc9:b0:79b:e346:980c with SMTP id
 00721157ae682-7a4d625504fmr16818907b3.12.1775183003286; Thu, 02 Apr 2026
 19:23:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403014517.142550-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260403014517.142550-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 2 Apr 2026 19:23:12 -0700
X-Gm-Features: AQROBzCrQfdIxhSDR4XDUfwsweTqox9rEdRUXCTR5rMIh44Ai2CNLoPe7QFj0bs
Message-ID: <CANn89iJru14aPMCXMHmsek1S5TH+sLkczJKUPpcfZHnYxR9KEw@mail.gmail.com>
Subject: Re: [PATCH net v2] net: skb: fix cross-cache free of KFENCE-allocated
 skb head
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Antonius <antonius@bluedragonsec.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Michal Luczaj <mhal@rbox.co>, Mina Almasry <almasrymina@google.com>, 
	Eric Biggers <ebiggers@google.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Alexander Duyck <alexanderduyck@fb.com>, Soheil Hassas Yeganeh <soheil@google.com>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274848-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,bluedragonsec.com,davemloft.net,kernel.org,redhat.com,gmail.com,google.com,rbox.co,fb.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,bluedragonsec.com:email,linux.dev:email]
X-Rspamd-Queue-Id: F126B3905BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 2, 2026 at 6:45=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> SKB_SMALL_HEAD_CACHE_SIZE is intentionally set to a non-power-of-2
> value (e.g. 704 on x86_64) to avoid collisions with generic kmalloc
> bucket sizes. This ensures that skb_kfree_head() can reliably use
> skb_end_offset to distinguish skb heads allocated from
> skb_small_head_cache vs. generic kmalloc caches.
>
> However, when KFENCE is enabled, kfence_ksize() returns the exact
> requested allocation size instead of the slab bucket size. If a caller
> (e.g. bpf_test_init) allocates skb head data via kzalloc() and the
> requested size happens to equal SKB_SMALL_HEAD_CACHE_SIZE, then
> slab_build_skb() -> ksize() returns that exact value. After subtracting
> skb_shared_info overhead, skb_end_offset ends up matching
> SKB_SMALL_HEAD_HEADROOM, causing skb_kfree_head() to incorrectly free
> the object to skb_small_head_cache instead of back to the original
> kmalloc cache, resulting in a slab cross-cache free:
>
>   kmem_cache_free(skbuff_small_head): Wrong slab cache. Expected
>   skbuff_small_head but got kmalloc-1k
>
> Fix this by always calling kfree(head) in skb_kfree_head(). This keeps
> the free path generic and avoids allocator-specific misclassification
> for KFENCE objects.
>
> Fixes: bf9f1baa279f ("net: add dedicated kmem_cache for typical/small skb=
->head")
> Reported-by: Antonius <antonius@bluedragonsec.com>
> Closes: https://lore.kernel.org/netdev/CAK8a0jxC5L5N7hq-DT2_NhUyjBxrPocoi=
DazzsBk4TGgT1r4-A@mail.gmail.com/
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Eric Dumazet <edumazet@google.com>

