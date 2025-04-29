Return-Path: <netdev+bounces-186618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C620A9FE46
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 02:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E992171BA5
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 00:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C2123C9;
	Tue, 29 Apr 2025 00:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LTUDBZKF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED848F64
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 00:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745886842; cv=none; b=OWmG8BrdgBTHXlWh2vHFNw/tIf4E6enpeKIZWXAEjXZrdqDd3nZpQLFmuM2MeorQSXtHzaR61pix/cktgsFBtWTeUWMvT98LJ3edT2CHG6RFHkuBM3jaA9QYJRHF0tEU/D06EeHIOjkpO3Gx8XTsJwx2UW9BZJWzRf7vvE4yoUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745886842; c=relaxed/simple;
	bh=rsvNqC0MxTQlWd+YUYXIHbuYym6di12rMpbncNUny2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1obod6JzFNU6a+2yaCHv71AIrEqEkIp+igCHV4rXDabWIj2xOOfL1LsZym6iWT77vVfV8N4YLsYcT5HfuOJLKOlCDQAsPhDxTzE0EMbu+9F2Wr+yCxgmwE8AvJLeRJP8XyvMWoHSA7O0TDfrjpOwRfZJBwbokLMdb+VWOBDOx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LTUDBZKF; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745886840; x=1777422840;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rsvNqC0MxTQlWd+YUYXIHbuYym6di12rMpbncNUny2U=;
  b=LTUDBZKFs4PmBJMYZAY19rxrml9bIiJHdt+eNHeh9uSPIABshhlkjG8M
   KLry1JrMRDvGHG0HLiuxXBxgT4SGsgYyFNZUNvd2zxYhov+6XUvWksQxn
   DtqJn6QDjL8wrxEGJkIFJ2qu/0xgmRruO9rQgxPWljhhf4ePeEWriYp8s
   WTPzh0VTlSsgCu3Eod21pAX8eU6cL8M5oa2Gp9MKMH52rAO9vupUNkrSp
   uwT5hWn+Or09RjQUBthANM6lynGbK4fQFnEKO0VJLYKCwelmi+EUbxeO2
   xH4YzOhqwYaxpk/eQLZyd3+C/u6PZMn3SAjZNAKnd5/wsSUuvtyv3edAA
   g==;
X-CSE-ConnectionGUID: pVm5f/RcT/iTcf8a2nGCsg==
X-CSE-MsgGUID: QOB7COzITiGXbc21zYV0iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="58485498"
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="58485498"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 17:34:00 -0700
X-CSE-ConnectionGUID: z7Dr7BCrQFmIZiVZDLnZeg==
X-CSE-MsgGUID: PomhpN88SUyEZuAwQ/IBYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="133620719"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.35.3])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 17:33:56 -0700
Date: Tue, 29 Apr 2025 08:24:08 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	yi1.lai@intel.com, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v3 net-next 03/15] ipv6: Move some validation from
 ip6_route_info_create() to rtm_to_fib6_config().
Message-ID: <aBAcKDEFoN/LntBF@ly-workstation>
References: <20250418000443.43734-1-kuniyu@amazon.com>
 <20250418000443.43734-4-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418000443.43734-4-kuniyu@amazon.com>

Hi Kuniyuki Iwashima,

Greetings!

I used Syzkaller and found that there is KASAN: use-after-free Read in ip6_route_info_create in linux-next tag - next-20250428.

After bisection and the first bad commit is:
"
fa76c1674f2e ipv6: Move some validation from ip6_route_info_create() to rtm_to_fib6_config().
"

All detailed into can be found at:
https://github.com/laifryiee/syzkaller_logs/tree/main/250429_005622_ip6_route_info_create
Syzkaller repro code:
https://github.com/laifryiee/syzkaller_logs/tree/main/250429_005622_ip6_route_info_create/repro.c
Syzkaller repro syscall steps:
https://github.com/laifryiee/syzkaller_logs/tree/main/250429_005622_ip6_route_info_create/repro.prog
Syzkaller report:
https://github.com/laifryiee/syzkaller_logs/tree/main/250429_005622_ip6_route_info_create/repro.report
Kconfig(make olddefconfig):
https://github.com/laifryiee/syzkaller_logs/tree/main/250429_005622_ip6_route_info_create/kconfig_origin
Bisect info:
https://github.com/laifryiee/syzkaller_logs/tree/main/250429_005622_ip6_route_info_create/bisect_info.log
bzImage:
https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/250429_005622_ip6_route_info_create/bzImage_33035b665157558254b3c21c3f049fd728e72368
Issue dmesg:
https://github.com/laifryiee/syzkaller_logs/blob/main/250429_005622_ip6_route_info_create/33035b665157558254b3c21c3f049fd728e72368_dmesg.log

