Return-Path: <netdev+bounces-97513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C398CBCD1
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 10:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60442282F7B
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 08:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D3E7F7D1;
	Wed, 22 May 2024 08:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYHZM/YC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603A17F7C6;
	Wed, 22 May 2024 08:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716366029; cv=none; b=uQpkkm4fJcTu3s79Br6Ovl3EYosmx7lDUBd8qDGwQoSGEUrq475N7+q7glUY0+LRc9DqVcgGIouJg9ZTdczYKO84t/hUDdi8hQloqSLWfE2zRkE/KLdTmHiKdeEc1j9os19fjBE863iD4HurC00KDfjhTZzhR1YuVcSgLpVCuR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716366029; c=relaxed/simple;
	bh=mbOIJA/yKaWRIVC2lCO/kmVMoRBB+nzAeKm5m98EUQo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FmweMF2jFEiwXuMdh26wdpFPd5pv5ybCyTqeL1CznSglb5PlRlpdQ/rthR20grG4IgDlBmV2wUZo11Heh/1GxVoXEXeikcjN/YrptQP1nsMxD7TbmTDPLbrb7S3zbEwZA/di6dB+FLKIxQgxJUpV5o33CEHLN5Z5mik5gwHUoZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYHZM/YC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1EDA2C32781;
	Wed, 22 May 2024 08:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716366029;
	bh=mbOIJA/yKaWRIVC2lCO/kmVMoRBB+nzAeKm5m98EUQo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TYHZM/YCIMfGcitP68G/bHayfPgavQUB2ZjU+nX4y8Zz5x8KluuUAUqdXaUaLbfYs
	 H4TAObGMtQMTxzUUhcsi9e7lXQH12Du4WdxGj5cJz8bFnq+o4kfJGXqRZHas7bL5Wa
	 XzBPPcYVmLNRGHiKs9Fze9pisC2yGX4MWslJ3Luv3bumvZVr5dHpRWAbxLqEh5PSBp
	 PKvsBSIIfHl7Djq1uiiL5LwDhWtmGwwlGzyzBelmBLvtMvG6KntKO3BItmBZ/ZCosG
	 4HcnyR/brFuQH3rHNrvNvvNQAK/6wnAvq5ejqfDj0up09Xz55iNbLfp1osuPoPcGiU
	 e8drS3ur1sZzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0FE2FC4361C;
	Wed, 22 May 2024 08:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: lan966x: Remove ptp traps in case the ptp is not
 enabled.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171636602904.18841.14437220048685954330.git-patchwork-notify@kernel.org>
Date: Wed, 22 May 2024 08:20:29 +0000
References: <20240517135808.3025435-1-horatiu.vultur@microchip.com>
In-Reply-To: <20240517135808.3025435-1-horatiu.vultur@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, vladimir.oltean@nxp.com,
 jacob.e.keller@intel.com, UNGLinuxDriver@microchip.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 17 May 2024 15:58:08 +0200 you wrote:
> Lan966x is adding ptp traps to redirect the ptp frames to the CPU such
> that the HW will not forward these frames anywhere. The issue is that in
> case ptp is not enabled and the timestamping source is et to
> HWTSTAMP_SOURCE_NETDEV then these traps would not be removed on the
> error path.
> Fix this by removing the traps in this case as they are not needed.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: lan966x: Remove ptp traps in case the ptp is not enabled.
    https://git.kernel.org/netdev/net/c/eda40be3a5ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



