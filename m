Return-Path: <netdev+bounces-229803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE75BE0EEF
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 00:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27B8018824F6
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 22:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063F22BDC02;
	Wed, 15 Oct 2025 22:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YhNzBTnG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEB719F48D;
	Wed, 15 Oct 2025 22:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567444; cv=none; b=EOWivhQt3OUyzWa8XFvYRapCCAsSPPhsSfCkNU7dYZfhzwtM3pLyfvI7sXUasaYEmXjQftbnyJl2NSkyCAHaIK2bzQ+UlGiCn2v7gBc6BX98aooA5qfXR2PM63OKUnNeoABSt396Riw0I0yC6L4LcLf8cnqz1xtiopEOUfedlwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567444; c=relaxed/simple;
	bh=1h0KCYOu9WSeyH7MSt/68v3aZ3T34B2LgMeFa18yPx0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qebWYVrRf6TGwS2UL7qCkIJQ/mQfjvxP3dx+QqECHvZWV9661+UxvoxiQbuOugZXBfjCV/lJVcagg5XIA7LVWBP4wi7KxZ08hWXHovAxg6emVepZFIjJgdCBtwp9++dDaaef0sPnjYrTylxHNzwpH8zS+s47TDjJH+S27EXWyW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YhNzBTnG; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760567443; x=1792103443;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=1h0KCYOu9WSeyH7MSt/68v3aZ3T34B2LgMeFa18yPx0=;
  b=YhNzBTnGIysctLzNYcepl4qSOex1dX+WLWuybH+rYzlTmiwZYE7zkFgV
   vK1K/r8g9DiWvxm+J1qAGlYtPFdI3NMdbf7qGo82MJ+WsFij6sD1wOtca
   v9cOstYcE3XCkW6Nur+DFDW4g8Qwl0gIW9yPZmVde8NWWypMEZcWXwCBN
   SSV/iHw+6lR5C3DM2xPF39D8mnjKzd0NZ1E/vjbxYrlVyH5vGG0fmzC2R
   LCJtIoiv1SJRn1IKT3hfg0j41tXcOs78dmZis4esdh9Mu+8F/TeNNPw4d
   ArNw9SkFAhwmTPBpcfkE3HqNebY4PvlT/3rgBhKjn96o9SbrGsPWQrhs7
   w==;
X-CSE-ConnectionGUID: 5ZLSGV7USpaI2Ciu9kVDqA==
X-CSE-MsgGUID: WbmSjkr0RjmB9fa9KTMDLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="62847709"
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="62847709"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 15:30:41 -0700
X-CSE-ConnectionGUID: APsH6AFSQ5myC0E1wECDyg==
X-CSE-MsgGUID: BK+OjphCSOKh9XSAvBWvrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="181841528"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.88.27.140])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 15:30:41 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Eric Dumazet <edumazet@google.com>, syzbot
 <syzbot+51cd74c5dfeafd65e488@syzkaller.appspotmail.com>,
 davem@davemloft.net, dsahern@kernel.org, hdanton@sina.com,
 horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Subject: Re: [syzbot] [net?] [mm?] INFO: rcu detected stall in
 inet_rtm_newaddr (2)
In-Reply-To: <CAM0EoMnWcsgtN++zkOW9zf5QqUg9uNBGTNgf=2JARqarW31wwQ@mail.gmail.com>
References: <681a1770.050a0220.a19a9.000d.GAE@google.com>
 <68ea0a24.050a0220.91a22.01ca.GAE@google.com>
 <CANn89iLjjtXV3ZMxfQDb1bbsVJ6a_Chexu4FwqeejxGTwsR_kg@mail.gmail.com>
 <CAM0EoMnGLqKU7AnsgS00SEgU0eq71f-kiqNniCNyfiyAfNm8og@mail.gmail.com>
 <87347mmpwp.fsf@intel.com>
 <CAM0EoMnWcsgtN++zkOW9zf5QqUg9uNBGTNgf=2JARqarW31wwQ@mail.gmail.com>
