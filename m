Return-Path: <netdev+bounces-51031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C7E7F8BE2
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 15:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C9B62813F7
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 14:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC4C28DB4;
	Sat, 25 Nov 2023 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5asX7gA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280F392
	for <netdev@vger.kernel.org>; Sat, 25 Nov 2023 06:58:20 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a002562bd8bso541532666b.0
        for <netdev@vger.kernel.org>; Sat, 25 Nov 2023 06:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700924298; x=1701529098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BAGonsaJ67B4qpICLBBrqsGPmVqy602WsPQd0Zq3Dmk=;
        b=A5asX7gA4HI4G4bqjbi5cpoNGBmi2jIDIuCZTcFTfBHesNbWmKEvJyXcEipcvNUdtr
         OZa7k5v4LUhtaFZhSr3WETVc3qShiSdbuUaUtimL9XYx92fsgPMv0xdVHgkDNpqFfiLO
         Lxdu4rpZYcwfHZa7PMsumj8amRtN7rovBISqxdwiP9lWupdk66VS+dc6OUAu5kVADAdg
         ES+iUt1RfHqRin8GIOkmZpzJfUpvcr8dpD24X+i99vlqHgv3Uwz8TzUNqK8vz43ORYxg
         n/UWNUwRC6rVzPEywMgBVRfLD2ljhwApBhwrnDdxpIa0wJF6yLnA5AvoWgYpJYSfCprF
         eY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700924298; x=1701529098;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BAGonsaJ67B4qpICLBBrqsGPmVqy602WsPQd0Zq3Dmk=;
        b=X5IyNXnCbdPyCVSLiOSz6mANAMq7yze8y37MPIup8YX6FIRVvm7DljwxjcQExQ4bEM
         YFXZkde+DObIyfFNrGhoAZD8WD6bUK2duRIhnM68D4Nj1F3Vd9OTgP03g3Ty0GTpsl/t
         SFZf2K7rKjAZr1oZ0Zc+p03AI2dZimtcAN8lAkJ6sV21JIxJYj40JNrFnNBJ0RLL6iE5
         +Yckuz6qTOC+RViWVEOTtxfhC3sWgsR6wo8Lx9ktqm3p6gaw1Wurcxu/FPQCi1oZiqfV
         VqJB1YKIun7Kpx06PQWAWQMwVqaF1GurkOllumYIbxpxR3ptUe20L3C0zBTHz725XBFb
         1JDQ==
X-Gm-Message-State: AOJu0YwGpMLqUoNfMTe+y63Ai6EVUW198lz/3PaXY+grrZbGgibqDXXO
	Cdr3n085kviyXsPlwsP8G+Y=
X-Google-Smtp-Source: AGHT+IELcHpSd5D+VaVUWCV6vG3YF/9CIpWSxaJ5uy6hTp+gysP477FQGToZ1+SPZeEqmFwgKyg9sA==
X-Received: by 2002:a17:907:da3:b0:9fa:d1df:c2c4 with SMTP id go35-20020a1709070da300b009fad1dfc2c4mr9561308ejc.36.1700924298231;
        Sat, 25 Nov 2023 06:58:18 -0800 (PST)
Received: from ?IPV6:2a01:c22:6e7b:8300:8429:9ce:215b:f3ee? (dynamic-2a01-0c22-6e7b-8300-8429-09ce-215b-f3ee.c22.pool.telefonica.de. [2a01:c22:6e7b:8300:8429:9ce:215b:f3ee])
        by smtp.googlemail.com with ESMTPSA id hg5-20020a170906f34500b00a0a2cb33ee0sm1733179ejb.203.2023.11.25.06.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Nov 2023 06:58:17 -0800 (PST)
Message-ID: <e6641e7e-e786-416a-843c-c2b3c18cdd9f@gmail.com>
Date: Sat, 25 Nov 2023 15:58:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] r8169: deadlock when NetworkManager brings link up
To: Ian Chen <free122448@hotmail.com>, netdev@vger.kernel.org
References: <LV2P220MB08459B430FFD8830782201B4D2BFA@LV2P220MB0845.NAMP220.PROD.OUTLOOK.COM>
Content-Language: en-US
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
Thanks for the report. Issue seems to be caused by a recursive call
to phy_start_aneg(), and it seems to be specific to using a jumbo mtu.

Are you using a jumbo mtu? And could you please check whether issue
is gone with the standard mtu?

> Ian

Heiner