"
[   17.307248] ==================================================================
[   17.307611] BUG: KASAN: slab-use-after-free in ip6_route_info_create+0xb84/0xc30
[   17.307993] Read of size 1 at addr ffff8880100b8a94 by task repro/727
[   17.308291] 
[   17.308389] CPU: 0 UID: 0 PID: 727 Comm: repro Not tainted 6.15.0-rc4-next-20250428-33035b665157 #1 PREEMPT(voluntary) 
[   17.308397] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   17.308405] Call Trace:
[   17.308412]  <TASK>
[   17.308414]  dump_stack_lvl+0xea/0x150
[   17.308439]  print_report+0xce/0x660
[   17.308469]  ? ip6_route_info_create+0xb84/0xc30
[   17.308475]  ? kasan_complete_mode_report_info+0x80/0x200
[   17.308482]  ? ip6_route_info_create+0xb84/0xc30
[   17.308489]  kasan_report+0xd6/0x110
[   17.308496]  ? ip6_route_info_create+0xb84/0xc30
[   17.308504]  __asan_report_load1_noabort+0x18/0x20
[   17.308509]  ip6_route_info_create+0xb84/0xc30
[   17.308516]  ip6_route_add+0x32/0x320
[   17.308524]  ipv6_route_ioctl+0x414/0x5a0
[   17.308530]  ? __pfx_ipv6_route_ioctl+0x10/0x10
[   17.308539]  ? __might_fault+0xf1/0x1b0
[   17.308556]  inet6_ioctl+0x265/0x2b0
[   17.308568]  ? __pfx_inet6_ioctl+0x10/0x10
[   17.308573]  ? do_anonymous_page+0x4b5/0x1b30
[   17.308579]  ? register_lock_class+0x49/0x4b0
[   17.308597]  ? __sanitizer_cov_trace_switch+0x58/0xa0
[   17.308616]  sock_do_ioctl+0xde/0x260
[   17.308628]  ? __pfx_sock_do_ioctl+0x10/0x10
[   17.308634]  ? __lock_acquire+0x410/0x2260
[   17.308640]  ? __lock_acquire+0x410/0x2260
[   17.308649]  ? __sanitizer_cov_trace_switch+0x58/0xa0
[   17.308656]  sock_ioctl+0x23e/0x6a0
[   17.308665]  ? __pfx_sock_ioctl+0x10/0x10
[   17.308671]  ? __this_cpu_preempt_check+0x21/0x30
[   17.308683]  ? seqcount_lockdep_reader_access.constprop.0+0xb4/0xd0
[   17.308694]  ? lockdep_hardirqs_on+0x89/0x110
[   17.308703]  ? trace_hardirqs_on+0x51/0x60
[   17.308717]  ? seqcount_lockdep_reader_access.constprop.0+0xc0/0xd0
[   17.308723]  ? __sanitizer_cov_trace_cmp4+0x1a/0x20
[   17.308729]  ? ktime_get_coarse_real_ts64+0xad/0xf0
[   17.308737]  ? __pfx_sock_ioctl+0x10/0x10
[   17.308744]  __x64_sys_ioctl+0x1bc/0x220
[   17.308765]  x64_sys_call+0x122e/0x2150
[   17.308774]  do_syscall_64+0x6d/0x150
[   17.308783]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   17.308789] RIP: 0033:0x7f75a8c3ee5d
[   17.308797] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
[   17.308803] RSP: 002b:00007ffe7620af68 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
[   17.308814] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f75a8c3ee5d
[   17.308818] RDX: 00000000200015c0 RSI: 000000000000890b RDI: 0000000000000003
[   17.308821] RBP: 00007ffe7620af80 R08: 0000000000000800 R09: 0000000000000800
[   17.308825] R10: 0000000000000000 R11: 0000000000000206 R12: 00007ffe7620b098
[   17.308828] R13: 0000000000401136 R14: 0000000000403e08 R15: 00007f75a8fc3000
[   17.308835]  </TASK>
[   17.308837] 
[   17.320668] Allocated by task 653:
[   17.320836]  kasan_save_stack+0x2c/0x60
[   17.321028]  kasan_save_track+0x18/0x40
[   17.321217]  kasan_save_alloc_info+0x3c/0x50
[   17.321430]  __kasan_slab_alloc+0x62/0x80
[   17.321627]  kmem_cache_alloc_noprof+0x13d/0x430
[   17.321855]  getname_kernel+0x5c/0x390
[   17.322044]  kern_path+0x29/0x90
[   17.322203]  unix_find_other+0x11b/0x880
[   17.322395]  unix_stream_connect+0x4f5/0x1a50
[   17.322604]  __sys_connect_file+0x159/0x1d0
[   17.322805]  __sys_connect+0x176/0x1b0
[   17.322986]  __x64_sys_connect+0x7b/0xc0
[   17.323180]  x64_sys_call+0x1bc7/0x2150
[   17.323371]  do_syscall_64+0x6d/0x150
[   17.323555]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   17.323793] 
[   17.323876] Freed by task 653:
[   17.324024]  kasan_save_stack+0x2c/0x60
[   17.324212]  kasan_save_track+0x18/0x40
[   17.324405]  kasan_save_free_info+0x3f/0x60
[   17.324606]  __kasan_slab_free+0x3d/0x60
[   17.324799]  kmem_cache_free+0x2ea/0x520
[   17.324987]  putname.part.0+0x132/0x180
[   17.325175]  kern_path+0x74/0x90
[   17.325335]  unix_find_other+0x11b/0x880
[   17.325526]  unix_stream_connect+0x4f5/0x1a50
[   17.325736]  __sys_connect_file+0x159/0x1d0
[   17.325941]  __sys_connect+0x176/0x1b0
[   17.326122]  __x64_sys_connect+0x7b/0xc0
[   17.326316]  x64_sys_call+0x1bc7/0x2150
[   17.326504]  do_syscall_64+0x6d/0x150
[   17.326687]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   17.326929] 
[   17.327013] The buggy address belongs to the object at ffff8880100b8000
[   17.327013]  which belongs to the cache names_cache of size 4096
[   17.327572] The buggy address is located 2708 bytes inside of
[   17.327572]  freed 4096-byte region [ffff8880100b8000, ffff8880100b9000)
[   17.328121] 
[   17.328204] The buggy address belongs to the physical page:
[   17.328461] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x100b8
[   17.328831] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[   17.329184] flags: 0xfffffc0000040(head|node=0|zone=1|lastcpupid=0x1fffff)
[   17.329508] page_type: f5(slab)
[   17.329670] raw: 000fffffc0000040 ffff88800d72cdc0 dead000000000100 dead000000000122
[   17.330022] raw: 0000000000000000 0000000000070007 00000000f5000000 0000000000000000
[   17.330381] head: 000fffffc0000040 ffff88800d72cdc0 dead000000000100 dead000000000122
[   17.330738] head: 0000000000000000 0000000000070007 00000000f5000000 0000000000000000
[   17.331094] head: 000fffffc0000003 ffffea0000402e01 00000000ffffffff 00000000ffffffff
[   17.331454] head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
[   17.331807] page dumped because: kasan: bad access detected
[   17.332066] 
[   17.332150] Memory state around the buggy address:
[   17.332374]  ffff8880100b8980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   17.332703]  ffff8880100b8a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   17.333031] >ffff8880100b8a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   17.333361]                          ^
[   17.333545]  ffff8880100b8b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   17.333874]  ffff8880100b8b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   17.334201] ==================================================================
"

