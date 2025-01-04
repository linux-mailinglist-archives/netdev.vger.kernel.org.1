Return-Path: <netdev+bounces-155189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1BFA01661
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 19:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3549C3A355F
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 18:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE101CD1EA;
	Sat,  4 Jan 2025 18:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTE4UzRP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6924923CB;
	Sat,  4 Jan 2025 18:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736015936; cv=none; b=rkc+PzR5XXoS6TViPiTfo5XN8uTMqLxjXtIq5QVDrlViCjvjogzCTUB9iqm0rN4PQox67tg1xBdTfQeZn6ePsiUnMQIbY/NmwdtrGfFuD3WPlacmLgJhuXHB1TTgKkoJ9r2Jyf+5jiyd1NWmeJ580aVLFmar3zw5ne2kCg30HVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736015936; c=relaxed/simple;
	bh=sMwWst1VaxlfgryvSvavR9svnM6hSEe/ZVod3oQR4RE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XHV036u0HTmASKB2Qq+BaE4xVDfJ7LQrMw3HMWvi7X908wQaKyJQNlzXGw/0iSTrwcCEUEjZ0HFb+7VAfzUwRtviKzcC+VD3XZVCK/+FpaZ2RE/qGjWfj/oiWWLCi3mshNtwAL2PSOZ0n7E40WAS4n+Bph6+h6xmo+A71rvscJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTE4UzRP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05EB2C4CED1;
	Sat,  4 Jan 2025 18:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736015936;
	bh=sMwWst1VaxlfgryvSvavR9svnM6hSEe/ZVod3oQR4RE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dTE4UzRPRnRbYoDiSQnfF56FIybZpAjUD/RxJpmbdcvEFF2r1bv6eCwfhE7QaJg7z
	 VHXd62dYXsXwqWQRHSjXsiQgpOsEo/ydKTT+JLaxsjfAqd13P6AIzhEHKWiYfawbHD
	 2MFDnZOQ3G/lPyohkDkqVdSC45VXLzmDyrfHYbhnYsqMo+yDgUg1rJvjw4kzPmyWe2
	 vPugKDlegq+eNacr01FV/tyMzxXYBVnagC/3JUbVR8yA17eDIW0fPV1pvPQpyrQkvJ
	 dPDzu9KBwGDbYbkHUH4iR7yQesPqXnlNc0aaeayGlWzYFuo7QE64D3ZIS/2b1tpKw0
	 omrjPbAUInb4g==
Message-ID: <cf187558-63d0-4375-8fb2-2cfa8bb8fa03@kernel.org>
Date: Sat, 4 Jan 2025 19:38:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [syzbot] [mptcp?] general protection fault in proc_scheduler
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, geliang@kernel.org, horms@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, martineau@kernel.org,
 mptcp@lists.linux.dev, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com,
 syzbot <syzbot+e364f774c6f57f2c86d1@syzkaller.appspotmail.com>,
 Al Viro <viro@zeniv.linux.org.uk>
References: <67769ecb.050a0220.3a8527.003f.GAE@google.com>
 <CANn89iKVTgzr8kt2sScrfoSbBSGMtLLqEwmA+WFFYUfV-PS--w@mail.gmail.com>
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CANn89iKVTgzr8kt2sScrfoSbBSGMtLLqEwmA+WFFYUfV-PS--w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Eric,

Thank you for the bug report!

