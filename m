Return-Path: <netdev+bounces-156293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 253BAA05ED3
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 15:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDF647A04AC
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 14:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF6F1FC7C2;
	Wed,  8 Jan 2025 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLs48jKq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408A12594A2;
	Wed,  8 Jan 2025 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736347044; cv=none; b=PbTOLUqJttk+Kh4zY/1y5H43i9QjdeZJ4fNv780irAPuGadtt/QTScoJD7263RV5Vo0Qq3SIYVb9JtSAw1C/UE8y9hjhxFOEKz/vqajAAnDBiG+R2obmZqraSkjfYyMEsSM19WHf9XSh4XSy7akwWYW3vB3bH7kjHoE3UCeVRJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736347044; c=relaxed/simple;
	bh=ihLZzokW6wRzdZU9Jx6fuBaHZCJqqzdJzNqXk93o97U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sc7yfLb57g8CCRWqiiixZoXWVouatGEOYM/1KW+uDTbr0Uy4DLPtjtFsU1JonTnruiZ4i6/NLKeuWRkFcCC1elTux6jEmA1KQI3biIMdhpFM5gTmYz+R5/6SYv+4BbHPxvMIAsROAI5+Bs7e7GQ88lQShS+RI44hhucwPeth7K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLs48jKq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6664DC4CED3;
	Wed,  8 Jan 2025 14:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736347043;
	bh=ihLZzokW6wRzdZU9Jx6fuBaHZCJqqzdJzNqXk93o97U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sLs48jKqEw3ZIvx6xL7pR78fz5S1c0/ar12ehCzFOxfjh5ve7p3OhCSloPvUGVaTy
	 ZEdLweQPqjR6cI5o4a3sy0/KMEg3QGUst8a0Ej8x1r4P0sKfDt5e/CwBimh5OTMSiz
	 SVpIUUI2xlATcwTxAKqcSZBXl+ALBJn3LZwv6FUCUAEgqOhDhiks8zwX1Ok3atfSwV
	 bX+Tp5bYQiBe4KI0fvfjS/LU1C/StaAadmjEVxt6ZSwKQI5/ysj7vejRyFLqpsXXjU
	 RrU1Yrq3UurfrRuhyQgUyjtRuKPpMw+l7LrWdh5Z4ZJQaop1zc0F3sh3jGYx0tC+xP
	 cPokEhVTLqaJw==
Date: Wed, 8 Jan 2025 15:37:18 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	davem@davemloft.net, geliang@kernel.org, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martineau@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	syzbot <syzbot+e364f774c6f57f2c86d1@syzkaller.appspotmail.com>
Subject: Re: Re: [syzbot] [mptcp?] general protection fault in proc_scheduler
Message-ID: <5ua4fxtrg24iccyminv7s7whihmduhd73ure3smmpi2z755526@kmqye3etmoog>
References: <67769ecb.050a0220.3a8527.003f.GAE@google.com>
 <CANn89iKVTgzr8kt2sScrfoSbBSGMtLLqEwmA+WFFYUfV-PS--w@mail.gmail.com>
 <cf187558-63d0-4375-8fb2-2cfa8bb8fa03@kernel.org>
 <CANn89iJEMGYt4YVdGkyb-q81TQU+UBOQaX7jH-2zOqv-4SjZGg@mail.gmail.com>
 <7927eae8-4d26-4340-852a-b93fcf1eba89@kernel.org>
 <fewptpw6r5rspq3seygym7v5y2h2htomongyxbxio2x27cngac@ituf5et5db2b>
 <2b0bcf38-5408-4268-bb69-cbea2b250521@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b0bcf38-5408-4268-bb69-cbea2b250521@kernel.org>

