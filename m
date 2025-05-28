Return-Path: <netdev+bounces-193794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47972AC5EB4
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 03:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAD477AF756
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 01:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D9F1D7E35;
	Wed, 28 May 2025 01:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8mHngg+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0661E1D6193;
	Wed, 28 May 2025 01:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748395212; cv=none; b=lXO9qBZmM3dSq7WaxuFXxhBSFyyhYVWpT0NaVj3IuAMLQUArjSSviyhGUcEhQoSgt/FlSaWsA1QNkqjDqikdtHP89X0Ig7Def+2fOOIkmzp+dZOje8AtM1j1ZzDEmmEE7EeP+dGXPPku6q24K1NdUJ3vUiW4W5ijWkNYLXyhjyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748395212; c=relaxed/simple;
	bh=9JY3IAPSbrtJG70MWL4Volm1i4Pjc1h93UbM13RUUHY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J0PnP5g9ipAMDbaBeplOE9zSSRHuxvZE/SMXL5ZE5E0ZXUqnjA00Ia6oQnTK4y1ZBZg/IEgUorWBek4o+gkYSHHslMm5bFJ5pYMePtxm6cD8YVgXNadWhYUHRw7W1cilXAIkzrgn6KoE0nHZs64MibDAphNMCxuGNFgzyqk8NIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8mHngg+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBA7C4CEED;
	Wed, 28 May 2025 01:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748395211;
	bh=9JY3IAPSbrtJG70MWL4Volm1i4Pjc1h93UbM13RUUHY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X8mHngg+XKun97bJItmoCVfg1bktF5axDMNZqZ+rcF4kyKREgeuq9emri2KizG4j7
	 HAS1GDL+dNWXVif1poCWn3uoWlriqOhNeSTy4eR3/xP2vjK95qyio7mIbXuKkTpDx9
	 rgK+7hK6unezisWD2bMhy+3OZGPK92kQxLwD8Tj2MgsuwuoXPPrg9iVqryWF8n1JvZ
	 bycjHG8wMZcYLmGz5EeJ3PJf51fRA7ObVju6JfnoQ3hwvOL33Ax9fGW8oouYTta94Z
	 hB61226IDh11JR/PxLXgsnEVpMvpyrgYxhVPWXYfhHbcZD3bg3wIfWX9xMfop/+vIG
	 tFXVHExTvOmoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C61380AAE2;
	Wed, 28 May 2025 01:20:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 net-next] selftests: net: move wait_local_port_listen to
 lib.sh
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174839524574.1849945.6989274952814404845.git-patchwork-notify@kernel.org>
Date: Wed, 28 May 2025 01:20:45 +0000
References: <20250526014600.9128-1-liuhangbin@gmail.com>
In-Reply-To: <20250526014600.9128-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 mptcp@lists.linux.dev, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 May 2025 01:46:00 +0000 you wrote:
> The function wait_local_port_listen() is the only function defined in
> net_helper.sh. Since some tests source both lib.sh and net_helper.sh,
> we can simplify the setup by moving wait_local_port_listen() to lib.sh.
> 
> With this change, net_helper.sh becomes redundant and can be removed.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> 
> [...]

Here is the summary with links:
  - [PATCHv2,net-next] selftests: net: move wait_local_port_listen to lib.sh
    https://git.kernel.org/netdev/net-next/c/d9d836bfa5e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



