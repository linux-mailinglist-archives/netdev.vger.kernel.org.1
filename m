Return-Path: <netdev+bounces-300129-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ClcHLKV9MmoB0wUAu9opvQ
	(envelope-from <netdev+bounces-300129-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 12:57:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50936698BB3
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 12:57:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=samsung.com header.s=mail20170921 header.b=tKc3cGqm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300129-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300129-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=samsung.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F1F4830744DA
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 10:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00DA3A6EED;
	Wed, 17 Jun 2026 10:48:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A3B3A3821
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 10:48:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781693314; cv=none; b=uOyit6QHRU+Fh/Q7yK8p5Dm8lsaw5Rcdlb3tfu+4CkjonkhodY7uYMu1vCYAnEZgu8rNYv+iT1KVCb2V+G5WI1+EI0pWafCfyvGNsU0fW8J7ft56i7VTHC3AMrFQBwHzdaxQSV8cuqFMyuQiCqYnbvo9vMWq4uDNXO3eC3IkBEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781693314; c=relaxed/simple;
	bh=vqBbJI3ntUoavEvQHGcur91R3czJE00FfezuYjOO484=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=DP01J9ws9fn+rqP2h8he+hUlfVGH5ve2A3G026txnsLRUeX/H0lfnfrgycVahy1vaX1EnabItpeeM3pw3Kiud+XoPIDFXmYf7hq2BdcNoQmWaQRCpM+4gPy3gpdD5lF1HJnH9CI7fC6Uv+i13a2gnYafSab5rO1HkmWfuB9+eVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tKc3cGqm; arc=none smtp.client-ip=210.118.77.11
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260617104823euoutp011ade9d559902e2a75871383e0b3a9e03~52J6vUP5I2406124061euoutp01q
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 10:48:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260617104823euoutp011ade9d559902e2a75871383e0b3a9e03~52J6vUP5I2406124061euoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1781693303;
	bh=H9+b5Wb0VfYI+H7N1dUrr+Bdd92hyU4Y1QKyd0n/6qw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=tKc3cGqmJP+haNfkuh/m/IuCPf8DXeDvYFyOZRBl+BP4134KvG8Pv6HyGDr+OFqw6
	 8Qc4qJ+RGXAIFqbM2iZJVCOipGzzQlMFO7baRsEeo2xjrfcBDlppFs6ygLbyRU8UnN
	 l0joyN9T3Dn1/9feUQqBhfgTMOV3PAM2Urd8HGYQ=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260617104823eucas1p2268fc45472e6acbcbe70ee7813b4e9dd~52J6Kw6K60448104481eucas1p2U;
	Wed, 17 Jun 2026 10:48:23 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260617104822eusmtip12d62084603d36bdf3e6769bf4da55325~52J5uw_A22833428334eusmtip1C;
	Wed, 17 Jun 2026 10:48:22 +0000 (GMT)
Message-ID: <a443376e-5187-4268-93b3-58047ef113a8@samsung.com>
Date: Wed, 17 Jun 2026 12:48:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v3 net] net: watchdog: fix refcount tracking races
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com,
	syzbot+381d82bbf0253710b35d@syzkaller.appspotmail.com,
	syzbot+3479efbc2821cb2a79f2@syzkaller.appspotmail.com
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260611152737.2580480-1-edumazet@google.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260617104823eucas1p2268fc45472e6acbcbe70ee7813b4e9dd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260617104823eucas1p2268fc45472e6acbcbe70ee7813b4e9dd
X-EPHeader: CA
X-CMS-RootMailID: 20260617104823eucas1p2268fc45472e6acbcbe70ee7813b4e9dd
References: <20260611152737.2580480-1-edumazet@google.com>
	<CGME20260617104823eucas1p2268fc45472e6acbcbe70ee7813b4e9dd@eucas1p2.samsung.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.65 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[samsung.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300129-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:syzbot+381d82bbf0253710b35d@syzkaller.appspotmail.com,m:syzbot+3479efbc2821cb2a79f2@syzkaller.appspotmail.com,m:ericdumazet@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[m.szyprowski@samsung.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.szyprowski@samsung.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev,381d82bbf0253710b35d,3479efbc2821cb2a79f2];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,appspotmail.com:email,samsung.com:dkim,samsung.com:mid,samsung.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 50936698BB3

Dear All,

On 11.06.2026 17:27, Eric Dumazet wrote:
> Blamed commit converted the untracked dev_hold()/dev_put() calls
> in the watchdog code to use the tracked dev_hold_track()/dev_put_track()
> (which were later renamed/interfaced to netdev_hold() and netdev_put()).
>
> By introducing dev->watchdog_dev_tracker to store the
> reference tracking information without adding synchronization
> between netdev_watchdog_up() and dev_watchdog(), it enabled the
> race condition where this pointer could be overwritten or freed
> concurrently, leading to the list corruption crash syzbot reported:
>
> list_del corruption, ffff888114a18c00->next is NULL
>  kernel BUG at lib/list_debug.c:52 !
> Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
> CPU: 1 UID: 0 PID: 91 Comm: kworker/u8:5 Not tainted syzkaller #0 PREEMPT(lazy)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
> Workqueue: events_unbound linkwatch_event
>  RIP: 0010:__list_del_entry_valid_or_report.cold+0x22/0x2a lib/list_debug.c:52
> Call Trace:
>  <TASK>
>   __list_del_entry_valid include/linux/list.h:132 [inline]
>   __list_del_entry include/linux/list.h:246 [inline]
>   list_move_tail include/linux/list.h:341 [inline]
>   ref_tracker_free+0x1a7/0x6c0 lib/ref_tracker.c:329
>   netdev_tracker_free include/linux/netdevice.h:4491 [inline]
>   netdev_put include/linux/netdevice.h:4508 [inline]
>   netdev_put include/linux/netdevice.h:4504 [inline]
>   netdev_watchdog_down net/sched/sch_generic.c:600 [inline]
>   dev_deactivate_many+0x28c/0xfe0 net/sched/sch_generic.c:1363
>   dev_deactivate+0x109/0x1d0 net/sched/sch_generic.c:1397
>   linkwatch_do_dev net/core/link_watch.c:184 [inline]
>   linkwatch_do_dev+0xd3/0x120 net/core/link_watch.c:166
>   __linkwatch_run_queue+0x3a5/0x810 net/core/link_watch.c:240
>   linkwatch_event+0x8f/0xc0 net/core/link_watch.c:314
>   process_one_work+0xa0e/0x1980 kernel/workqueue.c:3314
>   process_scheduled_works kernel/workqueue.c:3397 [inline]
>   worker_thread+0x5ef/0xe50 kernel/workqueue.c:3478
>   kthread+0x370/0x450 kernel/kthread.c:436
>   ret_from_fork+0x69a/0xc80 arch/x86/kernel/process.c:158
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>
> This patch has three coordinated parts:
>
> 1) Add dev->watchdog_lock and dev->watchdog_ref_held to serialize watchdog operations.
>
> 2) Remove netdev_watchdog_up() call from netif_carrier_on():
>    This ensures netdev_watchdog_up() is only called from process/BH context
>    (via linkwatch workqueue dev_activate()), allowing us to use
>    spin_lock_bh() for synchronization.
>
> 3) Synchronize watchdog up and watchdog timer:
>    Protect netdev_watchdog_up() with tx_global_lock and watchdog_lock.
>    Only allocate a new tracker in netdev_watchdog_up() if one is
>    not already present.
>    In dev_watchdog(), ensure we don't release the tracker if the
>    timer was rescheduled either by dev_watchdog() itself or concurrently
>    by netdev_watchdog_up().
>
> Fixes: f12bf6f3f942 ("net: watchdog: add net device refcount tracker")
> Reported-by: syzbot+381d82bbf0253710b35d@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6a26b751.c25708ab.1b19ef.0013.GAE@google.com/T/#u
> Tested-by: syzbot+3479efbc2821cb2a79f2@syzkaller.appspotmail.com
> Signed-off-by: Eric Dumazet <edumazet@google.com>
This patch landed recently in linux-next as commit 8eed5519e496 ("net: watchdog:
fix refcount tracking races"). In my tests I found that it causes the following
deadlock during system suspend/resume on QEmu's ARM64bit 'virt' machine:

root@target:~# time rtcwake -s10 -mmem
rtcwake: assuming RTC uses UTC ...
rtcwake: wakeup from "mem" using /dev/rtc0 at Wed Jun 17 10:46:12 2026
PM: suspend entry (s2idle)
Filesystems sync: 0.055 seconds
Freezing user space processes
Freezing user space processes completed (elapsed 0.006 seconds)
OOM killer disabled.
Freezing remaining freezable tasks
Freezing remaining freezable tasks completed (elapsed 0.003 seconds)

============================================
WARNING: possible recursive locking detected
7.1.0-rc7+ #13003 Not tainted
--------------------------------------------
rtcwake/254 is trying to acquire lock:
ffff000006de64e8 (&dev->tx_global_lock){+.-.}-{3:3}, at: netdev_watchdog_up+0x40/0x108

but task is already holding lock:
ffff000006de64e8 (&dev->tx_global_lock){+.-.}-{3:3}, at: netif_tx_lock+0x1c/0x34

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&dev->tx_global_lock);
  lock(&dev->tx_global_lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

6 locks held by rtcwake/254:
 #0: ffff0000071ab3e8 (sb_writers#5){.+.+}-{0:0}, at: vfs_write+0x1ec/0x35c
 #1: ffff00000d22c480 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0xf0/0x1c4
 #2: ffff0000049162c8 (kn->active#61){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x100/0x1c4
 #3: ffffaa79533c03b0 (system_transition_mutex){+.+.}-{4:4}, at: pm_suspend+0x98/0x608
 #4: ffff000005e3a138 (&dev->mutex){....}-{4:4}, at: device_resume+0xb4/0x254
 #5: ffff000006de64e8 (&dev->tx_global_lock){+.-.}-{3:3}, at: netif_tx_lock+0x1c/0x34

stack backtrace:
CPU: 1 UID: 0 PID: 254 Comm: rtcwake Not tainted 7.1.0-rc7+ #13003 PREEMPT
Hardware name: linux,dummy-virt (DT)
Call trace:
 show_stack+0x18/0x24 (C)
 dump_stack_lvl+0x90/0xd0
 dump_stack+0x18/0x24
 print_deadlock_bug+0x260/0x350
 __lock_acquire+0x11b8/0x225c
 lock_acquire+0x1c4/0x3f0
 _raw_spin_lock_bh+0x50/0x68
 netdev_watchdog_up+0x40/0x108
 netif_device_attach+0x9c/0xb0
 virtnet_restore+0x100/0x21c
 virtio_device_restore_priv+0x11c/0x1d0
 virtio_device_restore+0x14/0x20
 virtio_mmio_restore+0x34/0x40
 platform_pm_resume+0x2c/0x68
 dpm_run_callback+0xa0/0x240
 device_resume+0x120/0x254
 dpm_resume+0x1f8/0x2ec
 dpm_resume_end+0x18/0x34
 suspend_devices_and_enter+0x1d0/0x990
 pm_suspend+0x1ec/0x608
 state_store+0x8c/0x110
 kobj_attr_store+0x18/0x2c
 sysfs_kf_write+0x50/0x7c
 kernfs_fop_write_iter+0x130/0x1c4
 vfs_write+0x2b8/0x35c
 ksys_write+0x6c/0x104
 __arm64_sys_write+0x1c/0x28
 invoke_syscall+0x54/0x110
 el0_svc_common.constprop.0+0x40/0xe8
 do_el0_svc+0x20/0x2c
 el0_svc+0x54/0x338
 el0t_64_sync_handler+0xa0/0xe4
 el0t_64_sync+0x198/0x19c


Reverting $subject on top of linux-next fixes this issue.


> ---
> v3: added dev->watchdog_lock and dev->watchdog_ref_held instead of messing
>     with ref tracker infra. (after sashiko feedback on v2)
> v2: fix compile error when CONFIG_NET_DEV_REFCNT_TRACKER is not set (Jakub and build bots)
>
>  include/linux/netdevice.h |  4 ++++
>  net/core/dev.c            |  3 ++-
>  net/sched/sch_generic.c   | 44 +++++++++++++++++++++++++++++----------
>  3 files changed, 39 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 0e1e581efc5ac264259b2f0fdfe41c50a6f47239..4a0e83709f29e4bcf12f479e464e6bedecc61c69 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1980,6 +1980,8 @@ enum netdev_reg_state {
>   *	@qdisc_hash:		qdisc hash table
>   *	@watchdog_timeo:	Represents the timeout that is used by
>   *				the watchdog (see dev_watchdog())
> + *	@watchdog_lock:		protect watchdog_ref_held
> + *	@watchdog_ref_held:	True if the watchdog device ref is taken.
>   *	@watchdog_timer:	List of timers
>   *
>   *	@proto_down_reason:	reason a netdev interface is held down
> @@ -2392,6 +2394,8 @@ struct net_device {
>  	/* These may be needed for future network-power-down code. */
>  	struct timer_list	watchdog_timer;
>  	int			watchdog_timeo;
> +	spinlock_t		watchdog_lock;
> +	bool			watchdog_ref_held;
>  
>  	u32                     proto_down_reason;
>  
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 0c6c270d9f7d115feb824f4ebe6be122c40d745f..731e661d7be6574d5eca4a600e0a5623be4c2485 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -11217,7 +11217,8 @@ static int netif_alloc_netdev_queues(struct net_device *dev)
>  
>  	netdev_for_each_tx_queue(dev, netdev_init_one_queue, NULL);
>  	spin_lock_init(&dev->tx_global_lock);
> -
> +	spin_lock_init(&dev->watchdog_lock);
> +	dev->watchdog_ref_held = false;
>  	return 0;
>  }
>  
> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> index a93321db8fd75d30c61e146c290bbc139c37c913..6cdf2ccfb0937e45271f8690a0c09d48a24ce769 100644
> --- a/net/sched/sch_generic.c
> +++ b/net/sched/sch_generic.c
> @@ -568,16 +568,24 @@ static void dev_watchdog(struct timer_list *t)
>  				dev->netdev_ops->ndo_tx_timeout(dev, i);
>  				netif_unfreeze_queues(dev);
>  			}
> -			if (!mod_timer(&dev->watchdog_timer,
> -				       round_jiffies(oldest_start +
> -						     dev->watchdog_timeo)))
> -				release = false;
> +			spin_lock(&dev->watchdog_lock);
> +			mod_timer(&dev->watchdog_timer,
> +				  round_jiffies(oldest_start +
> +						dev->watchdog_timeo));
> +			release = false;
> +			spin_unlock(&dev->watchdog_lock);
>  		}
>  	}
>  	spin_unlock(&dev->tx_global_lock);
>  
> -	if (release)
> +	spin_lock(&dev->watchdog_lock);
> +	if (timer_pending(&dev->watchdog_timer))
> +		release = false;
> +	if (release && dev->watchdog_ref_held) {
>  		netdev_put(dev, &dev->watchdog_dev_tracker);
> +		dev->watchdog_ref_held = false;
> +	}
> +	spin_unlock(&dev->watchdog_lock);
>  }
>  
>  void netdev_watchdog_up(struct net_device *dev)
> @@ -586,18 +594,34 @@ void netdev_watchdog_up(struct net_device *dev)
>  		return;
>  	if (dev->watchdog_timeo <= 0)
>  		dev->watchdog_timeo = 5*HZ;
> +	spin_lock_bh(&dev->tx_global_lock);
> +
> +	spin_lock(&dev->watchdog_lock);
>  	if (!mod_timer(&dev->watchdog_timer,
> -		       round_jiffies(jiffies + dev->watchdog_timeo)))
> -		netdev_hold(dev, &dev->watchdog_dev_tracker,
> -			    GFP_ATOMIC);
> +		       round_jiffies(jiffies + dev->watchdog_timeo))) {
> +		if (!dev->watchdog_ref_held) {
> +			netdev_hold(dev, &dev->watchdog_dev_tracker,
> +				    GFP_ATOMIC);
> +			dev->watchdog_ref_held = true;
> +		}
> +	}
> +	spin_unlock(&dev->watchdog_lock);
> +
> +	spin_unlock_bh(&dev->tx_global_lock);
>  }
>  EXPORT_SYMBOL_GPL(netdev_watchdog_up);
>  
>  static void netdev_watchdog_down(struct net_device *dev)
>  {
>  	netif_tx_lock_bh(dev);
> -	if (timer_delete(&dev->watchdog_timer))
> +
> +	spin_lock(&dev->watchdog_lock);
> +	if (timer_delete(&dev->watchdog_timer)) {
>  		netdev_put(dev, &dev->watchdog_dev_tracker);
> +		dev->watchdog_ref_held = false;
> +	}
> +	spin_unlock(&dev->watchdog_lock);
> +
>  	netif_tx_unlock_bh(dev);
>  }
>  
> @@ -614,8 +638,6 @@ void netif_carrier_on(struct net_device *dev)
>  			return;
>  		atomic_inc(&dev->carrier_up_count);
>  		linkwatch_fire_event(dev);
> -		if (netif_running(dev))
> -			netdev_watchdog_up(dev);
>  	}
>  }
>  EXPORT_SYMBOL(netif_carrier_on);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


