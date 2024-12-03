Return-Path: <netdev+bounces-148456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D08339E1B7C
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 12:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CA77284AC1
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 11:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E701E47DE;
	Tue,  3 Dec 2024 11:58:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A651E47B9;
	Tue,  3 Dec 2024 11:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733227117; cv=none; b=iIcDsFiXhe6c9j8nW8gED5gqdV0Pj8PNWZYny/4GJymZaaObi0A+fztRVaT5+vzrisDcsUl79Vx/EjFNuIZZR5R+K1JSxATNMP2EhnVi1YikfuYdOZqeacHIZYNeusL6Y+t0XGvxGrDKe9mJRQCboAjfBIgtg05As4inLD0BdOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733227117; c=relaxed/simple;
	bh=NxadRO4CQiaxFHU4Zd7b6Fgv3d+2ZSuAs0MZeq3D46w=;
	h=Message-ID:Date:MIME-Version:Cc:From:Subject:To:Content-Type; b=KstOhWQugqiTaPFbm+kr43TGljWORVXN0l2aredX10Pe/VMGrxSIMXvIj+5v0gr1vbLkuCiurnFGZvopF8U3a7048pIfgEILiBRoak6DvEKkEs3WmiTnNhntjafXkG6q30I+njMAZotMk8GSh5/qaoawHf959xXx/H/1sktVV6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-53de556ecdaso5440524e87.1;
        Tue, 03 Dec 2024 03:58:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733227114; x=1733831914;
        h=content-transfer-encoding:to:autocrypt:subject:from:cc
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dqJ3VGS5Rl4D1twRN5/XD4VyCy4iH8xE2xlRYz7Ry/Y=;
        b=f14k/t8A/Wt/cLMK4I/H6Qn9N+6YkPj4JmkLXqN8jO7NLCmHQW3hNQOLgOWo/lFXA7
         fwWvaDKGavwBFDYxDHWkZd0EFoAVP42ATStxPAT+n7rrkG8EVeHF2bpPhdXIneYlFhlV
         GadrZuXszodhCy/IMSzhA0pPkN4cK+DJO63prZz6F73QXRAwqWeWWLRjBmygAM3Th+W9
         z0coZHEFZGZUYzqhcZgs/P99p8KnsEYtJM4GKBlJtLp7wtNnZunCIdPxRfZczcHlg0sI
         71SZXTTKmVMCSnVmvhnRFf+uPqE3leZc8j0frvL8SpcmtSD3NZq3PDxiVGsRd5Bib/71
         uF2w==
X-Forwarded-Encrypted: i=1; AJvYcCW+l//4v5uuGSXB5oYJKQFgVw3Q+iJwsonvsGi4FhiInuwhBGUH6G+Q778givJnIzxESdP7RcUZ+jrR+/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzewZav3/5Vdbl1ESm8+RMa4a6sVMvKa6cZR1CsD/Fd/GBMS9NE
	RZgy5BbcP6UmHAkGv/cKlGJry6LaoqeOWJp5m3MNDbvDPeJ66PLxJYJT3PoC
X-Gm-Gg: ASbGncsMGGtW82a4vKPrSD3nxigz40qfjGuN8w/N9eLOtPzMexz++YeggUZ0v2ZLPKI
	Eys57cJ2ubbhR708don40wIj2I+3eT1M75o8A6+aE3uVMaXVXpk8OkqBzmWfQBHPac387PR+1h7
	nrYRDohEXexxx9oqON4WwoaJK9qRpMRib3A914sarDYrM7gzcAP2QZWNatfG0uTenmvRb7HOr8c
	XhwdxJW0ByuFpdmFBaOPw3e+kNkxkcnUzQLVbf1InSgEX9fc4hlS9sBoFICerhbSz4R6Yw0mO5o
	B9pFOA==
X-Google-Smtp-Source: AGHT+IH3LycIvD/GVqp9aiGs3v69KSHpVSFW2hW4YH5er4jTYPa7AOqBWFos1vbifT1hgYyw/6TjYQ==
X-Received: by 2002:ac2:4e09:0:b0:53d:ed15:5ab6 with SMTP id 2adb3069b0e04-53e129ef4f5mr1349903e87.11.1733227113530;
        Tue, 03 Dec 2024 03:58:33 -0800 (PST)
