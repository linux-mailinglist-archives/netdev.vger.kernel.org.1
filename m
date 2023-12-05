Return-Path: <netdev+bounces-54151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CD28061AC
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 23:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B9591C20F41
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 22:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFFD6E5AB;
	Tue,  5 Dec 2023 22:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpFXAnAw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AC1188
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 14:28:29 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5c2066accc5so2839677a12.3
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 14:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701815308; x=1702420108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/5HEBXmP51sYvurHUGgJkEYAh08IJ/3eLFaMaZMIC8=;
        b=SpFXAnAwyKHHKZGErSeATo/kc+Lm4meZlnmmFkc5Ld426o3OmXChj0IrE/u7xcdBlx
         rYTWNi5ZHDOU1TmD8cfr5ajejQBywRHfu4YkxjXNRZMxcPp3FhPpxx3FK5kfqQXZP+wu
         x3/8g0NqqQVbBJNn11vkradxDUlYi+ETDDuE5LaD24HkxOJDGC6hfyAwiaG3X18DgRzR
         L9KQB3RCIC+0caAp7EmYEgpHg+s3MkTH3KyanIOTnPMq2zm7D+MvYF+F2/FS0fCuPnPR
         snxqZVuqqt8Cos9haN7aFquL0Au/7xj8uQx5eLSANwOsMh8KviOAJpVKtR3IXCfd4vtS
         5ZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701815308; x=1702420108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/5HEBXmP51sYvurHUGgJkEYAh08IJ/3eLFaMaZMIC8=;
        b=Z2456hM5iQzy4UHx2kQ/Dj2rNeeI+ogAQyUHE1xrfXQdHgpkEomjOg6iITMfHVrd2k
         H8xzs8ryczQGvDVeFnqoj6yjUpUUk/a1ztEqjSqI8GtTEMuOVGOoJgZgizYfdWt+/V4X
         Nv+eikCzHA5tA7eaeR67zsxycpSSI4Oz4fPAFfTFKVnFSamvllH5ir8sqe8syAXCXMVD
         QhjBzBD0bpI+i5lHyHyZ8e9WoGcPF9Z+Z9Bvl3L+alh4V4SpfB4aAJvsXWjcYTyqpb8J
         rNR1ny1q0kG0FnY1v7KBCK/SLLnOzXrBiV1irqf6tk6DzBI4EjHPyW2TmY2wAtEGfC/M
         jsgA==
X-Gm-Message-State: AOJu0YxVFckXIEy3J5TgyHh8AkrDjFWIefpNYMHXd6ZrCmXXdJtCaUKe
	c3jrr/nXXSzlf5SB7nt6Lab8hyYy16jw47k2hCM=
X-Google-Smtp-Source: AGHT+IHm2Y96uUCzln96C0ma/oXFdIj+hfxYl9MobMCh2l3LzHabc8fILD1e3PtDYyGoP4l+M9ip2OOpqwiRaYcCRks=
X-Received: by 2002:a05:6a20:734e:b0:18c:19d1:5e91 with SMTP id
 v14-20020a056a20734e00b0018c19d15e91mr3995068pzc.16.1701815308355; Tue, 05
 Dec 2023 14:28:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201230011.2925305-1-victor@mojatatu.com> <20231201230011.2925305-4-victor@mojatatu.com>
In-Reply-To: <20231201230011.2925305-4-victor@mojatatu.com>
From: Dave Taht <dave.taht@gmail.com>
Date: Tue, 5 Dec 2023 14:28:15 -0800
Message-ID: <CAA93jw520FBOfmhpOBNyfFPy1UKbjOdc52=0L8uzADUKQyeLHQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] net: sched: Add initial TC error skb drop reasons
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	daniel@iogearbox.net, dcaratti@redhat.com, netdev@vger.kernel.org, 
	kernel@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 6:00=E2=80=AFPM Victor Nogueira <victor@mojatatu.com=
