Return-Path: <netdev+bounces-150288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7BB9E9CC4
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB8761887ED4
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 17:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600D6153801;
	Mon,  9 Dec 2024 17:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQ+gKVRm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD394409;
	Mon,  9 Dec 2024 17:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733764554; cv=none; b=Bd0+fo5jZLf7c9SaftwBhaxznLab2LxE7oj7tahqZW6sE9QOw5BpCQahde4/MOGYjnjBqwckT2wOYBrO9Rc8KZcdf7NjMJUl3gTPOKKfKeWsR+qAsCyRkD7lA0ythNxDfviDXMvBl8JoH/kVMHpdQA0uf2pssuS50JZpJRj2Ev8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733764554; c=relaxed/simple;
	bh=6mmK774oaI1xwIiw2gQoyks602oHU/lNQARnhNloHjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZBKqRODwgJeqLqhMTQ3Jy/7uxtfzVzMt9SA1RMw4L1TzZ0XyM2TpHEZ9C5wspLolYMHLfZ7eEl5Vt0S18C7bya7WJrj3kae/oaJH99S3DTJdCoVBsNNEYV64h9enKUl4fQRTY8eyo6wc3F40/1X6bPCXPqEA7kF+g9sGbQD+ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQ+gKVRm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C759C4CED1;
	Mon,  9 Dec 2024 17:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733764553;
	bh=6mmK774oaI1xwIiw2gQoyks602oHU/lNQARnhNloHjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AQ+gKVRmPkwSnAQ2nCoADv3vKcCNEjob6VWzUqjygd/m3+G9FZv2T/NgHlttZp9DC
	 X/xJBRSkoUZaaVNJFxhIWDOjybkNCVmJt/Lan95gXdw9imKSEx8oPCnA2dsZXmXMaW
	 8Xrt0dft5Jip9C43nO0vt+xMhI3vk4F0aJiDuSrMTEme1aVjevI3+Z/NEq6itGOG/S
	 zXVqkqsWocI4/Sq7zkLcGQsEYopb6PXSlirBU0VH9+8Hw7HCKsf3x/+i5gPfwY979r
	 juxsZJUhgLSkxZxXfqL3iTUdi7M64wVg/STXuIYnptQsp52ZSVa+qYFRx19y3Qzn7M
	 ZGij6Ldl0IqKA==
Date: Mon, 9 Dec 2024 18:15:50 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: syzbot <syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, hawk@kernel.org,
	horms@kernel.org, ilias.apalodimas@linaro.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, toke@redhat.com
Subject: Re: [syzbot] [net?] BUG: Bad page state in skb_pp_cow_data
Message-ID: <Z1clxqJ2-q4xVRCH@lore-desk>
References: <6756c37b.050a0220.a30f1.019a.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F4b1hG6eb+XkXxv1"
Content-Disposition: inline
In-Reply-To: <6756c37b.050a0220.a30f1.019a.GAE@google.com>


