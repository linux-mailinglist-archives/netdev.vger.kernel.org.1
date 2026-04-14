Return-Path: <netdev+bounces-278569-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFG0EYSU3mlaGAAAu9opvQ
	(envelope-from <netdev+bounces-278569-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 21:24:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C81E3FE010
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 21:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1802D30471E4
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 19:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE69282F3D;
	Tue, 14 Apr 2026 19:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCYeG+IW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f66.google.com (mail-oa1-f66.google.com [209.85.160.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4951F23D7DF
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 19:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776194687; cv=none; b=faOjcE/YKEwFRN+txnUmMYbbIiAV7dKQPHHKqID3kBsrfmw10HX4Yq4wsql2gJP3hxe4stp/TIUDnxuiNS992iV0PgNucLcSWyajg48fqUKO31ewu8AiW81jt5TPmNaFP85mjLnHdYtBYdyEkAObZTYcdQ4l0HLejyk+qDKl3M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776194687; c=relaxed/simple;
	bh=3KBYmCJf/WIw95XMyfHCT3kB0wZ0Z03zozQAMQoI7wA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMzViqUuJvkGR/uWImIS1Li+XcjfFkiNpZhpZkpOT1JspYD/+x1pttG+oIFn2FZ8mEZibH9myfc4V/9i/8z6n0uD0BwzxazgSd5ISWSxsTXn5m2q7/dzmhhQg+it7/jQa91Q5V50PvT9bju2M4Xy9JncuwmLwUoFt3IaRJMIoAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCYeG+IW; arc=none smtp.client-ip=209.85.160.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f66.google.com with SMTP id 586e51a60fabf-41c4d660b19so1651733fac.1
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 12:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776194685; x=1776799485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Siz3z5IxFOj8b0OunPP5kZBAXQk4fVlvS/hZBk1sSl0=;
        b=aCYeG+IWa1Jy94g4exfRJfs8EnWyaZMBHXWTaER30k3Uv5CzOoYDBipokJcvkeRTko
         Uq69ecEp1THy1il6yYmgwm+5dd1u378c8YImzKGH+c/zCDFitDyCD6sUKnC++CL6RjHw
         1/oEWnCunGgfpKIwc3/anIrpF8b8prkzUQYvp4IyJ71W2vQ9LzEXWl18hhi6hzpjy4m7
         x+SUA1ohN6d/XlH9m3/fhxHje3DsSNgoXJwEtg9/7l9d3HmK0tAqo5PXb3jieOdMM5BM
         P6BlwJe6ho8ijKnAOfGmsWZxagFM6cuUlagsLnljFEV91q+Ie4Uu00BvgsqZ4uFmQ8af
         DkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776194685; x=1776799485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Siz3z5IxFOj8b0OunPP5kZBAXQk4fVlvS/hZBk1sSl0=;
        b=RPIvyans157CgbkAz69JENt+lIC7mZ+7cie3rsHjDyp/lyc8gkLLCwsEvlInW7Aqu/
         8zn0WcMrt6nb2Hbgf9O/O6cK9Xf3LZJ5Olf4LReQlDfhZ6pkKNbmxoh5Afj9SzN3K6Yr
         A0nle9/4Y+aYATObOq2a/iJQJXqRIjWNfcnA4PHXHa4adwDj7OegpiLWaiIQ1XbJY1PM
         MVuguqVCt8qYCyQ/nDQIdVUQNEPKfRlqXINA20TerxFkNiCKZyFC2MC13xFJJbuL5afU
         g3nMr6BQjMVtioSp/43+LxhBxrZpSiGf9q4piaInNi1aDjSqdMF55h9HXko4cGWy+IKG
         YbIA==
X-Forwarded-Encrypted: i=1; AFNElJ942HhvlBjPMTENa4OJqlYuJiChbXpeA9LXgbyRuG+tfgAwlakxiYe1MX/+0aKBdCSP0CagfLg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9QlIAbvGBRAhoGUsaC7Tfgh9ashEb/T7SzMki0ODQkscP+Y+J
	Dr8tlxah/vHTi8huxNCFot+2TDqlY9po61eYeyvZntZ8TSHxak9wHDwM
X-Gm-Gg: AeBDiesp5g3LxIB3ltVNaxqgqcSs41YJGdZ4+mnd+8JJ+95uvB7/zWLZV+SlESWzIER
	Rmu6Epa4DDs0vZ6vpr0i+PIJRhBgDvDdHz3zowniSumhFLrj9Tye9mNRv3mYdzELvKllnNyURl8
	+vZn1cIIwB12xgmVpVlFduOJrBUKnCZeIEPzUBS0+skSe6B2PnSgbbQ8EdM0kVkRe1gV0b5Xs0B
	1zYMUWtZu0GWUR70tUgMS6fRcONYiEQx46USdi8FbxJxiq7dsxLtyGprLI0Bu+5+OneazzukCIl
	2xSSCmbDE079pax7c/rzh99BK8ouuaTQPjU16ULImA7MgEgIWx5Cz9Ib+YNLvTsa21y0hJ6nPk2
	v+FRCIdDjNwLefEM9YXiNToYkmRsD7pEF3idP/StvTVaMGAl7cRGCGq/2+4/N6ebsQuDQLutXZR
	+GzEw8rQ1eLWaa53kwGw==
X-Received: by 2002:a05:6870:7d1c:b0:41c:28d1:2c11 with SMTP id 586e51a60fabf-423e0e2c39amr10397241fac.6.1776194680390;
        Tue, 14 Apr 2026 12:24:40 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:40::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-423dd395606sm12122767fac.1.2026.04.14.12.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 12:24:39 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <stfomichev@gmail.com>
Date: Tue, 14 Apr 2026 12:24:39 -0700
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net-next v7 00/15] net: sleepable ndo_set_rx_mode
Message-ID: <ad6UEB5ripPKBfUD@devvm17672.vll0.facebook.com>
References: <20260413171131.550126-1-sdf@fomichev.me>
 <20260413190831.1f3c53cb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260413190831.1f3c53cb@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278569-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,davemloft.net,google.com,redhat.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ff110001a3c12618:email]
X-Rspamd-Queue-Id: 9C81E3FE010
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/13, Jakub Kicinski wrote:
> On Mon, 13 Apr 2026 10:11:16 -0700 Stanislav Fomichev wrote:
> > This series adds a new ndo_set_rx_mode_async callback that enables
> > drivers to handle address list updates in a sleepable context. The
> > current ndo_set_rx_mode is called under the netif_addr_lock spinlock
> > with BHs disabled, which prevents drivers from sleeping. This is
> > problematic for ops-locked drivers that need to sleep.
> 
> Hi hi, hit this on the new(ish) queue leasing test with bnxt (debug
> kernel):
> 
> | [ 1148.733157] kselftest: Running tests in drivers/net/hw
> [ 1151.485032] ref_tracker: reference already released.
> [ 1151.491522] ref_tracker: allocated in:
> [ 1151.496526]  __dev_set_rx_mode+0x398/0x4f0
> [ 1151.501923]  dev_mc_add+0xe7/0x100
> [ 1151.506537]  igmp6_group_added+0x31c/0x400
> [ 1151.511930]  __ipv6_dev_mc_inc+0x282/0x590
> [ 1151.517320]  __ipv6_sock_mc_join+0x40d/0x7c0
> [ 1151.522908]  do_ipv6_setsockopt+0x3504/0x3700
> [ 1151.528594]  ipv6_setsockopt+0x7e/0xf0
> [ 1151.533596]  do_sock_setsockopt+0x164/0x3b0
> [ 1151.539089]  __sys_setsockopt+0xe4/0x150
> [ 1151.544276]  __x64_sys_setsockopt+0xbd/0x180
> [ 1151.549866]  do_syscall_64+0xf3/0x5e0
> [ 1151.554763]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [ 1151.561229] ref_tracker: freed in:
> [ 1151.565840]  netdev_rx_mode_work+0x205/0x410
> [ 1151.571429]  process_one_work+0xdf5/0x1410
> [ 1151.576824]  worker_thread+0x4f1/0xd60
> [ 1151.581827]  kthread+0x364/0x460
> [ 1151.586246]  ret_from_fork+0x4a4/0x720
> [ 1151.591251]  ret_from_fork_asm+0x11/0x20
> [ 1151.596704] ------------[ cut here ]------------
> [ 1151.602747] WARNING: lib/ref_tracker.c:322 at ref_tracker_free.cold+0x10a/0x1f9, CPU#7: kworker/7:2/5262
> [ 1151.614292] Modules linked in:
> [ 1151.618626] CPU: 7 UID: 0 PID: 5262 Comm: kworker/7:2 Not tainted 7.0.0-rc7-hmtc-g3cb8f09d448a #1 PREEMPT(full) 
> [ 1151.630928] Hardware name: Giga Computing E163-Z34-AAH1-000/MZ33-DC1-000, BIOS R30_F44 12/24/2025
> [ 1151.641762] Workqueue: events netdev_rx_mode_work
> [ 1151.647920] RIP: 0010:ref_tracker_free.cold+0x10a/0x1f9
> [ 1151.654646] Code: e0 2a 0f b6 04 02 84 c0 74 04 3c 03 7e 78 8b 7b 18 4c 89 04 24 e8 71 b2 e4 01 4c 8b 04 24 4c 89 c6 48 89 ef e8 32 92 05 04 90 <0f> 0b 90 ba ea ff ff ff e9 06 de e4 01 4c 89 ea 48 89 df 4c 89 04
> [ 1151.676612] RSP: 0018:ffa0000035f6fb18 EFLAGS: 00010296
> [ 1151.683343] RAX: 0000000000000000 RBX: ff110001f7ae9460 RCX: 0000000000000001
> [ 1151.692224] RDX: 00000000ffffffff RSI: 1ffffffff1841334 RDI: 0000000000000001
> [ 1151.701102] RBP: ff110001a3c12618 R08: 0000000000000000 R09: 0000000000000000
> [ 1151.709973] R10: 0000000000000007 R11: 0000000000000001 R12: 1ff4000006bedf67
> [ 1151.718835] R13: ff110001f7ae9478 R14: ff110001fd1949fc R15: ffffffff8a80b9a0
> [ 1151.727814] FS:  0000000000000000(0000) GS:ff11001882899000(0000) knlGS:0000000000000000
> [ 1151.737696] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1151.744947] CR2: 00007f83287c3574 CR3: 00000017e26b0002 CR4: 0000000000771ef0
> [ 1151.753758] PKRU: 55555554
> [ 1151.757588] Call Trace:
> [ 1151.761130]  <TASK>
> [ 1151.764282]  ? ref_tracker_alloc+0x460/0x460
> [ 1151.769872]  ? netdev_rx_mode_work+0x205/0x410
> [ 1151.775659]  ? process_one_work+0xdf5/0x1410
> [ 1151.781249]  ? worker_thread+0x4f1/0xd60
> [ 1151.786450]  ? kthread+0x364/0x460
> [ 1151.791066]  ? ret_from_fork+0x4a4/0x720
> [ 1151.796267]  ? ret_from_fork_asm+0x11/0x20
> [ 1151.801666]  ? mark_held_locks+0x40/0x70
> [ 1151.806870]  netdev_rx_mode_work+0x205/0x410
> [ 1151.812461]  ? trace_workqueue_execute_start+0x9b/0x180
> [ 1151.819124]  ? process_one_work+0xdb4/0x1410
> [ 1151.824712]  process_one_work+0xdf5/0x1410
> [ 1151.830111]  ? pwq_dec_nr_in_flight+0x710/0x710
> [ 1151.835992]  ? lock_acquire.part.0+0xbc/0x260
> [ 1151.841686]  worker_thread+0x4f1/0xd60
> [ 1151.846694]  ? rescuer_thread+0x1320/0x1320
> [ 1151.852188]  kthread+0x364/0x460
> [ 1151.856609]  ? trace_irq_enable.constprop.0+0x9b/0x180
> [ 1151.863180]  ? kthread_affine_node+0x330/0x330
> [ 1151.868965]  ret_from_fork+0x4a4/0x720
> [ 1151.873965]  ? arch_exit_to_user_mode_prepare.isra.0+0xb0/0xb0
> [ 1151.881315]  ? __switch_to+0x540/0xd00
> [ 1151.886320]  ? kthread_affine_node+0x330/0x330
> [ 1151.892108]  ret_from_fork_asm+0x11/0x20
> | [ 1151.905076] hardirqs last  enabled at (7665): [<ffffffff847c61ea>] __up_console_sem+0x5a/0x70
> | [ 1151.915450] hardirqs last disabled at (7676): [<ffffffff847c61cf>] __up_console_sem+0x3f/0x70
> | [ 1151.925823] softirqs last  enabled at (7600): [<ffffffff8462d50e>] handle_softirqs+0x60e/0x920
> | [ 1151.936291] softirqs last disabled at (7595): [<ffffffff8462dca2>] irq_exit_rcu+0xa2/0xf0
> | [ 1151.946275] ---[ end trace 0000000000000000 ]---
> [ 1152.247817] ref_tracker: netdev@ff110001a3c12618 has 1/1 users at\x0a     __dev_set_rx_mode+0x398/0x4f0\x0a     dev_mc_add+0xe7/0x100\x0a     igmp6_group_added+0x31c/0x400\x0a     __ipv6_dev_mc_inc+0x282/0x590\x0a     addrconf_dad_begin+0x13c/0x540\x0a     addrconf_dad_work+0x170/0x930\x0a     process_one_work+0xdf5/0x1410\x0a     worker_thread+0x4f1/0xd60\x0a     kthread+0x364/0x460\x0a     ret_from_fork+0x4a4/0x720\x0a     ret_from_fork_asm+0x11/0x20\x0a
> [ 1152.318767] ------------[ cut here ]------------
> [ 1152.325512] WARNING: lib/ref_tracker.c:246 at ref_tracker_dir_exit+0x466/0x7e0, CPU#27: ip/15056
> [ 1152.336246] Modules linked in:
> [ 1152.340578] CPU: 27 UID: 0 PID: 15056 Comm: ip Tainted: G        W           7.0.0-rc7-hmtc-g3cb8f09d448a #1 PREEMPT(full) 
> [ 1152.353871] Tainted: [W]=WARN
> [ 1152.357997] Hardware name: Giga Computing E163-Z34-AAH1-000/MZ33-DC1-000, BIOS R30_F44 12/24/2025
> [ 1152.368759] RIP: 0010:ref_tracker_dir_exit+0x466/0x7e0
> [ 1152.375326] Code: e8 03 42 80 3c 38 00 0f 85 57 02 00 00 48 8b 03 49 89 de 49 39 dc 0f 85 2e ff ff ff 48 8b 74 24 10 48 89 ef e8 cb aa 20 02 90 <0f> 0b 90 48 8d 5d 44 be 04 00 00 00 48 89 df e8 a6 ee ec fe 48 89
> [ 1152.397212] RSP: 0018:ffa00000380470d0 EFLAGS: 00010286
> [ 1152.403876] RAX: 0000000000000000 RBX: ff110001a3c12668 RCX: 0000000000000001
> [ 1152.412685] RDX: 00000000ffffffff RSI: 1ffffffff1841334 RDI: 0000000000000001
> [ 1152.421496] RBP: ff110001a3c12618 R08: 0000000000000000 R09: 0000000000000000
> [ 1152.430303] R10: 000000000000000b R11: 0000000000000001 R12: ff110001a3c12668
> [ 1152.439103] R13: dead000000000100 R14: ff110001a3c12668 R15: dffffc0000000000
> [ 1152.447911] FS:  00007f05f6331840(0000) GS:ff11001883299000(0000) knlGS:0000000000000000
> [ 1152.457811] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1152.465057] CR2: 00007f68f567f440 CR3: 00000001a9d12003 CR4: 0000000000771ef0
> [ 1152.473863] PKRU: 55555554
> [ 1152.477694] Call Trace:
> [ 1152.481231]  <TASK>
> [ 1152.484384]  ? rcu_is_watching+0x15/0xd0
> [ 1152.489585]  ? ref_tracker_free+0x870/0x870
> [ 1152.495077]  ? lockdep_hardirqs_on+0x8c/0x130
> [ 1152.500764]  ? __stack_depot_get_stack_record+0x10/0x10
> [ 1152.507427]  ? kfree+0x151/0x610
> [ 1152.511847]  free_netdev+0x402/0x870
> [ 1152.516648]  ? do_raw_spin_unlock+0x59/0x250
> [ 1152.522241]  ? _raw_spin_unlock_irqrestore+0x40/0x80
> [ 1152.528613]  netdev_run_todo+0x83b/0xbf0
> [ 1152.533804]  ? unregister_netdevice_queued+0x80/0x80
> [ 1152.540172]  ? mutex_is_locked+0x1c/0x50
> [ 1152.545373]  ? generic_xdp_install+0x400/0x400
> [ 1152.551158]  ? mutex_is_locked+0x1c/0x50
> [ 1152.556349]  ? rtnl_is_locked+0x15/0x20
> [ 1152.561450]  ? unregister_netdevice_queued+0x16/0x80
> [ 1152.567826]  rtnl_dellink+0x4a5/0xae0
> [ 1152.572737]  ? rtnl_mdb_del+0x580/0x580
> [ 1152.577839]  ? __lock_acquire+0x508/0xc10
> [ 1152.583148]  ? avc_has_perm_noaudit+0xf6/0x300
> [ 1152.588935]  ? sched_init_numa+0x7f7/0xc30
> [ 1152.594331]  ? mark_usage+0x61/0x170
> [ 1152.599142]  ? __lock_acquire+0x508/0xc10
> [ 1152.604443]  ? lock_acquire.part.0+0xbc/0x260
> [ 1152.610130]  ? find_held_lock+0x2b/0x80
> [ 1152.615237]  ? rtnl_mdb_del+0x580/0x580
> [ 1152.620339]  ? __lock_release.isra.0+0x6b/0x1a0
> [ 1152.626215]  ? rtnl_mdb_del+0x580/0x580
> [ 1152.631319]  rtnetlink_rcv_msg+0x6fd/0xbd0
> [ 1152.636718]  ? rtnl_fdb_dump+0x690/0x690
> [ 1152.641917]  ? __lock_acquire+0x508/0xc10
> [ 1152.647218]  ? lock_acquire.part.0+0xbc/0x260
> [ 1152.652905]  ? find_held_lock+0x2b/0x80
> [ 1152.658008]  netlink_rcv_skb+0x14e/0x3a0
> [ 1152.663210]  ? rtnl_fdb_dump+0x690/0x690
> [ 1152.668412]  ? netlink_ack+0xcd0/0xcd0
> [ 1152.673422]  ? netlink_deliver_tap+0xc5/0x330
> [ 1152.679110]  ? netlink_deliver_tap+0x13c/0x330
> [ 1152.684894]  netlink_unicast+0x47c/0x740
> [ 1152.690098]  ? netlink_attachskb+0x800/0x800
> [ 1152.695687]  ? sock_has_perm+0x283/0x3f0
> [ 1152.700879]  netlink_sendmsg+0x75b/0xc90
> [ 1152.706081]  ? netlink_unicast+0x740/0x740
> [ 1152.711476]  ? __lock_release.isra.0+0x6b/0x1a0
> [ 1152.717357]  ? __import_iovec+0x36c/0x620
> [ 1152.722655]  ? __might_fault+0x97/0x140
> [ 1152.727749]  __sock_sendmsg+0xca/0x180
> [ 1152.732747]  ? move_addr_to_kernel+0x36/0xf0
> [ 1152.738328]  ____sys_sendmsg+0x609/0x830
> [ 1152.743529]  ? copy_msghdr_from_user+0x2a0/0x460
> [ 1152.749510]  ? kernel_sendmsg+0x30/0x30
> [ 1152.754611]  ? move_addr_to_kernel+0xf0/0xf0
> [ 1152.760204]  ? kasan_save_stack+0x3d/0x50
> [ 1152.765503]  ? kasan_save_stack+0x2f/0x50
> [ 1152.770799]  ? kasan_record_aux_stack+0x9b/0xc0
> [ 1152.776681]  ? __call_rcu_common.constprop.0+0xb2/0xa10
> [ 1152.783337]  ? kmem_cache_free+0x3d0/0x5f0
> [ 1152.788733]  ? fput_close_sync+0xde/0x1b0
> [ 1152.794032]  ? __x64_sys_close+0x8b/0xf0
> [ 1152.799235]  ___sys_sendmsg+0x14e/0x1d0
> [ 1152.804337]  ? copy_msghdr_from_user+0x460/0x460
> [ 1152.810330]  ? rcu_is_watching+0x15/0xd0
> [ 1152.815532]  ? trace_irq_enable.constprop.0+0x9b/0x180
> [ 1152.822106]  __sys_sendmsg+0x145/0x1f0
> [ 1152.827110]  ? __sys_sendmsg_sock+0x20/0x20
> [ 1152.832608]  ? do_raw_spin_unlock+0x59/0x250
> [ 1152.838196]  ? rcu_is_watching+0x15/0xd0
> [ 1152.843398]  do_syscall_64+0xf3/0x5e0
> [ 1152.848307]  ? trace_hardirqs_off+0xd/0x30
> [ 1152.853703]  ? exc_page_fault+0xda/0xf0
> [ 1152.858805]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [ 1152.865267] RIP: 0033:0x7f05f656b22e
> [ 1152.870077] Code: 4d 89 d8 e8 94 bd 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 03 ff ff ff 0f 1f 00 f3 0f 1e fa
> [ 1152.891961] RSP: 002b:00007fff388be520 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
> [ 1152.901262] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f05f656b22e
> [ 1152.910070] RDX: 0000000000000000 RSI: 00007fff388be5d0 RDI: 0000000000000003
> [ 1152.918880] RBP: 00007fff388be530 R08: 0000000000000000 R09: 0000000000000000
> [ 1152.927690] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
> [ 1152.936499] R13: 0000000069dd8ee8 R14: 000056113dabf040 R15: 0000000000000000
> 
> 
> Either decoding failed or I forgot where NIPA-HW puts the output :S
> But I think it's clear enough..

Looks like I need to juggle the tracker a bit, similar to how linkwatch_clean_dev
does it. Nice to see HW NIPA coming together!