> wrote:
>
> Continue expanding Daniel's patch by adding new skb drop reasons that
> are idiosyncratic to TC.
>
> More specifically:
>
> - SKB_DROP_REASON_TC_EXT_COOKIE_NOTFOUND: tc cookie was looked up using
>   ext, but was not found.
>
> - SKB_DROP_REASON_TC_COOKIE_EXT_MISMATCH: tc ext was looked up using cook=
ie
>   and either was not found or different from expected.
>
> - SKB_DROP_REASON_TC_CHAIN_NOTFOUND: tc chain lookup failed.
>
> - SKB_DROP_REASON_TC_RECLASSIFY_LOOP: tc exceeded max reclassify loop
>   iterations
>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> ---
>  include/net/dropreason-core.h | 30 +++++++++++++++++++++++++++---
>  net/sched/act_api.c           |  3 ++-
>  net/sched/cls_api.c           | 22 ++++++++++++++--------
>  3 files changed, 43 insertions(+), 12 deletions(-)
>
> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.=
h
> index 3c70ad53a49c..fa6ace8f1611 100644
> --- a/include/net/dropreason-core.h
> +++ b/include/net/dropreason-core.h
> @@ -85,7 +85,11 @@
>         FN(IPV6_NDISC_BAD_OPTIONS)      \
>         FN(IPV6_NDISC_NS_OTHERHOST)     \
>         FN(QUEUE_PURGE)                 \
> -       FN(TC_ERROR)                    \
> +       FN(TC_EXT_COOKIE_NOTFOUND)      \
> +       FN(TC_COOKIE_EXT_MISMATCH)      \
> +       FN(TC_COOKIE_MISMATCH)          \
> +       FN(TC_CHAIN_NOTFOUND)           \
> +       FN(TC_RECLASSIFY_LOOP)          \
>         FNe(MAX)
>
>  /**
> @@ -376,8 +380,28 @@ enum skb_drop_reason {
>         SKB_DROP_REASON_IPV6_NDISC_NS_OTHERHOST,
>         /** @SKB_DROP_REASON_QUEUE_PURGE: bulk free. */
>         SKB_DROP_REASON_QUEUE_PURGE,
> -       /** @SKB_DROP_REASON_TC_ERROR: generic internal tc error. */
> -       SKB_DROP_REASON_TC_ERROR,
> +       /**
> +        * @SKB_DROP_REASON_TC_EXT_COOKIE_NOTFOUND: tc cookie was looked =
up
> +        * using ext, but was not found.
> +        */
> +       SKB_DROP_REASON_TC_EXT_COOKIE_NOTFOUND,
> +       /**
> +        * @SKB_DROP_REASON_TC_COOKIE_EXT_MISMATCH: tc ext was lookup usi=
ng
> +        * cookie and either was not found or different from expected.
> +        */
> +       SKB_DROP_REASON_TC_COOKIE_EXT_MISMATCH,
> +       /**
> +        * @SKB_DROP_REASON_TC_COOKIE_MISMATCH: tc cookie available but w=
as
> +        * unable to match to filter.
> +        */
> +       SKB_DROP_REASON_TC_COOKIE_MISMATCH,
> +       /** @SKB_DROP_REASON_TC_CHAIN_NOTFOUND: tc chain lookup failed. *=
/
> +       SKB_DROP_REASON_TC_CHAIN_NOTFOUND,
> +       /**
> +        * @SKB_DROP_REASON_TC_RECLASSIFY_LOOP: tc exceeded max reclassif=
y loop
> +        * iterations.
> +        */
> +       SKB_DROP_REASON_TC_RECLASSIFY_LOOP,
>         /**
>          * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
>          * shouldn't be used as a real 'reason' - only for tracing code g=
en
> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> index 12ac05857045..429cb232e17b 100644
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c
> @@ -1098,7 +1098,8 @@ int tcf_action_exec(struct sk_buff *skb, struct tc_=
action **actions,
>                         }
>                 } else if (TC_ACT_EXT_CMP(ret, TC_ACT_GOTO_CHAIN)) {
>                         if (unlikely(!rcu_access_pointer(a->goto_chain)))=
 {
> -                               tcf_set_drop_reason(skb, SKB_DROP_REASON_=
TC_ERROR);
> +                               tcf_set_drop_reason(skb,
> +                                                   SKB_DROP_REASON_TC_CH=
AIN_NOTFOUND);
>                                 return TC_ACT_SHOT;
>                         }
>                         tcf_action_goto_chain_exec(a, res);
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index 32457a236d77..5012fc0a24a1 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -1682,13 +1682,15 @@ static inline int __tcf_classify(struct sk_buff *=
skb,
>                          */
>                         if (unlikely(n->tp !=3D tp || n->tp->chain !=3D n=
->chain ||
>                                      !tp->ops->get_exts)) {
> -                               tcf_set_drop_reason(skb, SKB_DROP_REASON_=
TC_ERROR);
> +                               tcf_set_drop_reason(skb,
> +                                                   SKB_DROP_REASON_TC_CO=
OKIE_MISMATCH);
>                                 return TC_ACT_SHOT;
>                         }
>
>                         exts =3D tp->ops->get_exts(tp, n->handle);
>                         if (unlikely(!exts || n->exts !=3D exts)) {
> -                               tcf_set_drop_reason(skb, SKB_DROP_REASON_=
TC_ERROR);
> +                               tcf_set_drop_reason(skb,
> +                                                   SKB_DROP_REASON_TC_CO=
OKIE_EXT_MISMATCH);
>                                 return TC_ACT_SHOT;
>                         }
>
> @@ -1717,7 +1719,8 @@ static inline int __tcf_classify(struct sk_buff *sk=
b,
>         }
>
>         if (unlikely(n)) {
> -               tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
> +               tcf_set_drop_reason(skb,
> +                                   SKB_DROP_REASON_TC_COOKIE_MISMATCH);
>                 return TC_ACT_SHOT;
>         }
>
> @@ -1729,7 +1732,8 @@ static inline int __tcf_classify(struct sk_buff *sk=
b,
>                                        tp->chain->block->index,
>                                        tp->prio & 0xffff,
>                                        ntohs(tp->protocol));
> -               tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
> +               tcf_set_drop_reason(skb,
> +                                   SKB_DROP_REASON_TC_RECLASSIFY_LOOP);
>                 return TC_ACT_SHOT;
>         }
>
> @@ -1767,7 +1771,8 @@ int tcf_classify(struct sk_buff *skb,
>                                 n =3D tcf_exts_miss_cookie_lookup(ext->ac=
t_miss_cookie,
>                                                                 &act_inde=
x);
>                                 if (!n) {
> -                                       tcf_set_drop_reason(skb, SKB_DROP=
_REASON_TC_ERROR);
> +                                       tcf_set_drop_reason(skb,
> +                                                           SKB_DROP_REAS=
ON_TC_EXT_COOKIE_NOTFOUND);
>                                         return TC_ACT_SHOT;
>                                 }
>
> @@ -1778,7 +1783,9 @@ int tcf_classify(struct sk_buff *skb,
>
>                         fchain =3D tcf_chain_lookup_rcu(block, chain);
>                         if (!fchain) {
> -                               tcf_set_drop_reason(skb, SKB_DROP_REASON_=
TC_ERROR);
> +                               tcf_set_drop_reason(skb,
> +                                                   SKB_DROP_REASON_TC_CH=
AIN_NOTFOUND);
> +
>                                 return TC_ACT_SHOT;
>                         }
>
> @@ -1800,10 +1807,9 @@ int tcf_classify(struct sk_buff *skb,
>
>                         ext =3D tc_skb_ext_alloc(skb);
>                         if (WARN_ON_ONCE(!ext)) {
> -                               tcf_set_drop_reason(skb, SKB_DROP_REASON_=
TC_ERROR);
> +                               tcf_set_drop_reason(skb, SKB_DROP_REASON_=
NOMEM);
>                                 return TC_ACT_SHOT;
>                         }
> -
>                         ext->chain =3D last_executed_chain;
>                         ext->mru =3D cb->mru;
>                         ext->post_ct =3D cb->post_ct;
> --
> 2.25.1
>
>

I have been meaning to get around to adding
QDISC_DROP_REASON_{CONGEST,OVERFLOW,FLOOD,SPIKE} to
cake/fq_codel/red/etc for some time now. Would this be the right
facility to leverage (or something more direct?) I discussed the why
at netdevconf:

https://docs.google.com/document/d/1tTYBPeaRdCO9AGTGQCpoiuLORQzN_bG3TAkEolJ=
Ph28/edit

Other names welcomed. Otherwise I suppose I will wait for this stuff to lan=
d:

Acked-By: Dave Taht <dave.taht@gmail.com>

--
:( My old R&D campus is up for sale: https://tinyurl.com/yurtlab
Dave T=C3=A4ht CSO, LibreQos