Date: Wed, 15 Oct 2025 15:30:58 -0700
Message-ID: <87ms5rlrvh.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jamal Hadi Salim <jhs@mojatatu.com> writes:

> On Mon, Oct 13, 2025 at 5:51=E2=80=AFPM Vinicius Costa Gomes
> <vinicius.gomes@intel.com> wrote:
>>
>> Jamal Hadi Salim <jhs@mojatatu.com> writes:
>>
>> > On Sat, Oct 11, 2025 at 5:42=E2=80=AFAM Eric Dumazet <edumazet@google.=
com> wrote:
>> >>
>> >> On Sat, Oct 11, 2025 at 12:41=E2=80=AFAM syzbot
>> >> <syzbot+51cd74c5dfeafd65e488@syzkaller.appspotmail.com> wrote:
>> >> >
>> >> > syzbot has found a reproducer for the following issue on:
>> >> >
>> >> > HEAD commit:    18a7e218cfcd Merge tag 'net-6.18-rc1' of git://git.=
kernel...
>> >> > git tree:       net-next
>> >> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D12504dc=
d980000
>> >> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D61ab7fa=
743df0ec1
>> >> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D51cd74c5d=
feafd65e488
>> >> > compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f9=
09b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
>> >> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D14d2a=
542580000
>> >> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D142149e=
2580000
>> >> >
>> >> > Downloadable assets:
>> >> > disk image: https://storage.googleapis.com/syzbot-assets/7a01e6dce9=
7e/disk-18a7e218.raw.xz
>> >> > vmlinux: https://storage.googleapis.com/syzbot-assets/5e1b7e41427f/=
vmlinux-18a7e218.xz
>> >> > kernel image: https://storage.googleapis.com/syzbot-assets/69b55860=
1209/bzImage-18a7e218.xz
>> >> >
>> >> > IMPORTANT: if you fix the issue, please add the following tag to th=
e commit:
>> >> > Reported-by: syzbot+51cd74c5dfeafd65e488@syzkaller.appspotmail.com
>> >> >
>> >> > sched: DL replenish lagged too much
>> >> > rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>> >> > rcu:    0-...!: (2 GPs behind) idle=3D7754/1/0x4000000000000000 sof=
tirq=3D15464/15465 fqs=3D1
>> >> > rcu:    (detected by 1, t=3D10502 jiffies, g=3D11321, q=3D371 ncpus=
=3D2)
>> >> > Sending NMI from CPU 1 to CPUs 0:
>> >> > NMI backtrace for cpu 0
>> >> > CPU: 0 UID: 0 PID: 5948 Comm: syz-executor Not tainted syzkaller #0=
 PREEMPT(full)
>> >> > Hardware name: Google Google Compute Engine/Google Compute Engine, =
BIOS Google 10/02/2025
>> >> > RIP: 0010:rb_insert_color_cached include/linux/rbtree.h:113 [inline]
>> >> > RIP: 0010:rb_add_cached include/linux/rbtree.h:183 [inline]
>> >> > RIP: 0010:timerqueue_add+0x1a8/0x200 lib/timerqueue.c:40
>> >> > Code: e7 31 f6 e8 6a 0c de f6 42 80 3c 2b 00 74 08 4c 89 f7 e8 7b 0=
a de f6 4d 89 26 4d 8d 7e 08 4c 89 f8 48 c1 e8 03 42 80 3c 28 00 <74> 08 4c=
 89 ff e8 5e 0a de f6 4d 89 27 4d 85 e4 40 0f 95 c5 eb 07
