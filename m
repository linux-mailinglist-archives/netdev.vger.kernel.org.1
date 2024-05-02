Return-Path: <netdev+bounces-93038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 812E68B9C98
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 16:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 079001F229A8
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 14:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379C4153563;
	Thu,  2 May 2024 14:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osdvTjIQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ABB14EC74
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714660833; cv=none; b=DFHN4uy7FS01a6z1YzOfRh4utAGIgQ2pJrmvsOXiJd4ALegK+4OHd3LivTPBEIyWANwrDDmdl/xmBchL22n6DhXCwq5MvM5a0ETjY5eEYu+GxcM50w2UOul98X37Lj3fCLc4jeOQb43NTy9BOARTUTJgXqprWhuM3906vCIeO5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714660833; c=relaxed/simple;
	bh=INfBFM3tiV8leWAR4U/L0riUpDiYTZi4XKMqrQ5f19o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SyPCJ48yRFb0UYluAzqXIchjExpNtfbb/gE0N6XQ5E2ww7BRL0QuY8zA5ur8MBHW9Bh8CSVy/wk9Z/8vrWvHZixGBph145QaOMx0mvS8DihOv5rbYcgszhu5NTaVRmGWMrcoIWFaOoKNbM2oVUVPcr3lkfstg4MSUNN7NdX01H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osdvTjIQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91183C32789;
	Thu,  2 May 2024 14:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714660832;
	bh=INfBFM3tiV8leWAR4U/L0riUpDiYTZi4XKMqrQ5f19o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=osdvTjIQFeVV2P1veVfuSmSJnvJavYeA7WyNLYu8hW+0cDilkHUtC4hqWfP45nyqm
	 qJbHUH48350GKAYJX49TaV7KYIfPhvGCJyPTqw7xwxkXH63S0RqC0VulFLcWs4s4E2
	 dK6NXx4NcJ8Jn3EfTFQbGma95DU4ERqUcX5+zNVybTBtb5M1POUdkrPCotmnX9cVNR
	 +qaH/ZX7Kn0Lbp3WNfdp57c9TA8jsICj4nOqB428pFaG2Kq8jwGHQDENuROI/zDCWP
	 E4TnMPGh4/BoTGAciunnwZ4Qv0MWCd4qCBQJh/vVGjfFAxnl2iz8FWK9wU0YRG7JkO
	 +UVo88ne6NcoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 82318C4333C;
	Thu,  2 May 2024 14:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/6] bnxt_en: Updates for net-next
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171466083252.8921.5531775388112291110.git-patchwork-notify@kernel.org>
Date: Thu, 02 May 2024 14:40:32 +0000
References: <20240501003056.100607-1-michael.chan@broadcom.com>
In-Reply-To: <20240501003056.100607-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew.gospodarek@broadcom.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 30 Apr 2024 17:30:50 -0700 you wrote:
> The first patch converts the sw_stats field in the completion
> ring structure to a pointer.  This allows the group of
> completion rings using the same MSIX to share the same sw_stats
> structure.  Prior to this, the correct completion ring must be
> used to count packets.
> 
> The next four patches remove the RTNL lock when calling the RoCE
> driver for asynchronous stop and start during error recovery and
> firmware reset.  The RTNL ilock is replaced with a private mutex
> used to synchronize RoCE register, unregister, stop, and start.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/6] bnxt_en: share NQ ring sw_stats memory with subrings
    https://git.kernel.org/netdev/net-next/c/a75fbb3aa47a
  - [net-next,v2,2/6] bnxt_en: Don't support offline self test when RoCE driver is loaded
    https://git.kernel.org/netdev/net-next/c/895621f1c816
  - [net-next,v2,3/6] bnxt_en: Don't call ULP_STOP/ULP_START during L2 reset
    https://git.kernel.org/netdev/net-next/c/f79d7a9f1c9d
  - [net-next,v2,4/6] bnxt_en: Add a mutex to synchronize ULP operations
    https://git.kernel.org/netdev/net-next/c/de21ec442d41
  - [net-next,v2,5/6] bnxt_en: Optimize recovery path ULP locking in the driver
    https://git.kernel.org/netdev/net-next/c/3c163f35bd50
  - [net-next,v2,6/6] bnxt_en: Add VF PCI ID for 5760X (P7) chips
    https://git.kernel.org/netdev/net-next/c/54d0b84f4002

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



