Return-Path: <netdev+bounces-147944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4159DF385
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 23:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FAA4280E75
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 22:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CC61B4C30;
	Sat, 30 Nov 2024 22:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLPWJX3l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526BE1B3B28
	for <netdev@vger.kernel.org>; Sat, 30 Nov 2024 22:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733005220; cv=none; b=bImCdjwK8Kb0Coygu4E2i4xmCk7TN2ZPmnfDal8j+EWCGbtEqjUN7GCgOdUOeObj5+rebY7ELPzsNCFg9i5yxwbjMsmjIq5U7qlosLXfAzRWZxgaJaF5tDj7J4xIxLcr0GBZ49BtqUdD/sOU+VM/xbTClu7+zsONwJpf3kvFG+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733005220; c=relaxed/simple;
	bh=98HRPumpHVSqqY67GDueYHI2TpKgGKTG6NY4WWqEWy0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KQ/x554GNazq0z77JEZaFfjac6/OaE1cPcO9twbcYoA1b0AwAXOzcHdZ5G3vzWf4sFtSZtBqhcn5anQc7WRuaXWELqe7c8zWmU+Y5jhmtoxnXltQox+jTpC33QcSVy4seJQc2ufha/QUiTKk4hke6FpLZTLpnDkJ9wqGdKfNPx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLPWJX3l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63F8C4CECC;
	Sat, 30 Nov 2024 22:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733005218;
	bh=98HRPumpHVSqqY67GDueYHI2TpKgGKTG6NY4WWqEWy0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cLPWJX3l0qCIGzmDxORFfzJKjIOIkJSVVDqVs+MQKk5CoZPob9xK5ee/uAbTtCGll
	 rnKBXpqTlay8C7t89mFuZ9/8i3AKzyzJGNDpwRTaYOCG1WcEEhQHI9l55xjnnyujao
	 0h46E1rLUAXOWhPg9yfARMAk5YnPy6cVQG87l9YefhkKoq4eNr8dFlL20J2BXrVvSR
	 /7Ds6OSvZkTPchOLggv5/VWGlN7H6uLfV+/MeJKUC2smxRNkgpfw8voLgOlxcsZxWt
	 8ZZA4Olm3O1HVyHYi+WbsJLKR5zv5g38vDKDIyWNJRDDpvaxaO3YGtP6wdmbNHXfUq
	 8RWelTCwf+C4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE154380A944;
	Sat, 30 Nov 2024 22:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: Fix icmp host relookup triggering ip_rt_bug
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173300523224.2492979.16729601076665827822.git-patchwork-notify@kernel.org>
Date: Sat, 30 Nov 2024 22:20:32 +0000
References: <20241127040850.1513135-1-dongchenchen2@huawei.com>
In-Reply-To: <20241127040850.1513135-1-dongchenchen2@huawei.com>
To: Dong Chenchen <dongchenchen2@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, herbert@gondor.apana.org.au,
 steffen.klassert@secunet.com, netdev@vger.kernel.org, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 Nov 2024 12:08:50 +0800 you wrote:
> arp link failure may trigger ip_rt_bug while xfrm enabled, call trace is:
> 
> WARNING: CPU: 0 PID: 0 at net/ipv4/route.c:1241 ip_rt_bug+0x14/0x20
> Modules linked in:
> CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.0-rc6-00077-g2e1b3cc9d7f7
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> RIP: 0010:ip_rt_bug+0x14/0x20
> Call Trace:
>  <IRQ>
>  ip_send_skb+0x14/0x40
>  __icmp_send+0x42d/0x6a0
>  ipv4_link_failure+0xe2/0x1d0
>  arp_error_report+0x3c/0x50
>  neigh_invalidate+0x8d/0x100
>  neigh_timer_handler+0x2e1/0x330
>  call_timer_fn+0x21/0x120
>  __run_timer_base.part.0+0x1c9/0x270
>  run_timer_softirq+0x4c/0x80
>  handle_softirqs+0xac/0x280
>  irq_exit_rcu+0x62/0x80
>  sysvec_apic_timer_interrupt+0x77/0x90
> 
> [...]

Here is the summary with links:
  - [net,v3] net: Fix icmp host relookup triggering ip_rt_bug
    https://git.kernel.org/netdev/net/c/c44daa7e3c73

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



