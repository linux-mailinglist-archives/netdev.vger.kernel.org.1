Return-Path: <netdev+bounces-283910-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFvUCWi1+Gm3zAIAu9opvQ
	(envelope-from <netdev+bounces-283910-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 17:04:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6FB4C05D0
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 17:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56C61301F7B7
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 14:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D92A379980;
	Mon,  4 May 2026 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVPFtxR7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499BB3DF019
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 14:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777906748; cv=none; b=MXh58CHtPOUwGdihBIsUFfIp5KSCMEkkWq9TUJrTb2S/+/9xifEqrx5buuvKX8xag+VobTawQkRK0ENgEx11w5IPOfVUWDTELkws9P0cj9VEijkQWjnTmH/q7/MNOE3Q2RM1lsKlj/2sR4MIeIY06HK+e9diuJklNmHGKyLQ4Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777906748; c=relaxed/simple;
	bh=CsDy/LfJFNDUkKNXWKhbZTlzGt8sVL1eoAGYyZGFDDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4mO7sTo8DJdeaoesITTP9t7rdVnC85svB1eIizP+kDrKWAV2uQcH6h8wAIXqNJsk/Bl2RIEFXBUFmw4Jhpfkg7rS6d9z8rahfdX035lccsVz4oY5YhqVMZ4W6dDvcL4iUzXQdG+UU3jRVnKyKflK43RtKQqOt1o0AGF1ph7dpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVPFtxR7; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c822652f82aso627021a12.3
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 07:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777906744; x=1778511544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b8q/EPPyhCK5sjTLWIJy3Uk1FD9dao+2uQzQee1Mzzc=;
        b=aVPFtxR7Fwl81rIfLRl++vTcutGGx7w0pqeP8kywybU6xUHZfe7sgcb802FuGDajcr
         OV4R4pNJyfSOmBJqWVFv0sWluqX0sEAEok3EwkW1cwJ8rc/N9tR7yrSiXiSv4vi1CI6Q
         bZr+U0wwuyhKASfxw/r33j9BJvCq1s/D3v+RikkuZc4pxOXIsgJzCRiqIBMFbBP00GDh
         kIsh5xBesdE4HyZthgKM52SujgmIZz6P+EVJIVxpZcvXZ3DlFgzrhZ1cxp24+lYbRsxY
         /d8kyYwRPgyr1856K4JVNuc3kBuJcBiPTdD5ycEiEX271yG8TKH6k7FC9a08GNRg4kNh
         9qYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777906744; x=1778511544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b8q/EPPyhCK5sjTLWIJy3Uk1FD9dao+2uQzQee1Mzzc=;
        b=aVP0sNum/EPPHubQGLvPZZ6ZYzvGBLACfGkK9y8KFjhf15Di4VxKjxdK2IxHF0uxTA
         kQzrUzThn0Ndr6oaE0ZeDPmyowik6KKxEls23/qh4JuoXzXt9ltMct6yyJ9xz45kWtjw
         TGWL+XzlWzWhzSaWvisBVEkVF61CcIM57k/JphYRtqZoD0WX9K4TSocW/8equyz/HoKD
         gsCnX5oyvs4VGrqtPUfZevE04d6fZ2TFZYUs9IGCZEFfsPncWJ0xyElOsYBW4iYsFp7Q
         64ey9m2awbchsX/hlwrQ6u6wE4S9zDQiNd5tvcrQEt/J6ibxFOvSscHZKJK0I4RJmonx
         cwBQ==
X-Forwarded-Encrypted: i=1; AFNElJ/5bFhd0heAUrsj+xk+5U3zGwn3XUcGs4bk8tZaCyaTFg5WAul8AjNl9vuXwNd2xezJJyWi19Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2HnDCWCoIBpX+LVHwVl5EPALVVAZrDfJjzu+AGlH/ppIINoSE
	iqwPF8tOeZYzHKctAttuAbkbG8S+gyKIv3CpwlZjD1F9N1k7owFKOfTQ
X-Gm-Gg: AeBDievnbasCV86EtDC4NrvEngTW+bJJ/jAyHdInMFADwOrxTIc1NtoRnXuYoB9FBA7
	GQpstIhLlx+B8kwmjQ5z2ZH35Zatm+CToKW4WHQz+LOwX3rVra/8dTpL+9rYcwj/08qesseCWHS
	k+sQpgNN9v0EfO5iGYp/12ERW2rVFwAGvxGM4gw5k57J6d2CtteLTwpP14nFHH6yM/rbXNy1f1A
	6+FWJtZoqKxAMvrI/ZqD59cwsBKgwAQWL20YbTljOGaQ8u+JheI5I+5zDAyTsgQPPbMbMy6KSNL
	BddfMeG8ad1+A7Qg0KchVittWii5fVPZwJvoA5zovl+5/tUSp6fmWDe1UvASvbcFAtaZQOEmGSf
	/Qd4ASz5z/l/4C8PwWSfdLRk2WnRrkIAcD3Kv9GzRzdhIkzLMlMxcek5z5ISMxwD4jXeEv5aNz/
	rnc2ywLBOyhk+JOD/BTywNKhBHZHg=
X-Received: by 2002:a05:6a21:9981:b0:3a2:df61:50e6 with SMTP id adf61e73a8af0-3a7f1caabb5mr10192770637.47.1777906744036;
        Mon, 04 May 2026 07:59:04 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:50::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbca323dsm10468070a12.28.2026.05.04.07.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 07:59:03 -0700 (PDT)
Date: Mon, 4 May 2026 07:59:03 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org, 
	andrew+netdev@lunn.ch, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net v5 8/8] xsk: fix u64 descriptor address truncation on
 32-bit architectures
