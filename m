Return-Path: <netdev+bounces-51790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7F97FC0AD
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 18:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52F811C20A88
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 17:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6FE39AF9;
	Tue, 28 Nov 2023 17:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BIK3H3gl"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86DE1B5
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 09:54:39 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASFjLsi019454;
	Tue, 28 Nov 2023 09:54:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pfpt0220;
 bh=+zG/Z4VFJWpA3WRnB5MJgTqHXyEhI6kQ7vWZ6o8scKQ=;
 b=BIK3H3gl6A+i23iON6d2TYdmLwAEICWRkZ0gUPjHR92FBv/w4PAsYlRHhnMPxZeI+icv
 KzgCfU83fPJx/2UiiClRaYGgumT8jG8oUwO5u1uRDmeSXlb3BQgw6QvOnQ10xsy/Nh8S
 sMq55/1SJmUpnxDVTsbvDgF0jZhMLVgDfm9ETklDC0wKfsZndahqxBa0UTGm6BOadIZ5
 hK/hDa5vhFgq1RmDFaX3F84BrPhOStfhXfxo5gS4OJ0UHw++lxw7jNB0xQnL6okZCVzj
 SA3w4VgtJq1CbaEWgC4X2QVmR3w1DRJhTwzCbuJu3/pqA/KEcPvDm2G0yY1m4Cb728E4 xg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3una4djcgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 09:54:33 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 28 Nov
 2023 09:54:31 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 28 Nov 2023 09:54:31 -0800
Received: from [10.193.38.189] (unknown [10.193.38.189])
	by maili.marvell.com (Postfix) with ESMTP id 5BC763F7057;
	Tue, 28 Nov 2023 09:54:29 -0800 (PST)
Message-ID: <f1673f31-b1b4-2c50-92ff-c6b5e247586f@marvell.com>
Date: Tue, 28 Nov 2023 18:54:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Aquantia ethernet driver suspend/resume issues
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Netdev <netdev@vger.kernel.org>
References: <CAHk-=wiZZi7FcvqVSUirHBjx0bBUZ4dFrMDVLc3+3HCrtq0rBA@mail.gmail.com>
 <cf6e78b6-e4e2-faab-f8c6-19dc462b1d74@marvell.com>
 <CAHk-=whLsdX=Kr010LiM2smEu2rC3Hedwmuxtcp0pYtZvFj+=A@mail.gmail.com>
From: Igor Russkikh <irusskikh@marvell.com>
In-Reply-To: <CAHk-=whLsdX=Kr010LiM2smEu2rC3Hedwmuxtcp0pYtZvFj+=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: sk24g-f_4XqorBJnFKgUsZTYSKyH0A2B
X-Proofpoint-ORIG-GUID: sk24g-f_4XqorBJnFKgUsZTYSKyH0A2B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_19,2023-11-27_01,2023-05-22_02


On 11/27/2023 7:02 PM, Linus Torvalds wrote:

> 
> So I suspect that one reason I triggered the problem was simply
> because the suspend/resume happened while I walked away from the
> computer when it was copying a few hundred gig of data from the old
> SSD (over USB, so not hugely fast).

...

> Also, make sure you don't have ridiculous amounts of memory in your
> machine.  I've got "only" 64GB in mine, which is small for a big
> machine, and presumably a lot of it was used for buffer cache, and I'm
> not sure what the device suspend/resume ordering was (ie disk might be
> resumed after ethernet).

With these details in mind I was able to repro this within seconds on my 16Gb machine,
basically by doing a stress in parallel:

    stress -m 2000 --vm-bytes 20M --vm-hang 10 --backoff 1000

    while true; do sudo ifconfig enp1s0 down; sudo ifconfig enp1s0 up; done

in 5-10 seconds I get

