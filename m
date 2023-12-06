Return-Path: <netdev+bounces-54355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 633F4806BB4
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 11:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05787B20BBA
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 10:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4943D2D04C;
	Wed,  6 Dec 2023 10:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0slYgZEC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7A2FA
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 02:16:55 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54c77d011acso6924a12.1
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 02:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701857813; x=1702462613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfXPFO/7+RK8jxvwI6TyUQ4knJvIfXPJAOZzoXigq4M=;
        b=0slYgZECWDVlD4ndq84JssW1H+AZMsTYdRezAccn9kmcrF1hiwDGc/6mn9RJGDhCIA
         KXvQTZNniPgWan02r2mYCuhCiYzxTS5WRJaRITzbe/+9/OQjbCWrNLb/bLHsNYFyC0tv
         sOtrFRrko6yQriG6jmx/lKTEtOJILYl0MWZ0Uydde9Tn5M17Uf1kl2/719p40vOBhIXz
         JKsJvcdPhWpG3s6/eC0cmNeydOqwdkreMG1bfDDi7i3Oy6m3cKxsvJZBaAJ3KWi7mk9D
         k+qvGlfWEmWQdE1UTZb6zApeMO5ZuZ/KChpgO2fB00zaziIIxyfiHSxgXIeJtajTTDzq
         6WTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701857813; x=1702462613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TfXPFO/7+RK8jxvwI6TyUQ4knJvIfXPJAOZzoXigq4M=;
        b=T4hLaK/MeEUrlcq4EDctFMC+DjgWX4R02Dfm/bjU0d302gRHu0F5vXJQgd6d36D54C
         qnMc96S/MX+uoZ0bO+cTfDBkVamMolQEhRXVGWgFTe4SkVRgQhYRbNMBNdOjb9vDXOTB
         CYcQvibpW4XrWxYlPyb7m6AfQtmd3fflkw18GkEn5HaSyqpngNiHmQbFjYwR2M7O0k2b
         xlMLWAUoO0CKSKV0f0cifOFHOjGdZTXEDnUrRg7Dk4z4ml51a8Mb4IQ8LOrDfooi9aOx
         GiZw207UNJklLNkKwmxX9rItcVsO22Qzu/HQaIgHJuoP4bE3u4VzPLnh9qVahaB7otmI
         KApA==
X-Gm-Message-State: AOJu0Ywk71IOS1AY3Ae1RxxB2V1U5gldGg02Znw+Ll0y8dCHn+cwP4LT
	3aJ920yzxQ9ja2dEVTXCBskAtle6nLViYMaLR82qXw==
X-Google-Smtp-Source: AGHT+IE3Vqo156PuYHWEO0YaCIdo+4bBe4974PJlGGOXbUuGkJ1GAVd+bSt+fBhF8PdY3LkpThDmQJTyyDnc+bb/zqY=
X-Received: by 2002:a50:aacf:0:b0:54b:321:ef1a with SMTP id
 r15-20020a50aacf000000b0054b0321ef1amr72386edc.6.1701857813188; Wed, 06 Dec
 2023 02:16:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <73065927a49619fcd60e5b765c929f899a66cd1a.1701853200.git.dcaratti@redhat.com>
In-Reply-To: <73065927a49619fcd60e5b765c929f899a66cd1a.1701853200.git.dcaratti@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 6 Dec 2023 11:16:39 +0100
Message-ID: <CANn89iLXjstLx-=hFR0Rhav462+9pH3JTyE45t+nyiszKKCPTQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net/sched: fix false lockdep warning on qdisc
 root lock
To: Davide Caratti <dcaratti@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	xmu@redhat.com, cpaasch@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 10:04=E2=80=AFAM Davide Caratti <dcaratti@redhat.com=
> wrote:
>
> Xiumei and Cristoph reported the following lockdep splat, it complains of
> the qdisc root being taken twice:
>
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  WARNING: possible recursive locking detected
>  6.7.0-rc3+ #598 Not tainted
>  --------------------------------------------
>  swapper/2/0 is trying to acquire lock:
>  ffff888177190110 (&sch->q.lock){+.-.}-{2:2}, at: __dev_queue_xmit+0x1560=
/0x2e70
>
>  but task is already holding lock:
>  ffff88811995a110 (&sch->q.lock){+.-.}-{2:2}, at: __dev_queue_xmit+0x1560=
/0x2e70
>
>  other info that might help us debug this:
>   Possible unsafe locking scenario:
>
>         CPU0
>         ----
>    lock(&sch->q.lock);
>    lock(&sch->q.lock);
>
>   *** DEADLOCK ***
>
>   May be due to missing lock nesting notation
>
>  5 locks held by swapper/2/0:
>   #0: ffff888135a09d98 ((&in_dev->mr_ifc_timer)){+.-.}-{0:0}, at: call_ti=
mer_fn+0x11a/0x510
>   #1: ffffffffaaee5260 (rcu_read_lock){....}-{1:2}, at: ip_finish_output2=
+0x2c0/0x1ed0
>   #2: ffffffffaaee5200 (rcu_read_lock_bh){....}-{1:2}, at: __dev_queue_xm=
it+0x209/0x2e70
>   #3: ffff88811995a110 (&sch->q.lock){+.-.}-{2:2}, at: __dev_queue_xmit+0=
x1560/0x2e70
>   #4: ffffffffaaee5200 (rcu_read_lock_bh){....}-{1:2}, at: __dev_queue_xm=
it+0x209/0x2e70
>
>

Can you add a Fixes: tag ?

Also, what is the interaction with htb_set_lockdep_class_child(), have
you tried to use HTB after your patch ?

Could htb_set_lockdep_class_child() be removed ?


> CC: Xiumei Mu <xmu@redhat.com>
> Reported-by: Cristoph Paasch <cpaasch@apple.com>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/451
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> ---
>  include/net/sch_generic.h | 1 +
>  net/sched/sch_generic.c   | 3 +++
>  2 files changed, 4 insertions(+)
>
> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index dcb9160e6467..a395ca76066c 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -126,6 +126,7 @@ struct Qdisc {
>
>         struct rcu_head         rcu;
>         netdevice_tracker       dev_tracker;
> +       struct lock_class_key   root_lock_key;
>         /* private data */
>         long privdata[] ____cacheline_aligned;
>  };
> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> index 8dd0e5925342..da3e1ea42852 100644
> --- a/net/sched/sch_generic.c
> +++ b/net/sched/sch_generic.c
> @@ -944,7 +944,9 @@ struct Qdisc *qdisc_alloc(struct netdev_queue *dev_qu=
eue,
>         __skb_queue_head_init(&sch->gso_skb);
>         __skb_queue_head_init(&sch->skb_bad_txq);
>         gnet_stats_basic_sync_init(&sch->bstats);
> +       lockdep_register_key(&sch->root_lock_key);
>         spin_lock_init(&sch->q.lock);
> +       lockdep_set_class(&sch->q.lock, &sch->root_lock_key);
>
>         if (ops->static_flags & TCQ_F_CPUSTATS) {
>                 sch->cpu_bstats =3D
> @@ -1064,6 +1066,7 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
>         if (ops->destroy)
>                 ops->destroy(qdisc);
>
> +       lockdep_unregister_key(&qdisc->root_lock_key);
>         module_put(ops->owner);
>         netdev_put(qdisc_dev(qdisc), &qdisc->dev_tracker);
>
> --
> 2.41.0
>

