Return-Path: <netdev+bounces-92306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1DD8B67EC
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 04:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2396B22ACF
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 02:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E86BE66;
	Tue, 30 Apr 2024 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1af24vs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955858C10
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714443632; cv=none; b=nedUc9mv2n1qjBF6Cg92eXTY819SCapQh4IvhD+jYBVHDNE2PKPHMLUMBYUiAeLZzCa7H00pwKsRhvPCfJlyRWYiwfUnZci5SUD6ehR237+LvrgAF06in+RQxwLy+iM6IrtjGZI2rWvcjzhK/6rSFuJM/UJeGTYTO2JuSCX5MI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714443632; c=relaxed/simple;
	bh=f/kJEr2/pM2MTEQSCCxjghR4KkK4ogWqjc6ClfnsLHQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Wcf9dWWpar3pKx5q0/7q04gO8sWE0E+5Ye1/P4Sd8K6CuMx5+CO8QyAV6yk91Rimi5aESePwElcNErZci76zICT0qUQrGjZQnq6h/XWgKny3AaT12iJhrb0U2LQ5J0LVSgja8NPcNtg9g/ZSO9IJaGvqocjJlxC+fpycN26aMhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1af24vs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47DB4C4AF1B;
	Tue, 30 Apr 2024 02:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714443632;
	bh=f/kJEr2/pM2MTEQSCCxjghR4KkK4ogWqjc6ClfnsLHQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L1af24vsqhlmRfPYfatrJH+qilIdFP+gwh+2Op7mQqq51MC+0HC635xBP0dWKlZFB
	 6rk2MGOy1CEM3d1XVcgBAhx1JBo8sJHqJlNzgJe/J1oMW5Mk9oIRdJ/mWqM5migsM1
	 c0vVJL+cZiDkToN4LJKNjd+W34Itlfe+wl8Om9e++tmsU/kJZ0AUaTozJlGsmKCYHY
	 w+Q0aGDTHMyLKDsDr8DimH12PpnZ9MzZCQJmOxffkKHfGNLiVZ7mK7coHx02lCGHaI
	 aBSsQrUO+rraLLVRdUb2dpUR+u6PE+5x0nwuW3JzddS8E7NjJjKGzK+71ehXVJ+7br
	 mziVQa2tisvTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35103C54BAE;
	Tue, 30 Apr 2024 02:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: prestera: use phylink_pcs_change() to report
 PCS link change events
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171444363221.30384.12667093071640216059.git-patchwork-notify@kernel.org>
Date: Tue, 30 Apr 2024 02:20:32 +0000
References: <E1s0OGx-009hgr-NP@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1s0OGx-009hgr-NP@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: taras.chornyi@plvision.eu, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 26 Apr 2024 17:18:03 +0100 you wrote:
> Use phylink_pcs_change() when reporting changes in PCS link state to
> phylink as the interrupts are informing us about changes to the PCS
> state.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/marvell/prestera/prestera_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net-next] net: prestera: use phylink_pcs_change() to report PCS link change events
    https://git.kernel.org/netdev/net-next/c/e47e5e85da3a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



