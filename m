Return-Path: <netdev+bounces-37987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0430B7B8363
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 17:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7A8CA2815BB
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 15:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546C118E38;
	Wed,  4 Oct 2023 15:17:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCC018E2D
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 15:17:05 +0000 (UTC)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA5DC6
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 08:17:02 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-59f6441215dso27140587b3.2
        for <netdev@vger.kernel.org>; Wed, 04 Oct 2023 08:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1696432622; x=1697037422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IN5WIKysaV095JDrkaH6KFl3bMCNfb4hE0xbNlkR+WI=;
        b=SLahdtkpCZ9uSW+lkZcC0ktV27g4x3ZaI/QYdA5LOmuNbMVnQmW3kpO3nsZFC5QB5j
         PeZb209MDBo/EY1t/x+G2MT9I8+/7qEYCRnB7J4jJANnmF0AsYboTrl6PSaSSlLyg5aD
         82nFzpXWyCTQLeWtj41lT6nagnEgbQOK57lbNS3C8RgO0t2J0ghKKWNvWAhVZwc6F/QZ
         jfk3kRRwTwImafpER0s5p8cOrh+BTag294qXqagS+RhofuWcsKLdSZKgOfjoN1s8T67o
         Ps0vnooYJ5FoMVu9/MfRpyJr20qzSIjWIPn1CxIrDgaxyi9BKOPMCoD5woPP8zmi9LO8
         /o9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696432622; x=1697037422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IN5WIKysaV095JDrkaH6KFl3bMCNfb4hE0xbNlkR+WI=;
        b=OhI+3dZ/silWVxTq9oOkXN+DShT0k1rPNozbW3/3VO9BijoqLG2fnx/XUi4SJBySX+
         Vh2/5Ka7zUG4SQ4I00KV4f5qwG1jUTG3PP008pms3siDnXk6TdfVCnTDW8xjxgb9PSuA
         L+Cth3bkJMBTW2zyQTFXlRFm6qBbq+Fv+ufUSkrDXhF+FfNl1oK3xakxwE83Hy1PfWKw
         2BOwaLxRkrX38UtfY+bEOseX8qYOYSS+hvl4qHG30MJUsDYEar5fqPjfokD5qSp9Pr4p
         4oImg0k2xIKa00K/gSQyTRencwvqy6HCmYQsRtOyyvmKD2LhNpydFfEpIRyeLwbMpEgf
         eG6A==
X-Gm-Message-State: AOJu0YzZuYFeXYz0ATXAgh+j0pyuQdTPw13EuVKrfgb83O4eRWDoHSSy
	KmRWR+uOf5/WOiXPbfOEU0XQC7CTyfFvtW00BS2GRQ==
X-Google-Smtp-Source: AGHT+IF3gOIOHwzY/EJ4UEawivz5g6FcqEZ4tBc3cxlP5IfgeoL3y+aonS5/cF9+D+3yxBLVKvrpO4rH7ZRnIHAw2Z4=
X-Received: by 2002:a05:6902:188e:b0:d78:be:6f02 with SMTP id
 cj14-20020a056902188e00b00d7800be6f02mr2507137ybb.11.1696432622042; Wed, 04
 Oct 2023 08:17:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZR1maZoAh2W/0Vw6@work>
