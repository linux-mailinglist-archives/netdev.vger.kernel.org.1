Return-Path: <netdev+bounces-43680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 640367D4327
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 01:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0F022816B2
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 23:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C7124207;
	Mon, 23 Oct 2023 23:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="NrGgcT1r"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76F724204
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 23:22:50 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD50EDE
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 16:22:48 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c4fdf94666so51397441fa.2
        for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 16:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1698103367; x=1698708167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRqLVtJ4+w6Q7VE/TH5E+yurITf2hF65g/YIWSM61UI=;
        b=NrGgcT1rZp9qMmxAnyHVNstXUYv6rt2UGqQiFTIt9ir6JX0xKKueSdQs7Wu0LLL2Ac
         Tgag75fIkZRG/fElY8geqyDJJvVnbYHF9Gya4nWbvB1f3YgZ0xHlK9UsKrKPX1jYZPD5
         PKTfQ6/3x7DrL1Odk4GrSnpY6heb74XhClsjXoEF4xO5g6Frgh34o7wza1NOPIQ0ykO1
         9K89tmR1s8QHONUTQBYImaJcSM05a4ZmGjYLa3+8+pSjkn1B2q51uK7V0azaHS43H/gR
         szbxuxGSIIbHwE1bVnBR8ipuhGh878O0cX1tSSEFCNmtLYI4bMz6odP9bWuiEPtYxKOw
         wEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698103367; x=1698708167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZRqLVtJ4+w6Q7VE/TH5E+yurITf2hF65g/YIWSM61UI=;
        b=b508oeukw+cbt0AbXbij+34RDxBVI6IXvBsUur3HXsByEYo0JRkNRHV5ql6tJVCAWL
         dUZmGIn1NPJczwWNJwJ5PLNDc8sAFlZB0uCif+pgVusk7fQ5n4E7B6+0Vf89AZpReW3S
         dP4AAJmltZvCqWw3Urv586IchiJLTi1mdyDq1FO6kxyg9wtxqL4QbMgvtS+DFam5eW9V
         vkBcaWOt0kHhtMbPANkPBb6dkSazexKqR3fZbTHWivFEDzimSaaa0MDoHSy238IowfIr
         ULu/xMWW52S7AG1R6WJo+vIzOGBh+E3Kw66LKt0UiMdkucMdqAJhkgS9hJnBay4Q5DAS
         J3qQ==
X-Gm-Message-State: AOJu0Yz2d+x2tAyDyTffo60dU+Q1kH5NMNrIzXaX59SQCYmzTMYLsDQJ
	/52DSvKycm3iEnAmX+YJvIFDN8qtGAN9rXgIwgSX3dQ/pZK6sEJyT+Q=
X-Google-Smtp-Source: AGHT+IGrfm5czbpRabF9/H2HucnSiA1Nms8R7DXTnfVVdNdF09Z9p2OOZlW7bFdTwCxsfO3w3b8p8sdYkkW250uGLeE=
X-Received: by 2002:a2e:9691:0:b0:2bf:f32a:1f64 with SMTP id
 q17-20020a2e9691000000b002bff32a1f64mr7583173lji.18.1698103366961; Mon, 23
 Oct 2023 16:22:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABWYdi1kiu1g1mAq6DpQWczg78tMzaVFnytNMemZATFHqYSqYw@mail.gmail.com>
 <20231020104728.2060-1-hdanton@sina.com> <CABWYdi0N7uvDex5CdKD60hNQ6UFuqoB=Ss52yQu6UoMJm0MFPw@mail.gmail.com>
 <20231021012322.1799-1-hdanton@sina.com>
