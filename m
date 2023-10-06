Return-Path: <netdev+bounces-38704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EDE7BC2D4
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 01:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16421281FE0
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 23:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A41745F75;
	Fri,  6 Oct 2023 23:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F64NvOSF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4593F45F65
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 23:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7ADDC433C8;
	Fri,  6 Oct 2023 23:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696633826;
	bh=iGGXiHCPBXXGPLXYhogX0uB7dLIdsJIP9zkVVpjuKN0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F64NvOSFDHsstNMHh/SPk3qVziCEuAiomhF3rSTAMMJAsQ1zlFgE74kyesOYKvUMS
	 n8VoBTGLsCBEleUfSFgihbCSJXoULN6BiZRouCdDpmYLXgXL0u0GoVR0v+LzvHp45u
	 1uoumfnl2mQgu0NsMcXj75J7bDvezdnX6MdhhSv5YGh06h4+uEv6rrYuxPC/tD/iwj
	 2nC1AKvVjzYtUTuOTJwawcA7Zhbimro8U/dIsmkeoAc9a3C5TOy8ROYHtXxHxjDY2a
	 iYYqfIngm1P46/VVF/Su1jIPF7IjiTMAzD9yDNjW8IqzEzz/YaNPJjAWRqbHLtPo8X
	 1zhXzDhT9tOZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B5572E632D2;
	Fri,  6 Oct 2023 23:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] net: phy: broadcom: add support for BCM5221 phy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169663382673.5705.11227398287831475925.git-patchwork-notify@kernel.org>
Date: Fri, 06 Oct 2023 23:10:26 +0000
References: <20231005182915.153815-1-giulio.benetti@benettiengineering.com>
In-Reply-To: <20231005182915.153815-1-giulio.benetti@benettiengineering.com>
To: Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 giulio.benetti+tekvox@benettiengineering.com, jimr@tekvox.com,
 jautry@tekvox.com, matthewm@tekvox.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Oct 2023 20:29:15 +0200 you wrote:
> From: Giulio Benetti <giulio.benetti+tekvox@benettiengineering.com>
> 
> This patch adds the BCM5221 PHY support by reusing brcm_fet_*()
> callbacks and adding quirks for BCM5221 when needed.
> 
> Cc: Jim Reinhart <jimr@tekvox.com>
> Cc: James Autry <jautry@tekvox.com>
> Cc: Matthew Maron <matthewm@tekvox.com>
> Signed-off-by: Giulio Benetti <giulio.benetti+tekvox@benettiengineering.com>
> 
> [...]

Here is the summary with links:
  - [v4] net: phy: broadcom: add support for BCM5221 phy
    https://git.kernel.org/netdev/net-next/c/3abbd0699b67

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



