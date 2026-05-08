Return-Path: <netdev+bounces-285788-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJXbAmrS/Wm+jgAAu9opvQ
	(envelope-from <netdev+bounces-285788-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:09:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 854334F6214
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 65ED0301F37D
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 12:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634233DC4A1;
	Fri,  8 May 2026 12:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="cayBonKY"
X-Original-To: netdev@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C1E3DC4A3;
	Fri,  8 May 2026 12:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778242147; cv=none; b=biRv2oNg6c8VZh8NVW2MiDQpdfawJ8fVFBjFK0Ktdx8cznIQdPov6ho491FCOZTFU/nSXePd7vmYAZySwDqsZ3CBAidImp4qIEACQzVD7yCtel/E9q1V6X/KwD3wNfji6r2E0Ozk6x6D9oRMcFMBqrDuAXQDofpJNeFvv0/6Hag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778242147; c=relaxed/simple;
	bh=PefJ8JJu7/cKo7POP1k7Bbb/EL0NZmMwrKWhUR6m+LA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JmcTUshIMqZ7SyNeWecrr/LstuVCRVUQKRfxqiBn3Sgjfb3/y5U5y4Y+BsWe6+w0a985jmcGc3NqaPWJC8aHElcKTj62dSKHnkbpVYiyn4IxZDHHsmEk/xSuQG0HhtYTvvp3zD4OtkuWERbbprRSWX3DDiZOcXlq7hc6GT2zhpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=cayBonKY; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZxE2F0MPlAKMA9tTYHpUj7NAcehst+ZfS8iSylAqVg4=; b=cayBonKYqJar5bSkkFVChAMPeG
	u8LQdQUYv2hIF1nMVMTkDIz1MLMENXW8yhLnt9DjX29H0yO95zub+3DGMRurmT1O5Rz/dmJc4zYp7
	rwG4bxiUHFHRcWjvZajB8fxESXEg1CCkxECmmxDboGqtlA3C9yXRlcGwSr3tx8jkC8GwafMNeI4hC
	QX6cs342LAP3XSOwDYobrbfRUn6fbV6RJZCMMFjndTGCNAkPlJU7k2bEla/BECzLMZzm8bRu8fMH8
	DDmDuh4Av//BNTrZHsKmVhpRGiFzwHp3O0XFqOL3gdZ3jexaJEtq6jLUMfZ1iq0NibzYjQ5kFebyp
	4j/eODhg==;
Received: from [138.117.126.15] (helo=[192.168.1.18])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wLK0r-007ryf-5J; Fri, 08 May 2026 14:09:00 +0200
Message-ID: <ebc92c53-b29f-49ae-a810-e2120cea44f2@igalia.com>
Date: Fri, 8 May 2026 09:08:51 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] kernel BUG in pn_socket_autobind
To: syzbot <syzbot+b3c0e6a240078433c42b@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <69e79944.a00a0220.17a17.001a.GAE@google.com>
Content-Language: en-US
From: Helen Koike <koike@igalia.com>
In-Reply-To: <69e79944.a00a0220.17a17.001a.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 854334F6214
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.64 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=95ee3fe1c5a8ab57];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285788-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,goo.gl:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,googlegroups.com:email,igalia.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[koike@igalia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,b3c0e6a240078433c42b];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action

#syz dup kernel BUG in pn_socket_sendmsg

On 4/21/26 12:35 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    b4e07588e743 tracing: tell git to ignore the generated 'un..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10aa8e6a580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=95ee3fe1c5a8ab57
> dashboard link: https://syzkaller.appspot.com/bug?extid=b3c0e6a240078433c42b
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-b4e07588.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/bb7067cc2bb4/vmlinux-b4e07588.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/46b9d3bae153/bzImage-b4e07588.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b3c0e6a240078433c42b@syzkaller.appspotmail.com
> 
> netlink: 'syz.3.104': attribute type 2 has an invalid length.
> ------------[ cut here ]------------
> kernel BUG at net/phonet/socket.c:213!
> Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> CPU: 1 UID: 0 PID: 6429 Comm: syz.3.104 Tainted: G             L      syzkaller #0 PREEMPT(full)
> Tainted: [L]=SOFTLOCKUP
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> RIP: 0010:pn_socket_autobind net/phonet/socket.c:213 [inline]
> RIP: 0010:pn_socket_autobind+0x14c/0x170 net/phonet/socket.c:202
> Code: 00 00 00 00 48 8b 44 24 58 65 48 2b 05 35 85 47 09 75 2a 48 83 c4 60 89 d8 5b 5d 41 5c 41 5d c3 cc cc cc cc e8 f5 0f 3d f7 90 <0f> 0b e8 ad c8 aa f7 eb 9e e8 06 c9 aa f7 e9 6c ff ff ff e8 5c b0
> RSP: 0018:ffffc900037ffa30 EFLAGS: 00010287
> RAX: 000000000000084d RBX: 0000000000000000 RCX: ffffc90007544000
> RDX: 0000000000080000 RSI: ffffffff8acc6aeb RDI: ffff888034de8000
> RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff920006fff46
> R13: dffffc0000000000 R14: 1ffff920006fff61 R15: ffffc900037ffe48
> FS:  00007fdb20e7f6c0(0000) GS:ffff8880d63e1000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fce31d5ee9c CR3: 000000002d58c000 CR4: 0000000000352ef0
> Call Trace:
>   <TASK>
>   pn_socket_sendmsg+0x43/0xe0 net/phonet/socket.c:421
>   sock_sendmsg_nosec net/socket.c:787 [inline]
>   __sock_sendmsg net/socket.c:802 [inline]
>   ____sys_sendmsg+0x9e1/0xb70 net/socket.c:2698
>   ___sys_sendmsg+0x190/0x1e0 net/socket.c:2752
>   __sys_sendmsg+0x170/0x220 net/socket.c:2784
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0x10b/0xf80 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fdb1ff9c819
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fdb20e7f028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007fdb20215fa0 RCX: 00007fdb1ff9c819
> RDX: 0000000000008000 RSI: 0000200000000380 RDI: 0000000000000006
> RBP: 00007fdb20032c91 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fdb20216038 R14: 00007fdb20215fa0 R15: 00007ffc7b77c6b8
>   </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:pn_socket_autobind net/phonet/socket.c:213 [inline]
> RIP: 0010:pn_socket_autobind+0x14c/0x170 net/phonet/socket.c:202
> Code: 00 00 00 00 48 8b 44 24 58 65 48 2b 05 35 85 47 09 75 2a 48 83 c4 60 89 d8 5b 5d 41 5c 41 5d c3 cc cc cc cc e8 f5 0f 3d f7 90 <0f> 0b e8 ad c8 aa f7 eb 9e e8 06 c9 aa f7 e9 6c ff ff ff e8 5c b0
> RSP: 0018:ffffc900037ffa30 EFLAGS: 00010287
> RAX: 000000000000084d RBX: 0000000000000000 RCX: ffffc90007544000
> RDX: 0000000000080000 RSI: ffffffff8acc6aeb RDI: ffff888034de8000
> RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff920006fff46
> R13: dffffc0000000000 R14: 1ffff920006fff61 R15: ffffc900037ffe48
> FS:  00007fdb20e7f6c0(0000) GS:ffff8880d63e1000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fce31d5ee9c CR3: 000000002d58c000 CR4: 0000000000352ef0
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup


