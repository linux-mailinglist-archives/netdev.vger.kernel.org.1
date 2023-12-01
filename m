Return-Path: <netdev+bounces-53083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B63F68013AF
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 20:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECE38B20DBB
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 19:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E527C51C21;
	Fri,  1 Dec 2023 19:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BT0zJIR7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D6DD6C
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 11:48:57 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3316d855828so454072f8f.0
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 11:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701460136; x=1702064936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7DYNr85oL/bh4o+/XuwLjGJ0LzCVEfjk2QS9LtgDnag=;
        b=BT0zJIR7MgIHJFRhVXsen6CloaRUa3onMCGPcJBZsZnB/MHHDv5scqJvqP6bDfXB/U
         rcF4vh5Fc2c0xfI13PmID/DbqbkRQ+wCIBtLXY1sipJ/Cg6XlAVBQwsEiNsgivkOsBQu
         u8o3E7L2N35dAYDLC8vxOQx39TxV+daCEAeyfZJdPfukQH6NvQo8AhmKozHx1hLh1EWM
         txjln9vwgMmxRhnTQwh00fCqIYGIcHa3eIz0clogOjw2uM9Fj9QFx4naUiH6R7xXnW/e
         AF2a85qAxKzuAslVdM5UNcjk/RYRJ7GxsxfabyQWczsfBUW4VxXmhSixNt7TvkQopoXu
         4y6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701460136; x=1702064936;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7DYNr85oL/bh4o+/XuwLjGJ0LzCVEfjk2QS9LtgDnag=;
        b=unVKh+DOxuWT3nS3Py9guqssivaE39mQblGm9MsG3Ak6vG8IcJbRODzmAPoEQw4RRa
         SuMM6JNDesV8iLIfvCusQqevQ+gSYiXGLwSj6dN8xA4/Mu/ZGsBLBwhTDKzqa2A2PycV
         M9qT6Gbutep5o+y/UlZaJE5wGW7LZVMkznbJTr3Z+AMG6YBOHC0ZWGG/VMsg0rbdRWXF
         aZTDE8GYl56AYPh+NDGxmYaScfPuVIW5FQOjrgUmZFOEpoVX/5p+lcJCbiD3qpxhHMA0
         DVkKkcHmxEK9+cMYVKUdWND5uPd2jZRDbIUpmxqYhfcoU4DNg01q6jHsToEfKDuMD0KX
         X1gQ==
X-Gm-Message-State: AOJu0Yx25tPPVQ1i1wwB7BDWD+rPRlr3BiblLmwgBHYHYZUjxb/pOsXI
	9AAFbV6cqUVIsIrFlAMVWBc=
X-Google-Smtp-Source: AGHT+IHH8ObzrIfo9rMh28/rkZ9RF2Bs6lBVsO/KSqKz4xuzETNQY3h92PhVUlT+J/MWsLML3qdrTA==
X-Received: by 2002:a5d:5889:0:b0:333:362e:8416 with SMTP id n9-20020a5d5889000000b00333362e8416mr441579wrf.0.1701460135896;
        Fri, 01 Dec 2023 11:48:55 -0800 (PST)
Received: from [10.0.0.4] ([37.170.89.160])
        by smtp.gmail.com with ESMTPSA id x7-20020a5d6507000000b003296b488961sm4948059wru.31.2023.12.01.11.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 11:48:55 -0800 (PST)
Message-ID: <a85c596f-6cda-4d34-85e8-4645c41515bc@gmail.com>
Date: Fri, 1 Dec 2023 20:48:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: [syzbot] [net?] INFO: rcu detected stall in sys_socket (10)
Content-Language: en-US
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Jakub Kicinski <kuba@kernel.org>,
 Linux Kernel Network Developers <netdev@vger.kernel.org>, edumazet@google.com
References: <00000000000077c77f060b603f2d@google.com>
 <CAM0EoMkAxx+JwLxc_T0jJd3+jZmoSTndLKC6Ap7qYwd58A5Zmg@mail.gmail.com>
 <87il5i7pc2.fsf@intel.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <87il5i7pc2.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/1/23 01:12, Vinicius Costa Gomes wrote:
> Jamal Hadi Salim <jhs@mojatatu.com> writes:
>
>> Vinicius/Vladmir,
>> I pinged you on this already. Can you take a look please? There is a
>> reproducer..
>>
> It seems to be another one of those, syzkaller managed to produce a
> schedule with a small enough interval that it's going to starve some
> other things. (in this case, the interval is 127 ns)
>
> We already reject intervals that won't allow the passage of the smallest
> ethernet packet. I am running out of ideas that we could do to, at least
> at configuration time.
>
> But one almost crazy idea turned up: what if we only start the timer
> when there are actually packets in the qdisc? i.e. if the queue was
> empty, we would only start the timer during "empty -> non-empty"
> enqueue(), and stop the timer when the queue goes back to empty.
>
> I think that way, we remove the issue that causes most of the syzkaller
> reports, and we would reduce the CPU overhead when taprio is idle (on a
> non-debug system with the problematic schedule I am seeing ~2% overhead
> in perf top).
>
> Does that sound like it could work?

