Return-Path: <netdev+bounces-109097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0C1926D9D
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 04:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 457D72825F4
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 02:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0230117C67;
	Thu,  4 Jul 2024 02:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyqeilsp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1844179BF
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 02:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720061431; cv=none; b=JanVCXbMaSrwEXDigWU/zCRWwhACcGWCGg0mo5cjCWLStfM2CD0eXZGXsXevxrDrVCt+vcH3Gt7Pp5ExJP8TRZhgKVOzcdKWqjcMsOOfLN4tUQOgVx9nYSPGJn8UiLa2vIAIwKzSZybcLEtoLrOnZLmWPal0r027ml4rj2XmQeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720061431; c=relaxed/simple;
	bh=Xnglko4gkIl28XX6H7oc7DzlN+sO/jN9SIz0b+lNaz0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZQ3IbPw6uwcpcZuOpmidrJWazpTuDHfMeXjRqEl2Q8iledz9lCvub5k9qtBJPrErH5gzwWDKwbxAv3xMbWuWsn4k258Qa1JnK8/7TNr4gEcf7bBIj8uCddj635VVOF+PvY3/4Z34Dz+W4OXGXA3Q62lP9XLt9t12WxXg3s3MyqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pyqeilsp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40BCEC32781;
	Thu,  4 Jul 2024 02:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720061431;
	bh=Xnglko4gkIl28XX6H7oc7DzlN+sO/jN9SIz0b+lNaz0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pyqeilspVpa2eflAOXsCuRuvB5SmcA+mg6qNqcMJjv3/0+0pprqIY8g5W1X3kVebm
	 bKIzYgyo1HfYuWUq0i8AB0ZlcReUZ8IAv23rL1syuzvCboryLJrIdD+gV/ZuEOyywi
	 4YvMPkElTTVUOSkkDqcF6rNa0LwbWC2nOpso3NTEWVS0T87g055Pw5gydRuIKzhnPQ
	 NemCJ+sPqEKEztHIIr2fm4cfcXNrm02n0h83BVnu1raKBzWwTNGZ/V8wf9l4Rp6N5m
	 lglDDCmQ1USrh2yHR1s5/QESbXnq963XkIWfVpqrKhXFSHwsAuZuTOnXPJFv6EtVFy
	 2jixiCpQhB4sQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 318AEC43617;
	Thu,  4 Jul 2024 02:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v6] bonding: Fix out-of-bounds read in
 bond_option_arp_ip_targets_set()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172006143119.17004.14253482214488888073.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jul 2024 02:50:31 +0000
References: <20240702-bond-oob-v6-1-2dfdba195c19@kernel.org>
In-Reply-To: <20240702-bond-oob-v6-1-2dfdba195c19@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, j.vosburgh@gmail.com, andy@greyhouse.net,
 dingtianhong@huawei.com, liuhangbin@gmail.com, samsun1006219@gmail.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 02 Jul 2024 14:55:55 +0100 you wrote:
> From: Sam Sun <samsun1006219@gmail.com>
> 
> In function bond_option_arp_ip_targets_set(), if newval->string is an
> empty string, newval->string+1 will point to the byte after the
> string, causing an out-of-bound read.
> 
> BUG: KASAN: slab-out-of-bounds in strlen+0x7d/0xa0 lib/string.c:418
> Read of size 1 at addr ffff8881119c4781 by task syz-executor665/8107
> CPU: 1 PID: 8107 Comm: syz-executor665 Not tainted 6.7.0-rc7 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
>  print_address_description mm/kasan/report.c:364 [inline]
>  print_report+0xc1/0x5e0 mm/kasan/report.c:475
>  kasan_report+0xbe/0xf0 mm/kasan/report.c:588
>  strlen+0x7d/0xa0 lib/string.c:418
>  __fortify_strlen include/linux/fortify-string.h:210 [inline]
>  in4_pton+0xa3/0x3f0 net/core/utils.c:130
>  bond_option_arp_ip_targets_set+0xc2/0x910
> drivers/net/bonding/bond_options.c:1201
>  __bond_opt_set+0x2a4/0x1030 drivers/net/bonding/bond_options.c:767
>  __bond_opt_set_notify+0x48/0x150 drivers/net/bonding/bond_options.c:792
>  bond_opt_tryset_rtnl+0xda/0x160 drivers/net/bonding/bond_options.c:817
>  bonding_sysfs_store_option+0xa1/0x120 drivers/net/bonding/bond_sysfs.c:156
>  dev_attr_store+0x54/0x80 drivers/base/core.c:2366
>  sysfs_kf_write+0x114/0x170 fs/sysfs/file.c:136
>  kernfs_fop_write_iter+0x337/0x500 fs/kernfs/file.c:334
>  call_write_iter include/linux/fs.h:2020 [inline]
>  new_sync_write fs/read_write.c:491 [inline]
>  vfs_write+0x96a/0xd80 fs/read_write.c:584
>  ksys_write+0x122/0x250 fs/read_write.c:637
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> [...]

Here is the summary with links:
  - [net,v6] bonding: Fix out-of-bounds read in bond_option_arp_ip_targets_set()
    https://git.kernel.org/netdev/net/c/e271ff53807e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



