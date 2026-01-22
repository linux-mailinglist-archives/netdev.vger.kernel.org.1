Return-Path: <netdev+bounces-252182-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJVlGsGfcWmgKQAAu9opvQ
	(envelope-from <netdev+bounces-252182-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:55:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E94F6184E
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 407375005BC
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 03:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E1840F8C7;
	Thu, 22 Jan 2026 03:47:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DCD338939
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 03:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769053653; cv=none; b=dcIm6MpcUZMsxnramWoy33k2cXOF8m/vjl3fDCqhlLmO1p7UzDI80pRG9PMciDk59K53h2tqscWG3xWec/YZk7A1jhTfSlLP5XsyGH8HykYAP7ophlSci7pAGK9OWBcGKSG+VoYxg67YVnc16Xy9nRXthrO7Qn1PPqS+UNxwJtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769053653; c=relaxed/simple;
	bh=6g/XgbQC4rwOuewtIED1c/oSKE2m3EhVd2tddAWX1sY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pTakls8GhAuLVdnXMWTB8996TipyNuzFuewiVqV0ypwQ3Hq1z8mDs3MnAZxft7YS65EUVlof3i3mypfw7ZR2joZytSMdQA21o6GUut7+XStVJQ+v+hIQ5xlehTBHZsTNZ8/RzxYQX5AYMu3qmlbJOZFbt/DF5wttBsORjgZlrWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7cfd10872d7so972602a34.3
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 19:47:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769053651; x=1769658451;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i6yubr60Bru8t+RzLTJvgmyxmRQ6PRK+sdmnGTiJ7+U=;
        b=d3SgSbvK6CyP60aaI7/rYFDCf3N8KkmJGxcyJFp2i0C6yi1+5FzZlQ+gNFFfYYNOZ9
         MtH/mitXEA+5im0ah5ZTEvoSc58HnRdGJp/aUoBPzvoym8Iml3rLk7YimskPM2p4Bv55
         XwEc/dWCdS7/QtQD1mGAmA06zAoZBO9PiXoS3fMszbVqIte+KmdV5uUaAEVnksdpcW86
         eVNfYJKIPUUet8Yl2txJzW/2vIh0Zy/JInMv4osHykGLygKEXDSRYwk0O1c0ErH7P8wK
         GcAkyOdD8NvYgDAbsUZW42QnVw46oHWGcxYEiVuzkHLPkwCqcSBlK1tRaa5h/ajePCwP
         6amg==
X-Forwarded-Encrypted: i=1; AJvYcCX6DX0e4D80N7A6AdaO0VV8h5S+YdE/7RDbr5eD6sRzKiOAZ0MNN+t6rRvmVFUxW+QMt1OOYnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcyDAsVN0J6n3aG/L9wDaZGPrInDdTk7giJJPEXAkxrnwQajrV
	m8/IQJjy0XM0SgJOeRYEI7ArWoC6rG8XsBLwH/+7mowb55kFL9eCfX4Si17hIdTap5kms7tdeao
	CxJCiP0xdi2cdSUW2HhKsCOudj6BPH83f3Lj30DxK/Hc5uAAxXEKn6nK+q0A=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:61c:b0:65f:69f7:d0f2 with SMTP id
 006d021491bc7-662b00bbbfamr2737684eaf.77.1769053650941; Wed, 21 Jan 2026
 19:47:30 -0800 (PST)
Date: Wed, 21 Jan 2026 19:47:30 -0800
In-Reply-To: <6970d61d.050a0220.706b.0010.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69719dd2.a00a0220.3ad28e.9c55.GAE@google.com>
Subject: Re: [syzbot] [net?] general protection fault in ife_tlv_meta_encode
From: syzbot <syzbot+5cf914f193dffde3bd3c@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, eric.dumazet@gmail.com, 
	horms@kernel.org, jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com, yotam.gi@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=c06d757173270a35];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : No valid SPF, No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252182-lists,netdev=lfdr.de,5cf914f193dffde3bd3c];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,gmail.com,kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,redhat.com,googlegroups.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 1E94F6184E
X-Rspamd-Action: no action

syzbot has found a reproducer for the following issue on:

