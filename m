Return-Path: <netdev+bounces-224195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAB8B82285
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 00:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A20033A22B3
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 22:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFD630F92B;
	Wed, 17 Sep 2025 22:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTF+07cY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3530030F54C;
	Wed, 17 Sep 2025 22:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758148207; cv=none; b=gOQ8QOf0pY7qdHHrO5LzdG6pgfR0vLCoDkupq192ps/5ZUQDL3Kn/u1Vak5YVCHVNww9H+NL6srPzl5MaAMVQCGzGc4Iw8n35JQdxHt4dwhXMYQhOZUrPSQaGVDTA2wpT3beMU596T09/gnpVuLqv4TfQVdTW+JSeJahEZoJ8vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758148207; c=relaxed/simple;
	bh=s76GbDrYFwwZwSum2VWjLTNSOLDqXR0ee9PKdLqdIN4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sOc5KReCNUwhBKciK8mwoq2WjkWSVz681gWe8xxVrqnZICCRr17I2yEuSGEJT6i2Ex5yQW4HuXNKW1zPPqeaZ7dmy/WEJGCOTaKFMsAplV46ofF4euejVL0wO+DIMfd4SJfeeiJ8gclKKfGTtv9OOAi2OHbnhxh38AzuhGpTb04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTF+07cY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE635C4CEE7;
	Wed, 17 Sep 2025 22:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758148206;
	bh=s76GbDrYFwwZwSum2VWjLTNSOLDqXR0ee9PKdLqdIN4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XTF+07cY9h6ulIkYEmSAadUHSirIAkCR8PdSvFN1oItDmlNlxKzY+kznsK77kbpFE
	 BN1YJFtQ6eGSftAWvNzyYAEnBRlE0bEMhx91x/tm5D6MfP72y7vPB0B/M49qZrgSmX
	 XOVTqEYu5g7KbyvgnV1JbFjn2WVl8IqNrgIAqYSuN6Firz9MpGdPKhwbB42bik2GTM
	 jsch48DbkuV4HnJeV4OtZuIE2LgVxFI+D7+HI0olM7xXbyjkGeQst1hhMqTvs9LCH7
	 kGlq57ypU2AErDcAWg2ta4F74R6tI1v8bSCS050Vne2FjYx8PXe9LeTETfj8iU6WUA
	 DqpLpcLGV++kg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CCB39D0C28;
	Wed, 17 Sep 2025 22:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] Revert "net: ethernet: stmmac: dwmac-rk: Make
 the
 clk_phy could be used for external phy"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175814820725.2170568.16324588910347581106.git-patchwork-notify@kernel.org>
Date: Wed, 17 Sep 2025 22:30:07 +0000
References: <0A3F1D1604FEE424+20250916012628.1819-1-kernel@airkyi.com>
In-Reply-To: <0A3F1D1604FEE424+20250916012628.1819-1-kernel@airkyi.com>
To: Chaoyi Chen <kernel@airkyi.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk, jonas@kwiboo.se,
 david.wu@rock-chips.com, sebastian.reichel@collabora.com, ziyao@disroot.org,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, chaoyi.chen@rock-chips.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Sep 2025 09:26:28 +0800 you wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> This reverts commit da114122b83149d1f1db0586b1d67947b651aa20.
> 
> As discussed, the PHY clock should be managed by PHY driver instead
> of other driver like dwmac-rk.
> 
> [...]

Here is the summary with links:
  - [net-next] Revert "net: ethernet: stmmac: dwmac-rk: Make the clk_phy could be used for external phy"
    https://git.kernel.org/netdev/net-next/c/a09655dde754

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



