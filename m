Return-Path: <netdev+bounces-51054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 511117F8CD8
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 18:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73CA11C20AD8
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 17:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AF82C863;
	Sat, 25 Nov 2023 17:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTh2U43f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7A211F
	for <netdev@vger.kernel.org>; Sat, 25 Nov 2023 09:36:46 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40b399a6529so9423745e9.1
        for <netdev@vger.kernel.org>; Sat, 25 Nov 2023 09:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700933805; x=1701538605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xaOhHx5fqJQhzmI9UMBDJ629veoD+SltmQvPKayB/D0=;
        b=QTh2U43fllffImnBLbiULlnRt+ySTtPyR5H/arVtkGECUh3vbtaPd6oIJD4+Wat3R+
         ulJKGeJjh0+4d3sAEpvs0Nb4zBo5d5uFGrQ2Bx+kPQ2SCQguqFx4jr0CgexBabu30wx9
         IrVSHxsB3n66+oM1StT09jxjpSE4URb7eHSEkyFcsAm1mixu3UTc87tNXsWKVQHpqKZ5
         QJ1KWJ5MHf4tcQTmWZc8qeyuqPGqh/IpoPyRAnZOg0aOWA5R0kK2GA8pe6r++JvxhO6u
         AK9AETx3JJW09NeSfSXCn06AeXD+H6smYrhjfygAxVWB/9LF5xKzCdDoLz2ZoJnXtzph
         vCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700933805; x=1701538605;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xaOhHx5fqJQhzmI9UMBDJ629veoD+SltmQvPKayB/D0=;
        b=hmdVZBHVRmo9uTizsjmbJ0MSiVMl/dLqqe79yJ2pUP9oo36WdkQdaxSJNXtyByMZfO
         3pBy07J/yhGHVkZLh1jRty5PBu6TrJCUNumngBwdi7D+3jlGkVgeHfu9PfWLVjiUlJw5
         wZHhJ18N6mGakB8iPWdXUeSCPxu1aDTHLzbZi3rPUDrXEwzW68fPFkyXEJ5mKfEZhCPc
         yvzrFwK/JKH9K0mz34d31imv3+YVJ6ONZEmptlNaFKQhC54QicAEyL/KhlGfh6+Sgv5K
         jESBIoSW2+fPGG3HMDalOktLqHxObUtAdfVBYv1bl6xl7UO7C1O6/SH6dmNvHqy9M60a
         10aA==
X-Gm-Message-State: AOJu0YyalQUFigHvjZXPXn0fxr8Hu1uVH+Ho7/AJ/SDra/3an65MeB4Q
	3exllZ9QnOibIR4xtHz+zSkRzWVSEB0=
X-Google-Smtp-Source: AGHT+IGBGqme2ZY8BtaMkdclXqwBB4jDR0yGuFp0hQ1D72gp0imq8qx9rMjPJAz15AAtIUHc3ZoaNw==
X-Received: by 2002:a5d:4946:0:b0:332:e3ad:4273 with SMTP id r6-20020a5d4946000000b00332e3ad4273mr9248372wrs.2.1700933804487;
        Sat, 25 Nov 2023 09:36:44 -0800 (PST)
Received: from ?IPV6:2a01:c22:6e7b:8300:8429:9ce:215b:f3ee? (dynamic-2a01-0c22-6e7b-8300-8429-09ce-215b-f3ee.c22.pool.telefonica.de. [2a01:c22:6e7b:8300:8429:9ce:215b:f3ee])
        by smtp.googlemail.com with ESMTPSA id ay12-20020a05600c1e0c00b0040588d85b3asm9090569wmb.15.2023.11.25.09.36.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Nov 2023 09:36:43 -0800 (PST)
