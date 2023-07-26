Return-Path: <netdev+bounces-21401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE46C76382E
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 15:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BC111C21270
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 13:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B79921D33;
	Wed, 26 Jul 2023 13:56:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABC8BA43
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 13:56:34 +0000 (UTC)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A942D55
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 06:54:50 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-4036bd4fff1so343241cf.0
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 06:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690379664; x=1690984464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COexSHp8mfkB2ce8L0l32/sMceJub3l4HXCq08ifNbo=;
        b=XFhHBDtCBfoTQTStj2YqIcfnrUBfCtzC6VhrWzJPN6fuDV/6+OFB4DG6kfb3UwKR0d
         qa9s82z8UQlj92pTD0V7kesLwDMPNlV3Oc49ukr2vENjKfm3qcEJ7n2x4NSaTvE00SXL
         ogsATbX2J3+NdsRr7ZwS70l+xnF7zbh5nCmFOSbmPvWQVQ80YL8Wf/FG7nAG4hnrONX5
         Ll9EcdbUAseBaXEWvd3xG1LPDgzuUTP3ETA3LaYdBTbqhjGNEhSsK0vCKjf1DWpgP2Zu
         2y1Hnq0LZsQ/QZ2SIhQ47NRBPbiAkxbtEouOwXCT/ix52N2iWACA5CaapopWtel9nXK8
         IHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690379664; x=1690984464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=COexSHp8mfkB2ce8L0l32/sMceJub3l4HXCq08ifNbo=;
        b=Sbmapv5uJzmRickR89gh8WbMGUq/tNQPeACw9LUBdFCs9Z1Y1PuOViuJhct9JoWPWO
         W/JGThpPGtcLpxo+6K3u+rOaua7UD4Q4tW9oP1y/VgnsnthiJxmK8ezHcfWcuLcT7uKK
         8IUALmaowdSNdzaDA0Glf0T0fMAxHMX+ollNlXykPomNApRJQ3Nn6hy0UDg4D5+ikxMx
         qtE8z6jAaq+l3pJpvK69IWdT2eboEpnK4sp9y7147pfUC/eGOTfMcW0rxRB147CN1Oem
         oBgzL/rr2cvXrY5v+XVCWvzFsINp21FhjDNSBWFglkd1Ea72YuxxMhVGMTKzdItC44EF
         6t+A==
X-Gm-Message-State: ABy/qLZlFcqmJw99hpYFYAvZpKw63X4kNQ4/fwr7nu2lLyYMLDyCEhJE
	tLRu4yzfZhSmSkeSd3rnLeLNzr2S8ubd+0845f5VEg==
X-Google-Smtp-Source: APBJJlHd2aflQMgx9Sw56Hy/jez0nuf036yJAMK3xpJfpDtLam3Q+Hv4mcD4slP2wvGVCcw89XFEHiuc5B6tPu3MFjQ=
X-Received: by 2002:ac8:5b12:0:b0:3f6:97b4:1a4d with SMTP id
 m18-20020ac85b12000000b003f697b41a4dmr500548qtw.23.1690379663631; Wed, 26 Jul
 2023 06:54:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230726011432.19250-1-kuniyu@amazon.com>
In-Reply-To: <20230726011432.19250-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Jul 2023 15:54:12 +0200
Message-ID: <CANn89i+nqvkXbxOANmrjLzbTx4YNO=ze3WbG6gF8Q_MToJJ5DQ@mail.gmail.com>
Subject: Re: [PATCH v1 net] net/sched: taprio: Limit TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME
 to INT_MAX.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Vedang Patel <vedang.patel@intel.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 3:15=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> syzkaller found a zero division error [0] in div_s64_rem() called from
> get_cycle_time_elapsed(), where sched->cycle_time is the divisor.
>
> We have tests in parse_taprio_schedule() so that cycle_time will never
> be 0, and actually cycle_time is not 0 in get_cycle_time_elapsed().
>
> The problem is that the types of divisor are different; cycle_time is
> s64, but the argument of div_s64_rem() is s32.
>
> syzkaller fed this input and 0x100000000 is cast to s32 to be 0.
>
>   @TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME=3D{0xc, 0x8, 0x100000000}
>
> We use s64 for cycle_time to cast it to ktime_t, so let's keep it and
> set min/max for cycle_time.
>
> [0]:
> divide error: 0000 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 1 PID: 103 Comm: kworker/1:3 Not tainted 6.5.0-rc1-00330-g60cc1f7d06=
05 #3
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-=
gd239552ce722-prebuilt.qemu.org 04/01/2014
> Workqueue: ipv6_addrconf addrconf_dad_work
> RIP: 0010:div_s64_rem include/linux/math64.h:42 [inline]
> RIP: 0010:get_cycle_time_elapsed net/sched/sch_taprio.c:223 [inline]
> RIP: 0010:find_entry_to_transmit+0x252/0x7e0 net/sched/sch_taprio.c:344
> Code: 3c 02 00 0f 85 5e 05 00 00 48 8b 4c 24 08 4d 8b bd 40 01 00 00 48 8=
b 7c 24 48 48 89 c8 4c 29 f8 48 63 f7 48 99 48 89 74 24 70 <48> f7 fe 48 29=
 d1 48 8d 04 0f 49 89 cc 48 89 44 24 20 49 8d 85 10
