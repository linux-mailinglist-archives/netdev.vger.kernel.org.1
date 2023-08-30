Return-Path: <netdev+bounces-31413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FAF78D69F
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 16:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3D7B280FE2
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 14:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6246AAC;
	Wed, 30 Aug 2023 14:48:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F553FFB
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 14:48:25 +0000 (UTC)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6A9FF
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 07:48:23 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5922b96c5fcso64348407b3.0
        for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 07:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1693406902; x=1694011702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+sMyOwBIT3rM9bUDXRkEU99iVszdOTM+71uU8XtSqpE=;
        b=Nc0phlCfC7i1egLjQ9/BpyxH0B3AI3BFY2rPWawPAaDBsTncEVsYRkycAdQMgcqQZv
         CnStQGVUhvgWUyCla7DW5/6SLvEQ9WDvjztybm3p0O3VfORYMiiesolBaXe4/UYJbdIj
         E6tICahiVaOI9f4P37NOo/2UWYBp1lLqvwBXHea3QuFzNlOJeFmxAHUN8FRGf920kC/S
         XS5MGWK7WANtmgaYC/nt6XK5nKYpV0IV5RWSDs23Hxl7qp+qvs+Er9/8B/RMyApzFshL
         99T4Dr8OMzSquN9bh3dYPLf97jSulB4zH+710UaXUiBS4AKBzZv6hihPa74cUkdC7nch
         QWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693406902; x=1694011702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+sMyOwBIT3rM9bUDXRkEU99iVszdOTM+71uU8XtSqpE=;
        b=hS36aSFFsoK+nuR7habjIve/fheKUZV1msSVHViNi0V806yY4G/vVuRlBUAZNv1QCT
         wwWUtVT6K8+3sNVKXA8e3a+fzEQaoGjxPeE9rATQVgUySHw9U/O++bYYUiNG3lLsrwNA
         BLZcVBkhAm/6B+5Q7LWdkPxPTq8eQKitui0amvEt9mKpAtx+GYrIx76wcQ45nQLpxXIs
         5zkd99DeqlZBxIKYxCAnk+y8Ver5BGt5PcZX+x1rLNidNQv3xST1Cz6LO9EkRE1tbqBH
         Xz1F5YTfgm3yzf/icX2AhuVUx89RFQjNHxptvMwGK0ufVi7KNoEkDNzL0pimBaPPbmjK
         39eA==
X-Gm-Message-State: AOJu0YwyPf3W74U7B2qjedKtRecPSbl+FjieGXlJ+tEtLKEOwaz9F61d
	EpvOzB8U6kObZqF49Tam0CJX3DISMhP0r5PhEesRwg==
X-Google-Smtp-Source: AGHT+IEAAwBprPtcHrSR+aOmPYtOsf/mHx6O9cmIkJaaRdLb5mJMfUUsf31iSqEb/cjorChk4K81XTRlfg9Q7nlvY7w=
X-Received: by 2002:a0d:d98c:0:b0:586:a2f9:648e with SMTP id
 b134-20020a0dd98c000000b00586a2f9648emr2473865ywe.4.1693406902568; Wed, 30
 Aug 2023 07:48:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230829123541.3745013-1-edumazet@google.com> <ZO9Q0ih6OQhq7sio@localhost.localdomain>
In-Reply-To: <ZO9Q0ih6OQhq7sio@localhost.localdomain>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 30 Aug 2023 10:48:11 -0400
Message-ID: <CAM0EoMnpL5rE-zDhiY_FKTOguX_3kKkWCGdX0ry8ZWXjmRLjfA@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: fq_pie: avoid stalls in fq_pie_timer()
To: Michal Kubiak <michal.kubiak@intel.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
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

On Wed, Aug 30, 2023 at 10:30=E2=80=AFAM Michal Kubiak <michal.kubiak@intel=
.com> wrote:
>
> On Tue, Aug 29, 2023 at 12:35:41PM +0000, Eric Dumazet wrote:
> > When setting a high number of flows (limit being 65536),
> > fq_pie_timer() is currently using too much time as syzbot reported.
> >
> > Add logic to yield the cpu every 2048 flows (less than 150 usec
> > on debug kernels).
> > It should also help by not blocking qdisc fast paths for too long.
> > Worst case (65536 flows) would need 31 jiffies for a complete scan.
> >
> > Relevant extract from syzbot report:
> >
> > rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 0-...=
. } 2663 jiffies s: 873 root: 0x1/.
> > rcu: blocking rcu_node structures (internal RCU debug):
> > Sending NMI from CPU 1 to CPUs 0:
> > NMI backtrace for cpu 0
> > CPU: 0 PID: 5177 Comm: syz-executor273 Not tainted 6.5.0-syzkaller-0045=
3-g727dbda16b83 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 07/26/2023
> > RIP: 0010:check_kcov_mode kernel/kcov.c:173 [inline]
> > RIP: 0010:write_comp_data+0x21/0x90 kernel/kcov.c:236
> > Code: 2e 0f 1f 84 00 00 00 00 00 65 8b 05 01 b2 7d 7e 49 89 f1 89 c6 49=
 89 d2 81 e6 00 01 00 00 49 89 f8 65 48 8b 14 25 80 b9 03 00 <a9> 00 01 ff =
00 74 0e 85 f6 74 59 8b 82 04 16 00 00 85 c0 74 4f 8b
> > RSP: 0018:ffffc90000007bb8 EFLAGS: 00000206
> > RAX: 0000000000000101 RBX: ffffc9000dc0d140 RCX: ffffffff885893b0
> > RDX: ffff88807c075940 RSI: 0000000000000100 RDI: 0000000000000001
> > RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000000 R12: ffffc9000dc0d178
> > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > FS:  0000555555d54380(0000) GS:ffff8880b9800000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f6b442f6130 CR3: 000000006fe1c000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <NMI>
> >  </NMI>
> >  <IRQ>
> >  pie_calculate_probability+0x480/0x850 net/sched/sch_pie.c:415
> >  fq_pie_timer+0x1da/0x4f0 net/sched/sch_fq_pie.c:387
> >  call_timer_fn+0x1a0/0x580 kernel/time/timer.c:1700
> >
> > Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet scheduler")
> > Link: https://lore.kernel.org/lkml/00000000000017ad3f06040bf394@google.=
com/
> > Reported-by: syzbot+e46fbd5289363464bc13@syzkaller.appspotmail.com
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> The code logic and style looks good to me.
> However, I don't have experience with that code to estimate if 2048
> flows per round is enough to avoid stalls for all normal circumstances,
> so I guess someone else should take a look.
>

Eric, I had the same question: Why 2048 (why not 12 for example? ;->).
Could that number make more sense to add as an init attribute? Not
asking you to add it but i or somebody else could send a followup
patch after.
Other than that:

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> Thanks,
> Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
>

