Return-Path: <netdev+bounces-46535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2927E4C62
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 00:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 335A8B20DCA
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 23:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E6530652;
	Tue,  7 Nov 2023 23:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="wo4P00xr"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7970C210B
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 23:00:09 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB92D78
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 15:00:08 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32f7c80ab33so3699020f8f.0
        for <netdev@vger.kernel.org>; Tue, 07 Nov 2023 15:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1699398007; x=1700002807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tH8FoKh7cHQDHvyLNhPgTHfTTeil2f3JK8l4/BlvzE=;
        b=wo4P00xrUAcPZJeagGcptfBUYBfgsf6xf7hSPzp8TvtJZmRkBsoiN170LudiQ1LK5E
         7hZmFd3MeMKNl8yG3UEQ+NNfLgsP2WKBPMgqwI5om3CbWkf6zRXYVkz5IIqkyYdJ8qQy
         uREGOv75bLSDEe3cqN7BLtYFLlvS5HoZYeLEc8eD5HbmEZX+EIPMeEmOSq9plgT2foLP
         6rtxkkxriEQ5TzA1D4nD3DI20QoW2Rg56asrVmD4JqhyX3e2V4QmL6d8RnLdrSkY+SN6
         TXAWmKsUD2s1NRGYq5Ilba/RoegbnTkzBNL2NJo+/5Ow9Q5fL7VIsaWk2dOE8PNEK8LJ
         Veng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699398007; x=1700002807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0tH8FoKh7cHQDHvyLNhPgTHfTTeil2f3JK8l4/BlvzE=;
        b=sa4FKhqZNWz5YAuljzBrAaTDPGpJi6vBw2XyY5O3+1lF1aFx/mpXh3Cvf0fpt8RQ2m
         AyBc+1Btaid8U3iUMa77lk+ON1/mSSvzyVZtjPT0Nz4Zf6idCnJMqNZ1hiNSZOZSsQ6g
         GFlOgIr8jPbITZHL1U9zJpKOVqivU6WjUa1FHvTdWhdvSre9x6C3BxUDR5RQ119dlo1x
         JdQeFzn7uGjONNUaJu0snvP5E9IjOVys7JyfxQqFuRkcllQdQWZSpElcdYm527wuKmO1
         P5z3OeXXLfY5Roji2E7AP2CYZ7uWJW7PpmZfvaLa7dFXseKcTlVgfeYcAxRtXH/9C52R
         PBaQ==
X-Gm-Message-State: AOJu0YxDrsCfCAbIfqSaL87ppMJwAum8CYlNLVjDreVPwGKPWR4gtzq6
	o172apF9WDFPJxjihLgl8x/JexZaYfArHikvVuEsvw==
X-Google-Smtp-Source: AGHT+IGuggcU1bh9QWzOFqzQIUImXNmuJSXG+ioTXW26kiI/yqa+p0mi5qbuCLQInXWLlRHZWlpXSiZNQmCrZJuBBUw=
X-Received: by 2002:a05:6000:719:b0:32d:570b:c0a4 with SMTP id
 bs25-20020a056000071900b0032d570bc0a4mr164770wrb.27.1699398006989; Tue, 07
 Nov 2023 15:00:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231107160440.1992526-1-edumazet@google.com>
