Return-Path: <netdev+bounces-12569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7C6738248
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 13:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A8028157C
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 11:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B3C11CB4;
	Wed, 21 Jun 2023 11:21:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5104C2F0
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 11:21:27 +0000 (UTC)
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346A310D5
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 04:21:18 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-47560c8e057so247800e0c.1
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 04:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1687346477; x=1689938477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zicZyLnS1reU8dn+e8y3aZCUsBuI2pk4J/AOSJ4Fj70=;
        b=tlo6FfXwpoWbQGMC/nTahJCIZuKCDP44BRTERwhgfGvSvghMuJkXeW95Bk27dXw4Lr
         pDZJxws/1XyBqY0J3w+McbxLUpbRgSY6ysUzF9q/zRPcWkXD4YqFo4LU60RT0MbIVcJ9
         +HigaRIbxEXjXMvMqg8ji+mI2l6bIFliIaNLa7cz0CZQlDm7UFLqjXTLbRF/FH5bEns9
         2WUjHzBXhYLG7IvIaHI/Hz6GLLv1olYKlnX+iuOqONRCguOPPco31sJKqmmNqCUWeVLS
         5X996QAAKm0/0/8JId1cvXMXdbmLCJGNIds+10BarI03sOuwUSMqvfu3Po69l/9g0xLx
         uv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687346477; x=1689938477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zicZyLnS1reU8dn+e8y3aZCUsBuI2pk4J/AOSJ4Fj70=;
        b=AMjyy6tPrjQb86HEq+noToH/IxueLZK/cl1nPchRgCsO4ALR2O3iIPWjLQT/aQM9je
         cNU/TMgonMHbnNurioV0ow4SaHS0ku6I30T7CLKW9KVx28bgPRx6TpKGKWjxWpDWZX2L
         BCzc8Yyb8LL6EGIKCUgQXtx3kPqOaLmp7MH8dzFDt65hCigpl7uBkwIr7Szyh45jsYJL
         p15esG0ICSqh5okrTxJh85g9elcwCOw8pD1PB02/N0hcSIv149b018Tg1zOQ6zKWIfc9
         JAZyUQZ8TvmPtIPFVY/8+dAA1VKgRLB/Vkq2PC1aROzD5lXL65DRl8/UVcpCqjs5akNS
         /+mg==
X-Gm-Message-State: AC+VfDxqreRjJXFh6T2ktcbbwvXCDIRIu2Fn5u3eIYnB96VFR4pPJ+Ym
	ARg6T7aIeHpl/eWE67QQyHYoCE/5YmtvLpF4i0d3yg==
X-Google-Smtp-Source: ACHHUZ5zh7zzLsz3XZd9uyuugVpB8yJrdbo0pdJh/b0zLL0aBk99WsJZsNhBkBpyh++aQrovpgTRrucUS/ebboC+7BA=
X-Received: by 2002:a1f:60cf:0:b0:471:6e65:576 with SMTP id
 u198-20020a1f60cf000000b004716e650576mr4063766vkb.3.1687346477306; Wed, 21
 Jun 2023 04:21:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230620184425.1179809-1-edumazet@google.com>
