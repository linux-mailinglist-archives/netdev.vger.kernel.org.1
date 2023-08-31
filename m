Return-Path: <netdev+bounces-31549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7500578EBC6
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 13:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 935CA2814B6
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 11:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655078F6E;
	Thu, 31 Aug 2023 11:17:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495AB8F61
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 11:17:47 +0000 (UTC)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A684BCE4
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 04:17:46 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-58e6c05f529so8021717b3.3
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 04:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1693480666; x=1694085466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjB4yOeji4obhEk9s6PHu2YnbLFDMD/NxZEoDUz3W/k=;
        b=nETuy8jBOkfsL9dijeiMYzk+2LItCXycbdKaKdonalCivSn5jdvY6CEc/rMlzI6aDz
         MGQNd9Ukuyhf6iA0L0l98jHmSYgH47+5SNxF3zG48FFZlyBFH8fjZ7Fa87zhUK0fkk8H
         T4LVaZxXzvEtPGFrl7SJSJSph3LWd2bOiN9/1ClYc7Ki+ZhcnYPOqfRRLEMUwdna71TU
         GJ6LYnsRxLFBWsKxGesh/+V9jIMHg+Y9o40MDGJcpFHZcy2JB9vCDSFxqhagMWqhtfxK
         aU7xBebv4gTagYj992RoyGJsG5zD1BPicjWwzO7fPhVGm4Nd+L7f7WMaQZuTVgtim/Be
         4QpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693480666; x=1694085466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zjB4yOeji4obhEk9s6PHu2YnbLFDMD/NxZEoDUz3W/k=;
        b=jFPQ7+WoNTa6CpR/1t7R+qHT9MRj0h8jiVf8oimUFSKtUxai+yosZwQuqJHAmGlyr9
         gARiUo8QN5irtDiaZZnMZStiBXpEmvH+c4/70jlOtvgmy/+ld1n3za9TFos2VZ4RUmT4
         qz2s90V1oEENpqQdsfsLdN/47hf3KnErsDrBvWEZ13IPx7jgv+IYY/YmqIq/23n/2ms0
         VXaYN3uyJ2dEYs37IPL9oc8akN9PrBVhB7hBpOgiN6LJUKOxGq3wUmy3ad5hPMqRxTZz
         rMDbzRTLz43Z3WLKN5rm6IUu3TypwWgp9T1zksWoDSWhRHAhFvy7qRrikDNhQWl3xA/c
         Wpag==
X-Gm-Message-State: AOJu0Yw3NbMU3OUj+7ZU6j2mROogc/CcyrvuA/21SY+4PzfZQcoTW8C3
	caf03Wk2TXQKjlOHwr3UtB0iwIn5J0JkAHdfjRMOXQ==
X-Google-Smtp-Source: AGHT+IG0idgRq5GXtXn8gyc7AavZ6cYsfBS82GmkbtT4/gU8JoP2rUZpehj9whfbrGObKl+RHlPc/wn8q6ge0LOkPss=
X-Received: by 2002:a81:6dcc:0:b0:586:c1fc:f307 with SMTP id
 i195-20020a816dcc000000b00586c1fcf307mr4424493ywc.0.1693480665530; Thu, 31
 Aug 2023 04:17:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230829123541.3745013-1-edumazet@google.com> <ZO9Q0ih6OQhq7sio@localhost.localdomain>
 <CAM0EoMnpL5rE-zDhiY_FKTOguX_3kKkWCGdX0ry8ZWXjmRLjfA@mail.gmail.com>
 <CANn89iLf6+6679LrTV-c2XZWMEeRc3O0N+++yKNqQUxQzjspJw@mail.gmail.com>
 <CAM0EoMn+W0xiFxS9VPjzgW0-z2-M-cNS2RwXZJeRN6+G7ENmWw@mail.gmail.com> <CANn89iK0An9y-u3pCfQZism9F0Mtt6Qn-J7DwA=vsk6k+sNcjw@mail.gmail.com>
In-Reply-To: <CANn89iK0An9y-u3pCfQZism9F0Mtt6Qn-J7DwA=vsk6k+sNcjw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 31 Aug 2023 07:17:34 -0400
Message-ID: <CAM0EoM=o8EVdcpHP3FAVeoLOp=vrEY9C1h+_mi7CrkrnLLp3SQ@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: fq_pie: avoid stalls in fq_pie_timer()
To: Eric Dumazet <edumazet@google.com>
Cc: Michal Kubiak <michal.kubiak@intel.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+e46fbd5289363464bc13@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 30, 2023 at 11:53=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Wed, Aug 30, 2023 at 5:50=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > On Wed, Aug 30, 2023 at 11:00=E2=80=AFAM Eric Dumazet <edumazet@google.=
com> wrote:
> > >
> > > On Wed, Aug 30, 2023 at 4:48=E2=80=AFPM Jamal Hadi Salim <jhs@mojatat=
u.com> wrote:
> > > >
> > > > On Wed, Aug 30, 2023 at 10:30=E2=80=AFAM Michal Kubiak <michal.kubi=
ak@intel.com> wrote:
> > > > >
> > > > > On Tue, Aug 29, 2023 at 12:35:41PM +0000, Eric Dumazet wrote:
> > > > > > When setting a high number of flows (limit being 65536),
> > > > > > fq_pie_timer() is currently using too much time as syzbot repor=
ted.
> > > > > >
> > > > > > Add logic to yield the cpu every 2048 flows (less than 150 usec
> > > > > > on debug kernels).
> > > > > > It should also help by not blocking qdisc fast paths for too lo=
ng.
> > > > > > Worst case (65536 flows) would need 31 jiffies for a complete s=
can.
> > > > > >
> > > > > > Relevant extract from syzbot report:
> > > > > >
> > > > > > rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks:=
 { 0-.... } 2663 jiffies s: 873 root: 0x1/.
