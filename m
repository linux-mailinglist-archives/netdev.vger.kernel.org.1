Return-Path: <netdev+bounces-215851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D27B30A68
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 02:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 265012A4508
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 00:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF54126C1E;
	Fri, 22 Aug 2025 00:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4VCFcVU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480BF3C2F
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 00:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755822622; cv=none; b=ZQ7V8urc4raji2JRmWVexjGY82zm2XZQ2fisPMKCLGhPLTnMc8TR+UjQqAC5fm+kWbMH1r4NhL5fefOYvGcFEgXUcyQDXVikXQ6OB4A616sZ86+fdLDGr0P+SIh7FCQhcNrbPCrsxLGC7Bo6QcnH7WjzJZEbmbxctuXHT9AdF8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755822622; c=relaxed/simple;
	bh=7BDziKGy0nYnSWBVNd9Y5a/fWiagJtMenNbERVY62z4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CunyiHDiwwvywAG1zxnApYEG7PHCkmRnE07PycflIpOPnYaEv289mC4MchLuZjhRbSo+Na9kzWcjolHy9sp5sHuYNMlYV1bqviNqZCmWT5uWTroMPJJO2Zei22r/Wi0rdSK06xiUDIXR+dvsja6vVznKE1bKGlgIQs/2oE59hV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4VCFcVU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C636BC4CEED;
	Fri, 22 Aug 2025 00:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755822621;
	bh=7BDziKGy0nYnSWBVNd9Y5a/fWiagJtMenNbERVY62z4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r4VCFcVUOqFKQasKbMSVD1e7GJJ7Yq94Zh7XZXHQEfnBc460BPXaFvSUBnvI+mQHW
	 LMF4ggA8+sTKBOqBwJudBQXKKupmlUClsHOwmTVXuyw8nENcN/92rfGYytfIjkOtwW
	 ChxO81ClVPUvous5/b7+/yb3PnOW5h/v0WIswBFcsGhOxqWoQwk2AzRKONdOPHXisW
	 USggvjcyYHZpTUvC8jtA0Thv3GEnb+/0Dc3rCE2S/emYyzyR+Sum4HaOyYQ3cdiKSH
	 lB5xdqylwz+Gg+LnLkCqfwm+ytgBHwrAV2oILe2Rcp5FleispZDaHBjVnch834IGVF
	 hXg//iKHfAPDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CF3383BF68;
	Fri, 22 Aug 2025 00:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: fix stmmac_simple_pm_ops build
 errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175582263074.1251664.13209370832398636375.git-patchwork-notify@kernel.org>
Date: Fri, 22 Aug 2025 00:30:30 +0000
References: <E1uojpo-00BMoL-4W@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1uojpo-00BMoL-4W@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 20 Aug 2025 15:30:40 +0100 you wrote:
> The kernel test robot reports that various drivers have an undefined
> reference to stmmac_simple_pm_ops. This is caused by
> EXPORT_SYMBOL_GPL_SIMPLE_DEV_PM_OPS() defining the struct as static
> and omitting the export when CONFIG_PM=n, unlike DEFINE_SIMPLE_PM_OPS()
> which still defines the struct non-static.
> 
> Switch to using DEFINE_SIMPLE_PM_OPS() + EXPORT_SYMBOL_GPL(), which
> means we always define stmmac_simple_pm_ops, and it will always be
> visible for dwmac-* to reference whether modular or built-in.
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: fix stmmac_simple_pm_ops build errors
    https://git.kernel.org/netdev/net-next/c/dac72136aa6b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