Message-ID: <da9ddec6-ab6d-4ab0-95a7-142af7f0786d@gmail.com>
Date: Sat, 25 Nov 2023 18:36:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] r8169: deadlock when NetworkManager brings link up
Content-Language: en-US
To: Ian Chen <free122448@hotmail.com>, netdev@vger.kernel.org
References: <LV2P220MB08459B430FFD8830782201B4D2BFA@LV2P220MB0845.NAMP220.PROD.OUTLOOK.COM>
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <LV2P220MB08459B430FFD8830782201B4D2BFA@LV2P220MB0845.NAMP220.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25.11.2023 14:55, Ian Chen wrote:
> Hello,
> 
> My home server runs Arch Linux with its stock kernel on a GIGABYTE Z790
> AORUS ELITE AX with its builtin RTL8125B ethernet adapter.
> 
> After upgrading from 6.6.1.arch1 to 6.6.2.arch1, booting up the system
> would end up in a state where all operations on any netlink socket
> would block forever. The system is effectively unusable. Here's the
> relevant dmesg:
> 
> kernel: INFO: task kworker/u64:2:218 blocked for more than 122 seconds.
> kernel:       Not tainted 6.6.2-arch1-1 #1
> kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> this message.
> kernel: task:kworker/u64:2   state:D stack:0     pid:218   ppid:2     
> flags:0x00004000
> kernel: Workqueue: events_power_efficient crda_timeout_work [cfg80211]
> kernel: Call Trace:
> kernel:  <TASK>
> kernel:  __schedule+0x3e8/0x1410
> kernel:  schedule+0x5e/0xd0
> kernel:  schedule_preempt_disabled+0x15/0x30
> kernel:  __mutex_lock.constprop.0+0x39a/0x6a0
> kernel:  crda_timeout_work+0x10/0x40 [cfg80211
> d1ff02bd631e7b94dc4a8630ea4cdb5aede1cb9b]
> kernel:  process_one_work+0x171/0x340
> kernel:  worker_thread+0x27b/0x3a0
> kernel:  ? __pfx_worker_thread+0x10/0x10
> kernel:  kthread+0xe5/0x120
> kernel:  ? __pfx_kthread+0x10/0x10
> kernel:  ret_from_fork+0x31/0x50
> kernel:  ? __pfx_kthread+0x10/0x10
> kernel:  ret_from_fork_asm+0x1b/0x30
> kernel:  </TASK>
> kernel: INFO: task kworker/5:1:250 blocked for more than 122 seconds.
> kernel:       Not tainted 6.6.2-arch1-1 #1
> kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> this message.
> kernel: task:kworker/5:1     state:D stack:0     pid:250   ppid:2     
> flags:0x00004000
> kernel: Workqueue: events linkwatch_event
> kernel: Call Trace:
> kernel:  <TASK>
> kernel:  __schedule+0x3e8/0x1410
> kernel:  ? sched_clock+0x10/0x30
> kernel:  schedule+0x5e/0xd0
> kernel:  schedule_preempt_disabled+0x15/0x30
> kernel:  __mutex_lock.constprop.0+0x39a/0x6a0
> kernel:  linkwatch_event+0x12/0x40
> kernel:  process_one_work+0x171/0x340
> kernel:  worker_thread+0x27b/0x3a0
> kernel:  ? __pfx_worker_thread+0x10/0x10
> kernel:  kthread+0xe5/0x120
> kernel:  ? __pfx_kthread+0x10/0x10
> kernel:  ret_from_fork+0x31/0x50
> kernel:  ? __pfx_kthread+0x10/0x10
> kernel:  ret_from_fork_asm+0x1b/0x30
> kernel:  </TASK>
> kernel: INFO: task kworker/u64:6:290 blocked for more than 122 seconds.
> kernel:       Not tainted 6.6.2-arch1-1 #1
> kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> this message.
> kernel: task:kworker/u64:6   state:D stack:0     pid:290   ppid:2     
> flags:0x00004000
> kernel: Workqueue: netns cleanup_net
> kernel: Call Trace:
> kernel:  <TASK>
> kernel:  __schedule+0x3e8/0x1410
> kernel:  schedule+0x5e/0xd0
> kernel:  schedule_preempt_disabled+0x15/0x30
> kernel:  __mutex_lock.constprop.0+0x39a/0x6a0
> kernel:  wg_netns_pre_exit+0x19/0x100 [wireguard
> 0c090e6018e49e49957d27fd2202b1db304881dc]
> kernel:  cleanup_net+0x1e0/0x3b0
> kernel:  process_one_work+0x171/0x340
> kernel:  worker_thread+0x27b/0x3a0
> kernel:  ? __pfx_worker_thread+0x10/0x10
> kernel:  kthread+0xe5/0x120
> kernel:  ? __pfx_kthread+0x10/0x10
> kernel:  ret_from_fork+0x31/0x50
> kernel:  ? __pfx_kthread+0x10/0x10
> kernel:  ret_from_fork_asm+0x1b/0x30
> kernel:  </TASK>
> kernel: INFO: task kworker/u64:19:577 blocked for more than 122
> seconds.
> kernel:       Not tainted 6.6.2-arch1-1 #1
> kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> this message.
> kernel: task:kworker/u64:19  state:D stack:0     pid:577   ppid:2     
> flags:0x00004000
> kernel: Workqueue: events_power_efficient reg_check_chans_work
> [cfg80211]
> kernel: Call Trace:
> kernel:  <TASK>
> kernel:  __schedule+0x3e8/0x1410
> kernel:  ? _get_random_bytes+0xc0/0x1a0
> kernel:  schedule+0x5e/0xd0
> kernel:  schedule_preempt_disabled+0x15/0x30
> kernel:  __mutex_lock.constprop.0+0x39a/0x6a0
> kernel:  ? finish_task_switch.isra.0+0x94/0x2f0
> kernel:  reg_check_chans_work+0x31/0x5b0 [cfg80211
> d1ff02bd631e7b94dc4a8630ea4cdb5aede1cb9b]
> kernel:  process_one_work+0x171/0x340
> kernel:  worker_thread+0x27b/0x3a0
> kernel:  ? __pfx_worker_thread+0x10/0x10
> kernel:  kthread+0xe5/0x120
> kernel:  ? __pfx_kthread+0x10/0x10
> kernel:  ret_from_fork+0x31/0x50
> kernel:  ? __pfx_kthread+0x10/0x10
> kernel:  ret_from_fork_asm+0x1b/0x30
> kernel:  </TASK>
> kernel: INFO: task kworker/u64:23:581 blocked for more than 122
> seconds.
> kernel:       Not tainted 6.6.2-arch1-1 #1
> kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> this message.
> kernel: task:kworker/u64:23  state:D stack:0     pid:581   ppid:2     
> flags:0x00004000
> kernel: Workqueue: events_power_efficient phy_state_machine [libphy]
> kernel: Call Trace:
> kernel:  <TASK>
> kernel:  __schedule+0x3e8/0x1410
> kernel:  schedule+0x5e/0xd0
> kernel:  schedule_preempt_disabled+0x15/0x30
> kernel:  __mutex_lock.constprop.0+0x39a/0x6a0
> kernel:  phy_state_machine+0x47/0x2c0 [libphy
> 93248cd1d88abf54f1b4cc64a990177f549a7710]
> kernel:  process_one_work+0x171/0x340
> kernel:  worker_thread+0x27b/0x3a0
> kernel:  ? __pfx_worker_thread+0x10/0x10
> kernel:  kthread+0xe5/0x120
> kernel:  ? __pfx_kthread+0x10/0x10
> kernel:  ret_from_fork+0x31/0x50
> kernel:  ? __pfx_kthread+0x10/0x10
> kernel:  ret_from_fork_asm+0x1b/0x30
> kernel:  </TASK>
> kernel: INFO: task NetworkManager:849 blocked for more than 122
> seconds.
> kernel:       Not tainted 6.6.2-arch1-1 #1
> kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> this message.
> kernel: task:NetworkManager  state:D stack:0     pid:849   ppid:1     
> flags:0x00004002
> kernel: Call Trace:
> kernel:  <TASK>
> kernel:  __schedule+0x3e8/0x1410
> kernel:  ? sysvec_apic_timer_interrupt+0xe/0x90
> kernel:  schedule+0x5e/0xd0
> kernel:  schedule_preempt_disabled+0x15/0x30
> kernel:  __mutex_lock.constprop.0+0x39a/0x6a0
> kernel:  ? pci_conf1_write+0xae/0xf0
> kernel:  ? pcie_set_readrq+0x8e/0x160
> kernel:  phy_start_aneg+0x1d/0x40 [libphy
> 93248cd1d88abf54f1b4cc64a990177f549a7710]
> kernel:  rtl_reset_work+0x1bd/0x3b0 [r8169
> 08653ab60f23923c3943d53f140b2b697e265b93]
> kernel:  r8169_phylink_handler+0x5b/0x240 [r8169
> 08653ab60f23923c3943d53f140b2b697e265b93]
> kernel:  phy_link_change+0x2e/0x60 [libphy
> 93248cd1d88abf54f1b4cc64a990177f549a7710]
> kernel:  phy_check_link_status+0xad/0xe0 [libphy
> 93248cd1d88abf54f1b4cc64a990177f549a7710]
> kernel:  phy_start_aneg+0x25/0x40 [libphy
> 93248cd1d88abf54f1b4cc64a990177f549a7710]
> kernel:  rtl8169_change_mtu+0x24/0x60 [r8169
> 08653ab60f23923c3943d53f140b2b697e265b93]
> kernel:  dev_set_mtu_ext+0xf1/0x200
> kernel:  ? select_task_rq_fair+0x82c/0x1dd0
> kernel:  do_setlink+0x291/0x12d0
> kernel:  ? remove_entity_load_avg+0x31/0x80
> kernel:  ? sched_clock+0x10/0x30
> kernel:  ? sched_clock_cpu+0xf/0x190
> kernel:  ? __smp_call_single_queue+0xad/0x120
> kernel:  ? ttwu_queue_wakelist+0xef/0x110
> kernel:  ? __nla_validate_parse+0x61/0xd10
> kernel:  ? try_to_wake_up+0x2b7/0x640
> kernel:  __rtnl_newlink+0x651/0xa10
> kernel:  ? __kmem_cache_alloc_node+0x1a6/0x340
> kernel:  ? rtnl_newlink+0x2e/0x70
> kernel:  rtnl_newlink+0x47/0x70
> kernel:  rtnetlink_rcv_msg+0x14f/0x3c0
> kernel:  ? number+0x33b/0x3d0
> kernel:  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
> kernel:  netlink_rcv_skb+0x58/0x110
> kernel:  netlink_unicast+0x1a3/0x290
> kernel:  netlink_sendmsg+0x254/0x4d0
> kernel:  ____sys_sendmsg+0x396/0x3d0
> kernel:  ? copy_msghdr_from_user+0x7d/0xc0
> kernel:  ___sys_sendmsg+0x9a/0xe0
> kernel:  __sys_sendmsg+0x7a/0xd0
> kernel:  do_syscall_64+0x5d/0x90
> kernel:  ? do_syscall_64+0x6c/0x90
> kernel:  ? do_syscall_64+0x6c/0x90
> kernel:  ? do_syscall_64+0x6c/0x90
> kernel:  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> kernel: RIP: 0033:0x7fc9232e7b3d
> kernel: RSP: 002b:00007fffd4df2830 EFLAGS: 00000293 ORIG_RAX:
> 000000000000002e
> kernel: RAX: ffffffffffffffda RBX: 0000000000000055 RCX:
> 00007fc9232e7b3d
> kernel: RDX: 0000000000000000 RSI: 00007fffd4df2870 RDI:
> 000000000000000d
> kernel: RBP: 00007fffd4df2c40 R08: 0000000000000000 R09:
> 0000000000000000
> kernel: R10: 0000000000000000 R11: 0000000000000293 R12:
> 0000563fe71367c0
> kernel: R13: 0000000000000001 R14: 0000000000000000 R15:
> 0000000000000000
> kernel:  </TASK>
> kernel: INFO: task geoclue:1358 blocked for more than 122 seconds.
> kernel:       Not tainted 6.6.2-arch1-1 #1
> kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> this message.
> kernel: task:geoclue         state:D stack:0     pid:1358  ppid:1     
> flags:0x00000002
> kernel: Call Trace:
> kernel:  <TASK>
> kernel:  __schedule+0x3e8/0x1410
> kernel:  schedule+0x5e/0xd0
> kernel:  schedule_preempt_disabled+0x15/0x30
> kernel:  __mutex_lock.constprop.0+0x39a/0x6a0
> kernel:  __netlink_dump_start+0x75/0x290
> kernel:  ? __pfx_rtnl_dump_all+0x10/0x10
> kernel:  rtnetlink_rcv_msg+0x277/0x3c0
> kernel:  ? __pfx_rtnl_dump_all+0x10/0x10
> kernel:  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
> kernel:  netlink_rcv_skb+0x58/0x110
> kernel:  netlink_unicast+0x1a3/0x290
> kernel:  netlink_sendmsg+0x254/0x4d0
> kernel:  __sys_sendto+0x1f6/0x200
> kernel:  __x64_sys_sendto+0x24/0x30
> kernel:  do_syscall_64+0x5d/0x90
> kernel:  ? do_syscall_64+0x6c/0x90
> kernel:  ? do_syscall_64+0x6c/0x90
> kernel:  ? syscall_exit_to_user_mode+0x2b/0x40
> kernel:  ? do_syscall_64+0x6c/0x90
> kernel:  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> kernel: RIP: 0033:0x7f977ae729ec
> kernel: RSP: 002b:00007ffeeb6aba50 EFLAGS: 00000246 ORIG_RAX:
> 000000000000002c
> kernel: RAX: ffffffffffffffda RBX: 000056084849e910 RCX:
> 00007f977ae729ec
> kernel: RDX: 0000000000000014 RSI: 00007ffeeb6abad0 RDI:
> 0000000000000007
> kernel: RBP: 0000000000000000 R08: 0000000000000000 R09:
> 0000000000000000
> kernel: R10: 0000000000004000 R11: 0000000000000246 R12:
> 0000000000000014
> kernel: R13: 0000000000000000 R14: 0000000000000000 R15:
> 0000000000000000
> kernel:  </TASK>
> kernel: INFO: task pool-gnome-shel:1986 blocked for more than 122
> seconds.
> kernel:       Not tainted 6.6.2-arch1-1 #1
> kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> this message.
> kernel: task:pool-gnome-shel state:D stack:0     pid:1986  ppid:1513  
> flags:0x00000002
> kernel: Call Trace:
> kernel:  <TASK>
> kernel:  __schedule+0x3e8/0x1410
> kernel:  schedule+0x5e/0xd0
> kernel:  schedule_preempt_disabled+0x15/0x30
> kernel:  __mutex_lock.constprop.0+0x39a/0x6a0
> kernel:  __netlink_dump_start+0x75/0x290
> kernel:  ? __pfx_rtnl_dump_all+0x10/0x10
> kernel:  rtnetlink_rcv_msg+0x277/0x3c0
> kernel:  ? __pfx_rtnl_dump_all+0x10/0x10
> kernel:  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
> kernel:  netlink_rcv_skb+0x58/0x110
> kernel:  netlink_unicast+0x1a3/0x290
> kernel:  netlink_sendmsg+0x254/0x4d0
> kernel:  __sys_sendto+0x1f6/0x200
> kernel:  __x64_sys_sendto+0x24/0x30
> kernel:  do_syscall_64+0x5d/0x90
> kernel:  ? syscall_exit_to_user_mode+0x2b/0x40
> kernel:  ? do_syscall_64+0x6c/0x90
> kernel:  ? exc_page_fault+0x7f/0x180
> kernel:  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> kernel: RIP: 0033:0x7f232af30bfc
> kernel: RSP: 002b:00007f223e1fbba0 EFLAGS: 00000293 ORIG_RAX:
> 000000000000002c
> kernel: RAX: ffffffffffffffda RBX: 00007f223e1fccc0 RCX:
> 00007f232af30bfc
> kernel: RDX: 0000000000000014 RSI: 00007f223e1fccc0 RDI:
> 0000000000000028
> kernel: RBP: 0000000000000000 R08: 00007f223e1fcc64 R09:
> 000000000000000c
> kernel: R10: 0000000000000000 R11: 0000000000000293 R12:
> 0000000000000028
> kernel: R13: 00007f223e1fcc80 R14: 0000000000000665 R15:
> 000055638262fd10
> kernel:  </TASK>
> kernel: INFO: task evolution-sourc:1819 blocked for more than 122
> seconds.
> kernel:       Not tainted 6.6.2-arch1-1 #1
> kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> this message.
> kernel: task:evolution-sourc state:D stack:0     pid:1819  ppid:1513  
> flags:0x00000006
> kernel: Call Trace:
> kernel:  <TASK>
> kernel:  __schedule+0x3e8/0x1410
> kernel:  schedule+0x5e/0xd0
> kernel:  schedule_preempt_disabled+0x15/0x30
> kernel:  __mutex_lock.constprop.0+0x39a/0x6a0
> kernel:  ? netlink_lookup+0x151/0x1d0
> kernel:  __netlink_dump_start+0x75/0x290
> kernel:  ? __pfx_rtnl_dump_all+0x10/0x10
> kernel:  rtnetlink_rcv_msg+0x277/0x3c0
> kernel:  ? __pfx_rtnl_dump_all+0x10/0x10
> kernel:  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
> kernel:  netlink_rcv_skb+0x58/0x110
> kernel:  netlink_unicast+0x1a3/0x290
> kernel:  netlink_sendmsg+0x254/0x4d0
> kernel:  __sys_sendto+0x1f6/0x200
> kernel:  __x64_sys_sendto+0x24/0x30
> kernel:  do_syscall_64+0x5d/0x90
> kernel:  ? do_syscall_64+0x6c/0x90
> kernel:  ? sock_getsockopt+0x22/0x30
> kernel:  ? __fget_light+0x99/0x100
> kernel:  ? __sys_setsockopt+0x129/0x1d0
> kernel:  ? syscall_exit_to_user_mode+0x2b/0x40
> kernel:  ? do_syscall_64+0x6c/0x90
> kernel:  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> kernel: RIP: 0033:0x7f6aa096c9ec
> kernel: RSP: 002b:00007fff2b442820 EFLAGS: 00000246 ORIG_RAX:
> 000000000000002c
> kernel: RAX: ffffffffffffffda RBX: 0000561e6b466d80 RCX:
> 00007f6aa096c9ec
> kernel: RDX: 0000000000000014 RSI: 00007fff2b4428a0 RDI:
> 000000000000000a
> kernel: RBP: 0000000000000000 R08: 0000000000000000 R09:
> 0000000000000000
> kernel: R10: 0000000000004000 R11: 0000000000000246 R12:
> 0000000000000014
> kernel: R13: 00007fff2b442a70 R14: 0000000000000000 R15:
> 0000000000000001
> kernel:  </TASK>
> kernel: INFO: task gnome-software:1904 blocked for more than 122
> seconds.
> kernel:       Not tainted 6.6.2-arch1-1 #1
> kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> this message.
> kernel: task:gnome-software  state:D stack:0     pid:1904  ppid:1613  
> flags:0x00000002
> kernel: Call Trace:
> kernel:  <TASK>
> kernel:  __schedule+0x3e8/0x1410
> kernel:  ? __pte_offset_map_lock+0x9e/0x110
> kernel:  schedule+0x5e/0xd0
> kernel:  schedule_preempt_disabled+0x15/0x30
> kernel:  __mutex_lock.constprop.0+0x39a/0x6a0
> kernel:  ? netlink_lookup+0x151/0x1d0
> kernel:  __netlink_dump_start+0x75/0x290
> kernel:  ? __pfx_rtnl_dump_all+0x10/0x10
> kernel:  rtnetlink_rcv_msg+0x277/0x3c0
> kernel:  ? __pfx_rtnl_dump_all+0x10/0x10
> kernel:  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
> kernel:  netlink_rcv_skb+0x58/0x110
> kernel:  netlink_unicast+0x1a3/0x290
> kernel:  netlink_sendmsg+0x254/0x4d0
> kernel:  __sys_sendto+0x1f6/0x200
> kernel:  __x64_sys_sendto+0x24/0x30
> kernel:  do_syscall_64+0x5d/0x90
> kernel:  ? __fget_light+0x99/0x100
> kernel:  ? __sys_setsockopt+0x129/0x1d0
> kernel:  ? syscall_exit_to_user_mode+0x2b/0x40
> kernel:  ? do_syscall_64+0x6c/0x90
> kernel:  ? syscall_exit_to_user_mode+0x2b/0x40
> kernel:  ? do_syscall_64+0x6c/0x90
> kernel:  ? exc_page_fault+0x7f/0x180
> kernel:  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> kernel: RIP: 0033:0x7fdbfd26d9ec
> kernel: RSP: 002b:00007ffd15dd63e0 EFLAGS: 00000246 ORIG_RAX:
> 000000000000002c
> kernel: RAX: ffffffffffffffda RBX: 000056133c78f580 RCX:
> 00007fdbfd26d9ec
> kernel: RDX: 0000000000000014 RSI: 00007ffd15dd6460 RDI:
> 000000000000000b
> kernel: RBP: 0000000000000000 R08: 0000000000000000 R09:
> 0000000000000000
> kernel: R10: 0000000000004000 R11: 0000000000000246 R12:
> 0000000000000014
> kernel: R13: 00007ffd15dd6630 R14: 0000000000000000 R15:
> 0000000000000001
> kernel:  </TASK>
> kernel: Future hung task reports are suppressed, see sysctl
> kernel.hung_task_warnings
> 
> From the call traces, it seems that the issue is caused by commit
> 621735f590643e3048ca2060c285b80551660601 (r8169: fix rare issue with
> broken rx after link-down on RTL8125), which got backported to 6.6.2.
> 
> Ian

