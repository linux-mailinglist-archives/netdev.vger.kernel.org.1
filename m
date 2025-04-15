Return-Path: <netdev+bounces-182862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B60AAA8A314
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 17:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1ED6190218D
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 15:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4530729B79D;
	Tue, 15 Apr 2025 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMeqfwmf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE96298CBE
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744731606; cv=none; b=uzM6NDcaPbRiktMYv3Y/lktJTz+Afmcn/q1szsn1E4pKf+qCEJTSZg+djAFukxq+KZWYEYvDUr14NbPvbxetYYqXJPMdmQT0IQ2b30DpxL2f3VP+udKiOhIOLOJoYzBhuNEcI1UICVkJkt4r+5xDNC6fp4FEQ8vUiwFQevkG3e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744731606; c=relaxed/simple;
	bh=TTwmd1qwkjcOawvuF4ndw/Outr89qvs8u05lc+zv+W8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EIVeXrhvwPwCfhcIdGEZiWtpFz3XnMMkNhTnpdATdZzopMWBY5GpimkY9FnXm+TIuEyf2jvlyK9nwEcq1MSA/w/gZ0HsQq+00qQy8dXYkVvgeyrObZ8guj5QHfEytRelXs00QbYBaA72UcOP5LZs5MxlnRUzI2jv94ssC0gpSVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMeqfwmf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C15FC4CEEC;
	Tue, 15 Apr 2025 15:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744731605;
	bh=TTwmd1qwkjcOawvuF4ndw/Outr89qvs8u05lc+zv+W8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AMeqfwmfD6A9pIDzu3d/lmYs1WsH0T9j6UvqjmHnx4SEQhytxzB6e1QvO8i48Yii3
	 8ElS2c3NgPgVOCI/xqx2lXz54ZLTbfWPTt7s5Bv6Gx+VzvLCdXzhNsobeFoJYcS+zh
	 vz0cyqL8vgBBW32ozO/XKk2sc+VNUVGGqAMFiV6UW/Sj1nU7TeVHHKxv967YysxwCf
	 5ab29NCzuhYCmZ7ZqdvarzZbDAhZMKDQ6zYtryOP7KXoaXaP93OTMlrzLjeWEmZcYd
	 yHQEoJ847f6DKOTWyHGZjpl/CicwY1tn626O4JUIRjVi6ABOyHWSB/dLUmewN23feX
	 kyLrtMUWmxVzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF113822D55;
	Tue, 15 Apr 2025 15:40:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: stmmac: ingenic: cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174473164325.2680773.1202751718118032665.git-patchwork-notify@kernel.org>
Date: Tue, 15 Apr 2025 15:40:43 +0000
References: <Z_0u9pA0Ziop-BuU@shell.armlinux.org.uk>
In-Reply-To: <Z_0u9pA0Ziop-BuU@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Apr 2025 16:51:18 +0100 you wrote:
> Hi,
> 
> Another series for another stmmac glue platform.
> 
> Convert Ingenic to use the stmmac platform PM ops and the
> devm_stmmac_pltfr_probe() helper.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: stmmac: ingenic: convert to stmmac_pltfr_pm_ops
    https://git.kernel.org/netdev/net-next/c/debfcb3f5848
  - [net-next,2/2] net: stmmac: ingenic: convert to devm_stmmac_pltfr_probe()
    https://git.kernel.org/netdev/net-next/c/96f8bf85d11a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



