Return-Path: <netdev+bounces-279913-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eG/fLiiA5mmjxQEAu9opvQ
	(envelope-from <netdev+bounces-279913-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 21:36:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CED14335E1
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 21:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 185E53045AA1
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B26F3C5DCE;
	Mon, 20 Apr 2026 19:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKoNcu/4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5602B3C2768
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 19:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776713678; cv=none; b=FFPaPIOawy2nv3Q8oQMGv8G22mN71kIck3p7ZgEsU2ZHXZw2I9AWnBFysl5glIwU3BPEE3fe7wW0QOzAwCKrsAGyu1odxq/8Na+wDzqGDK9zr59avbvyGgcpm2GHWiu5ekKli8coFW7Ig5+qZ3POb9iWNbRfLSuOjkhqLv1Xdik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776713678; c=relaxed/simple;
	bh=JSsKbyP1KNpH3VgRE1/5fzA0f6PCalqc1PPHjq93CEE=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:Subject:Content-Type; b=M9gZx9MUrs1Kri6CVRs0ezQKZsrVfEWuyPqmD73HjY/Bh7I0RcytsFrqGkyWnC4WBdIwGf6OE36WMjQY1EghECGNFouA7mAFgby9+BxRtantM9KcZX6arqdvLDY+9zFCIlEppolsr8QePxJD6fUoZoNRA4Bmvty5FfoZtOTSRXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKoNcu/4; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7dcd17e19b6so369942a34.1
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 12:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776713674; x=1777318474; darn=vger.kernel.org;
        h=subject:in-reply-to:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/N6MVvai13qDwjLjyRX2yoaXM7uyr51YiE4c9y/nXV0=;
        b=VKoNcu/4jsmvBtOmsntBF9EbRwgMMuhysTUj+lIB7jcHEbbiWGsWIXwt+lMEbHKXoq
         +RD/Ah6RPZi+9WBueZW15HclScJXfEw6pIvxMGE3qZ1mNvQ0SRlbJBEyHXwi82glzeas
         N3N0wzd/FC4k6INEAG1Tju91lGJEOHx23LnOn9vcgksxfmz5T0lOoA5gAuyW1HG3lF89
         8GGmdYAjY/4u/bKsJ9HjqWbSE8i11rdN5XM0ZEc1fXuTMAZPFnfTzDTCPfNJoZbTKSK4
         56YeHqreEFj4a9Q8Aps8OrlanfvKWKNGizj42lGtcxK7DRCXway//dO2DyebsqB9h22A
         iwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776713674; x=1777318474;
        h=subject:in-reply-to:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/N6MVvai13qDwjLjyRX2yoaXM7uyr51YiE4c9y/nXV0=;
        b=FmdjVNSv5oRHaN1m4WycTxoV7jlU75rVWMqs/SKRWtE71+4Azf+Nx9ZpeyigkYkpl3
         8qHjnq1f9bTtwfxnpAklwDx6fOmWEM3m46ug4PzhKXnJORfJbGd7jg0JsOTKTit9cOLA
         9lQAJDNUjD7ZlEAdn2WlolyI61qwTsx42RQQNx+j+ExH2efaWEpasIDOOpYlUwwLfrx7
         1yKg6ccZGhVx49hPh+AhTdJJB3f4UyY/ooRr7YHH5bJxh9ybUhZdbzin2JDk1Xw9bbEs
         9JGZih7wl3XQ1N9U3nk0jAq3vWakX4s7KsUCR3uK2ol/i7fBoueb17XUynP02fGRNRY+
         BWBw==
X-Forwarded-Encrypted: i=1; AFNElJ89lF0zYeuVRBWlOn7C7EgQnyDBUkNciHEX4ru0zaMjT12Mmz9d1vm1e7LO/4tPAoe8hauK+XU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnVlWVX33tUSPyhuNKceBT+c5iTZep7xfrTpn0noIGsir3mBCO
	Qo4kDpY4r4+VNEeUfxavQzwbOI44Uqo6SFPwXOi44x1vYraDFks5aZN8U0NJ0g6k
X-Gm-Gg: AeBDietZ7gv2HidTWfiuYLTSji91Ktvt/v0iCBQRzZycb91cb4GjsbZjf7R4DmlDqzZ
	KzsxYIaNHtKK41d46NuVj4o3Tx07lWpcShtqV8vJKNqcVRZRp3oKvGhc8z0imwusu3xrHoW7fIX
	rXvQAzMlIaKiur32Ra+SGEkeMqxIH3vBXN4UAb341Th936ENafu01pOJEiTFBem1xRwlrQyEpUe
	R/PlA/oQ3s9VWHRgzkJ1KJn7yXV6z4ls8dXB2Yn7iav+ns/CXTNqdL8GZrxszcsx5qHtPFwfejR
	SOV/AFKVwSRLbhSSDZoFQ6T9XZYI9Frp1QmCeofTz2CMf22ZWgIqpaPOTtpy2o3LLXMcYjAgjWD
	EzSbNrXQnJMW3NGd87hUa2o64qbX6I/caTU2DpykiMFOgLLzhGFd5yW9tjcgwSnOBa3yhswQwSH
	Mdn8ngmgVMrN7oOBkVyLTENsJLQlW4
X-Received: by 2002:a05:6830:6af8:b0:7d7:da02:1aa4 with SMTP id 46e09a7af769-7dc94fac1d6mr8621768a34.1.1776713674272;
        Mon, 20 Apr 2026 12:34:34 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:71::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc97518b58sm9283895a34.7.2026.04.20.12.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 12:34:33 -0700 (PDT)
Date: Mon, 20 Apr 2026 12:34:32 -0700
Message-ID: <eef5d62d475b0aeb93f6f84585f36972.sdf.kernel@gmail.com>
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
In-Reply-To: <20260420082805.14844-4-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net v2 3/8] xsk: fix use-after-free of xs->skb in
 xsk_build_skb() free_err path
