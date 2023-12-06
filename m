Return-Path: <netdev+bounces-54359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01887806BE0
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 11:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97458B20B39
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 10:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B4C2D79D;
	Wed,  6 Dec 2023 10:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pIiaTJ1n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DE9120
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 02:26:05 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40b367a0a12so45645e9.1
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 02:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701858364; x=1702463164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzwLGC3vzstuFTUp+aY480W98kgR2iZWo0WXAIHUpRY=;
        b=pIiaTJ1n6Yko20nS+P5FOA2ViTFUig/7BVi6mpfAM8RftMM0pSRJYc5+hSjb8hABFL
         UdFfKL6lR55+efE7eyz4eoxg9FA/bujnyNlHDnqD02jg4OzaQu/wqA5NrGw1hn78xUwx
         cU+iMtYrN7GUFzbhMEOiy+YmdL0j+YvvKqFoL497WBlWySl0kX9EjtapOTYW859gp1hm
         FIaBvPxiTXlJ0olkHQJHR5GK2kXxP+ADdyjER7hxIEU8VtvUcP//q2a5jwDsXRI8yDM4
         5FDqktAZiYPbpalvP+AbutFJyanMAOtz/a9cUX7fE58ocZ83ba1B5pcWfpMw0+bCQJBZ
         lTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701858364; x=1702463164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzwLGC3vzstuFTUp+aY480W98kgR2iZWo0WXAIHUpRY=;
        b=sv+hJ25r0L0gSudCt9FN4Uz6sgGqZXqbZL5hMwFskadbgvdFRsO6sVw8soH2o7qEZa
         +a8GRVungza7ea82uJvqutB6Ox1bNPWLcn/b79LnBrOoSzP4Wp2MmnUExTkls8fBNol1
         8lC2sg8tMOEVBLhtCws/AqVgK0RQojrVfuKSUniJ/YPUHenFKAhae00S/+cMp/YbEvB8
         9Lasm9Vt6o3XS7lsMex/k+fB2y65xlhiIiZTvDapval4IJBsoDHAELI+8m6gZM6nqt+a
         JnrVZUuYZR/2LBgAR2+Ow4hGODbgpy3+lI2tMQs0dIGqqOXgfwc7RJ3W3X2ZftoKl2Kc
         gKSQ==
X-Gm-Message-State: AOJu0YyhRveM215m5M3XmD6qg1Jiro5BgyvaxVTXdS2GoWaOgiOF4spX
	skgAw2rfSM05Tt1EjnBK7ihJBPtmw5UO4Vrl29A+1A==
X-Google-Smtp-Source: AGHT+IEf7YnnDf35VzgKpZal/EN7zNKRTDSITXp0Hl3N4a7pbuwoGawjX5oLpZpztybVyrC7EBX2EHC2udS39ZaGsk8=
X-Received: by 2002:a05:600c:22d8:b0:40b:4221:4085 with SMTP id
 24-20020a05600c22d800b0040b42214085mr49751wmg.1.1701858363424; Wed, 06 Dec
 2023 02:26:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <73065927a49619fcd60e5b765c929f899a66cd1a.1701853200.git.dcaratti@redhat.com>
 <CANn89iLXjstLx-=hFR0Rhav462+9pH3JTyE45t+nyiszKKCPTQ@mail.gmail.com>
In-Reply-To: <CANn89iLXjstLx-=hFR0Rhav462+9pH3JTyE45t+nyiszKKCPTQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 6 Dec 2023 11:25:52 +0100
Message-ID: <CANn89iK7Nf9WPwg3XkwAMfCqnidtjsB9fSr3025rsUnpuwXJ2w@mail.gmail.com>
Subject: Re: [PATCH net-next] net/sched: fix false lockdep warning on qdisc
 root lock
