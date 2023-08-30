Return-Path: <netdev+bounces-31434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A33C78D74D
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 17:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CA342810D6
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 15:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFB8746C;
	Wed, 30 Aug 2023 15:53:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08D37469
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 15:53:41 +0000 (UTC)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C06D193
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 08:53:40 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4036bd4fff1so352911cf.0
        for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 08:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693410819; x=1694015619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNz7cpf2XwdCtEvSFjcjD+zwimXx2MBuyu+yEYFgDqg=;
        b=q9PKHjtiDYXmanLrsnfKjx7+gGxdCEQ1PeDz/GmMRTcBmjbwW6ViPq4zJgue524k+m
         L26GAWO+DCyUdIvFV6UFKvWEy+gt6TZW6eIUYXQW+GwgsNfytnsEr8xMMk/zmOzLMQc6
         1Bi7GlkT0bT/f7ne4TfHghbzvG3U91JTvqg/luwbfa4Ay2nuI5MqH2fCpQ01rSkqh30+
         mWr67SEn4ObU7S5RR6gt/dBzzAufEDHNINH/rRzsrP/ZYNUCB8edkGgnqOpe5LFyOpNP
         DdodbkDfzZ58gygxKdpfglrJmzjchRUggS0i/jWKvT2PHkHcX1v0u1ljIa89GGZCWjqQ
         +rnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693410819; x=1694015619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNz7cpf2XwdCtEvSFjcjD+zwimXx2MBuyu+yEYFgDqg=;
        b=CZrkhNhmYEPJA0n0BMai34C4m4kOABm1Peby9VTteq8120yi85dUiP/06XRHcYikrH
         a37uObaRkssUWATWZtVtT4gG3gQzYJZFU+6MfNN3jdm39J5JQZvHyWTjFyi82wGOhREx
         SiKuj4UpkVUIFpLtjpzAoqxHLGa8gg3fhXuDW98yGCRU5DklN8wl1ZqsCK0Y8EJH4AvM
         /IEyLioNeAdM9eGYDUysLSPY67yu1VMQJ877FlkI5/j5doa1V9CfuTWix3ywVhb38JOt
         wtSh9JLYcZXs06BF+QAjWMXJzJ7prl5Rqz87/3swnWBOiKPFzUMkNlVLE33l+hrtZxEB
         xj3w==
X-Gm-Message-State: AOJu0Yx8VHrCmd9gTVfxLElSrE7jdpnNjnRAcd7kp+Odrasu/PIrQCMS
	pmuhwvnn8IuuY/y9fatVnP7FfbLzFfaMvVZK72i6lQ==
X-Google-Smtp-Source: AGHT+IEPRuXLavQ88WWm6s+FebZe3L4VexmvBdRKzcSvKYGSYf0tl8kuuDTxH/ajZuWplvfSILPRkAUiVRcYtLV3w6w=
X-Received: by 2002:a05:622a:452:b0:410:9855:ac6 with SMTP id
 o18-20020a05622a045200b0041098550ac6mr548673qtx.14.1693410819254; Wed, 30 Aug
 2023 08:53:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230829123541.3745013-1-edumazet@google.com> <ZO9Q0ih6OQhq7sio@localhost.localdomain>
 <CAM0EoMnpL5rE-zDhiY_FKTOguX_3kKkWCGdX0ry8ZWXjmRLjfA@mail.gmail.com>
 <CANn89iLf6+6679LrTV-c2XZWMEeRc3O0N+++yKNqQUxQzjspJw@mail.gmail.com> <CAM0EoMn+W0xiFxS9VPjzgW0-z2-M-cNS2RwXZJeRN6+G7ENmWw@mail.gmail.com>
In-Reply-To: <CAM0EoMn+W0xiFxS9VPjzgW0-z2-M-cNS2RwXZJeRN6+G7ENmWw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 30 Aug 2023 17:53:28 +0200
Message-ID: <CANn89iK0An9y-u3pCfQZism9F0Mtt6Qn-J7DwA=vsk6k+sNcjw@mail.gmail.com>
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

