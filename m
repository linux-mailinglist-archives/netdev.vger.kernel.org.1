Return-Path: <netdev+bounces-217561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B9AB39104
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 03:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0DB9461204
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 01:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4805153BE8;
	Thu, 28 Aug 2025 01:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tCYoR2/G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06A1189
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 01:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756344000; cv=none; b=fM7AkA0HgZxKUMKsRcPm5IKZYK6Q1KW3hBQWYNdKWDdEJCc3h/kW5ZpfBrOotMnWkwaAd4jSqQhI75h/lf/DA79GFnh0vW2Ytm6rS5dwirMsZQ9S1zAFCuwcGxWbIzaVbMHnwG72zUfRsKqMHB1gboAf2Tz7uk8mNp0VJD3w0bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756344000; c=relaxed/simple;
	bh=6OS/gjdbe/D5piApew8lAE9fvruNuG2KoVotjkI34Hg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PPNbYXJcjlPMz0CZUVhWlzTHC2ycdOYiU9GGCVjUrh7J6B3Y22pd/jNAuwxbAQH7pPRYu9puMypueRDBuSe5YKjvfGoI3EU52RZVmrZ2G0I+7brtxP0DYs1Rx8ML4AEe6FjxGCjmPrkxPqB2dr7C/+B8h0BsYNMiVKZyOsynAP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tCYoR2/G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E66C4CEEB;
	Thu, 28 Aug 2025 01:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756344000;
	bh=6OS/gjdbe/D5piApew8lAE9fvruNuG2KoVotjkI34Hg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tCYoR2/GCn0qeBvPWccqJI271zhwBFk03dwES2gTzliyRbrftF7sPzgNRpo0d8gA0
	 PcGZj/61BPUQqrOaxVjqIf63rHI+G19Ci69bQCFvmR8eh5yaWmOTy+DZ8YqZOz3h8V
	 JGjyd412EkLW71h/CtoJLObXG1f++f8LR2RxBfRFA1rHFzSsMG/62CBf5kd2arYA+V
	 94Va+qrmlXmDR4v87R6oyCt2NUr3jvANezdplm2u07GlDwIf9S1Lsohp3n22X1rYqs
	 phRrdjanZ4WYCF5P9IOw8Ah5hc8Y9L8dsZwktUD96XI8IOQyrvkseWvtMNqo0qUm8q
	 U2vN10dQJjcaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF575383BF76;
	Thu, 28 Aug 2025 01:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: fixed_phy: simplify fixed_mdio_read
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175634400651.898971.11758530831088975376.git-patchwork-notify@kernel.org>
Date: Thu, 28 Aug 2025 01:20:06 +0000
References: <c49195c7-a3a1-485c-baed-9b33740752de@gmail.com>
In-Reply-To: <c49195c7-a3a1-485c-baed-9b33740752de@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, andrew+netdev@lunn.ch, linux@armlinux.org.uk,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 Aug 2025 21:24:44 +0200 you wrote:
> swphy_read_reg() doesn't change the passed struct fixed_phy_status,
> so we can pass &fp->status directly.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/phy/fixed_phy.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Here is the summary with links:
  - [net-next] net: phy: fixed_phy: simplify fixed_mdio_read
    https://git.kernel.org/netdev/net-next/c/6aff3699906b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



