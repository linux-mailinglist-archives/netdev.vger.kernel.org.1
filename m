Return-Path: <netdev+bounces-199609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DE9AE0F9E
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 00:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BBA75A276A
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 22:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72EF2620FA;
	Thu, 19 Jun 2025 22:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qpoing9+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0862609F5;
	Thu, 19 Jun 2025 22:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750372184; cv=none; b=fGR41xH4Y6eN4+fOa3G1bnHdUXcu/4wT92o31y+ECMrs7u3OjN4E2P1TLj+iODnPMA7wysgdgEZnvxkloqWV9wnpfOr6wydBWXrfJUXmPhZpNCZeouyUZggGsEVZJkJgYRL0rOX0X2oQXkBzmhK1zHaWyx0A7Tc8ZAkDKcK07ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750372184; c=relaxed/simple;
	bh=uE1h3VBCq9FkWTRsFDM4zWbkP/DJUBaz2aRme8X4Zcg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S5M/sSyIfuQtANcgN2UfBVzB/bAbIX1hFnXN/bkXLBp/VSZj8vEAvKMS/tJVknq8G7jAWxMJHYnndwzsrkjTQzH5oLE2uWQ0x8tpvt+LbSyW9X9LEUPz4q3DY80YOMbny7Jsg/rmEqZ1/ioTxk5SsufgU8msNejEkTvrxpLApxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qpoing9+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BADC4CEEA;
	Thu, 19 Jun 2025 22:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750372184;
	bh=uE1h3VBCq9FkWTRsFDM4zWbkP/DJUBaz2aRme8X4Zcg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Qpoing9+7HNARwvNmhkAEPndGAgl3F0B9yk/yLR2qdZvw7rhrSoc5ImniCmLgKv0Z
	 014KsUD2lTwV0cmovedpd1DOQ1UM+dZHvqB2zpWnAv+RCvnmzs8kbUsDvdLTdw/u7I
	 IS5mfpRuU+ZlmkpXWvl1HHY4FlPGgVruoPPhB/cJNrQW86Afynf1dBpWysqil5f9di
	 X/ddP6M33PcmWVQHf+unpRQxhfSLI6xBDyc9pxng58P4empGzMaDqsvFVFx5vJ8skm
	 +3KhEml66/T+/+TvGzFRpuUg05d3TTbaRYknFLxmV4b1Dl74IJKDLQ2Wiv8lGSj/3k
	 FesZDO0UOzs6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F8D38111DD;
	Thu, 19 Jun 2025 22:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: replace ioaddr with stmmac_priv for
 pcs_set_ane() method
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175037221224.1006270.683992000903480141.git-patchwork-notify@kernel.org>
Date: Thu, 19 Jun 2025 22:30:12 +0000
References: <E1uRqbQ-004djP-1l@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1uRqbQ-004djP-1l@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com,
 vkoul@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Jun 2025 12:05:12 +0100 you wrote:
> Pass the stmmac_priv structure into the pcs_set_ane() MAC method rather
> than having callers dereferencing this structure for the IO address.
> 
> Tested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org> # sa8775p-ride-r3
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 2 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c    | 6 +++---
>  drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c       | 4 ++--
>  drivers/net/ethernet/stmicro/stmmac/hwif.h              | 4 ++--
>  drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c    | 2 +-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c       | 2 +-
>  6 files changed, 10 insertions(+), 10 deletions(-)

Here is the summary with links:
  - [net-next] net: stmmac: replace ioaddr with stmmac_priv for pcs_set_ane() method
    https://git.kernel.org/netdev/net-next/c/c8e32755ba2b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



