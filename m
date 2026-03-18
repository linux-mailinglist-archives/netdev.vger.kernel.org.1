Return-Path: <netdev+bounces-269148-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBQJAP/tumnydAIAu9opvQ
	(envelope-from <netdev+bounces-269148-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 19:25:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A2D2C135F
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 19:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07D1430D16E3
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 17:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7644D37AA7D;
	Wed, 18 Mar 2026 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="vf/PIfqC"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EC036164A
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 17:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773856609; cv=none; b=SKjtL3HUhdUJ8foa4Qz80UDL6DNZX6XQtpRWMtZHMdb17OldlslPmZkzzzfn40wcX/IzMpbAyG+iTcb/Mr1uSFqISsm1g3nXzkGDKkmatj8i+S5TgqmA7sRoZb4F9V0Elsgahold1EoCOL7DgMmQEP52gdtpzTZU22nr2TyrLuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773856609; c=relaxed/simple;
	bh=IXBU3YQIouf+VJdt1ZOkV9JZUbIA4wlHgmaWHjg/b/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BybkSno6Z0ed1FK7KfRo2cCTT8Eh43AbTjK82qaceSuCj5mI8UO+BLEKL4jPCdz9Xm2GTtOJcxPPPAhZUbgmWXYZY0XIRZf8m1Oqzkq6+/+YWQx/81H5sZyHgw4BWKnccnqJx+Y5e2PAgLob8Fz7J3YYDPtRoQAxjxfUJWmdWJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=vf/PIfqC; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from x1 (122.24.31.150.dy.iij4u.or.jp [150.31.24.122])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 62IHtmKq077402
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 19 Mar 2026 02:55:50 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=iUa0cUAD4togZvYKxzXDBpSFVS/rOwnteKTz4jTJm+8=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1773856550; v=1;
        b=vf/PIfqCgBa02vkmAd/4zNIX/nnJjZaA/43ZKAb+r7I05Qh6JgLI+NNqLk+XQj2W
         0cuskUKclaTebUPaCfUg5+b0DelcmFWX2hTJHzbVH3dDxs9D4Ar49c1NkI70sVMt
         dQo5EZoYmPtsAWOIiE9c4I69FHFRfJYUrj9gTrGPNOD184LFGRbEm+1UzwQkDsvd
         LmXuY8fEojSUR3lz1bs2L/U/0fH0c9z0JpM3APidWvgRMDKR+IdkOKNTn9WZ1Pzc
         TkqbfHJRM96ybw2j+nWtHiQO3gM3gYk3eKPj4E7HaAAa8KEigMktcUKijGhztafE
         BtgZaakc4orZCYaSWGdngw==
Date: Thu, 19 Mar 2026 02:55:48 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
        nxne.cnse.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 3/5] ice: migrate to netdev
 ops lock
