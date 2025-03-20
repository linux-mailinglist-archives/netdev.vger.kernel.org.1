Return-Path: <netdev+bounces-176411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFB8A6A200
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 10:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E07BF1664BD
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 09:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D72B2206A9;
	Thu, 20 Mar 2025 08:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTvJsuwj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045E5220687;
	Thu, 20 Mar 2025 08:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742461197; cv=none; b=EAySInSYvnbXznn5/57CkbL4C0PZSlNfbJxysIFXleP1gBcDUpKZjpAsC1wse3BkCiPBKkxBBZhv0tCUcXHq/tbX7ZRocdEVwXu94KA+9gCF6LeyTiyVcMN0NtehivJrjFKtuMIg/CXKB5JtBnHNMx/CO3T5RAobcpb9lPBkjns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742461197; c=relaxed/simple;
	bh=KP5DLbCJulgRoFKv+2i9EXZEl0WABrzh7Q0EO7+EneM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ti4G1gzszMoVfHONU57OHI6AWPX+Cf5A4b/E+/VCKEtUklckLrXndAPsUXTKt8yMkHhbLpaVJzQdWl62E5WjEp+x/b/ey8x7eMW8KLZ+z41qBslz+Dm1ZwNSxLyrniV1i4WZ39UOHqGWShVp+zV33+YiQlChxATR3h8sfJQqWFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTvJsuwj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 718F9C4CEDD;
	Thu, 20 Mar 2025 08:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742461196;
	bh=KP5DLbCJulgRoFKv+2i9EXZEl0WABrzh7Q0EO7+EneM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KTvJsuwjnICAWuspdkkvvwUIYzc2VB+/4X3uQNHQr/zeIJ+F8cgJSvHZi7sEJiqJO
	 TTf3WEqw3zCVlF/YyXjEEBTn3OKuP2E5qTY6im/k3Bzy+egrZG16aSlwVoAokf0Y0b
	 oTdiuTt1FygDVZMmbptJYLKHGWI9k+D1ZOP9QH0R5o0oU4iRDltHJsDiZUIoNtppBe
	 jmleY1LW2Va45ZCbS3IWNGzuSa1vcv+rl39JDOY2okOi0MhB5hed7KtZLucZrOFMpx
	 mP9Y1WzKP62E1Hz4oDhtjD2jDn0lhMQxo1Kz1v9CmCQLdYbE7IgOSbA0AAnXW1BPuM
	 qUmoFCLXgxmfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 712493806654;
	Thu, 20 Mar 2025 09:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: vlan: don't propagate flags on open
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174246123226.1357755.15672961348464906574.git-patchwork-notify@kernel.org>
Date: Thu, 20 Mar 2025 09:00:32 +0000
References: <20250313100657.2287455-1-sdf@fomichev.me>
In-Reply-To: <20250313100657.2287455-1-sdf@fomichev.me>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 horms@kernel.org, aleksander.lobakin@intel.com,
 syzbot+b0c03d76056ef6cd12a6@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 13 Mar 2025 03:06:57 -0700 you wrote:
> With the device instance lock, there is now a possibility of a deadlock:
> 
> [    1.211455] ============================================
> [    1.211571] WARNING: possible recursive locking detected
> [    1.211687] 6.14.0-rc5-01215-g032756b4ca7a-dirty #5 Not tainted
> [    1.211823] --------------------------------------------
> [    1.211936] ip/184 is trying to acquire lock:
> [    1.212032] ffff8881024a4c30 (&dev->lock){+.+.}-{4:4}, at: dev_set_allmulti+0x4e/0xb0
> [    1.212207]
> [    1.212207] but task is already holding lock:
> [    1.212332] ffff8881024a4c30 (&dev->lock){+.+.}-{4:4}, at: dev_open+0x50/0xb0
> [    1.212487]
> [    1.212487] other info that might help us debug this:
> [    1.212626]  Possible unsafe locking scenario:
> [    1.212626]
> [    1.212751]        CPU0
> [    1.212815]        ----
> [    1.212871]   lock(&dev->lock);
> [    1.212944]   lock(&dev->lock);
> [    1.213016]
> [    1.213016]  *** DEADLOCK ***
> [    1.213016]
> [    1.213143]  May be due to missing lock nesting notation
> [    1.213143]
> [    1.213294] 3 locks held by ip/184:
> [    1.213371]  #0: ffffffff838b53e0 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock+0x1b/0xa0
> [    1.213543]  #1: ffffffff84e5fc70 (&net->rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock+0x37/0xa0
> [    1.213727]  #2: ffff8881024a4c30 (&dev->lock){+.+.}-{4:4}, at: dev_open+0x50/0xb0
> [    1.213895]
> [    1.213895] stack backtrace:
> [    1.213991] CPU: 0 UID: 0 PID: 184 Comm: ip Not tainted 6.14.0-rc5-01215-g032756b4ca7a-dirty #5
> [    1.213993] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
> [    1.213994] Call Trace:
> [    1.213995]  <TASK>
> [    1.213996]  dump_stack_lvl+0x8e/0xd0
> [    1.214000]  print_deadlock_bug+0x28b/0x2a0
> [    1.214020]  lock_acquire+0xea/0x2a0
> [    1.214027]  __mutex_lock+0xbf/0xd40
> [    1.214038]  dev_set_allmulti+0x4e/0xb0 # real_dev->flags & IFF_ALLMULTI
> [    1.214040]  vlan_dev_open+0xa5/0x170 # ndo_open on vlandev
> [    1.214042]  __dev_open+0x145/0x270
> [    1.214046]  __dev_change_flags+0xb0/0x1e0
> [    1.214051]  netif_change_flags+0x22/0x60 # IFF_UP vlandev
> [    1.214053]  dev_change_flags+0x61/0xb0 # for each device in group from dev->vlan_info
> [    1.214055]  vlan_device_event+0x766/0x7c0 # on netdevsim0
> [    1.214058]  notifier_call_chain+0x78/0x120
> [    1.214062]  netif_open+0x6d/0x90
> [    1.214064]  dev_open+0x5b/0xb0 # locks netdevsim0
> [    1.214066]  bond_enslave+0x64c/0x1230
> [    1.214075]  do_set_master+0x175/0x1e0 # on netdevsim0
> [    1.214077]  do_setlink+0x516/0x13b0
> [    1.214094]  rtnl_newlink+0xaba/0xb80
> [    1.214132]  rtnetlink_rcv_msg+0x440/0x490
> [    1.214144]  netlink_rcv_skb+0xeb/0x120
> [    1.214150]  netlink_unicast+0x1f9/0x320
> [    1.214153]  netlink_sendmsg+0x346/0x3f0
> [    1.214157]  __sock_sendmsg+0x86/0xb0
> [    1.214160]  ____sys_sendmsg+0x1c8/0x220
> [    1.214164]  ___sys_sendmsg+0x28f/0x2d0
> [    1.214179]  __x64_sys_sendmsg+0xef/0x140
> [    1.214184]  do_syscall_64+0xec/0x1d0
> [    1.214190]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [    1.214191] RIP: 0033:0x7f2d1b4a7e56
> 
> [...]

Here is the summary with links:
  - [net-next] net: vlan: don't propagate flags on open
    https://git.kernel.org/netdev/net-next/c/27b918007d96

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



