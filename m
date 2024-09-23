Return-Path: <netdev+bounces-129279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2753897EA2C
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 12:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A83381F215B6
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 10:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E667B195FF0;
	Mon, 23 Sep 2024 10:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2OecYiW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEFA1FDA;
	Mon, 23 Sep 2024 10:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727088624; cv=none; b=I6iS4YTYF7tJ+BYl3JDbDiO9XTuheoFTdyTxMsdWr8ADXUi9RcNa7x9x5RmGDhOtLFnw0tw47TOiKVYwAbaFXLFSgocDH+y/VytC4HJOOTizqRlhyUOyAPovIHCXroNhO+RiCyn2Aq5D3glutK6p2onMybfuUqhuPLBueZi5rQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727088624; c=relaxed/simple;
	bh=mxd3Hk3PA6MXg2n/G4AmttuaPp1QBBaez55EKfZPLq0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BOgyZUPtcXGWA1dHvewDmwkyBT7KNjqd514KxZCPOe8cOrVJAvbQCNy3FGE9pEOlet6RMmTY21HcK+kK5oojJ48ziWkX5N9pNn8rCk/LIdLOqems3xuwNuKHeLk9fA3ohoGqtmRHSgmd6hDgI5rRRWjbJ88sCSE7f/6UphF2ZWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2OecYiW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363E9C4CEC4;
	Mon, 23 Sep 2024 10:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727088624;
	bh=mxd3Hk3PA6MXg2n/G4AmttuaPp1QBBaez55EKfZPLq0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K2OecYiWEfBtRbO1tTJkY5dUQhc42hEO4dXB1gx71K69JNk4IK3wFZyDhOZhlAvYO
	 U2yd25EvqgMjXGJXcTE2Nd5ZfmbO3DwpsZJFNUwr0jBZEQxVlmZqAoGhFNmtECzyfN
	 CFHN/GCOdyctUYNGk8PZWKBifqUgsTeoAiYaCh2rh5AfaOFZM4rBcWhbsBDUXl6dgG
	 KlIiVzB130iaV0kfoh2s7fbtVcPccUTZF1uC2Z1I/D57uxGWpdLK0uZ8r3xjtExK3V
	 sqiK442B9d9ZgXDcXgkXbtHo/Iesufq2H0IuStPkAZxe2vBND+5IV088c3+cGaUTAN
	 A6S8Fth0EXoWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B01FE3809A80;
	Mon, 23 Sep 2024 10:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] tcp: check skb is non-NULL in tcp_rto_delta_us()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172708862651.3320223.2618494280244639290.git-patchwork-notify@kernel.org>
