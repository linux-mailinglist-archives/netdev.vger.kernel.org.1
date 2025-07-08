Return-Path: <netdev+bounces-204773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8AFAFC07E
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 04:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D2904A368C
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 02:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD3C2165F3;
	Tue,  8 Jul 2025 02:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfXSKREn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22CB158538;
	Tue,  8 Jul 2025 02:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751940584; cv=none; b=Rq+bskrqKiIju7i4Ju3KDZCKHpsqtyX5ouYDeGj8bPXPUceQLGMeEVtUl1LOapeRX2FJmyx9eTNrqbOqEot/B/BiDg2g3dZrclIumRz66xFLriCXoFMNn0ygB98odp6hwIdMw46e4GLTBg7H/DkJahEbNffumWE8Mc06m5+DBOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751940584; c=relaxed/simple;
	bh=Y2HRJXm8RUdKfk7+RIco0EmNptQ798W6rD21ZSJGA28=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tXCXKklJzecgndaJIYKwXO1bnmQaZqXvM4RaMG8QcP1gR/MbKWder5SsuBe8Du9SawoJs+TT9rLS8FQgCgmZv8Q3pIf355VwcmY12w+o1623BfRWxlmYAZmsqO6RXLKAL+kt2mG5XDwy++df8KX0BMNISTd3xtPvMRR+TxWq6Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfXSKREn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9C3C4CEE3;
	Tue,  8 Jul 2025 02:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751940583;
	bh=Y2HRJXm8RUdKfk7+RIco0EmNptQ798W6rD21ZSJGA28=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SfXSKREnt7r6CswOP+sXwROAUdQDX0t3Sf1PI+OpRgAuRXodIf/Kehq/uFCuL0mfu
	 0NodUMAKATTEJzHxjCXLM2qoOSl+vPZ4ZA6maqpmfN+EkM7uWHhjVuzIyujvv/VMlB
	 gjU4g+sY2EZQrrKAEm474M2TYstIrwyqWzvA2ZpFqWrsDHkKstMM2CtV7HQ/9O4jab
	 SxF/RMAhlRYeOzvZUeefyw+si5H1ymGSz8VFFKtUB2Qmgs0G53lYApWox1xXiIubfO
	 AvMxWseXgRuyYuxVhrzhI3J+YpGxohpzYU5fTsOmvId3sUAJjax7b20/7Mhw1VdU8k
	 AfmtD8ueJq3vg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DFF38111DD;
	Tue,  8 Jul 2025 02:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: bcmgenet: Initialize u64 stats seq counter
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175194060626.3543842.7090318547175398332.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 02:10:06 +0000
References: <20250702092417.46486-1-ryotkkr98@gmail.com>
In-Reply-To: <20250702092417.46486-1-ryotkkr98@gmail.com>
To: Ryo Takakura <ryotkkr98@gmail.com>
Cc: horms@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, florian.fainelli@broadcom.com, kuba@kernel.org,
 opendmb@gmail.com, pabeni@redhat.com, zakkemble@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Jul 2025 18:24:17 +0900 you wrote:
> Initialize u64 stats as it uses seq counter on 32bit machines
> as suggested by lockdep below.
> 
> [    1.830953][    T1] INFO: trying to register non-static key.
> [    1.830993][    T1] The code is fine but needs lockdep annotation, or maybe
> [    1.831027][    T1] you didn't initialize this object before use?
> [    1.831057][    T1] turning off the locking correctness validator.
> [    1.831090][    T1] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W           6.16.0-rc2-v7l+ #1 PREEMPT
> [    1.831097][    T1] Tainted: [W]=WARN
> [    1.831099][    T1] Hardware name: BCM2711
> [    1.831101][    T1] Call trace:
> [    1.831104][    T1]  unwind_backtrace from show_stack+0x18/0x1c
> [    1.831120][    T1]  show_stack from dump_stack_lvl+0x8c/0xcc
> [    1.831129][    T1]  dump_stack_lvl from register_lock_class+0x9e8/0x9fc
> [    1.831141][    T1]  register_lock_class from __lock_acquire+0x420/0x22c0
> [    1.831154][    T1]  __lock_acquire from lock_acquire+0x130/0x3f8
> [    1.831166][    T1]  lock_acquire from bcmgenet_get_stats64+0x4a4/0x4c8
> [    1.831176][    T1]  bcmgenet_get_stats64 from dev_get_stats+0x4c/0x408
> [    1.831184][    T1]  dev_get_stats from rtnl_fill_stats+0x38/0x120
> [    1.831193][    T1]  rtnl_fill_stats from rtnl_fill_ifinfo+0x7f8/0x1890
> [    1.831203][    T1]  rtnl_fill_ifinfo from rtmsg_ifinfo_build_skb+0xd0/0x138
> [    1.831214][    T1]  rtmsg_ifinfo_build_skb from rtmsg_ifinfo+0x48/0x8c
> [    1.831225][    T1]  rtmsg_ifinfo from register_netdevice+0x8c0/0x95c
> [    1.831237][    T1]  register_netdevice from register_netdev+0x28/0x40
> [    1.831247][    T1]  register_netdev from bcmgenet_probe+0x690/0x6bc
> [    1.831255][    T1]  bcmgenet_probe from platform_probe+0x64/0xbc
> [    1.831263][    T1]  platform_probe from really_probe+0xd0/0x2d4
> [    1.831269][    T1]  really_probe from __driver_probe_device+0x90/0x1a4
> [    1.831273][    T1]  __driver_probe_device from driver_probe_device+0x38/0x11c
> [    1.831278][    T1]  driver_probe_device from __driver_attach+0x9c/0x18c
> [    1.831282][    T1]  __driver_attach from bus_for_each_dev+0x84/0xd4
> [    1.831291][    T1]  bus_for_each_dev from bus_add_driver+0xd4/0x1f4
> [    1.831303][    T1]  bus_add_driver from driver_register+0x88/0x120
> [    1.831312][    T1]  driver_register from do_one_initcall+0x78/0x360
> [    1.831320][    T1]  do_one_initcall from kernel_init_freeable+0x2bc/0x314
> [    1.831331][    T1]  kernel_init_freeable from kernel_init+0x1c/0x144
> [    1.831339][    T1]  kernel_init from ret_from_fork+0x14/0x20
> [    1.831344][    T1] Exception stack(0xf082dfb0 to 0xf082dff8)
> [    1.831349][    T1] dfa0:                                     00000000 00000000 00000000 00000000
> [    1.831353][    T1] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    1.831356][    T1] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> 
> [...]

Here is the summary with links:
  - [net,v2] net: bcmgenet: Initialize u64 stats seq counter
    https://git.kernel.org/netdev/net/c/ffc2c8c4a714

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



