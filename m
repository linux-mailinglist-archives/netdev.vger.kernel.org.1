Return-Path: <netdev+bounces-31418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F30678D6C2
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 17:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 177CB1C203BC
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 15:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CD66FA1;
	Wed, 30 Aug 2023 15:00:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5825A3D7C
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 15:00:40 +0000 (UTC)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009521A4
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 08:00:38 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-40a47e8e38dso272511cf.1
        for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 08:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693407638; x=1694012438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7aXa5hGtM+ifHC12JyMR6o/cnFI94UwzRMefboss3fo=;
        b=dlACefOKJjKUdGE4xj25wVhqD8MQAobTuVV3WzLvnOQLh4uL+j9xKGNdw0Putb7BpH
         fpiSyvgIFTSjMMgad5ynQEF97BZLSp8zKTkRMPFKm07bvlj6J3Q1U0rGmVrfl1P2gYOg
         mYW7mGx8BwXAgtbXpdWc+l2iEG1poSQRSDal2LFYEXS8atzbfZqLNHO3rJmrqTOq758S
         PMGYwGYoKCWLsNqv9GjT43Ysb2RWodeiPyLxS8QASadufFIAZC3IaQ8+Zuxqqv4bk+Sa
         WwRNwfWMhh1m/QULD2mi/AGUWzfEMJGCIQecnj7nO9eiouZzk0tq94v7czx4/gFeFgsh
         mmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693407638; x=1694012438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7aXa5hGtM+ifHC12JyMR6o/cnFI94UwzRMefboss3fo=;
        b=QXaqAUjLKNbOncX5TlqF7sRpSY/fYqMu0GOBbAT8QpDR2tMwIY1z3okYu3z3wXEoKj
         HOW/eTIZTQ4iGmBitkRd3mA2khgSzHxF0diDXOMQvN4o9wSGKfxffS0NB5A0jMZvJhcP
         uzxNgJOKNnMbMRYkDAV6KXoFQvEQBmIRiBj5OxkYWy+L1MUILTPMFmw0wpYTMmpLfg6o
         Xlrft8ekXpzWtcWjinV8W825dgY1YkEUiKWNGLVInnf0MFXqAN7Z59hpJ03E9bytwaC5
         EqWObwNredyoEuErqyZ6uDpR9JMsJ+4F3gCx4xYTeYZQUuAkwWKnPf3iuFZwSAoPDyIl
         eQgg==
X-Gm-Message-State: AOJu0YwQaqsbaZzh6RbtapfWHajVTvSNypIQVo6CSwr7/iG5qJtTmnvq
	eWOX6ErKxQfcsSZZIKFz8W7AV/7t8stpRuCpsU8Z4w==
X-Google-Smtp-Source: AGHT+IGDkGTXomr0lZtq2o0bcm3XxsT/EJ1Dn7ToR6CwsC7xs9dztSMoyNXByUBpkS8P13LOFLAj1/4DqKqVGlNi7k8=
X-Received: by 2002:a05:622a:452:b0:3f5:2006:50f1 with SMTP id
 o18-20020a05622a045200b003f5200650f1mr566768qtx.12.1693407637202; Wed, 30 Aug
 2023 08:00:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230829123541.3745013-1-edumazet@google.com> <ZO9Q0ih6OQhq7sio@localhost.localdomain>
 <CAM0EoMnpL5rE-zDhiY_FKTOguX_3kKkWCGdX0ry8ZWXjmRLjfA@mail.gmail.com>
