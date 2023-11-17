Return-Path: <netdev+bounces-48858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAD97EFC2C
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 00:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B1111C20506
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 23:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6F34653F;
	Fri, 17 Nov 2023 23:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="JFJ6uCO8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9188D7A
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 15:38:54 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9e62f903e88so331040966b.2
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 15:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1700264333; x=1700869133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2bmbv+oDgkU+IH2O+FV+APsaOjjslIE2eCkoDOr/Uo=;
        b=JFJ6uCO84UDC+42p+2E+aiI3fU1KtxEV1y/DMiB5ULUEdw6W1JbYqGyxcw22bxEA2P
         6jXo5eO9qMOhvQ3Qy3+BkLobM6aZnO9oY5HVxKKKpA8gOLTeNVxxobmEP1F4J6z+oewr
         9/KfZ2yk5gz4J95yiR1PLPsCBFK+W0dsYPHw4XfYCYHVDWw5KSgfMlg4StD0FpkuPOrD
         /v8jKLGeD4+HQS7eBItkWyWOhE0j9Qkw4y7vE7mlRtsgc5L3nl3M//J0OP7DwdXSnVme
         0ljPyBLiGicaRCyL59pD/aQ1r0Ru1Fa/I9f24XE3TZEmoNMvWGvI7wLTIoweCqe039NK
         Ie3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700264333; x=1700869133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o2bmbv+oDgkU+IH2O+FV+APsaOjjslIE2eCkoDOr/Uo=;
        b=sgWioIZQsxDBKHQBWcwtBHeRgBPwiEWDENQGBguqq42Mw3jGyz9cgYxqPEEf69i46Z
         OPgSp3ax/xsrd61WHyGPherU39jTF7+DTFmfzFXNaMz4ePQC1g8wjhLbr5mVIIpzIDUK
         Dc7oUUt3ibbyMTzHAK2I03ERked8B0J3s4fzcwlvX9wtAv3hjDL/jRDID72jo0xTIoV5
         7YMxaUlodXM9mBp/Xvj5Cv/qUjNwz+KsulJ1cHa4KFIGFlXxTGE2zG+OjvTun7tjjPBu
         GDGt6oFUau0wUakBX8ETTagcsfZ6nN5ARt0dUjNIo8IDn+ZvfiZpbpNHpZaPLfCl9YuV
         CuzQ==
X-Gm-Message-State: AOJu0Yz7lsqAlmzPrluAYufitE5i//QkZkYIK4w9ENE4jdZLWiWc3YyT
	JFz/JtBgpLGmZSCABZ/6q8zEK+B21oAqyXWoH3O5vg==
X-Google-Smtp-Source: AGHT+IFZBOCB+PzmC+ta7PifG+xMTU8FPWOzj6fCcWdP8lf8cHkiucDinvYRbCZWU2zXiW2af9eGSSClEMLIJtRbqp4=
X-Received: by 2002:a17:907:9504:b0:9e6:59d5:7ad6 with SMTP id
 ew4-20020a170907950400b009e659d57ad6mr435603ejc.23.1700264333212; Fri, 17 Nov
 2023 15:38:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABWYdi0j4yXWV6-Pr=2q7S6SQSZR7O6F61BLRdU=gDxvuQ3e1w@mail.gmail.com>
 <20231023234555.75053-1-kuniyu@amazon.com>
In-Reply-To: <20231023234555.75053-1-kuniyu@amazon.com>
From: Ivan Babrou <ivan@cloudflare.com>
Date: Fri, 17 Nov 2023 15:38:42 -0800
Message-ID: <CABWYdi2JmfMBK43KrkAGsz+MN8KyFSjg0QZv5G_cuA1k1c0f7w@mail.gmail.com>
Subject: Re: wait_for_unix_gc can cause CPU overload for well behaved programs
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: edumazet@google.com, hdanton@sina.com, kernel-team@cloudflare.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 4:46=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Ivan Babrou <ivan@cloudflare.com>
> Date: Mon, 23 Oct 2023 16:22:35 -0700
> > On Fri, Oct 20, 2023 at 6:23=E2=80=AFPM Hillf Danton <hdanton@sina.com>=
 wrote:
> > >
> > > On Fri, 20 Oct 2023 10:25:25 -0700 Ivan Babrou <ivan@cloudflare.com>
> > > >
> > > > This could solve wait_for_unix_gc spinning, but it wouldn't affect
> > > > unix_gc itself, from what I understand. There would always be one
> > > > socket writer or destroyer punished by running the gc still.
> > >
> > > See what you want. The innocents are rescued by kicking a worker off.
> > > Only for thoughts.
> > >
> > > --- x/net/unix/garbage.c
> > > +++ y/net/unix/garbage.c
> > > @@ -86,7 +86,6 @@
> > >  /* Internal data structures and random procedures: */
> > >
> > >  static LIST_HEAD(gc_candidates);
> > > -static DECLARE_WAIT_QUEUE_HEAD(unix_gc_wait);
> > >
> > >  static void scan_inflight(struct sock *x, void (*func)(struct unix_s=
ock *),
> > >                           struct sk_buff_head *hitlist)
> > > @@ -185,24 +184,25 @@ static void inc_inflight_move_tail(struc
> > >                 list_move_tail(&u->link, &gc_candidates);
> > >  }
> > >
> > > -static bool gc_in_progress;
> > > +static void __unix_gc(struct work_struct *w);
> > > +static DECLARE_WORK(unix_gc_work, __unix_gc);
> > > +
> > >  #define UNIX_INFLIGHT_TRIGGER_GC 16000
> > >
> > >  void wait_for_unix_gc(void)
> > >  {
> > >         /* If number of inflight sockets is insane,
> > > -        * force a garbage collect right now.
> > > -        * Paired with the WRITE_ONCE() in unix_inflight(),
> > > -        * unix_notinflight() and gc_in_progress().
> > > -        */
> > > -       if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC &=
&
> > > -           !READ_ONCE(gc_in_progress))
> > > -               unix_gc();
> > > -       wait_event(unix_gc_wait, gc_in_progress =3D=3D false);
> > > +        * kick a garbage collect right now.
> > > +        *
> > > +        * todo s/wait_for_unix_gc/kick_unix_gc/
> > > +        */
> > > +       if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC /=
2)
> > > +               queue_work(system_unbound_wq, &unix_gc_work);
> > >  }
> > >
> > > -/* The external entry point: unix_gc() */
> > > -void unix_gc(void)
> > > +static DEFINE_MUTEX(unix_gc_mutex);
> > > +
> > > +static void __unix_gc(struct work_struct *w)
> > >  {
> > >         struct sk_buff *next_skb, *skb;
> > >         struct unix_sock *u;
> > > @@ -211,15 +211,10 @@ void unix_gc(void)
> > >         struct list_head cursor;
> > >         LIST_HEAD(not_cycle_list);
> > >
> > > +       if (!mutex_trylock(&unix_gc_mutex))
> > > +               return;
> > >         spin_lock(&unix_gc_lock);
> > >
> > > -       /* Avoid a recursive GC. */
> > > -       if (gc_in_progress)
> > > -               goto out;
> > > -
> > > -       /* Paired with READ_ONCE() in wait_for_unix_gc(). */
> > > -       WRITE_ONCE(gc_in_progress, true);
> > > -
> > >         /* First, select candidates for garbage collection.  Only
> > >          * in-flight sockets are considered, and from those only ones
> > >          * which don't have any external reference.
> > > @@ -325,11 +320,12 @@ void unix_gc(void)
> > >         /* All candidates should have been detached by now. */
> > >         BUG_ON(!list_empty(&gc_candidates));
> > >
> > > -       /* Paired with READ_ONCE() in wait_for_unix_gc(). */
> > > -       WRITE_ONCE(gc_in_progress, false);
> > > -
> > > -       wake_up(&unix_gc_wait);
> > > -
> > > - out:
> > >         spin_unlock(&unix_gc_lock);
> > > +       mutex_unlock(&unix_gc_mutex);
> > > +}
> > > +
> > > +/* The external entry point: unix_gc() */
> > > +void unix_gc(void)
> > > +{
> > > +       __unix_gc(NULL);
> > >  }
> > > --
> >
> > This one results in less overall load than Kuniyuki's proposed patch
> > with my repro:
> >
> > * https://lore.kernel.org/netdev/20231020220511.45854-1-kuniyu@amazon.c=
om/
> >
> > My guess is that's because my repro is the one that is getting penalize=
d there.
>
> Thanks for testing, and yes.
>
> It would be good to split the repro to one offender and one normal
> process, run them on different users, and measure load on the normal
> process.
>
>
> > There's still a lot work done in unix_release_sock here, where GC runs
> > as long as you have any fds inflight:
> >
> > * https://elixir.bootlin.com/linux/v6.1/source/net/unix/af_unix.c#L670
> >
> > Perhaps it can be improved.
>
> Yes, it also can be done async by worker as done in my first patch.
> I replaced schedule_work() with queue_work() to avoid using system_wq
> as gc could take long.
>
> Could you try this ?

Apologies for the long wait, I was OOO.

A bit of a problem here is that unix_gc is called unconditionally in
unix_release_sock. It's done asynchronously now and it can only
consume a single CPU with your changes, which is a lot better than
before. I am wondering if we can still do better to only trigger gc
when it touches unix sockets that have inflight fds.