Message-ID: <abripOPt4oVu-Ksb@x1>
References: <20260318163505.31765-1-aleksander.lobakin@intel.com>
 <20260318163505.31765-4-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260318163505.31765-4-aleksander.lobakin@intel.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269148-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[enjuk.jp:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 53A2D2C135F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 03/18 17:35, Alexander Lobakin wrote:
> Queue management ops unconditionally enable netdev locking. The same
> lock is taken by default by several NAPI configuration functions,
> such as napi_enable() and netif_napi_set_irq().
> Request ops locking in advance and make sure we use the _locked
> counterparts of those functions to avoid deadlocks, taking the lock
> manually where needed (suspend/resume, queue rebuild and resets).

Hi Alexander,
After applying this patch (3/5) along with the preceding ones on top of
net-next, I got some WARNING splats when changing the admin state
(up/down) using the ip link command. [1, 2]

Since I haven't looked into this series in detail, I'm reporting the
splats anyway. 
I'm wondering why I haven't seen anyone report this type of issue up to
v3. Maybe there is something wrong with my setup or devices?

Device: Intel Corporation Ethernet Controller E810-XXV for SFP (rev 02)

[1] ip link set $DEV up
  WARNING: ./include/net/netdev_lock.h:17 at netif_napi_set_irq_locked+0x393/0x4b0, CPU#0: ip/898
  Modules linked in:
  CPU: 0 UID: 0 PID: 898 Comm: ip Not tainted 7.0.0-rc3-00751-gf0103a010a50 #88 PREEMPT(full)
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
  RIP: 0010:netif_napi_set_irq_locked+0x393/0x4b0
  [...]
  Call Trace:
   <TASK>
   ice_vsi_set_napi_queues_locked+0x31b/0x4d0
   ice_vsi_open+0x359/0x420
   ice_open_internal+0x1a4/0x230
   __dev_open+0x2e9/0x830
   __dev_change_flags+0x411/0x610
   netif_change_flags+0x76/0x170
   do_setlink.isra.0+0x17e8/0x39a0
   rtnl_newlink+0xe72/0x22a0
   rtnetlink_rcv_msg+0x6ea/0xb40
   netlink_rcv_skb+0x121/0x380
   netlink_unicast+0x4aa/0x780
   netlink_sendmsg+0x753/0xc80
   ____sys_sendmsg+0x7a2/0x950
   ___sys_sendmsg+0xf8/0x180
   __sys_sendmsg+0x11f/0x1c0
   do_syscall_64+0xf3/0x690
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
  RIP: 0033:0x7f07ffabec5e
  [...]

[2] ip link set $DEV down
  WARNING: ./include/net/netdev_lock.h:17 at napi_disable_locked+0x3dd/0x5e0, CPU#0: ip/921
  Modules linked in:
  CPU: 0 UID: 0 PID: 921 Comm: ip Tainted: G        W           7.0.0-rc3-00751-gf0103a010a50 #88 PREEMPT(full)
  Tainted: [W]=WARN
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
  RIP: 0010:napi_disable_locked+0x3dd/0x5e0
  [...]
  Call Trace:
   <TASK>
   ice_down+0x7c3/0x1010
   ice_vsi_close+0x26f/0x360
   ice_stop+0xde/0x120
   __dev_close_many+0x2a2/0x650
   __dev_change_flags+0x237/0x610
   netif_change_flags+0x76/0x170
   do_setlink.isra.0+0x17e8/0x39a0
   rtnl_newlink+0xe72/0x22a0
   rtnetlink_rcv_msg+0x6ea/0xb40
   netlink_rcv_skb+0x121/0x380
   netlink_unicast+0x4aa/0x780
   netlink_sendmsg+0x753/0xc80
   ____sys_sendmsg+0x7a2/0x950
   ___sys_sendmsg+0xf8/0x180
   __sys_sendmsg+0x11f/0x1c0
   do_syscall_64+0xf3/0x690
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
  RIP: 0033:0x7fc0bb17cc5e
  [...]
  ------------[ cut here ]------------
  WARNING: ./include/net/netdev_lock.h:17 at netif_napi_set_irq_locked+0x393/0x4b0, CPU#0: ip/921
  Modules linked in:
  CPU: 0 UID: 0 PID: 921 Comm: ip Tainted: G        W           7.0.0-rc3-00751-gf0103a010a50 #88 PREEMPT(full)
  Tainted: [W]=WARN
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
  RIP: 0010:netif_napi_set_irq_locked+0x393/0x4b0
  [...]
  Call Trace:
   <TASK>
   ice_vsi_clear_napi_queues_locked+0xe7/0x2b0
   ice_vsi_close+0x38/0x360
   ice_stop+0xde/0x120
   __dev_close_many+0x2a2/0x650
   __dev_change_flags+0x237/0x610
   netif_change_flags+0x76/0x170
   do_setlink.isra.0+0x17e8/0x39a0
   rtnl_newlink+0xe72/0x22a0
   rtnetlink_rcv_msg+0x6ea/0xb40
   netlink_rcv_skb+0x121/0x380
   netlink_unicast+0x4aa/0x780
   netlink_sendmsg+0x753/0xc80
   ____sys_sendmsg+0x7a2/0x950
   ___sys_sendmsg+0xf8/0x180
   __sys_sendmsg+0x11f/0x1c0
   do_syscall_64+0xf3/0x690
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
  RIP: 0033:0x7fc0bb17cc5e
  [...]
  ------------[ cut here ]------------
  WARNING: ./include/net/netdev_lock.h:17 at netif_napi_affinity_release+0x1cb/0x250, CPU#1: ip/921
  Modules linked in:
  CPU: 1 UID: 0 PID: 921 Comm: ip Tainted: G        W           7.0.0-rc3-00751-gf0103a010a50 #88 PREEMPT(full)
  Tainted: [W]=WARN
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
  RIP: 0010:netif_napi_affinity_release+0x1cb/0x250
  [...]
  Call Trace:
   <TASK>
   irq_set_affinity_notifier+0x261/0x360
   netif_napi_set_irq_locked+0x338/0x4b0
   ice_vsi_clear_napi_queues_locked+0xe7/0x2b0
   ice_vsi_close+0x38/0x360
   ice_stop+0xde/0x120
   __dev_close_many+0x2a2/0x650
   __dev_change_flags+0x237/0x610
   netif_change_flags+0x76/0x170
   do_setlink.isra.0+0x17e8/0x39a0
   rtnl_newlink+0xe72/0x22a0
   rtnetlink_rcv_msg+0x6ea/0xb40
   netlink_rcv_skb+0x121/0x380
   netlink_unicast+0x4aa/0x780
   netlink_sendmsg+0x753/0xc80
   ____sys_sendmsg+0x7a2/0x950
   ___sys_sendmsg+0xf8/0x180
   __sys_sendmsg+0x11f/0x1c0
   do_syscall_64+0xf3/0x690
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
  RIP: 0033:0x7fc0bb17cc5e
  [...]

