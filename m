Return-Path: <netdev+bounces-21646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A0D764162
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 23:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6C5C1C213BA
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 21:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A83C1BF19;
	Wed, 26 Jul 2023 21:46:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1601BF04
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 21:46:16 +0000 (UTC)
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53C7F5
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 14:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1690407975; x=1721943975;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xtCBO2W/ffEuCLKZTmkFR2K7CwBlhd1eRDoXUxSEimA=;
  b=hfBii7QH47+1cNxrCzy3hiqcfV/Vod68ZKn5iW2UHqethjVF1fubX8og
   CGwH16D/UpvEKYrY9Chn98JtcJiqIBPkl6ZQ5enEfoujeThyRxYbPthNK
   xeT90axpRO/tTWueWUl1NjgaPMZydUu3oi2v0RgimKp04QrC0aDDpUaSa
   A=;
X-IronPort-AV: E=Sophos;i="6.01,233,1684800000"; 
   d="scan'208";a="229217467"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-d47337e0.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 21:46:13 +0000
Received: from EX19MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
	by email-inbound-relay-pdx-2a-m6i4x-d47337e0.us-west-2.amazon.com (Postfix) with ESMTPS id 10B97609B4;
	Wed, 26 Jul 2023 21:46:12 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 26 Jul 2023 21:46:11 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.26) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 26 Jul 2023 21:46:08 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pctammela@mojatatu.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <jhs@mojatatu.com>,
	<jiri@resnulli.us>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzkaller@googlegroups.com>, <vedang.patel@intel.com>,
	<vinicius.gomes@intel.com>, <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH v2 net] net/sched: taprio: Limit TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME to INT_MAX.