>> >> > RSP: 0018:ffffc90000007cf0 EFLAGS: 00000046
>> >> > RAX: 1ffff110170c4f83 RBX: 1ffff110170c4f82 RCX: 0000000000000000
>> >> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88805de72358
>> >> > RBP: 0000000000000000 R08: ffff88805de72357 R09: 0000000000000000
>> >> > R10: ffff88805de72340 R11: ffffed100bbce46b R12: ffff88805de72340
>> >> > R13: dffffc0000000000 R14: ffff8880b8627c10 R15: ffff8880b8627c18
>> >> > FS:  000055557c657500(0000) GS:ffff888125d0f000(0000) knlGS:0000000=
000000000
>> >> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> >> > CR2: 0000200000000600 CR3: 000000002ee76000 CR4: 00000000003526f0
>> >> > Call Trace:
>> >> >  <IRQ>
>> >> >  __run_hrtimer kernel/time/hrtimer.c:1794 [inline]
>> >> >  __hrtimer_run_queues+0x656/0xc60 kernel/time/hrtimer.c:1841
>> >> >  hrtimer_interrupt+0x45b/0xaa0 kernel/time/hrtimer.c:1903
>> >> >  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1041 [inlin=
e]
>> >> >  __sysvec_apic_timer_interrupt+0x108/0x410 arch/x86/kernel/apic/api=
c.c:1058
>> >> >  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1052=
 [inline]
>> >> >  sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:=
1052
>> >> >  </IRQ>
>> >> >  <TASK>
>> >> >  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idt=
entry.h:702
>> >> > RIP: 0010:pv_vcpu_is_preempted arch/x86/include/asm/paravirt.h:579 =
[inline]
>> >> > RIP: 0010:vcpu_is_preempted arch/x86/include/asm/qspinlock.h:63 [in=
line]
>> >> > RIP: 0010:owner_on_cpu include/linux/sched.h:2282 [inline]
>> >> > RIP: 0010:mutex_spin_on_owner+0x189/0x360 kernel/locking/mutex.c:361
>> >> > Code: b6 04 30 84 c0 0f 85 59 01 00 00 48 8b 44 24 08 8b 18 48 8b 4=
4 24 48 42 80 3c 30 00 74 0c 48 c7 c7 90 8c fa 8d e8 a7 cd 88 00 <48> 83 3d=
 ff 27 5e 0c 00 0f 84 b9 01 00 00 48 89 df e8 41 e0 d5 ff
>> >> > RSP: 0018:ffffc900034c7428 EFLAGS: 00000246
>> >> > RAX: 1ffffffff1bf5192 RBX: 0000000000000001 RCX: ffffffff819c6588
>> >> > RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff8f4df8a0
>> >> > RBP: 1ffffffff1e9bf14 R08: ffffffff8f4df8a7 R09: 1ffffffff1e9bf14
>> >> > R10: dffffc0000000000 R11: fffffbfff1e9bf15 R12: ffffffff8f4df8a0
>> >> > R13: ffffffff8f4df8f0 R14: dffffc0000000000 R15: ffff8880267a9e40
>> >> >  mutex_optimistic_spin kernel/locking/mutex.c:464 [inline]
>> >> >  __mutex_lock_common kernel/locking/mutex.c:602 [inline]
>> >> >  __mutex_lock+0x311/0x1350 kernel/locking/mutex.c:760
>> >> >  rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
>> >> >  inet_rtm_newaddr+0x3b0/0x18b0 net/ipv4/devinet.c:978
>> >> >  rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6954
>> >> >  netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2552
>> >> >  netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
>> >> >  netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
>> >> >  netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
>> >> >  sock_sendmsg_nosec net/socket.c:727 [inline]
>> >> >  __sock_sendmsg+0x21c/0x270 net/socket.c:742
>> >> >  __sys_sendto+0x3bd/0x520 net/socket.c:2244
>> >> >  __do_sys_sendto net/socket.c:2251 [inline]
>> >> >  __se_sys_sendto net/socket.c:2247 [inline]
>> >> >  __x64_sys_sendto+0xde/0x100 net/socket.c:2247
>> >> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>> >> >  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>> >> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> >> > RIP: 0033:0x7faade790d5c
>> >> > Code: 2a 5f 02 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54 24 2=
8 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00=
 f0 ff ff 77 34 89 ef 48 89 44 24 08 e8 70 5f 02 00 48 8b