Could you please test whether the following fixes the issue for you?

---
 drivers/net/ethernet/realtek/r8169_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 0aed99a20..e32cc3279 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -575,6 +575,7 @@ struct rtl8169_tc_offsets {
 enum rtl_flag {
 	RTL_FLAG_TASK_ENABLED = 0,
 	RTL_FLAG_TASK_RESET_PENDING,
+	RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE,
 	RTL_FLAG_TASK_TX_TIMEOUT,
 	RTL_FLAG_MAX
 };
@@ -4494,6 +4495,8 @@ static void rtl_task(struct work_struct *work)
 reset:
 		rtl_reset_work(tp);
 		netif_wake_queue(tp->dev);
+	} else if (test_and_clear_bit(RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE, tp->wk.flags)) {
+		rtl_reset_work(tp);
 	}
 out_unlock:
 	rtnl_unlock();
@@ -4527,7 +4530,7 @@ static void r8169_phylink_handler(struct net_device *ndev)
 	} else {
 		/* In few cases rx is broken after link-down otherwise */
 		if (rtl_is_8125(tp))
-			rtl_reset_work(tp);
+			rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE);
 		pm_runtime_idle(d);
 	}
 
@@ -4603,7 +4606,7 @@ static int rtl8169_close(struct net_device *dev)
 	rtl8169_down(tp);
 	rtl8169_rx_clear(tp);
 
-	cancel_work_sync(&tp->wk.work);
+	cancel_work(&tp->wk.work);
 
 	free_irq(tp->irq, tp);
 
-- 
2.43.0



