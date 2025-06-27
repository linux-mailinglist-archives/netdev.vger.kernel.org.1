Return-Path: <netdev+bounces-201851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6509AAEB31D
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 538E8567C38
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 09:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D251F295534;
	Fri, 27 Jun 2025 09:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPh0q99B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD27D293C6A
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 09:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751017180; cv=none; b=eUTAysKez7nxjEugy6xkZMK1A8DSksklKV4O5HoDkYjyggLykTIYPOibJopx8LEUaD6iRv4yoOG4UAAaAU9UouwUKuB4xZfZLAf097tRkaB1r0lVN9Gj1iUBta/wGliuLKYwx0+ll1AWyi8MvLvZTVw7afAYumxPY47uFZGPcZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751017180; c=relaxed/simple;
	bh=UksSEZ9CI/0w5oIRN+fbACmRu52fHSOH+FoqPvM4d9s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VgGkyq4eb0KZ9I+yPRrudZ4R5Yiu2xnTo+XNExndxWbuRo9KnvLI390v0/RI+owaUukYZt+tgt73POXUmqnA4yJaKeDuYY6MRKCEfaEtu2PXn6ZEvyxsR4OULzjNYP66lscIGjkMF9qLOCycMd4XbyOD5fKI62bkY2GakHfSmUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPh0q99B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2220DC4CEE3;
	Fri, 27 Jun 2025 09:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751017180;
	bh=UksSEZ9CI/0w5oIRN+fbACmRu52fHSOH+FoqPvM4d9s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lPh0q99BBniSFXyo9OJdwtVI8+59JRs4yWVJjHn/T/mh57FO/oeDFrw6SkdJ2PKzI
	 TheDAifYdia4B8ikx3Zo1rswfURdfmM467ccr6Hdys25vQhjEoWbmD5WI98vLsaI+U
	 rz1dE3ZQazOUYokF2egxQLbEpEHDTH4I33YBYIhCq2zrT7voC6KhDB3s4rpSbsNvHW
	 FTqy92j6HK0b2hl7GVZjUo6/xVhAhyq5uwlC1o2gAmfORz4FFkZ53L+Vim/7kEmVHF
	 stVE/hNedoOomywXrAtrexu1k1fI7F7ypPpF8QFP0NcUgBZqMJ6YycUPW9EomKjTnY
	 Cjuutnrkgoaww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 712E5380DBEE;
	Fri, 27 Jun 2025 09:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tg3: spelling corrections
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175101720600.1855896.1510496879860203238.git-patchwork-notify@kernel.org>
Date: Fri, 27 Jun 2025 09:40:06 +0000
References: <20250625-tg3-spell-v1-1-78b8b0deee28@kernel.org>
In-Reply-To: <20250625-tg3-spell-v1-1-78b8b0deee28@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: pavan.chebbi@broadcom.com, mchan@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 25 Jun 2025 13:52:10 +0100 you wrote:
> Correct spelling as flagged by codespell.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>  drivers/net/ethernet/broadcom/tg3.c | 4 ++--
>  drivers/net/ethernet/broadcom/tg3.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [net-next] tg3: spelling corrections
    https://git.kernel.org/netdev/net-next/c/8efa26fcbf8a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