In-Reply-To: <CAM0EoMnpL5rE-zDhiY_FKTOguX_3kKkWCGdX0ry8ZWXjmRLjfA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 30 Aug 2023 17:00:25 +0200
Message-ID: <CANn89iLf6+6679LrTV-c2XZWMEeRc3O0N+++yKNqQUxQzjspJw@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: fq_pie: avoid stalls in fq_pie_timer()
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Michal Kubiak <michal.kubiak@intel.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+e46fbd5289363464bc13@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 30, 2023 at 4:48=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Wed, Aug 30, 2023 at 10:30=E2=80=AFAM Michal Kubiak <michal.kubiak@int=
el.com> wrote:
> >
> > On Tue, Aug 29, 2023 at 12:35:41PM +0000, Eric Dumazet wrote:
> > > When setting a high number of flows (limit being 65536),
> > > fq_pie_timer() is currently using too much time as syzbot reported.
> > >
> > > Add logic to yield the cpu every 2048 flows (less than 150 usec
> > > on debug kernels).
> > > It should also help by not blocking qdisc fast paths for too long.
> > > Worst case (65536 flows) would need 31 jiffies for a complete scan.
> > >
> > > Relevant extract from syzbot report:
> > >
> > > rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 0-.=
... } 2663 jiffies s: 873 root: 0x1/.
> > > rcu: blocking rcu_node structures (internal RCU debug):
> > > Sending NMI from CPU 1 to CPUs 0:
> > > NMI backtrace for cpu 0
> > > CPU: 0 PID: 5177 Comm: syz-executor273 Not tainted 6.5.0-syzkaller-00=
453-g727dbda16b83 #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 07/26/2023
> > > RIP: 0010:check_kcov_mode kernel/kcov.c:173 [inline]
> > > RIP: 0010:write_comp_data+0x21/0x90 kernel/kcov.c:236
> > > Code: 2e 0f 1f 84 00 00 00 00 00 65 8b 05 01 b2 7d 7e 49 89 f1 89 c6 =
49 89 d2 81 e6 00 01 00 00 49 89 f8 65 48 8b 14 25 80 b9 03 00 <a9> 00 01 f=
f 00 74 0e 85 f6 74 59 8b 82 04 16 00 00 85 c0 74 4f 8b
> > > RSP: 0018:ffffc90000007bb8 EFLAGS: 00000206
> > > RAX: 0000000000000101 RBX: ffffc9000dc0d140 RCX: ffffffff885893b0
> > > RDX: ffff88807c075940 RSI: 0000000000000100 RDI: 0000000000000001
> > > RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000000 R12: ffffc9000dc0d178
> > > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > > FS:  0000555555d54380(0000) GS:ffff8880b9800000(0000) knlGS:000000000=
0000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 00007f6b442f6130 CR3: 000000006fe1c000 CR4: 00000000003506f0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >  <NMI>
> > >  </NMI>
> > >  <IRQ>
> > >  pie_calculate_probability+0x480/0x850 net/sched/sch_pie.c:415
> > >  fq_pie_timer+0x1da/0x4f0 net/sched/sch_fq_pie.c:387
> > >  call_timer_fn+0x1a0/0x580 kernel/time/timer.c:1700
> > >
> > > Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet scheduler=
")
> > > Link: https://lore.kernel.org/lkml/00000000000017ad3f06040bf394@googl=
e.com/
> > > Reported-by: syzbot+e46fbd5289363464bc13@syzkaller.appspotmail.com
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> >
> > The code logic and style looks good to me.
> > However, I don't have experience with that code to estimate if 2048
> > flows per round is enough to avoid stalls for all normal circumstances,
> > so I guess someone else should take a look.
> >
>
> Eric, I had the same question: Why 2048 (why not 12 for example? ;->).
> Could that number make more sense to add as an init attribute? Not
> asking you to add it but i or somebody else could send a followup
> patch after.

This is based on experimentation.

I started using 1024, then saw that using 2048 was okay.

I think I gave some numbers in the changelog :
"(less than 150 usec on debug kernels)."

Spending 150 usec every jiffie seems reasonable to me.

Honestly, I am not sure if anyone was/is using a high number of flows,
given that whole qdisc enqueue/dequeue operations were frozen every 15ms fo=
r
2 or 3 ms on non debug kernels :/



> Other than that:
>
> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
>
> cheers,
> jamal
>
> > Thanks,
> > Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
> >

