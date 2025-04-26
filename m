Return-Path: <netdev+bounces-186213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8702A9D737
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 04:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FF029E19C0
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 02:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C571EEA59;
	Sat, 26 Apr 2025 02:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GL7UsMEX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676784A02;
	Sat, 26 Apr 2025 02:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745633994; cv=none; b=XHsJsK4Tfuq8p2dReR14ocbg5wPHstJ66Mw67x661QR1hLTHsgWP8LFGINkPV1I9VoV5np8kyUP6JSc2eHkcZlvS2YN5q9cE946l5BFzZhbx5kjCIsAHhQCuExUrcrjlJ0nBiXHeSkHIxGEZ6+Wjkk729HJmN62LNbW3qAJfocQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745633994; c=relaxed/simple;
	bh=QI3VQECJ4VOdlU50ySozc+hha6S8Kroa22KH3HCcmkY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z334yEtO6YU/ALBREy5lFj11zDlFeYdHiMwaS6nie+bHYKg7WVh6peI1CgWvAVVqouUsFfHsq5MM4/qWLXos715JOZSZpEMrT1r1KYhEMeSC1utizTgUOCOqjj/vjp6jMQuhz5CP3cirhNwVgn9rLaipyQZFFyH9c4X8ydCMy4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GL7UsMEX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8ABAC4CEEA;
	Sat, 26 Apr 2025 02:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745633993;
	bh=QI3VQECJ4VOdlU50ySozc+hha6S8Kroa22KH3HCcmkY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GL7UsMEX78Zh+N77JaSubzMfpgbC7dG50JkgdpHT9X6GDrhJsm2OXUCUv+leRCp1I
	 Lst+qsLvXScNVjc0RYGvzz2sfM0dJQ/QAyapQsORbGwf/ENLKkAbegU09OXGCZXGNE
	 wDGa4qotkivXOx6mkmOZmv6wdQRyTbYoc31YfqrLlhplALHByyDnQciVo0hFp5i5gW
	 n8lganKfeVf85MBZpJCQUG9fGiZQpwzhrocn2pETrR2wquHCJMufS4Ma8t60X2lsWw
	 uKTPvyFpl9sDTlY/mB/dJsnHV4wVdfpvGJhiUYnkMSjXgWSij51/ttJV8SJIMfkiyJ
	 BboJhJeRHNoCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF6E380CFDC;
	Sat, 26 Apr 2025 02:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] net: ethernet: mtk-star-emac: fix several
 issues on rx/tx poll
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174563403253.3902866.2022861799721968649.git-patchwork-notify@kernel.org>
Date: Sat, 26 Apr 2025 02:20:32 +0000
References: <20250424-mtk_star_emac-fix-spinlock-recursion-issue-v2-0-f3fde2e529d8@collabora.com>
In-Reply-To: <20250424-mtk_star_emac-fix-spinlock-recursion-issue-v2-0-f3fde2e529d8@collabora.com>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: nbd@nbd.name, sean.wang@mediatek.com, lorenzo@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, biao.huang@mediatek.com,
 ot_yinghua.pan@mediatek.com, brgl@bgdev.pl, kernel@collabora.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Apr 2025 10:38:47 +0200 you wrote:
> This patchset fixes two issues with the mtk-star-emac driver.
> 
> The first patch fixes spin lock recursion issues I've observed on the
> Mediatek Genio 350-EVK board using this driver when the Ethernet
> functionality is enabled on the board (requires a correct jumper and
> DIP switch configuration, as well as enabling the device in the
> devicetree).
> The issues can be easily reproduced with apt install or ssh commands
> especially and with the CONFIG_DEBUG_SPINLOCK parameter, when
> one occurs, there is backtrace similar to this:
> ```
> BUG: spinlock recursion on CPU#0, swapper/0/0
>  lock: 0xffff00000db9cf20, .magic: dead4ead, .owner: swapper/0/0,
> 	.owner_cpu: 0
> CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted
> 	6.15.0-rc2-next-20250417-00001-gf6a27738686c-dirty #28 PREEMPT
> Hardware name: MediaTek MT8365 Open Platform EVK (DT)
> Call trace:
>  show_stack+0x18/0x24 (C)
>  dump_stack_lvl+0x60/0x80
>  dump_stack+0x18/0x24
>  spin_dump+0x78/0x88
>  do_raw_spin_lock+0x11c/0x120
>  _raw_spin_lock+0x20/0x2c
>  mtk_star_handle_irq+0xc0/0x22c [mtk_star_emac]
>  __handle_irq_event_percpu+0x48/0x140
>  handle_irq_event+0x4c/0xb0
>  handle_fasteoi_irq+0xa0/0x1bc
>  handle_irq_desc+0x34/0x58
>  generic_handle_domain_irq+0x1c/0x28
>  gic_handle_irq+0x4c/0x120
>  do_interrupt_handler+0x50/0x84
>  el1_interrupt+0x34/0x68
>  el1h_64_irq_handler+0x18/0x24
>  el1h_64_irq+0x6c/0x70
>  regmap_mmio_read32le+0xc/0x20 (P)
>  _regmap_bus_reg_read+0x6c/0xac
>  _regmap_read+0x60/0xdc
>  regmap_read+0x4c/0x80
>  mtk_star_rx_poll+0x2f4/0x39c [mtk_star_emac]
>  __napi_poll+0x38/0x188
>  net_rx_action+0x164/0x2c0
>  handle_softirqs+0x100/0x244
>  __do_softirq+0x14/0x20
>  ____do_softirq+0x10/0x20
>  call_on_irq_stack+0x24/0x64
>  do_softirq_own_stack+0x1c/0x40
>  __irq_exit_rcu+0xd4/0x10c
>  irq_exit_rcu+0x10/0x1c
>  el1_interrupt+0x38/0x68
>  el1h_64_irq_handler+0x18/0x24
>  el1h_64_irq+0x6c/0x70
>  cpuidle_enter_state+0xac/0x320 (P)
>  cpuidle_enter+0x38/0x50
>  do_idle+0x1e4/0x260
>  cpu_startup_entry+0x34/0x3c
>  rest_init+0xdc/0xe0
>  console_on_rootfs+0x0/0x6c
>  __primary_switched+0x88/0x90
> ```
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net: ethernet: mtk-star-emac: fix spinlock recursion issues on rx/tx poll
    https://git.kernel.org/netdev/net/c/6fe086601448
  - [net,v2,2/2] net: ethernet: mtk-star-emac: rearm interrupts in rx_poll only when advised
    https://git.kernel.org/netdev/net/c/e54b4db35e20

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



