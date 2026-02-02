Return-Path: <netdev+bounces-255900-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOd1F7i9gGl3AgMAu9opvQ
	(envelope-from <netdev+bounces-255900-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 16:07:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B64CDE3B
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 16:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9915630036F2
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 15:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038F8377555;
	Mon,  2 Feb 2026 15:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIq1WwYb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E33327AC45
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 15:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770044802; cv=pass; b=Z/ixzPuUEtXI0Rq4u8hp3bS6Bk+jVvvhnvzezpQMTPya3aezz0n+u2xWQjA+QKE5+xTBnIyA1872Y5TCHBEgDT1SBKvqNjtgbxeyMtJ/8f9+d8O5nHFqj+STMo7XOoFqvpafEFTnQM/Y16AUTToXY/5uUJMF8miSGJAThgpT08o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770044802; c=relaxed/simple;
	bh=MQamEwioJNyqiewvMLOwiby7MXQ4+rAarVSOcdnd2WU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qIFR8c2ebH92E1wxQiSxdMOG3kWWZd6S9hf7rOVGXm+WbEQ4qxiBE7eKhgvsakSicvX7j8mjc/0q93Anncw0d55LuXUcJSGZULMUc0IkGKGpwp88A3n7mUKSpS2CGuB+WGBg0mMF65uuBrdguk4BI+OOGZa6q0Rx/BhfbV2+rFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIq1WwYb; arc=pass smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-88a2fe9e200so43061566d6.0
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 07:06:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770044800; cv=none;
        d=google.com; s=arc-20240605;
        b=faOPUnZm2udBWQJRAvJwb/BWrt8A2HtqRET4yoxObtAosmWWPvdKf6Nlzh8vOUH514
         plh3NW7CM2hB8S6YSlzrejRYUCkPUeSeXepdHmmYz6UgzWoMu0LOnSyQs4VxsUYNsBWO
         i7P2ejEPE7rEUOPNBLVlnN85BsanQq4SlJgPHfixU5abppFvGTHuIl0vbbO3w4snvjfX
         jJdKOKSkiXQKz0n/D01huC9O1XhEt+A1CqD2MmxSROwq8r3h9DSjALwJczfhA5xd0rQ0
         bXAU6wWNSkc5FWAnMT8mjichAToivA8k8GrNUN/EUTz3ol/yfBN6b0HBE16lJmj35GwJ
         +MOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=w9jeP7bm024Qg0/Bgjvap268vepI5Fu8QRugNXY+EhA=;
        fh=/+0iNucZp6HzkZaPeTSoYb0+6KMbK8tgu8LHOtzsyLk=;
        b=cl8cs+26BkUHfvXh7XakzazXq1eUFNQCcS1t8K1ZzhDjbv2AUf/Nh85Hp1v1T4Lqtk
         ZCsFQay2Wi1kqkdA41rFX0NirDMgbkdpELe/6RanaQu1gjNQLErH9yxIfH+fEy9rAA1+
         bFj1MruDcA40cVR9Oa6eUYkH6SyePUBHI6Yaew/HpoMcs7woLicVvMTMQlO39DCoU/BA
         Mj8ADlvECNV84ZgZw84oKgla0zwM1s73X8AzWGGHtM9C42gHZ9WDkw+VITj2FGDjY4tt
         F1ydPiNcQxK96QDSA+0+zYMM3FVsDl0301ZvZOb76f3WuMDXeIbO6LkVvXRAUZcXIrQa
         dXRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770044800; x=1770649600; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w9jeP7bm024Qg0/Bgjvap268vepI5Fu8QRugNXY+EhA=;
        b=UIq1WwYbz/RSAg5VRKe/erzOojySD6JIoR/qeeKEGitaV8rtj3x7gwr28pw7hYMhN8
         Gne2jiwy4SRQN6WH8/28Bl867kURHZn+tqG7PPcewmtcdsfayIV05kA/ODb5Jht8/ITQ
         RX+t/Yr8SX5RcD/2anAMdpC4omOxRf/HNR+rkoImW+m9covo0JM1TJxXbNRGiYmgUzza
         clEQORbSZstKjyQ9TCo13exqvUMzSrBd1rkKOusjm6WpEwobRpdBhM7HsL5GxxZCbbLm
         R+1hAzdMJUC0landPKG9BAAhECjXpvSHmBGJZT1+LaYbcMu4mcvSiBO7nNKYCJ8Q3u6d
         L+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770044800; x=1770649600;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w9jeP7bm024Qg0/Bgjvap268vepI5Fu8QRugNXY+EhA=;
        b=uIXE3anPYIbWUStzm2EwRvmlQKpX6tNO20WikYfhqE97IIjGukroKgGY6od56nU+1E
         jP5tvU7uukegzlBTZkveFEuvGdBYGdAh4C6XtGBbgk/L2QCo6c4vXvxfEmQWFSrGxuDL
         VZvNGUdRX685AdFlV6lUi6dMR3LtWUuk5oyN576Fd5+yHUYdgaVn21PSwzoqbJrgtwkm
         MQX7gGpAzCuJ9TKOCFoC7ag9RsTGowQ+HIm6Q5KD2N4GZx+Ku+aZQ86St1WZ3oHpSsGp
         B62eYvkDNFsDVpZSSgpE+zWItJwJATeJ/LUBzO8dlKrRpA/s9ZeTZunBAtS7oNLSMs2r
         JwRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4dL0/ZRLJr9HWsvDHNPU6UwC3zue2n1mM8qnAeLKVF5Wv9qS4SI9XN4hhVPVUtf1K5zKfJv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQltOlMdTsryexmBYEJ4uNdnKFY6Krihy/7QSg4LgKM8DSXqsl
	p/0r0jd/FXi3DBg0ZmvAb2Ui4jEMieZgw7xY/KlKbtbAjbs99FMlAZhcixnimmRfHWT+1hUV3Wn
	JFqJ76wIJM8MPiGKHJTQ/WegBxYT7fJM=
X-Gm-Gg: AZuq6aKNIo7T8gKsd/G0qBNuZsrhl1zXvkPr65rG0dtoVAF4bIrAAPq3yXvK2W0lNYR
	nT8OkZJS2/h5gq7gQPxgMkqermCupyPu+laA0lwAmIODPcs4/SGytWMM50sDPdNl5wGvSK5P1wJ
	x9RVcPuI73oIbrXsff6gFxNCFH+5VI1LIL+3KFDdAdbOY16kkWGlkeVhk1KxGXq5BAYVkB6ek5u
	l/rplZGjoLYQV0uJxFa7QQHoBUPYpqAQs22Bb+JNC/uxf60veJ6bKOw78/mTq96E/4gVYQC
X-Received: by 2002:ad4:5f4a:0:b0:894:835d:b112 with SMTP id
 6a1803df08f44-894ea021d37mr174389836d6.40.1770044799594; Mon, 02 Feb 2026
 07:06:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sam Sun <samsun1006219@gmail.com>
Date: Mon, 2 Feb 2026 23:06:28 +0800
X-Gm-Features: AZwV_QijWGswhsnlUNOl98VZFGdjf-cZHkRE_JI1VByzESDNxU_o63zDFEHKqI8
Message-ID: <CAEkJfYP+dGtJZAatpFi9XgNJ5pKWDv6hOPUtyz14_6NbxTWT+g@mail.gmail.com>
Subject: [Linux kernel bug] general protection fault in wg_packet_send_queued_handshake_initiation
To: Jason@zx2c4.com, davem@davemloft.net, Eric Dumazet <edumazet@google.com>, 
	kuba@kernel.org, pabeni@redhat.com, wireguard@lists.zx2c4.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: syzkaller@googlegroups.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-255900-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[samsun1006219@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B8B64CDE3B
X-Rspamd-Action: no action

Dear developers and maintainers,

We have encountered a kernel crash in __queue_work occurring within
the wg_packet_handshake_send_worker context. The call trace indicates
the crash happens when wg_expired_send_persistent_keepalive (timer
callback) attempts to queue a specific work item while the interface
is being destroyed. The original crash log is listed below.

Oops: general protection fault, probably for non-canonical address
0xe1d2d8131fe22003: 0000 [#1] SMP KASAN NOPTI
KASAN: maybe wild-memory-access in range [0x0e96e098ff110018-0x0e96e098ff11001f]
CPU: 1 UID: 0 PID: 7634 Comm: kworker/u10:17 Tainted: G             L
    6.19.0-rc6-00003-g13bede03f3b8-dirty #18 PREEMPT(full)
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: wg-kex-wg0 wg_packet_handshake_send_worker
RIP: 0010:kasan_byte_accessible+0x15/0x30 mm/kasan/generic.c:210
Code: 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
0f 1f 40 d6 48 b8 00 00 00 00 00 fc ff df 48 c1 ef 03 48 01 c7 <0f> b6
07 3c 07 0f 96 c0 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00
RSP: 0018:ffa00000001d89c0 EFLAGS: 00010086
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8b56293e RDI: e1d2d8131fe22003
RBP: 0e96e098ff110018 R08: 0000000000000001 R09: 0000000000000000
R10: ff11000100070003 R11: 0000000000000007 R12: 0000000000000000
R13: ffffffff8b56293e R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ff110001a1773000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd5733fc158 CR3: 000000000df84000 CR4: 0000000000753ef0
PKRU: 55555554
Call Trace:
 <IRQ>
 __kasan_check_byte+0x14/0x50 mm/kasan/common.c:573
 kasan_check_byte include/linux/kasan.h:402 [inline]
 lock_acquire kernel/locking/lockdep.c:5842 [inline]
 lock_acquire+0xfd/0x330 kernel/locking/lockdep.c:5825
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 __queue_work+0xac2/0x12b0 kernel/workqueue.c:2315
 queue_work_on+0x11c/0x140 kernel/workqueue.c:2418
 queue_work include/linux/workqueue.h:765 [inline]
 wg_packet_send_queued_handshake_initiation+0x220/0x410
drivers/net/wireguard/send.c:75
 wg_packet_send_staged_packets+0x10f0/0x1890 drivers/net/wireguard/send.c:413
 wg_packet_send_keepalive+0x4b/0x2f0 drivers/net/wireguard/send.c:239
 wg_expired_send_persistent_keepalive+0x5e/0x70
drivers/net/wireguard/timers.c:144
 call_timer_fn+0x19f/0x570 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers+0x6d2/0xac0 kernel/time/timer.c:2373
 __run_timer_base kernel/time/timer.c:2385 [inline]
 __run_timer_base kernel/time/timer.c:2377 [inline]
 run_timer_base+0xc5/0x120 kernel/time/timer.c:2394
 run_timer_softirq+0x1a/0x40 kernel/time/timer.c:2404
 handle_softirqs+0x1d4/0x8e0 kernel/softirq.c:622
 do_softirq kernel/softirq.c:523 [inline]
 do_softirq+0xac/0xe0 kernel/softirq.c:510
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x100/0x120 kernel/softirq.c:450
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 fpregs_unlock arch/x86/include/asm/fpu/api.h:77 [inline]
 kernel_fpu_end arch/x86/kernel/fpu/core.c:506 [inline]
 kernel_fpu_end+0x5e/0x70 arch/x86/kernel/fpu/core.c:499
 blake2s_compress+0x77/0xe0 lib/crypto/x86/blake2s.h:42
 blake2s_update+0xb6/0x1f0 lib/crypto/blake2s.c:119
 mix_hash+0xf1/0x140 drivers/net/wireguard/noise.c:438
 message_encrypt drivers/net/wireguard/noise.c:470 [inline]
 wg_noise_handshake_create_initiation+0x363/0x5c0
drivers/net/wireguard/noise.c:555
 wg_packet_send_handshake_initiation+0x182/0x340 drivers/net/wireguard/send.c:34
 wg_packet_handshake_send_worker+0x1c/0x30 drivers/net/wireguard/send.c:51
 process_one_work+0x9cd/0x1ba0 kernel/workqueue.c:3304
 process_scheduled_works kernel/workqueue.c:3401 [inline]
 worker_thread+0x67e/0xe90 kernel/workqueue.c:3482
 kthread+0x3d0/0x780 kernel/kthread.c:463
 ret_from_fork+0x966/0xaf0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:kasan_byte_accessible+0x15/0x30 mm/kasan/generic.c:210
Code: 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
0f 1f 40 d6 48 b8 00 00 00 00 00 fc ff df 48 c1 ef 03 48 01 c7 <0f> b6
07 3c 07 0f 96 c0 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00
RSP: 0018:ffa00000001d89c0 EFLAGS: 00010086
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8b56293e RDI: e1d2d8131fe22003
RBP: 0e96e098ff110018 R08: 0000000000000001 R09: 0000000000000000
R10: ff11000100070003 R11: 0000000000000007 R12: 0000000000000000
R13: ffffffff8b56293e R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ff110001a1773000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd5733fc158 CR3: 000000000df84000 CR4: 0000000000753ef0
PKRU: 55555554
----------------
Code disassembly (best guess):
   0: 00 00                 add    %al,(%rax)
   2: 0f 1f 00             nopl   (%rax)
   5: 90                   nop
   6: 90                   nop
   7: 90                   nop
   8: 90                   nop
   9: 90                   nop
   a: 90                   nop
   b: 90                   nop
   c: 90                   nop
   d: 90                   nop
   e: 90                   nop
   f: 90                   nop
  10: 90                   nop
  11: 90                   nop
  12: 90                   nop
  13: 90                   nop
  14: 90                   nop
  15: 0f 1f 40 d6           nopl   -0x2a(%rax)
  19: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
  20: fc ff df
  23: 48 c1 ef 03           shr    $0x3,%rdi
  27: 48 01 c7             add    %rax,%rdi
* 2a: 0f b6 07             movzbl (%rdi),%eax <-- trapping instruction
  2d: 3c 07                 cmp    $0x7,%al
  2f: 0f 96 c0             setbe  %al
  32: c3                   ret
  33: cc                   int3
  34: cc                   int3
  35: cc                   int3
  36: cc                   int3
  37: 66                   data16
  38: 66                   data16
  39: 2e                   cs
  3a: 0f                   .byte 0xf
  3b: 1f                   (bad)
  3c: 84 00                 test   %al,(%rax)

<<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>

Analysis:
The crash happens at raw_spin_lock(&pool->lock) inside __queue_work.
The faulting address (0xe1d2d8...) suggests that the code is accessing
a garbage pointer, characteristic of a Use-After-Free error.

Suspected Root Cause:
The issue could be resulted by race condition between another thread
invoking destroy_workqueue and the current thread. Unfortunately, we
don't have any reproducible PoC yet.

Best Regards,
Yue