It seems this is a periodic timer with a fix value ?

And a packet can sit in taprio for a long time if skb->tstamp is far away,

you can be sure syzbot will know how to feed such delayed packets.

It is unclear why a short timer is reset regardless of what progress can 
be done during this period.

net/sched/sch_fq.c only arms a timer based on the earliest time we can 
make forward progress.

This taprio bug is causing many syzbot reports, with different signatures.

Thanks.



>
>> cheers,
>> jamal
>>
>> ---------- Forwarded message ---------
>> From: syzbot <syzbot+de8e83db70e8beedd556@syzkaller.appspotmail.com>
>> Date: Thu, Nov 30, 2023 at 10:24 AM
>> Subject: [syzbot] [net?] INFO: rcu detected stall in sys_socket (10)
>> To: <bp@alien8.de>, <davem@davemloft.net>, <edumazet@google.com>,
>> <hpa@zytor.com>, <jhs@mojatatu.com>, <jiri@resnulli.us>,
>> <kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
>> <netdev@vger.kernel.org>, <pabeni@redhat.com>,
>> <syzkaller-bugs@googlegroups.com>, <tglx@linutronix.de>,
>> <vinicius.gomes@intel.com>, <willemdebruijn.kernel@gmail.com>,
>> <x86@kernel.org>, <xiyou.wangcong@gmail.com>
>>
>>
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    18d46e76d7c2 Merge tag 'for-6.7-rc3-tag' of git://git.kern..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=16bcc8b4e80000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=bb39fe85d254f638
>> dashboard link: https://syzkaller.appspot.com/bug?extid=de8e83db70e8beedd556
>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils
>> for Debian) 2.40
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12172952e80000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1086b58ae80000
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/0ce5608c89e8/disk-18d46e76.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/eef847faba9c/vmlinux-18d46e76.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/6a3df3288860/bzImage-18d46e76.xz
>>
>> The issue was bisected to:
>>
>> commit 5a781ccbd19e4664babcbe4b4ead7aa2b9283d22
>> Author: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>> Date:   Sat Sep 29 00:59:43 2018 +0000
>>
>>      tc: Add support for configuring the taprio scheduler
>>
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16a29b52e80000
>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=15a29b52e80000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=11a29b52e80000
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+de8e83db70e8beedd556@syzkaller.appspotmail.com
>> Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")
>>
>> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>> rcu:    0-...!: (1 GPs behind) idle=79f4/1/0x4000000000000000
>> softirq=5546/5548 fqs=1
>> rcu:    (detected by 1, t=10503 jiffies, g=5017, q=384 ncpus=2)
>> Sending NMI from CPU 1 to CPUs 0:
>> NMI backtrace for cpu 0
>> CPU: 0 PID: 5106 Comm: syz-executor201 Not tainted
>> 6.7.0-rc3-syzkaller-00024-g18d46e76d7c2 #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine,
>> BIOS Google 11/10/2023
>> RIP: 0010:__run_hrtimer kernel/time/hrtimer.c:1686 [inline]
>> RIP: 0010:__hrtimer_run_queues+0x62e/0xc20 kernel/time/hrtimer.c:1752
>> Code: fc ff df 48 89 fa 48 c1 ea 03 0f b6 04 02 48 89 fa 83 e2 07 38
>> d0 7f 08 84 c0 0f 85 fb 04 00 00 45 0f b6 6e 3b 31 ff 44 89 ee <e8> 2d
>> 46 11 00 45 84 ed 0f 84 8e fb ff ff e8 ef 4a 11 00 4c 89 f7
>> RSP: 0018:ffffc90000007e40 EFLAGS: 00000046
>> RAX: 0000000000000000 RBX: ffff8880b982ba40 RCX: ffffffff817642f9
>> RDX: 0000000000000003 RSI: 0000000000000000 RDI: 0000000000000000
>> RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
>> R10: 0000000000000001 R11: 0000000000000002 R12: ffff8880b982b940
>> R13: 0000000000000000 R14: ffff88801c43a340 R15: ffffffff88a2daf0
>> FS:  00005555566fe380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007fe9404c73b0 CR3: 0000000076e2d000 CR4: 0000000000350ef0
>> Call Trace:
>>   <NMI>
>>   </NMI>
>>   <IRQ>
>>   hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1814
>>   local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1065 [inline]
>>   __sysvec_apic_timer_interrupt+0x105/0x400 arch/x86/kernel/apic/apic.c:1082
>>   sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1076
>>   </IRQ>
>>   <TASK>
>>   asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
>> RIP: 0010:lock_acquire+0x1ef/0x520 kernel/locking/lockdep.c:5722
>> Code: c1 05 bd 6c 9a 7e 83 f8 01 0f 85 b4 02 00 00 9c 58 f6 c4 02 0f
>> 85 9f 02 00 00 48 85 ed 74 01 fb 48 b8 00 00 00 00 00 fc ff df <48> 01
>> c3 48 c7 03 00 00 00 00 48 c7 43 08 00 00 00 00 48 8b 84 24
>> RSP: 0018:ffffc9000432fb00 EFLAGS: 00000206
>> RAX: dffffc0000000000 RBX: 1ffff92000865f62 RCX: ffffffff81672c0e
>> RDX: 0000000000000001 RSI: ffffffff8accbae0 RDI: ffffffff8b2f0dc0
>> RBP: 0000000000000200 R08: 0000000000000000 R09: fffffbfff23e33d0
>> R10: ffffffff91f19e87 R11: 0000000000000000 R12: 0000000000000001
>> R13: 0000000000000000 R14: ffffffff8d0f0b48 R15: 0000000000000000
>>   __mutex_lock_common kernel/locking/mutex.c:603 [inline]
>>   __mutex_lock+0x175/0x9d0 kernel/locking/mutex.c:747
>>   pcpu_alloc+0xbb8/0x1420 mm/percpu.c:1769
>>   packet_alloc_pending net/packet/af_packet.c:1232 [inline]
>>   packet_create+0x2b7/0x8e0 net/packet/af_packet.c:3373
>>   __sock_create+0x328/0x800 net/socket.c:1569
>>   sock_create net/socket.c:1620 [inline]
>>   __sys_socket_create net/socket.c:1657 [inline]
>>   __sys_socket+0x14c/0x260 net/socket.c:1704
>>   __do_sys_socket net/socket.c:1718 [inline]
>>   __se_sys_socket net/socket.c:1716 [inline]
>>   __x64_sys_socket+0x72/0xb0 net/socket.c:1716
>>   do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>>   do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
>>   entry_SYSCALL_64_after_hwframe+0x63/0x6b
>> RIP: 0033:0x7fe940479de9
>> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 d1 19 00 00 90 48 89 f8 48
>> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
>> 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
>> RSP: 002b:00007ffe1bf080b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000029
>> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe940479de9
>> RDX: 0000000000000000 RSI: 0000000800000003 RDI: 0000000000000011
>> RBP: 00000000000f4240 R08: 0000000000000000 R09: 0000000100000000
>> R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe1bf08110
>> R13: 0000000000030c67 R14: 00007ffe1bf080dc R15: 0000000000000003
>>   </TASK>
>> INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.067 msecs
>> rcu: rcu_preempt kthread timer wakeup didn't happen for 10497 jiffies!
>> g5017 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
>> rcu:    Possible timer handling issue on cpu=0 timer-softirq=2416
>> rcu: rcu_preempt kthread starved for 10498 jiffies! g5017 f0x0
>> RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=0
>> rcu:    Unless rcu_preempt kthread gets sufficient CPU time, OOM is
>> now expected behavior.
>> rcu: RCU grace-period kthread stack dump:
>> task:rcu_preempt     state:I stack:27904 pid:17    tgid:17    ppid:2
>>     flags:0x00004000
>> Call Trace:
>>   <TASK>
>>   context_switch kernel/sched/core.c:5376 [inline]
>>   __schedule+0xedb/0x5af0 kernel/sched/core.c:6688
>>   __schedule_loop kernel/sched/core.c:6763 [inline]
>>   schedule+0xe9/0x270 kernel/sched/core.c:6778
>>   schedule_timeout+0x137/0x290 kernel/time/timer.c:2167
>>   rcu_gp_fqs_loop+0x1ec/0xb10 kernel/rcu/tree.c:1631
>>   rcu_gp_kthread+0x24b/0x380 kernel/rcu/tree.c:1830
>>   kthread+0x2c6/0x3a0 kernel/kthread.c:388
>>   ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>>   ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
>>   </TASK>
>>
>>
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>>
>> If the report is already addressed, let syzbot know by replying with:
>> #syz fix: exact-commit-title
>>
>> If you want syzbot to run the reproducer, reply with:
>> #syz test: git://repo/address.git branch-or-commit-hash
>> If you attach or paste a git patch, syzbot will apply it before testing.
>>
>> If you want to overwrite report's subsystems, reply with:
>> #syz set subsystems: new-subsystem
>> (See the list of subsystem names on the web dashboard)
>>
>> If the report is a duplicate of another one, reply with:
>> #syz dup: exact-subject-of-another-report
>>
>> If you want to undo deduplication, reply with:
>> #syz undup

