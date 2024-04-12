Return-Path: <netdev+bounces-87339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB35A8A2C11
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 12:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66999281B82
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 10:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A523453393;
	Fri, 12 Apr 2024 10:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="m5g54edo"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB934E1D5
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 10:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712916911; cv=none; b=cJ3Z4G9aMqOZYXnEhBIPYsoY0VniU6GdVSzH7uVFh9eI00R9uOYKSLc2z52kUg2GaLUFI9bmLlWvE1FRmWupaBqu+zDoKdKBnwX++XayoZiUfuuKo0wpbOq2QGUnVxBuTD6JR7AB7nUtELN/oR5mWYt00Q2YeGRlXR6JEh7AMV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712916911; c=relaxed/simple;
	bh=yV7JHWmIoNj536WE04uKOD03moCU5VJCGc0rLBN/mhU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QKIbnhQIp5aR35+YF770DcWwDgqQcR6B+qDrG9Tp9H9hd1RUIKHPeFJgeEiJIuVUgL6/wZAftrZT2YxtAEyT/4ZWer8vCSsiTJ/dAbaOIdZVOf4SHZps63LY++NbWOAs7fjm30koviLe7/ILe3FV7owgIiHg1H/FRDV6U18bhdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=m5g54edo; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E2B2B1BF20A;
	Fri, 12 Apr 2024 10:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712916901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2/WBBV/OgKQCU1mPjDsK9QBfMHYu7OJA9p/mz4Oeesw=;
	b=m5g54edojVfOFd9fua/fQhtqItRMjdtjFOF3rb4aSFPAURcpWAnQW+PTOkbhmG8hDOEqKl
	spQVyhaCwILe3DsJ256icdYygcHBWqmu2BNkv8jC8zx3hBt4RLKFWu0luIgkjvQ/mGH4uf
	c0Ql7z0oRkMPxqbZthSmcedYrZph6aGuC1uB79LpKqDb9MWbWf7U1cwEx8WbUG0+ejxWKP
	2vQEwFzj3CeVX8tWQsmfdjGSKwgEWe7dA06B9IwufncjkwfII8sg/mJTw5+ks5VdtkMoWr
	66Vy0jk4C8QucJmWwbSG0dSPU94FP3qwdfDSEvMK4qLF8X1dbm3pIT/Xv4HKVw==
Date: Fri, 12 Apr 2024 12:15:00 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King - ARM Linux
 <linux@armlinux.org.uk>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: Crash in new PHY link topology extension
Message-ID: <20240412121500.2c57e6eb@device-28.home>
In-Reply-To: <a4a6df3b-550e-4868-973b-5218462bab1d@gmail.com>
References: <2e11b89d-100f-49e7-9c9a-834cc0b82f97@gmail.com>
	<a4a6df3b-550e-4868-973b-5218462bab1d@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Heiner,

On Fri, 12 Apr 2024 12:03:35 +0200
Heiner Kallweit <hkallweit1@gmail.com> wrote:

