Return-Path: <netdev+bounces-257479-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJAhHbOKhWkWDQQAu9opvQ
	(envelope-from <netdev+bounces-257479-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 07:31:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9163CFAAF8
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 07:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 373B73002B45
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 06:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378572EBDC0;
	Fri,  6 Feb 2026 06:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HRndPdT/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE365220F3E
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 06:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770359471; cv=pass; b=ProdhpFhdOB1trIf7Ir+9hYOTOy8YVnMl37qalQZp7RM9T0aYV5pUIQEiPvbvU+HQJXcErwMujEMUlJqvvyy75VeOYckRHDtl++AQvTVwbCWqkerUcdtq/61gTQLiaegU9TRBa+g1P7vZYjYVwhXQ+GfbH0AjXsfMNv/86bYRBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770359471; c=relaxed/simple;
	bh=EIIKhyUooX3r/PdbexoCYcF38HhO9Z8ryf5x/gXXUYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m7MCDUS2kJd0FWgr5NWNacSs9e+iivf7BiVQVjXjlKymXMuD6Z4BR+jImqWuwYd2L7WqJLaVTgUaQZugorujfyyzsRjUhRcKCQPwP27Ux4gmBK4xl8w+hPjhtqk3rniDmUlxvHO/WNU/nzwLHXaGJU+7Ii97S/o0r4Xpjrc4hCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HRndPdT/; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-382fa66fa9dso13448371fa.0
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 22:31:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770359469; cv=none;
        d=google.com; s=arc-20240605;
        b=SoMJTGXvIi0f8Ie+KhDRtQVrIm0bRQzi/GJjhQ+rI5VgtLhP/keBth10JsidKsYmSN
         +d5UAFkpk4Loc5hOwxxLKdK1jikQ6xa6uNMj2iDU0G0NnvRjnS71g4QvGghtapNJgt7N
         M9bfnhWz1W/TkNgj2jj4HKBmu1rQA8sWSY+6jSpZC2xrj7LLg/oZFW6MersQG/nd8Ji2
         /pVFUQMz+Nr6qW/Fs6hY6dw0fVuBG1tPkFQi3P40IhPTy9LniwPHTQNLsc/nEb90jluJ
         Hz+5SQEmUQERR2mW7bqB3n5Cc6hvEr0rc5Xdkz9ulmHH50RiPhdRN2C5KaqFrJae4jjK
         7R6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Y7YKNjA07d2mDbxaHmncYluZfOIRQwuYJydAZEyrOgc=;
        fh=oEJRuuaWj0M6fEQR+wWySyYRj7YgcrYKiiBfYIEfrr4=;
        b=aLegOkIjT3giyISCNNy1MpIXF5OoQS3wv/ninZmwkNyoDhppFJSeDgOkHGjLgY1tx3
         0YXPis8/QOmosT+e8xLvHytE3/A/5l2LlRExtuJcnCvGxJwQMJjwGoJALbDCLj0VRYb4
         rjiBsZbdvZ71JFh/aXilMUmPOiYzoCzg9B0XcvzUB9aX0/ztAMf+ncLntBjRdNCTmgSV
         UL4rDWqECjbDKaA+vsx9hn93GcEe2R9n6B9gKr++WcxRLG3XtO4Dtp3wRY5jAL2w8FzX
         +/NuM7RBeVJOCNFiYz9PWL4BTrcoy5YleJmZXA7j4UFi2F88FqCIm5erEO4Fl4/flMSF
         q2+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770359469; x=1770964269; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7YKNjA07d2mDbxaHmncYluZfOIRQwuYJydAZEyrOgc=;
        b=HRndPdT/yY6VRrBN5PXD3P4wuaqssnUl87jc9dQt3iGhs0FpRHEt6h4Ty+QL/77Qzm
         IMkAUJRIVwCFJpjmE49NT6/QPuLdLhN3WB+hR0k5fN1RJrOUxWN0Yp2iqCV+LquRSw37
         k9uXig1ZRFdekOnLZUNMfn2A9EcJCvkvcK7pJ12cFiW4VbDtdWWvK92aZTuv3IPrIlId
         b5HcY3Z1onQUPMnF+VWYomzl0ZoHrigJA58TJVutBhZL9+dVhZHB4nH18r4309g0U1V8
         naEqxZqNMjnb0uQJKYUu93FT7pulyywUY7wOieWFjaINgq4MNXxuhcx+sthOCZDVmLH4
         34rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770359469; x=1770964269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7YKNjA07d2mDbxaHmncYluZfOIRQwuYJydAZEyrOgc=;
        b=V+jeCPKntWjSyJIeJktyGMejhQZmDWrjAWCm2Nhf7uuN5QZQbqjQ414U9xJw/NwHiB
         oIE9DdiUJ4mLWCguOuB7CKWtBebQgv7IOQ7KeEEzP3R+ozU6zp4baljFmo4Ez/AVp3Zh
         26bZFOS077W0gSWKaPd0bZSgSUyS1Jzn8DvomErEEW2zfA6GAx8nwfEh7Z6WjphBNVmI
         tSQm3S6xwPm/gaBk8cmXF0Nfw/pCJUNHamG6vxcR++wzlJ+tKMe7aTzlBz0q1QKVNBNE
         Bg9ZEsW5x/azX+ixuddzkaMmmEVetbH4ivS4g+/m6bewMssNPcbWhaNbyQbQ1A+ESCLC
         JizQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrsltaBXx2Yct8HWNZGcRR/ZrypP/B0W7TLF3tFXdCabNwK45s9MIbo/fNH5da2Q/Nn5FcgqA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2kN6J12klvod9juXtMYwjhaw1UD00jYhzXc/TkHjAQx0HKE3K
	P5yfoU9fKoyCYvn+tIcaZl92Dylr9UADqzS/UOXKP2BzX+n0LgJ24QswrDQnmst7pJio9dfwOuG
	NaHku83106PoV1tftcHmLzSMBcafdH9le/Jw/ork4
X-Gm-Gg: AZuq6aJgnIJmSvtJVZ5HALBdKokF/Y61ygParWahtwUmy6DDX1dSUhOGyRJOzmdDgn4
	mjIkgwQFVBjQAft/MkWowZkTORmPvknGFvowqWRTGvvNHFxdl8rY/EEMJxpr7R3MfWxKkXGvnYI
	9ZLtJAwyOYsnxDFvk5Y+kZnWDUmUfYopGPAOcBf0EsX17D1E4fXq65DxhUdKK4w+Jk/7ocFGf/F
	/tlzprIPUsjsToe02+2FdCwIqHNhYhPvOqOl1Vqlu5bBOWcrH5xJTYUoysikmN3f3jJx8bco2al
	eAQTnYcroknkpb63Hcymt9uHeEvN
X-Received: by 2002:a2e:a54e:0:b0:385:c10f:122 with SMTP id
 38308e7fff4ca-386b4ecab71mr6195491fa.3.1770359468625; Thu, 05 Feb 2026
 22:31:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69858738.050a0220.3b3015.002e.GAE@google.com>
In-Reply-To: <69858738.050a0220.3b3015.002e.GAE@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 6 Feb 2026 07:30:57 +0100
X-Gm-Features: AZwV_QigtRwHzRcz_qBwbEDZvHBUNHfkbq78REtw9jaCSitdZoy6tbcP7YfM-7s
Message-ID: <CACT4Y+ZQh5AQo7UuAKUNdJWZMBjKi9VA8aNFnT21sq=3yyeGjg@mail.gmail.com>
Subject: Re: [syzbot] [smc?] KCSAN: data-race in smc_switch_to_fallback /
 sock_poll (2)
To: syzbot <syzbot+198c20fde37cb9f6b0ac@syzkaller.appspotmail.com>
Cc: alibuda@linux.alibaba.com, davem@davemloft.net, dust.li@linux.alibaba.com, 
	edumazet@google.com, guwen@linux.alibaba.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, mjambigi@linux.ibm.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, sidraya@linux.ibm.com, syzkaller-bugs@googlegroups.com, 
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=8e27f4588a0f2183];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257479-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,storage.googleapis.com:url,syzkaller.appspot.com:url,appspotmail.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dvyukov@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,198c20fde37cb9f6b0ac];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 9163CFAAF8
X-Rspamd-Action: no action

