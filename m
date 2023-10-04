Return-Path: <netdev+bounces-38091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E997B8EF1
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 23:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C34C6281758
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 21:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D71B23770;
	Wed,  4 Oct 2023 21:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/YHDHZ0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F064D21A1F
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 21:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74238C433C9;
	Wed,  4 Oct 2023 21:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696455027;
	bh=hcaKpy52lF9OHAvmzHXLI5o1ZV1i1ANvqrPW4EAWj3E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S/YHDHZ0dcDKjf4y6yyE0nuHSv2Juch7RKAzoYW7UyabSsEwAfZltNDA+QaJ/bVpL
	 wYqkwhdE1RZIY7d0oT5CpK5FzCoA7NniqUKZ7Iy8PHSLyuw3YPl0rzCo5G5L4tBT2B
	 GQ9vhx+7GtG+QCiREM3XyU6zijIhr3YTGo1/jWkMVq3KzviCAvxu2O7fQf/IZNMHfY
	 MD+2o1cW7oEiljGQ7k2XQy8IOUnxf0d0FergsG8wVNQWA8b/tj7OEJFgqr4ED27Y/u
	 84xKC+4ueA5fjanjNObM6tJjms0EB2oj5SE+A3Dv7rpDl7aiIZgzbLaf2fqwHiB1Zm
	 uy0AwUJkomZ1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5907FE632D8;
	Wed,  4 Oct 2023 21:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] page_pool: fix documentation typos
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169645502736.6604.7880065311843633422.git-patchwork-notify@kernel.org>
Date: Wed, 04 Oct 2023 21:30:27 +0000
References: <20231001003846.29541-1-rdunlap@infradead.org>
In-Reply-To: <20231001003846.29541-1-rdunlap@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, hawk@kernel.org,
 ilias.apalodimas@linaro.org, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 30 Sep 2023 17:38:45 -0700 you wrote:
> Correct grammar for better readability.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jesper Dangaard Brouer <hawk@kernel.org>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: netdev@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> 
> [...]

Here is the summary with links:
  - page_pool: fix documentation typos
    https://git.kernel.org/netdev/net/c/513dbc10cfc1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