>> >> > RSP: 002b:00007ffdd2e3b670 EFLAGS: 00000293 ORIG_RAX: 0000000000000=
02c
>> >> > RAX: ffffffffffffffda RBX: 00007faadf514620 RCX: 00007faade790d5c
>> >> > RDX: 0000000000000028 RSI: 00007faadf514670 RDI: 0000000000000003
>> >> > RBP: 0000000000000000 R08: 00007ffdd2e3b6c4 R09: 000000000000000c
>> >> > R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
>> >> > R13: 0000000000000000 R14: 00007faadf514670 R15: 0000000000000000
>> >> >  </TASK>
>> >> > rcu: rcu_preempt kthread timer wakeup didn't happen for 10499 jiffi=
es! g11321 f0x0 RCU_GP_WAIT_FQS(5) ->state=3D0x402
>> >> > rcu:    Possible timer handling issue on cpu=3D0 timer-softirq=3D42=
86
>> >> > rcu: rcu_preempt kthread starved for 10500 jiffies! g11321 f0x0 RCU=
_GP_WAIT_FQS(5) ->state=3D0x402 ->cpu=3D0
>> >> > rcu:    Unless rcu_preempt kthread gets sufficient CPU time, OOM is=
 now expected behavior.
>> >> > rcu: RCU grace-period kthread stack dump:
>> >> > task:rcu_preempt     state:I stack:27224 pid:16    tgid:16    ppid:=
2      task_flags:0x208040 flags:0x00080000
>> >> > Call Trace:
>> >> >  <TASK>
>> >> >  context_switch kernel/sched/core.c:5325 [inline]
>> >> >  __schedule+0x1798/0x4cc0 kernel/sched/core.c:6929
>> >> >  __schedule_loop kernel/sched/core.c:7011 [inline]
>> >> >  schedule+0x165/0x360 kernel/sched/core.c:7026
>> >> >  schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
>> >> >  rcu_gp_fqs_loop+0x301/0x1540 kernel/rcu/tree.c:2083
>> >> >  rcu_gp_kthread+0x99/0x390 kernel/rcu/tree.c:2285
>> >> >  kthread+0x711/0x8a0 kernel/kthread.c:463
>> >> >  ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
>> >> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>> >> >  </TASK>
>> >> >
>> >> >
>> >> > ---
>> >> > If you want syzbot to run the reproducer, reply with:
>> >> > #syz test: git://repo/address.git branch-or-commit-hash
>> >> > If you attach or paste a git patch, syzbot will apply it before tes=
ting.
>> >>
>> >> Yet another taprio report.
>> >>
>> >> If taprio can not be fixed, perhaps we should remove it from the
>> >> kernel, or clearly marked as broken.
>> >> (Then ask syzbot to no longer include it)
>> >
>> > Agreed on the challenge with taprio.
>> > We need the stakeholders input: Vinicius - are you still working in
>> > this space? Vladimir you also seem to have interest (or maybe nxp
>> > does) in this?
>>
>> No, I am not working on this space anymore.
>>
>> I will talk with other Intel folks (and my manager) and see what we can
>> do.
>
> I assume your customers are still interested in this working? If yes,
> that would be a good pitch to the manager.

I did talk with some people here, and let's just say that I am hearing
positive noises. So chances are that I should be able to dedicate some
of my "job time" to this area again.

> In my (extreme) view, another selling point is that there is an
> ethical obligation to ensure things continue to work as intended.
> Getting patches in is the easy part.
>
> cheers,
> jamal
>
>>But if others that find it useful can help even better.
>>
>


Cheers,
--=20
Vinicius

