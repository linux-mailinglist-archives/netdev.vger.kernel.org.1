Return-Path: <netdev+bounces-130874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A6C98BD0E
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 15:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADA06282509
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 13:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F17F1E529;
	Tue,  1 Oct 2024 13:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="NiBbRQsX"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0773E4A06
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 13:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727788010; cv=none; b=l8G1gvNag5MYRe1PTPtoONIsSEqSbaiGh0Zf2oL8OEwcazl1trheNjFpqMbyjvB4mFoEf2pA/Ox/x5K6Zt8KtfmQBO7v/8Vqq61SkFy7hnwlXPQqOO84MjQGZcaq2Ivpq6gXdAbjjzwniVsGr9H976CNVOtFGyzB1xbCIW7A1QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727788010; c=relaxed/simple;
	bh=07OOiqbFA9bgzD/GWgardGPbOg7r+AzJS3cEEkG3mgM=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=KH1sz9dsIs2BusRZJB1h+A3ncDlFP86KBZG+vZkK8Na3JAQLV1V5iT4ewBWR+mVHGSG1Q6JQ8Lmh3I3YOAhSa0bQ/stvaTyz7O8OJt3nw6tR/EvkPLpEB4mcpZMvxKekwP1lGE3tlkLtdbb6Oo3uCkxtjHvfLk7YUKf9UUxuPt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=NiBbRQsX; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 911D0280072
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 13:06:45 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.40.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 0D42213C2B0
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 06:06:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0D42213C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1727788005;
	bh=07OOiqbFA9bgzD/GWgardGPbOg7r+AzJS3cEEkG3mgM=;
	h=Date:To:From:Subject:From;
	b=NiBbRQsX3/mpwWiIM8/n6XkBlHQpfMtGokrAyQQUOl5cEiARwWDzkYGTFxRqf8u28
	 N/3kuDzbmqJjgrA/7LA2vQLYFQDCQxZyXoyZbROFpeBCRcUZrDiabAo4xH3ZLrPoBL
	 VhZZhQqJ9b/+hMS+JtZsCQivqHmY3ioGiDZ5Bmt0=
Message-ID: <bdaaef9d-4364-4171-b82b-bcfc12e207eb@candelatech.com>
Date: Tue, 1 Oct 2024 06:06:44 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-MW
To: netdev <netdev@vger.kernel.org>
From: Ben Greear <greearb@candelatech.com>
Subject: nf-nat-core: allocated memory at module unload.
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1727788006-Zcic7C1qReRI
X-MDID-O:
 us5;ut7;1727788006;Zcic7C1qReRI;<greearb@candelatech.com>;0590461a9946a11a9d6965a08c2b2857

Hello,

I see this splat in 6.11.0 (plus a single patch to fix vrf xmit deadlock).

Is this a known issue?  Is it a serious problem?

------------[ cut here ]------------
net/netfilter/nf_nat_core.c:1114 module nf_nat func:nf_nat_register_fn has 256 allocated at module unload
WARNING: CPU: 1 PID: 10421 at lib/alloc_tag.c:168 alloc_tag_module_unload+0x22b/0x3f0
Modules linked in: nf_nat(-) btrfs ufs qnx4 hfsplus hfs minix vfat msdos fat jfs nls_ucs2_utils xfs nf_conntrack_netlink nf_conntrack nfnetlink nf_defrag_ipv6 
nf_defrag_ipv4 vrf 8021q garp mrp stp llc macvlan pktgen rpcrdma rdma_cm iw_cm ib_cm ib_core qrtr iwlmvm snd_hda_codec_hdmi snd_hda_codec_realtek 
snd_hda_codec_generic iTCO_wdt ee1004 snd_hda_scodec_component intel_pmc_bxt intel_rapl_msr iTCO_vendor_support snd_hda_intel snd_intel_dspcfg coretemp 
intel_rapl_common snd_hda_codec intel_uncore_frequency snd_hda_core intel_uncore_frequency_common mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm iwlwifi 
intel_tcc_cooling x86_pkg_temp_thermal snd_timer intel_powerclamp intel_wmi_thunderbolt i2c_i801 snd i2c_smbus pcspkr soundcore i2c_mux bfq cfg80211 mei_hdcp 
mei_pxp intel_pch_thermal intel_pmc_core intel_vsec pmt_telemetry pmt_class acpi_pad sch_fq_codel nfsd auth_rpcgss nfs_acl lockd grace sunrpc zram raid1 dm_raid 
raid456 libcrc32c async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq
  i915 cec rc_core drm_buddy intel_gtt drm_display_helper ixgbe drm_kms_helper igb mdio ttm dca i2c_algo_bit agpgart hwmon drm mei_wdt xhci_pci i2c_core 