On 02/01/2025 16:21, Eric Dumazet wrote:
> On Thu, Jan 2, 2025 at 3:12 PM syzbot
> <syzbot+e364f774c6f57f2c86d1@syzkaller.appspotmail.com> wrote:
>>
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    ccb98ccef0e5 Merge tag 'platform-drivers-x86-v6.13-4' of g..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=128f6ac4580000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=86dd15278dbfe19f
>> dashboard link: https://syzkaller.appspot.com/bug?extid=e364f774c6f57f2c86d1
>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1245eaf8580000
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/d24eb225cff7/disk-ccb98cce.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/dd81532f8240/vmlinux-ccb98cce.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/18b08e4bbf40/bzImage-ccb98cce.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+e364f774c6f57f2c86d1@syzkaller.appspotmail.com
>>
>> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN PTI
>> KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
>> CPU: 1 UID: 0 PID: 5924 Comm: syz-executor Not tainted 6.13.0-rc5-syzkaller-00004-gccb98ccef0e5 #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
>> RIP: 0010:proc_scheduler+0xc6/0x3c0 net/mptcp/ctrl.c:125
>> Code: 03 42 80 3c 38 00 0f 85 fe 02 00 00 4d 8b a4 24 08 09 00 00 48 b8 00 00 00 00 00 fc ff df 49 8d 7c 24 28 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 cc 02 00 00 4d 8b 7c 24 28 48 8d 84 24 c8 00 00
>> RSP: 0018:ffffc900034774e8 EFLAGS: 00010206
>>
>> RAX: dffffc0000000000 RBX: 1ffff9200068ee9e RCX: ffffc90003477620
>> RDX: 0000000000000005 RSI: ffffffff8b08f91e RDI: 0000000000000028
>> RBP: 0000000000000001 R08: ffffc90003477710 R09: 0000000000000040
>> R10: 0000000000000040 R11: 00000000726f7475 R12: 0000000000000000
>> R13: ffffc90003477620 R14: ffffc90003477710 R15: dffffc0000000000
>> FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007fee3cd452d8 CR3: 000000007d116000 CR4: 00000000003526f0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>  <TASK>
>>  proc_sys_call_handler+0x403/0x5d0 fs/proc/proc_sysctl.c:601
>>  __kernel_write_iter+0x318/0xa80 fs/read_write.c:612
>>  __kernel_write+0xf6/0x140 fs/read_write.c:632
>>  do_acct_process+0xcb0/0x14a0 kernel/acct.c:539
>>  acct_pin_kill+0x2d/0x100 kernel/acct.c:192
>>  pin_kill+0x194/0x7c0 fs/fs_pin.c:44
>>  mnt_pin_kill+0x61/0x1e0 fs/fs_pin.c:81
>>  cleanup_mnt+0x3ac/0x450 fs/namespace.c:1366
>>  task_work_run+0x14e/0x250 kernel/task_work.c:239
>>  exit_task_work include/linux/task_work.h:43 [inline]
>>  do_exit+0xad8/0x2d70 kernel/exit.c:938
>>  do_group_exit+0xd3/0x2a0 kernel/exit.c:1087
>>  get_signal+0x2576/0x2610 kernel/signal.c:3017
>>  arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
>>  exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
>>  exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
>>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>>  syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
>>  do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> RIP: 0033:0x7fee3cb87a6a
>> Code: Unable to access opcode bytes at 0x7fee3cb87a40.
>> RSP: 002b:00007fffcccac688 EFLAGS: 00000202 ORIG_RAX: 0000000000000037
>> RAX: 0000000000000000 RBX: 00007fffcccac710 RCX: 00007fee3cb87a6a
>> RDX: 0000000000000041 RSI: 0000000000000000 RDI: 0000000000000003
>> RBP: 0000000000000003 R08: 00007fffcccac6ac R09: 00007fffcccacac7
>> R10: 00007fffcccac710 R11: 0000000000000202 R12: 00007fee3cd49500
>> R13: 00007fffcccac6ac R14: 0000000000000000 R15: 00007fee3cd4b000
>>  </TASK>
>> Modules linked in:
>> ---[ end trace 0000000000000000 ]---
>> RIP: 0010:proc_scheduler+0xc6/0x3c0 net/mptcp/ctrl.c:125
>> Code: 03 42 80 3c 38 00 0f 85 fe 02 00 00 4d 8b a4 24 08 09 00 00 48 b8 00 00 00 00 00 fc ff df 49 8d 7c 24 28 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 cc 02 00 00 4d 8b 7c 24 28 48 8d 84 24 c8 00 00
>> RSP: 0018:ffffc900034774e8 EFLAGS: 00010206
>> RAX: dffffc0000000000 RBX: 1ffff9200068ee9e RCX: ffffc90003477620
>> RDX: 0000000000000005 RSI: ffffffff8b08f91e RDI: 0000000000000028
>> RBP: 0000000000000001 R08: ffffc90003477710 R09: 0000000000000040
>> R10: 0000000000000040 R11: 00000000726f7475 R12: 0000000000000000
>> R13: ffffc90003477620 R14: ffffc90003477710 R15: dffffc0000000000
>> FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007fee3cd452d8 CR3: 000000007d116000 CR4: 00000000003526f0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> ----------------
>> Code disassembly (best guess), 1 bytes skipped:
>>    0:   42 80 3c 38 00          cmpb   $0x0,(%rax,%r15,1)
>>    5:   0f 85 fe 02 00 00       jne    0x309
>>    b:   4d 8b a4 24 08 09 00    mov    0x908(%r12),%r12
>>   12:   00
>>   13:   48 b8 00 00 00 00 00    movabs $0xdffffc0000000000,%rax
>>   1a:   fc ff df
>>   1d:   49 8d 7c 24 28          lea    0x28(%r12),%rdi
>>   22:   48 89 fa                mov    %rdi,%rdx
>>   25:   48 c1 ea 03             shr    $0x3,%rdx
>> * 29:   80 3c 02 00             cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
>>   2d:   0f 85 cc 02 00 00       jne    0x2ff
>>   33:   4d 8b 7c 24 28          mov    0x28(%r12),%r15
>>   38:   48                      rex.W
>>   39:   8d                      .byte 0x8d
>>   3a:   84 24 c8                test   %ah,(%rax,%rcx,8)

(...)

> I thought acct(2) was only allowing regular files.
> 
> acct_on() indeed has :
> 
> if (!S_ISREG(file_inode(file)->i_mode)) {
>     kfree(acct);
>     filp_close(file, NULL);
>     return -EACCES;
> }
> 
> It seems there are other ways to call do_acct_process() targeting a sysfs file ?

Just to be sure I'm not misunderstanding your comment: do you mean that
here, the issue is *not* in MPTCP code where we get the 'struct net'
pointer via 'current->nsproxy->net_ns', but in the FS part, right?

Here, we have an issue because 'current->nsproxy' is NULL, but is it
normal? Or should we simply exit with an error if it is the case because
we are in an exiting phase?

I'm just a bit confused, because it looks like 'net' is retrieved from
different places elsewhere when dealing with sysfs: some get it from
'current' like us, some assign 'net' to 'table->extra2', others get it
from 'table->data' (via a container_of()), etc. Maybe we should not use
'current->nsproxy->net_ns' here then?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


