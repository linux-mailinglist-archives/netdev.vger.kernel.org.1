Return-Path: <netdev+bounces-199295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1E2ADFB18
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 04:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A33EE189636A
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 02:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68661FBE8A;
	Thu, 19 Jun 2025 02:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akMdPCog"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81797195B1A
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 02:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750298989; cv=none; b=iwarQWxjaySFmY1HWVHYC7sBC2P1I/fk1UzNfjTBMaYiq8I2xYRpdpoT2CgAqlxt43Ogni40bI0wTRJuU12u+ObdlNsXRjusPwnlJOR/fqkEGkErNPzmRtaEtgLjETehlw1+gd2kQOh1axAe9NSiwwaywelEUeukIGPya6jQqWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750298989; c=relaxed/simple;
	bh=SJMO4nk/IarxXrasmEIiA82qDuaOGS4bFyUeu/XJPI0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OS0TDKj6cXAadf1P2NzS11y7+j9Nomc/rEYR3Izm4eZ7WjZaS53rwoJUmmSbQN0uobrEB350DFA82wSYjwbxzm599tIPsBecUCEI/nEvlhlvaWHm2ceV7LyBdX2GdLpmiWJkQyQYhaPZmBlC7E1PV5MFn4PTMVBxGrOeW1PA1ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akMdPCog; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3A0C4CEE7;
	Thu, 19 Jun 2025 02:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750298989;
	bh=SJMO4nk/IarxXrasmEIiA82qDuaOGS4bFyUeu/XJPI0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=akMdPCogD2u5Af8/lgpXQfJCzxvtaNzgGvT5uRpVtD0ER9SlXK/Pfe05UHKVDCauu
	 sKkIy9BKvlBRVQKh8b4hnygc0bs8BOZvxXh2t1276FLCb8EW63jhovvmGy8nXwLmFG
	 x5UQMszhku0weP+TfgKV+JHUOvnUbhe5YZpyXEeG581TBW+rhHv0y4b3ld6o8aqALg
	 nClcyQyz0F5dt3IWJuI6u2aHwVZG+P0q47yy3bGrha2We+mKnJImdAJPzj462UaD3N
	 3XSba9nCmHLo2mg4WPWs/QwtMwY3kQmGJurBfHIXtliCCIGDRSx5STOMFzvi61QkZY
	 3ot2FJaTXQXRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EAC3806649;
	Thu, 19 Jun 2025 02:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v13 net-next 0/9] PHC support in ENA driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175029901725.322395.7808420069986562189.git-patchwork-notify@kernel.org>
Date: Thu, 19 Jun 2025 02:10:17 +0000
References: <20250617110545.5659-1-darinzon@amazon.com>
In-Reply-To: <20250617110545.5659-1-darinzon@amazon.com>
To: David Arinzon <darinzon@amazon.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 richardcochran@gmail.com, dwmw@amazon.com, zorik@amazon.com,
 matua@amazon.com, saeedb@amazon.com, msw@amazon.com, aliguori@amazon.com,
 nafea@amazon.com, evgenys@amazon.com, netanel@amazon.com,
 alisaidi@amazon.com, benh@amazon.com, akiyano@amazon.com, ndagan@amazon.com,
 amitbern@amazon.com, shayagr@amazon.com, evostrov@amazon.com,
 ofirt@amazon.com, maciek@machnikowski.net, rrameshbabu@nvidia.com,
 gal@nvidia.com, vadim.fedorenko@linux.dev, andrew@lunn.ch, leon@kernel.org,
 jiri@resnulli.us

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Jun 2025 14:05:36 +0300 you wrote:
> Changes in v13
> - Remove unnecessary out-of-tree driver documentation
> 
> Changes in v12 (https://lore.kernel.org/netdev/20250611092238.2651-1-darinzon@amazon.com/):
> - Add devlink port support
> - Remove unnecessary checks from devlink reload up and reload down
> 
> [...]

Here is the summary with links:
  - [v13,net-next,1/9] net: ena: Add PHC support in the ENA driver
    https://git.kernel.org/netdev/net-next/c/e0ea34158ee8
  - [v13,net-next,2/9] net: ena: PHC silent reset
    https://git.kernel.org/netdev/net-next/c/51d58804a53b
  - [v13,net-next,3/9] net: ena: Add device reload capability through devlink
    https://git.kernel.org/netdev/net-next/c/15115b1a2554
  - [v13,net-next,4/9] net: ena: Add devlink port support
    https://git.kernel.org/netdev/net-next/c/9d67d534e4e0
  - [v13,net-next,5/9] devlink: Add new "enable_phc" generic device param
    https://git.kernel.org/netdev/net-next/c/cea465a96a29
  - [v13,net-next,6/9] net: ena: Control PHC enable through devlink
    https://git.kernel.org/netdev/net-next/c/816b52624cf6
  - [v13,net-next,7/9] net: ena: Add debugfs support to the ENA driver
    https://git.kernel.org/netdev/net-next/c/60e28350b1ca
  - [v13,net-next,8/9] net: ena: View PHC stats using debugfs
    https://git.kernel.org/netdev/net-next/c/e14521e97b83
  - [v13,net-next,9/9] net: ena: Add PHC documentation
    https://git.kernel.org/netdev/net-next/c/c9223021433d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