Hope this cound be insightful to you.

Regards,
Yi Lai

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install 

On Thu, Apr 17, 2025 at 05:03:44PM -0700, Kuniyuki Iwashima wrote:
> ip6_route_info_create() is called from 3 functions:
> 
>   * ip6_route_add()
>   * ip6_route_multipath_add()
>   * addrconf_f6i_alloc()
> 
> addrconf_f6i_alloc() does not need validation for struct fib6_config in
> ip6_route_info_create().
> 
> ip6_route_multipath_add() calls ip6_route_info_create() for multiple
> routes with slightly different fib6_config instances, which is copied
> from the base config passed from userspace.  So, we need not validate
> the same config repeatedly.
> 
> Let's move such validation into rtm_to_fib6_config().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/ipv6/route.c | 79 +++++++++++++++++++++++++-----------------------
>  1 file changed, 42 insertions(+), 37 deletions(-)
> 
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 4de7abe5ee02..23102f37f220 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -3739,38 +3739,6 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
>  	int err = -EINVAL;
>  	int addr_type;
>  
> -	/* RTF_PCPU is an internal flag; can not be set by userspace */
> -	if (cfg->fc_flags & RTF_PCPU) {
> -		NL_SET_ERR_MSG(extack, "Userspace can not set RTF_PCPU");
> -		goto out;
> -	}
> -
> -	/* RTF_CACHE is an internal flag; can not be set by userspace */
> -	if (cfg->fc_flags & RTF_CACHE) {
> -		NL_SET_ERR_MSG(extack, "Userspace can not set RTF_CACHE");
> -		goto out;
> -	}
> -
> -	if (cfg->fc_type > RTN_MAX) {
> -		NL_SET_ERR_MSG(extack, "Invalid route type");
> -		goto out;
> -	}
> -
> -	if (cfg->fc_dst_len > 128) {
> -		NL_SET_ERR_MSG(extack, "Invalid prefix length");
> -		goto out;
> -	}
> -	if (cfg->fc_src_len > 128) {
> -		NL_SET_ERR_MSG(extack, "Invalid source address length");
> -		goto out;
> -	}
> -#ifndef CONFIG_IPV6_SUBTREES
> -	if (cfg->fc_src_len) {
> -		NL_SET_ERR_MSG(extack,
> -			       "Specifying source address requires IPV6_SUBTREES to be enabled");
> -		goto out;
> -	}
> -#endif
>  	if (cfg->fc_nh_id) {
>  		nh = nexthop_find_by_id(net, cfg->fc_nh_id);
>  		if (!nh) {
> @@ -3835,11 +3803,6 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
>  	rt->fib6_src.plen = cfg->fc_src_len;
>  #endif
>  	if (nh) {
> -		if (rt->fib6_src.plen) {
> -			NL_SET_ERR_MSG(extack, "Nexthops can not be used with source routing");
> -			err = -EINVAL;
> -			goto out_free;
> -		}
>  		if (!nexthop_get(nh)) {
>  			NL_SET_ERR_MSG(extack, "Nexthop has been deleted");
>  			err = -ENOENT;
> @@ -5239,6 +5202,48 @@ static int rtm_to_fib6_config(struct sk_buff *skb, struct nlmsghdr *nlh,
>  		}
>  	}
>  
> +	if (newroute) {
> +		/* RTF_PCPU is an internal flag; can not be set by userspace */
> +		if (cfg->fc_flags & RTF_PCPU) {
> +			NL_SET_ERR_MSG(extack, "Userspace can not set RTF_PCPU");
> +			goto errout;
> +		}
> +
> +		/* RTF_CACHE is an internal flag; can not be set by userspace */
> +		if (cfg->fc_flags & RTF_CACHE) {
> +			NL_SET_ERR_MSG(extack, "Userspace can not set RTF_CACHE");
> +			goto errout;
> +		}
> +
> +		if (cfg->fc_type > RTN_MAX) {
> +			NL_SET_ERR_MSG(extack, "Invalid route type");
> +			goto errout;
> +		}
> +
> +		if (cfg->fc_dst_len > 128) {
> +			NL_SET_ERR_MSG(extack, "Invalid prefix length");
> +			goto errout;
> +		}
> +
> +#ifdef CONFIG_IPV6_SUBTREES
> +		if (cfg->fc_src_len > 128) {
> +			NL_SET_ERR_MSG(extack, "Invalid source address length");
> +			goto errout;
> +		}
> +
> +		if (cfg->fc_nh_id &&  cfg->fc_src_len) {
> +			NL_SET_ERR_MSG(extack, "Nexthops can not be used with source routing");
> +			goto errout;
> +		}
> +#else
> +		if (cfg->fc_src_len) {
> +			NL_SET_ERR_MSG(extack,
> +				       "Specifying source address requires IPV6_SUBTREES to be enabled");
> +			goto errout;
> +		}
> +#endif
> +	}
> +
>  	err = 0;
>  errout:
>  	return err;
> -- 
> 2.49.0
> 

