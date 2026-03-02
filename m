Return-Path: <netdev+bounces-262552-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEcnG2dGpWkg7AUAu9opvQ
	(envelope-from <netdev+bounces-262552-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 09:12:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7B71D479C
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 09:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7349830066B0
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 08:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50357379EE0;
	Mon,  2 Mar 2026 08:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="X+7PA92T"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D994334C1D
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 08:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772439139; cv=none; b=tMmnnq/QtiSxepjc+aCCGRSt3kbaueTGIsFvYtzhhOomodP9qFUq4cKp6JUmKQucSkdHanT4iJ0CMss//b1TLHqhign7uL9RI9d9mCMHdx0prGfWxiW3vMOflNWh/E9/vz/OoPk5GJDzfKy+Evs/ujWQMwRR6ue5e8xMEGC2ZtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772439139; c=relaxed/simple;
	bh=X77En7xbeHjFDrS+w4CWnvDLXPc8ARQ1VrLC49Cx6C8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5wdqasgkRVc71POMwzYWvb4nHN2yKKmtVsn8G29QUyabQNHsNy8H9giKgp8hJ/MVP2Ps09esvJqabh6UJvyvoUZqtP8LME7LzTSCRixNyKqxw57GDRDLCCYr3lEWsLTThi3VjlvewPGZAFYwwditDNaR3F+jfNvcgW7+gInt+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=X+7PA92T; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 76689207AC;
	Mon,  2 Mar 2026 09:12:08 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kDiy8e5Fro0m; Mon,  2 Mar 2026 09:12:07 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 53B092053D;
	Mon,  2 Mar 2026 09:12:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 53B092053D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1772439127;
	bh=e49YRe/j876GJh/yjOn6GVk655K45hW0/aQ+jFAZzXg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=X+7PA92TgClY5bLyQVfcRkE0ckNQwcnWjAOJZ7qZVXDRDF+DDNcji4EkAahfq3ToR
	 dCwLvPrLqNQVugos/jYlAcj1qFiQGryQgcb6lBHZhqmLcUs6ORohMsdl9sdWMHCe89
	 omTKvhEloc+St1TrgMT0ljfqfYATNdObKpoOFXojpLyA8NCpfmvf3nURGHyjerHjE9
	 muMKjdnrvPAOvO05GVfnPOnWG0mVCtJfIpdPhXMVae63FTzLF+robRPRFbW0TlsGIc
	 TmgtlivdligoKcX6le7j0j5tlkQUhaSOBectar97zsbSWljyhRWbJuIaC1tFSNOYZu
	 GitCOa232xkwQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Mar
 2026 09:12:06 +0100
Received: (nullmailer pid 2830039 invoked by uid 1000);
	Mon, 02 Mar 2026 08:12:05 -0000
Date: Mon, 2 Mar 2026 09:12:05 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Hao Long <me@imlonghao.com>, Christian Hopps <chopps@labn.net>
CC: netdev <netdev@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [BUG] Kernel Panic in iptfs_reassem_cont when handling large
 packets
Message-ID: <aaVGVTelUZ9gFhkT@secunet.com>
References: <DGRCO9SL0T5U.JTINSHJQ9KPK@imlonghao.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DGRCO9SL0T5U.JTINSHJQ9KPK@imlonghao.com>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,secunet.com:mid,secunet.com:dkim];
	TAGGED_FROM(0.00)[bounces-262552-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[secunet.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0C7B71D479C
X-Rspamd-Action: no action

Add Chris, the author of IPTFS, to the Cc.

On Sun, Mar 01, 2026 at 05:49:19PM +0800, Hao Long wrote:
> Hello,
> 
> Recently I set up a strongSwan tunnel in AGGFRAG mode[1] in order to see
> how it fragments large packets.
> 
> Later I found out the receiver node will kernel panic when handling
> large packets, I tested in different distro and both panic.
> 
> Tested environment:
> - Arch Linux 6.18.13-arch1-1 strongswan-6.0.4-2
> - Arch Linux 7.0.0-rc1-1-mainline strongswan-6.0.4-2
> - NixOS 6.18.13 strongswan-6.0.4
> 
> Step to reproduce:
> 1. install strongSwan and create tunnel interface in vm1, see the
> attachment init_env.sh
> 2. do step1 in vm2, but remember to switch local_addrs and remote_addrs,
> also the ip assignment
> 3. run `ping -s 3333 10.0.1.2` in vm1, 10.0.1.2 is the ip from vm2
> 4. kernel panic in vm2
> 
> I'm not familiar in C programming and kernel developing, so sorry I can't
> provide a useful root case analyze and a fix.
> 
> Regards,
> Hao Long
> 
> [1] https://docs.strongswan.org/docs/latest/features/iptfs.html

> [  412.126912] ------------[ cut here ]------------
> [  412.126945] kernel BUG at net/core/skbuff.c:2651!
> [  412.126974] Oops: invalid opcode: 0000 [#1] SMP PTI
> [  412.127009] CPU: 2 UID: 0 PID: 0 Comm: swapper/2 Not tainted 7.0.0-rc1-1-mainline #1 PREEMPT(full)  b84afef9bed61122840347d0d1295877239d5881
> [  412.127061] Hardware name: Vultr VC2, BIOS  
> [  412.127076] RIP: 0010:skb_put+0x3c/0x40
> [  412.127122] Code: bc 00 00 00 01 77 70 48 89 c2 48 03 87 c8 00 00 00 01 f2 89 97 bc 00 00 00 39 97 c0 00 00 00 0f 82 c0 c2 14 ff e9 c4 a0 2f 00 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f
> [  412.127154] RSP: 0018:ffffcdee80120788 EFLAGS: 00010202
> [  412.127167] RAX: 000000000000056e RBX: ffff8ac7cef2c400 RCX: 0000000000000030
> [  412.127184] RDX: ffff8ac7cef94000 RSI: 0000000000000030 RDI: ffff8ac7c266a700
> [  412.127197] RBP: ffffcdee801207b0 R08: 0000000000000004 R09: 0000000000000030
> [  412.127210] R10: 0000000000000030 R11: 0000000000000030 R12: ffff8ac7c7160a00
> [  412.127222] R13: ffff8ac7c266a700 R14: ffffcdee80120978 R15: ffffcdee80120950
> [  412.127241] FS:  0000000000000000(0000) GS:ffff8ac995998000(0000) knlGS:0000000000000000
> [  412.127256] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  412.127271] CR2: 000055b8aa3f3b80 CR3: 0000000104500001 CR4: 00000000001706f0
> [  412.127288] Call Trace:
> [  412.127298]  <IRQ>
> [  412.127308]  iptfs_reassem_cont+0x12d/0x5f0 [xfrm_iptfs 7ea53a8d87342a9b7c66159e6b7baa8136dff23a]
> [  412.127335]  iptfs_input_ordered+0x260/0x310 [xfrm_iptfs 7ea53a8d87342a9b7c66159e6b7baa8136dff23a]
> [  412.127356]  iptfs_input+0x128/0x3d0 [xfrm_iptfs 7ea53a8d87342a9b7c66159e6b7baa8136dff23a]
> [  412.127373]  ? esp_input+0x1f7/0x330 [esp4 f354ef309189db0d9825bb990cd4d8b0a86a0bf3]
> [  412.127399]  xfrm_input+0x8d3/0x16a0
> [  412.127449]  xfrm4_esp_rcv+0x38/0x80
> [  412.127473]  ip_protocol_deliver_rcu+0x169/0x170
> [  412.127497]  ip_local_deliver_finish+0x85/0x100
> [  412.127509]  __netif_receive_skb_core.constprop.0+0xa14/0xe30
> [  412.127529]  ? kmalloc_reserve+0x86/0x100
> [  412.127540]  ? __alloc_skb+0xf4/0x2e0
> [  412.127551]  ? napi_alloc_skb+0x35/0x270
> [  412.127568]  ? page_to_skb+0x2a9/0x400 [virtio_net 07b3b182c5b7f88384b07163f6c3d83152f6c13c]
> [  412.127610]  __netif_receive_skb_list_core+0x13d/0x2d0
> [  412.127628]  netif_receive_skb_list_internal+0x1d5/0x310
> [  412.127645]  napi_complete_done+0x7f/0x1b0
> [  412.127660]  ? virtnet_rq_get_buf+0x2d/0x60 [virtio_net 07b3b182c5b7f88384b07163f6c3d83152f6c13c]
> [  412.127684]  virtnet_poll+0x6de/0xdbd [virtio_net 07b3b182c5b7f88384b07163f6c3d83152f6c13c]
> [  412.127710]  __napi_poll+0x30/0x200
> [  412.127723]  ? skb_defer_free_flush+0x9c/0xc0
> [  412.127745]  net_rx_action+0x2fd/0x390
> [  412.127761]  handle_softirqs+0xe4/0x2c0
> [  412.127802]  __irq_exit_rcu+0xcb/0xf0
> [  412.127817]  common_interrupt+0x85/0xa0
> [  412.127848]  </IRQ>
> [  412.127858]  <TASK>
> [  412.127867]  asm_common_interrupt+0x26/0x40
> [  412.127904] RIP: 0010:pv_native_safe_halt+0xf/0x20
> [  412.127926] Code: 20 d0 e9 c4 3c 01 00 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d c3 e9 1f 00 fb f4 <c3> cc cc cc cc 90 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
> [  412.128324] RSP: 0018:ffffcdee800dbeb8 EFLAGS: 00000286
> [  412.128644] RAX: 0000000000000002 RBX: ffff8ac7c085b600 RCX: 4000000000000000
> [  412.128930] RDX: 00000000000b70bc RSI: ffff8ac7c085b600 RDI: 00000000000b70bc
> [  412.129210] RBP: 0000000000000002 R08: ffffcdee800dbe30 R09: ffff8ac937d21820
> [  412.129486] R10: 0000005ff80573c0 R11: 0000000000000002 R12: 0000000000000000
> [  412.129743] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [  412.130001]  default_idle+0x9/0x20
> [  412.130263]  default_idle_call+0x2f/0x130
> [  412.130546]  do_idle+0x1c7/0x210
> [  412.130891]  cpu_startup_entry+0x29/0x30
> [  412.131263]  start_secondary+0x119/0x150
> [  412.131600]  common_startup_64+0x13e/0x141
> [  412.131859]  </TASK>
> [  412.132137] Modules linked in: xfrm_iptfs seqiv geniv esp4 xfrm_interface xfrm6_tunnel tunnel4 tunnel6 xfrm_user xfrm_algo snd_hda_codec_generic snd_hda_intel snd_hda_codec intel_rapl_msr intel_rapl_common snd_hda_core ghash_clmulni_intel snd_intel_dspcfg aesni_intel snd_intel_sdw_acpi rapl snd_hwdep i2c_i801 snd_pcm psmouse i2c_smbus i2c_mux pcspkr iTCO_wdt snd_timer intel_pmc_bxt snd soundcore vfat fat qemu_fw_cfg i6300esb joydev mousedev mac_hid cfg80211 rfkill dm_mod nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock vmw_vmci sr_mod cdrom lpc_ich virtio_balloon virtio_net net_failover failover bochs intel_agp intel_gtt serio_raw virtio_rng
> [  412.133499] ---[ end trace 0000000000000000 ]---
> [  412.133807] RIP: 0010:skb_put+0x3c/0x40
> [  412.134092] Code: bc 00 00 00 01 77 70 48 89 c2 48 03 87 c8 00 00 00 01 f2 89 97 bc 00 00 00 39 97 c0 00 00 00 0f 82 c0 c2 14 ff e9 c4 a0 2f 00 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f
> [  412.134654] RSP: 0018:ffffcdee80120788 EFLAGS: 00010202
> [  412.134935] RAX: 000000000000056e RBX: ffff8ac7cef2c400 RCX: 0000000000000030
> [  412.135282] RDX: ffff8ac7cef94000 RSI: 0000000000000030 RDI: ffff8ac7c266a700
> [  412.135583] RBP: ffffcdee801207b0 R08: 0000000000000004 R09: 0000000000000030
> [  412.135951] R10: 0000000000000030 R11: 0000000000000030 R12: ffff8ac7c7160a00
> [  412.136389] R13: ffff8ac7c266a700 R14: ffffcdee80120978 R15: ffffcdee80120950
> [  412.136721] FS:  0000000000000000(0000) GS:ffff8ac995998000(0000) knlGS:0000000000000000
> [  412.137015] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  412.137480] CR2: 000055b8aa3f3b80 CR3: 0000000104500001 CR4: 00000000001706f0
> [  412.137825] Kernel panic - not syncing: Fatal exception in interrupt
> [  412.138095] Kernel Offset: 0x1de00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)