To: Davide Caratti <dcaratti@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	xmu@redhat.com, cpaasch@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 11:16=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Dec 6, 2023 at 10:04=E2=80=AFAM Davide Caratti <dcaratti@redhat.c=
om> wrote:
> >
> > Xiumei and Cristoph reported the following lockdep splat, it complains =
of
> > the qdisc root being taken twice:
> >
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  WARNING: possible recursive locking detected
> >  6.7.0-rc3+ #598 Not tainted
> >  --------------------------------------------
> >  swapper/2/0 is trying to acquire lock:
> >  ffff888177190110 (&sch->q.lock){+.-.}-{2:2}, at: __dev_queue_xmit+0x15=
60/0x2e70
> >
> >  but task is already holding lock:
> >  ffff88811995a110 (&sch->q.lock){+.-.}-{2:2}, at: __dev_queue_xmit+0x15=
60/0x2e70
> >
> >  other info that might help us debug this:
> >   Possible unsafe locking scenario:
> >
> >         CPU0
> >         ----
> >    lock(&sch->q.lock);
> >    lock(&sch->q.lock);
> >
> >   *** DEADLOCK ***
> >
> >   May be due to missing lock nesting notation
> >
> >  5 locks held by swapper/2/0:
> >   #0: ffff888135a09d98 ((&in_dev->mr_ifc_timer)){+.-.}-{0:0}, at: call_=
timer_fn+0x11a/0x510
> >   #1: ffffffffaaee5260 (rcu_read_lock){....}-{1:2}, at: ip_finish_outpu=
t2+0x2c0/0x1ed0
> >   #2: ffffffffaaee5200 (rcu_read_lock_bh){....}-{1:2}, at: __dev_queue_=
xmit+0x209/0x2e70
> >   #3: ffff88811995a110 (&sch->q.lock){+.-.}-{2:2}, at: __dev_queue_xmit=
+0x1560/0x2e70
> >   #4: ffffffffaaee5200 (rcu_read_lock_bh){....}-{1:2}, at: __dev_queue_=
xmit+0x209/0x2e70
> >
> >
>
> Can you add a Fixes: tag ?
>
> Also, what is the interaction with htb_set_lockdep_class_child(), have
> you tried to use HTB after your patch ?
>
> Could htb_set_lockdep_class_child() be removed ?
>
>
> > CC: Xiumei Mu <xmu@redhat.com>
> > Reported-by: Cristoph Paasch <cpaasch@apple.com>
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/451
> > Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> > ---
> >  include/net/sch_generic.h | 1 +
> >  net/sched/sch_generic.c   | 3 +++
> >  2 files changed, 4 insertions(+)
> >
> > diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> > index dcb9160e6467..a395ca76066c 100644
> > --- a/include/net/sch_generic.h
> > +++ b/include/net/sch_generic.h
> > @@ -126,6 +126,7 @@ struct Qdisc {
> >
> >         struct rcu_head         rcu;
> >         netdevice_tracker       dev_tracker;
> > +       struct lock_class_key   root_lock_key;
> >         /* private data */
> >         long privdata[] ____cacheline_aligned;
> >  };
> > diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> > index 8dd0e5925342..da3e1ea42852 100644
> > --- a/net/sched/sch_generic.c
> > +++ b/net/sched/sch_generic.c
> > @@ -944,7 +944,9 @@ struct Qdisc *qdisc_alloc(struct netdev_queue *dev_=
queue,
> >         __skb_queue_head_init(&sch->gso_skb);
> >         __skb_queue_head_init(&sch->skb_bad_txq);
> >         gnet_stats_basic_sync_init(&sch->bstats);
> > +       lockdep_register_key(&sch->root_lock_key);
> >         spin_lock_init(&sch->q.lock);
> > +       lockdep_set_class(&sch->q.lock, &sch->root_lock_key);
> >
> >         if (ops->static_flags & TCQ_F_CPUSTATS) {
> >                 sch->cpu_bstats =3D
> > @@ -1064,6 +1066,7 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
> >         if (ops->destroy)
> >                 ops->destroy(qdisc);
> >
> > +       lockdep_unregister_key(&qdisc->root_lock_key);

lockdep_unregister_key() has a synchronize_rcu() call.

This would slow down qdisc dismantle too much.

I think we need to find another solution to this problem.