Date: Wed, 26 Jul 2023 14:46:00 -0700
Message-ID: <20230726214600.67449-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <51af51ae-0d33-ef0b-ae11-63420e446630@mojatatu.com>
References: <51af51ae-0d33-ef0b-ae11-63420e446630@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.171.26]
X-ClientProxiedBy: EX19D038UWC002.ant.amazon.com (10.13.139.238) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Pedro Tammela <pctammela@mojatatu.com>
Date: Wed, 26 Jul 2023 17:04:18 -0300
> On 26/07/2023 16:19, Kuniyuki Iwashima wrote:
> > syzkaller found zero division error [0] in div_s64_rem() called from
> > get_cycle_time_elapsed(), where sched->cycle_time is the divisor.
> > 
> > We have tests in parse_taprio_schedule() so that cycle_time will never
> > be 0, and actually cycle_time is not 0 in get_cycle_time_elapsed().
> > 
> > The problem is that the types of divisor are different; cycle_time is
> > s64, but the argument of div_s64_rem() is s32.
> > 
> > syzkaller fed this input and 0x100000000 is cast to s32 to be 0.
> > 
> >    @TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME={0xc, 0x8, 0x100000000}
> > 
> > We use s64 for cycle_time to cast it to ktime_t, so let's keep it and
> > set min/max for cycle_time.
> > 
> > While at it, we prevent overflow in setup_txtime() and add another
> > test in parse_taprio_schedule() to check if cycle_time overflows.
> > 
> > [0]:
> > divide error: 0000 [#1] PREEMPT SMP KASAN NOPTI
> > CPU: 1 PID: 103 Comm: kworker/1:3 Not tainted 6.5.0-rc1-00330-g60cc1f7d0605 #3
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > Workqueue: ipv6_addrconf addrconf_dad_work
> > RIP: 0010:div_s64_rem include/linux/math64.h:42 [inline]
> > RIP: 0010:get_cycle_time_elapsed net/sched/sch_taprio.c:223 [inline]
> > RIP: 0010:find_entry_to_transmit+0x252/0x7e0 net/sched/sch_taprio.c:344
> > Code: 3c 02 00 0f 85 5e 05 00 00 48 8b 4c 24 08 4d 8b bd 40 01 00 00 48 8b 7c 24 48 48 89 c8 4c 29 f8 48 63 f7 48 99 48 89 74 24 70 <48> f7 fe 48 29 d1 48 8d 04 0f 49 89 cc 48 89 44 24 20 49 8d 85 10
> > RSP: 0018:ffffc90000acf260 EFLAGS: 00010206
> > RAX: 177450e0347560cf RBX: 0000000000000000 RCX: 177450e0347560cf
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000100000000
> > RBP: 0000000000000056 R08: 0000000000000000 R09: ffffed10020a0934
> > R10: ffff8880105049a7 R11: ffff88806cf3a520 R12: ffff888010504800
> > R13: ffff88800c00d800 R14: ffff8880105049a0 R15: 0000000000000000
> > FS:  0000000000000000(0000) GS:ffff88806cf00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f0edf84f0e8 CR3: 000000000d73c002 CR4: 0000000000770ee0
> > PKRU: 55555554
> > Call Trace:
> >   <TASK>
> >   get_packet_txtime net/sched/sch_taprio.c:508 [inline]
> >   taprio_enqueue_one+0x900/0xff0 net/sched/sch_taprio.c:577
> >   taprio_enqueue+0x378/0xae0 net/sched/sch_taprio.c:658
> >   dev_qdisc_enqueue+0x46/0x170 net/core/dev.c:3732
> >   __dev_xmit_skb net/core/dev.c:3821 [inline]
> >   __dev_queue_xmit+0x1b2f/0x3000 net/core/dev.c:4169
> >   dev_queue_xmit include/linux/netdevice.h:3088 [inline]
> >   neigh_resolve_output net/core/neighbour.c:1552 [inline]
> >   neigh_resolve_output+0x4a7/0x780 net/core/neighbour.c:1532
> >   neigh_output include/net/neighbour.h:544 [inline]
> >   ip6_finish_output2+0x924/0x17d0 net/ipv6/ip6_output.c:135
> >   __ip6_finish_output+0x620/0xaa0 net/ipv6/ip6_output.c:196
> >   ip6_finish_output net/ipv6/ip6_output.c:207 [inline]
> >   NF_HOOK_COND include/linux/netfilter.h:292 [inline]
> >   ip6_output+0x206/0x410 net/ipv6/ip6_output.c:228
> >   dst_output include/net/dst.h:458 [inline]
> >   NF_HOOK.constprop.0+0xea/0x260 include/linux/netfilter.h:303
> >   ndisc_send_skb+0x872/0xe80 net/ipv6/ndisc.c:508
> >   ndisc_send_ns+0xb5/0x130 net/ipv6/ndisc.c:666
> >   addrconf_dad_work+0xc14/0x13f0 net/ipv6/addrconf.c:4175
> >   process_one_work+0x92c/0x13a0 kernel/workqueue.c:2597
> >   worker_thread+0x60f/0x1240 kernel/workqueue.c:2748
> >   kthread+0x2fe/0x3f0 kernel/kthread.c:389
> >   ret_from_fork+0x2c/0x50 arch/x86/entry/entry_64.S:308
> >   </TASK>
> > Modules linked in:
> > 
> > Fixes: 4cfd5779bd6e ("taprio: Add support for txtime-assist mode")
> > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > Co-developed-by: Eric Dumazet <edumazet@google.com>
> > ---
> > v2
> >    * Prevent overflow in setup_txtime() and parse_taprio_schedule()
> >      and add extack for such cases
> >      (Added cycle < 0 test in addition to Eric's suggestion)
> > 
> > v1: https://lore.kernel.org/netdev/20230726011432.19250-1-kuniyu@amazon.com/
> > ---
> 
> It is reproducible with a tdc test and a simple network setup triggers it.
> If you don't mind sending it, here it is:

I also confirmed the test reproduced the issue.
Will add it in v3.

Thanks!

---8<---
# python3 tdc.py -f tc-tests/qdiscs/taprio.json
...
Test 3e1e: Add taprio Qdisc with an invalid cycle-time
[   38.714868] divide error: 0000 [#1] PREEMPT SMP KASAN NOPTI
[   38.715313] CPU: 0 PID: 43 Comm: kworker/0:2 Not tainted 6.5.0-rc1-00329-g723970affdd8-dirty #8
---8<---


> 
> diff --git 
> a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json 
> b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
> index a44455372646..08d4861c2e78 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
> @@ -131,5 +131,30 @@
>           "teardown": [
>               "echo \"1\" > /sys/bus/netdevsim/del_device"
>           ]
> +    },
> +    {
> +        "id": "3e1e",
> +        "name": "Add taprio Qdisc with an invalid cycle-time",
> +        "category": [
> +            "qdisc",
> +            "taprio"
> +        ],
> +        "plugins": {
> +            "requires": "nsPlugin"
> +        },
> +        "setup": [
> +            "echo \"1 1 8\" > /sys/bus/netdevsim/new_device",
> +            "$TC qdisc add dev $ETH root handle 1: taprio num_tc 3 map 
> 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 queues 1@0 1@0 1@0 base-time 1000000000 
> sched-entry S 01 300000 flags 0x1 clockid CLOCK_TAI cycle-time 
> 4294967296 || /bin/true",
> +            "$IP link set dev $ETH up",
> +            "$IP addr add 10.10.10.10/24 dev $ETH"
> +        ],
> +        "cmdUnderTest": "/bin/true",
> +        "expExitCode": "0",
> +        "verifyCmd": "$TC qdisc show dev $ETH",
> +        "matchPattern": "qdisc taprio 1: root refcnt",
> +        "matchCount": "0",
> +        "teardown": [
> +            "echo \"1\" > /sys/bus/netdevsim/del_device"
> +        ]
>       }
>   ]

