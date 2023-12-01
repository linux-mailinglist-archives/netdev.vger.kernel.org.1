Return-Path: <netdev+bounces-52913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B38800B48
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 13:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0351C2095F
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 12:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7151EB4E;
	Fri,  1 Dec 2023 12:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4ra3o/ND"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EC010F3
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 04:53:04 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40b51e26a7aso58425e9.1
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 04:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701435183; x=1702039983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqpq7qHLQzhXGOS0FtYsA/dDj6qZVEXGLfJk8ruj1VQ=;
        b=4ra3o/NDQzR9A3vZt74XxM3ks2mIrEDBQ7bjf/Z7rBzcbZCEncgUF6GwDHiPRfkdAz
         Zr/s9lS7qZXMyd6a1lz3AmVZcYRtnM/6UWuqiwyQ952hcYskhFXeNGZy2AmRhlN8tR6D
         D3UaCd+U/sxqZ8GUnCHpfNZ0JD9jCX31Tw4IBNRSE/PkE9kH8UdF6dejJdpYCRnlCX3u
         wHne0CK2KVQpjv5Dmcenqlf7w5Ztica3+hJJpirIQIvLvcvR+7fojmNxAW+bPZQDZCnt
         G63twRcrJt0KXLprEU+kYX3V9jRIPcmveC5Vhze3pffSyGExrW5tuhxrbJOlW6MCB2fh
         wm3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701435183; x=1702039983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aqpq7qHLQzhXGOS0FtYsA/dDj6qZVEXGLfJk8ruj1VQ=;
        b=PK7Q8TEGc9Q1z175o4F2Sz3WRaH6LXJq/2JKUVnUDTevX6vQ0Uz5+2GeG6SBxMAlm2
         I98KK3pgJieQnEG0v0YOjtZy8026o+lmIMXPdKWVqgnhmAdkOT79ZyvacCsdwU03P0qn
         e0HwUjd3OByqJaqQ1CM4w4xgybVm8GBcQSNt3Wd7yuBVCz45Ggk/IwYmZoN5w608NW3L
         iLwpD5rsZ4wUmGdKsX7JSFidq73ZxH/9XLk6XE102qHf4nuvF1VhiHBOR8hx0oHPexqn
         2Du95VoTJLArAGhQymTdGD2POWFWy2V4/AiDs+f9G0VYJuXOSgc/R95fyCJA1MgZ24Rw
         wPcA==
X-Gm-Message-State: AOJu0YyR+N8KhmFcodfTrA0XFf9RfYKuGAgexpk4OkH4shB8fRD7X6vp
	UrJrfBv76nuVrND6iX+5QG5GpDkhIPqegHBN7Nb7XQ==
X-Google-Smtp-Source: AGHT+IE4wQYaBnqmb47NhHuxGm5Cq/SfIkFeH2fOHieO0RJR2XpHK11M+z2ntPhQMxoAK/PFzCgg9YNcyYpsCzdZM6U=
X-Received: by 2002:a05:600c:6014:b0:40b:33aa:a2b9 with SMTP id
 az20-20020a05600c601400b0040b33aaa2b9mr155629wmb.4.1701435182521; Fri, 01 Dec
 2023 04:53:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89iJ7h_LFSV6n_9WmbTMwTMsZ0UgdBj_oGrnzcrZu7oCxFw@mail.gmail.com>
 <CABOYnLzq7XwbFncos1p8FOnDyVes4VDkjWE277TngdJqSie14A@mail.gmail.com> <20231201111253.1029-1-hdanton@sina.com>
In-Reply-To: <20231201111253.1029-1-hdanton@sina.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 1 Dec 2023 13:52:49 +0100
Message-ID: <CANn89iJsY8-_wBwpQt4oV7uF5hP73rFY-GX_GHLVaTUiys6Yig@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING in cleanup_net (3)
To: Hillf Danton <hdanton@sina.com>
Cc: xingwei lee <xrivendell7@gmail.com>, 
	syzbot+9ada62e1dc03fdc41982@syzkaller.appspotmail.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 12:13=E2=80=AFPM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On Fri, 1 Dec 2023 08:39:32 +0800 xingwei lee <xrivendell7@gmail.com>
> > I forgot to CC others, repeat mail.
> > Sorry, Dumazet. I found this bug with my modified syzkaller in my
> > local environment.
> > You are right, I crashed this bug about 10 times and used some
> > heuristic solutions to increase the chances of luck with modifying
> > syz-repro during this process.
> > I can confirm the reproduction can trigger the bug soon and I hope it h=
elps you.
> > I'll test your patch and give your feedback ASAP.
> >
> > I apply your patch at
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D3b47bc037bd44f142ac09848e8d3ecccc726be99
> > with a little fix:
> >
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index fef349dd72fa..36d2871ac24f 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -2197,8 +2197,6 @@ static void __sk_destruct(struct rcu_head *head)
> >
> >         if (likely(sk->sk_net_refcnt))
> >                 put_net_track(sock_net(sk), &sk->ns_tracker);
> > -       else
> > -               __netns_tracker_free(sock_net(sk), &sk->ns_tracker, fal=
se);
> >
> >         sk_prot_free(sk->sk_prot_creator, sk);
> >  }
> > @@ -2212,6 +2210,9 @@ void sk_destruct(struct sock *sk)
> >                 use_call_rcu =3D true;
> >         }
> >
> > +       if (unlikely(!sk->sk_net_refcnt))
> > +               __netns_tracker_free(sock_net(sk), &sk->ns_tracker, fal=
se);
> > +
> >         if (use_call_rcu)
> >                 call_rcu(&sk->sk_rcu, __sk_destruct);
> >         else
> >
> > and It's also trigger the crash like below:
>
> Looks like a refcount leak that could be cured with the diff below.
> Only for thoughts.
>
> --- x/include/net/net_namespace.h
> +++ y/include/net/net_namespace.h
> @@ -320,7 +320,7 @@ static inline int check_net(const struct
>         return 1;
>  }
>
> -#define net_drop_ns NULL
> +static void net_drop_ns(void *w) { }
>  #endif
>
>
> @@ -355,7 +355,7 @@ static inline void __netns_tracker_free(
>  static inline struct net *get_net_track(struct net *net,
>                                         netns_tracker *tracker, gfp_t gfp=
)
>  {
> -       get_net(net);
> +       refcount_inc(&net->passive);
>         netns_tracker_alloc(net, tracker, gfp);
>         return net;
>  }
> @@ -363,7 +363,7 @@ static inline struct net *get_net_track(
>  static inline void put_net_track(struct net *net, netns_tracker *tracker=
)
>  {
>         __netns_tracker_free(net, tracker, true);
> -       put_net(net);
> +       net_drop_ns(net);
>  }
>
>  typedef struct {
> --

I do not think so.If you saw my prior patch, my thinking was :

At netns dismantle, RDS is supposed to close all kernel sockets it created.

Because of RCU grace period imposed on TCP listeners, my concern was
that we might have to release the sk->ns_tracker before
the RCU grace period ended. (I think my patch makes sense anyway, I
mentioned this race possibility in the past)

If the splat still occurs, this means that at the end of
rds_tcp_listen_stop(), rds_tcp_listen_sock->sk refcount had not
reached yet 0.

Therefore I think the bug is in RDS.

We could add a debug point in rds_tcp_listen_sock(), I suspect
something in RDS got a sock_hold(sk)
and did not release the refcount before we exit from rds_tcp_listen_stop()

Another way would be to add a tracker on sockets, but this seems a lot of w=
ork.

