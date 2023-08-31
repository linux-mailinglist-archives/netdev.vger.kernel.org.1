Return-Path: <netdev+bounces-31561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7560478EC55
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 13:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3043528151A
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 11:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94CB9460;
	Thu, 31 Aug 2023 11:41:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4649444
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 11:41:36 +0000 (UTC)
Received: from r3-24.sinamail.sina.com.cn (r3-24.sinamail.sina.com.cn [202.108.3.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C32BE63
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 04:41:24 -0700 (PDT)
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([112.97.53.170])
	by sina.com (172.16.97.23) with ESMTP
	id 64F07C5D00001B40; Thu, 31 Aug 2023 19:41:19 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 69514931457696
X-SMAIL-UIID: 61ABE43BA2DA49A7A438DA4E0AE7C64A-20230831-194119
From: Hillf Danton <hdanton@sina.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Netdev <netdev@vger.kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: selftests: net: pmtu.sh: Unable to handle kernel paging request at virtual address
Date: Thu, 31 Aug 2023 19:41:08 +0800
Message-Id: <20230831114108.4744-1-hdanton@sina.com>
In-Reply-To: <f607a7d5-8075-f321-e3c0-963993433b14@I-love.SAKURA.ne.jp>
References: <20230830112600.4483-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 30 Aug 2023 21:44:57 +0900 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>On 2023/08/30 20:26, Hillf Danton wrote:
>>> <4>[  399.014716] Call trace:
>>> <4>[  399.015702]  percpu_counter_add_batch+0x28/0xd0
>>> <4>[  399.016399]  dst_destroy+0x44/0x1e4
>>> <4>[  399.016681]  dst_destroy_rcu+0x14/0x20
>>> <4>[  399.017009]  rcu_core+0x2d0/0x5e0
>>> <4>[  399.017311]  rcu_core_si+0x10/0x1c
>>> <4>[  399.017609]  __do_softirq+0xd4/0x23c
>>> <4>[  399.017991]  ____do_softirq+0x10/0x1c
>>> <4>[  399.018320]  call_on_irq_stack+0x24/0x4c
>>> <4>[  399.018723]  do_softirq_own_stack+0x1c/0x28
>>> <4>[  399.022639]  __irq_exit_rcu+0x6c/0xcc
>>> <4>[  399.023434]  irq_exit_rcu+0x10/0x1c
>>> <4>[  399.023962]  el1_interrupt+0x8c/0xc0
>>> <4>[  399.024810]  el1h_64_irq_handler+0x18/0x24
>>> <4>[  399.025324]  el1h_64_irq+0x64/0x68
>>> <4>[  399.025612]  _raw_spin_lock_bh+0x0/0x6c
>>> <4>[  399.026102]  cleanup_net+0x280/0x45c
>>> <4>[  399.026403]  process_one_work+0x1d4/0x310
>>> <4>[  399.027140]  worker_thread+0x248/0x470
>>> <4>[  399.027621]  kthread+0xfc/0x184
>>> <4>[  399.028068]  ret_from_fork+0x10/0x20
>> 
>> static void cleanup_net(struct work_struct *work)
>> {
>> 	...
>> 
>> 	synchronize_rcu();
>> 
>> 	/* Run all of the network namespace exit methods */
>> 	list_for_each_entry_reverse(ops, &pernet_list, list)
>> 		ops_exit_list(ops, &net_exit_list);
>> 	...
>> 
>> Why did the RCU sync above fail to work in this report, Eric?
>
> Why do you assume that synchronize_rcu() failed to work?

In the ipv6 pernet_operations [1] for instance, dst_entries_destroy() is
invoked after RCU sync to ensure that nobody is using the exiting net,
but this report shows that protection falls apart.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/ipv6/route.c#n6557

> The trace merely says that an interrupt handler ran somewhere from
> cleanup_net(), and something went wrong inside dst_destroy().

But bc9d3a9f2afc and 483c26ff63f4 has been upsteam for quite a while.
Not sure if it is arm64 specific.

