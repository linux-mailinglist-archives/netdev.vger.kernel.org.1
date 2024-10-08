Return-Path: <netdev+bounces-132926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3C3993BD3
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 02:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA4D71C23EB4
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 00:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91A9182D2;
	Tue,  8 Oct 2024 00:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byXr/5C9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CC417C68;
	Tue,  8 Oct 2024 00:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728347432; cv=none; b=B0hRYHWKMGZMMs0gcNb3sWdG5/QFexSQU8ssl4qSkFOR1DFENKCWDfoWYbFDB+K19CqwrZ1wFlZrqQ5ECOrbSuX0ojxYidhTURPWufk9xTDON5vUXqHwRe84gdbduuv7P8PJbY+2FkBbO6/u83NNkia8P+HDV45/onVIMVty7Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728347432; c=relaxed/simple;
	bh=IqFHNR3lFHt7P7wOe3LfB4e2dlg8/UABeBYrFIjFnLY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Huo2pVRYAaA0QJUGg35m+ETF4bUFz78JuLe1b7xcq/a/U3FUEHhrjxSTEkzLqCxl6RG17rO2aoplqNeUJ9ElOlv+eXLa8DTNbRnO+YDu2ryNPW5aFU8NoIoJ6Y6hsy3Qgt3bZA4WKPwvNL++JbzIjTDkheAEu4CEx74j0skdthE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byXr/5C9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9613AC4CECF;
	Tue,  8 Oct 2024 00:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728347432;
	bh=IqFHNR3lFHt7P7wOe3LfB4e2dlg8/UABeBYrFIjFnLY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=byXr/5C93I+zvVngc4/eAxCHQZPzMDqNffaaG/7k4+tiJVawi7bllE6nSAwPaEEU4
	 3FVLPUm8HuxZnmwn5oDjFiuz0qIAOw4lGt0+UvCCT96DVy8cMKlYH1yxzSM44qSgVo
	 40fxU3J6n8D3csexm/7f7TPzJYDotaV08Vxt7dVau6VMl8lP97d1NAXmmuf8yDWBDu
	 CSTcJMkljwe9fmAI04scfdaR5H0sMLElG8LPaFlmQSKRrSpHDFR3WzXy71alu71G8F
	 Je3HEyUfrSCwxOm+zFiphzn4vpOAgXXV11k3YnAvUKSCjYGvqfK2cbNFAOkFT4vKWv
	 cVwc+8qk7ohmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1483803262;
	Tue,  8 Oct 2024 00:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: mxl-gpy: add missing support for
 TRIGGER_NETDEV_LINK_10
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172834743648.29256.12829684745666301581.git-patchwork-notify@kernel.org>
Date: Tue, 08 Oct 2024 00:30:36 +0000
References: <cc5da0a989af8b0d49d823656d88053c4de2ab98.1728057367.git.daniel@makrotopia.org>
In-Reply-To: <cc5da0a989af8b0d49d823656d88053c4de2ab98.1728057367.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: lxu@maxlinear.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 4 Oct 2024 16:56:35 +0100 you wrote:
> The PHY also support 10MBit/s links as well as the corresponding link
> indication trigger to be offloaded. Add TRIGGER_NETDEV_LINK_10 to the
> supported triggers.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/net/phy/mxl-gpy.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net-next] net: phy: mxl-gpy: add missing support for TRIGGER_NETDEV_LINK_10
    https://git.kernel.org/netdev/net-next/c/f95b4725e796

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