On Fri, 6 Feb 2026 at 07:16, syzbot
<syzbot+198c20fde37cb9f6b0ac@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    5fd0a1df5d05 Merge tag 'v6.19rc8-smb3-client-fixes' of git..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1070aa5a580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8e27f4588a0f2183
> dashboard link: https://syzkaller.appspot.com/bug?extid=198c20fde37cb9f6b0ac
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/a09cd69509c3/disk-5fd0a1df.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f218ec1eb157/vmlinux-5fd0a1df.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/8549229eee91/bzImage-5fd0a1df.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+198c20fde37cb9f6b0ac@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KCSAN: data-race in smc_switch_to_fallback / sock_poll
>
> write to 0xffff888127398c18 of 8 bytes by task 14369 on cpu 1:
>  smc_switch_to_fallback+0x4ea/0x7e0 net/smc/af_smc.c:933
>  smc_sendmsg+0xce/0x2f0 net/smc/af_smc.c:2797
>  sock_sendmsg_nosec net/socket.c:727 [inline]
>  __sock_sendmsg net/socket.c:742 [inline]
>  ____sys_sendmsg+0x5af/0x600 net/socket.c:2592
>  ___sys_sendmsg+0x195/0x1e0 net/socket.c:2646
>  __sys_sendmsg net/socket.c:2678 [inline]
>  __do_sys_sendmsg net/socket.c:2683 [inline]
>  __se_sys_sendmsg net/socket.c:2681 [inline]
>  __x64_sys_sendmsg+0xd4/0x160 net/socket.c:2681
>  x64_sys_call+0x17ba/0x3000 arch/x86/include/generated/asm/syscalls_64.h:47
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xc0/0x2a0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> read to 0xffff888127398c18 of 8 bytes by task 14367 on cpu 0:
>  sock_poll+0x27/0x240 net/socket.c:1427
>  vfs_poll include/linux/poll.h:82 [inline]
>  __io_arm_poll_handler+0x1ee/0xb80 io_uring/poll.c:581
>  io_poll_add+0x69/0xf0 io_uring/poll.c:899
>  __io_issue_sqe+0xfd/0x2d0 io_uring/io_uring.c:1793
>  io_issue_sqe+0x20b/0xc20 io_uring/io_uring.c:1816
>  io_queue_sqe io_uring/io_uring.c:2043 [inline]
>  io_submit_sqe io_uring/io_uring.c:2321 [inline]
>  io_submit_sqes+0x78a/0x11b0 io_uring/io_uring.c:2435
>  __do_sys_io_uring_enter io_uring/io_uring.c:3285 [inline]
>  __se_sys_io_uring_enter+0x1bf/0x1c70 io_uring/io_uring.c:3224
>  __x64_sys_io_uring_enter+0x78/0x90 io_uring/io_uring.c:3224
>  x64_sys_call+0x27e4/0x3000 arch/x86/include/generated/asm/syscalls_64.h:427
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xc0/0x2a0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> value changed: 0xffff88811a6056c0 -> 0xffff88811a606080
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 UID: 0 PID: 14367 Comm: syz.8.3658 Not tainted syzkaller #0 PREEMPT(voluntary)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
> ==================================================================

