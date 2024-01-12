Return-Path: <netdev+bounces-63174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B81D782B89F
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 01:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53C951F23046
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 00:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A16657;
	Fri, 12 Jan 2024 00:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sUA8ut+h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E9E379
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 00:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e5afc18f5so17462335e9.3
        for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 16:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705019708; x=1705624508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNPzjMbCaMql7MWIWhwMIOd1UyHIdjfgYJAXuurPtFc=;
        b=sUA8ut+hyY3yfagYlXVsuKZkIk205aB8Dsw4Tbr5JrgpOpzR2WXSio+DMa+BXrence
         JfIJGkL0Wz2x8lDD2RAOMY6uKIs/4EN/CJhCEjGvj2DIBPJhscCt6caFcuFLpFooGFZ5
         3AsCrLTr6+RFyJ1wohpAMiFjdEIn0qIBHTGVe875thflB7vZHEdM8glPK+MaUv6p3rAD
         UhkQvPHbWke+P3sJg0qg++RkRuv83mKLyekVxfhSMUFSSqL7tbix1kr70Ls3l8zpeHQY
         VVAHZo1TXAJgUFQx+11RCG2G/4Tw85//4NzMcbXZ2ALjW8O/s1up9EFyftQy/73tgq9A
         YNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705019708; x=1705624508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNPzjMbCaMql7MWIWhwMIOd1UyHIdjfgYJAXuurPtFc=;
        b=VaTqTrPjcxa5WgnIfpYDDyaALSKV+JsXmT21t5+9Mi8HOhrGScqEq8Xp/GtpmTQgDg
         DlDuQ2YwCoozbxYX9jH/lR6Qs06PhU6y1OSxGxSe2ftRyy+JD2bgVjxvjT5Fk7ZTNEW/
         l1o4YVIU8P10Kc7+csjPYzeu4WPexKy5JVZkinv6MBISieTXKw4ANe9qsxZKS5UzPvY+
         NF1RqBmioO8F1sCRofGph67yWeV3AwxU+F0rCT9t4r8Mo8ssa4NnaxQrnQjLS7KuMaiN
         oSa3dQPrq+4oxCLS7cdk04xPvbbzcU08ZrWRSEpcYdPQ50vObDGCDlqEZg8YWBHyEM+L
         4T/Q==
X-Gm-Message-State: AOJu0YwDcCuwXNayfGXm9jmO6uClPcngCFhXteDa6CwGvD1UZ+pT9NI/
	D6cWreQdzoaXLvf4MpL9xplsVLt4UJFwx1NLC9eAC5DS/eR2
X-Google-Smtp-Source: AGHT+IGjgBG09634J8gUf2EnRzYsdA7P9eS6HFUtPUhsa4bpnOZWHQfAgo7RaApfTVRiX0lzWUoTPnyheUQdYeRWrnE=
X-Received: by 2002:a05:600c:2a15:b0:40d:3112:a2c3 with SMTP id
 w21-20020a05600c2a1500b0040d3112a2c3mr315500wme.73.1705019707579; Thu, 11 Jan
 2024 16:35:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109011455.1061529-1-almasrymina@google.com>
 <20240109011455.1061529-3-almasrymina@google.com> <5219f2cd-6854-0134-560d-8ae3f363b53f@huawei.com>
In-Reply-To: <5219f2cd-6854-0134-560d-8ae3f363b53f@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 11 Jan 2024 16:34:55 -0800
Message-ID: <CAHS8izOtr+jfqQ6xCB3CoN-K_V1-4hPsB4-k5+1z-M3Qy2BbwA@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v5 2/2] net: add netmem to skb_frag_t
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shakeel Butt <shakeelb@google.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 4:45=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/1/9 9:14, Mina Almasry wrote:
>
> ...
>
> >
> > +             if (WARN_ON_ONCE(!skb_frag_page(&skb_shinfo(skb)->frags[0=
]))) {
>
> I am really hate to bring it up again.
> If you are not willing to introduce a new helper,

I'm actually more than happy to add a new helper like:

static inline netmem_ref skb_frag_netmem();

For future callers to obtain frag->netmem to use the netmem_ref directly.

What I'm hung up on is really your follow up request:

"Is it possible to introduce something like skb_frag_netmem() for
netmem? so that we can keep most existing users of skb_frag_page()
unchanged and avoid adding additional checking overhead for existing
users."

With this patchseries, skb_frag_t no longer has a page pointer inside
of it, it only has a netmem_ref. The netmem_ref is currently always a
page, but in the future may not be a page. Can you clarify how we keep
skb_frag_page() unchanged and without checks? What do you expect
skb_frag_page() and its callers to do? We can not assume netmem_ref is
always a struct page. I'm happy to implement a change but I need to
understand it a bit better.

> do you care to use some
> existing API like skb_frag_address_safe()?
>

skb_frag_address_safe() checks that the page is mapped. In this case,
we are not checking if the frag page is mapped; we would like to make
sure that the skb_frag has a page inside of it in the first place.
Seems like a different check from skb_frag_address_safe().

In fact, skb_frag_address[_safe]() actually assume that the skb frag
is always a page currently, I think I need to squash this fix:

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index e59f76151628..bc8b107d0235 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3533,7 +3533,9 @@ static inline void skb_frag_unref(struct sk_buff
*skb, int f)
  */
 static inline void *skb_frag_address(const skb_frag_t *frag)
 {
-       return page_address(skb_frag_page(frag)) + skb_frag_off(frag);
+       return skb_frag_page(frag) ?
+               page_address(skb_frag_page(frag)) + skb_frag_off(frag) :
+               NULL;
 }

 /**
@@ -3545,7 +3547,14 @@ static inline void *skb_frag_address(const
skb_frag_t *frag)
  */
 static inline void *skb_frag_address_safe(const skb_frag_t *frag)
 {
-       void *ptr =3D page_address(skb_frag_page(frag));
+       struct page *page;
+       void *ptr;
+
+       page =3D skb_frag_page(frag);
+       if (!page)
+               return NULL;
+
+       ptr =3D page_address(skb_frag_page(frag));
        if (unlikely(!ptr))
                return NULL;

> > +                     ret =3D -EINVAL;
> > +                     goto out;
> > +             }
> > +
> >               iov_iter_bvec(&msg.msg_iter, ITER_SOURCE,
> > -                           skb_shinfo(skb)->frags, skb_shinfo(skb)->nr=
_frags,
> > -                           msize);
> > +                           (const struct bio_vec *)skb_shinfo(skb)->fr=
ags,
> > +                           skb_shinfo(skb)->nr_frags, msize);
>
> I think we need to use some built-time checking to ensure some consistenc=
y
> between skb_frag_t and bio_vec.
>

I can add static_assert() that bio_vec->bv_len & bio_vec->bv_offset
are aligned with skb_frag_t->len & skb_frag_t->offset.

I can also maybe add a helper skb_frag_bvec() to do the cast instead
of doing it at the calling site. That may be a bit cleaner.

> >               iov_iter_advance(&msg.msg_iter, txm->frag_offset);
> >
> >               do {
> >



--
Thanks,
Mina

