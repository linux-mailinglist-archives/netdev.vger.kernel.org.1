Return-Path: <netdev+bounces-274360-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDf4IB7qzWkLjAYAu9opvQ
	(envelope-from <netdev+bounces-274360-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 06:01:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A4738355A
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 06:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6622303320E
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 04:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BAA358369;
	Thu,  2 Apr 2026 04:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EjTRUG2g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24F730E84B
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 04:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775102492; cv=pass; b=PPY19pmWSmlVZ4J31crU6ZJNKwHvAamffEAuugswBtTHoMI4wBgxWeeoaZYMrJTrh0WEOVOKy1ac9u4Xny4RdXeKtoXzPcFgpj5s3lpdla0mkAMzq2ABrfJ8IaP15XFtwcIRcjFELTzxsXj58SmwsAWA7zH3oj9s1gf+9+12vaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775102492; c=relaxed/simple;
	bh=1LdlDt6jmLrY8FNpB2IuDTi4XlODfOTCL66SsUvxy7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=swTyZnt5c5RYlzCshyMYWuL0zuSPr/q3VyzFlY34l7LkM1DGbLsV6aHxVrYpF0p4T6W9mwRduxqx3dsWlyFY2ibHC3ictFbZ1CWX4ptMpof+czEZaX5cjAR6QVfL2yShMzzxxFlq7noiUwgOXNhRwBS7FZbjsEB6VCCF6mm1SWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EjTRUG2g; arc=pass smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8a210c813f8so4249936d6.0
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 21:01:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775102489; cv=none;
        d=google.com; s=arc-20240605;
        b=EMVDsb4z3HrqvEAZS7JDhoIOvZMOlNQMxBTxkjt015zzsI9WJ2WEUWREIAeqZz/Le9
         BWG330oeTmUQ1uR0mcQ2Lfq9PWt6mkrdxBXcgU5LCVD0l/RNw5dLX73plyMFkr3LQGQT
         MmzFkh/Kh/1UPPzlvXJhF2LZDfwnvk2Sxjruxviudq/JDyLNRTXs2wJrYTMYxVV+Asbg
         Y/QQlFXnGpVeTM3vVxgg35VFtUZzjyjPIUBZqcxKf86Doq6n0ZyH3PNl0uSR4d7iMEHf
         YHBSt040KzYgDKRRVT20/FJAG+LPbNIeyhDHHM7fT6B5M1GOGHgHy347w9WpmaneeWR3
         7dPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ei3SX3G2s38D0KrFFaR3yQIVdKo46K0pf7MsWAZMuPY=;
        fh=ldmlPzGG+XzgNgSK5UXd6gCYAsneKP/yaCgbejaOPTI=;
        b=gGS70G7PSlfNaUrKQhYiitBNtBfxdjJMLg1fJPjr0blm+NsC6gzk+PvSgIUBCTifkF
         YvWK2o8BpYkgiqakt3rS7ElLZ0QgzzZbdMuVnaNeMCEAxKtja88mz/vTMLSMVo+FqS0i
         7tzXcAXbO2PatpU1CN1FWdX1eXAMGiPjZjbYgEwTkfmezH8fOci8/Vi5jDDsUcdOX4P+
         MoDXCZuCprc+jG3FUZeWxpkXuRGsNLRJrVHMs3eR7vngeGt/ZthoDWeqijvnJkbTEsdp
         /go+APxq7DDcEQ0Pq8hcJeU98Q7X5Y7WZ7lUPSuvKZgcV5quedRSerOBn6ewnDQjg0QT
         B1Hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775102489; x=1775707289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ei3SX3G2s38D0KrFFaR3yQIVdKo46K0pf7MsWAZMuPY=;
        b=EjTRUG2glylztXrEip2pEFDwmztsZ4gUic4aluaeDwlJH+fmgJih6KwFRpracCQeH5
         ScCRDIf02X5bCm/AaJzw/cpzZKXqzsSPcOT01YqDZJBTr0y13d+jT0WaZ6zME+YN/3IE
         uOV/HePk/QaWgk7XD9FLnyqzJqOJN7e3D6EgT3pi3+nlxiMCNrf2iesC1RfM2KnlgPFj
         VW+ejGg6EzgT0SMXpOJZbv5ImTaaVIeSMbjPS3gvtbAl8rI9hQKc3+TrqCg26vpig8ZG
         233LkxZHQtrRp56sW3sTIPOu4DmienaF02XxjzyeH5UF3P+MKwwkMwET6hGLw7PF4uLU
         e1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775102489; x=1775707289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ei3SX3G2s38D0KrFFaR3yQIVdKo46K0pf7MsWAZMuPY=;
        b=hX5H8aBCoDkdInvLstLAAyqwFdPE85I3GLMZQlZQwYYYe26RX23OrUzMxvHaHQriHt
         Lk9/ThnDbu0qYRM0XnJXHxvmZAF3rwpBmb5d5dnkJJANkYaJuZSWLCXK0toL546cAr89
         4feZA+xcSbZWuDvhqyr+YGfxNwymrTjzQBPI/BvIzEkqxRWbxpIZ0cc1NCg9jj9IoF5F
         fs9tKQmrteNG75BHpapSmtEB7EJwQeQjE1rm805Hr+hMjYhrqQPRozLsgYPu+0RZm9F/
         BrpMt3v5BqWkeJ7doxso0ASK0f3jrbLWIPEP/5pt3jH0agHME+Tr+ePZZGNymW/aEeZ/
         69fA==
X-Gm-Message-State: AOJu0YywLsHtHxL7zT2nZjwKe6Fgd4hUBVHRBYeF1cmggyslSw8FaoDh
	34D1+J37mYJT6i+0tfv9zd8HhoEYI5RKoA3TPohw4R1/wQMychKZaUcnCAuZdqbn1rqFvGko0fh
	O+GHJ8GLYJXEOWc3GUX0AoaFkmw3QvrdzjN5xqLxEweVN0/aCoEyGBJJ1oHA=
X-Gm-Gg: ATEYQzwNT8metPCNqFqLFp0Mbj2g359zuZkkQPJZdkwSDA/VYnmqxv9Di0fv2u0nKGT
	tYyyRYWKrZdwUSeUZVJYwhtr4DwaUGg8D7HISi2XIpsRGzoIslP7lhGa8c8pJkmSsqC2n1BHFB5
	bKbQ9QrCiStlbedbFUUsOnqSUv/GTHjQd7CmlwAsprFMHrHw3b3U6ZwUENpFItwMPPK/pVhuH2J
	kxkOK8KZgWs55pWM0yCeBS/XM9ubJvA637yDJde8fGjn7BxWnRa289AcWNKi6BgV81ik486tQ55
	05KqLOTw
X-Received: by 2002:a05:622a:2b08:b0:50b:48a6:6ba4 with SMTP id
 d75a77b69052e-50d3bd3ac41mr85630311cf.48.1775102489074; Wed, 01 Apr 2026
 21:01:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402033138.388574-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260402033138.388574-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 1 Apr 2026 21:01:17 -0700
X-Gm-Features: AQROBzDO2EXTCqKgPEsclvEUttkZBXr41LCEacZtE-Rldds-MyHmszsQr-VIAjA
Message-ID: <CANn89iLdRZd-qO4tRpSGamHpggh=r5vM4xes5npYCnkwcNG89A@mail.gmail.com>
Subject: Re: [PATCH net v1] net: skb: fix cross-cache free of KFENCE-allocated
 skb head
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Antonius <antonius@bluedragonsec.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Michal Luczaj <mhal@rbox.co>, Mina Almasry <almasrymina@google.com>, 
	Eric Biggers <ebiggers@google.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Alexander Duyck <alexanderduyck@fb.com>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274360-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,linux.dev:email]
