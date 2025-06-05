Return-Path: <netdev+bounces-195193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF545ACEC80
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 11:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 976A4189A919
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 09:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4F4207DEF;
	Thu,  5 Jun 2025 08:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGhJSCVP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8B72063F3;
	Thu,  5 Jun 2025 08:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749113998; cv=none; b=uTWc9R1I+tCYLyXO/ztekqsKYM9ywHoG/a2BZlddNltoctDTXMYJnIvqG1kYvtN/gGNEf93TrJDKAgHaJRgG3v+Ff6hNVoaRaonO89TtOLUaVexrUOZZKvRR7PB9x6Qnji5/hP7+gNaxloKXf927kkkdjFRJRZxmfAu0kCt9U5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749113998; c=relaxed/simple;
	bh=I9daZlx9d09m2s2x+V99tZsfbDCZbh3nml8Mrei8RJ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SgUR+IbN/OjCvYHdPcwKlHeP/9mpVylprdk2zZWD5aibBh0GMzKk+mqbXTo3TkPXI/lAEpP6onBWJ3wQtibQAmikykR38Lt/WTDZZpAGn/KekbFYBbo2EugNDL+TBvnMhkyj7d7Rwr8XXsZvByVNYJmGXZneT1t0snJ3ldErkd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGhJSCVP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779C7C4CEEB;
	Thu,  5 Jun 2025 08:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749113996;
	bh=I9daZlx9d09m2s2x+V99tZsfbDCZbh3nml8Mrei8RJ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BGhJSCVP9DVWnHhtP1CMrgfBMq9wZ/Wlstb4aPOw1PolcOh8//tYO/5loL6b8gmL8
	 Uaglr/tK6HdKPAzzNuT2aR47Ddo79e+0xOh/aiXOMhFoNlso8t/3XPp+C/2KubzPZl
	 442FxOP9gDmpah2V8DFAvMqxTxdPC6v4hbwz8V8gT3+NrcH+syPleCP6ZUzxqC0eSS
	 EUW4v4uhnaf+PgRGcGJjXC3jRT5C+eqxDNV4EE06rwcKmGoLiLpQPSG86cEJycJGUw
	 MH7HMMcS8wvNS0AYH6/JoV2UlN+V2T4AJUJ7ja/LvHWcp8C7NhN+iEGMVPFAQjHLUi
	 AMvJ673dTHNWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEFB38111D8;
	Thu,  5 Jun 2025 09:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ti: icssg-prueth: Fix swapped TX stats for
 MII
 interfaces.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174911402850.2989876.15623013112591980583.git-patchwork-notify@kernel.org>
Date: Thu, 05 Jun 2025 09:00:28 +0000
References: <20250603052904.431203-1-m-malladi@ti.com>
In-Reply-To: <20250603052904.431203-1-m-malladi@ti.com>
To: Meghana Malladi <m-malladi@ti.com>
Cc: horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srk@ti.com,
 vigneshr@ti.com, rogerq@kernel.org, danishanwar@ti.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 3 Jun 2025 10:59:04 +0530 you wrote:
> In MII mode, Tx lines are swapped for port0 and port1, which means
> Tx port0 receives data from PRU1 and the Tx port1 receives data from
> PRU0. This is an expected hardware behavior and reading the Tx stats
> needs to be handled accordingly in the driver. Update the driver to
> read Tx stats from the PRU1 for port0 and PRU0 for port1.
> 
> Fixes: c1e10d5dc7a1 ("net: ti: icssg-prueth: Add ICSSG Stats")
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ti: icssg-prueth: Fix swapped TX stats for MII interfaces.
    https://git.kernel.org/netdev/net/c/919d763d6094

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



