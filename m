Return-Path: <netdev+bounces-236391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06321C3B95B
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 15:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9933D188A440
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 14:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4C4333452;
	Thu,  6 Nov 2025 14:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4lExP0L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C738D7494
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 14:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762438241; cv=none; b=fO/d+HCl4sNEsP6sm3bk0SDVFWjAgTiQw1l8+FE1lx257oPDUVyjA/mk0DvwhLVDKCq3/MVZl58Hth8bDpXwcDSTRBRpXgelbhbS6RsyNzTGtdNhWckM1d6LB5NkXckfiED81oMHfsjoVBEpWkXP/ayXu2xdhz/4SHtYa1RDTF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762438241; c=relaxed/simple;
	bh=vO3HAZ7KyM8UA/AH+8L6Qo0caR5ru4pTX6o9OvDLDO0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C50IKu0+wKV0WYZVvR/AJytHXzYj+kfsPnlBWQtZ7BZXEyxDZ1FlvF7ztd9wE4V/LlxqlPfaVmzbk7D+VPmCui8u3196jc3zSn4x1rrLxpxskZOfcorPkQ3fkampCABfhbW9pf2hBJzEAD+L21CgrqBjdFwLHECQYV/SEexUFdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4lExP0L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E04AC4CEF7;
	Thu,  6 Nov 2025 14:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762438241;
	bh=vO3HAZ7KyM8UA/AH+8L6Qo0caR5ru4pTX6o9OvDLDO0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o4lExP0LsGebc+Nq5150dfMrrBzN8MUHzRBpKlQahgrMbFUmrocUtU9UWFJvH3T+G
	 Vipiw2YPQvY6IZ14dtf+5H2X5fW1JKvs3RXNoNQEoMcMWNUzHFSOdUhVVsME7nyyBL
	 tdlXws8wgHYfnInKZ4FQIk9oHbMY1EcLtp8kPRAtnzErOClIo3o4dD/rHcznM27H5A
	 L0Pm6jbaxeUE/zTmSZfOPqdmRt76uTNbjYIxvQTL6iD8sWqou4fezI7czawoPpIJsS
	 IkCRNYZlgm5XZr4zcHUbaRPLpztXWrYEl75ZSO98jbfdZDA6LfH14tb9/vCSetBfBX
	 OeM5NYW7XvPoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F0A39D0C9B;
	Thu,  6 Nov 2025 14:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/5] amd-xgbe: introduce support for ethtool
 selftests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176243821425.221682.16699614837258122691.git-patchwork-notify@kernel.org>
Date: Thu, 06 Nov 2025 14:10:14 +0000
References: <20251031111555.774425-1-Raju.Rangoju@amd.com>
In-Reply-To: <20251031111555.774425-1-Raju.Rangoju@amd.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 maxime.chevallier@bootlin.com, Shyam-sundar.S-k@amd.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 31 Oct 2025 16:45:51 +0530 you wrote:
> This patch series introduces support for ethtool selftests, which helps
> in finding the misconfiguration of HW. Makes use of network selftest
> packet creation infrastructure.
> 
> Supports the following tests:
> 
>  - MAC loopback selftest
>  - PHY loopback selftest
>  - Split header selftest
>  - Jubmo frame selftest
> 
> [...]

Here is the summary with links:
  - [net-next,v6,2/5] amd-xgbe: introduce support ethtool selftest
    https://git.kernel.org/netdev/net-next/c/862a64c83faf
  - [net-next,v6,3/5] amd-xgbe: add ethtool phy loopback selftest
    https://git.kernel.org/netdev/net-next/c/42b06fcc878d
  - [net-next,v6,4/5] amd-xgbe: add ethtool split header selftest
    https://git.kernel.org/netdev/net-next/c/d7735c6bb231
  - [net-next,v6,5/5] amd-xgbe: add ethtool jumbo frame selftest
    https://git.kernel.org/netdev/net-next/c/9c11b6b1abcd
  - [net-next,v6,1/5] net: selftests: export packet creation helpers for driver use
    https://git.kernel.org/netdev/net-next/c/6b47af35a6dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



