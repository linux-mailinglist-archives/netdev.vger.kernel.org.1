Return-Path: <netdev+bounces-213898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D581B27441
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 02:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C2465E009B
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 00:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3011A239D;
	Fri, 15 Aug 2025 00:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKoh+yLJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BE718C008;
	Fri, 15 Aug 2025 00:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755219020; cv=none; b=dIfXna+W1YvQFLmzDjMFNJrbZK+f+hyUwahojf94KymYig3TvOwpuw1qijODXopzMLS6zQYiG3VUH3nEQm10fClU6tdwRqLwvRCfv9C0TYq+u9gPmrh6fA49YDmXwpfhdTUEetP/YXw5OUw1iY3a8r7xCmFenAuqNNIrkslbYC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755219020; c=relaxed/simple;
	bh=S5EpvGM+SjK52tEv0RUvlzfLz1Hc6YeQRW/fyGS8FGA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=arUeyx8NYd4YMCoo9p5zzWIgk5uzoRMLKQTegZ37e2p7D0gNSnzy48dZEyQu7f4ABSnxwyLYavs3duBvvUgA+RSkkfjLdOvhBkDaX1euzgMdq0pMwW3MyosWq3djDennNI0heDE6JeWnhcl4bTIvdeGaxmhtG7netN4V5jUgKfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKoh+yLJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73772C4CEED;
	Fri, 15 Aug 2025 00:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755219020;
	bh=S5EpvGM+SjK52tEv0RUvlzfLz1Hc6YeQRW/fyGS8FGA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TKoh+yLJ/pfX+sSMvVkS+L3cAOtOG4NBAj53/EfLcALkmPhB22Hlm9vMOnBmO+nf6
	 fwzAKYRdiCITLiORtMviJ5BWZMlqSjbf2EgEmoUf50fU5VA0kHpd8IWoHo2p1/J79q
	 RSYNgxHF1qp50SdrfkkmKvpLBiGYFZKbVl4mYidwhH5ocMVX+y8tADh0a5DPHUg/H3
	 EUbz1pgVv1hYc3ejpFNHnq1HbKaPC0n2KHNkOFPe1Q2T/V9w38d39CiryfZtXfyuGr
	 aovPwJtx/s2UfCpjJjS8mLgbBV6Vdqekg7TiQdIzPGXT+s+cPpXD9XYXTr7QN+2Myp
	 rdJK67AVeONTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEB139D0C3E;
	Fri, 15 Aug 2025 00:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ptp: ptp_clockmatrix: Remove redundant semicolons
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175521903149.500228.11288097929884673827.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 00:50:31 +0000
References: <20250813095024.559085-1-liaoyuanhong@vivo.com>
In-Reply-To: <20250813095024.559085-1-liaoyuanhong@vivo.com>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 Aug 2025 17:50:24 +0800 you wrote:
> Remove unnecessary semicolons.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>  drivers/ptp/ptp_clockmatrix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - ptp: ptp_clockmatrix: Remove redundant semicolons
    https://git.kernel.org/netdev/net-next/c/4b6dc4c891cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



