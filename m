Return-Path: <netdev+bounces-204284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FCFAF9E71
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 08:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92FD83BC35D
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 06:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F060277C8D;
	Sat,  5 Jul 2025 06:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FKZDQhtR"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15450275AE6
	for <netdev@vger.kernel.org>; Sat,  5 Jul 2025 06:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751695655; cv=none; b=bmlLYTWxgQ0zXPJTC8JU1ZALReaSF8P72x45nK/W7H6QlYUbn124UaScQ3ssnz/Wy8p+xm//jV/893rcA0+UJ2hRo5qru6dOHHD9PJN4ynjjqGU2saRqhtxDmFt41XkWVcmvwnqFLtE9xtP1hnFvJ1SYMjfB+EiiKxOboFR9ih8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751695655; c=relaxed/simple;
	bh=NrT12kA5qjy5ZJ8dedsQeHk4B3Q8JNkXD5kOgaP4JoY=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=VBU7An6V1DR7iz6mfY9tYk/qeKpP1zodEs9vXpbMml8qjudBuAzxrri6GfgVhnTUotGwDFAkwleUgWIGLzisOXDy2b7+4CBzWVAPwL1UP/zEn/+NZY+DdX6PEv4ivi5n6nv/9pXxFCMdNBezad3FBSWWhkY2xFb0rq1ProvToiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FKZDQhtR; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751695640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OoyKvKGvOIY+YOUK48oOpXE0v1eQrruCiKGQYblUeLQ=;
	b=FKZDQhtREfyH1f1X4BX8cCxxOnFSsRs1+D9N7Sb6JyptsT4zg410KhBXcOKR4fuaZHZ5Yz
	PE3egEXoI9aayXiVC4cyXbKOYcUKKqvSXnVh5QGaprVycAHTQIUs4UbmG7FcpkOFl/FGiT
	qpFoZWQW3p0mpwXyCbVFrsyHYgEMqGo=
Date: Sat, 05 Jul 2025 06:07:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: qiang.zhang@linux.dev
Message-ID: <74395e33b2175fdb2745211c4ca41e5b2358d80d@linux.dev>
TLS-Required: No
Subject: Re: [bug report] [PATCH v6] net: usb: Convert tasklet API to new
 bottom half workqueue mechanism
To: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Jun Miao"
 <jun.miao@intel.com>
Cc: sbhatta@marvell.com, kuba@kernel.org, oneukum@suse.com,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <aGgD_Lp0i-ZU2xkt@pengutronix.de>
References: <20250618173923.950510-1-jun.miao@intel.com>
 <aGgD_Lp0i-ZU2xkt@pengutronix.de>
X-Migadu-Flow: FLOW_OUT

>=20
>=20Hi Jun,
>=20
>=20On Wed, Jun 18, 2025 at 01:39:23PM -0400, Jun Miao wrote:
>=20
>=20>=20
>=20> Migrate tasklet APIs to the new bottom half workqueue mechanism. It
> >=20
>=20>  replaces all occurrences of tasklet usage with the appropriate wor=
kqueue
> >=20
>=20>  APIs throughout the usbnet driver. This transition ensures compati=
bility
> >=20
>=20>  with the latest design and enhances performance.
> >=20
>=20
> After applying this patch, the smsc95xx driver fails after one down/up
>=20
>=20cycle.

Hello, Oleksij

Please try follow patch base on Jun Miao's patchs:

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 9564478a79cc..554f1a1cf247 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -953,6 +953,7 @@ int usbnet_open (struct net_device *net)
        dev->pkt_cnt =3D 0;
        dev->pkt_err =3D 0;
        clear_bit(EVENT_RX_KILL, &dev->flags);
+       enable_work(&dev->bh_work);
=20
=20       // delay posting reads until we're fully open
        queue_work(system_bh_wq, &dev->bh_work);


Thanks
Zqiang