In-Reply-To: <ZR1maZoAh2W/0Vw6@work>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 4 Oct 2023 11:16:50 -0400
Message-ID: <CAM0EoMkMfvpmxkcSyqC0dOLKDH8_JiJ74u06x7sqUHSehgjOtQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: sched: cls_u32: Fix allocation size in u32_init()
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 4, 2023 at 9:19=E2=80=AFAM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> commit d61491a51f7e ("net/sched: cls_u32: Replace one-element array
> with flexible-array member") incorrecly replaced an instance of
> `sizeof(*tp_c)` with `struct_size(tp_c, hlist->ht, 1)`. This results
> in a an over-allocation of 8 bytes.
>
> This change is wrong because `hlist` in `struct tc_u_common` is a
> pointer:
>
> net/sched/cls_u32.c:
> struct tc_u_common {
>         struct tc_u_hnode __rcu *hlist;
>         void                    *ptr;
>         int                     refcnt;
>         struct idr              handle_idr;
>         struct hlist_node       hnode;
>         long                    knodes;
> };
>
> So, the use of `struct_size()` makes no sense: we don't need to allocate
> any extra space for a flexible-array member. `sizeof(*tp_c)` is just fine=
.
>
> So, `struct_size(tp_c, hlist->ht, 1)` translates to:
>
> sizeof(*tp_c) + sizeof(tp_c->hlist->ht) =3D=3D
> sizeof(struct tc_u_common) + sizeof(struct tc_u_knode *) =3D=3D
>                                                 144 + 8  =3D=3D 0x98 (bye=
s)
>                                                      ^^^
>                                                       |
>                                                 unnecessary extra
>                                                 allocation size
>
> $ pahole -C tc_u_common net/sched/cls_u32.o
> struct tc_u_common {
>         struct tc_u_hnode *        hlist;                /*     0     8 *=
/
>         void *                     ptr;                  /*     8     8 *=
/
>         int                        refcnt;               /*    16     4 *=
/
>
>         /* XXX 4 bytes hole, try to pack */
>
>         struct idr                 handle_idr;           /*    24    96 *=
/
>         /* --- cacheline 1 boundary (64 bytes) was 56 bytes ago --- */
>         struct hlist_node          hnode;                /*   120    16 *=
/
>         /* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
>         long int                   knodes;               /*   136     8 *=
/
>
>         /* size: 144, cachelines: 3, members: 6 */
>         /* sum members: 140, holes: 1, sum holes: 4 */
>         /* last cacheline: 16 bytes */
> };
>
> And with `sizeof(*tp_c)`, we have:
>
>         sizeof(*tp_c) =3D=3D sizeof(struct tc_u_common) =3D=3D 144 =3D=3D=
 0x90 (bytes)
>
> which is the correct and original allocation size.
>
> Fix this issue by replacing `struct_size(tp_c, hlist->ht, 1)` with
> `sizeof(*tp_c)`, and avoid allocating 8 too many bytes.
>
> The following difference in binary output is expected and reflects the
> desired change:
>
> | net/sched/cls_u32.o
> | @@ -6148,7 +6148,7 @@
> | include/linux/slab.h:599
> |     2cf5:      mov    0x0(%rip),%rdi        # 2cfc <u32_init+0xfc>
> |                        2cf8: R_X86_64_PC32     kmalloc_caches+0xc
> |-    2cfc:      mov    $0x98,%edx
> |+    2cfc:      mov    $0x90,%edx
>
> Reported-by: Alejandro Colomar <alx@kernel.org>
> Closes: https://lore.kernel.org/lkml/09b4a2ce-da74-3a19-6961-67883f634d98=
@kernel.org/
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> Changes in v2:
>  - Update subject line.
>  - Update changelog text.
>
> v1:
>  - Link: https://lore.kernel.org/linux-hardening/ZN5DvRyq6JNz20l1@work/
>
>  net/sched/cls_u32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
> index da4c179a4d41..6663e971a13e 100644
> --- a/net/sched/cls_u32.c
> +++ b/net/sched/cls_u32.c
> @@ -366,7 +366,7 @@ static int u32_init(struct tcf_proto *tp)
>         idr_init(&root_ht->handle_idr);
>
>         if (tp_c =3D=3D NULL) {
> -               tp_c =3D kzalloc(struct_size(tp_c, hlist->ht, 1), GFP_KER=
NEL);
> +               tp_c =3D kzalloc(sizeof(*tp_c), GFP_KERNEL);
>                 if (tp_c =3D=3D NULL) {
>                         kfree(root_ht);
>                         return -ENOBUFS;
> --
> 2.34.1
>

