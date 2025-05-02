Return-Path: <netdev+bounces-187357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 991F5AA682E
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 03:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F06D1BA5A91
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 01:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8038D1632F2;
	Fri,  2 May 2025 01:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNIiQfyQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D9E1607A4;
	Fri,  2 May 2025 01:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746148199; cv=none; b=ErCUrjMdRN9tKiVcYgVDUNMw4eR3UepU+xjJrcUVAUr8sgEswxEANYZu0iepELHBuK8KE217tLXUa7QlgpBsF+YFaYR7+W9PuoW4BOiN7SJOaOc1U4gWBj6vKtGsPqs4zlfCUNDh3Aaq/oyPFrSmPhAZjaidqtFLpSlcRNXoATM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746148199; c=relaxed/simple;
	bh=g3TIEEz6QIKR/QtPPbov0pjIsuJaIQiZ5zX0ImOQ65g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RpcHSPNeb9+tVvcVJM+0+z9XoI8L7gA4WO5ZL2lIdJk9QQHwujbV0PQrrK+r571zYGfetLGYIiKtoU6w1BswOXoPs4CyJbRiaxpjAO7NEGVA9Q7Fkk+X50+0QHR6q9wpiqpCSG3DO0msKSZpENmeQIhrBYFm1dUGe61PT6AAwlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNIiQfyQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD73C4CEED;
	Fri,  2 May 2025 01:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746148199;
	bh=g3TIEEz6QIKR/QtPPbov0pjIsuJaIQiZ5zX0ImOQ65g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RNIiQfyQKMbYJr+GH0Rg9tJL+SfU8HzfFSU53WmiuS/eKPNLNssZLHslpq9AeETch
	 1oBb3PNIIYka9ke7+pgw7oQOret1+EHAe8znJUnmGrEstpInsEuznvlPaKf+RgxQ5l
	 KmN8uCEAeNuyYVWi0DLwz5HWFWKZ6CeKw9K4fQPBK86+dlllMIHtMOA1X/huso+go2
	 SkE1tbzmbex0LwOrN1krervmIKyWEhtZOiu7Yv8xreYaSG8Wqk7soF4kD0mEikdkm/
	 l5T9zoPpjHweE4N6u91hDDXgTcllhw2hBOnJtTam7SRZWS+SesJBri3iXPNu0q/HnX
	 qncipP+9cadAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CD83822D59;
	Fri,  2 May 2025 01:10:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: ethernet: mtk_eth_soc: add support for
 MT7988 internal 2.5G PHY
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174614823799.3123530.13600729204126295734.git-patchwork-notify@kernel.org>
Date: Fri, 02 May 2025 01:10:37 +0000
References: <9072cefbff6db969720672ec98ed5cef65e8218c.1745715380.git.daniel@makrotopia.org>
In-Reply-To: <9072cefbff6db969720672ec98ed5cef65e8218c.1745715380.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: nbd@nbd.name, john@phrozen.org, frank-w@public-files.de,
 ericwouds@gmail.com, eladwf@gmail.com, bc-bocun.chen@mediatek.com,
 skylake.huang@mediatek.com, sean.wang@mediatek.com, lorenzo@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux@armlinux.org.uk,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 27 Apr 2025 02:01:29 +0100 you wrote:
> The MediaTek MT7988 SoC comes with an single built-in Ethernet PHY for
> 2500Base-T/1000Base-T/100Base-TX/10Base-T link partners in addition to
> the built-in 1GE switch. The built-in PHY only supports full duplex.
> 
> Add muxes allowing to select GMAC2->2.5G PHY path and add basic support
> for XGMAC as the built-in 2.5G PHY is internally connected via XGMII.
> The XGMAC features will also be used by 5GBase-R, 10GBase-R and USXGMII
> SerDes modes which are going to be added once support for standalone PCS
> drivers is in place.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: ethernet: mtk_eth_soc: add support for MT7988 internal 2.5G PHY
    https://git.kernel.org/netdev/net-next/c/51cf06ddafc9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