Received: from [192.168.0.13] (ip-86-49-44-151.bb.vodafone.cz. [86.49.44.151])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996de7f2sm603894666b.53.2024.12.03.03.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 03:58:33 -0800 (PST)
Message-ID: <d1a7dea8-ce20-4c6f-beed-8a28b07e9468@ovn.org>
Date: Tue, 3 Dec 2024 12:58:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
Cc: i.maximets@ovn.org, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, LKML <linux-kernel@vger.kernel.org>
From: Ilya Maximets <i.maximets@ovn.org>
Subject: [v6.12] BUG: KASAN: slab-use-after-free in dst_destroy+0x2e2/0x340
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello there.  I was running some tests with openvswitch+ipsec on v6.12 tag
and got the KASAN UAF splat provided below.  It doesn't seem to be related
to anything specific to openvswitch module, more like core parts of networking.
At lest, at the first glance.

For the context, what I'm running is an OVS system test that creates 20 network
namespaces, starts OVS and Libreswan in each of them, creates a full mesh of
Geneve tunnels with IPsec (a separate tunnel between each pair of namespaces),
then checks that pings work through all the tunnels and then deletes all the
ports, OVS datapath and namespaces.  While removing namespaces, I see the
following KASAN report in the logs:

Dec 03 05:46:17 kernel: genev_sys_6081 (unregistering): left promiscuous mode
Dec 03 05:46:17 kernel: br-ipsec: left promiscuous mode
Dec 03 05:46:17 kernel: ovs-system: left promiscuous mode
Dec 03 05:46:18 kernel: ==================================================================
Dec 03 05:46:18 kernel: BUG: KASAN: slab-use-after-free in dst_destroy+0x2e2/0x340
Dec 03 05:46:18 kernel: Read of size 8 at addr ffff8882137ccab0 by task swapper/37/0
Dec 03 05:46:18 kernel: 
Dec 03 05:46:18 kernel: CPU: 37 UID: 0 PID: 0 Comm: swapper/37 Kdump: loaded Not tainted 6.12.0 #67
Dec 03 05:46:18 kernel: Hardware name: Red Hat KVM/RHEL, BIOS 1.16.1-1.el9 04/01/2014
Dec 03 05:46:18 kernel: Call Trace:
Dec 03 05:46:18 kernel:  <IRQ>
Dec 03 05:46:18 kernel:  dump_stack_lvl+0x64/0xa0
Dec 03 05:46:18 kernel:  print_address_description.constprop.0+0x2c/0x3d0
Dec 03 05:46:18 kernel:  ? dst_destroy+0x2e2/0x340
Dec 03 05:46:18 kernel:  print_report+0xb4/0x270
Dec 03 05:46:18 kernel:  ? dst_destroy+0x2e2/0x340
Dec 03 05:46:18 kernel:  ? kasan_addr_to_slab+0x9/0xa0
Dec 03 05:46:18 kernel:  kasan_report+0x89/0xc0
Dec 03 05:46:18 kernel:  ? dst_destroy+0x2e2/0x340
Dec 03 05:46:18 kernel:  ? rcu_do_batch+0x377/0xeb0
Dec 03 05:46:18 kernel:  dst_destroy+0x2e2/0x340
Dec 03 05:46:18 kernel:  rcu_do_batch+0x379/0xeb0
Dec 03 05:46:18 kernel:  ? __pfx_rcu_do_batch+0x10/0x10
Dec 03 05:46:18 kernel:  ? lockdep_hardirqs_on_prepare+0x127/0x3e0
Dec 03 05:46:18 kernel:  rcu_core+0x354/0x510
Dec 03 05:46:18 kernel:  handle_softirqs+0x1fe/0x580
Dec 03 05:46:18 kernel:  __irq_exit_rcu+0x13a/0x190
Dec 03 05:46:18 kernel:  irq_exit_rcu+0xa/0x20
Dec 03 05:46:18 kernel:  sysvec_apic_timer_interrupt+0x72/0x90
Dec 03 05:46:18 kernel:  </IRQ>
Dec 03 05:46:18 kernel:  <TASK>
Dec 03 05:46:18 kernel:  asm_sysvec_apic_timer_interrupt+0x16/0x20
Dec 03 05:46:18 kernel: RIP: 0010:default_idle+0xb/0x20
Dec 03 05:46:18 kernel: Code: 00 4d 29 c8 4c 01 c7 4c 29 c2 e9 6e ff ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 90 0f 00 2d c7 c9 27 00 fb f4 <fa> c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 90
Dec 03 05:46:18 kernel: RSP: 0018:ffff888100d2fe00 EFLAGS: 00000246
Dec 03 05:46:18 kernel: RAX: 00000000001870ed RBX: 1ffff110201a5fc2 RCX: ffffffffb61a3e46
Dec 03 05:46:18 kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffb3d4d123
Dec 03 05:46:18 kernel: RBP: 0000000000000000 R08: 0000000000000001 R09: ffffed11c7e1835d
Dec 03 05:46:18 kernel: R10: ffff888e3f0c1aeb R11: 0000000000000000 R12: 0000000000000000
Dec 03 05:46:18 kernel: R13: ffff888100d20000 R14: dffffc0000000000 R15: 0000000000000000
Dec 03 05:46:18 kernel:  ? ct_kernel_exit.constprop.0+0xb6/0xf0
Dec 03 05:46:18 kernel:  ? cpuidle_idle_call+0x1e3/0x270
Dec 03 05:46:18 kernel:  default_idle_call+0x67/0xa0
Dec 03 05:46:18 kernel:  cpuidle_idle_call+0x1e3/0x270
Dec 03 05:46:18 kernel:  ? __pfx_cpuidle_idle_call+0x10/0x10
Dec 03 05:46:18 kernel:  ? lock_release+0xd3/0x130
Dec 03 05:46:18 kernel:  ? lockdep_hardirqs_on_prepare+0x275/0x3e0
Dec 03 05:46:18 kernel:  ? tsc_verify_tsc_adjust+0x56/0x290
Dec 03 05:46:18 kernel:  do_idle+0xf1/0x1a0
Dec 03 05:46:18 kernel:  cpu_startup_entry+0x50/0x60
Dec 03 05:46:18 kernel:  start_secondary+0x210/0x290
Dec 03 05:46:18 kernel:  ? __pfx_start_secondary+0x10/0x10
Dec 03 05:46:18 kernel:  ? soft_restart_cpu+0x14/0x14
Dec 03 05:46:18 kernel:  common_startup_64+0x13e/0x141
Dec 03 05:46:18 kernel:  </TASK>
Dec 03 05:46:18 kernel: 
Dec 03 05:46:18 kernel: Allocated by task 12184:
Dec 03 05:46:18 kernel:  kasan_save_stack+0x20/0x40
Dec 03 05:46:18 kernel:  kasan_save_track+0x10/0x30
Dec 03 05:46:18 kernel:  __kasan_slab_alloc+0x83/0x90
Dec 03 05:46:18 kernel:  kmem_cache_alloc_noprof+0x123/0x3a0
Dec 03 05:46:18 kernel:  copy_net_ns+0xc2/0x530
Dec 03 05:46:18 kernel:  create_new_namespaces+0x35f/0x920
Dec 03 05:46:18 kernel:  unshare_nsproxy_namespaces+0x86/0x1b0
Dec 03 05:46:18 kernel:  ksys_unshare+0x2c0/0x6e0
Dec 03 05:46:18 kernel:  __x64_sys_unshare+0x2d/0x40
Dec 03 05:46:18 kernel:  do_syscall_64+0x8a/0x170
Dec 03 05:46:18 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Dec 03 05:46:18 kernel: 
Dec 03 05:46:18 kernel: Freed by task 11:
Dec 03 05:46:18 kernel:  kasan_save_stack+0x20/0x40
Dec 03 05:46:18 kernel:  kasan_save_track+0x10/0x30
Dec 03 05:46:18 kernel:  kasan_save_free_info+0x37/0x60
Dec 03 05:46:18 kernel:  __kasan_slab_free+0x50/0x70
Dec 03 05:46:18 kernel:  kmem_cache_free+0x1b8/0x560
Dec 03 05:46:18 kernel:  cleanup_net+0x767/0xa20
Dec 03 05:46:18 kernel:  process_one_work+0xe11/0x1640
Dec 03 05:46:18 kernel:  worker_thread+0x54d/0xc90
Dec 03 05:46:18 kernel:  kthread+0x2a8/0x380
Dec 03 05:46:18 kernel:  ret_from_fork+0x2d/0x70
Dec 03 05:46:18 kernel:  ret_from_fork_asm+0x1a/0x30
Dec 03 05:46:18 kernel: 
Dec 03 05:46:18 kernel: Last potentially related work creation:
Dec 03 05:46:18 kernel:  kasan_save_stack+0x20/0x40
Dec 03 05:46:18 kernel:  __kasan_record_aux_stack+0xad/0xc0
Dec 03 05:46:18 kernel:  insert_work+0x29/0x1b0
Dec 03 05:46:18 kernel:  __queue_work+0x5be/0x9c0
Dec 03 05:46:18 kernel:  queue_work_on+0x78/0x80
Dec 03 05:46:18 kernel:  xfrm_policy_insert+0x52f/0x6c0
Dec 03 05:46:18 kernel:  xfrm_add_policy+0x2a1/0x700
Dec 03 05:46:18 kernel:  xfrm_user_rcv_msg+0x4e5/0x830
Dec 03 05:46:18 kernel:  netlink_rcv_skb+0x12b/0x390
Dec 03 05:46:18 kernel:  xfrm_netlink_rcv+0x70/0x90
Dec 03 05:46:18 kernel:  netlink_unicast+0x447/0x710
Dec 03 05:46:18 kernel:  netlink_sendmsg+0x761/0xc40
Dec 03 05:46:18 kernel:  sock_write_iter+0x448/0x530
Dec 03 05:46:18 kernel:  vfs_write+0xa21/0xf30
Dec 03 05:46:18 kernel:  ksys_write+0x176/0x1d0
Dec 03 05:46:18 kernel:  do_syscall_64+0x8a/0x170
Dec 03 05:46:18 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Dec 03 05:46:18 kernel: 
Dec 03 05:46:18 kernel: Second to last potentially related work creation:
Dec 03 05:46:18 kernel:  kasan_save_stack+0x20/0x40
Dec 03 05:46:18 kernel:  __kasan_record_aux_stack+0xad/0xc0
Dec 03 05:46:18 kernel:  insert_work+0x29/0x1b0
Dec 03 05:46:18 kernel:  __queue_work+0x5be/0x9c0
Dec 03 05:46:18 kernel:  queue_work_on+0x78/0x80
Dec 03 05:46:18 kernel:  __xfrm_state_insert+0x179a/0x24b0
Dec 03 05:46:18 kernel:  xfrm_state_update+0x9ca/0xc60
Dec 03 05:46:18 kernel:  xfrm_add_sa+0x1b6/0x3e0
Dec 03 05:46:18 kernel:  xfrm_user_rcv_msg+0x4e5/0x830
Dec 03 05:46:18 kernel:  netlink_rcv_skb+0x12b/0x390
Dec 03 05:46:18 kernel:  xfrm_netlink_rcv+0x70/0x90
Dec 03 05:46:18 kernel:  netlink_unicast+0x447/0x710
Dec 03 05:46:18 kernel:  netlink_sendmsg+0x761/0xc40
Dec 03 05:46:18 kernel:  sock_write_iter+0x448/0x530
Dec 03 05:46:18 kernel:  vfs_write+0xa21/0xf30
Dec 03 05:46:18 kernel:  ksys_write+0x176/0x1d0
Dec 03 05:46:18 kernel:  do_syscall_64+0x8a/0x170
Dec 03 05:46:18 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Dec 03 05:46:18 kernel: 
Dec 03 05:46:18 kernel: The buggy address belongs to the object at ffff8882137cb680
                               which belongs to the cache net_namespace of size 6720
