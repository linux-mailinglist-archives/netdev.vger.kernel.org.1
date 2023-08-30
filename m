Return-Path: <netdev+bounces-31395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E0378D5F1
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 14:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEF641C20821
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 12:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8489D525E;
	Wed, 30 Aug 2023 12:45:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797592107
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 12:45:22 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB254C2;
	Wed, 30 Aug 2023 05:45:20 -0700 (PDT)
Received: from fsav120.sakura.ne.jp (fsav120.sakura.ne.jp [27.133.134.247])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 37UCiu1T038329;
	Wed, 30 Aug 2023 21:44:56 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav120.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp);
 Wed, 30 Aug 2023 21:44:56 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 37UCiuog038326
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 30 Aug 2023 21:44:56 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f607a7d5-8075-f321-e3c0-963993433b14@I-love.SAKURA.ne.jp>
Date: Wed, 30 Aug 2023 21:44:57 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: selftests: net: pmtu.sh: Unable to handle kernel paging request
 at virtual address
Content-Language: en-US
To: Hillf Danton <hdanton@sina.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Netdev <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230830112600.4483-1-hdanton@sina.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20230830112600.4483-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/08/30 20:26, Hillf Danton wrote:
>> <4>[  399.014716] Call trace:
>> <4>[  399.015702]  percpu_counter_add_batch+0x28/0xd0
>> <4>[  399.016399]  dst_destroy+0x44/0x1e4
>> <4>[  399.016681]  dst_destroy_rcu+0x14/0x20
>> <4>[  399.017009]  rcu_core+0x2d0/0x5e0
>> <4>[  399.017311]  rcu_core_si+0x10/0x1c
>> <4>[  399.017609]  __do_softirq+0xd4/0x23c
>> <4>[  399.017991]  ____do_softirq+0x10/0x1c
>> <4>[  399.018320]  call_on_irq_stack+0x24/0x4c
>> <4>[  399.018723]  do_softirq_own_stack+0x1c/0x28
>> <4>[  399.022639]  __irq_exit_rcu+0x6c/0xcc
>> <4>[  399.023434]  irq_exit_rcu+0x10/0x1c
>> <4>[  399.023962]  el1_interrupt+0x8c/0xc0
>> <4>[  399.024810]  el1h_64_irq_handler+0x18/0x24
>> <4>[  399.025324]  el1h_64_irq+0x64/0x68
>> <4>[  399.025612]  _raw_spin_lock_bh+0x0/0x6c
>> <4>[  399.026102]  cleanup_net+0x280/0x45c
>> <4>[  399.026403]  process_one_work+0x1d4/0x310
>> <4>[  399.027140]  worker_thread+0x248/0x470
>> <4>[  399.027621]  kthread+0xfc/0x184
>> <4>[  399.028068]  ret_from_fork+0x10/0x20
> 
> static void cleanup_net(struct work_struct *work)
> {
> 	...
> 
> 	synchronize_rcu();
> 
> 	/* Run all of the network namespace exit methods */
> 	list_for_each_entry_reverse(ops, &pernet_list, list)
> 		ops_exit_list(ops, &net_exit_list);
> 	...
> 
> Why did the RCU sync above fail to work in this report, Eric?

Why do you assume that synchronize_rcu() failed to work?
The trace merely says that an interrupt handler ran somewhere from
cleanup_net(), and something went wrong inside dst_destroy().

Please decode the trace into filename:line format (like syzbot reports)
using scripts/faddr2line tool, in order to find the exact location.


