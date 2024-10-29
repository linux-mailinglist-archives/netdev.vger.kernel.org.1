Return-Path: <netdev+bounces-140192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 873BD9B580B
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 00:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B861A1C23008
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 23:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E594820C48F;
	Tue, 29 Oct 2024 23:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elXltplR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C071E204034
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 23:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730245827; cv=none; b=TSc94mumwLsLV2hfbq2yqcaZWtfcNuCPKISRiAkLrR9jxDj1dFLQ+T/DrO8CPLMK0wW3KPWYD5PtrlMmvwrikT7MAOFCKvELN9wY67niWtjkTKyh5/tZi+NymNPXdNIz4omfIAhCHuQ5Xdjp67yjRMeUIKprgrDG9QuFPL4enQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730245827; c=relaxed/simple;
	bh=hxuMv4hYF15Rom8kTXP47yN8NQXYaZ6uI0CE4JtdIBI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZUdNU3zM4HrkSF+9M3rdTwI78KKc3ODJNwls/CCbzFgR0HilJscCmSPieZaL65Zew3UB98Arlxp0EuG0P8dowOLTJjCM45/liZUUWs6DGJBhA0FcPaAN7D1P9hxKfr9sU+A2iCSfFwo1VFfcksxK1VSkr1zxMwDeDF3xcMdk0ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elXltplR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA10C4CEE7;
	Tue, 29 Oct 2024 23:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730245827;
	bh=hxuMv4hYF15Rom8kTXP47yN8NQXYaZ6uI0CE4JtdIBI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=elXltplRE2Yncv0/JqOlIyx8mOV3yLf0oSvOIMmvC/nuq3H+sFp/NvbcBNCDKE/Fa
	 ix+hqn6I0zCu/kDZaSQgBHkdF7x8YTdksHMGAQDCQFyhyvV4kfuIG+I0thl39Te4Rn
	 g7mkLTE9b/gpiLmXRm1qvK+54sFqS/ah/XEWv26cYaYpLW5aKrANvTJkMi3AfBK5wZ
	 9M8bFkirdQjFlQpJURBN3sRRVWMD2yRckErXphYXcbo7XPOtL33ESgd0iHrWUaZHbm
	 xzRlKu0zvopL79dIubOKj/j6pdNkvLSL3Fppzmo5yOA7y2cWwumVEx/vYT7d8SwUqS
	 qrvH0Z3FFr5tA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E3E380AC00;
	Tue, 29 Oct 2024 23:50:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: fix inconsistent indenting in
 rtl8169_get_eth_mac_stats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173024583502.858719.5118791991806206936.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 23:50:35 +0000
References: <20fd6f39-3c1b-4af0-9adc-7d1f49728fad@gmail.com>
In-Reply-To: <20fd6f39-3c1b-4af0-9adc-7d1f49728fad@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Oct 2024 22:48:59 +0200 you wrote:
> This fixes an inconsistent indenting introduced with e3fc5139bd8f
> ("r8169: implement additional ethtool stats ops").
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202410220413.1gAxIJ4t-lkp@intel.com/
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] r8169: fix inconsistent indenting in rtl8169_get_eth_mac_stats
    https://git.kernel.org/netdev/net-next/c/b8bd8c44a266

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



