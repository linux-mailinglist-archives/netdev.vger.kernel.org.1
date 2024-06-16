Return-Path: <netdev+bounces-103838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 333F7909CC5
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 11:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C3A1C20991
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 09:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EB316D9C9;
	Sun, 16 Jun 2024 09:24:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9885C2F26
	for <netdev@vger.kernel.org>; Sun, 16 Jun 2024 09:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718529874; cv=none; b=PypLKaNwhRbT2vnL+eax1PWTT48G+wm04qIsOEAlimci6uEMvforLD3t/DF1apJPS/9rRwRSxOVRq867MhRIhFDC2qXnsFEkXc9b1aYUrrJlid+QjGocbbIlq8FWp3c73cjcYKLIaizp+v5jZHuBCLTO44oez41fZekpKfDGdXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718529874; c=relaxed/simple;
	bh=vKW2e1YjzWV1CuAtDetbVtcddLruTW3Y21qs1VaNXX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nKIpfjPmbC7P8EJQlCPSYjMiknjI7i3e4UZtQav/+64bnGR+WPuVPSDD2KNBWW0gtmq93qCLxNz8v1o7b7C/ZBsZHt5ADPEQtw/EscVnlUW6Xoxs/mdUum3yh3cj1i5RmZYvPhroyCPMOMeXMz+NzptaX0+qMgOMlvBImC4261Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52ca9e52d5dso227760e87.1
        for <netdev@vger.kernel.org>; Sun, 16 Jun 2024 02:24:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718529871; x=1719134671;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5DslIPEWa1agmfJXbyddVtGs+IrgyIOUuvNhh9hJGwY=;
        b=Acel3/+4weDkqEgcG0z+1Qd499Xadh/knPe0sztf7/AxyJk5ANzzcb+5MiSFu7WEJa
         5Y6JYRGdOVU8QgDs9j/CXrTdv4Ad4prRrgON9Bb3yT/U3kaTFdy1mCls15SviBeAN8MH
         SUpqfyIlli4nbsONAuGrW7rFIRAdWevgEP8cZek4b7oSM+KwyNZbWs7/a7lqGjUdO38N
         mP3Qexc23e0kyZODJ/bO23H5hwPJf97gIOWYnlHLLuP1kvD66FjbXahOpC15S6obaVKZ
         CIDyPZ+iDfgnMo2+SJwK6sOAZAzlXV3oFsfDqpxo1+NOlRtyzI5axjz5bd/bAvuTlR4L
         yJ+w==
X-Forwarded-Encrypted: i=1; AJvYcCWFwm1BiQawqSqFuOiuZUdzK9K6EoLTbQpWCw5k7a6J7QN1dI5t/kL9soIFreTtSIedPmmNkrmuhpcQXWNcIAq2C1toOnSG
X-Gm-Message-State: AOJu0Yz1UlVzNYrNYRp7ZVvnuQyo9S/z1RIOREUO06bc9CT+ZdWlM/hq
	1TLiNe2Tz+t408sYmF/8drbJMBKj/3Cd3j2R/5IJsxG92XkgnJkd
X-Google-Smtp-Source: AGHT+IEE9ozJ7jN8aSSupOsv471h7a6E3CWKm5yZAHxBdJuJ7PBr+0plwlvQGDTq9fk/8ckS1D7Fpw==
X-Received: by 2002:a05:6512:3d28:b0:52c:9a89:ece9 with SMTP id 2adb3069b0e04-52ca6ea5d43mr4275203e87.4.1718529870310;
        Sun, 16 Jun 2024 02:24:30 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-423b7a61501sm43343995e9.46.2024.06.16.02.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jun 2024 02:24:29 -0700 (PDT)
