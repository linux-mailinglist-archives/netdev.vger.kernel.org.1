Return-Path: <netdev+bounces-301006-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n41SKiT6OGqLkwcAu9opvQ
	(envelope-from <netdev+bounces-301006-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 11:02:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 173136AE086
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 11:02:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=U6PCzIb8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301006-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301006-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83416300FB6D
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 09:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FEF3955C3;
	Mon, 22 Jun 2026 09:00:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCE538F654
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 09:00:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782118805; cv=pass; b=NRG8Qd+kds8yFQHW9BuI4Z9F2ZmdODdLVeretJWCoFdest3q2TkyfL+aA79wOJL/FFiV5RbDqb5G5TXv3S2K/+5IIFarmubss+lJUEUOSS8U/6b74HvD/DbJysuLbOp2+98DVbzMa5FzX0qaoaKqWAU5Fe/mwKHlXOnoeiXGjcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782118805; c=relaxed/simple;
	bh=F/CbQHoUT28hP2ENVFq0kxKVDSQeBiATEBENNTd0UBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cDZX3ugVhQad42ZEkeuXLqtKBo4OR1MEapeSD3fkiki814q0ku8YJ8PQ/kMXRbQAlXv7SweYpRdxtD0cTA2+60rh3wel/DrCEDzduJdKATQ7C9WzPBJ/lfZuAV0dpBsY9Wp/8z7P/5gn2/b7yfOfV+Rodc3G9LHuIAdogkijR/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U6PCzIb8; arc=pass smtp.client-ip=209.85.160.174
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-519f9f13b06so24809581cf.0
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 02:00:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782118803; cv=none;
        d=google.com; s=arc-20240605;
        b=HnGc6512PIG9KDWhOswP4X17mAWjKiDZR+51QQUz85tzjYW+CnaszNcdVgpBSKObrN
         jtU9OM0G6kCVB0gCeY2075bLINtGDAcEeDBMPpC9xgA4veh7gG9GwXYYKsmu12MmjkEx
         nsIm1PLtVLDrV7pqNQDEZNxlM8A3KuHQarW2u3N7bc/7COtwPdCt1qm8Tm93+Fy1F2n2
         EYZNkMT5kIRCgjDeUl1W4XzEvJ4bY8Vp6rSNh4s/eRyH+lLtIaq0cyC9FhIh9qxz6ell
         IGLRJZf7aMuyxaRxkemzkhoBas9eSln1GN+LegYGJIWKwqlbWu07fbDv5NDTWOwY3ULv
         yOLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y17whgNAxqc3TxiMwxOGQ6rrpywKIs7y/Z93H1A0RSs=;
        fh=sE2AILRWyrBLiAc+bzNevpj7Bpiw8laMOaXKheug2oQ=;
        b=W6a50OI4kaLLxfUY8s1CU4AWUoWH2FJ4RqRwgNqAI2IhQP8cOZzXjIaMHR1eEUU+SX
         l48BSuAKoOA/S22nFHH/1Ie+UtXJnTijJ8kx6b81B9prF6L6YFuc1C7U1LyahNsFOBWG
         50oq4nvJidMkHiqjlpw0vWXQOMo4OrlvNqPMctuu+gx5N1xkhN3dRKvDC3owPVw75R7R
         2uAzYNx1k1yZLX9J3d5to670EkIjeA6sUybxa7/bl4p6YLkTEHGdxAcD7i6DsY8o2Pxr
         sp6svi2hTlk8jfSh730cqgu7uCOuUFGg4tOsfDvyIIB6Pxm3XUPhhcjlDqnNzONmepqS
         UcmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782118803; x=1782723603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y17whgNAxqc3TxiMwxOGQ6rrpywKIs7y/Z93H1A0RSs=;
        b=U6PCzIb89AJpyj8N2dmBLK1e/bWGfMCJT+QKWUstpTHuq0Sqlfqk1t+U4TJ8WYylDd
         pVjEfl/wMsQzNa96lLM5aPmu4NZYJ4pLVWUxC4ZUTVQwKIgddUTLwW+OV0XvZcvLDrby
         kADdKOooStfUl2tb9TBNOd6H0zSbUuvLtwC+5VfT2swegeghLlzbb58i416Jw7DwDuNJ
         jCjgcI/VT5Ey8LfEDzZRTNKND0t3xMAjwgJcWzZeMj3I/62jMBpUE4YYYY550pkaenoN
         i3Es/eSW2YL93cEJVe4wVKio37SFrBlUQTncBxd00HIDmA+7iag1gsP7RUKLC7SWz9ic
         /Fsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782118803; x=1782723603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y17whgNAxqc3TxiMwxOGQ6rrpywKIs7y/Z93H1A0RSs=;
        b=QxeaOpOkmt20qyiNyjxzISvdV2YU0GYqlMeMQJdA6SRROcNl1eunzhRkMCaOEUPmsJ
         rjj/X+3WOPocK4k/hO9THpDw4C9SoSJ9veLlNsuSWfA9QcW9UXXaZf5dAtrfOdPZA8Tq
         NALFTgkfubFbm6LjpEC7MI4THmKgJTssIayj2rHVWUY4vi4666sRQHd87xeFmp0/nWlr
         Zk0JYUyXL7P40FD1Dwouim2/Si/7+2Oq0chW1CdSnYFBC8VEJpVQMLsA0gFQ7P6fSDIu
         Tr6S3RxqPWm/o8AfwuEDVMMncfr5PHOFG1MbXMsm70sQEYlFqACYybzl2WTFHqcT6Y9w
         z7uA==
X-Forwarded-Encrypted: i=1; AFNElJ+xQO7m84i/OsMJGxG9/FkffQ5OajynSI52mKcrcCu3HpDo5dPVf8iKp5egH8STnmt2ULW673Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmdkEY7T4tQcJYYC0QUYaxpqhHo9/He7HH+2a6KArmpNt4X93o
	/tF/jkTGxKmVWB0WDW1Jpa78BpjwGYDrINAKBkK1h4y0H06Rh0MdUUl5+Xu51QJ1YBhE5abVbIy
	T92JVgscIGU/UqJC4fM3VD6e02vDPEXmpr6mUoSFL
X-Gm-Gg: AfdE7ckFf+u8ZxsbN4A10Rs4FpObfvz/Tbzpv5Xfinsq0tufk0uWJkFDyHxES2rfUPH
	DFl0ubbhdX7W1bQkwHeFDq2zeVhPDvvtxGK0mbASAEbi+GRBIwuvwDd7Yrg86b2f8PUXAUuSkmE
	kih+o8oh1fhED0Z6IHTo38P0xVBngdyoPXBEAVK6d7P2a+pzqFk5i2II/AKWqe/E9kw+bQNY1wu
	4u0Fy7jy3/bIggenYP6ZPa4jwvJvLpVYSErVPU6YnXe509C2BGnaJOD1mAhfUS7vSp8HILul3+0
	REHPS/MvQekvKGG7rJ+HIz27eVjoIy5jC0SJAjHGNVXmXlAw8bWnKCHYB/aXm38XQKmJSeG9HIA
	vHasuwvt2
X-Received: by 2002:a05:622a:11d2:b0:519:ef86:127d with SMTP id
 d75a77b69052e-519f02d8947mr177085511cf.18.1782118802511; Mon, 22 Jun 2026
 02:00:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20260617104823eucas1p2268fc45472e6acbcbe70ee7813b4e9dd@eucas1p2.samsung.com>
 <20260611152737.2580480-1-edumazet@google.com> <a443376e-5187-4268-93b3-58047ef113a8@samsung.com>
In-Reply-To: <a443376e-5187-4268-93b3-58047ef113a8@samsung.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 22 Jun 2026 01:59:50 -0700
X-Gm-Features: AVVi8Cfgyj-gWnPABDPuoN6uwxQseN0Y7Jl5nmpgxYPxYSS2Rb_m7gftjgamTqk
Message-ID: <CANn89i+GVoQxFS26=s5w5vUa-ytRUgD1NM6MDZQdtB7FtcXv-w@mail.gmail.com>
Subject: Re: [PATCH v3 net] net: watchdog: fix refcount tracking races
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+381d82bbf0253710b35d@syzkaller.appspotmail.com, 
	syzbot+3479efbc2821cb2a79f2@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301006-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:m.szyprowski@samsung.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:syzbot+381d82bbf0253710b35d@syzkaller.appspotmail.com,m:syzbot+3479efbc2821cb2a79f2@syzkaller.appspotmail.com,m:ericdumazet@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev,381d82bbf0253710b35d,3479efbc2821cb2a79f2];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 173136AE086

