Return-Path: <netdev+bounces-240934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 612D5C7C2BA
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 03:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 095DB34A17A
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 02:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC5E26F476;
	Sat, 22 Nov 2025 02:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfTlm42D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76932A1AA;
	Sat, 22 Nov 2025 02:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763778042; cv=none; b=dkV1K+L38LgdrJpTM6b7jqpZ89Fb5sBxz+crdLeY3EVIV4D0osO4bCoxqo8fDD+0SfCohQMv3flJ0her+Z7HpnFtWJdlNFD2nqpkRGTgD7zsZAQ3NbCvqG5OeWMGtBg+b5lL5/YK6sfEOEdx/re33YAdY/EIV6VRxmoUDvY2EKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763778042; c=relaxed/simple;
	bh=8Ep1rCg829/oXBKGJtjkB9NIJmPXTlxwn4nVf42Q4SA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T/QXaAegtdilByIgFctmrL0BJnzaG/TnEL2UEQcBTDTVsitxmwI/ptGVr3jFwOzGBnZQQL3k9eMeB4dXOoAx/Z0mqcP65Pq7vKC7lHb21B7ymkdOZfNu2spxsjQQF5qn5r1HOJXFHynEuOn8LjniZMi/vtwKFeO0gkfogT5KMUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfTlm42D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44186C4CEF1;
	Sat, 22 Nov 2025 02:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763778042;
	bh=8Ep1rCg829/oXBKGJtjkB9NIJmPXTlxwn4nVf42Q4SA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gfTlm42DX6mCOI1OeiEIUXfyJh7niFj298wgovz9r6N8gA+wbWSJhyUxatD0YLQDx
	 tkvT2LmG2/Ck6AgzgPDosIP1Bcnr/f0oJ/X47Atvg2oyj+qtKZCzEht6txCcQyUdb0
	 a41Cj2NZrIwOUWHktg8Y0crNPyH0XvAJ0tREUzKnFRguEh6xRrDkP6xu4b1F02pcNo
	 zItiiZcCR0+dO3azS20LnyFj8fL+VyJhLlT1m77K7STa5pOVMBnEkXWmX01LMXmM3W
	 v7h7kvwk+fp+lTGDepJ2fnBZ8HKwZwZK0rFMUUiBHEDxuEIlkBa3+tRy1K/oPuIh9X
	 s9R1P0gmBMWuA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0DD3A78B25;
	Sat, 22 Nov 2025 02:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: mxl-gpy: fix bogus error on USXGMII and
 integrated PHY
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176377800676.2657243.13369818267269550167.git-patchwork-notify@kernel.org>
Date: Sat, 22 Nov 2025 02:20:06 +0000
References: 
 <f744f721a1fcc5e2e936428c62ff2c7d94d2a293.1763648168.git.daniel@makrotopia.org>
In-Reply-To: 
 <f744f721a1fcc5e2e936428c62ff2c7d94d2a293.1763648168.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: lxu@maxlinear.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Raju.Lakkaraju@microchip.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Nov 2025 14:17:13 +0000 you wrote:
> As the interface mode doesn't need to be updated on PHYs connected with
> USXGMII and integrated PHYs, gpy_update_interface() should just return 0
> in these cases rather than -EINVAL which has wrongly been introduced by
> commit 7a495dde27ebc ("net: phy: mxl-gpy: Change gpy_update_interface()
> function return type"), as this breaks support for those PHYs.
> 
> Fixes: 7a495dde27ebc ("net: phy: mxl-gpy: Change gpy_update_interface() function return type")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> 
> [...]

Here is the summary with links:
  - [net] net: phy: mxl-gpy: fix bogus error on USXGMII and integrated PHY
    https://git.kernel.org/netdev/net/c/ec3803b5917b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



