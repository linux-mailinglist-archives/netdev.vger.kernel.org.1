Return-Path: <netdev+bounces-175440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7D1A65F01
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 21:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A064189D683
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 20:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D581F582A;
	Mon, 17 Mar 2025 20:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c00kyITz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8A51F4E47;
	Mon, 17 Mar 2025 20:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742242814; cv=none; b=X6PUAv6hAyA/XsNHpuoHP9v0+7VFqOlqGQPjjgFv0147IZIoU1je49tfgKxWTxFBbyxaXOFcR+ju6YnYLExavIM5feVVUTejEMbt/x4jmV8OJzRpPH/KLx9hx4aN7qggS2/4HnLIrmb2XpAdTNpsTujG79lrGHOJXAwqG02mc8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742242814; c=relaxed/simple;
	bh=PGe2zkk9t3wpiVapprqxZNUBlwXJz6fSOXIRXWg3MrM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VODIutZUCgvbE9j5E5GL8YfE7wNtDvLHrl3CSfbPID5hPMTiw0cob3WPeGPRH9BCmNYr2JhY6sc5CneXTzgKtYWSZWFI4oVKGMkh17X3HJOtKJHS0c7FTzbSv9siEKZqjdCckFBlcc2pkQ1eRbXBn5nb3EcVhPJd4ilPXY0hfqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c00kyITz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A5BC4CEE3;
	Mon, 17 Mar 2025 20:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742242813;
	bh=PGe2zkk9t3wpiVapprqxZNUBlwXJz6fSOXIRXWg3MrM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c00kyITzeyheVyBmzCx8pY6PlwOek/naieESbTbm4FbJlZFWWiKhfeewS2jh2a+Cb
	 7umPiM/7p5nPceIxqBHWZ6Dj5qyA0aa+zZ4eaE5nqOVq1GNcdMIfrr9v8c7/B1DOQA
	 LT2vMbaF5MPsmToJQn6Eh/XyO1GINQMZnwVhXKJuSznQ/Ynsf7EULHwA0w/zzQI7JZ
	 /3DyllNlwwxI4J2qiOeHJkqRWqERyqNYEK+6iprqubwQM5ptz+0nQ7OaTuIrlp72wx
	 3BPTFaLKb0+OwSBRX7b+oliJb8nVAZhX7yHPmIny3GKw6PBelk5rmc/sk45zqG9rSH
	 +B/M3DEIqZCKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEE0380DBE3;
	Mon, 17 Mar 2025 20:20:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 1/1] stmmac: intel: Fix warning message for return
 value in intel_tsn_lane_is_available()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174224284849.3901460.9366636522852386074.git-patchwork-notify@kernel.org>
Date: Mon, 17 Mar 2025 20:20:48 +0000
References: <20250310050835.808870-1-yong.liang.choong@linux.intel.com>
In-Reply-To: <20250310050835.808870-1-yong.liang.choong@linux.intel.com>
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, dan.carpenter@linaro.org,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 10 Mar 2025 13:08:35 +0800 you wrote:
> Fix the warning "warn: missing error code? 'ret'" in the
> intel_tsn_lane_is_available() function.
> 
> The function now returns 0 to indicate that a TSN lane was found and
> returns -EINVAL when it is not found.
> 
> Fixes: a42f6b3f1cc1 ("net: stmmac: configure SerDes according to the interface mode")
> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v1,1/1] stmmac: intel: Fix warning message for return value in intel_tsn_lane_is_available()
    https://git.kernel.org/netdev/net-next/c/38f13bf80130

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



