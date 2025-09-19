Return-Path: <netdev+bounces-224692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 646A7B886E9
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 10:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AEAC3BD604
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 08:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA7F2E62D8;
	Fri, 19 Sep 2025 08:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nClz5dy3"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5092BD01B
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 08:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758270779; cv=none; b=utwvgf0C+bzBq1rEl5syeYchhXNrRApc+/kok5y+4344JL6ITZEbbcWoAaBKMCdq8f0xhI82X3on+lUwlUmRxG2q6wN2m4pRvz+ichbOlRuqNDwH+7kDUSGxIWR7r41RU1pqwcqS+KzolTZ8gfQVvzOA4deEj5UPo/G8XbK4vTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758270779; c=relaxed/simple;
	bh=a0jGbuINXDYYLHXrX6+Ip5hZUOHKxpyoBXTqd81umCk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MLa13PzRTfJwVN7r0EeJyv7bpEEusuoMHu0h3lj2GC6bxu3vfV9Hs82fkLiUGjY+4FweTwtG/Ew6kTUaOted5+O8sVc0ZILLZ0AsVErp1ah9TnOczc0rc+yPfpn1uE9S7K8uSR8v1Z0OPSTRDHtEyUcOjqGHPC3jVKHb/grX0i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nClz5dy3; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 2B0FEC8EC77;
	Fri, 19 Sep 2025 08:32:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CEAAB606A8;
	Fri, 19 Sep 2025 08:32:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C3354102F1D07;
	Fri, 19 Sep 2025 10:32:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758270768; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=aYSdvv1PGdJwPuRoTj/5x3ILygoqiHtqkDX7UP6C+Dk=;
	b=nClz5dy3UJ39xi0U6noITgt5NHEUm6oO1ha0PnBdfDaOwm8+x0bhPbBb3KSQm94KHGcl2t
	u+HQ/9nB3Rf5bzRM9ydQe1uyFDTOaokNI0Kn4YZlfgkOKWiaM/Z+UPc8A2b6ieCIF13moG
	corSAPx3GLssAcX79ej3TV+uNKdC8W5KtN7aqrP+x6VNIXj/Og3MfzwuGw5wLMjgb61ua5
	E/WdwxkoX4ICiMotZhMMJl3wGeV5bL4gaosK2ihAmiNI2rO4f4SWv/yu1HMn52g3GGImbz
	gCyGfH/VokpSWoFEGA9f/A7SqKgkKAza3mGoKxO+YZ7zgbUN+4UEmNfJkvS4Ug==
Date: Fri, 19 Sep 2025 10:32:32 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>, claudiu.manoil@nxp.com,
 xiaoning.wang@nxp.com, yangbo.lu@nxp.com, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Frank.Li@nxp.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: enetc: use generic interfaces to get
 phc_index for ENETC v1
Message-ID: <20250919103232.6d668441@kmaincent-XPS-13-7390>
In-Reply-To: <20250918124823.t3xlzn7w2glzkhnx@skbuf>
References: <20250918074454.1742328-1-wei.fang@nxp.com>
	<20250918124823.t3xlzn7w2glzkhnx@skbuf>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 18 Sep 2025 15:48:23 +0300
Vladimir Oltean <vladimir.oltean@nxp.com> wrote:

> On Thu, Sep 18, 2025 at 03:44:54PM +0800, Wei Fang wrote:
> > @@ -954,17 +957,9 @@ static int enetc_get_ts_info(struct net_device *nd=
ev,
> >  	if (!enetc_ptp_clock_is_enabled(si))
> >  		goto timestamp_tx_sw;
> > =20
> > -	if (is_enetc_rev1(si)) {
> > -		phc_idx =3D symbol_get(enetc_phc_index);
> > -		if (phc_idx) {
> > -			info->phc_index =3D *phc_idx; =20
>=20
> phc_idx remains unused in enetc_get_ts_info() after this change, and it
> produces a build warning.
>=20
> > -			symbol_put(enetc_phc_index);
> > -		}
> > -	} else {
> > -		info->phc_index =3D enetc4_get_phc_index(si);
> > -		if (info->phc_index < 0)
> > -			goto timestamp_tx_sw;
> > -	}
> > +	info->phc_index =3D enetc_get_phc_index(si);
> > +	if (info->phc_index < 0)
> > +		goto timestamp_tx_sw;
> > =20
> >  	enetc_get_ts_generic_info(ndev, info);
> >   =20
>=20
> Also, testing reveals:
>=20
> root@fii:~# ethtool -T eno2
> [   43.374227] BUG: sleeping function called from invalid context at
> kernel/locking/rwsem.c:1536 [   43.383268] in_atomic(): 0, irqs_disabled(=
):
> 0, non_block: 0, pid: 460, name: ethtool [   43.392076] preempt_count: 0,
> expected: 0 [   43.396454] RCU nest depth: 1, expected: 0
> [   43.400908] 3 locks held by ethtool/460:
> [   43.405206]  #0: ffffcb976c5fb608 (cb_lock){++++}-{4:4}, at:
> genl_rcv+0x30/0x60 [   43.412886]  #1: ffffcb976c5e9f88
> (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock+0x28/0x40 [   43.420931]  #2:
> ffffcb976c0b32d0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x4/0x=
48 [
>   43.429785] CPU: 1 UID: 0 PID: 460 Comm: ethtool Not tainted 6.17.0-rc5+
> #2920 PREEMPT [   43.429796] Call trace: [   43.429799]  show_stack+0x24/=
0x38
> (C) [   43.429814]  dump_stack_lvl+0x40/0xa0
> [   43.429822]  dump_stack+0x18/0x24
> [   43.429828]  __might_resched+0x200/0x218
> [   43.429837]  __might_sleep+0x54/0x90
> [   43.429844]  down_read+0x3c/0x1f0
> [   43.429852]  pci_get_slot+0x30/0x88
> [   43.429860]  enetc_get_ts_info+0x108/0x1a0
> [   43.429867]  __ethtool_get_ts_info+0x140/0x218
> [   43.429875]  tsinfo_prepare_data+0x9c/0xc8
> [   43.429881]  ethnl_default_doit+0x1cc/0x410
> [   43.429888]  genl_rcv_msg+0x2d8/0x358
> [   43.429896]  netlink_rcv_skb+0x124/0x148
> [   43.429903]  genl_rcv+0x40/0x60
> [   43.429910]  netlink_unicast+0x198/0x358
> [   43.429916]  netlink_sendmsg+0x22c/0x348
> [   43.429923]  __sys_sendto+0x138/0x1d8
> [   43.429928]  __arm64_sys_sendto+0x34/0x50
> [   43.429933]  invoke_syscall+0x4c/0x110
> [   43.429940]  el0_svc_common+0xb8/0xf0
> [   43.429946]  do_el0_svc+0x28/0x40
> [   43.429953]  el0_svc+0x4c/0xe0
> [   43.429960]  el0t_64_sync_handler+0x78/0x130
> [   43.429967]  el0t_64_sync+0x198/0x1a0
> [   43.429974]
> [   43.537263] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   43.541282] [ BUG: Invalid wait context ]
> [   43.545301] 6.17.0-rc5+ #2920 Tainted: G        W
> [   43.550891] -----------------------------
> [   43.554909] ethtool/460 is trying to lock:
> [   43.559016] ffffcb976c26ab80 (pci_bus_sem){++++}-{4:4}, at:
> pci_get_slot+0x30/0x88 [   43.566628] other info that might help us debug
> this: [   43.571694] context-{5:5}
> [   43.574317] 3 locks held by ethtool/460:
> [   43.578251]  #0: ffffcb976c5fb608 (cb_lock){++++}-{4:4}, at:
> genl_rcv+0x30/0x60 [   43.585603]  #1: ffffcb976c5e9f88
> (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock+0x28/0x40 [   43.593301]  #2:
> ffffcb976c0b32d0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x4/0x=
48 [
>   43.601786] stack backtrace: [   43.604672] CPU: 1 UID: 0 PID: 460 Comm:
> ethtool Tainted: G        W           6.17.0-rc5+ #2920 PREEMPT [
> 43.604679] Tainted: [W]=3DWARN [   43.604683] Call trace:
> [   43.604685]  show_stack+0x24/0x38 (C)
> [   43.604692]  dump_stack_lvl+0x40/0xa0
> [   43.604699]  dump_stack+0x18/0x24
> [   43.604706]  __lock_acquire+0xab4/0x31f8
> [   43.604713]  lock_acquire+0x11c/0x278
> [   43.604720]  down_read+0x6c/0x1f0
> [   43.604726]  pci_get_slot+0x30/0x88
> [   43.604732]  enetc_get_ts_info+0x108/0x1a0
> [   43.604738]  __ethtool_get_ts_info+0x140/0x218
> [   43.604745]  tsinfo_prepare_data+0x9c/0xc8
> [   43.604750]  ethnl_default_doit+0x1cc/0x410
> [   43.604757]  genl_rcv_msg+0x2d8/0x358
> [   43.604765]  netlink_rcv_skb+0x124/0x148
> [   43.604771]  genl_rcv+0x40/0x60
> [   43.604778]  netlink_unicast+0x198/0x358
> [   43.604784]  netlink_sendmsg+0x22c/0x348
> [   43.604790]  __sys_sendto+0x138/0x1d8
> [   43.604795]  __arm64_sys_sendto+0x34/0x50
> [   43.604799]  invoke_syscall+0x4c/0x110
> [   43.604806]  el0_svc_common+0xb8/0xf0
> [   43.604812]  do_el0_svc+0x28/0x40
> [   43.604818]  el0_svc+0x4c/0xe0
> [   43.604825]  el0t_64_sync_handler+0x78/0x130
> [   43.604832]  el0t_64_sync+0x198/0x1a0
> Time stamping parameters for eno2:
> Capabilities:
>         hardware-transmit
>         software-transmit
>         hardware-receive
>         software-receive
>         software-system-clock
>         hardware-raw-clock
> PTP Hardware Clock: 0
> Hardware Transmit Timestamp Modes:
>         off
>         on
>         onestep-sync
> Hardware Receive Filter Modes:
>         none
>         all
>=20
> It looks like we have a problem and can't call pci_get_slot(), which
> sleeps on down_read(&pci_bus_sem), from ethtool_ops :: get_ts_info(),
> which can't sleep, as of commit 4c61d809cf60 ("net: ethtool: Fix
> suspicious rcu_dereference usage").
>=20
> K=C3=B6ry, do you have any comments or suggestions? Patch is here:
> https://lore.kernel.org/netdev/20250918074454.1742328-1-wei.fang@nxp.com/

This is annoying indeed. I don't know how this enetc drivers works but why
ts_info needs this pci_get_slot() call? It seems this call seems to not be
used in ndo_hwtstamp_get/set while ts_info which does not need any hardware
communication report only a list of capabilities.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