In-Reply-To: <20230620184425.1179809-1-edumazet@google.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 21 Jun 2023 07:21:06 -0400
Message-ID: <CAM0EoM=Jbjod+bdKexkcBxpzvGfsbT1gb_wU+uRjTcPHH_SJKQ@mail.gmail.com>
Subject: Re: [PATCH net] sch_netem: acquire qdisc lock in netem_change()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot <syzkaller@googlegroups.com>, Stephen Hemminger <stephen@networkplumber.org>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 20, 2023 at 2:44=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> syzbot managed to trigger a divide error [1] in netem.
>
> It could happen if q->rate changes while netem_enqueue()
> is running, since q->rate is read twice.
>
> It turns out netem_change() always lacked proper synchronization.
>
> [1]
> divide error: 0000 [#1] SMP KASAN
> CPU: 1 PID: 7867 Comm: syz-executor.1 Not tainted 6.1.30-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 05/25/2023
> RIP: 0010:div64_u64 include/linux/math64.h:69 [inline]
> RIP: 0010:packet_time_ns net/sched/sch_netem.c:357 [inline]
> RIP: 0010:netem_enqueue+0x2067/0x36d0 net/sched/sch_netem.c:576
> Code: 89 e2 48 69 da 00 ca 9a 3b 42 80 3c 28 00 4c 8b a4 24 88 00 00 00 7=
4 0d 4c 89 e7 e8 c3 4f 3b fd 48 8b 4c 24 18 48 89 d8 31 d2 <49> f7 34 24 49=
 01 c7 4c 8b 64 24 48 4d 01 f7 4c 89 e3 48 c1 eb 03
> RSP: 0018:ffffc9000dccea60 EFLAGS: 00010246
> RAX: 000001a442624200 RBX: 000001a442624200 RCX: ffff888108a4f000
> RDX: 0000000000000000 RSI: 000000000000070d RDI: 000000000000070d
> RBP: ffffc9000dcceb90 R08: ffffffff849c5e26 R09: fffffbfff10e1297
> R10: 0000000000000000 R11: dffffc0000000001 R12: ffff888108a4f358
> R13: dffffc0000000000 R14: 0000001a8cd9a7ec R15: 0000000000000000
> FS: 00007fa73fe18700(0000) GS:ffff8881f6b00000(0000) knlGS:00000000000000=
00
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fa73fdf7718 CR3: 000000011d36e000 CR4: 0000000000350ee0
> Call Trace:
> <TASK>
> [<ffffffff84714385>] __dev_xmit_skb net/core/dev.c:3931 [inline]
> [<ffffffff84714385>] __dev_queue_xmit+0xcf5/0x3370 net/core/dev.c:4290
> [<ffffffff84d22df2>] dev_queue_xmit include/linux/netdevice.h:3030 [inlin=
e]
> [<ffffffff84d22df2>] neigh_hh_output include/net/neighbour.h:531 [inline]
> [<ffffffff84d22df2>] neigh_output include/net/neighbour.h:545 [inline]
> [<ffffffff84d22df2>] ip_finish_output2+0xb92/0x10d0 net/ipv4/ip_output.c:=
235
> [<ffffffff84d21e63>] __ip_finish_output+0xc3/0x2b0
> [<ffffffff84d10a81>] ip_finish_output+0x31/0x2a0 net/ipv4/ip_output.c:323
> [<ffffffff84d10f14>] NF_HOOK_COND include/linux/netfilter.h:298 [inline]
> [<ffffffff84d10f14>] ip_output+0x224/0x2a0 net/ipv4/ip_output.c:437
> [<ffffffff84d123b5>] dst_output include/net/dst.h:444 [inline]
> [<ffffffff84d123b5>] ip_local_out net/ipv4/ip_output.c:127 [inline]
> [<ffffffff84d123b5>] __ip_queue_xmit+0x1425/0x2000 net/ipv4/ip_output.c:5=
42
> [<ffffffff84d12fdc>] ip_queue_xmit+0x4c/0x70 net/ipv4/ip_output.c:556
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Stephen Hemminger <stephen@networkplumber.org>
> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Cc: Jiri Pirko <jiri@resnulli.us>

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> ---
>  net/sched/sch_netem.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> index 6ef3021e1169a376494d610ac8c3f1c04fb911c5..e79be1b3e74da3c154f7ee23e=
16cc9e8da8f7106 100644
> --- a/net/sched/sch_netem.c
> +++ b/net/sched/sch_netem.c
> @@ -966,6 +966,7 @@ static int netem_change(struct Qdisc *sch, struct nla=
ttr *opt,
>         if (ret < 0)
>                 return ret;
>
> +       sch_tree_lock(sch);
>         /* backup q->clg and q->loss_model */
>         old_clg =3D q->clg;
>         old_loss_model =3D q->loss_model;
> @@ -974,7 +975,7 @@ static int netem_change(struct Qdisc *sch, struct nla=
ttr *opt,
>                 ret =3D get_loss_clg(q, tb[TCA_NETEM_LOSS]);
>                 if (ret) {
>                         q->loss_model =3D old_loss_model;
> -                       return ret;
> +                       goto unlock;
>                 }
>         } else {
>                 q->loss_model =3D CLG_RANDOM;
> @@ -1041,6 +1042,8 @@ static int netem_change(struct Qdisc *sch, struct n=
lattr *opt,
>         /* capping jitter to the range acceptable by tabledist() */
>         q->jitter =3D min_t(s64, abs(q->jitter), INT_MAX);
>
> +unlock:
> +       sch_tree_unlock(sch);
>         return ret;
>
>  get_table_failure:
> @@ -1050,7 +1053,8 @@ static int netem_change(struct Qdisc *sch, struct n=
lattr *opt,
>          */
>         q->clg =3D old_clg;
>         q->loss_model =3D old_loss_model;
> -       return ret;
> +
> +       goto unlock;
>  }
>
>  static int netem_init(struct Qdisc *sch, struct nlattr *opt,
> --
> 2.41.0.178.g377b9f9a00-goog
>

