Return-Path: <netdev+bounces-136836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 228199A3301
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 04:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD4131F2327F
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 02:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22ABA56B81;
	Fri, 18 Oct 2024 02:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t82sFMyk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D5F51C4A
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 02:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729219825; cv=none; b=uNweUvPjksYr3rqD2B4J8/VC3Cd+yQUzdbYZjesBwQbJ5v6sN8aDRZp+KbBgry7djlcMWiySEngz7CUuT1nkO4hy2dOGhDBC9rSlHttkSzfj0+8EL1OUrrb4yO/sYmjOE1sZ8Jdu8R7rmPvoSAa0X1WYo+cBwOZmf8m9jLyWawo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729219825; c=relaxed/simple;
	bh=TV2vZOfHCYzI29IT082PlVZm8+DxBeGHheYHxpV28A8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u6uMidPXhYOvYXyOs5uZTRjHbeGhBpro+MWTbxlwFXkfIFituKnExkuTjTJ2T3G05QmPt5/y30NtUuc9rjQOvWZiS6nJqxpyOYbhRFBG2me/uxPQxhy56yxzKXv8QnsK5PfktQHJm6rauIUhhw7Y6777+Z80O1DVFfX+1rHedpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t82sFMyk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBD2C4CEC3;
	Fri, 18 Oct 2024 02:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729219824;
	bh=TV2vZOfHCYzI29IT082PlVZm8+DxBeGHheYHxpV28A8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t82sFMykzQEpfZSeeZ4n5Y1mqB6qfrEIeJXvvgb6lbSlVKYd5rnZybsbO5QnltehT
	 ZWhy20eaCmRX8zoqo+W/xN0vRdF8W3X/FyI30DD7f7LpJOryIsLkinUO2biOl4vGFH
	 K219DWkcucAVMyR/dPnmPBD54aOiEt/TJXPb74Not+fcdsU/uaLZscyzmUMHQlOSJs
	 G+tyuS1fD8iny7GzrsF79V8vF7v3akUjzLcrZshtDNtBsKXT7ovrTXV6uw/+Wfi5Lk
	 8bq/Ij4IuLYbA+83Q35LMEAopVXgUIQmRSi8hqm2qPga2pnFMsLUnsckXw4kqPE0zR
	 5sao5WktngWXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CBC3809A8A;
	Fri, 18 Oct 2024 02:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: airoha: Fix typo in REG_CDM2_FWD_CFG
 configuration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172921983001.2667083.1676500266510353428.git-patchwork-notify@kernel.org>
Date: Fri, 18 Oct 2024 02:50:30 +0000
References: <20241015-airoha-eth-cdm2-fixes-v1-1-9dc6993286c3@kernel.org>
In-Reply-To: <20241015-airoha-eth-cdm2-fixes-v1-1-9dc6993286c3@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: nbd@nbd.name, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, chihwei.cheng@airoha.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Andrew Lunn <andrew@lunn.ch>:

On Tue, 15 Oct 2024 09:58:09 +0200 you wrote:
> Fix typo in airoha_fe_init routine configuring CDM2_OAM_QSEL_MASK field
> of REG_CDM2_FWD_CFG register.
> This bug is not introducing any user visible problem since Frame Engine
> CDM2 port is used just by the second QDMA block and we currently enable
> just QDMA1 block connected to the MT7530 dsa switch via CDM1 port.
> 
> Introduced by commit 23020f049327 ("net: airoha: Introduce ethernet
> support for EN7581 SoC")
> 
> [...]

Here is the summary with links:
  - [net-next] net: airoha: Fix typo in REG_CDM2_FWD_CFG configuration
    https://git.kernel.org/netdev/net-next/c/30d9d8f6a2d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