--F4b1hG6eb+XkXxv1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    7503345ac5f5 Merge tag 'block-6.13-20241207' of git://git=
=2E..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D1784c820580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D335e39020523e=
2ed
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dff145014d6b0ce6=
4a173
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D177a8b30580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D17d80c0f980000
>=20
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/21582041bcc6/dis=
k-7503345a.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3752facf1019/vmlinu=
x-7503345a.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/3b1c3c4d3bd9/b=
zImage-7503345a.xz
>=20
> The issue was bisected to:
>=20
> commit e6d5dbdd20aa6a86974af51deb9414cd2e7794cb
> Author: Lorenzo Bianconi <lorenzo@kernel.org>
> Date:   Mon Feb 12 09:50:56 2024 +0000
>=20
>     xdp: add multi-buff support for xdp running in generic mode
>=20
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D129acb3058=
0000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D119acb3058=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D169acb30580000
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com
> Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in gene=
ric mode")
>=20
> BUG: Bad page state in process syz-executor285  pfn:2d302
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2d302
> flags: 0xfff00000000000(node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> raw: 00fff00000000000 dead000000000040 ffff888022ab2000 0000000000000000
> raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
> page dumped because: page_pool leak
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(G=
FP_ATOMIC|__GFP_NOWARN), pid 5820, tgid 5820 (syz-executor285), ts 62999485=
029, free_ts 54592867285
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
>  prep_new_page mm/page_alloc.c:1564 [inline]
>  get_page_from_freelist+0x3651/0x37a0 mm/page_alloc.c:3474
>  __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
>  alloc_pages_bulk_noprof+0x70b/0xcc0 mm/page_alloc.c:4699
>  alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
>  __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
>  page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
>  page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
>  page_pool_alloc include/net/page_pool/helpers.h:129 [inline]
>  page_pool_dev_alloc include/net/page_pool/helpers.h:167 [inline]
>  skb_pp_cow_data+0xc43/0x1640 net/core/skbuff.c:983
>  netif_skb_check_for_xdp net/core/dev.c:5041 [inline]
>  netif_receive_generic_xdp net/core/dev.c:5080 [inline]
>  do_xdp_generic+0x505/0xd30 net/core/dev.c:5148
>  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
>  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
>  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
>  netif_receive_skb_internal net/core/dev.c:5871 [inline]
>  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
>  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
>  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
>  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
>  new_sync_write fs/read_write.c:586 [inline]
>  vfs_write+0xaeb/0xd30 fs/read_write.c:679
>  ksys_write+0x18f/0x2b0 fs/read_write.c:731
> page last free pid 5807 tgid 5807 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1127 [inline]
>  free_unref_page+0xde3/0x1130 mm/page_alloc.c:2657
>  __folio_put+0x2c7/0x440 mm/swap.c:112
>  pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
>  pipe_update_tail fs/pipe.c:224 [inline]
>  pipe_read+0x6ed/0x13e0 fs/pipe.c:344
>  new_sync_read fs/read_write.c:484 [inline]
>  vfs_read+0x991/0xb70 fs/read_write.c:565
>  ksys_read+0x18f/0x2b0 fs/read_write.c:708
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> Modules linked in:

According to the stack trace above this seems an issue in the page_pool
codebase since we are trying to get a new page from the page allocator
(__page_pool_alloc_pages_slow()) but the new page we receive is already
marked with PP_SIGNATURE in pp_magic field (bad reason is set to "page_pool
leak" in page_bad_reason()) so it already belongs to the pool.

@Jesper, Ilias: any input on it?

Regards,
Lorenzo

> CPU: 0 UID: 0 PID: 5820 Comm: syz-executor285 Not tainted 6.13.0-rc1-syzk=
aller-00337-g7503345ac5f5 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 09/13/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  bad_page+0x176/0x1d0 mm/page_alloc.c:501
>  free_page_is_bad mm/page_alloc.c:923 [inline]
>  free_pages_prepare mm/page_alloc.c:1119 [inline]
>  free_unref_page+0x1048/0x1130 mm/page_alloc.c:2657
>  bpf_xdp_shrink_data net/core/filter.c:4148 [inline]
>  bpf_xdp_frags_shrink_tail+0x3ee/0x7e0 net/core/filter.c:4169
>  ____bpf_xdp_adjust_tail net/core/filter.c:4194 [inline]
>  bpf_xdp_adjust_tail+0x1c3/0x200 net/core/filter.c:4187
>  bpf_prog_f476d5219b92964a+0x1e/0x20
>  __bpf_prog_run include/linux/filter.h:701 [inline]
>  bpf_prog_run_xdp include/net/xdp.h:514 [inline]
>  bpf_prog_run_generic_xdp+0x686/0x1510 net/core/dev.c:4973
>  netif_receive_generic_xdp net/core/dev.c:5086 [inline]
>  do_xdp_generic+0x757/0xd30 net/core/dev.c:5148
>  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
>  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
>  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
>  netif_receive_skb_internal net/core/dev.c:5871 [inline]
>  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
>  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
>  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
>  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
>  new_sync_write fs/read_write.c:586 [inline]
>  vfs_write+0xaeb/0xd30 fs/read_write.c:679
>  ksys_write+0x18f/0x2b0 fs/read_write.c:731
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f941abf7db0
> Code: 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b=
7 0f 1f 00 80 3d f1 e2 07 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff=
 ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
> RSP: 002b:00007ffc09852f28 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f941abf7db0
> RDX: 0000000000011dc0 RSI: 00000000200004c0 RDI: 00000000000000c8
> RBP: 0000000000000000 R08: 00007ffc09853058 R09: 00007ffc09853058
> R10: 00007ffc09853058 R11: 0000000000000202 R12: 00007f941ac460de
> R13: 0000000000000000 R14: 00007ffc09852f60 R15: 00007ffc09852f50
>  </TASK>
> BUG: Bad page state in process syz-executor285  pfn:2d301
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x8 pfn:0x2d301
> flags: 0xfff00000000000(node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> raw: 00fff00000000000 dead000000000040 ffff888022ab2000 0000000000000000
> raw: 0000000000000008 0000000000000001 00000000ffffffff 0000000000000000
> page dumped because: page_pool leak
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(G=
FP_ATOMIC|__GFP_NOWARN), pid 5820, tgid 5820 (syz-executor285), ts 62999478=
821, free_ts 55944947211
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
>  prep_new_page mm/page_alloc.c:1564 [inline]
>  get_page_from_freelist+0x3651/0x37a0 mm/page_alloc.c:3474
>  __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
>  alloc_pages_bulk_noprof+0x70b/0xcc0 mm/page_alloc.c:4699
>  alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
>  __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
>  page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
>  page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
>  page_pool_alloc include/net/page_pool/helpers.h:129 [inline]
>  page_pool_dev_alloc include/net/page_pool/helpers.h:167 [inline]
>  skb_pp_cow_data+0xc43/0x1640 net/core/skbuff.c:983
>  netif_skb_check_for_xdp net/core/dev.c:5041 [inline]
>  netif_receive_generic_xdp net/core/dev.c:5080 [inline]
>  do_xdp_generic+0x505/0xd30 net/core/dev.c:5148
>  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
>  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
>  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
>  netif_receive_skb_internal net/core/dev.c:5871 [inline]
>  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
>  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
>  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
>  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
>  new_sync_write fs/read_write.c:586 [inline]
>  vfs_write+0xaeb/0xd30 fs/read_write.c:679
>  ksys_write+0x18f/0x2b0 fs/read_write.c:731
> page last free pid 5810 tgid 5810 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1127 [inline]
>  free_unref_page+0xde3/0x1130 mm/page_alloc.c:2657
>  __folio_put+0x2c7/0x440 mm/swap.c:112
>  pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
>  pipe_update_tail fs/pipe.c:224 [inline]
>  pipe_read+0x6ed/0x13e0 fs/pipe.c:344
>  new_sync_read fs/read_write.c:484 [inline]
>  vfs_read+0x991/0xb70 fs/read_write.c:565
>  ksys_read+0x18f/0x2b0 fs/read_write.c:708
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> Modules linked in:
> CPU: 0 UID: 0 PID: 5820 Comm: syz-executor285 Tainted: G    B            =
  6.13.0-rc1-syzkaller-00337-g7503345ac5f5 #0
> Tainted: [B]=3DBAD_PAGE
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 09/13/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  bad_page+0x176/0x1d0 mm/page_alloc.c:501
>  free_page_is_bad mm/page_alloc.c:923 [inline]
>  free_pages_prepare mm/page_alloc.c:1119 [inline]
>  free_unref_page+0x1048/0x1130 mm/page_alloc.c:2657
>  bpf_xdp_shrink_data net/core/filter.c:4148 [inline]
>  bpf_xdp_frags_shrink_tail+0x3ee/0x7e0 net/core/filter.c:4169
>  ____bpf_xdp_adjust_tail net/core/filter.c:4194 [inline]
>  bpf_xdp_adjust_tail+0x1c3/0x200 net/core/filter.c:4187
>  bpf_prog_f476d5219b92964a+0x1e/0x20
>  __bpf_prog_run include/linux/filter.h:701 [inline]
>  bpf_prog_run_xdp include/net/xdp.h:514 [inline]
>  bpf_prog_run_generic_xdp+0x686/0x1510 net/core/dev.c:4973
>  netif_receive_generic_xdp net/core/dev.c:5086 [inline]
>  do_xdp_generic+0x757/0xd30 net/core/dev.c:5148
>  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
>  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
>  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
>  netif_receive_skb_internal net/core/dev.c:5871 [inline]
>  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
>  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
>  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
>  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
>  new_sync_write fs/read_write.c:586 [inline]
>  vfs_write+0xaeb/0xd30 fs/read_write.c:679
>  ksys_write+0x18f/0x2b0 fs/read_write.c:731
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f941abf7db0
> Code: 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b=
7 0f 1f 00 80 3d f1 e2 07 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff=
 ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
> RSP: 002b:00007ffc09852f28 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f941abf7db0
> RDX: 0000000000011dc0 RSI: 00000000200004c0 RDI: 00000000000000c8
> RBP: 0000000000000000 R08: 00007ffc09853058 R09: 00007ffc09853058
> R10: 00007ffc09853058 R11: 0000000000000202 R12: 00007f941ac460de
> R13: 0000000000000000 R14: 00007ffc09852f60 R15: 00007ffc09852f50
>  </TASK>
> BUG: Bad page state in process syz-executor285  pfn:2d300
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88802d30=
4000 pfn:0x2d300
> flags: 0xfff00000000000(node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> raw: 00fff00000000000 dead000000000040 ffff888022ab2000 0000000000000000
> raw: ffff88802d304000 0000000000000001 00000000ffffffff 0000000000000000
> page dumped because: page_pool leak
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(G=
FP_ATOMIC|__GFP_NOWARN), pid 5820, tgid 5820 (syz-executor285), ts 62999472=
559, free_ts 55944400344
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
>  prep_new_page mm/page_alloc.c:1564 [inline]
>  get_page_from_freelist+0x3651/0x37a0 mm/page_alloc.c:3474
>  __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
>  alloc_pages_bulk_noprof+0x70b/0xcc0 mm/page_alloc.c:4699
>  alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
>  __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
>  page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
>  page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
>  page_pool_alloc include/net/page_pool/helpers.h:129 [inline]
>  page_pool_dev_alloc include/net/page_pool/helpers.h:167 [inline]
>  skb_pp_cow_data+0xc43/0x1640 net/core/skbuff.c:983
>  netif_skb_check_for_xdp net/core/dev.c:5041 [inline]
>  netif_receive_generic_xdp net/core/dev.c:5080 [inline]
>  do_xdp_generic+0x505/0xd30 net/core/dev.c:5148
>  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
>  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
>  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
>  netif_receive_skb_internal net/core/dev.c:5871 [inline]
>  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
>  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
>  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
>  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
>  new_sync_write fs/read_write.c:586 [inline]
>  vfs_write+0xaeb/0xd30 fs/read_write.c:679
>  ksys_write+0x18f/0x2b0 fs/read_write.c:731
> page last free pid 5810 tgid 5810 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1127 [inline]
>  free_unref_page+0xde3/0x1130 mm/page_alloc.c:2657
>  __folio_put+0x2c7/0x440 mm/swap.c:112
>  pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
>  pipe_update_tail fs/pipe.c:224 [inline]
>  pipe_read+0x6ed/0x13e0 fs/pipe.c:344
>  new_sync_read fs/read_write.c:484 [inline]
>  vfs_read+0x991/0xb70 fs/read_write.c:565
>  ksys_read+0x18f/0x2b0 fs/read_write.c:708
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> Modules linked in:
> CPU: 0 UID: 0 PID: 5820 Comm: syz-executor285 Tainted: G    B            =
  6.13.0-rc1-syzkaller-00337-g7503345ac5f5 #0
> Tainted: [B]=3DBAD_PAGE
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 09/13/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  bad_page+0x176/0x1d0 mm/page_alloc.c:501
>  free_page_is_bad mm/page_alloc.c:923 [inline]
>  free_pages_prepare mm/page_alloc.c:1119 [inline]
>  free_unref_page+0x1048/0x1130 mm/page_alloc.c:2657
>  bpf_xdp_shrink_data net/core/filter.c:4148 [inline]
>  bpf_xdp_frags_shrink_tail+0x3ee/0x7e0 net/core/filter.c:4169
>  ____bpf_xdp_adjust_tail net/core/filter.c:4194 [inline]
>  bpf_xdp_adjust_tail+0x1c3/0x200 net/core/filter.c:4187
>  bpf_prog_f476d5219b92964a+0x1e/0x20
>  __bpf_prog_run include/linux/filter.h:701 [inline]
>  bpf_prog_run_xdp include/net/xdp.h:514 [inline]
>  bpf_prog_run_generic_xdp+0x686/0x1510 net/core/dev.c:4973
>  netif_receive_generic_xdp net/core/dev.c:5086 [inline]
>  do_xdp_generic+0x757/0xd30 net/core/dev.c:5148
>  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
>  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
>  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
>  netif_receive_skb_internal net/core/dev.c:5871 [inline]
>  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
>  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
>  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
>  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
>  new_sync_write fs/read_write.c:586 [inline]
>  vfs_write+0xaeb/0xd30 fs/read_write.c:679
>  ksys_write+0x18f/0x2b0 fs/read_write.c:731
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f941abf7db0
> Code: 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b=
7 0f 1f 00 80 3d f1 e2 07 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff=
 ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
> RSP: 002b:00007ffc09852f28 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f941abf7db0
> RDX: 0000000000011dc0 RSI: 00000000200004c0 RDI: 00000000000000c8
> RBP: 0000000000000000 R08: 00007ffc09853058 R09: 00007ffc09853058
> R10: 00007ffc09853058 R11: 0000000000000202 R12: 00007f941ac460de
> R13: 0000000000000000 R14: 00007ffc09852f60 R15: 00007ffc09852f50
>  </TASK>
> BUG: Bad page state in process syz-executor285  pfn:72d3b
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x72d3b
> flags: 0xfff00000000000(node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> raw: 00fff00000000000 dead000000000040 ffff888022ab2000 0000000000000000
> raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
> page dumped because: page_pool leak
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(G=
FP_ATOMIC|__GFP_NOWARN), pid 5820, tgid 5820 (syz-executor285), ts 62999466=
297, free_ts 54575113729
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
>  prep_new_page mm/page_alloc.c:1564 [inline]
>  get_page_from_freelist+0x3651/0x37a0 mm/page_alloc.c:3474
>  __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
>  alloc_pages_bulk_noprof+0x70b/0xcc0 mm/page_alloc.c:4699
>  alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
>  __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
>  page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
>  page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
>  page_pool_alloc include/net/page_pool/helpers.h:129 [inline]
>  page_pool_dev_alloc include/net/page_pool/helpers.h:167 [inline]
>  skb_pp_cow_data+0xc43/0x1640 net/core/skbuff.c:983
>  netif_skb_check_for_xdp net/core/dev.c:5041 [inline]
>  netif_receive_generic_xdp net/core/dev.c:5080 [inline]
>  do_xdp_generic+0x505/0xd30 net/core/dev.c:5148
>  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
>  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
>  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
>  netif_receive_skb_internal net/core/dev.c:5871 [inline]
>  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
>  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
>  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
>  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
>  new_sync_write fs/read_write.c:586 [inline]
>  vfs_write+0xaeb/0xd30 fs/read_write.c:679
>  ksys_write+0x18f/0x2b0 fs/read_write.c:731
> page last free pid 5807 tgid 5807 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1127 [inline]
>  free_unref_page+0xde3/0x1130 mm/page_alloc.c:2657
>  __folio_put+0x2c7/0x440 mm/swap.c:112
>  pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
>  pipe_update_tail fs/pipe.c:224 [inline]
>  pipe_read+0x6ed/0x13e0 fs/pipe.c:344
>  new_sync_read fs/read_write.c:484 [inline]
>  vfs_read+0x991/0xb70 fs/read_write.c:565
>  ksys_read+0x18f/0x2b0 fs/read_write.c:708
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> Modules linked in:
> CPU: 0 UID: 0 PID: 5820 Comm: syz-executor285 Tainted: G    B            =
  6.13.0-rc1-syzkaller-00337-g7503345ac5f5 #0
> Tainted: [B]=3DBAD_PAGE
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 09/13/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  bad_page+0x176/0x1d0 mm/page_alloc.c:501
>  free_page_is_bad mm/page_alloc.c:923 [inline]
>  free_pages_prepare mm/page_alloc.c:1119 [inline]
>  free_unref_page+0x1048/0x1130 mm/page_alloc.c:2657
>  bpf_xdp_shrink_data net/core/filter.c:4148 [inline]
>  bpf_xdp_frags_shrink_tail+0x3ee/0x7e0 net/core/filter.c:4169
>  ____bpf_xdp_adjust_tail net/core/filter.c:4194 [inline]
>  bpf_xdp_adjust_tail+0x1c3/0x200 net/core/filter.c:4187
>  bpf_prog_f476d5219b92964a+0x1e/0x20
>  __bpf_prog_run include/linux/filter.h:701 [inline]
>  bpf_prog_run_xdp include/net/xdp.h:514 [inline]
>  bpf_prog_run_generic_xdp+0x686/0x1510 net/core/dev.c:4973
>  netif_receive_generic_xdp net/core/dev.c:5086 [inline]
>  do_xdp_generic+0x757/0xd30 net/core/dev.c:5148
>  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
>  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
>  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
>  netif_receive_skb_internal net/core/dev.c:5871 [inline]
>  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
>  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
>  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
>  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
>  new_sync_write fs/read_write.c:586 [inline]
>  vfs_write+0xaeb/0xd30 fs/read_write.c:679
>  ksys_write+0x18f/0x2b0 fs/read_write.c:731
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f941abf7db0
> Code: 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b=
7 0f 1f 00 80 3d f1 e2 07 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff=
 ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
> RSP: 002b:00007ffc09852f28 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f941abf7db0
> RDX: 0000000000011dc0 RSI: 00000000200004c0 RDI: 00000000000000c8
> RBP: 0000000000000000 R08: 00007ffc09853058 R09: 00007ffc09853058
> R10: 00007ffc09853058 R11: 0000000000000202 R12: 00007f941ac460de
> R13: 0000000000000000 R14: 00007ffc09852f60 R15: 00007ffc09852f50
>  </TASK>
> BUG: Bad page state in process syz-executor285  pfn:72d3a
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x72d3a
> flags: 0xfff00000000000(node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> raw: 00fff00000000000 dead000000000040 ffff888022ab2000 0000000000000000
> raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
> page dumped because: page_pool leak
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(G=
FP_ATOMIC|__GFP_NOWARN), pid 5820, tgid 5820 (syz-executor285), ts 62999460=
106, free_ts 54575122306
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
>  prep_new_page mm/page_alloc.c:1564 [inline]
>  get_page_from_freelist+0x3651/0x37a0 mm/page_alloc.c:3474
>  __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
>  alloc_pages_bulk_noprof+0x70b/0xcc0 mm/page_alloc.c:4699
>  alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
>  __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
>  page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
>  page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
>  page_pool_alloc include/net/page_pool/helpers.h:129 [inline]
>  page_pool_dev_alloc include/net/page_pool/helpers.h:167 [inline]
>  skb_pp_cow_data+0xc43/0x1640 net/core/skbuff.c:983
>  netif_skb_check_for_xdp net/core/dev.c:5041 [inline]
>  netif_receive_generic_xdp net/core/dev.c:5080 [inline]
>  do_xdp_generic+0x505/0xd30 net/core/dev.c:5148
>  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
>  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
>  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
>  netif_receive_skb_internal net/core/dev.c:5871 [inline]
>  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
>  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
>  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
>  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
>  new_sync_write fs/read_write.c:586 [inline]
>  vfs_write+0xaeb/0xd30 fs/read_write.c:679
>  ksys_write+0x18f/0x2b0 fs/read_write.c:731
> page last free pid 5807 tgid 5807 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1127 [inline]
>  free_unref_page+0xde3/0x1130 mm/page_alloc.c:2657
>  __folio_put+0x2c7/0x440 mm/swap.c:112
>  pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
>  pipe_update_tail fs/pipe.c:224 [inline]
>  pipe_read+0x6ed/0x13e0 fs/pipe.c:344
>  new_sync_read fs/read_write.c:484 [inline]
>  vfs_read+0x991/0xb70 fs/read_write.c:565
>  ksys_read+0x18f/0x2b0 fs/read_write.c:708
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> Modules linked in:
> CPU: 0 UID: 0 PID: 5820 Comm: syz-executor285 Tainted: G    B            =
  6.13.0-rc1-syzkaller-00337-g7503345ac5f5 #0
> Tainted: [B]=3DBAD_PAGE
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 09/13/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  bad_page+0x176/0x1d0 mm/page_alloc.c:501
>  free_page_is_bad mm/page_alloc.c:923 [inline]
>  free_pages_prepare mm/page_alloc.c:1119 [inline]
>  free_unref_page+0x1048/0x1130 mm/page_alloc.c:2657
>  bpf_xdp_shrink_data net/core/filter.c:4148 [inline]
>  bpf_xdp_frags_shrink_tail+0x3ee/0x7e0 net/core/filter.c:4169
>  ____bpf_xdp_adjust_tail net/core/filter.c:4194 [inline]
>  bpf_xdp_adjust_tail+0x1c3/0x200 net/core/filter.c:4187
>  bpf_prog_f476d5219b92964a+0x1e/0x20
>  __bpf_prog_run include/linux/filter.h:701 [inline]
>  bpf_prog_run_xdp include/net/xdp.h:514 [inline]
>  bpf_prog_run_generic_xdp+0x686/0x1510 net/core/dev.c:4973
>  netif_receive_generic_xdp net/core/dev.c:5086 [inline]
>  do_xdp_generic+0x757/0xd30 net/core/dev.c:5148
>  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
>  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
>  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
>  netif_receive_skb_internal net/core/dev.c:5871 [inline]
>  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
>  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
>  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
>  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
>  new_sync_write fs/read_write.c:586 [inline]
>  vfs_write+0xaeb/0xd30 fs/read_write.c:679
>  ksys_write+0x18f/0x2b0 fs/read_write.c:731
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f941abf7db0
> Code: 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b=
7 0f 1f 00 80 3d f1 e2 07 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff=
 ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
> RSP: 002b:00007ffc09852f28 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f941abf7db0
> RDX: 0000000000011dc0 RSI: 00000000200004c0 RDI: 00000000000000c8
> RBP: 0000000000000000 R08: 00007ffc09853058 R09: 00007ffc09853058
> R10: 00007ffc09853058 R11: 0000000000000202 R12: 00007f941ac460de
> R13: 0000000000000000 R14: 00007ffc09852f60 R15: 00007ffc09852f50
>  </TASK>
> BUG: Bad page state in process syz-executor285  pfn:72d39
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x72d39
> flags: 0xfff00000000000(node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> raw: 00fff00000000000 dead000000000040 ffff888022ab2000 0000000000000000
> raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
> page dumped because: page_pool leak
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(G=
FP_ATOMIC|__GFP_NOWARN), pid 5820, tgid 5820 (syz-executor285), ts 62999453=
972, free_ts 54575963863
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
>  prep_new_page mm/page_alloc.c:1564 [inline]
>  get_page_from_freelist+0x3651/0x37a0 mm/page_alloc.c:3474
>  __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
>  alloc_pages_bulk_noprof+0x70b/0xcc0 mm/page_alloc.c:4699
>  alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
>  __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
>  page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
>  page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
>  page_pool_alloc include/net/page_pool/helpers.h:129 [inline]
>  page_pool_dev_alloc include/net/page_pool/helpers.h:167 [inline]
>  skb_pp_cow_data+0xc43/0x1640 net/core/skbuff.c:983
>  netif_skb_check_for_xdp net/core/dev.c:5041 [inline]
>  netif_receive_generic_xdp net/core/dev.c:5080 [inline]
>  do_xdp_generic+0x505/0xd30 net/core/dev.c:5148
>  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
>  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
>  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
>  netif_receive_skb_internal net/core/dev.c:5871 [inline]
>  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
>  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
>  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
>  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
>  new_sync_write fs/read_write.c:586 [inline]
>  vfs_write+0xaeb/0xd30 fs/read_write.c:679
>  ksys_write+0x18f/0x2b0 fs/read_write.c:731
> page last free pid 5807 tgid 5807 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1127 [inline]
>  free_unref_page+0xde3/0x1130 mm/page_alloc.c:2657
>  __folio_put+0x2c7/0x440 mm/swap.c:112
>  pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
>  pipe_update_tail fs/pipe.c:224 [inline]
>  pipe_read+0x6ed/0x13e0 fs/pipe.c:344
>  new_sync_read fs/read_write.c:484 [inline]
>  vfs_read+0x991/0xb70 fs/read_write.c:565
>  ksys_read+0x18f/0x2b0 fs/read_write.c:708
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> Modules linked in:
> CPU: 0 UID: 0 PID: 5820 Comm: syz-executor285 Tainted: G    B            =
  6.13.0-rc1-syzkaller-00337-g7503345ac5f5 #0
> Tainted: [B]=3DBAD_PAGE
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 09/13/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  bad_page+0x176/0x1d0 mm/page_alloc.c:501
>  free_page_is_bad mm/page_alloc.c:923 [inline]
>  free_pages_prepare mm/page_alloc.c:1119 [inline]
>  free_unref_page+0x1048/0x1130 mm/page_alloc.c:2657
>  bpf_xdp_shrink_data net/core/filter.c:4148 [inline]
>  bpf_xdp_frags_shrink_tail+0x3ee/0x7e0 net/core/filter.c:4169
>  ____bpf_xdp_adjust_tail net/core/filter.c:4194 [inline]
>  bpf_xdp_adjust_tail+0x1c3/0x200 net/core/filter.c:4187
>  bpf_prog_f476d5219b92964a+0x1e/0x20
>  __bpf_prog_run include/linux/filter.h:701 [inline]
>  bpf_prog_run_xdp include/net/xdp.h:514 [inline]
>  bpf_prog_run_generic_xdp+0x686/0x1510 net/core/dev.c:4973
>  netif_receive_generic_xdp net/core/dev.c:5086 [inline]
>  do_xdp_generic+0x757/0xd30 net/core/dev.c:5148
>  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
>  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
>  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
>  netif_receive_skb_internal net/core/dev.c:5871 [inline]
>  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
>  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
>  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
>  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
>  new_sync_write fs/read_write.c:586 [inline]
>  vfs_write+0xaeb/0xd30 fs/read_write.c:679
>  ksys_write+0x18f/0x2b0 fs/read_write.c:731
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f941abf7db0
> Code: 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b=
7 0f 1f 00 80 3d f1 e2 07 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff=
 ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
> RSP: 002b:00007ffc09852f28 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f941abf7db0
> RDX: 0000000000011dc0 RSI: 00000000200004c0 RDI: 00000000000000c8
> RBP: 0000000000000000 R08: 00007ffc09853058 R09: 00007ffc09853058
> R10: 00007ffc09853058 R11: 0000000000000202 R12: 00007f941ac460de
> R13: 0000000000000000 R14: 00007ffc09852f60 R15: 00007ffc09852f50
>  </TASK>
> BUG: Bad page state in process syz-executor285  pfn:72d38
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x72d38
> flags: 0xfff00000000000(node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> raw: 00fff00000000000 dead000000000040 ffff888022ab2000 0000000000000000
> raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
> page dumped because: page_pool leak
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(G=
FP_ATOMIC|__GFP_NOWARN), pid 5820, tgid 5820 (syz-executor285), ts 62999447=
572, free_ts 54575218247
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
>  prep_new_page mm/page_alloc.c:1564 [inline]
>  get_page_from_freelist+0x3651/0x37a0 mm/page_alloc.c:3474
>  __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
>  alloc_pages_bulk_noprof+0x70b/0xcc0 mm/page_alloc.c:4699
>  alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
>  __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
>  page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
>  page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
>  page_pool_alloc include/net/page_pool/helpers.h:129 [inline]
>  page_pool_dev_alloc include/net/page_pool/helpers.h:167 [inline]
>  skb_pp_cow_data+0xc43/0x1640 net/core/skbuff.c:983
>  netif_skb_check_for_xdp net/core/dev.c:5041 [inline]
>  netif_receive_generic_xdp net/core/dev.c:5080 [inline]
>  do_xdp_generic+0x505/0xd30 net/core/dev.c:5148
>  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
>  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
>  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
>  netif_receive_skb_internal net/core/dev.c:5871 [inline]
>  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
>  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
>  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
>  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
>  new_sync_write fs/read_write.c:586 [inline]
>  vfs_write+0xaeb/0xd30 fs/read_write.c:679
>  ksys_write+0x18f/0x2b0 fs/read_write.c:731
> page last free pid 5807 tgid 5807 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1127 [inline]
>  free_unref_page+0xde3/0x1130 mm/page_alloc.c:2657
>  __folio_put+0x2c7/0x440 mm/swap.c:112
>  pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
>  pipe_update_tail fs/pipe.c:224 [inline]
>  pipe_read+0x6ed/0x13e0 fs/pipe.c:344
>  new_sync_read fs/read_write.c:484 [inline]
>  vfs_read+0x991/0xb70 fs/read_write.c:565
>  ksys_read+0x18f/0x2b0 fs/read_write.c:708
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> Modules linked in:
> CPU: 0 UID: 0 PID: 5820 Comm: syz-executor285 Tainted: G    B            =
  6.13.0-rc1-syzkaller-00337-g7503345ac5f5 #0
> Tainted: [B]=3DBAD_PAGE
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 09/13/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  bad_page+0x176/0x1d0 mm/page_alloc.c:501
>  free_page_is_bad mm/page_alloc.c:923 [inline]
>  free_pages_prepare mm/page_alloc.c:1119 [inline]
>  free_unref_page+0x1048/0x1130 mm/page_alloc.c:2657
>  bpf_xdp_shrink_data net/core/filter.c:4148 [inline]
>  bpf_xdp_frags_shrink_tail+0x3ee/0x7e0 net/core/filter.c:4169
>  ____bpf_xdp_adjust_tail net/core/filter.c:4194 [inline]
>  bpf_xdp_adjust_tail+0x1c3/0x200 net/core/filter.c:4187
>  bpf_prog_f476d5219b92964a+0x1e/0x20
>  __bpf_prog_run include/linux/filter.h:701 [inline]
>  bpf_prog_run_xdp include/net/xdp.h:514 [inline]
>  bpf_prog_run_generic_xdp+0x686/0x1510 net/core/dev.c:4973
>  netif_receive_generic_xdp net/core/dev.c:5086 [inline]
>  do_xdp_generic+0x757/0xd30 net/core/dev.c:5148
>  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
>  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
>  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
>  netif_receive_skb_internal net/core/dev.c:5871 [inline]
>  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
>  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
>  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
>  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
>  new_sync_write fs/read_write.c:586 [inline]
>  vfs_write+0xaeb/0xd30 fs/read_write.c:679
>  ksys_write+0x18f/0x2b0 fs/read_write.c:731
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f941abf7db0
> Code: 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b=
7 0f 1f 00 80 3d f1 e2 07 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff=
 ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
> RSP: 002b:00007ffc09852f28 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f941abf7db0
> RDX: 0000000000011dc0 RSI: 00000000200004c0 RDI: 00000000000000c8
> RBP: 0000000000000000 R08: 00007ffc09853058 R09: 00007ffc09853058
> R10: 00007ffc09853058 R11: 0000000000000202 R12: 00007f941ac460de
> R13: 0000000000000000 R14: 00007ffc09852f60 R15: 00007ffc09852f50
>  </TASK>
> BUG: Bad page state in process syz-executor285  pfn:76907
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x76907
> flags: 0xfff00000000000(node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> raw: 00fff00000000000 dead000000000040 ffff888022ab2000 0000000000000000
> raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
> page dumped because: page_pool leak
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(G=
FP_ATOMIC|__GFP_NOWARN), pid 5820, tgid 5820 (syz-executor285), ts 62999441=
200, free_ts 54582364655
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
>  prep_new_page mm/page_alloc.c:1564 [inline]
>  get_page_from_freelist+0x3651/0x37a0 mm/page_alloc.c:3474
>  __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
>  alloc_pages_bulk_noprof+0x70b/0xcc0 mm/page_alloc.c:4699
>  alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
>  __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
>  page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
>  page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
>  page_pool_alloc include/net/page_pool/helpers.h:129 [inline]
>  page_pool_dev_alloc include/net/page_pool/helpers.h:167 [inline]
>  skb_pp_cow_data+0xc43/0x1640 net/core/skbuff.c:983
>  netif_skb_check_for_xdp net/core/dev.c:5041 [inline]
>  netif_receive_generic_xdp net/core/dev.c:5080 [inline]
>  do_xdp_generic+0x505/0xd30 net/core/dev.c:5148
>  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
>  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
>  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
>  netif_receive_skb_internal net/core/dev.c:5871 [inline]
>  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
>  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
>  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
>  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
>  new_sync_write fs/read_write.c:586 [inline]
>  vfs_write+0xaeb/0xd30 fs/read_write.c:679
>  ksys_write+0x18f/0x2b0 fs/read_write.c:731
> page last free pid 5807 tgid 5807 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1127 [inline]
>  free_unref_page+0xde3/0x1130 mm/page_alloc.c:2657
>  __folio_put+0x2c7/0x440 mm/swap.c:112
>  pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
>  pipe_update_tail fs/pipe.c:224 [inline]
>  pipe_read+0x6ed/0x13e0 fs/pipe.c:344
>  new_sync_read fs/read_write.c:484 [inline]
>  vfs_read+0x991/0xb70 fs/read_write.c:565
>  ksys_read+0x18f/0x2b0 fs/read_write.c:708
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> Modules linked in:
> CPU: 0 UID: 0 PID: 5820 Comm: syz-executor285 Tainted: G    B            =
  6.13.0-rc1-syzkaller-00337-g7503345ac5f5 #0
> Tainted: [B]=3DBAD_PAGE
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 09/13/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  bad_page+0x176/0x1d0 mm/page_alloc.c:501
>  free_page_is_bad mm/page_alloc.c:923 [inline]
>  free_pages_prepare mm/page_alloc.c:1119 [inline]
>  free_unref_page+0x1048/0x1130 mm/page_alloc.c:2657
>  bpf_xdp_shrink_data net/core/filter.c:4148 [inline]
>  bpf_xdp_frags_shrink_tail+0x3ee/0x7e0 net/core/filter.c:4169
>  ____bpf_xdp_adjust_tail net/core/filter.c:4194 [inline]
>  bpf_xdp_adjust_tail+0x1c3/0x200 net/core/filter.c:4187
>  bpf_prog_f476d5219b92964a+0x1e/0x20
>  __bpf_prog_run include/linux/filter.h:701 [inline]
>  bpf_prog_run_xdp include/net/xdp.h:514 [inline]
>  bpf_prog_run_generic_xdp+0x686/0x1510 net/core/dev.c:4973
>  netif_receive_generic_xdp net/core/dev.c:5086 [inline]
>  do_xdp_generic+0x757/0xd30 net/core/dev.c:5148
>  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
>  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
>  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
>  netif_receive_skb_internal net/core/dev.c:5871 [inline]
>  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
>  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
>  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
>  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
>  new_sync_write fs/read_write.c:586 [inline]
>  vfs_write+0xaeb/0xd30 fs/read_write.c:679
>  ksys_write+0x18f/0x2b0 fs/read_write.c:731
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f941abf7db0
> Code: 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b=
7 0f 1f 00 80 3d f1 e2 07 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff=
 ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
> RSP: 002b:00007ffc09852f28 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f941abf7db0
> RDX: 0000000000011dc0 RSI: 00000000200004c0 RDI: 00000000000000c8
> RBP: 0000000000000000 R08: 00007ffc09853058 R09: 00007ffc09853058
> R10: 00007ffc09853058 R11: 0000000000000202 R12: 00007f941ac460de
> R13: 0000000000000000 R14: 00007ffc09852f60 R15: 00007ffc09852f50
>  </TASK>
> BUG: Bad page state in process syz-executor285  pfn:76906
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x76906
> flags: 0xfff00000000000(node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> raw: 00fff00000000000 dead000000000040 ffff888022ab2000 0000000000000000
> raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
> page dumped because: page_pool leak
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(G=
FP_ATOMIC|__GFP_NOWARN), pid 5820, tgid 5820 (syz-executor285), ts 62999421=
067, free_ts 54582851254
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
>  prep_new_page mm/page_alloc.c:1564 [inline]
>  get_page_from_freelist+0x3651/0x37a0 mm/page_alloc.c:3474
>  __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
>  alloc_pages_bulk_noprof+0x70b/0xcc0 mm/page_alloc.c:4699
>  alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
>  __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
>  page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
>  page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
>  page_pool_alloc include/net/page_pool/helpers.h:129 [inline]
>  page_pool_dev_alloc include/net/page_pool/helpers.h:167 [inline]
>  skb_pp_cow_data+0xc43/0x1640 net/core/skbuff.c:983
>  netif_skb_check_for_xdp net/core/dev.c:5041 [inline]
>  netif_receive_generic_xdp net/core/dev.c:5080 [inline]
>  do_xdp_generic+0x505/0xd30 net/core/dev.c:5148
>  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
>  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
>  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
>  netif_receive_skb_internal net/core/dev.c:5871 [inline]
>  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
>  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
>  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
>  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
>  new_sync_write fs/read_write.c:586 [inline]
>  vfs_write+0xaeb/0xd30 fs/read_write.c:679
>  ksys_write+0x18f/0x2b0 fs/read_write.c:731
> page last free pid 5807 tgid 5807 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1127 [inline]
>  free_unref_page+0xde3/0x1130 mm/page_alloc.c:2657
>  __folio_put+0x2c7/0x440 mm/swap.c:112
>  pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
>  pipe_update_tail fs/pipe.c:224 [inline]
>  pipe_read+0x6ed/0x13e0 fs/pipe.c:344
>  new_sync_read fs/read_write.c:484 [inline]
>  vfs_read+0x991/0xb70 fs/read_write.c:565
>  ksys_read+0x18f/0x2b0 fs/read_write.c:708
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> Modules linked in:
> CPU: 0 UID: 0 PID: 5820 Comm: syz-executor285 Tainted: G    B            =
  6.13.0-rc1-syzkaller-00337-g7503345ac5f5 #0
> Tainted: [B]=3DBAD_PAGE
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 09/13/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  bad_page+0x176/0x1d0 mm/page_alloc.c:501
>  free_page_is_bad mm/page_alloc.c:923 [inline]
>  free_pages_prepare mm/page_alloc.c:1119 [inline]
>  free_unref_page+0x1048/0x1130 mm/page_alloc.c:2657
>  bpf_xdp_shrink_data net/core/filter.c:4148 [inline]
>  bpf_xdp_frags_shrink_tail+0x3ee/0x7e0 net/core/filter.c:4169
>  ____bpf_xdp_adjust_tail net/core/filter.c:4194 [inline]
>  bpf_xdp_adjust_tail+0x1c3/0x200 net/core/filter.c:4187
>  bpf_prog_f476d5219b92964a+0x1e/0x20
>  __bpf_prog_run include/linux/filter.h:701 [inline]
>  bpf_prog_run_xdp include/net/xdp.h:514 [inline]
>  bpf_prog_run_generic_xdp+0x686/0x1510 net/core/dev.c:4973
>  netif_receive_generic_xdp net/core/dev.c:5086 [inline]
>  do_xdp_generic+0x757/0xd30 net/core/dev.c:5148
>  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
>  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
>  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
>  netif_receive_skb_internal net/core/dev.c:5871 [inline]
>  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
>  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
>  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
>  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
>  new_sync_write fs/read_write.c:586 [inline]
>  vfs_write+0xaeb/0xd30 fs/read_write.c:679
>  ksys_write+0x18f/0x2b0 fs/read_write.c:731
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f941abf7db0
> Code: 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b=
7 0f 1f 00 80 3d f1 e2 07 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff=
 ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
> RSP: 002b:00007ffc09852f28 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f941abf7db0
> RDX: 0000000000011dc0 RSI: 00000000200004c0 RDI: 00000000000000c8
> RBP: 0000000000000000 R08: 00007ffc09853058 R09: 00007ffc09853058
> R10: 00007ffc09853058 R11: 0000000000000202 R12: 00007f941ac460de
> R13: 0000000000000000 R14: 00007ffc09852f60 R15: 00007ffc09852f50
>  </TASK>
> BUG: Bad page state in process syz-executor285  pfn:76905
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x76905
> flags: 0xfff00000000000(node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> raw: 00fff00000000000 dead000000000040 ffff888022ab2000 0000000000000000
> raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
> page dumped because: page_pool leak
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(G=
FP_ATOMIC|__GFP_NOWARN), pid 5820, tgid 5820 (syz-executor285), ts 62999414=
838, free_ts 54582871367
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
>  prep_new_page mm/page_alloc.c:1564 [inline]
>  get_page_from_freelist+0x3651/0x37a0 mm/page_alloc.c:3474
>  __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
>  alloc_pages_bulk_noprof+0x70b/0xcc0 mm/page_alloc.c:4699
>  alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
>  __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
>  page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
>  page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
>  page_pool_alloc include/net/page_pool/helpers.h:129 [inline]
>  page_pool_dev_alloc include/net/page_pool/helpers.h:167 [inline]
>  skb_pp_cow_data+0xc43/0x1640 net/core/skbuff.c:983
>  netif_skb_check_for_xdp net/core/dev.c:5041 [inline]
>  netif_receive_generic_xdp net/core/dev.c:5080 [inline]
>  do_xdp_generic+0x505/0xd30 net/core/dev.c:5148
>  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
>  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
>  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
>  netif_receive_skb_internal net/core/dev.c:5871 [inline]
>  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
>  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
>  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
>  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
>  new_sync_write fs/read_write.c:586 [inline]
>  vfs_write+0xaeb/0xd30 fs/read_write.c:679
>  ksys_write+0x18f/0x2b0 fs/read_write.c:731
> page last free pid 5807 tgid 5807 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1127 [inline]
>  free_unref_page+0xde3/0x1130 mm/page_alloc.c:2657
>  __folio_put+0x2c7/0x440 mm/swap.c:112
>  pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
>  pipe_update_tail fs/pipe.c:224 [inline]
>  pipe_read+0x6ed/0x13e0 fs/pipe.c:344
>  new_sync_read fs/read_write.c:484 [inline]
>  vfs_read+0x991/0xb70 fs/read_write.c:565
>  ksys_read+0x18f/0x2b0 fs/read_write.c:708
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> Modules linked in:
> CPU: 0 UID: 0 PID: 5820 Comm: syz-executor285 Tainted: G    B            =
  6.13.0-rc1-syzkaller-00337-g7503345ac5f5 #0
> Tainted: [B]=3DBAD_PAGE
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 09/13/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  bad_page+0x176/0x1d0 mm/page_alloc.c:501
>  free_page_is_bad mm/page_alloc.c:923 [inline]
>  free_pages_prepare mm/page_alloc.c:1119 [inline]
>  free_unref_page+0x1048/0x1130 mm/page_alloc.c:2657
>  bpf_xdp_shrink_data net/core/filter.c:4148 [inline]
>  bpf_xdp_frags_shrink_tail+0x3ee/0x7e0 net/core/filter.c:4169
>  ____bpf_xdp_adjust_tail net/core/filter.c:4194 [inline]
>  bpf_xdp_adjust_tail+0x1c3/0x200 net/core/filter.c:4187
>  bpf_prog_f476d5219b92964a+0x1e/0x20
>  __bpf_prog_run include/linux/filter.h:701 [inline]
>  bpf_prog_run_xdp include/net/xdp.h:514 [inline]
>  bpf_prog_run_generic_xdp+0x686/0x1510 net/core/dev.c:4973
>  netif_receive_generic_xdp net/core/dev.c:5086 [inline]
>  do_xdp_generic+0x757/0xd30 net/core/dev.c:5148
>  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
>  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
>  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
>  netif_receive_skb_internal net/core/dev.c:5871 [inline]
>  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
>  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
>  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
>  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
>  new_sync_write fs/read_write.c:586 [inline]
>  vfs_write+0xaeb/0xd30 fs/read_write.c:679
>  ksys_write+0x18f/0x2b0 fs/read_write.c:731
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f941abf7db0
> Code: 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b=
7 0f 1f 00 80 3d f1 e2 07 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff=
 ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
> RSP: 002b:00007ffc09852f28 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f941abf7db0
> RDX: 0000000000011dc0 RSI: 00000000200004c0 RDI: 00000000000000c8
> RBP: 0000000000000000 R08: 00007ffc09853058 R09: 00007ffc09853058
> R10: 00007ffc09853058 R11: 0000000000000202 R12: 00007f941ac460de
> R13: 0000000000000000 R14: 00007ffc09852f60 R15: 00007ffc09852f50
>  </TASK>
> BUG: Bad page state in process syz-executor285  pfn:76904
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x76904
> flags: 0xfff00000000000(node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> raw: 00fff00000000000 dead000000000040 ffff888022ab2000 0000000000000000
> raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
> page dumped because: page_pool leak
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(G=
FP_ATOMIC|__GFP_NOWARN), pid 5820, tgid 5820 (syz-executor285), ts 62999408=
239, free_ts 54582895841
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
>  prep_new_page mm/page_alloc.c:1564 [inline]
>  get_page_from_freelist+0x3651/0x37a0 mm/page_alloc.c:3474
>  __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
>  alloc_pages_bulk_noprof+0x70b/0xcc0 mm/page_alloc.c:4699
>  alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
>  __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
>  page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
>  page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
>  page_pool_alloc include/net/page_pool/helpers.h:129 [inline]
>  page_pool_dev_alloc include/net/page_pool/helpers.h:167 [inline]
>  skb_pp_cow_data+0xc43/0x1640 net/core/skbuff.c:983
>  netif_skb_check_for_xdp net/core/dev.c:5041 [inline]
>  netif_receive_generic_xdp net/core/dev.c:5080 [inline]
>  do_xdp_generic+0x505/0xd30 net/core/dev.c:5148
>  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
>  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
>  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
>  netif_receive_skb_internal net/core/dev.c:5871 [inline]
>  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
>  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
>  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
>  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
>  new_sync_write fs/read_write.c:586 [inline]
>  vfs_write+0xaeb/0xd30 fs/read_write.c:679
>  ksys_write+0x18f/0x2b0 fs/read_write.c:731
> page last free pid 5807 tgid 5807 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1127 [inline]
>  free_unref_page+0xde3/0x1130 mm/page_alloc.c:2657
>  __folio_put+0x2c7/0x440 mm/swap.c:112
>  pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
>  pipe_update_tail fs/pipe.c:224 [inline]
>  pipe_read+0x6ed/0x13e0 fs/pipe.c:344
>  new_sync_read fs/read_write.c:484 [inline]
>  vfs_read+0x991/0xb70 fs/read_write.c:565
>  ksys_read+0x18f/0x2b0 fs/read_write.c:708
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> Modules linked in:
> CPU: 0 UID: 0 PID: 5820 Comm: syz-executor285 Tainted: G    B            =
  6.13.0-rc1-syzkaller-00337-g7503345ac5f5 #0
> Tainted: [B]=3DBAD_PAGE
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 09/13/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  bad_page+0x176/0x1d0 mm/page_alloc.c:501
>  free_page_is_bad mm/page_alloc.c:923 [inline]
>  free_pages_prepare mm/page_alloc.c:1119 [inline]
>  free_unref_page+0x1048/0x1130 mm/page_alloc.c:2657
>  bpf_xdp_shrink_data net/core/filter.c:4148 [inline]
>  bpf_xdp_frags_shrink_tail+0x3ee/0x7e0 net/core/filter.c:4169
>  ____bpf_xdp_adjust_tail net/core/filter.c:4194 [inline]
>  bpf_xdp_adjust_tail+0x1c3/0x200 net/core/filter.c:4187
>  bpf_prog_f476d5219b92964a+0x1e/0x20
>  __bpf_prog_run include/linux/filter.h:701 [inline]
>  bpf_prog_run_xdp include/net/xdp.h:514 [inline]
>  bpf_prog_run_generic_xdp+0x686/0x1510 net/core/dev.c:4973
>  netif_receive_generic_xdp net/core/dev.c:5086 [inline]
>  do_xdp_generic+0x757/0xd30 net/core/dev.c:5148
>  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
>  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
>  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
>  netif_receive_skb_internal net/core/dev.c:5871 [inline]
>  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
>  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
>  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
>  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
>  new_sync_write fs/read_write.c:586 [inline]
>  vfs_write+0xaeb/0xd30 fs/read_write.c:679
>  ksys_write+0x18f/0x2b0 fs/read_write.c:731
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f941abf7db0
> Code: 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b=
7 0f 1f 00 80 3d f1 e2 07 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff=
 ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
> RSP: 002b:00007ffc09852f28 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f941abf7db0
> RDX: 0000000000011dc0 RSI: 00000000200004c0 RDI: 00000000000000c8
> RBP: 0000000000000000 R08: 00007ffc09853058 R09: 00007ffc09853058
> R10: 00007ffc09853058 R11: 0000000000000202 R12: 00007f941ac460de
> R13: 0000000000000000 R14: 00007ffc09852f60 R15: 00007ffc09852f50
>  </TASK>
>=20
>=20
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>=20
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>=20
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>=20
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>=20
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>=20
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>=20
> If you want to undo deduplication, reply with:
> #syz undup

--F4b1hG6eb+XkXxv1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ1clxgAKCRA6cBh0uS2t
rMKMAQCUHS25JA8YHh0O4WmYpVubTHREayATjFhdhepPyCwCEAEAuWY6ARTOuRAC
sT8/ZMRrHohDx5DUxCL2FoYgiuLewg8=
=8a6n
-----END PGP SIGNATURE-----

--F4b1hG6eb+XkXxv1--