>=20
>=20Here is how I can reproduce the issue:
>=20
>=20nmcli device set enu1u1 managed no
>=20
>=20ip a a 10.10.10.1/24 dev enu1u1
>=20
>=20ping -c 4 10.10.10.3
>=20
>=20ip l s dev enu1u1 down
>=20
>=20ip l s dev enu1u1 up
>=20
>=20ping -c 4 10.10.10.3
>=20
>=20The second ping does not reach the host. Networking also fails on oth=
er
>=20
>=20interfaces.
>=20
>=20After some delay, the following trace appears:
>=20
>=20[ 846.838527] INFO: task kworker/u16:1:308 blocked for more than 120 =
seconds.
>=20
>=20[ 846.838596] Not tainted 6.16.0-rc3-00963-g4fcedea9cdf2-dirty #32
>=20
>=20[ 846.838666] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disa=
bles this message.
>=20
>=20[ 846.838697] task:kworker/u16:1 state:D stack:0 pid:308 tgid:308 ppi=
d:2
>=20
>=20 task_flags:0x4208060 flags:0x00000010
>=20
>=20[ 846.838776] Workqueue: events_unbound linkwatch_event
>=20
>=20[ 846.838851] Call trace:
>=20
>=20[ 846.838880] __switch_to+0x1d0/0x330 (T)
>=20
>=20[ 846.838933] __schedule+0xa88/0x2a90
>=20
>=20[ 846.838980] schedule+0x114/0x428
>=20
>=20[ 846.839010] schedule_preempt_disabled+0x80/0x118
>=20
>=20[ 846.839036] __mutex_lock+0x764/0xba8
>=20
>=20[ 846.839060] mutex_lock_nested+0x28/0x38
>=20
>=20[ 846.839084] rtnl_lock+0x20/0x30
>=20
>=20[ 846.839115] linkwatch_event+0x18/0x70
>=20
>=20[ 846.839141] process_one_work+0x760/0x17b0
>=20
>=20[ 846.839175] worker_thread+0x768/0xce8
>=20
>=20[ 846.839208] kthread+0x3bc/0x690
>=20
>=20[ 846.839237] ret_from_fork+0x10/0x20
>=20
>=20[ 846.839359] INFO: task kworker/u16:1:308 is blocked on a mutex like=
ly
>=20
>=20owned by task ip:899.
>=20
>=20[ 846.839381] task:ip state:D stack:0 pid:899
>=20
>=20tgid:899 ppid:1 task_flags:0x400100 flags:0x00000019
>=20
>=20[ 846.839419] Call trace:
>=20
>=20[ 846.839432] __switch_to+0x1d0/0x330 (T)
>=20
>=20[ 846.839466] __schedule+0xa88/0x2a90
>=20
>=20[ 846.839495] schedule+0x114/0x428
>=20
>=20[ 846.839524] schedule_timeout+0xec/0x220
>=20
>=20[ 846.839551] wait_skb_queue_empty+0xa0/0x168
>=20
>=20[ 846.839581] usbnet_terminate_urbs+0x150/0x2c8
>=20
>=20[ 846.839609] usbnet_stop+0x41c/0x608
>=20
>=20[ 846.839636] __dev_close_many+0x1fc/0x4b8
>=20
>=20[ 846.839668] __dev_change_flags+0x33c/0x500
>=20
>=20[ 846.839694] netif_change_flags+0x7c/0x158
>=20
>=20[ 846.839718] do_setlink.isra.0+0x2040/0x2eb8
>=20
>=20[ 846.839745] rtnl_newlink+0xd88/0x16c8
>=20
>=20[ 846.839770] rtnetlink_rcv_msg+0x654/0x8c8
>=20
>=20[ 846.839795] netlink_rcv_skb+0x19c/0x350
>=20
>=20[ 846.839823] rtnetlink_rcv+0x1c/0x30
>=20
>=20[ 846.839848] netlink_unicast+0x3c4/0x668
>=20
>=20[ 846.839873] netlink_sendmsg+0x620/0xa10
>=20
>=20[ 846.839899] ____sys_sendmsg+0x2f8/0x788
>=20
>=20[ 846.839924] ___sys_sendmsg+0xf0/0x178
>=20
>=20[ 846.839950] __sys_sendmsg+0x104/0x198
>=20
>=20[ 846.839975] __arm64_sys_sendmsg+0x74/0xa8
>=20
>=20[ 846.840000] el0_svc_common.constprop.0+0xe4/0x338
>=20
>=20[ 846.840033] do_el0_svc+0x44/0x60
>=20
>=20[ 846.840061] el0_svc+0x3c/0xb0
>=20
>=20[ 846.840089] el0t_64_sync_handler+0x104/0x130
>=20
>=20[ 846.840117] el0t_64_sync+0x154/0x158
>=20
>=20[ 846.840164]
>=20
>=20[ 846.840164] Showing all locks held in the system:
>=20
>=20[ 846.840199] 1 lock held by khungtaskd/41:
>=20
>=20[ 846.840216] #0: ffffffc08424ede0 (rcu_read_lock){....}-{1:3}, at: d=
ebug_show_all_locks+0x14/0x1b0
>=20
>=20[ 846.840309] 3 locks held by kworker/u16:2/47:
>=20
>=20[ 846.840325] #0: ffffff800926a148 ((wq_completion)ipv6_addrconf){+.+=
.}-{0:0}, at: process_one_work+0x698/0x17b0
>=20
>=20[ 846.840406] #1: ffffffc0860f7c00 ((work_completion)(&(&net->ipv6.ad=
dr_chk_work)->work)){+.+.}-{0:0}, at: process_one_work+0x6bc/0x17b0
>=20
>=20[ 846.840484] #2: ffffffc084924408 (rtnl_mutex){+.+.}-{4:4}, at: rtnl=
_lock+0x20/0x30
>=20
>=20[ 846.840568] 2 locks held by pr/ttymxc1/60:
>=20
>=20[ 846.840595] 5 locks held by sugov:0/84:
>=20
>=20[ 846.840618] 2 locks held by systemd-journal/124:
>=20
>=20[ 846.840639] 3 locks held by kworker/u16:1/308:
>=20
>=20[ 846.840655] #0: ffffff8005d00148 ((wq_completion)events_unbound){+.=
+.}-{0:0}, at: process_one_work+0x698/0x17b0
>=20
>=20[ 846.840733] #1: ffffffc087307c00 ((linkwatch_work).work){+.+.}-{0:0=
}, at: process_one_work+0x6bc/0x17b0
>=20
>=20[ 846.840810] #2: ffffffc084924408 (rtnl_mutex){+.+.}-{4:4}, at: rtnl=
_lock+0x20/0x30
>=20
>=20[ 846.840894] 1 lock held by ip/899:
>=20
>=20[ 846.840910] #0: ffffffc084924408 (rtnl_mutex){+.+.}-{4:4}, at: rtnl=
_newlink+0x5e8/0x16c8
>=20
>=20[ 846.840982] 2 locks held by sshd/901:
>=20
>=20[ 846.840998] #0: ffffff800aee06b0 (nlk_cb_mutex-ROUTE){+.+.}-{4:4}, =
at: __netlink_dump_start+0x100/0x800
>=20
>=20[ 846.841073] #1: ffffffc084924408 (rtnl_mutex){+.+.}-{4:4}, at: rtnl=
_dumpit+0x128/0x1a8
>=20
>=20[ 846.841149] 2 locks held by sshd/903:
>=20
>=20[ 846.841165] #0: ffffff800b1c76b0 (nlk_cb_mutex-ROUTE){+.+.}-{4:4}, =
at: __netlink_dump_start+0x100/0x800
>=20
>=20[ 846.841237] #1: ffffffc084924408 (rtnl_mutex){+.+.}-{4:4}, at: rtnl=
_dumpit+0x128/0x1a8
>=20
>=20Reverting this patch recovers smsc95xx functionality.
>=20
>=20Best Regards,
>=20
>=20Oleksij
>