On Wed, Jun 17, 2026 at 3:48=E2=80=AFAM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Dear All,
>
> On 11.06.2026 17:27, Eric Dumazet wrote:
> > Blamed commit converted the untracked dev_hold()/dev_put() calls
> > in the watchdog code to use the tracked dev_hold_track()/dev_put_track(=
)
> > (which were later renamed/interfaced to netdev_hold() and netdev_put())=
.
> >
> > By introducing dev->watchdog_dev_tracker to store the
> > reference tracking information without adding synchronization
> > between netdev_watchdog_up() and dev_watchdog(), it enabled the
> > race condition where this pointer could be overwritten or freed
> > concurrently, leading to the list corruption crash syzbot reported:
> >
> > list_del corruption, ffff888114a18c00->next is NULL
> >  kernel BUG at lib/list_debug.c:52 !
> > Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
> > CPU: 1 UID: 0 PID: 91 Comm: kworker/u8:5 Not tainted syzkaller #0 PREEM=
PT(lazy)
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 05/09/2026
> > Workqueue: events_unbound linkwatch_event
> >  RIP: 0010:__list_del_entry_valid_or_report.cold+0x22/0x2a lib/list_deb=
ug.c:52
> > Call Trace:
> >  <TASK>
> >   __list_del_entry_valid include/linux/list.h:132 [inline]
> >   __list_del_entry include/linux/list.h:246 [inline]
> >   list_move_tail include/linux/list.h:341 [inline]
> >   ref_tracker_free+0x1a7/0x6c0 lib/ref_tracker.c:329
> >   netdev_tracker_free include/linux/netdevice.h:4491 [inline]
> >   netdev_put include/linux/netdevice.h:4508 [inline]
> >   netdev_put include/linux/netdevice.h:4504 [inline]
> >   netdev_watchdog_down net/sched/sch_generic.c:600 [inline]
> >   dev_deactivate_many+0x28c/0xfe0 net/sched/sch_generic.c:1363
> >   dev_deactivate+0x109/0x1d0 net/sched/sch_generic.c:1397
> >   linkwatch_do_dev net/core/link_watch.c:184 [inline]
> >   linkwatch_do_dev+0xd3/0x120 net/core/link_watch.c:166
> >   __linkwatch_run_queue+0x3a5/0x810 net/core/link_watch.c:240
> >   linkwatch_event+0x8f/0xc0 net/core/link_watch.c:314
> >   process_one_work+0xa0e/0x1980 kernel/workqueue.c:3314
> >   process_scheduled_works kernel/workqueue.c:3397 [inline]
> >   worker_thread+0x5ef/0xe50 kernel/workqueue.c:3478
> >   kthread+0x370/0x450 kernel/kthread.c:436
> >   ret_from_fork+0x69a/0xc80 arch/x86/kernel/process.c:158
> >   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> >
> > This patch has three coordinated parts:
> >
> > 1) Add dev->watchdog_lock and dev->watchdog_ref_held to serialize watch=
dog operations.
> >
> > 2) Remove netdev_watchdog_up() call from netif_carrier_on():
> >    This ensures netdev_watchdog_up() is only called from process/BH con=
text
> >    (via linkwatch workqueue dev_activate()), allowing us to use
> >    spin_lock_bh() for synchronization.
> >
> > 3) Synchronize watchdog up and watchdog timer:
> >    Protect netdev_watchdog_up() with tx_global_lock and watchdog_lock.
> >    Only allocate a new tracker in netdev_watchdog_up() if one is
> >    not already present.
> >    In dev_watchdog(), ensure we don't release the tracker if the
> >    timer was rescheduled either by dev_watchdog() itself or concurrentl=
y
> >    by netdev_watchdog_up().
> >
> > Fixes: f12bf6f3f942 ("net: watchdog: add net device refcount tracker")
> > Reported-by: syzbot+381d82bbf0253710b35d@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/netdev/6a26b751.c25708ab.1b19ef.0013.GA=
E@google.com/T/#u
> > Tested-by: syzbot+3479efbc2821cb2a79f2@syzkaller.appspotmail.com
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> This patch landed recently in linux-next as commit 8eed5519e496 ("net: wa=
tchdog:
> fix refcount tracking races"). In my tests I found that it causes the fol=
lowing
> deadlock during system suspend/resume on QEmu's ARM64bit 'virt' machine:
>
> root@target:~# time rtcwake -s10 -mmem
> rtcwake: assuming RTC uses UTC ...
> rtcwake: wakeup from "mem" using /dev/rtc0 at Wed Jun 17 10:46:12 2026
> PM: suspend entry (s2idle)
> Filesystems sync: 0.055 seconds
> Freezing user space processes
> Freezing user space processes completed (elapsed 0.006 seconds)
> OOM killer disabled.
> Freezing remaining freezable tasks
> Freezing remaining freezable tasks completed (elapsed 0.003 seconds)
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> WARNING: possible recursive locking detected
> 7.1.0-rc7+ #13003 Not tainted
> --------------------------------------------
> rtcwake/254 is trying to acquire lock:
> ffff000006de64e8 (&dev->tx_global_lock){+.-.}-{3:3}, at: netdev_watchdog_=
up+0x40/0x108
>
> but task is already holding lock:
> ffff000006de64e8 (&dev->tx_global_lock){+.-.}-{3:3}, at: netif_tx_lock+0x=
1c/0x34
>
> other info that might help us debug this:
>  Possible unsafe locking scenario:
>
>        CPU0
>        ----
>   lock(&dev->tx_global_lock);
>   lock(&dev->tx_global_lock);
>
>  *** DEADLOCK ***
>
>  May be due to missing lock nesting notation
>
> 6 locks held by rtcwake/254:
>  #0: ffff0000071ab3e8 (sb_writers#5){.+.+}-{0:0}, at: vfs_write+0x1ec/0x3=
5c
>  #1: ffff00000d22c480 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_it=
er+0xf0/0x1c4
>  #2: ffff0000049162c8 (kn->active#61){.+.+}-{0:0}, at: kernfs_fop_write_i=
ter+0x100/0x1c4
>  #3: ffffaa79533c03b0 (system_transition_mutex){+.+.}-{4:4}, at: pm_suspe=
nd+0x98/0x608
>  #4: ffff000005e3a138 (&dev->mutex){....}-{4:4}, at: device_resume+0xb4/0=
x254
>  #5: ffff000006de64e8 (&dev->tx_global_lock){+.-.}-{3:3}, at: netif_tx_lo=
ck+0x1c/0x34
>
> stack backtrace:
> CPU: 1 UID: 0 PID: 254 Comm: rtcwake Not tainted 7.1.0-rc7+ #13003 PREEMP=
T
> Hardware name: linux,dummy-virt (DT)
> Call trace:
>  show_stack+0x18/0x24 (C)
>  dump_stack_lvl+0x90/0xd0
>  dump_stack+0x18/0x24
>  print_deadlock_bug+0x260/0x350
>  __lock_acquire+0x11b8/0x225c
>  lock_acquire+0x1c4/0x3f0
>  _raw_spin_lock_bh+0x50/0x68
>  netdev_watchdog_up+0x40/0x108
>  netif_device_attach+0x9c/0xb0
>  virtnet_restore+0x100/0x21c
>  virtio_device_restore_priv+0x11c/0x1d0
>  virtio_device_restore+0x14/0x20
>  virtio_mmio_restore+0x34/0x40
>  platform_pm_resume+0x2c/0x68
>  dpm_run_callback+0xa0/0x240
>  device_resume+0x120/0x254
>  dpm_resume+0x1f8/0x2ec
>  dpm_resume_end+0x18/0x34
>  suspend_devices_and_enter+0x1d0/0x990
>  pm_suspend+0x1ec/0x608
>  state_store+0x8c/0x110
>  kobj_attr_store+0x18/0x2c
>  sysfs_kf_write+0x50/0x7c
>  kernfs_fop_write_iter+0x130/0x1c4
>  vfs_write+0x2b8/0x35c
>  ksys_write+0x6c/0x104
>  __arm64_sys_write+0x1c/0x28
>  invoke_syscall+0x54/0x110
>  el0_svc_common.constprop.0+0x40/0xe8
>  do_el0_svc+0x20/0x2c
>  el0_svc+0x54/0x338
>  el0t_64_sync_handler+0xa0/0xe4
>  el0t_64_sync+0x198/0x19c
>
>
> Reverting $subject on top of linux-next fixes this issue.

Thanks for the report Marek!

Acquiring tx_global_lock in netdev_watchdog_up() appears unnecessary anyway
because the critical state (timer and refcount tracker) is already
protected by dev->watchdog_lock.

Could you try this patch?

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 3f1c510df850dbdbaf10d483547c7b1f3a5d5482..ef2b4bf51564173751c74fefe17=
e3913ed2fa056
100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -594,9 +594,8 @@ void netdev_watchdog_up(struct net_device *dev)
                return;
        if (dev->watchdog_timeo <=3D 0)
                dev->watchdog_timeo =3D 5*HZ;
-       spin_lock_bh(&dev->tx_global_lock);

-       spin_lock(&dev->watchdog_lock);
+       spin_lock_bh(&dev->watchdog_lock);
        if (!mod_timer(&dev->watchdog_timer,
                       round_jiffies(jiffies + dev->watchdog_timeo))) {
                if (!dev->watchdog_ref_held) {
@@ -605,9 +604,7 @@ void netdev_watchdog_up(struct net_device *dev)
                        dev->watchdog_ref_held =3D true;
                }
        }
-       spin_unlock(&dev->watchdog_lock);
-
-       spin_unlock_bh(&dev->tx_global_lock);
+       spin_unlock_bh(&dev->watchdog_lock);
 }
 EXPORT_SYMBOL_GPL(netdev_watchdog_up);