Message-ID: <afi0I6UZ9FlueHBE@devvm7509.cco0.facebook.com>
References: <20260502200722.53960-1-kerneljasonxing@gmail.com>
 <20260502200722.53960-9-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260502200722.53960-9-kerneljasonxing@gmail.com>
X-Rspamd-Queue-Id: 8E6FB4C05D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283910-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,devvm7509.cco0.facebook.com:mid,fomichev.me:email]

On 05/02, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> In copy mode TX, xsk_skb_destructor_set_addr() stores the 64-bit
> descriptor address into skb_shinfo(skb)->destructor_arg (void *) via a
> uintptr_t cast:
> 
>     skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
> 
> On 32-bit architectures uintptr_t is 32 bits, so the upper 32 bits of
> the descriptor address are silently dropped. In XDP_ZEROCOPY unaligned
> mode the chunk offset is encoded in bits 48-63 of the descriptor
> address (XSK_UNALIGNED_BUF_OFFSET_SHIFT = 48), meaning the offset is
> lost entirely. The completion queue then returns a truncated address to
> userspace, making buffer recycling impossible.
> 
> Fix this by handling the 32-bit case directly in
> xsk_skb_destructor_set_addr(): when !CONFIG_64BIT, allocate an
> xsk_addrs struct (the same path already used for multi-descriptor
> SKBs) to store the full u64 address. The existing tagged-pointer logic
> in xsk_skb_destructor_is_addr() stays unchanged: slab pointers returned
> from kmem_cache_zalloc() are always word-aligned and therefore have
> bit 0 clear, which correctly identifies them as a struct pointer
> rather than an inline tagged address on every architecture.
> 
> Factor the shared kmem_cache_zalloc + destructor_arg assignment into
> __xsk_addrs_alloc() and add a wrapper xsk_addrs_alloc() that handles
> the inline-to-list upgrade (is_addr check + get_addr + num_descs = 1).
> The three former open-coded kmem_cache_zalloc call sites now reduce to
> a single call each.
> 
> Propagate the -ENOMEM from xsk_skb_destructor_set_addr() through
> xsk_skb_init_misc() so the caller can clean up the skb via kfree_skb()
> before skb->destructor is installed.
> 
> The overhead is one extra kmem_cache_zalloc per first descriptor on
> 32-bit only; 64-bit builds are completely unchanged.
> 
> Closes: https://lore.kernel.org/all/20260419045824.D9E5EC2BCAF@smtp.kernel.org/
> Fixes: 0ebc27a4c67d ("xsk: avoid data corruption on cq descriptor number")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

LGTM, thanks!

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