> On 12.04.2024 12:00, Heiner Kallweit wrote:
> > On today's linux-next I get the following.
> > 
> > Apr 12 11:36:03 zotac kernel: BUG: kernel NULL pointer dereference, address: 0000000000000018
> > Apr 12 11:36:03 zotac kernel: #PF: supervisor read access in kernel mode
> > Apr 12 11:36:03 zotac kernel: #PF: error_code(0x0000) - not-present page
> > Apr 12 11:36:03 zotac kernel: PGD 0 P4D 0
> > Apr 12 11:36:03 zotac kernel: Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> > Apr 12 11:36:03 zotac kernel: CPU: 1 PID: 219 Comm: systemd-network Not tainted 6.9.0-rc3-next-20240412+ #2
> > Apr 12 11:36:03 zotac kernel: Hardware name: Default string Default string/Default string, BIOS ADLN.M6.SODIMM.ZB.CY.015 08/08/2023
> > Apr 12 11:36:03 zotac kernel: RIP: 0010:__lock_acquire+0x5d/0x2550
> > Apr 12 11:36:03 zotac kernel: Code: 65 4c 8b 35 65 5d d1 7e 45 85 db 0f 84 bd 06 00 00 44 8b 15 f5 f8 14 01 45 89 c3 41 89 d7 45 89 c8 45 85
> >  d2 0f 84 c5 02 00 00 <48> 81 3f 00 f3 8a 82 44 0f 44 d8 83 fe 01 0f 86 bd 02 00 00 31 d2
> > Apr 12 11:36:03 zotac kernel: RSP: 0018:ffff9ca180e6f498 EFLAGS: 00010002
> > Apr 12 11:36:03 zotac kernel: RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> > Apr 12 11:36:03 zotac kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000018
> > Apr 12 11:36:03 zotac kernel: RBP: ffff9ca180e6f510 R08: 0000000000000000 R09: 0000000000000000
> > Apr 12 11:36:03 zotac kernel: R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
> > Apr 12 11:36:03 zotac kernel: R13: 0000000000000000 R14: ffff98e7c5b38000 R15: 0000000000000000
> > Apr 12 11:36:03 zotac kernel: FS:  00007f7e7440e0c0(0000) GS:ffff98e937a80000(0000) knlGS:0000000000000000
> > Apr 12 11:36:03 zotac kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > Apr 12 11:36:03 zotac kernel: CR2: 0000000000000018 CR3: 00000001027c0000 CR4: 0000000000750ef0
> > Apr 12 11:36:03 zotac kernel: PKRU: 55555554
> > Apr 12 11:36:03 zotac kernel: Call Trace:
> > Apr 12 11:36:03 zotac kernel:  <TASK>
> > Apr 12 11:36:03 zotac kernel:  ? show_regs+0x5f/0x70
> > Apr 12 11:36:03 zotac kernel:  ? __die+0x1f/0x70
> > Apr 12 11:36:03 zotac kernel:  ? page_fault_oops+0x15a/0x450
> > Apr 12 11:36:03 zotac kernel:  ? debug_smp_processor_id+0x17/0x20
> > Apr 12 11:36:03 zotac kernel:  ? rcu_is_watching+0x11/0x50
> > Apr 12 11:36:03 zotac kernel:  ? exc_page_fault+0x4cb/0x8d0
> > Apr 12 11:36:03 zotac kernel:  ? asm_exc_page_fault+0x27/0x30
> > Apr 12 11:36:03 zotac kernel:  ? __lock_acquire+0x5d/0x2550
> > Apr 12 11:36:03 zotac kernel:  ? __lock_acquire+0x3f8/0x2550
> > Apr 12 11:36:03 zotac kernel:  lock_acquire+0xc8/0x2f0
> > Apr 12 11:36:03 zotac kernel:  ? phy_link_topo_add_phy+0x153/0x1a0 [libphy]
> > Apr 12 11:36:03 zotac kernel:  _raw_spin_lock+0x2d/0x40
> > Apr 12 11:36:03 zotac kernel:  ? phy_link_topo_add_phy+0x153/0x1a0 [libphy]
> > Apr 12 11:36:03 zotac kernel:  phy_link_topo_add_phy+0x153/0x1a0 [libphy]
> > Apr 12 11:36:03 zotac kernel:  phy_attach_direct+0xcd/0x410 [libphy]
> > Apr 12 11:36:03 zotac kernel:  ? __pfx_r8169_phylink_handler+0x10/0x10 [r8169]
> > Apr 12 11:36:03 zotac kernel:  phy_connect_direct+0x21/0x70 [libphy]
> > Apr 12 11:36:03 zotac kernel:  rtl_open+0x30c/0x4f0 [r8169]
> > Apr 12 11:36:03 zotac kernel:  __dev_open+0xe8/0x1a0
> > Apr 12 11:36:03 zotac kernel:  __dev_change_flags+0x1c5/0x240
> > Apr 12 11:36:03 zotac kernel:  dev_change_flags+0x22/0x70
> > Apr 12 11:36:03 zotac kernel:  do_setlink+0xe9f/0x1290
> > Apr 12 11:36:03 zotac kernel:  ? __nla_validate_parse+0x60/0xce0
> > Apr 12 11:36:03 zotac kernel:  rtnl_setlink+0xff/0x190
> > Apr 12 11:36:03 zotac kernel:  ? __this_cpu_preempt_check+0x13/0x20
> > Apr 12 11:36:03 zotac kernel:  rtnetlink_rcv_msg+0x16e/0x660
> > Apr 12 11:36:03 zotac kernel:  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
> > Apr 12 11:36:03 zotac kernel:  netlink_rcv_skb+0x5a/0x110
> > Apr 12 11:36:03 zotac kernel:  rtnetlink_rcv+0x10/0x20
> > Apr 12 11:36:03 zotac kernel:  netlink_unicast+0x1a2/0x290
> > Apr 12 11:36:03 zotac kernel:  netlink_sendmsg+0x1f9/0x420
> > Apr 12 11:36:03 zotac kernel:  __sys_sendto+0x1d0/0x1e0
> > Apr 12 11:36:03 zotac kernel:  ? __seccomp_filter+0x22e/0x3b0
> > Apr 12 11:36:03 zotac kernel:  __x64_sys_sendto+0x1f/0x30
> > Apr 12 11:36:03 zotac kernel:  do_syscall_64+0x6c/0x140
> > Apr 12 11:36:03 zotac kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e  

I've had another similar report, I'll send a fix right-away.

Thanks for the report,

Maxime

> 
> Seems phy_link_topo_add_phy() can't deal with argument topo being NULL.
> 