Date: Mon, 23 Sep 2024 10:50:26 +0000
References: <20240910190822.2407606-1-johunt@akamai.com>
In-Reply-To: <20240910190822.2407606-1-johunt@akamai.com>
To: Josh Hunt <johunt@akamai.com>
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, ncardwell@google.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 10 Sep 2024 15:08:22 -0400 you wrote:
> We have some machines running stock Ubuntu 20.04.6 which is their 5.4.0-174-generic
> kernel that are running ceph and recently hit a null ptr dereference in
> tcp_rearm_rto(). Initially hitting it from the TLP path, but then later we also
> saw it getting hit from the RACK case as well. Here are examples of the oops
> messages we saw in each of those cases:
> 
> Jul 26 15:05:02 rx [11061395.780353] BUG: kernel NULL pointer dereference, address: 0000000000000020
> Jul 26 15:05:02 rx [11061395.787572] #PF: supervisor read access in kernel mode
> Jul 26 15:05:02 rx [11061395.792971] #PF: error_code(0x0000) - not-present page
> Jul 26 15:05:02 rx [11061395.798362] PGD 0 P4D 0
> Jul 26 15:05:02 rx [11061395.801164] Oops: 0000 [#1] SMP NOPTI
> Jul 26 15:05:02 rx [11061395.805091] CPU: 0 PID: 9180 Comm: msgr-worker-1 Tainted: G W 5.4.0-174-generic #193-Ubuntu
> Jul 26 15:05:02 rx [11061395.814996] Hardware name: Supermicro SMC 2x26 os-gen8 64C NVME-Y 256G/H12SSW-NTR, BIOS 2.5.V1.2U.NVMe.UEFI 05/09/2023
> Jul 26 15:05:02 rx [11061395.825952] RIP: 0010:tcp_rearm_rto+0xe4/0x160
> Jul 26 15:05:02 rx [11061395.830656] Code: 87 ca 04 00 00 00 5b 41 5c 41 5d 5d c3 c3 49 8b bc 24 40 06 00 00 eb 8d 48 bb cf f7 53 e3 a5 9b c4 20 4c 89 ef e8 0c fe 0e 00 <48> 8b 78 20 48 c1 ef 03 48 89 f8 41 8b bc 24 80 04 00 00 48 f7 e3
> Jul 26 15:05:02 rx [11061395.849665] RSP: 0018:ffffb75d40003e08 EFLAGS: 00010246
> Jul 26 15:05:02 rx [11061395.855149] RAX: 0000000000000000 RBX: 20c49ba5e353f7cf RCX: 0000000000000000
> Jul 26 15:05:02 rx [11061395.862542] RDX: 0000000062177c30 RSI: 000000000000231c RDI: ffff9874ad283a60
> Jul 26 15:05:02 rx [11061395.869933] RBP: ffffb75d40003e20 R08: 0000000000000000 R09: ffff987605e20aa8
> Jul 26 15:05:02 rx [11061395.877318] R10: ffffb75d40003f00 R11: ffffb75d4460f740 R12: ffff9874ad283900
> Jul 26 15:05:02 rx [11061395.884710] R13: ffff9874ad283a60 R14: ffff9874ad283980 R15: ffff9874ad283d30
> Jul 26 15:05:02 rx [11061395.892095] FS: 00007f1ef4a2e700(0000) GS:ffff987605e00000(0000) knlGS:0000000000000000
> Jul 26 15:05:02 rx [11061395.900438] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Jul 26 15:05:02 rx [11061395.906435] CR2: 0000000000000020 CR3: 0000003e450ba003 CR4: 0000000000760ef0
> Jul 26 15:05:02 rx [11061395.913822] PKRU: 55555554
> Jul 26 15:05:02 rx [11061395.916786] Call Trace:
> Jul 26 15:05:02 rx [11061395.919488]
> Jul 26 15:05:02 rx [11061395.921765] ? show_regs.cold+0x1a/0x1f
> Jul 26 15:05:02 rx [11061395.925859] ? __die+0x90/0xd9
> Jul 26 15:05:02 rx [11061395.929169] ? no_context+0x196/0x380
> Jul 26 15:05:02 rx [11061395.933088] ? ip6_protocol_deliver_rcu+0x4e0/0x4e0
> Jul 26 15:05:02 rx [11061395.938216] ? ip6_sublist_rcv_finish+0x3d/0x50
> Jul 26 15:05:02 rx [11061395.943000] ? __bad_area_nosemaphore+0x50/0x1a0
> Jul 26 15:05:02 rx [11061395.947873] ? bad_area_nosemaphore+0x16/0x20
> Jul 26 15:05:02 rx [11061395.952486] ? do_user_addr_fault+0x267/0x450
> Jul 26 15:05:02 rx [11061395.957104] ? ipv6_list_rcv+0x112/0x140
> Jul 26 15:05:02 rx [11061395.961279] ? __do_page_fault+0x58/0x90
> Jul 26 15:05:02 rx [11061395.965458] ? do_page_fault+0x2c/0xe0
> Jul 26 15:05:02 rx [11061395.969465] ? page_fault+0x34/0x40
> Jul 26 15:05:02 rx [11061395.973217] ? tcp_rearm_rto+0xe4/0x160
> Jul 26 15:05:02 rx [11061395.977313] ? tcp_rearm_rto+0xe4/0x160
> Jul 26 15:05:02 rx [11061395.981408] tcp_send_loss_probe+0x10b/0x220
> Jul 26 15:05:02 rx [11061395.985937] tcp_write_timer_handler+0x1b4/0x240
> Jul 26 15:05:02 rx [11061395.990809] tcp_write_timer+0x9e/0xe0
> Jul 26 15:05:02 rx [11061395.994814] ? tcp_write_timer_handler+0x240/0x240
> Jul 26 15:05:02 rx [11061395.999866] call_timer_fn+0x32/0x130
> Jul 26 15:05:02 rx [11061396.003782] __run_timers.part.0+0x180/0x280
> Jul 26 15:05:02 rx [11061396.008309] ? recalibrate_cpu_khz+0x10/0x10
> Jul 26 15:05:02 rx [11061396.012841] ? native_x2apic_icr_write+0x30/0x30
> Jul 26 15:05:02 rx [11061396.017718] ? lapic_next_event+0x21/0x30
> Jul 26 15:05:02 rx [11061396.021984] ? clockevents_program_event+0x8f/0xe0
> Jul 26 15:05:02 rx [11061396.027035] run_timer_softirq+0x2a/0x50
> Jul 26 15:05:02 rx [11061396.031212] __do_softirq+0xd1/0x2c1
> Jul 26 15:05:02 rx [11061396.035044] do_softirq_own_stack+0x2a/0x40
> Jul 26 15:05:02 rx [11061396.039480]
> Jul 26 15:05:02 rx [11061396.041840] do_softirq.part.0+0x46/0x50
> Jul 26 15:05:02 rx [11061396.046022] __local_bh_enable_ip+0x50/0x60
> Jul 26 15:05:02 rx [11061396.050460] _raw_spin_unlock_bh+0x1e/0x20
> Jul 26 15:05:02 rx [11061396.054817] nf_conntrack_tcp_packet+0x29e/0xbe0 [nf_conntrack]
> Jul 26 15:05:02 rx [11061396.060994] ? get_l4proto+0xe7/0x190 [nf_conntrack]
> Jul 26 15:05:02 rx [11061396.066220] nf_conntrack_in+0xe9/0x670 [nf_conntrack]
> Jul 26 15:05:02 rx [11061396.071618] ipv6_conntrack_local+0x14/0x20 [nf_conntrack]
> Jul 26 15:05:02 rx [11061396.077356] nf_hook_slow+0x45/0xb0
> Jul 26 15:05:02 rx [11061396.081098] ip6_xmit+0x3f0/0x5d0
> Jul 26 15:05:02 rx [11061396.084670] ? ipv6_anycast_cleanup+0x50/0x50
> Jul 26 15:05:02 rx [11061396.089282] ? __sk_dst_check+0x38/0x70
> Jul 26 15:05:02 rx [11061396.093381] ? inet6_csk_route_socket+0x13b/0x200
> Jul 26 15:05:02 rx [11061396.098346] inet6_csk_xmit+0xa7/0xf0
> Jul 26 15:05:02 rx [11061396.102263] __tcp_transmit_skb+0x550/0xb30
> Jul 26 15:05:02 rx [11061396.106701] tcp_write_xmit+0x3c6/0xc20
> Jul 26 15:05:02 rx [11061396.110792] ? __alloc_skb+0x98/0x1d0
> Jul 26 15:05:02 rx [11061396.114708] __tcp_push_pending_frames+0x37/0x100
> Jul 26 15:05:02 rx [11061396.119667] tcp_push+0xfd/0x100
> Jul 26 15:05:02 rx [11061396.123150] tcp_sendmsg_locked+0xc70/0xdd0
> Jul 26 15:05:02 rx [11061396.127588] tcp_sendmsg+0x2d/0x50
> Jul 26 15:05:02 rx [11061396.131245] inet6_sendmsg+0x43/0x70
> Jul 26 15:05:02 rx [11061396.135075] __sock_sendmsg+0x48/0x70
> Jul 26 15:05:02 rx [11061396.138994] ____sys_sendmsg+0x212/0x280
> Jul 26 15:05:02 rx [11061396.143172] ___sys_sendmsg+0x88/0xd0
> Jul 26 15:05:02 rx [11061396.147098] ? __seccomp_filter+0x7e/0x6b0
> Jul 26 15:05:02 rx [11061396.151446] ? __switch_to+0x39c/0x460
> Jul 26 15:05:02 rx [11061396.155453] ? __switch_to_asm+0x42/0x80
> Jul 26 15:05:02 rx [11061396.159636] ? __switch_to_asm+0x5a/0x80
> Jul 26 15:05:02 rx [11061396.163816] __sys_sendmsg+0x5c/0xa0
> Jul 26 15:05:02 rx [11061396.167647] __x64_sys_sendmsg+0x1f/0x30
> Jul 26 15:05:02 rx [11061396.171832] do_syscall_64+0x57/0x190
> Jul 26 15:05:02 rx [11061396.175748] entry_SYSCALL_64_after_hwframe+0x5c/0xc1
> Jul 26 15:05:02 rx [11061396.181055] RIP: 0033:0x7f1ef692618d
> Jul 26 15:05:02 rx [11061396.184893] Code: 28 89 54 24 1c 48 89 74 24 10 89 7c 24 08 e8 ca ee ff ff 8b 54 24 1c 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 2f 44 89 c7 48 89 44 24 08 e8 fe ee ff ff 48
> Jul 26 15:05:02 rx [11061396.203889] RSP: 002b:00007f1ef4a26aa0 EFLAGS: 00000293 ORIG_RAX: 000000000000002e
> Jul 26 15:05:02 rx [11061396.211708] RAX: ffffffffffffffda RBX: 000000000000084b RCX: 00007f1ef692618d
> Jul 26 15:05:02 rx [11061396.219091] RDX: 0000000000004000 RSI: 00007f1ef4a26b10 RDI: 0000000000000275
> Jul 26 15:05:02 rx [11061396.226475] RBP: 0000000000004000 R08: 0000000000000000 R09: 0000000000000020
> Jul 26 15:05:02 rx [11061396.233859] R10: 0000000000000000 R11: 0000000000000293 R12: 000000000000084b
> Jul 26 15:05:02 rx [11061396.241243] R13: 00007f1ef4a26b10 R14: 0000000000000275 R15: 000055592030f1e8
> Jul 26 15:05:02 rx [11061396.248628] Modules linked in: vrf bridge stp llc vxlan ip6_udp_tunnel udp_tunnel nls_iso8859_1 amd64_edac_mod edac_mce_amd kvm_amd kvm crct10dif_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd glue_helper wmi_bmof ipmi_ssif input_leds joydev rndis_host cdc_ether usbnet mii ast drm_vram_helper ttm drm_kms_helper i2c_algo_bit fb_sys_fops syscopyarea sysfillrect sysimgblt ccp mac_hid ipmi_si ipmi_devintf ipmi_msghandler nft_ct sch_fq_codel nf_tables_set nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink ramoops reed_solomon efi_pstore drm ip_tables x_tables autofs4 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid0 multipath linear mlx5_ib ib_uverbs ib_core raid1 mlx5_core hid_generic pci_hyperv_intf crc32_pclmul tls usbhid ahci mlxfw bnxt_en libahci hid nvme i2c_piix4 nvme_core wmi
> Jul 26 15:05:02 rx [11061396.324334] CR2: 0000000000000020
> Jul 26 15:05:02 rx [11061396.327944] ---[ end trace 68a2b679d1cfb4f1 ]---
> Jul 26 15:05:02 rx [11061396.433435] RIP: 0010:tcp_rearm_rto+0xe4/0x160
> Jul 26 15:05:02 rx [11061396.438137] Code: 87 ca 04 00 00 00 5b 41 5c 41 5d 5d c3 c3 49 8b bc 24 40 06 00 00 eb 8d 48 bb cf f7 53 e3 a5 9b c4 20 4c 89 ef e8 0c fe 0e 00 <48> 8b 78 20 48 c1 ef 03 48 89 f8 41 8b bc 24 80 04 00 00 48 f7 e3
> Jul 26 15:05:02 rx [11061396.457144] RSP: 0018:ffffb75d40003e08 EFLAGS: 00010246
> Jul 26 15:05:02 rx [11061396.462629] RAX: 0000000000000000 RBX: 20c49ba5e353f7cf RCX: 0000000000000000
> Jul 26 15:05:02 rx [11061396.470012] RDX: 0000000062177c30 RSI: 000000000000231c RDI: ffff9874ad283a60
> Jul 26 15:05:02 rx [11061396.477396] RBP: ffffb75d40003e20 R08: 0000000000000000 R09: ffff987605e20aa8
> Jul 26 15:05:02 rx [11061396.484779] R10: ffffb75d40003f00 R11: ffffb75d4460f740 R12: ffff9874ad283900
> Jul 26 15:05:02 rx [11061396.492164] R13: ffff9874ad283a60 R14: ffff9874ad283980 R15: ffff9874ad283d30
> Jul 26 15:05:02 rx [11061396.499547] FS: 00007f1ef4a2e700(0000) GS:ffff987605e00000(0000) knlGS:0000000000000000
> Jul 26 15:05:02 rx [11061396.507886] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Jul 26 15:05:02 rx [11061396.513884] CR2: 0000000000000020 CR3: 0000003e450ba003 CR4: 0000000000760ef0
> Jul 26 15:05:02 rx [11061396.521267] PKRU: 55555554
> Jul 26 15:05:02 rx [11061396.524230] Kernel panic - not syncing: Fatal exception in interrupt
> Jul 26 15:05:02 rx [11061396.530885] Kernel Offset: 0x1b200000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> Jul 26 15:05:03 rx [11061396.660181] ---[ end Kernel panic - not syncing: Fatal
>  exception in interrupt ]---
> 
> [...]

Here is the summary with links:
  - [net,v3] tcp: check skb is non-NULL in tcp_rto_delta_us()
    https://git.kernel.org/netdev/net/c/c8770db2d544

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