Dec 03 05:46:18 kernel: The buggy address is located 5168 bytes inside of
                               freed 6720-byte region [ffff8882137cb680, ffff8882137cd0c0)
Dec 03 05:46:18 kernel: 
Dec 03 05:46:18 kernel: The buggy address belongs to the physical page:
Dec 03 05:46:18 kernel: page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2137c8
Dec 03 05:46:18 kernel: head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
Dec 03 05:46:18 kernel: memcg:ffff88812794d901
Dec 03 05:46:18 kernel: flags: 0x17ffffc0000040(head|node=0|zone=2|lastcpupid=0x1fffff)
Dec 03 05:46:18 kernel: page_type: f5(slab)
Dec 03 05:46:18 kernel: raw: 0017ffffc0000040 ffff888100053980 dead000000000122 0000000000000000
Dec 03 05:46:18 kernel: raw: 0000000000000000 0000000080040004 00000001f5000000 ffff88812794d901
Dec 03 05:46:18 kernel: head: 0017ffffc0000040 ffff888100053980 dead000000000122 0000000000000000
Dec 03 05:46:18 kernel: head: 0000000000000000 0000000080040004 00000001f5000000 ffff88812794d901
Dec 03 05:46:18 kernel: head: 0017ffffc0000003 ffffea00084df201 ffffffffffffffff 0000000000000000
Dec 03 05:46:18 kernel: head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
Dec 03 05:46:18 kernel: page dumped because: kasan: bad access detected
Dec 03 05:46:18 kernel: 
Dec 03 05:46:18 kernel: Memory state around the buggy address:
Dec 03 05:46:18 kernel:  ffff8882137cc980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
Dec 03 05:46:18 kernel:  ffff8882137cca00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
Dec 03 05:46:18 kernel: >ffff8882137cca80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
Dec 03 05:46:18 kernel:                                      ^
Dec 03 05:46:18 kernel:  ffff8882137ccb00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
Dec 03 05:46:18 kernel:  ffff8882137ccb80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
Dec 03 05:46:18 kernel: ==================================================================

This one seems to be reproducible fairly consistently.

Best regards, Ilya Maximets.

