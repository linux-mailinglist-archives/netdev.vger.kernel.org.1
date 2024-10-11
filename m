Return-Path: <netdev+bounces-134724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA9D99AED3
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 00:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4477328587E
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 22:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA571E7645;
	Fri, 11 Oct 2024 22:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pS/NO1dC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E791E6DFF
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 22:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728687037; cv=none; b=H8fn2wkvH0ed/9ekqwdbYmlDP3oPh5Ta59hb4CFCxM0qElN2hWQjSzm+N8E0XX/J26reXn8f8ZXoDNxxtCwXt8cMHj7ZV/zHclU7uZMGFPwOUHh8d97gX0EYwEqjsBYftHhFAnmykI6TIO5x44i8cs2mIIrQzViKIHRlVZ4aJPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728687037; c=relaxed/simple;
	bh=tHn9ZA5WAy/QqpCsiHvIraa+HJy3I589bsbtOjbBggM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z29Bh+eNTtGJ0zBF5PYlDn2G4N93bMchszVy0Kp5IQRm8T3wOb7GZDvNU/XYQUIHI4mCUb6LjYZhYvhWVcqEenRU2PabFESVUvthaxW0PDYwMQVVpNvxjs8LW4393mih9oxuxp6qpojIXr9LtDyWHRDTf3rJ6tIThyuIo6/DMY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pS/NO1dC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C56C4CECE;
	Fri, 11 Oct 2024 22:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728687036;
	bh=tHn9ZA5WAy/QqpCsiHvIraa+HJy3I589bsbtOjbBggM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pS/NO1dCExZAqRNAMifDvIP6pdJ/Jtl7BOlUjTcg8DwDzpe11Tz/FDv7oCrAQGrgB
	 hkSvDzIj91YlTEAo7kgHhA5pnaQlGxrciy7FRKOSyRVziISCM1iej4ywOy9c82ME/A
	 CupkbgvzH1zXNMIJ3FeolJNXETqIG8ChcFbBkUpR54X3zfhI4Uo4Zv7Xjau6eCrrk+
	 I8xL9TKJGqjhnclesdWSL0xNLVIQ7cR8JQjTCUDABwCzZuYPElNNozSk8CxDVyhuOd
	 jv0l3urKLth8AbrBu7HqZIzkEEP9F51fkSW2fLJdK6VdGqtYJ+bySOxbinVJ7kEsk5
	 OtlCJQ0Xb7KRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE4538363CB;
	Fri, 11 Oct 2024 22:50:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] net: remove RTNL from fib_seq_sum()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172868704123.3018281.4916763990451712900.git-patchwork-notify@kernel.org>
Date: Fri, 11 Oct 2024 22:50:41 +0000
References: <20241009184405.3752829-1-edumazet@google.com>
In-Reply-To: <20241009184405.3752829-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, kuniyu@amazon.com, jiri@resnulli.us,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Oct 2024 18:44:00 +0000 you wrote:
> This series is inspired by a syzbot report showing
> rtnl contention and one thread blocked in:
> 
> 7 locks held by syz-executor/10835:
>   #0: ffff888033390420 (sb_writers#8){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2931 [inline]
>   #0: ffff888033390420 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x224/0xc90 fs/read_write.c:679
>   #1: ffff88806df6bc88 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x1ea/0x500 fs/kernfs/file.c:325
>   #2: ffff888026fcf3c8 (kn->active#50){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x20e/0x500 fs/kernfs/file.c:326
>   #3: ffffffff8f56f848 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: new_device_store+0x1b4/0x890 drivers/net/netdevsim/bus.c:166
>   #4: ffff88805e0140e8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
>   #4: ffff88805e0140e8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x8e/0x520 drivers/base/dd.c:1005
>   #5: ffff88805c5fb250 (&devlink->lock_key#55){+.+.}-{3:3}, at: nsim_drv_probe+0xcb/0xb80 drivers/net/netdevsim/dev.c:1534
>   #6: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: fib_seq_sum+0x31/0x290 net/core/fib_notifier.c:46
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] fib: rules: use READ_ONCE()/WRITE_ONCE() on ops->fib_rules_seq
    https://git.kernel.org/netdev/net-next/c/a716ff52bebf
  - [net-next,2/5] ipv4: use READ_ONCE()/WRITE_ONCE() on net->ipv4.fib_seq
    https://git.kernel.org/netdev/net-next/c/16207384d292
  - [net-next,3/5] ipv6: use READ_ONCE()/WRITE_ONCE() on fib6_table->fib_seq
    https://git.kernel.org/netdev/net-next/c/e60ea4544776
  - [net-next,4/5] ipmr: use READ_ONCE() to read net->ipv[46].ipmr_seq
    https://git.kernel.org/netdev/net-next/c/055202b16c58
  - [net-next,5/5] net: do not acquire rtnl in fib_seq_sum()
    https://git.kernel.org/netdev/net-next/c/2698acd6ea47

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



