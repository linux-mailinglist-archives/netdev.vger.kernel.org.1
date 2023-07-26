Return-Path: <netdev+bounces-21605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D318E76401D
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 22:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E7B81C21235
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 20:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36F819886;
	Wed, 26 Jul 2023 20:04:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9126F4CE6C
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 20:04:26 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF59C1BF6
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 13:04:24 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a37909a64eso202567b6e.1
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 13:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1690401864; x=1691006664;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wyNj1FTIpJXGjVVHmJNCmL03dV5mi2G2moxL0WNHK1s=;
        b=oGf0nrn5xjG6zOIIngwiacpkdLfM9bcSbP2X7Dj2K4kxkwnKXqvrMmDGR5oARpkvgy
         aP6uUHTqtTUvM8kLy2XBrVqbSKVAsmLiLb+kjvZHtM2Fl8UN2LYXw+upVTMpIsIKh4n7
         TqvT5eiCh7T9qxtPa5SAgLcLIm6/qLWPyWZ5U7xrbCUn+54TzTuNVAaEAoVpayajQNap
         vElOZ5+1kS7TnWn9z9KjR8f7BQdMuwPyGE2rLZWhRnC/BkzXyJb6IhdDCIdDzg1SUDx7
         7Z3m9hVWKflmE9rwdBPmQcA8fguiweBHdzF4gj5z/iMCbajyhTcRm2+phFpNoIpRYWNR
         upUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690401864; x=1691006664;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wyNj1FTIpJXGjVVHmJNCmL03dV5mi2G2moxL0WNHK1s=;
        b=KeDxoDyH21it0O3t2q3qcBb9ylsj8rBduFUx1w7KrrUmHYxVAZWZGCP9RqirgRKkND
         /jq6v6eg/LMbb1OuAmaBwMyqqPYJ0e1cIk5SaU3cjE0LpNOiOh0UP+l7UyiPGQDmRoDi
         eklM5N5KNU+To2fhBea13dgy7e/tZcd9WIw9TjN2TFczGt//PRrVhTevWM+1+gAqvl0M
         e6Bz49A8JJz01E6QO40xZEjKaUHtjuMIQlzkzbQdiygegZxSuQzGHU3NOuPi4j4WZOiI
         pmUGCD4fYC2vXXjM82hYU5h7lVflxumnArqjOJX4Zo/5Qbxk7qpmQbsFExAOTl8Cn0uh
         VuQw==
X-Gm-Message-State: ABy/qLbriRnnxSccuTNS7uxmfxVOzV9USDfLTqfBRGUAys4i9XSNmIzX
	Jvwg0dgvS8/JDU3ybzFuePOvGA==
X-Google-Smtp-Source: APBJJlEZEZpZcYeJgyfIQPcTR685CqUd/dRcHXQrTFpWOawM7nh9wkMW66plo8g0c6MQk+JYFOe/Gw==
X-Received: by 2002:a05:6808:1520:b0:3a4:8f16:f637 with SMTP id u32-20020a056808152000b003a48f16f637mr642207oiw.48.1690401864156;
        Wed, 26 Jul 2023 13:04:24 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:526a:9255:9fc8:954f? ([2804:14d:5c5e:44fb:526a:9255:9fc8:954f])
        by smtp.gmail.com with ESMTPSA id bm47-20020a0568081aaf00b003a5b027ccb2sm4221506oib.38.2023.07.26.13.04.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 13:04:23 -0700 (PDT)