Content-Type: text/plain
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [0.34 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279913-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6CED14335E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Jason Xing <kernelxing@tencent.com>
> 
> When xsk_build_skb() processes multi-buffer packets in copy mode, the
> first descriptor stores data into the skb linear area without adding
> any frags, so nr_frags stays at 0. The caller then sets xs->skb = skb
> to accumulate subsequent descriptors.
> 
> If a continuation descriptor fails (e.g. alloc_page returns NULL with
> -EAGAIN), we jump to free_err where the condition:
> 
>   if (skb && !skb_shinfo(skb)->nr_frags)
>       kfree_skb(skb);
> 
> evaluates to true because nr_frags is still 0 (the first descriptor
> used the linear area, not frags). This frees the skb while xs->skb
> still points to it, creating a dangling pointer. On the next transmit
> attempt or socket close, xs->skb is dereferenced, causing a
> use-after-free or double-free.
> 
> Fix by adding a !xs->skb check to the condition, ensuring we only free
> skbs that were freshly allocated in this call (xs->skb is NULL) and
> never free an in-progress multi-buffer skb that the caller still
> references.
> 
> Closes: https://lore.kernel.org/all/20260415082654.21026-4-kerneljasonxing@gmail.com/
> Fixes: 6b9c129c2f93 ("xsk: remove @first_frag from xsk_build_skb()")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/xdp/xsk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 6521604f8d42..4fdd1a45a9bd 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -889,7 +889,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  	return skb;
>  
>  free_err:
> -	if (skb && !skb_shinfo(skb)->nr_frags)
> +	if (skb && !xs->skb && !skb_shinfo(skb)->nr_frags)
>  		kfree_skb(skb);
>  
>  	if (err == -EOVERFLOW) {
> -- 
> 2.41.3

Now "!skb_shinfo(skb)->nr_frags" feels redundant? It's either
"skb && !xs->skb" and we own the kfree. or "xs->skb != NULL" and we
want xsk_drop_skb? Or am I missing something?

