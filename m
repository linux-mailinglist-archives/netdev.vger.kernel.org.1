Return-Path: <netdev+bounces-280197-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBQBNH6w52lZ/QEAu9opvQ
	(envelope-from <netdev+bounces-280197-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 19:14:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 537E943DCB7
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 19:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD93F3085E85
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 17:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1BD39446D;
	Tue, 21 Apr 2026 17:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="jmg1qYCC"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F3B33F8B4;
	Tue, 21 Apr 2026 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776791485; cv=none; b=t1DebE3qeQ3hxFF/ItnvZDHek86cIEEEDhmChaD1hxFNB90/TZhrsN+WObkQsLGvq5x3qRpZrc8+3EDy8ykCSVqH3DQQ9xEOlDbgWS89x4rcX8FlhQ6Kw15K/NqTGxtxsQLYqusyT+tZqySDsLAMsNuinRNryHQlkyQVj5z+ZU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776791485; c=relaxed/simple;
	bh=fwYhpXAQjF8uUI7rvG31pxoDQeHS1b/JL+0rzRKM+fE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5Cv6ZhVrkw2kN746ClVRDErQ6N2tn93wekl/1sHTJoBoc4MwB12B2N5MBLA55JmCW1hgH18pIo5ahnv/KOBBAk5Wd8CYPAUyjwjrvZrJ/5cbVawYdRmB6sK89Sl2j1jBZj55CxY+h+R18tA+3XjGnegqrNGBkSXw9jvaL5/ygM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=jmg1qYCC; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from x1 (232.154.13.160.dy.iij4u.or.jp [160.13.154.232])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63LHB1J9054786
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 22 Apr 2026 02:11:02 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=upF82mfMNY+/yYIp/ptx7mS216iUNpwrVyJJ6IPjghA=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1776791463; v=1;
        b=jmg1qYCC0tA80JrysTdgPgMX/fTCOGSX1mcP9e5P3bZbSJoihgNrsjE415Z1UClh
         UjSuC2aL87FWkTYxecy1aEcj/CaHaiZ8VZzq86gcnQvGdl52JUkmzt/03BznBAA+
         C1PifUORy4ePtFu2vbAA31JIC+M0nKr0clJCvRN4LEKKgQB9KP9ejEsViikIx2et
         fp4z2Cj+eNbFcksjDCElGGkXBbZSvFJs66/Qfjyu6VgVlFOJGTjkYKLT0h0bnLFR
         lmR5loi1FJbmazU1+pUpTEgcH/dVEHnPzanESwajMVNAbT0mJL8D2+cz++q7kPWf
         UQRRnEpMlr16A0lRKtQy9g==
Date: Wed, 22 Apr 2026 02:11:01 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: syzbot <syzbot+6985cb8e543ea90ba8ee@syzkaller.appspotmail.com>
Cc: jasowang@redhat.com, linux-kernel@vger.kernel.org, mst@redhat.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kvm?] [net?] [virt?] BUG: sleeping function called
 from invalid context in vhost_get_avail_idx
Message-ID: <aeerTzpq8B-WTKeC@x1>
References: <69e6a414.050a0220.24bfd3.002d.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <69e6a414.050a0220.24bfd3.002d.GAE@google.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=7e54da1916e8d11f];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280197-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,enjuk.jp:dkim,googlegroups.com:email,storage.googleapis.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,goo.gl:url];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev,6985cb8e543ea90ba8ee];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 537E943DCB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/20 15:09, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8541d8f725c6 Merge tag 'mtd/for-7.1' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=136454ce580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7e54da1916e8d11f
> dashboard link: https://syzkaller.appspot.com/bug?extid=6985cb8e543ea90ba8ee
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d264ce580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143ec1ba580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-8541d8f7.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/22dfea2c37c2/vmlinux-8541d8f7.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e2f93ad68fe3/bzImage-8541d8f7.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+6985cb8e543ea90ba8ee@syzkaller.appspotmail.com
> 
> BUG: sleeping function called from invalid context at drivers/vhost/vhost.c:1527
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6110, name: vhost-6109
> preempt_count: 1, expected: 0
> RCU nest depth: 0, expected: 0
> 2 locks held by vhost-6109/6110:
>  #0: ffff888055624cb0 (&vq->mutex/1){+.+.}-{4:4}, at: handle_tx+0x2d/0x160 drivers/vhost/net.c:971
>  #1: ffff888055620248 (&vq->mutex){+.+.}-{4:4}, at: vhost_net_busy_poll+0x9c/0x730 drivers/vhost/net.c:554
> Preemption disabled at:
> [<ffffffff88f1a006>] vhost_net_busy_poll+0x1c6/0x730 drivers/vhost/net.c:563

I think the blamed commit may be commit 030881372460 ("vhost_net: basic
polling support"), since it introduced preempt_{disable,enable}() around
the busy-poll loop, which calls a sleepable function inside the loop.

Also, from the changelog of the series,

https://lore.kernel.org/netdev/1448435489-5949-4-git-send-email-jasowang@redhat.com/T/#u

  Changes from RFC V1:
  ...
  - Disable preemption during busy looping to make sure local_clock() was
    correctly used.

So my understanding is that preempt_disable() was introduced to keep
local_clock() based timeout accounting on a single CPU, rather than as a
requirement of busy polling itself.

If my understanding is correct, migrate_disable() is sufficient here
instead of preempt_disable(), avoiding sleepable accesses from a
preempt-disabled context.

#syz test

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 80965181920c..c6536cad9c4f 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -560,7 +560,7 @@ static void vhost_net_busy_poll(struct vhost_net *net,
        busyloop_timeout = poll_rx ? rvq->busyloop_timeout:
                                     tvq->busyloop_timeout;

-       preempt_disable();
+       migrate_disable();
        endtime = busy_clock() + busyloop_timeout;

        while (vhost_can_busy_poll(endtime)) {
@@ -577,7 +577,7 @@ static void vhost_net_busy_poll(struct vhost_net *net,
                cpu_relax();
        }

-       preempt_enable();
+       migrate_enable();

        if (poll_rx || sock_has_rx_data(sock))
                vhost_net_busy_poll_try_queue(net, vq);


> CPU: 0 UID: 0 PID: 6110 Comm: vhost-6109 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
>  __might_resched.cold+0x1ec/0x232 kernel/sched/core.c:9162
>  __might_fault+0x8b/0x140 mm/memory.c:7322
>  vhost_get_avail_idx+0x31c/0x4f0 drivers/vhost/vhost.c:1527
>  vhost_vq_avail_empty drivers/vhost/vhost.c:3206 [inline]
>  vhost_vq_avail_empty+0xa9/0xe0 drivers/vhost/vhost.c:3199
>  vhost_net_busy_poll+0x297/0x730 drivers/vhost/net.c:574
>  vhost_net_tx_get_vq_desc drivers/vhost/net.c:610 [inline]
>  get_tx_bufs.constprop.0+0x338/0x600 drivers/vhost/net.c:650
>  handle_tx_copy+0x28c/0x12e0 drivers/vhost/net.c:778
>  handle_tx+0x139/0x160 drivers/vhost/net.c:985
>  vhost_run_work_list+0x183/0x220 drivers/vhost/vhost.c:454
>  vhost_task_fn+0x156/0x430 kernel/vhost_task.c:49
>  ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
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
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
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

