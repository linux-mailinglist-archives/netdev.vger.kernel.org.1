Return-Path: <netdev+bounces-177141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C54A6E063
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 18:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89B1F3A5C70
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 16:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552052641D1;
	Mon, 24 Mar 2025 17:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aG5BhD8d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D2C2641CA
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742835600; cv=none; b=SMdp57l+IqiUNmjz6fIUoBe353/T2rPPRF0YMEGYOU0I5i23IzgAv9ouMkyyVghqIRgJxQvqKxT/ZiQVJrfxtAoPvf/X5lyIkPnMFL3jRJvrFJ4nAlTcFKKGGRQLKALfYk7CmwY1eiHVfWor8x66s1CzzyLFwLgPoBu6TXd6jgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742835600; c=relaxed/simple;
	bh=/Ewt+WGZCnH3ZJSGrU9/UyMTTUyHOdYkvYjAQ9Ytk/A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AfdNZUwpDHss7iZquGDAl6itNTm10wiMB7xq8d8g1JIo++oYybySa4YFt5Th5Dccx0Y3IIbXrhU2gYnL8gIJkme6sU5zn69wUzWB9/C/r5DXDi6AisMRMbpwYbTU2MMbvvCWWS/XcUmD9ojtER9sbHAdHkSLIE4IooHC62lwh7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aG5BhD8d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B15C4CEEA;
	Mon, 24 Mar 2025 16:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742835599;
	bh=/Ewt+WGZCnH3ZJSGrU9/UyMTTUyHOdYkvYjAQ9Ytk/A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aG5BhD8d1Qe/dGivPijlYM7V0yH1dSnEs4oKThN25dX/9aQPfpiLCmiyej6cdXzyy
	 +rYbiUXIo15LyVfNYst4XD0TMle4bNtyZ288W087hBSznlLqbvRDaJLhmbCshKOYy8
	 6ZwvRF+9b/UB3IuSb/zNB9DSqCMufu7hJmvDGwHd+/6sUU20neC11mY4YDPzamwDfn
	 V9Pei7X/Iew+p9Vw1KfCLcvKKdNhRD8EslGsLaPghc/+EsUqFRxfcsZak6/la/q2GO
	 StbXwNbfyL7LPXjYU5r4OS3ByjPwF1OVNwx4bsx1ezOcXisdShgl4sWRn/xV83Yn6b
	 onaC4yxthPGaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB657380664D;
	Mon, 24 Mar 2025 17:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: ena: resolve WARN_ON when freeing IRQs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174283563576.4097226.15084775591948652066.git-patchwork-notify@kernel.org>
Date: Mon, 24 Mar 2025 17:00:35 +0000
References: <20250317071147.1105-1-darinzon@amazon.com>
In-Reply-To: <20250317071147.1105-1-darinzon@amazon.com>
To: David Arinzon <darinzon@amazon.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 ahmed.zaki@intel.com, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, richardcochran@gmail.com, dwmw@amazon.com,
 zorik@amazon.com, matua@amazon.com, saeedb@amazon.com, msw@amazon.com,
 aliguori@amazon.com, nafea@amazon.com, evgenys@amazon.com,
 netanel@amazon.com, alisaidi@amazon.com, benh@amazon.com, akiyano@amazon.com,
 ndagan@amazon.com, amitbern@amazon.com, shayagr@amazon.com,
 evostrov@amazon.com, ofirt@amazon.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Mar 2025 09:11:47 +0200 you wrote:
> When IRQs are freed, a WARN_ON is triggered as the
> affinity notifier is not released.
> This results in the below stack trace:
> 
> [  484.544586]  ? __warn+0x84/0x130
> [  484.544843]  ? free_irq+0x5c/0x70
> [  484.545105]  ? report_bug+0x18a/0x1a0
> [  484.545390]  ? handle_bug+0x53/0x90
> [  484.545664]  ? exc_invalid_op+0x14/0x70
> [  484.545959]  ? asm_exc_invalid_op+0x16/0x20
> [  484.546279]  ? free_irq+0x5c/0x70
> [  484.546545]  ? free_irq+0x10/0x70
> [  484.546807]  ena_free_io_irq+0x5f/0x70 [ena]
> [  484.547138]  ena_down+0x250/0x3e0 [ena]
> [  484.547435]  ena_destroy_device+0x118/0x150 [ena]
> [  484.547796]  __ena_shutoff+0x5a/0xe0 [ena]
> [  484.548110]  pci_device_remove+0x3b/0xb0
> [  484.548412]  device_release_driver_internal+0x193/0x200
> [  484.548804]  driver_detach+0x44/0x90
> [  484.549084]  bus_remove_driver+0x69/0xf0
> [  484.549386]  pci_unregister_driver+0x2a/0xb0
> [  484.549717]  ena_cleanup+0xc/0x130 [ena]
> [  484.550021]  __do_sys_delete_module.constprop.0+0x176/0x310
> [  484.550438]  ? syscall_trace_enter+0xfb/0x1c0
> [  484.550782]  do_syscall_64+0x5b/0x170
> [  484.551067]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: ena: resolve WARN_ON when freeing IRQs
    https://git.kernel.org/netdev/net-next/c/d39e08b0893b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