Message-ID: <4937ffd4-f30a-4bdb-9166-6aebb19ca950@grimberg.me>
Date: Sun, 16 Jun 2024 12:24:28 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: micro-optimize skb_datagram_iter
To: kernel test robot <oliver.sang@intel.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
References: <202406161539.b5ff7b20-oliver.sang@intel.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <202406161539.b5ff7b20-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16/06/2024 11:06, kernel test robot wrote:
>
> Hello,
>
> kernel test robot noticed "kernel_BUG_at_mm/usercopy.c" on:
>
> commit: 18f0423b9eccb781310af6709ceebf654175af14 ("[PATCH] net: micro-optimize skb_datagram_iter")
> url: https://github.com/intel-lab-lkp/linux/commits/Sagi-Grimberg/net-micro-optimize-skb_datagram_iter/20240613-193620
> base: https://git.kernel.org/cgit/linux/kernel/git/davem/net.git b60b1bdc1888f51da7a2a22c48c5f1eb2bd12e97
> patch link: https://lore.kernel.org/all/20240613113504.1079860-1-sagi@grimberg.me/
> patch subject: [PATCH] net: micro-optimize skb_datagram_iter
>
> in testcase: boot
>
> compiler: gcc-8
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
> +------------------------------------------+------------+------------+
> |                                          | b60b1bdc18 | 18f0423b9e |
> +------------------------------------------+------------+------------+
> | boot_successes                           | 6          | 0          |
> | boot_failures                            | 0          | 6          |
> | kernel_BUG_at_mm/usercopy.c              | 0          | 6          |
> | Oops:invalid_opcode:#[##]PREEMPT_SMP     | 0          | 6          |
> | EIP:usercopy_abort                       | 0          | 6          |
> | Kernel_panic-not_syncing:Fatal_exception | 0          | 6          |
> +------------------------------------------+------------+------------+
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202406161539.b5ff7b20-oliver.sang@intel.com
>
>
> [   13.495377][  T189] ------------[ cut here ]------------
> [   13.495862][  T189] kernel BUG at mm/usercopy.c:102!
> [   13.496372][  T189] Oops: invalid opcode: 0000 [#1] PREEMPT SMP
> [   13.496927][  T189] CPU: 0 PID: 189 Comm: systemctl Not tainted 6.10.0-rc2-00258-g18f0423b9ecc #1
> [   13.497741][  T189] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [ 13.498663][ T189] EIP: usercopy_abort (mm/usercopy.c:102 (discriminator 12))
> [   13.499424][  T194] usercopy: Kernel memory exposure attempt detected from kmap (offset 0, size 8192)!

Hmm, not sure I understand exactly why changing kmap() to 
kmap_local_page() expose this,
but it looks like mm/usercopy does not like size=8192 when copying for 
the skb frag.

quick git browse directs to:
--
commit 4e140f59d285c1ca1e5c81b4c13e27366865bd09
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Mon Jan 10 23:15:27 2022 +0000

     mm/usercopy: Check kmap addresses properly

     If you are copying to an address in the kmap region, you may not copy
     across a page boundary, no matter what the size of the underlying
     allocation.  You can't kmap() a slab page because slab pages always
     come from low memory.

     Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
     Acked-by: Kees Cook <keescook@chromium.org>
     Signed-off-by: Kees Cook <keescook@chromium.org>
     Link: 
https://lore.kernel.org/r/20220110231530.665970-2-willy@infradead.org
--

CCing willy.

The documentation suggest that under single-context usage kmap() can be 
freely converted
to kmap_local_page()? But seems that when using kmap() the size is not 
an issue, still trying to
understand why.



> [ 13.499647][ T189] Code: d6 89 44 24 0c 0f 45 cf 8b 7d 0c 89 74 24 10 89 4c 24 04 c7 04 24 a4 55 8a d6 89 7c 24 20 8b 7d 08 89 7c 24 1c e8 20 3c df ff <0f> 0b b8 80 91 d7 d6 e8 a8 de 68 00 ba 3d 17 86 d6 89 55 f0 89 d6
> All code
> ========
>     0:	d6                   	(bad)
>     1:	89 44 24 0c          	mov    %eax,0xc(%rsp)
>     5:	0f 45 cf             	cmovne %edi,%ecx
>     8:	8b 7d 0c             	mov    0xc(%rbp),%edi
>     b:	89 74 24 10          	mov    %esi,0x10(%rsp)
>     f:	89 4c 24 04          	mov    %ecx,0x4(%rsp)
>    13:	c7 04 24 a4 55 8a d6 	movl   $0xd68a55a4,(%rsp)
>    1a:	89 7c 24 20          	mov    %edi,0x20(%rsp)
>    1e:	8b 7d 08             	mov    0x8(%rbp),%edi
>    21:	89 7c 24 1c          	mov    %edi,0x1c(%rsp)
>    25:	e8 20 3c df ff       	call   0xffffffffffdf3c4a
>    2a:*	0f 0b                	ud2		<-- trapping instruction
>    2c:	b8 80 91 d7 d6       	mov    $0xd6d79180,%eax
>    31:	e8 a8 de 68 00       	call   0x68dede
>    36:	ba 3d 17 86 d6       	mov    $0xd686173d,%edx
>    3b:	89 55 f0             	mov    %edx,-0x10(%rbp)
>    3e:	89 d6                	mov    %edx,%esi
>
> Code starting with the faulting instruction
> ===========================================
>     0:	0f 0b                	ud2
>     2:	b8 80 91 d7 d6       	mov    $0xd6d79180,%eax
>     7:	e8 a8 de 68 00       	call   0x68deb4
>     c:	ba 3d 17 86 d6       	mov    $0xd686173d,%edx
>    11:	89 55 f0             	mov    %edx,-0x10(%rbp)
>    14:	89 d6                	mov    %edx,%esi
> [   13.500502][  T194] ------------[ cut here ]------------
> [   13.502187][  T189] EAX: 00000052 EBX: d680da68 ECX: e0435480 EDX: 01000232
> [   13.502666][  T194] kernel BUG at mm/usercopy.c:102!
> [   13.503236][  T189] ESI: d686173d EDI: 00000000 EBP: ece37c44 ESP: ece37c10
> [   13.504266][  T189] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010286
> [   13.504856][  T189] CR0: 80050033 CR2: 0135eb6c CR3: 2beff000 CR4: 000406d0
> [   13.505464][  T189] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [   13.506083][  T189] DR6: fffe0ff0 DR7: 00000400
> [   13.506495][  T189] Call Trace:
> [ 13.506795][ T189] ? show_regs (arch/x86/kernel/dumpstack.c:479)
> [ 13.507187][ T189] ? __die_body (arch/x86/kernel/dumpstack.c:421)
> [ 13.507576][ T189] ? die (arch/x86/kernel/dumpstack.c:449)
> [ 13.507894][ T189] ? do_trap (arch/x86/kernel/traps.c:114 arch/x86/kernel/traps.c:155)
> [ 13.508270][ T189] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4300 kernel/locking/lockdep.c:4359 kernel/locking/lockdep.c:4311)
> [ 13.508783][ T189] ? do_error_trap (arch/x86/include/asm/traps.h:58 arch/x86/kernel/traps.c:176)
> [ 13.509182][ T189] ? usercopy_abort (mm/usercopy.c:102 (discriminator 12))
> [ 13.509588][ T189] ? exc_overflow (arch/x86/kernel/traps.c:252)
> [ 13.509983][ T189] ? exc_invalid_op (arch/x86/kernel/traps.c:267)
> [ 13.510396][ T189] ? usercopy_abort (mm/usercopy.c:102 (discriminator 12))
> [ 13.510797][ T189] ? handle_exception (arch/x86/entry/entry_32.S:1054)
> [ 13.511242][ T189] ? exc_overflow (arch/x86/kernel/traps.c:252)
> [ 13.511646][ T189] ? usercopy_abort (mm/usercopy.c:102 (discriminator 12))
> [ 13.512070][ T189] ? exc_overflow (arch/x86/kernel/traps.c:252)
> [ 13.512434][ T189] ? usercopy_abort (mm/usercopy.c:102 (discriminator 12))
> [ 13.512832][ T189] __check_object_size (mm/usercopy.c:180 mm/usercopy.c:251 mm/usercopy.c:213)
> [ 13.513275][ T189] simple_copy_to_iter (include/linux/uio.h:196 net/core/datagram.c:513)
> [ 13.513693][ T189] __skb_datagram_iter (net/core/datagram.c:424 (discriminator 1))
> [ 13.514138][ T189] skb_copy_datagram_iter (net/core/datagram.c:529)
> [ 13.514606][ T189] ? skb_free_datagram (net/core/datagram.c:512)
> [ 13.515028][ T189] ? scm_stat_del (net/unix/af_unix.c:2883)
> [ 13.515429][ T189] unix_stream_read_actor (net/unix/af_unix.c:2889)
> [ 13.515884][ T189] unix_stream_read_generic (net/unix/af_unix.c:2805)
> [ 13.516377][ T189] ? cma_for_each_area (mm/page_ext.c:518)
> [ 13.516826][ T189] ? unix_stream_splice_read (net/unix/af_unix.c:2907)
> [ 13.517301][ T189] unix_stream_recvmsg (net/unix/af_unix.c:2923)
> [ 13.517720][ T189] ? scm_stat_del (net/unix/af_unix.c:2883)
> [ 13.518108][ T189] ____sys_recvmsg (net/socket.c:1046 net/socket.c:1068 net/socket.c:2804)
> [ 13.518527][ T189] ? import_iovec (lib/iov_iter.c:1348)
> [ 13.518930][ T189] ? copy_msghdr_from_user (net/socket.c:2525)
> [ 13.519396][ T189] ___sys_recvmsg (net/socket.c:2846)
> [ 13.519811][ T189] ? __fdget (fs/file.c:1160)
> [ 13.520186][ T189] ? sockfd_lookup_light (net/socket.c:558)
> [ 13.520643][ T189] __sys_recvmsg (include/linux/file.h:34 net/socket.c:2878)
> [ 13.521046][ T189] __ia32_sys_socketcall (net/socket.c:3173 net/socket.c:3077 net/socket.c:3077)
> [ 13.521513][ T189] ia32_sys_call (arch/x86/entry/syscall_32.c:42)
> [ 13.521923][ T189] __do_fast_syscall_32 (arch/x86/entry/common.c:165 arch/x86/entry/common.c:386)
> [ 13.522362][ T189] do_fast_syscall_32 (arch/x86/entry/common.c:411)
> [ 13.522787][ T189] do_SYSENTER_32 (arch/x86/entry/common.c:450)
> [ 13.523188][ T189] entry_SYSENTER_32 (arch/x86/entry/entry_32.S:836)
> [   13.523613][  T189] EIP: 0xb7ee6579
> [ 13.523933][ T189] Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
> All code
> ========
>     0:	b8 01 10 06 03       	mov    $0x3061001,%eax
>     5:	74 b4                	je     0xffffffffffffffbb
>     7:	01 10                	add    %edx,(%rax)
>     9:	07                   	(bad)
>     a:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
>     e:	10 08                	adc    %cl,(%rax)
>    10:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
> 	...
>    20:	00 51 52             	add    %dl,0x52(%rcx)
>    23:	55                   	push   %rbp
>    24:*	89 e5                	mov    %esp,%ebp		<-- trapping instruction
>    26:	0f 34                	sysenter
>    28:	cd 80                	int    $0x80
>    2a:	5d                   	pop    %rbp
>    2b:	5a                   	pop    %rdx
>    2c:	59                   	pop    %rcx
>    2d:	c3                   	ret
>    2e:	90                   	nop
>    2f:	90                   	nop
>    30:	90                   	nop
>    31:	90                   	nop
>    32:	8d 76 00             	lea    0x0(%rsi),%esi
>    35:	58                   	pop    %rax
>    36:	b8 77 00 00 00       	mov    $0x77,%eax
>    3b:	cd 80                	int    $0x80
>    3d:	90                   	nop
>    3e:	8d                   	.byte 0x8d
>    3f:	76                   	.byte 0x76
>
> Code starting with the faulting instruction
> ===========================================
>     0:	5d                   	pop    %rbp
>     1:	5a                   	pop    %rdx
>     2:	59                   	pop    %rcx
>     3:	c3                   	ret
>     4:	90                   	nop
>     5:	90                   	nop
>     6:	90                   	nop
>     7:	90                   	nop
>     8:	8d 76 00             	lea    0x0(%rsi),%esi
>     b:	58                   	pop    %rax
>     c:	b8 77 00 00 00       	mov    $0x77,%eax
>    11:	cd 80                	int    $0x80
>    13:	90                   	nop
>    14:	8d                   	.byte 0x8d
>    15:	76                   	.byte 0x76
> [   13.525624][  T189] EAX: ffffffda EBX: 00000011 ECX: bfdf5450 EDX: 00000000
> [   13.526233][  T189] ESI: b7c46000 EDI: bfdf54ac EBP: bfdf54a8 ESP: bfdf5440
> [   13.526853][  T189] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000286
> [   13.527519][  T189] Modules linked in: i2c_piix4(+) agpgart(+) qemu_fw_cfg button fuse drm drm_panel_orientation_quirks ip_tables
> [   13.528566][  T194] Oops: invalid opcode: 0000 [#2] PREEMPT SMP
> [   13.528804][  T189] ---[ end trace 0000000000000000 ]---
> [   13.529217][  T194] CPU: 1 PID: 194 Comm: systemctl Tainted: G      D            6.10.0-rc2-00258-g18f0423b9ecc #1
> [ 13.529725][ T189] EIP: usercopy_abort (mm/usercopy.c:102 (discriminator 12))
> [   13.530536][  T194] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [ 13.531060][ T189] Code: d6 89 44 24 0c 0f 45 cf 8b 7d 0c 89 74 24 10 89 4c 24 04 c7 04 24 a4 55 8a d6 89 7c 24 20 8b 7d 08 89 7c 24 1c e8 20 3c df ff <0f> 0b b8 80 91 d7 d6 e8 a8 de 68 00 ba 3d 17 86 d6 89 55 f0 89 d6
> All code
> ========
>     0:	d6                   	(bad)
>     1:	89 44 24 0c          	mov    %eax,0xc(%rsp)
>     5:	0f 45 cf             	cmovne %edi,%ecx
>     8:	8b 7d 0c             	mov    0xc(%rbp),%edi
>     b:	89 74 24 10          	mov    %esi,0x10(%rsp)
>     f:	89 4c 24 04          	mov    %ecx,0x4(%rsp)
>    13:	c7 04 24 a4 55 8a d6 	movl   $0xd68a55a4,(%rsp)
>    1a:	89 7c 24 20          	mov    %edi,0x20(%rsp)
>    1e:	8b 7d 08             	mov    0x8(%rbp),%edi
>    21:	89 7c 24 1c          	mov    %edi,0x1c(%rsp)
>    25:	e8 20 3c df ff       	call   0xffffffffffdf3c4a
>    2a:*	0f 0b                	ud2		<-- trapping instruction
>    2c:	b8 80 91 d7 d6       	mov    $0xd6d79180,%eax
>    31:	e8 a8 de 68 00       	call   0x68dede
>    36:	ba 3d 17 86 d6       	mov    $0xd686173d,%edx
>    3b:	89 55 f0             	mov    %edx,-0x10(%rbp)
>    3e:	89 d6                	mov    %edx,%esi
>
> Code starting with the faulting instruction
> ===========================================
>     0:	0f 0b                	ud2
>     2:	b8 80 91 d7 d6       	mov    $0xd6d79180,%eax
>     7:	e8 a8 de 68 00       	call   0x68deb4
>     c:	ba 3d 17 86 d6       	mov    $0xd686173d,%edx
>    11:	89 55 f0             	mov    %edx,-0x10(%rbp)
>    14:	89 d6                	mov    %edx,%esi
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240616/202406161539.b5ff7b20-oliver.sang@intel.com
>
>
>