X-Rspamd-Queue-Id: F3A4738355A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 1, 2026 at 8:32=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.dev=
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
> slab_build_skb() =E2=86=92 ksize() returns that exact value. After subtra=
cting
> skb_shared_info overhead, skb_end_offset ends up matching
> SKB_SMALL_HEAD_HEADROOM, causing skb_kfree_head() to incorrectly free
> the object to skb_small_head_cache instead of back to the original
> kmalloc cache, resulting in a slab cross-cache free:
>
>   kmem_cache_free(skbuff_small_head): Wrong slab cache. Expected
>   skbuff_small_head but got kmalloc-1k
>
> Fix this by adding an is_kfence_address() check in skb_kfree_head().
> When the head is a KFENCE object, we skip the kmem_cache_free() path
> and fall through to kfree(), which correctly handles KFENCE objects
> via kfence_free(). The check compiles away when CONFIG_KFENCE is
> disabled.
>
> Fixes: bf9f1baa279f ("net: add dedicated kmem_cache for typical/small skb=
->head")
> Reported-by: Antonius <antonius@bluedragonsec.com>
> Closes: https://lore.kernel.org/netdev/CAK8a0jxC5L5N7hq-DT2_NhUyjBxrPocoi=
DazzsBk4TGgT1r4-A@mail.gmail.com/
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  net/core/skbuff.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 0e217041958a..87cecd40381b 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -91,6 +91,7 @@
>  #include <linux/user_namespace.h>
>  #include <linux/indirect_call_wrapper.h>
>  #include <linux/textsearch.h>
> +#include <linux/kfence.h>
>
>  #include "dev.h"
>  #include "devmem.h"
> @@ -1083,7 +1084,8 @@ static int skb_pp_frag_ref(struct sk_buff *skb)
>
>  static void skb_kfree_head(void *head, unsigned int end_offset)
>  {
> -       if (end_offset =3D=3D SKB_SMALL_HEAD_HEADROOM)
> +       if (end_offset =3D=3D SKB_SMALL_HEAD_HEADROOM &&
> +           !is_kfence_address(head))
>                 kmem_cache_free(net_hotdata.skb_small_head_cache, head);
>         else
>                 kfree(head);

Oh well, time to simply call kfree(head) ?

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 3d6978dd0aa83f63984b994359d0c914c6427a00..6b35aed23b8936409f6b0d4ee8d=
378f726c569c6
100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1072,10 +1072,7 @@ static int skb_pp_frag_ref(struct sk_buff *skb)

 static void skb_kfree_head(void *head, unsigned int end_offset)
 {
-       if (end_offset =3D=3D SKB_SMALL_HEAD_HEADROOM)
-               kmem_cache_free(net_hotdata.skb_small_head_cache, head);
-       else
-               kfree(head);
+       kfree(head);
 }

 static void skb_free_head(struct sk_buff *skb)