> > > > > > rcu: blocking rcu_node structures (internal RCU debug):
> > > > > > Sending NMI from CPU 1 to CPUs 0:
> > > > > > NMI backtrace for cpu 0
> > > > > > CPU: 0 PID: 5177 Comm: syz-executor273 Not tainted 6.5.0-syzkal=
ler-00453-g727dbda16b83 #0
> > > > > > Hardware name: Google Google Compute Engine/Google Compute Engi=
ne, BIOS Google 07/26/2023
> > > > > > RIP: 0010:check_kcov_mode kernel/kcov.c:173 [inline]
> > > > > > RIP: 0010:write_comp_data+0x21/0x90 kernel/kcov.c:236
> > > > > > Code: 2e 0f 1f 84 00 00 00 00 00 65 8b 05 01 b2 7d 7e 49 89 f1 =
89 c6 49 89 d2 81 e6 00 01 00 00 49 89 f8 65 48 8b 14 25 80 b9 03 00 <a9> 0=
0 01 ff 00 74 0e 85 f6 74 59 8b 82 04 16 00 00 85 c0 74 4f 8b
> > > > > > RSP: 0018:ffffc90000007bb8 EFLAGS: 00000206
> > > > > > RAX: 0000000000000101 RBX: ffffc9000dc0d140 RCX: ffffffff885893=
b0
> > > > > > RDX: ffff88807c075940 RSI: 0000000000000100 RDI: 00000000000000=
01
> > > > > > RBP: 0000000000000000 R08: 0000000000000001 R09: 00000000000000=
00
> > > > > > R10: 0000000000000000 R11: 0000000000000000 R12: ffffc9000dc0d1=
78
> > > > > > R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000000=
00
> > > > > > FS:  0000555555d54380(0000) GS:ffff8880b9800000(0000) knlGS:000=
0000000000000
> > > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > CR2: 00007f6b442f6130 CR3: 000000006fe1c000 CR4: 00000000003506=
f0
> > > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000000=
00
> > > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000004=
00
> > > > > > Call Trace:
> > > > > >  <NMI>
> > > > > >  </NMI>
> > > > > >  <IRQ>
> > > > > >  pie_calculate_probability+0x480/0x850 net/sched/sch_pie.c:415
> > > > > >  fq_pie_timer+0x1da/0x4f0 net/sched/sch_fq_pie.c:387
> > > > > >  call_timer_fn+0x1a0/0x580 kernel/time/timer.c:1700
> > > > > >
> > > > > > Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet sch=
eduler")
> > > > > > Link: https://lore.kernel.org/lkml/00000000000017ad3f06040bf394=
@google.com/
> > > > > > Reported-by: syzbot+e46fbd5289363464bc13@syzkaller.appspotmail.=
com
> > > > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > > >
> > > > > The code logic and style looks good to me.
> > > > > However, I don't have experience with that code to estimate if 20=
48
> > > > > flows per round is enough to avoid stalls for all normal circumst=
ances,
> > > > > so I guess someone else should take a look.
> > > > >
> > > >
> > > > Eric, I had the same question: Why 2048 (why not 12 for example? ;-=
>).
> > > > Could that number make more sense to add as an init attribute? Not
> > > > asking you to add it but i or somebody else could send a followup
> > > > patch after.
> > >
> > > This is based on experimentation.
> > >
> > > I started using 1024, then saw that using 2048 was okay.
> > >
> > > I think I gave some numbers in the changelog :
> > > "(less than 150 usec on debug kernels)."
> > >
> > > Spending 150 usec every jiffie seems reasonable to me.
> > >
> > > Honestly, I am not sure if anyone was/is using a high number of flows=
,
> > > given that whole qdisc enqueue/dequeue operations were frozen every 1=
5ms for
> > > 2 or 3 ms on non debug kernels :/
> >
> > Unfortunately such numbers tend to depend on the CPU used etc. Once
> > your patch goes in we can add an extension to set a netlink attribute
> > so the user can change this value (by default keep it at 2048).
> >
>
> Then syzbot will set this new attribute to 65536 and we are back to
> the initial bug.

Hail our new overlord and savior.

cheers,
jamal