Message-ID: <51af51ae-0d33-ef0b-ae11-63420e446630@mojatatu.com>
Date: Wed, 26 Jul 2023 17:04:18 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 net] net/sched: taprio: Limit
 TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME to INT_MAX.
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>
Cc: Vedang Patel <vedang.patel@intel.com>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 syzkaller <syzkaller@googlegroups.com>
References: <20230726191928.50768-1-kuniyu@amazon.com>
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20230726191928.50768-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 26/07/2023 16:19, Kuniyuki Iwashima wrote:
> syzkaller found zero division error [0] in div_s64_rem() called from
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
>    @TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME={0xc, 0x8, 0x100000000}
> 
> We use s64 for cycle_time to cast it to ktime_t, so let's keep it and
> set min/max for cycle_time.
> 
> While at it, we prevent overflow in setup_txtime() and add another
> test in parse_taprio_schedule() to check if cycle_time overflows.
> 
> [0]:
> divide error: 0000 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 1 PID: 103 Comm: kworker/1:3 Not tainted 6.5.0-rc1-00330-g60cc1f7d0605 #3
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> Workqueue: ipv6_addrconf addrconf_dad_work
> RIP: 0010:div_s64_rem include/linux/math64.h:42 [inline]
> RIP: 0010:get_cycle_time_elapsed net/sched/sch_taprio.c:223 [inline]
> RIP: 0010:find_entry_to_transmit+0x252/0x7e0 net/sched/sch_taprio.c:344
> Code: 3c 02 00 0f 85 5e 05 00 00 48 8b 4c 24 08 4d 8b bd 40 01 00 00 48 8b 7c 24 48 48 89 c8 4c 29 f8 48 63 f7 48 99 48 89 74 24 70 <48> f7 fe 48 29 d1 48 8d 04 0f 49 89 cc 48 89 44 24 20 49 8d 85 10
> RSP: 0018:ffffc90000acf260 EFLAGS: 00010206
> RAX: 177450e0347560cf RBX: 0000000000000000 RCX: 177450e0347560cf
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000100000000
> RBP: 0000000000000056 R08: 0000000000000000 R09: ffffed10020a0934
> R10: ffff8880105049a7 R11: ffff88806cf3a520 R12: ffff888010504800
> R13: ffff88800c00d800 R14: ffff8880105049a0 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff88806cf00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f0edf84f0e8 CR3: 000000000d73c002 CR4: 0000000000770ee0
> PKRU: 55555554
> Call Trace:
>   <TASK>
>   get_packet_txtime net/sched/sch_taprio.c:508 [inline]
>   taprio_enqueue_one+0x900/0xff0 net/sched/sch_taprio.c:577
>   taprio_enqueue+0x378/0xae0 net/sched/sch_taprio.c:658
>   dev_qdisc_enqueue+0x46/0x170 net/core/dev.c:3732
>   __dev_xmit_skb net/core/dev.c:3821 [inline]
>   __dev_queue_xmit+0x1b2f/0x3000 net/core/dev.c:4169
>   dev_queue_xmit include/linux/netdevice.h:3088 [inline]
>   neigh_resolve_output net/core/neighbour.c:1552 [inline]
>   neigh_resolve_output+0x4a7/0x780 net/core/neighbour.c:1532
>   neigh_output include/net/neighbour.h:544 [inline]
>   ip6_finish_output2+0x924/0x17d0 net/ipv6/ip6_output.c:135
>   __ip6_finish_output+0x620/0xaa0 net/ipv6/ip6_output.c:196
>   ip6_finish_output net/ipv6/ip6_output.c:207 [inline]
>   NF_HOOK_COND include/linux/netfilter.h:292 [inline]
>   ip6_output+0x206/0x410 net/ipv6/ip6_output.c:228
>   dst_output include/net/dst.h:458 [inline]
>   NF_HOOK.constprop.0+0xea/0x260 include/linux/netfilter.h:303
>   ndisc_send_skb+0x872/0xe80 net/ipv6/ndisc.c:508
>   ndisc_send_ns+0xb5/0x130 net/ipv6/ndisc.c:666
>   addrconf_dad_work+0xc14/0x13f0 net/ipv6/addrconf.c:4175
>   process_one_work+0x92c/0x13a0 kernel/workqueue.c:2597
>   worker_thread+0x60f/0x1240 kernel/workqueue.c:2748
>   kthread+0x2fe/0x3f0 kernel/kthread.c:389
>   ret_from_fork+0x2c/0x50 arch/x86/entry/entry_64.S:308
>   </TASK>
> Modules linked in:
> 
> Fixes: 4cfd5779bd6e ("taprio: Add support for txtime-assist mode")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Co-developed-by: Eric Dumazet <edumazet@google.com>
> ---
> v2
>    * Prevent overflow in setup_txtime() and parse_taprio_schedule()
>      and add extack for such cases
>      (Added cycle < 0 test in addition to Eric's suggestion)
> 
> v1: https://lore.kernel.org/netdev/20230726011432.19250-1-kuniyu@amazon.com/
> ---

It is reproducible with a tdc test and a simple network setup triggers it.
If you don't mind sending it, here it is:

diff --git 
a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json 
b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
index a44455372646..08d4861c2e78 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
@@ -131,5 +131,30 @@
          "teardown": [
              "echo \"1\" > /sys/bus/netdevsim/del_device"
          ]
+    },
+    {
+        "id": "3e1e",
+        "name": "Add taprio Qdisc with an invalid cycle-time",
+        "category": [
+            "qdisc",
+            "taprio"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1 1 8\" > /sys/bus/netdevsim/new_device",
+            "$TC qdisc add dev $ETH root handle 1: taprio num_tc 3 map 
2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 queues 1@0 1@0 1@0 base-time 1000000000 
sched-entry S 01 300000 flags 0x1 clockid CLOCK_TAI cycle-time 
4294967296 || /bin/true",
+            "$IP link set dev $ETH up",
+            "$IP addr add 10.10.10.10/24 dev $ETH"
+        ],
+        "cmdUnderTest": "/bin/true",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $ETH",
+        "matchPattern": "qdisc taprio 1: root refcnt",
+        "matchCount": "0",
+        "teardown": [
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
      }
  ]


