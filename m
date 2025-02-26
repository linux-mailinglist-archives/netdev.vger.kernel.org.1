Return-Path: <netdev+bounces-169684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9E8A453D8
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 04:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 677053AAEDF
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 03:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C06234970;
	Wed, 26 Feb 2025 03:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENi69153"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2D722655F
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 03:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740539417; cv=none; b=BOalyiYEhAtYWXGfHwIN9PLfzcuU+9CwxgTQNL24yBMLhWWCzhqy66whr8ob1xDi1Ydy4LWvjxOFZFJLR53Gg4Tgs6vsqQzqWge5DXZBiK5eiEtF9mQiovYon8wgXe3Vtc39MUVmdYBH7GuWxaMMfewK12150pmZVJ9N7/nYr30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740539417; c=relaxed/simple;
	bh=EaM8nAcknuTEqgSWtgRX+O1SPtlqPr1RuKMMFdHdR3c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DUEu5PvlDHZA4jskC5/eyWaThc9UZln07j/WE52TwwFDuieJLkyMrk/SwxNWrauj4DNtKT72JJnCwVRNHUX6bgarvlq640JyVhsXxM/AH1bwlOfG1fGyydy2qe33BgFpoLuwRF0fC+G2A33SS143VC5Fl8uZpT7Pauhvp7ajc8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENi69153; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B799DC4CED6;
	Wed, 26 Feb 2025 03:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740539415;
	bh=EaM8nAcknuTEqgSWtgRX+O1SPtlqPr1RuKMMFdHdR3c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ENi69153t9+nKAboDE1j2k8m0xn5XVkoy5WArA25idCLXE2KRrnFftC1EokGlxaGZ
	 HhjBkzsCoFgm5soPcgidtOi1reK+q/VjngzTolfKYOhz+3UW+e6XTMWNjqrH2/bTWg
	 KASP/xdUFXcC8rsghNLTUEux9I2YsUXC4ZTDzIhKpUAoSb9Z78kGapkU6IECtml4vT
	 LtAx0o0rMDgTNrfKFoqUG1GzqFR3FZMANtDESWNIv9qNchraqzj4T0IowJXlXAOoro
	 umW9L0O2kvaBNRRoHQPAvZ32HOi3YxIYY9jrZxRmF2JBiYMu2zD/oEEKRCqLaXhe7Q
	 oIOfkpy0lf3jQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC8A380CFDD;
	Wed, 26 Feb 2025 03:10:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] net: stmmac: dwc-qos: clean up clock
 initialisation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174053944723.217003.15797703887455778925.git-patchwork-notify@kernel.org>
Date: Wed, 26 Feb 2025 03:10:47 +0000
References: <Z7yj_BZa6yG02KcI@shell.armlinux.org.uk>
In-Reply-To: <Z7yj_BZa6yG02KcI@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Feb 2025 16:53:16 +0000 you wrote:
> Hi,
> 
> My single v1 patch has become two patches as a result of the build
> error, as it appears this code uses "data" differently from others.
> v2 still produced build warnings despite local builds being clean,
> so v3 addresses those.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] net: stmmac: dwc-qos: name struct plat_stmmacenet_data consistently
    https://git.kernel.org/netdev/net-next/c/cff608268baf
  - [net-next,v3,2/2] net: stmmac: dwc-qos: clean up clock initialisation
    https://git.kernel.org/netdev/net-next/c/196b07ba9104

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