Here is what LLM said re harmfull-ness of this data race.
It does not look totally bogus to me. At least the read of
file->private_data in sock_poll() needs to be done with READ_ONCE to
avoid the harmful scenario. I don't know if changing the fundamental
socket function because of this it's the best solution, though.

========

The data race occurs on the `file->private_data` field of a socket
file descriptor. This field is being updated in
`smc_switch_to_fallback()` (to point to the underlying TCP/CLC socket
instead of the SMC socket) while concurrently being read in
`sock_poll()`.

### Analysis of the Race

1.  **Nature of the Access**: `smc_switch_to_fallback()` is performing
a plain write to `file->private_data`, and `sock_poll()` is performing
a plain read. There is no mutual exclusion (like a lock) or memory
barrier protecting this transition.
2.  **Type Confusion Risk**: In `sock_poll()`, the code first reads
`file->private_data` into a local variable `sock`, then reads
`sock->ops`, and finally calls `ops->poll(file, sock, wait)`. If the
compiler reloads `sock` from `file->private_data` between these steps
(which is permitted under the C memory model for non-volatile
accesses), it could fetch the `ops` from the SMC socket but then call
that `ops->poll` function (i.e., `smc_poll`) passing the TCP socket as
the `sock` argument.
3.  **Consequences of Type Confusion**: `smc_poll()` casts the `struct
socket *sock` to a `struct smc_sock *`. A TCP socket (`struct
tcp_sock`) is not compatible with `struct smc_sock`. Accessing
SMC-specific fields (like `smc->use_fallback` or `smc->conn`) on a TCP
socket object would result in reading random memory, leading to
undefined behavior, logic errors, or a kernel crash.
4.  **Inconsistent State**: Even if the compiler does not reload the
pointer, the race between setting `smc->use_fallback = true` and
updating `file->private_data` means that `sock_poll()` might see an
inconsistent state where it enters `smc_poll()` but the fallback is
already partially complete, potentially accessing uninitialized or
transitioning connection state.
5.  **Violation of Invariants**: In the Linux kernel,
`file->private_data` for a socket is generally expected to be constant
for the lifetime of the `file` object. SMC's "fallback" mechanism
violates this invariant. While the mechanism is intended to be a
performance optimization, doing so without proper synchronization
(like `READ_ONCE`/`WRITE_ONCE` or a lock) makes it unsafe.

### Conclusion
This data race is **harmful** because it can lead to type confusion
and memory corruption. It is not a simple statistics counter or a
benign flag race; it involves the fundamental identity of the socket
object being operated on.

The fix for this would typically involve using `READ_ONCE` and
`WRITE_ONCE` to prevent compiler reloads and ensure atomicity, or
better yet, avoiding the mid-flight change of `file->private_data`
altogether.