In-Reply-To: <20231107160440.1992526-1-edumazet@google.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 7 Nov 2023 17:59:54 -0500
Message-ID: <CAM0EoMmJ_tDjCXbA3bKT1Y4xkYGtTAPnnU8nw=XgUonF8pgyWA@mail.gmail.com>
Subject: Re: [PATCH net] net_sched: sch_fq: better validate TCA_FQ_WEIGHTS and TCA_FQ_PRIOMAP
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 11:04=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> syzbot was able to trigger the following report while providing
> too small TCA_FQ_WEIGHTS attribute [1]
>
> Fix is to use NLA_POLICY_EXACT_LEN() to ensure user space
> provided correct sizes.
>
> Apply the same fix to TCA_FQ_PRIOMAP.
>
> [1]
> BUG: KMSAN: uninit-value in fq_load_weights net/sched/sch_fq.c:960 [inlin=
e]
> BUG: KMSAN: uninit-value in fq_change+0x1348/0x2fe0 net/sched/sch_fq.c:10=
71
> fq_load_weights net/sched/sch_fq.c:960 [inline]
> fq_change+0x1348/0x2fe0 net/sched/sch_fq.c:1071
> fq_init+0x68e/0x780 net/sched/sch_fq.c:1159
> qdisc_create+0x12f3/0x1be0 net/sched/sch_api.c:1326
> tc_modify_qdisc+0x11ef/0x2c20
> rtnetlink_rcv_msg+0x16a6/0x1840 net/core/rtnetlink.c:6558
> netlink_rcv_skb+0x371/0x650 net/netlink/af_netlink.c:2545
> rtnetlink_rcv+0x34/0x40 net/core/rtnetlink.c:6576
> netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
> netlink_unicast+0xf47/0x1250 net/netlink/af_netlink.c:1368
> netlink_sendmsg+0x1238/0x13d0 net/netlink/af_netlink.c:1910
> sock_sendmsg_nosec net/socket.c:730 [inline]
> __sock_sendmsg net/socket.c:745 [inline]
> ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2588
> ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2642
> __sys_sendmsg net/socket.c:2671 [inline]
> __do_sys_sendmsg net/socket.c:2680 [inline]
> __se_sys_sendmsg net/socket.c:2678 [inline]
> __x64_sys_sendmsg+0x307/0x490 net/socket.c:2678
> do_syscall_x64 arch/x86/entry/common.c:51 [inline]
> do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
> entry_SYSCALL_64_after_hwframe+0x63/0x6b
>
> Uninit was created at:
> slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
> slab_alloc_node mm/slub.c:3478 [inline]
> kmem_cache_alloc_node+0x5e9/0xb10 mm/slub.c:3523
> kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:560
> __alloc_skb+0x318/0x740 net/core/skbuff.c:651
> alloc_skb include/linux/skbuff.h:1286 [inline]
> netlink_alloc_large_skb net/netlink/af_netlink.c:1214 [inline]
> netlink_sendmsg+0xb34/0x13d0 net/netlink/af_netlink.c:1885
> sock_sendmsg_nosec net/socket.c:730 [inline]
> __sock_sendmsg net/socket.c:745 [inline]
> ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2588
> ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2642
> __sys_sendmsg net/socket.c:2671 [inline]
> __do_sys_sendmsg net/socket.c:2680 [inline]
> __se_sys_sendmsg net/socket.c:2678 [inline]
> __x64_sys_sendmsg+0x307/0x490 net/socket.c:2678
> do_syscall_x64 arch/x86/entry/common.c:51 [inline]
> do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
> entry_SYSCALL_64_after_hwframe+0x63/0x6b
>
> CPU: 1 PID: 5001 Comm: syz-executor300 Not tainted 6.6.0-syzkaller-12401-=
g8f6f76a6a29f #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 10/09/2023
>
> Fixes: 29f834aa326e ("net_sched: sch_fq: add 3 bands and WRR scheduling")
> Fixes: 49e7265fd098 ("net_sched: sch_fq: add TCA_FQ_WEIGHTS attribute")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/sched/sch_fq.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> index 0fd18c344ab5ae6d53e12fc764c0506a2979b4c8..3a31c47fea9bd97d815f2624d=
926bf7be62387cd 100644
> --- a/net/sched/sch_fq.c
> +++ b/net/sched/sch_fq.c
> @@ -919,14 +919,8 @@ static const struct nla_policy fq_policy[TCA_FQ_MAX =
+ 1] =3D {
>         [TCA_FQ_TIMER_SLACK]            =3D { .type =3D NLA_U32 },
>         [TCA_FQ_HORIZON]                =3D { .type =3D NLA_U32 },
>         [TCA_FQ_HORIZON_DROP]           =3D { .type =3D NLA_U8 },
> -       [TCA_FQ_PRIOMAP]                =3D {
> -                       .type =3D NLA_BINARY,
> -                       .len =3D sizeof(struct tc_prio_qopt),
> -               },
> -       [TCA_FQ_WEIGHTS]                =3D {
> -                       .type =3D NLA_BINARY,
> -                       .len =3D FQ_BANDS * sizeof(s32),
> -               },
> +       [TCA_FQ_PRIOMAP]                =3D NLA_POLICY_EXACT_LEN(sizeof(s=
truct tc_prio_qopt)),
> +       [TCA_FQ_WEIGHTS]                =3D NLA_POLICY_EXACT_LEN(FQ_BANDS=
 * sizeof(s32)),
>  };
>
>  /* compress a u8 array with all elems <=3D 3 to an array of 2-bit fields=
 */

Acked-by: Jamal Hadi Salim<jhs@mojatatu.com>

cheers,
jamal
> --
> 2.42.0.869.gea05f2083d-goog
>

