Return-Path: <netdev+bounces-226148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33484B9D002
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 03:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 575E019C57E5
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 01:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A2F2DD5F6;
	Thu, 25 Sep 2025 01:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LExT1vAh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DDF28CF66;
	Thu, 25 Sep 2025 01:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758763212; cv=none; b=PPxotaE6o4gtBXTmnUnifhYJgXkG9Igz1OtFXU+6TWsxZHyY0Jt3ViX5ENg7HeuByDLf0GGoK90mMGaH0+yscYAZ53tSw5RRAIn6T3TT9hWhkC5Tb8ahG6FxD845wj6ita6bxJ0/MgUI9ZK7qcMTa4vRzPBybOcks+DXLydt7mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758763212; c=relaxed/simple;
	bh=aBh85ZWr5ojCCkpHwSkwmxfofsf3Z7IYgyWeqdIPpi8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PBa2cOdfG7b0AbCVCgqrT2Ap9PPOLE21XtHSHTXN9rYRYjkF9G0XhbJkOZ/zlyYfahI/vqPJ07cat1tRVUaAOlvZhA1nvEtn7OKRAuE81nTteFj+ju/hwb8QFsIIJBTVwDzqi8pa2MW5bDvUAqCA4rc/iFGqKrSkg3c6HTeOPcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LExT1vAh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5FBCC4CEE7;
	Thu, 25 Sep 2025 01:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758763211;
	bh=aBh85ZWr5ojCCkpHwSkwmxfofsf3Z7IYgyWeqdIPpi8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LExT1vAhY78doWnPWwwJcxBvJEmiXeIU6CnXo/s/RVG56pLPcFYtvTO4O74RoFEJX
	 UiUUFVKb0r2Wb0gAFxGZWZR387QVQ/VSUBbsSAUYxrXTXVm6OwfcqpOuWN8ZdJdODJ
	 Ki4a1aokV9cTB+H/4DFFOyeqoHixxrGkLuW20purscPsAIO2U2ey2+pM++MscL31am
	 AsAjQfi9Lio5Tc5Q2ptxwc8uvhvvQki2SOvgWEv8P3g78HAwFPW8Mc2k+ekFd8YhLg
	 2VMSsq9MengjR9BeYlYtkMkw/aNtyMetff9QmslF7Tcuw6K/kAxyJ9EWqUNMcqyrGM
	 VJIMoFp5LKxrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DAC39D0C20;
	Thu, 25 Sep 2025 01:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: micrel: Fix default LED behaviour
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175876320725.2768103.8066350995981508489.git-patchwork-notify@kernel.org>
Date: Thu, 25 Sep 2025 01:20:07 +0000
References: <20250922130314.758229-1-horatiu.vultur@microchip.com>
In-Reply-To: <20250922130314.758229-1-horatiu.vultur@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Sep 2025 15:03:14 +0200 you wrote:
> By default the LED will be ON when there is a link but they are not
> blinking when there is any traffic activity. Therefore change this
> to blink when there is any traffic.
> 
> Fixes: 5a774b64cd6a ("net: phy: micrel: Add support for lan8842")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: micrel: Fix default LED behaviour
    https://git.kernel.org/netdev/net-next/c/cf7f0e3bd9fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



