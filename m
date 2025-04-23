Return-Path: <netdev+bounces-184932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AE7A97BD1
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 02:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 220F63B1EA2
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 00:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7842571C2;
	Wed, 23 Apr 2025 00:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krczq7IH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EA92566CF
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 00:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745369391; cv=none; b=WEE+QrvB0J3n1zIeETwv2cni7nvHVvGoahgi/C7IZlU17uCXNBU+5OOgCnkncxm2kPnPZl6ItANutBQiF0lArO+I4LR9kOI6YToRjPHuDl0GnLwUvhqzLobYrU5fgpFNJvHKlm4TPFlj/2oVjyLm3qEAO660gv9HVYvceXb+FKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745369391; c=relaxed/simple;
	bh=CqVzWcoxkBYMJ26ywjeE+aBNOgs9D0g0rJ7g2GKZ9EQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ONFkvwl6Hj29knmMDKxSpdIDq2MURlPz8AleecVygKjdBUFkp3B00ZFd8mQpuz5u1F3Nj0Zu0SshZddykDdIjo7W1LA0AY7CZXdRUZ+XfvKdo0MDyoA00CR5sDHclGVKIRURXYiHsVg0DEH5QQmV1HEDM+l2poR/11011/5OTdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krczq7IH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD33AC4CEE9;
	Wed, 23 Apr 2025 00:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745369390;
	bh=CqVzWcoxkBYMJ26ywjeE+aBNOgs9D0g0rJ7g2GKZ9EQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=krczq7IHOdJx3IgOeswAo4hLd2KBAw18afCiczljcGXjQVWMuNz/BBhZkKw2j3LF/
	 nbFF64T4EOh5ssCqg4zC3zWJfzRR/X8tc3WZStCSS1PYfOOrqH6H8FVp8BuuDgvMFe
	 EX4CV/fA3pCwmZqi+eWofojKl9WqZ3yiy/AIvY0qxfFs1B++BgChsHFMHGiFIFHl+2
	 rcvIzGhwyM2N6VG1Hf44+72O/wJihJqEwY6rxAq85HuJ75f37XQRCYq4gkGjFn1S0/
	 Cq6P2WnX8CVxTvV7WdnfT9TFefAZk6DaC5mo59WsA9Z4fhBx0YcrfSsN9hxooGN0cN
	 PCV2FDaD2eRag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D28380CEF4;
	Wed, 23 Apr 2025 00:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: use pci_prepare_to_sleep in rtl_shutdown
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174536942926.2100670.4564919760479410366.git-patchwork-notify@kernel.org>
Date: Wed, 23 Apr 2025 00:50:29 +0000
References: <f573fdbd-ba6d-41c1-b68f-311d3c88db2c@gmail.com>
In-Reply-To: <f573fdbd-ba6d-41c1-b68f-311d3c88db2c@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Apr 2025 11:25:18 +0200 you wrote:
> Use pci_prepare_to_sleep() like PCI core does in pci_pm_suspend_noirq.
> This aligns setting a low-power mode during shutdown with the handling
> of the transition to system suspend. Also the transition to runtime
> suspend uses pci_target_state() instead of setting D3hot unconditionally.
> 
> Note: pci_prepare_to_sleep() uses device_may_wakeup() to check whether
>       device may generate wakeup events. So we don't lose anything by
>       not passing tp->saved_wolopts any longer.
> 
> [...]

Here is the summary with links:
  - [net-next] r8169: use pci_prepare_to_sleep in rtl_shutdown
    https://git.kernel.org/netdev/net-next/c/b7ed5d5a78fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



