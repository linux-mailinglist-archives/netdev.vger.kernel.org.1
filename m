Return-Path: <netdev+bounces-72371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA94857C38
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 13:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE0F51C20E51
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 12:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55A87866C;
	Fri, 16 Feb 2024 12:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFXXdF0Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917EE78664
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 12:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708084827; cv=none; b=vFT0bVNNEp7L02J/EZog78EoAYjO6Xrb9yePgF4AlVGDi3fMqBtesdZvsByHTYTvbeLNexo1JfJE9v57+m5vUBs+NS6d4LPhB5b3DCD8Y6vDhx7rhNsjlTswnThfe5OcuFizJr1ieBXHsKpKNnkqgVsSKENTrXEH5aSeF6QHgOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708084827; c=relaxed/simple;
	bh=vQwXoAcd4+u4Cw4/7jJsdXiiOO9hpzfflYs30JaVFNg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oCg6IaI2XnxZOOSu3dz180iLwpSYfABRZFQRE5yGEL8eJztjkQlwA0ghGSar5zbXO0z9XHOv7Ju9pTC//2yBN9gxYpSEaep8vu8jpQbJ931u0N8xlz7+NxXWPQ/PHxf7YM8SdcUBvGFh5ay/CaAdTDOi2FEnMmyJTKp2hMJZXk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFXXdF0Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A3C6C433F1;
	Fri, 16 Feb 2024 12:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708084827;
	bh=vQwXoAcd4+u4Cw4/7jJsdXiiOO9hpzfflYs30JaVFNg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bFXXdF0Q0NeKQFlbb60BtzczrRyg8gs9CIVAVkFhp6pbm7BW5DkadPo9DfEA7k12J
	 Ugl/cHy764lfuJNyFz4Pzpx1OnI9dvib1/METzYJ45vUHcTe0d9LVKQrMOdo+6aVW7
	 MhbpcgMMB+ATRmrogIBv+L8GpI7qb6Z0B2ZuUUtOyd2B5o3VHYjuLQLPHRKFOEYDd5
	 ar15mzkuO9bcFBFt2jMrFR8cUPXbxJv904oVay9Caw2EE0Qys5OTPixHVC+R82ACY4
	 7L8oNteSbcdKHMCykPvGuh+PgXC7b8Zlmoap3bEi4F7d6vhse8S0gBdtwkcZSuvQAR
	 JxPv2FoKQb0HQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F28CFD84BCD;
	Fri, 16 Feb 2024 12:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: ti: icssg-prueth: Remove duplicate cleanup
 calls in emac_ndo_stop()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170808482698.6309.10803815782224916695.git-patchwork-notify@kernel.org>
Date: Fri, 16 Feb 2024 12:00:26 +0000
References: <20240215152203.431268-1-diogo.ivo@siemens.com>
In-Reply-To: <20240215152203.431268-1-diogo.ivo@siemens.com>
To: Diogo Ivo <diogo.ivo@siemens.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
 jan.kiszka@siemens.com, dan.carpenter@linaro.org, robh@kernel.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 15 Feb 2024 15:22:01 +0000 you wrote:
> Remove the duplicate calls to prueth_emac_stop() and
> prueth_cleanup_tx_chns() in emac_ndo_stop().
> 
> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
> Reviewed-by: Roger Quadros <rogerq@kernel.org>
> Reviewed-by: MD Danish Anwar <danishanwar@ti.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: ti: icssg-prueth: Remove duplicate cleanup calls in emac_ndo_stop()
    https://git.kernel.org/netdev/net-next/c/1d085e9ce384

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