HEAD commit:    d8f87aa5fa0a net: remove HIPPI support and RoadRunner HIPP..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11fbf852580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c06d757173270a35
dashboard link: https://syzkaller.appspot.com/bug?extid=5cf914f193dffde3bd3c
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d4a7fc580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1691f3fa580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/502d97c34968/disk-d8f87aa5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/71a9c26032b6/vmlinux-d8f87aa5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/78eeec8d5dbf/bzImage-d8f87aa5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5cf914f193dffde3bd3c@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 UID: 0 PID: 5987 Comm: syz.0.18 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/13/2026
RIP: 0010:ife_tlv_meta_encode+0x46/0xb0 net/ife/ife.c:166
Code: 50 83 73 f6 45 8d 77 07 4d 8d 65 04 c1 e5 10 44 89 fb 83 c3 04 09 eb 0f cb 4c 89 e8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <0f> b6 04 08 84 c0 75 43 41 89 5d 00 41 81 e6 fc ff 00 00 41 8d 46
RSP: 0018:ffffc90003426f60 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000008000300 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000000
RBP: 0000000000030000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: ffffffff8979aa80 R12: 0000000000000004
R13: 0000000000000000 R14: 000000000000000b R15: 0000000000000004
FS:  000055557c2de500(0000) GS:ffff888125a29000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c0083cc000 CR3: 00000000763c8000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ife_encode_meta_u32+0x126/0x1c0 net/sched/act_ife.c:101
 tcf_ife_encode net/sched/act_ife.c:841 [inline]
 tcf_ife_act+0x10fd/0x1d80 net/sched/act_ife.c:877
 tc_act include/net/tc_wrapper.h:130 [inline]
 tcf_action_exec+0x185/0x8e0 net/sched/act_api.c:1152
 tc_classify include/net/tc_wrapper.h:197 [inline]
 __tcf_classify net/sched/cls_api.c:1764 [inline]
 tcf_classify+0x4cf/0x1130 net/sched/cls_api.c:1860
 multiq_classify net/sched/sch_multiq.c:39 [inline]
 multiq_enqueue+0x102/0x4d0 net/sched/sch_multiq.c:66
 dev_qdisc_enqueue+0x4e/0x240 net/core/dev.c:4146
 __dev_xmit_skb net/core/dev.c:4261 [inline]
 __dev_queue_xmit+0x1933/0x32b0 net/core/dev.c:4797
 packet_snd net/packet/af_packet.c:3076 [inline]
 packet_sendmsg+0x3eb6/0x50f0 net/packet/af_packet.c:3108
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:742
 ____sys_sendmsg+0x4d7/0x810 net/socket.c:2592
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2646
 __sys_sendmsg net/socket.c:2678 [inline]
 __do_sys_sendmsg net/socket.c:2683 [inline]
 __se_sys_sendmsg net/socket.c:2681 [inline]
 __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2681
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2a0039acb9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff41bd8b88 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f2a00615fa0 RCX: 00007f2a0039acb9
RDX: 0000000000000004 RSI: 00002000000000c0 RDI: 0000000000000008
RBP: 00007fff41bd8bf0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007f2a00615fac R14: 00007f2a00615fa0 R15: 00007f2a00615fa0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ife_tlv_meta_encode+0x46/0xb0 net/ife/ife.c:166
Code: 50 83 73 f6 45 8d 77 07 4d 8d 65 04 c1 e5 10 44 89 fb 83 c3 04 09 eb 0f cb 4c 89 e8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <0f> b6 04 08 84 c0 75 43 41 89 5d 00 41 81 e6 fc ff 00 00 41 8d 46
RSP: 0018:ffffc90003426f60 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000008000300 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000000
RBP: 0000000000030000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: ffffffff8979aa80 R12: 0000000000000004
R13: 0000000000000000 R14: 000000000000000b R15: 0000000000000004
FS:  000055557c2de500(0000) GS:ffff888125a29000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c0083cc000 CR3: 00000000763c8000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	50                   	push   %rax
   1:	83 73 f6 45          	xorl   $0x45,-0xa(%rbx)
   5:	8d 77 07             	lea    0x7(%rdi),%esi
   8:	4d 8d 65 04          	lea    0x4(%r13),%r12
   c:	c1 e5 10             	shl    $0x10,%ebp
   f:	44 89 fb             	mov    %r15d,%ebx
  12:	83 c3 04             	add    $0x4,%ebx
  15:	09 eb                	or     %ebp,%ebx
  17:	0f cb                	bswap  %ebx
  19:	4c 89 e8             	mov    %r13,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  27:	fc ff df
* 2a:	0f b6 04 08          	movzbl (%rax,%rcx,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	75 43                	jne    0x75
  32:	41 89 5d 00          	mov    %ebx,0x0(%r13)
  36:	41 81 e6 fc ff 00 00 	and    $0xfffc,%r14d
  3d:	41                   	rex.B
  3e:	8d                   	.byte 0x8d
  3f:	46                   	rex.RX


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

