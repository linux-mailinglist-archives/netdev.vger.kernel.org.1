Return-Path: <netdev+bounces-212741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF0AB21B98
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 05:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BE3518923FF
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 03:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DE92E3711;
	Tue, 12 Aug 2025 03:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUDYoYVF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3CB2E3709;
	Tue, 12 Aug 2025 03:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754968804; cv=none; b=CaaNc3yGGFQvgwuzWD93D27PK7IcDzs5xZTbyjS1K5i8OGy6VkMUaK9C6cvy5sieHx8Xj7KbipG4Ykab3DW0pGSGEFihAbIHcbXLsoHvnXd3Pc18kJyxdY16DtYapw/TAXhnAkAKQHnIATnR5k4JnkKbayn7Dt76qfAaBDPImEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754968804; c=relaxed/simple;
	bh=0LXvGWcDVzLjATEkBa1b2ib32lSLGtARM86lJlsk20c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qSDulfuUCd1+AsQlZQvhekrykUGyLQkC4pA6hMc1FXVTK2mPZ5B/cOkc1xLM9u0GDE2pnlgq4dUYzt8cJonl+ClORrdekE5Is6rW8Nyq1FOsDZ7jmKQjwOVIw+9M1ZFRBz9fYvKNNVv+Trn6YUhQCertJBZsPZfRTVPElTEUB1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUDYoYVF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FBE1C4CEF5;
	Tue, 12 Aug 2025 03:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754968804;
	bh=0LXvGWcDVzLjATEkBa1b2ib32lSLGtARM86lJlsk20c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lUDYoYVFOKiNzvRDHMc3+0TDrHPUmU2PGYMOQY3iWMNA5ug1DG5G8lP/0TyWOQreU
	 Du7TRPsS7g9wwhnCHUymWhEtrDBN1IRQ+qjRCWNUpVqOEMDv8XzWBSx8OSDcnGu3XA
	 9dz2c0hGbFiijqSXcRJ8wltiAz9sIbAlheKy2nAMxHhgv8ciGCpBCUHSgnP6zp3FWS
	 74r3A+aCdYMfU8syO9yo0tdZTFq6QyRy/+eEutK1WF+nDbHq12Q26+V7BCnGS3YIG0
	 mnmLU/Ejna6+XztLRmziajeYN/LDDBBlE52SaR7sZ00L6dGA+Spd9yqxLng4+2ucZj
	 q9sb4iWjBzU1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADB7D383BF51;
	Tue, 12 Aug 2025 03:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: Mark Intel WWAN IOSM driver as orphaned
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175496881649.1990527.10833258935065520646.git-patchwork-notify@kernel.org>
Date: Tue, 12 Aug 2025 03:20:16 +0000
References: <20250808174505.C9FF434F@davehans-spike.ostc.intel.com>
In-Reply-To: <20250808174505.C9FF434F@davehans-spike.ostc.intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, johannes@sipsolutions.net,
 loic.poulain@oss.qualcomm.com, netdev@vger.kernel.org, pabeni@redhat.com,
 ryazanov.s.a@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 08 Aug 2025 10:45:05 -0700 you wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> This maintainer's email no longer works. Remove it from MAINTAINERS.
> 
> I've been unable to locate a new maintainer for this at Intel. Mark
> the driver as Orphaned.
> 
> [...]

Here is the summary with links:
  - MAINTAINERS: Mark Intel WWAN IOSM driver as orphaned
    https://git.kernel.org/netdev/net/c/7573980c7049

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