Commit 3c32da19a858 ("unix: Show number of pending scm files of
receive queue in fdinfo") added "struct scm_stat" to "struct
unix_sock", which can be used to check for the number of inflight fds
in the unix socket. Can we use that to drive the GC? I think we can:

* Trigger unix_gc from unix_release_sock if there's a non-zero number
of inflight fds in the socket being destroyed.
* Trigger wait_for_unix_gc from the write path only if the write
contains fds or if the socket contains inflight fds. Alternatively, we
can run gc at the end of the write path and only check for inflight
fds on the socket there, which is probably simpler.

GC only applies to unix sockets inflight of other unix sockets, so GC
can still affect sockets passing regular fds around, but it wouldn't
affect non-fd-passing unix sockets, which are usually in the data
path.

This way we don't have to check for per-user inflight fds, which means
that services running as "nobody" wouldn't be punished for other
services running as "nobody" screwing up.

Does this sound like a reasonable approach?

> ---8<---
> diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> index 824c258143a3..3b38e21116f1 100644
> --- a/include/net/af_unix.h
> +++ b/include/net/af_unix.h
> @@ -13,6 +13,7 @@ void unix_notinflight(struct user_struct *user, struct =
file *fp);
>  void unix_destruct_scm(struct sk_buff *skb);
>  void io_uring_destruct_scm(struct sk_buff *skb);
>  void unix_gc(void);
> +void unix_gc_flush(void);
>  void wait_for_unix_gc(void);
>  struct sock *unix_get_socket(struct file *filp);
>  struct sock *unix_peer_get(struct sock *sk);
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 3e8a04a13668..ed3251753417 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -3683,6 +3683,7 @@ static int __init af_unix_init(void)
>
>  static void __exit af_unix_exit(void)
>  {
> +       unix_gc_flush();
>         sock_unregister(PF_UNIX);
>         proto_unregister(&unix_dgram_proto);
>         proto_unregister(&unix_stream_proto);
> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> index 2405f0f9af31..51f30f89bacb 100644
> --- a/net/unix/garbage.c
> +++ b/net/unix/garbage.c
> @@ -86,7 +86,9 @@
>  /* Internal data structures and random procedures: */
>
>  static LIST_HEAD(gc_candidates);
> -static DECLARE_WAIT_QUEUE_HEAD(unix_gc_wait);
> +
> +static void __unix_gc(struct work_struct *work);
> +static DECLARE_WORK(unix_gc_work, __unix_gc);
>
>  static void scan_inflight(struct sock *x, void (*func)(struct unix_sock =
*),
>                           struct sk_buff_head *hitlist)
> @@ -185,24 +187,26 @@ static void inc_inflight_move_tail(struct unix_sock=
 *u)
>                 list_move_tail(&u->link, &gc_candidates);
>  }
>
> -static bool gc_in_progress;
> -#define UNIX_INFLIGHT_TRIGGER_GC 16000
> +#define UNIX_INFLIGHT_TRIGGER_GC 16

It's probably best to keep it at 16k.

>  void wait_for_unix_gc(void)
>  {
> +       struct user_struct *user =3D get_uid(current_user());
> +
>         /* If number of inflight sockets is insane,
> -        * force a garbage collect right now.
> +        * kick a garbage collect right now.
>          * Paired with the WRITE_ONCE() in unix_inflight(),
> -        * unix_notinflight() and gc_in_progress().
> +        * unix_notinflight().
>          */
> -       if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC &&
> -           !READ_ONCE(gc_in_progress))
> -               unix_gc();
> -       wait_event(unix_gc_wait, gc_in_progress =3D=3D false);
> +       if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC)
> +               queue_work(system_unbound_wq, &unix_gc_work);
> +
> +       /* Penalise senders of not-yet-received-fd */
> +       if (READ_ONCE(user->unix_inflight))
> +               flush_work(&unix_gc_work);
>  }
>
> -/* The external entry point: unix_gc() */
> -void unix_gc(void)
> +static void __unix_gc(struct work_struct *work)
>  {
>         struct sk_buff *next_skb, *skb;
>         struct unix_sock *u;
> @@ -213,13 +217,6 @@ void unix_gc(void)
>
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
> @@ -325,11 +322,15 @@ void unix_gc(void)
>         /* All candidates should have been detached by now. */
>         BUG_ON(!list_empty(&gc_candidates));
>
> -       /* Paired with READ_ONCE() in wait_for_unix_gc(). */
> -       WRITE_ONCE(gc_in_progress, false);
> +       spin_unlock(&unix_gc_lock);
> +}
>
> -       wake_up(&unix_gc_wait);
> +void unix_gc(void)
> +{
> +       queue_work(system_unbound_wq, &unix_gc_work);
> +}
>
> - out:
> -       spin_unlock(&unix_gc_lock);
> +void __exit unix_gc_flush(void)
> +{
> +       cancel_work_sync(&unix_gc_work);
>  }
> ---8<---