On Mon, Jan 06, 2025 at 03:27:47PM +0100, Matthieu Baerts wrote:
> Hi Joel, Eric, Al,
> 
> On 06/01/2025 14:32, Joel Granados wrote:
> > On Sat, Jan 04, 2025 at 08:11:52PM +0100, Matthieu Baerts wrote:
> >> Hi Eric,
> >>
> >> (+cc Joel)
> >>
> >> Thank you for your reply!
> >>
> >> On 04/01/2025 19:53, Eric Dumazet wrote:
> >>> On Sat, Jan 4, 2025 at 7:38 PM Matthieu Baerts <matttbe@kernel.org> wrote:
> >>>>
> >>>> Hi Eric,
> >>>>
> >>>> Thank you for the bug report!
> >>>>
> >>>> On 02/01/2025 16:21, Eric Dumazet wrote:
> >>>>> On Thu, Jan 2, 2025 at 3:12 PM syzbot
> >>>>> <syzbot+e364f774c6f57f2c86d1@syzkaller.appspotmail.com> wrote:
> >>>>>>
> >>>>>> Hello,
> >>>>>>
> >>>>>> syzbot found the following issue on:
> >>>>>>
> >>>>>> HEAD commit:    ccb98ccef0e5 Merge tag 'platform-drivers-x86-v6.13-4' of g..
> >>>>>> git tree:       upstream
> >>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=128f6ac4580000
> >>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=86dd15278dbfe19f
> >>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=e364f774c6f57f2c86d1
> >>>>>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> >>>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1245eaf8580000
> >>>>>>
> >>>>>> Downloadable assets:
> >>>>>> disk image: https://storage.googleapis.com/syzbot-assets/d24eb225cff7/disk-ccb98cce.raw.xz
> >>>>>> vmlinux: https://storage.googleapis.com/syzbot-assets/dd81532f8240/vmlinux-ccb98cce.xz
> >>>>>> kernel image: https://storage.googleapis.com/syzbot-assets/18b08e4bbf40/bzImage-ccb98cce.xz
> >>>>>>
> >>>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >>>>>> Reported-by: syzbot+e364f774c6f57f2c86d1@syzkaller.appspotmail.com
> >>>>>>
> >>>>>> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN PTI
> >>>>>> KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
> >>>>>> CPU: 1 UID: 0 PID: 5924 Comm: syz-executor Not tainted 6.13.0-rc5-syzkaller-00004-gccb98ccef0e5 #0
> >>>>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> >>>>>> RIP: 0010:proc_scheduler+0xc6/0x3c0 net/mptcp/ctrl.c:125
> >>>>>> Code: 03 42 80 3c 38 00 0f 85 fe 02 00 00 4d 8b a4 24 08 09 00 00 48 b8 00 00 00 00 00 fc ff df 49 8d 7c 24 28 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 cc 02 00 00 4d 8b 7c 24 28 48 8d 84 24 c8 00 00
> >>>>>> RSP: 0018:ffffc900034774e8 EFLAGS: 00010206
> >>>>>>
> >>>>>> RAX: dffffc0000000000 RBX: 1ffff9200068ee9e RCX: ffffc90003477620
> >>>>>> RDX: 0000000000000005 RSI: ffffffff8b08f91e RDI: 0000000000000028
> >>>>>> RBP: 0000000000000001 R08: ffffc90003477710 R09: 0000000000000040
> >>>>>> R10: 0000000000000040 R11: 00000000726f7475 R12: 0000000000000000
> >>>>>> R13: ffffc90003477620 R14: ffffc90003477710 R15: dffffc0000000000
> >>>>>> FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
> >>>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>>>> CR2: 00007fee3cd452d8 CR3: 000000007d116000 CR4: 00000000003526f0
> >>>>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >>>>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >>>>>> Call Trace:
> >>>>>>  <TASK>
> >>>>>>  proc_sys_call_handler+0x403/0x5d0 fs/proc/proc_sysctl.c:601
> >>>>>>  __kernel_write_iter+0x318/0xa80 fs/read_write.c:612
> >>>>>>  __kernel_write+0xf6/0x140 fs/read_write.c:632
> >>>>>>  do_acct_process+0xcb0/0x14a0 kernel/acct.c:539
> >>>>>>  acct_pin_kill+0x2d/0x100 kernel/acct.c:192
> >>>>>>  pin_kill+0x194/0x7c0 fs/fs_pin.c:44
> >>>>>>  mnt_pin_kill+0x61/0x1e0 fs/fs_pin.c:81
> >>>>>>  cleanup_mnt+0x3ac/0x450 fs/namespace.c:1366
> >>>>>>  task_work_run+0x14e/0x250 kernel/task_work.c:239
> >>>>>>  exit_task_work include/linux/task_work.h:43 [inline]
> >>>>>>  do_exit+0xad8/0x2d70 kernel/exit.c:938
> >>>>>>  do_group_exit+0xd3/0x2a0 kernel/exit.c:1087
> >>>>>>  get_signal+0x2576/0x2610 kernel/signal.c:3017
> >>>>>>  arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
> >>>>>>  exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
> >>>>>>  exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
> >>>>>>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
> >>>>>>  syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
> >>>>>>  do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
> >>>>>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >>>>>> RIP: 0033:0x7fee3cb87a6a
> >>>>>> Code: Unable to access opcode bytes at 0x7fee3cb87a40.
> >>>>>> RSP: 002b:00007fffcccac688 EFLAGS: 00000202 ORIG_RAX: 0000000000000037
> >>>>>> RAX: 0000000000000000 RBX: 00007fffcccac710 RCX: 00007fee3cb87a6a
> >>>>>> RDX: 0000000000000041 RSI: 0000000000000000 RDI: 0000000000000003
> >>>>>> RBP: 0000000000000003 R08: 00007fffcccac6ac R09: 00007fffcccacac7
> >>>>>> R10: 00007fffcccac710 R11: 0000000000000202 R12: 00007fee3cd49500
> >>>>>> R13: 00007fffcccac6ac R14: 0000000000000000 R15: 00007fee3cd4b000
> >>>>>>  </TASK>
> >>>>>> Modules linked in:
> >>>>>> ---[ end trace 0000000000000000 ]---
> >>>>>> RIP: 0010:proc_scheduler+0xc6/0x3c0 net/mptcp/ctrl.c:125
> >>>>>> Code: 03 42 80 3c 38 00 0f 85 fe 02 00 00 4d 8b a4 24 08 09 00 00 48 b8 00 00 00 00 00 fc ff df 49 8d 7c 24 28 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 cc 02 00 00 4d 8b 7c 24 28 48 8d 84 24 c8 00 00
> >>>>>> RSP: 0018:ffffc900034774e8 EFLAGS: 00010206
> >>>>>> RAX: dffffc0000000000 RBX: 1ffff9200068ee9e RCX: ffffc90003477620
> >>>>>> RDX: 0000000000000005 RSI: ffffffff8b08f91e RDI: 0000000000000028
> >>>>>> RBP: 0000000000000001 R08: ffffc90003477710 R09: 0000000000000040
> >>>>>> R10: 0000000000000040 R11: 00000000726f7475 R12: 0000000000000000
> >>>>>> R13: ffffc90003477620 R14: ffffc90003477710 R15: dffffc0000000000
> >>>>>> FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
> >>>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>>>> CR2: 00007fee3cd452d8 CR3: 000000007d116000 CR4: 00000000003526f0
> >>>>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >>>>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >>>>>> ----------------
> >>>>>> Code disassembly (best guess), 1 bytes skipped:
> >>>>>>    0:   42 80 3c 38 00          cmpb   $0x0,(%rax,%r15,1)
> >>>>>>    5:   0f 85 fe 02 00 00       jne    0x309
> >>>>>>    b:   4d 8b a4 24 08 09 00    mov    0x908(%r12),%r12
> >>>>>>   12:   00
> >>>>>>   13:   48 b8 00 00 00 00 00    movabs $0xdffffc0000000000,%rax
> >>>>>>   1a:   fc ff df
> >>>>>>   1d:   49 8d 7c 24 28          lea    0x28(%r12),%rdi
> >>>>>>   22:   48 89 fa                mov    %rdi,%rdx
> >>>>>>   25:   48 c1 ea 03             shr    $0x3,%rdx
> >>>>>> * 29:   80 3c 02 00             cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
> >>>>>>   2d:   0f 85 cc 02 00 00       jne    0x2ff
> >>>>>>   33:   4d 8b 7c 24 28          mov    0x28(%r12),%r15
> >>>>>>   38:   48                      rex.W
> >>>>>>   39:   8d                      .byte 0x8d
> >>>>>>   3a:   84 24 c8                test   %ah,(%rax,%rcx,8)
> >>>>
> >>>> (...)
> >>>>
> >>>>> I thought acct(2) was only allowing regular files.
> >>>>>
> >>>>> acct_on() indeed has :
> >>>>>
> >>>>> if (!S_ISREG(file_inode(file)->i_mode)) {
> >>>>>     kfree(acct);
> >>>>>     filp_close(file, NULL);
> >>>>>     return -EACCES;
> >>>>> }
> >>>>>
> >>>>> It seems there are other ways to call do_acct_process() targeting a sysfs file ?
> > If this is the case, can you point me to the place where this happens?
> > 
> >>>>
> >>>> Just to be sure I'm not misunderstanding your comment: do you mean that
> >>>> here, the issue is *not* in MPTCP code where we get the 'struct net'
> >>>> pointer via 'current->nsproxy->net_ns', but in the FS part, right?
> >>>>
> >>>> Here, we have an issue because 'current->nsproxy' is NULL, but is it
> >>>> normal? Or should we simply exit with an error if it is the case because
> >>>> we are in an exiting phase?
> >>>>
> >>>> I'm just a bit confused, because it looks like 'net' is retrieved from
> >>>> different places elsewhere when dealing with sysfs: some get it from
> >>>> 'current' like us, some assign 'net' to 'table->extra2', others get it
> >>>> from 'table->data' (via a container_of()), etc. Maybe we should not use
> >>>> 'current->nsproxy->net_ns' here then?
> >>>
> >>> I do think this is a bug in process accounting, not in networking.
> >>>
> >>> It might make sense to output a record on a regular file, but probably
> >>> not on any other files.
> > It for sure does not make sense to output a record on a sysctl file that
> > has a maxlen of just 3*sizeof(int) (kernel/acct.c:79).
> > 
> >>>
> >>> diff --git a/kernel/acct.c b/kernel/acct.c
> >>> index 179848ad33e978a557ce695a0d6020aa169177c6..a211305cb930f6860d02de7f45ebd260ae03a604
> >>> 100644
> >>> --- a/kernel/acct.c
> >>> +++ b/kernel/acct.c
> >>> @@ -495,6 +495,9 @@ static void do_acct_process(struct bsd_acct_struct *acct)
> >>>         const struct cred *orig_cred;
> >>>         struct file *file = acct->file;
> >>>
> >>> +       if (S_ISREG(file_inode(file)->i_mode))
> >>> +               return;
> >>> +
> > This seems like it does not handle the actual culprit which is. Why is
> > the sysctl file being used for the accounting.
> > 
> >>>         /*
> >>>          * Accounting records are not subject to resource limits.
> >>>          */
> >>
> >> OK, thank you, that's clearer.
> >>
> >> So this is then more a question for Joel, right?
> >>
> >> Do you plan to send this patch to him?
> >>
> >> #syz set subsystems: fs
> >>
> >> Cheers,
> >> Matt
> >> -- 
> >> Sponsored by the NGI0 Core fund.
> >>
> > 
> > So what is happening is that:
> > 1. The accounting file is set to a non-sysctl file.
> > 2. And when accounting tries to write to this file, you get the
> >    behaviour explained in this mail?
> > 
> > Please correct me if I have miss-read the situation.
> 
> @Joel: Thank you for your reply!
> 
> I'm sorry, I'm not sure whether I can help here. I hope Eric and/or Al
> can jump in.
> 
> What I can say is that the original issue has been found by syzbot, and
> the reproducer [1] shows that 3 syscalls have been used:
> - openat('/proc/sys/net/mptcp/scheduler')
> - mprotect()
> - acct()
> 
> Please also note that the conversation continued in a sub-tread where
> you are not in the Cc list, see [2]. In short, Eric suggested another
> patch only for sysfs, and Al recommended dropping the use of
> 'current->nsproxy'.
Perfect. Thx for the summary. I'll remove this thread from my radar as
it seems that a fix has already been found. 

Best

-- 

Joel Granados

