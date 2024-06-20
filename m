Return-Path: <netdev+bounces-105224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F52910330
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02CE51C20D9F
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 11:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682711A4F20;
	Thu, 20 Jun 2024 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMRcyT5G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4370EEBE
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718883629; cv=none; b=NMx5gAmOzUZQbwLyAygk5kyJv8/EQS8ai72HoxT2+8Wv/rSNpECEu2DXgTe0aTbebdnZ8n8C1MBa1Cl7OzfmKgopZwOg85kSPbsH32ctE79oa1xoqA2PDxhlyY3vRhsGF29dxSvStdlBmRCEvoSLLrrI86aLi+703S8u7hXVe7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718883629; c=relaxed/simple;
	bh=fj1F1Y5rGjjynEwaL8zb0wiQfoYrb9ww0G8IQUOK7kc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r3425SLLtPLOHaKRWxaBzWbsP3bNpRTY7HmrIquNb+OVXV9PzRAyFxU+mNQ4fK7Y/3PYhMtjQDjf8zqQ4sTslguRv2WIHbYYF4j3XZRTuIxmuJd5sJkIpkkkMQDzwyDc7U2LCQYN3VAGAP2jZCH+unzWkkZg104rl/fnLyZF/Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMRcyT5G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3FCEC32786;
	Thu, 20 Jun 2024 11:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718883628;
	bh=fj1F1Y5rGjjynEwaL8zb0wiQfoYrb9ww0G8IQUOK7kc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RMRcyT5GggREb+OPqjktvnRVfz32aalw8hz6uDfzLmN11uAyxZ5dm9TAwup7h8Ld5
	 FjzdHK4GSdM/A+1kcX8/QknQDh59hhJfk8TWPt8TL3fzxR6ehCJrewE64OE7r0x+Ql
	 zGbZyGLoxCWa0ihTnbDz5eTy9J4c+p0XZVm5neEynxtwicUaUlMgLKD3oNa2lDa0jB
	 KqTjM5nd6y3tZj/pfe1lVSLbAp4FhBcravWz9n4uqJo1OGtV6rPSxQ0DchQBOqLkzw
	 0zVN/AMhc/MVr/Hp/qMKcjwxyCzKpKufdHQFNMFGVw9MAbF9AvuHhj8hCDGB6egDRr
	 RCInDlC9FSGiw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BF0E3C39563;
	Thu, 20 Jun 2024 11:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/3] add flow director for txgbe
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171888362877.30345.6475777776775825408.git-patchwork-notify@kernel.org>
Date: Thu, 20 Jun 2024 11:40:28 +0000
References: <20240618101609.3580-1-jiawenwu@trustnetic.com>
In-Reply-To: <20240618101609.3580-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, dumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew@lunn.ch, rmk+kernel@armlinux.org.uk,
 horms@kernel.org, netdev@vger.kernel.org, mengyuanlou@net-swift.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 18 Jun 2024 18:16:06 +0800 you wrote:
> Add flow director support for Wangxun 10Gb NICs.
> 
> v2 -> v3: https://lore.kernel.org/all/20240605020852.24144-1-jiawenwu@trustnetic.com/
> - Wrap the code at 80 chars where possible. (Jakub Kicinski)
> - Add function description address on kernel-doc. (Jakub Kicinski)
> - Correct return code. (Simon Horman)
> - Remove redundant size check. (Hariprasad Kelam)
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] net: txgbe: add FDIR ATR support
    https://git.kernel.org/netdev/net-next/c/b501d261a5b3
  - [net-next,v3,2/3] net: txgbe: support Flow Director perfect filters
    https://git.kernel.org/netdev/net-next/c/4bdb441105dc
  - [net-next,v3,3/3] net: txgbe: add FDIR info to ethtool ops
    https://git.kernel.org/netdev/net-next/c/34744a7749b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