> RSP: 0018:ffffc90000acf260 EFLAGS: 00010206
> RAX: 177450e0347560cf RBX: 0000000000000000 RCX: 177450e0347560cf
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000100000000
> RBP: 0000000000000056 R08: 0000000000000000 R09: ffffed10020a0934
> R10: ffff8880105049a7 R11: ffff88806cf3a520 R12: ffff888010504800
> R13: ffff88800c00d800 R14: ffff8880105049a0 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff88806cf00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f0edf84f0e8 CR3: 000000000d73c002 CR4: 0000000000770ee0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  get_packet_txtime net/sched/sch_taprio.c:508 [inline]
>  taprio_enqueue_one+0x900/0xff0 net/sched/sch_taprio.c:577
>  taprio_enqueue+0x378/0xae0 net/sched/sch_taprio.c:658
>  dev_qdisc_enqueue+0x46/0x170 net/core/dev.c:3732
>  __dev_xmit_skb net/core/dev.c:3821 [inline]
>  __dev_queue_xmit+0x1b2f/0x3000 net/core/dev.c:4169
>  dev_queue_xmit include/linux/netdevice.h:3088 [inline]
>  neigh_resolve_output net/core/neighbour.c:1552 [inline]
>  neigh_resolve_output+0x4a7/0x780 net/core/neighbour.c:1532
>  neigh_output include/net/neighbour.h:544 [inline]
>  ip6_finish_output2+0x924/0x17d0 net/ipv6/ip6_output.c:135
>  __ip6_finish_output+0x620/0xaa0 net/ipv6/ip6_output.c:196
>  ip6_finish_output net/ipv6/ip6_output.c:207 [inline]
>  NF_HOOK_COND include/linux/netfilter.h:292 [inline]
>  ip6_output+0x206/0x410 net/ipv6/ip6_output.c:228
>  dst_output include/net/dst.h:458 [inline]
>  NF_HOOK.constprop.0+0xea/0x260 include/linux/netfilter.h:303
>  ndisc_send_skb+0x872/0xe80 net/ipv6/ndisc.c:508
>  ndisc_send_ns+0xb5/0x130 net/ipv6/ndisc.c:666
>  addrconf_dad_work+0xc14/0x13f0 net/ipv6/addrconf.c:4175
>  process_one_work+0x92c/0x13a0 kernel/workqueue.c:2597
>  worker_thread+0x60f/0x1240 kernel/workqueue.c:2748
>  kthread+0x2fe/0x3f0 kernel/kthread.c:389
>  ret_from_fork+0x2c/0x50 arch/x86/entry/entry_64.S:308
>  </TASK>
> Modules linked in:
>
> Fixes: 4cfd5779bd6e ("taprio: Add support for txtime-assist mode")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/sched/sch_taprio.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index 717ae51d94a0..72808acb5435 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -1015,6 +1015,11 @@ static const struct nla_policy taprio_tc_policy[TC=
A_TAPRIO_TC_ENTRY_MAX + 1] =3D {
>                                                               TC_FP_PREEM=
PTIBLE),
>  };
>
> +static struct netlink_range_validation_signed taprio_cycle_time_range =
=3D {
> +       .min =3D 1,
> +       .max =3D INT_MAX,
> +};
> +
>  static const struct nla_policy taprio_policy[TCA_TAPRIO_ATTR_MAX + 1] =
=3D {
>         [TCA_TAPRIO_ATTR_PRIOMAP]              =3D {
>                 .len =3D sizeof(struct tc_mqprio_qopt)
> @@ -1023,7 +1028,8 @@ static const struct nla_policy taprio_policy[TCA_TA=
PRIO_ATTR_MAX + 1] =3D {
>         [TCA_TAPRIO_ATTR_SCHED_BASE_TIME]            =3D { .type =3D NLA_=
S64 },
>         [TCA_TAPRIO_ATTR_SCHED_SINGLE_ENTRY]         =3D { .type =3D NLA_=
NESTED },
>         [TCA_TAPRIO_ATTR_SCHED_CLOCKID]              =3D { .type =3D NLA_=
S32 },
> -       [TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME]           =3D { .type =3D NLA_=
S64 },
> +       [TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME]           =3D
> +               NLA_POLICY_FULL_RANGE_SIGNED(NLA_S64, &taprio_cycle_time_=
range),
>         [TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME_EXTENSION] =3D { .type =3D NLA_=
S64 },
>         [TCA_TAPRIO_ATTR_FLAGS]                      =3D { .type =3D NLA_=
U32 },
>         [TCA_TAPRIO_ATTR_TXTIME_DELAY]               =3D { .type =3D NLA_=
U32 },
> --
> 2.30.2
>

Not sure this is enough (syzbot could very well find other ways to
trigger bugs caused by overflows)

What about setup_txtime() ? It seems possible to have overflows there...

What about adding to your patch the following ?

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 717ae51d94a0ae4f45317e8ba86f51ab4ac41aa6..a4bdc5d8bd6fc546bc835c953db=
81cdaf7285a40
100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1158,7 +1158,10 @@ static int parse_taprio_schedule(struct
taprio_sched *q, struct nlattr **tb,
                        NL_SET_ERR_MSG(extack, "'cycle_time' can never be 0=
");
                        return -EINVAL;
                }
-
+               if (cycle > INT_MAX) {
+                       NL_SET_ERR_MSG(extack, "'cycle_time' is too big");
+                       return -EINVAL;
+               }
                new->cycle_time =3D cycle;
        }

@@ -1347,7 +1350,7 @@ static void setup_txtime(struct taprio_sched *q,
                         struct sched_gate_list *sched, ktime_t base)
 {
        struct sched_entry *entry;
-       u32 interval =3D 0;
+       u64 interval =3D 0;

        list_for_each_entry(entry, &sched->entries, list) {
                entry->next_txtime =3D ktime_add_ns(base, interval);