xhci_pci_renesas video wmi fuse [last unloaded: nf_nat]
CPU: 1 UID: 0 PID: 10421 Comm: rmmod Tainted: G        W          6.11.0+ #2
Tainted: [W]=WARN
Hardware name: Default string Default string/SKYBAY, BIOS 5.12 08/04/2020
RIP: 0010:alloc_tag_module_unload+0x22b/0x3f0
Code: 00 00 00 00 00 fc ff df 49 89 fa 49 c1 ea 03 41 80 3c 02 00 0f 85 28 01 00 00 48 8b 76 18 48 c7 c7 a0 da 48 84 e8 15 7d c1 fe <0f> 0b 45 31 ed e9 6b fe ff 
ff 41 bd 01 00 00 00 48 b8 00 00 00 00
RSP: 0018:ffff88813b91fc50 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88812b30b600 RCX: 0000000000000027
RDX: 0000000000000027 RSI: 0000000000000004 RDI: ffff88841daab988
RBP: 1ffff11027723f8f R08: 0000000000000001 R09: ffffed1083b55731
R10: ffff88841daab98b R11: 0000000000000001 R12: fffffbfff099df23
R13: 0000000000000001 R14: 00000000000000ff R15: dffffc0000000000
FS:  00007f4efd62f740(0000) GS:ffff88841da80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000561ab516c000 CR3: 0000000120f94003 CR4: 00000000003706f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <TASK>
  ? __warn+0xc8/0x2d0
  ? alloc_tag_module_unload+0x22b/0x3f0
  ? report_bug+0x259/0x2c0
  ? handle_bug+0x54/0xa0
  ? exc_invalid_op+0x13/0x40
  ? asm_exc_invalid_op+0x16/0x20
  ? alloc_tag_module_unload+0x22b/0x3f0
  ? idr_get_next_ul+0x189/0x230
  ? allocinfo_show+0x6d0/0x6d0
  ? rwsem_down_read_slowpath+0xb10/0xb10
  codetag_unload_module+0x19b/0x2a0
  ? codetag_load_module+0x80/0x80
  ? up_write+0x4f0/0x4f0
  ? notifier_call_chain+0x95/0x2d0
  free_module+0x51/0x3e0
  __do_sys_delete_module.constprop.0+0x39c/0x530
  ? module_flags+0x300/0x300
  ? kmem_cache_alloc_bulk_noprof+0x680/0x6a0
  ? __virt_addr_valid+0x1cb/0x390
  ? lockdep_hardirqs_on_prepare+0x275/0x3e0
  do_syscall_64+0x69/0x160
  entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x7f4efcf128cb
Code: 73 01 c3 48 8b 0d 55 55 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 
48 8b 0d 25 55 0e 00 f7 d8 64 89 01 48
RSP: 002b:00007ffee03b3338 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
RAX: ffffffffffffffda RBX: 000055b749cea7b0 RCX: 00007f4efcf128cb
RDX: 0000000000000000 RSI: 0000000000000800 RDI: 000055b749cea818
RBP: 0000000000000000 R08: 1999999999999999 R09: 0000000000000000
R10: 00007f4efcf9dac0 R11: 0000000000000206 R12: 00007ffee03b3590
R13: 00007ffee03b4963 R14: 000055b749cea2a0 R15: 00007ffee03b3598
  </TASK>
irq event stamp: 7895
hardirqs last  enabled at (7907): [<ffffffff8143a209>] __up_console_sem+0x59/0x60
hardirqs last disabled at (7918): [<ffffffff8143a1ee>] __up_console_sem+0x3e/0x60
softirqs last  enabled at (7800): [<ffffffff8129bd51>] __irq_exit_rcu+0x91/0xc0
softirqs last disabled at (7795): [<ffffffff8129bd51>] __irq_exit_rcu+0x91/0xc0
---[ end trace 0000000000000000 ]---

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