On Wed, Aug 30, 2023 at 5:50=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Wed, Aug 30, 2023 at 11:00=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Wed, Aug 30, 2023 at 4:48=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > On Wed, Aug 30, 2023 at 10:30=E2=80=AFAM Michal Kubiak <michal.kubiak=
@intel.com> wrote:
> > > >
> > > > On Tue, Aug 29, 2023 at 12:35:41PM +0000, Eric Dumazet wrote:
> > > > > When setting a high number of flows (limit being 65536),
> > > > > fq_pie_timer() is currently using too much time as syzbot reporte=
d.
> > > > >
> > > > > Add logic to yield the cpu every 2048 flows (less than 150 usec
> > > > > on debug kernels).
> > > > > It should also help by not blocking qdisc fast paths for too long=
.
> > > > > Worst case (65536 flows) would need 31 jiffies for a complete sca=
n.
> > > > >
> > > > > Relevant extract from syzbot report:
> > > > >
> > > > > rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {=
 0-.... } 2663 jiffies s: 873 root: 0x1/.
> > > > > rcu: blocking rcu_node structures (internal RCU debug):
> > > > > Sending NMI from CPU 1 to CPUs 0:
> > > > > NMI backtrace for cpu 0
> > > > > CPU: 0 PID: 5177 Comm: syz-executor273 Not tainted 6.5.0-syzkalle=
r-00453-g727dbda16b83 #0
> > > > > Hardware name: Google Google Compute Engine/Google Compute Engine=
, BIOS Google 07/26/2023
> > > > > RIP: 0010:check_kcov_mode kernel/kcov.c:173 [inline]
> > > > > RIP: 0010:write_comp_data+0x21/0x90 kernel/kcov.c:236
> > > > > Code: 2e 0f 1f 84 00 00 00 00 00 65 8b 05 01 b2 7d 7e 49 89 f1 89=
 c6 49 89 d2 81 e6 00 01 00 00 49 89 f8 65 48 8b 14 25 80 b9 03 00 <a9> 00 =
01 ff 00 74 0e 85 f6 74 59 8b 82 04 16 00 00 85 c0 74 4f 8b
> > > > > RSP: 0018:ffffc90000007bb8 EFLAGS: 00000206
> > > > > RAX: 0000000000000101 RBX: ffffc9000dc0d140 RCX: ffffffff885893b0
> > > > > RDX: ffff88807c075940 RSI: 0000000000000100 RDI: 0000000000000001
> > > > > RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
> > > > > R10: 0000000000000000 R11: 0000000000000000 R12: ffffc9000dc0d178
> > > > > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > > > > FS:  0000555555d54380(0000) GS:ffff8880b9800000(0000) knlGS:00000=
00000000000
> > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > CR2: 00007f6b442f6130 CR3: 000000006fe1c000 CR4: 00000000003506f0
> > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > > Call Trace:
> > > > >  <NMI>
> > > > >  </NMI>
> > > > >  <IRQ>
> > > > >  pie_calculate_probability+0x480/0x850 net/sched/sch_pie.c:415
> > > > >  fq_pie_timer+0x1da/0x4f0 net/sched/sch_fq_pie.c:387
> > > > >  call_timer_fn+0x1a0/0x580 kernel/time/timer.c:1700
> > > > >
> > > > > Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet sched=
uler")
> > > > > Link: https://lore.kernel.org/lkml/00000000000017ad3f06040bf394@g=
oogle.com/
> > > > > Reported-by: syzbot+e46fbd5289363464bc13@syzkaller.appspotmail.co=
m
> > > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > >
> > > > The code logic and style looks good to me.
> > > > However, I don't have experience with that code to estimate if 2048
> > > > flows per round is enough to avoid stalls for all normal circumstan=
ces,
> > > > so I guess someone else should take a look.
> > > >
> > >
> > > Eric, I had the same question: Why 2048 (why not 12 for example? ;->)=
.
> > > Could that number make more sense to add as an init attribute? Not
> > > asking you to add it but i or somebody else could send a followup
> > > patch after.
> >
> > This is based on experimentation.
> >
> > I started using 1024, then saw that using 2048 was okay.
> >
> > I think I gave some numbers in the changelog :
> > "(less than 150 usec on debug kernels)."
> >
> > Spending 150 usec every jiffie seems reasonable to me.
> >
> > Honestly, I am not sure if anyone was/is using a high number of flows,
> > given that whole qdisc enqueue/dequeue operations were frozen every 15m=
s for
> > 2 or 3 ms on non debug kernels :/
>
> Unfortunately such numbers tend to depend on the CPU used etc. Once
> your patch goes in we can add an extension to set a netlink attribute
> so the user can change this value (by default keep it at 2048).
>

Then syzbot will set this new attribute to 65536 and we are back to
the initial bug.