[  859.536856] atlantic 0000:01:00.0 enp1s0: aq_ring_alloc[6](0x30000)
[  859.563153] warn_alloc: 1 callbacks suppressed
[  859.563156] ifconfig: page allocation failure: order:5, mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), nodemask=(null),cpuset=/,mems_allowed=0
[  859.563163] CPU: 13 PID: 48544 Comm: ifconfig Tainted: G           OE      6.7.0-rc2igor1+ #1
[  859.563165] Hardware name: ASUS System Product Name/PRIME Z590-P, BIOS 1017 07/12/2021
[  859.563166] Call Trace:
[  859.563168]  <TASK>
[  859.563170]  dump_stack_lvl+0x48/0x70
[  859.563175]  dump_stack+0x10/0x20
[  859.563177]  warn_alloc+0x119/0x190
[  859.563180]  ? __alloc_pages_direct_compact+0xae/0x1f0
[  859.563183]  __alloc_pages_slowpath.constprop.0+0xd1a/0xdd0
[  859.563188]  __alloc_pages+0x304/0x350
[  859.563192]  ? aq_ring_alloc+0x29/0xe0 [atlantic]
[  859.563207]  __kmalloc_large_node+0x7f/0x140
[  859.563210]  __kmalloc+0xc9/0x140
[  859.563212]  aq_ring_alloc+0x29/0xe0 [atlantic]
[  859.563221]  aq_ring_rx_alloc+0x7d/0x90 [atlantic]
[  859.563230]  aq_vec_ring_alloc+0xab/0x170 [atlantic]
[  859.563241]  aq_nic_init+0x11c/0x1e0 [atlantic]
[  859.563250]  aq_ndev_open+0x20/0x90 [atlantic]
[  859.563259]  __dev_open+0xe9/0x190
[  859.563261]  __dev_change_flags+0x18c/0x1f0
[  859.563263]  dev_change_flags+0x26/0x70
[  859.563265]  devinet_ioctl+0x602/0x760
[  859.563268]  inet_ioctl+0x167/0x190
[  859.563269]  ? sk_ioctl+0x4b/0x110
[  859.563271]  ? inet_ioctl+0x95/0x190
[  859.563273]  sock_do_ioctl+0x44/0xf0
[  859.563274]  ? __check_object_size+0x51/0x2d0
[  859.563277]  ? _copy_to_user+0x25/0x40
[  859.563279]  sock_ioctl+0xf7/0x300
[  859.563280]  __x64_sys_ioctl+0x95/0xd0
[  859.563283]  do_syscall_64+0x5c/0xe0
[  859.563286]  ? exit_to_user_mode_prepare+0x45/0x1a0
[  859.563289]  ? syscall_exit_to_user_mode+0x34/0x50
[  859.563291]  ? do_syscall_64+0x6b/0xe0
[  859.563293]  ? do_syscall_64+0x6b/0xe0
[  859.563295]  ? syscall_exit_to_user_mode+0x34/0x50
[  859.563296]  ? __x64_sys_openat+0x20/0x30
[  859.563298]  ? do_syscall_64+0x6b/0xe0
[  859.563300]  ? syscall_exit_to_user_mode+0x34/0x50
[  859.563301]  ? __x64_sys_read+0x1a/0x20
[  859.563303]  ? do_syscall_64+0x6b/0xe0
[  859.563305]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[  859.563307] RIP: 0033:0x7f98499df3ab
[  859.563309] Code: 0f 1e fa 48 8b 05 e5 7a 0d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b5 7a 0d 00 f7 d8 64 89 01 48
[  859.563310] RSP: 002b:00007fffba955138 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
[  859.563312] RAX: ffffffffffffffda RBX: 00007fffba955140 RCX: 00007f98499df3ab
[  859.563313] RDX: 00007fffba955140 RSI: 0000000000008914 RDI: 0000000000000004
[  859.563314] RBP: 00007fffba9551f0 R08: 0000000000000008 R09: 0000000000000001
[  859.563315] R10: 0000000000000011 R11: 0000000000000202 R12: 0000000000000041
[  859.563316] R13: 00007fffba9554e8 R14: 0000000000000000 R15: 0000000000000000
[  859.563318]  </TASK>
[  859.563319] Mem-Info:
[  859.563320] active_anon:14091 inactive_anon:3805083 isolated_anon:2336
                active_file:4601 inactive_file:5452 isolated_file:3
                unevictable:2258 dirty:56 writeback:0
                slab_reclaimable:35879 slab_unreclaimable:42730
                mapped:8485 shmem:2635 pagetables:35066
                sec_pagetables:0 bounce:0
                kernel_misc_reclaimable:0
                free:56673 free_pcp:0 free_cma:0
