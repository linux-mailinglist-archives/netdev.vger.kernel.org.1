Return-Path: <netdev+bounces-122519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49875961922
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 23:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2D46B220B0
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 21:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76B71D417D;
	Tue, 27 Aug 2024 21:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D090luz3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6B91D4179;
	Tue, 27 Aug 2024 21:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724793638; cv=none; b=aXQ2lyS4tV9LXsg3Xh651xDsrQeLLkVeyt1Ele2cwAoLiKf23AI942oxcsMsYKl2dOcggm4HZEwpkLOm+mNjf8OaPr0BxX7GR0SJhjZI8A5bfkSBtB3FsogzKk2QlNIgf47y43mw2SxbIKOnkYZejMV2cYQnoKJy0dyIT6O36Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724793638; c=relaxed/simple;
	bh=6AdjvTP1MVp1SeDszmdKg0TqLaGfboVOdRJQCz8TUXs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nnWfMm7tE05wZsb9rEZZzz2E1grlokhNzOSeWEJUUdaVR9fUKl8lf07fEuBy+uNcR/HQH5gdKcJcRX0+P78wn+VOZeMKMNbxu5KCd4NZ0s5dA1oELCuFzvOycDNIukfsoF5mQNZz4b3pha9mlVsbi7RjYX99/IHZ6VGhksYCr30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D090luz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29871C4AF15;
	Tue, 27 Aug 2024 21:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724793638;
	bh=6AdjvTP1MVp1SeDszmdKg0TqLaGfboVOdRJQCz8TUXs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D090luz3int0y9B1OXRxf0fUCsBojLIS3jBRZH389kMSxivmAJDaxio0A7NOzqzyu
	 dRuB8kltSbwQXpzRQSK5uCwQ4FqTrxcpowkLzIenGEGbCiMuAC4iDjkI95bUpwFbf2
	 zE9nlZPAAlAUGcuYxxFu/E3K4a0VhEP2bICXbn2++9pgs19azL34dPdN37vIkmnAGF
	 it8NhUb9g5B5604rCzNdpndvI7A5hxW6xHXxnE+oSA1f+jp4f2kLHjvVAoAhJxBk9e
	 4umjfjN03O/KwCSXfXQpVibZJXVMdeXgepYKCwYLaBwG9fPFU7VaBCyDidgjgfJnpR
	 pI+QHgf06yY+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D183822D6D;
	Tue, 27 Aug 2024 21:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: thunderx: Remove unused declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172479363800.765313.3854499701349975014.git-patchwork-notify@kernel.org>
Date: Tue, 27 Aug 2024 21:20:38 +0000
References: <20240824082754.3637963-1-yuehaibing@huawei.com>
In-Reply-To: <20240824082754.3637963-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 24 Aug 2024 16:27:54 +0800 you wrote:
> Commit 4863dea3fab0 ("net: Adding support for Cavium ThunderX network
> controller") declared nicvf_qset_reg_{write,read}() but never implemented.
> 
> Commit 4863dea3fab0 ("net: Adding support for Cavium ThunderX network
> controller") declared bgx_add_dmac_addr() but no implementation.
> 
> After commit 5fc7cf179449 ("net: thunderx: Cleanup PHY probing code.")
> octeon_mdiobus_force_mod_depencency() is not used any more.
> 
> [...]

Here is the summary with links:
  - [net-next] net: thunderx: Remove unused declarations
    https://git.kernel.org/netdev/net-next/c/9a4556862d1f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