In-Reply-To: <20231021012322.1799-1-hdanton@sina.com>
From: Ivan Babrou <ivan@cloudflare.com>
Date: Mon, 23 Oct 2023 16:22:35 -0700
Message-ID: <CABWYdi0j4yXWV6-Pr=2q7S6SQSZR7O6F61BLRdU=gDxvuQ3e1w@mail.gmail.com>
Subject: Re: wait_for_unix_gc can cause CPU overload for well behaved programs
To: Hillf Danton <hdanton@sina.com>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 6:23=E2=80=AFPM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On Fri, 20 Oct 2023 10:25:25 -0700 Ivan Babrou <ivan@cloudflare.com>
> >
> > This could solve wait_for_unix_gc spinning, but it wouldn't affect
> > unix_gc itself, from what I understand. There would always be one
> > socket writer or destroyer punished by running the gc still.
>
> See what you want. The innocents are rescued by kicking a worker off.
> Only for thoughts.
>
> --- x/net/unix/garbage.c
> +++ y/net/unix/garbage.c
> @@ -86,7 +86,6 @@
>  /* Internal data structures and random procedures: */
>
>  static LIST_HEAD(gc_candidates);
> -static DECLARE_WAIT_QUEUE_HEAD(unix_gc_wait);
>
>  static void scan_inflight(struct sock *x, void (*func)(struct unix_sock =
*),
>                           struct sk_buff_head *hitlist)
> @@ -185,24 +184,25 @@ static void inc_inflight_move_tail(struc
>                 list_move_tail(&u->link, &gc_candidates);
>  }
>
> -static bool gc_in_progress;
> +static void __unix_gc(struct work_struct *w);
> +static DECLARE_WORK(unix_gc_work, __unix_gc);
> +
>  #define UNIX_INFLIGHT_TRIGGER_GC 16000
>
>  void wait_for_unix_gc(void)
>  {
>         /* If number of inflight sockets is insane,
> -        * force a garbage collect right now.
> -        * Paired with the WRITE_ONCE() in unix_inflight(),
> -        * unix_notinflight() and gc_in_progress().
> -        */
> -       if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC &&
> -           !READ_ONCE(gc_in_progress))
> -               unix_gc();
> -       wait_event(unix_gc_wait, gc_in_progress =3D=3D false);
> +        * kick a garbage collect right now.
> +        *
> +        * todo s/wait_for_unix_gc/kick_unix_gc/
> +        */
> +       if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC /2)
> +               queue_work(system_unbound_wq, &unix_gc_work);
>  }
>
> -/* The external entry point: unix_gc() */
> -void unix_gc(void)
> +static DEFINE_MUTEX(unix_gc_mutex);
> +
> +static void __unix_gc(struct work_struct *w)
>  {
>         struct sk_buff *next_skb, *skb;
>         struct unix_sock *u;
> @@ -211,15 +211,10 @@ void unix_gc(void)
>         struct list_head cursor;
>         LIST_HEAD(not_cycle_list);
>
> +       if (!mutex_trylock(&unix_gc_mutex))
> +               return;
>         spin_lock(&unix_gc_lock);
>
> -       /* Avoid a recursive GC. */
> -       if (gc_in_progress)
> -               goto out;
> -
> -       /* Paired with READ_ONCE() in wait_for_unix_gc(). */
> -       WRITE_ONCE(gc_in_progress, true);
> -
>         /* First, select candidates for garbage collection.  Only
>          * in-flight sockets are considered, and from those only ones
>          * which don't have any external reference.
> @@ -325,11 +320,12 @@ void unix_gc(void)
>         /* All candidates should have been detached by now. */
>         BUG_ON(!list_empty(&gc_candidates));
>
> -       /* Paired with READ_ONCE() in wait_for_unix_gc(). */
> -       WRITE_ONCE(gc_in_progress, false);
> -
> -       wake_up(&unix_gc_wait);
> -
> - out:
>         spin_unlock(&unix_gc_lock);
> +       mutex_unlock(&unix_gc_mutex);
> +}
> +
> +/* The external entry point: unix_gc() */
> +void unix_gc(void)
> +{
> +       __unix_gc(NULL);
>  }
> --

This one results in less overall load than Kuniyuki's proposed patch
with my repro:

* https://lore.kernel.org/netdev/20231020220511.45854-1-kuniyu@amazon.com/

My guess is that's because my repro is the one that is getting penalized th=
ere.

There's still a lot work done in unix_release_sock here, where GC runs
as long as you have any fds inflight:

* https://elixir.bootlin.com/linux/v6.1/source/net/unix/af_unix.c#L670

Perhaps it can be improved.

