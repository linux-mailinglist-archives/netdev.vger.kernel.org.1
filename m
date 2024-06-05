Return-Path: <netdev+bounces-101011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 701128FCF76
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 15:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A0E21C2475E
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 13:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1850C1990AD;
	Wed,  5 Jun 2024 13:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DegvNTrT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E452E198848
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 13:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717593032; cv=none; b=S7xQ8CrZbHR5kQyLK60WTY0tbbamHDx6/EjMakEN8yQo1X/gBdu0K3XsAhWrzQ9jBZXp+rRky5XJaxsh2iF6xS1LyscJyfC0xRNOkz48MM+XdjTaucPbPg5G7gOIuhKbxYUGmSXlXBHGYgOzIgbxrwjvoz96Tv8uR1JhBfGt2Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717593032; c=relaxed/simple;
	bh=TFbTkeeINqvPsb4KCjjFEgO112fPF50XY35zw4Zs40E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s4YMFydvdP73ZdKeO5dSUU53Qr16hTwQvn39nzJD/dZLA7aPbRQ87gtmOht4l96+ftrIC+GoHfhCXQAYWLnuN6ax1W2nc3dn3nwrOXUC7bdMGPXl3hpz1+nIKagx/9GBI6bo7JsCbvs5zNrZcC105a1U36ZprDDNeYQFtVMfrWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DegvNTrT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77333C32781;
	Wed,  5 Jun 2024 13:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717593031;
	bh=TFbTkeeINqvPsb4KCjjFEgO112fPF50XY35zw4Zs40E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DegvNTrTfMpPYXgzBG1iltvezhjQmX1A45d3BD5Exl1+FQ9/KP9zbBPsu0bvi8QAd
	 LTpze3np0mDM8j7TdxmQTrGykpxDaGpBqIOcLBXyDI/iIM/RqEn8LM6vU3dl12dsLR
	 pG0GuNQprvxgEdb0KfXSlmdx3kdPf8KRF44Jhtb1K/MU/zcgh3kJ0czHKhqnQK2vfQ
	 SMLUOt9Ji8EDu9RtKveiCwU/uCGtuhVqTalde2DUXpIkeXbLsEGf6mjH6Nbjdf72uJ
	 XtI7oQRJU+7mFikMBtUiPMBCUNw9VEtZIATv1ACKJnoqH82lItBrlc8+Bz2BzlPVtY
	 Sf2SIaupERj2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5CF57C4332C;
	Wed,  5 Jun 2024 13:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] mlx5 core fixes 20240603
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171759303136.15829.1133546889266174138.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jun 2024 13:10:31 +0000
References: <20240603210443.980518-1-tariqt@nvidia.com>
In-Reply-To: <20240603210443.980518-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, saeedm@nvidia.com,
 gal@nvidia.com, leonro@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 4 Jun 2024 00:04:41 +0300 you wrote:
> Hi,
> 
> This small patchset provides two bug fixes from the team to the mlx5 core driver.
> 
> Series generated against:
> commit 33700a0c9b56 ("net/tcp: Don't consider TCP_CLOSE in TCP_AO_ESTABLISHED")
> 
> [...]

Here is the summary with links:
  - [net,1/2] net/mlx5: Stop waiting for PCI if pci channel is offline
    https://git.kernel.org/netdev/net/c/33afbfcc105a
  - [net,2/2] net/mlx5: Always stop health timer during driver removal
    https://git.kernel.org/netdev/net/c/c8b3f38d2dae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