[  859.563323] Node 0 active_anon:56364kB inactive_anon:15220332kB active_file:18404kB inactive_file:21808kB unevictable:9032kB isolated(anon):9344kB isolated(file):12kB mapped:33940kB dirty:224kB writeback:0kB shmem:10540kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:42592kB pagetables:140264kB sec_pagetables:0kB all_unreclaimable? no
[  859.563326] Node 0 DMA free:13308kB boost:0kB min:64kB low:80kB high:96kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[  859.563329] lowmem_reserve[]: 0 2305 15744 15744 15744
[  859.563332] Node 0 DMA32 free:63608kB boost:0kB min:9884kB low:12352kB high:14820kB reserved_highatomic:0KB active_anon:16kB inactive_anon:2330560kB active_file:88kB inactive_file:36kB unevictable:0kB writepending:8kB present:2467796kB managed:2401988kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[  859.563335] lowmem_reserve[]: 0 0 13439 13439 13439
[  859.563338] Node 0 Normal free:149776kB boost:90112kB min:147740kB low:162144kB high:176548kB reserved_highatomic:2048KB active_anon:56024kB inactive_anon:12889984kB active_file:19608kB inactive_file:22216kB unevictable:9032kB writepending:0kB present:14098432kB managed:13769880kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[  859.563342] lowmem_reserve[]: 0 0 0 0 0
[  859.563344] Node 0 DMA: 1*4kB (U) 1*8kB (U) 1*16kB (U) 1*32kB (U) 1*64kB (U) 1*128kB (U) 1*256kB (U) 1*512kB (U) 0*1024kB 2*2048kB (UM) 2*4096kB (M) = 13308kB
[  859.563353] Node 0 DMA32: 2*4kB (UM) 2*8kB (UM) 5*16kB (M) 5*32kB (UM) 6*64kB (UM) 17*128kB (UM) 22*256kB (UM) 4*512kB (UM) 6*1024kB (UM) 11*2048kB (UM) 6*4096kB (UM) = 63752kB
[  859.563362] Node 0 Normal: 7073*4kB (UMEH) 1922*8kB (UMEH) 756*16kB (UMEH) 464*32kB (UMEH) 830*64kB (UMEH) 197*128kB (UMH) 6*256kB (MH) 0*512kB 0*1024kB 0*2048kB 0*4096kB = 150484kB
[  859.563371] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
[  859.563373] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
[  859.563374] 23673 total pagecache pages
[  859.563374] 11582 pages in swap cache
[  859.563375] Free swap  = 7137276kB
[  859.563375] Total swap = 8003580kB
[  859.563376] 4145555 pages RAM
[  859.563376] 0 pages HighMem/MovableOnly
[  859.563377] 98748 pages reserved
[  859.563378] 0 pages hwpoisoned
[  859.563379] atlantic 0000:01:00.0 enp1s0: aq_ring_alloc[6](0x18000)
[  859.563381] atlantic 0000:01:00.0 enp1s0: aq_ring_alloc[6] FAILURE =============================
[  859.563388] atlantic 0000:01:00.0 enp1s0: device open failure
[  860.996946] atlantic 0000:01:00.0 enp1s0: aq_ring_alloc[0](0x30000)
[  860.996961] atlantic 0000:01:00.0 enp1s0: aq_ring_alloc[0](0x18000)

Thats already with the patch applied, so no panic and next "ifconfig up" recovers the device state.

I will submit a bugfix patch for that solution, but will also continue looking into suspend/resume refactoring.

Thanks,
  Igor

