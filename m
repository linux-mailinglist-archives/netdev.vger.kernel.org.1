Return-Path: <netdev+bounces-127180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F27B59747E7
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 03:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 153A71C25CB2
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 01:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EFD22075;
	Wed, 11 Sep 2024 01:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaZGTR6r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9553BB50;
	Wed, 11 Sep 2024 01:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726018836; cv=none; b=VJjqA1eFhy/pMJbMC/Vf+IHH7V1XDg0X77ft6Zz+1mgugeGjIrv7TvkCFzod2KD3kI0+avUKKxSav0ylc2EP181zzv9N0Hfmcz+12LJQa3i1kBLq8bZpr8ebVw5hvzGkguXb6623aih9H1sg4nqgtcR0GUTDusy5eYbocGwAyW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726018836; c=relaxed/simple;
	bh=ZuAbWhRnVaI9nqKxR6ggYsI1BD9oXYA7MUnLLKyL/+c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mQsrRkwMXZQvVRTC5fAIlCldgu4tq4GF+g1zzvqEqUvd25cdxvwP/c0sbKUjatCwJkwFOriRBfLyDeKoVqkz1gBPooX82l28Yi7HciPzCFKcVvVpO5ddUUshuzOLnDnbk+qwGpKatNOFElkNe9KazUrnSaFArW4hdha4Rkx6KSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaZGTR6r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF282C4CEC3;
	Wed, 11 Sep 2024 01:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726018835;
	bh=ZuAbWhRnVaI9nqKxR6ggYsI1BD9oXYA7MUnLLKyL/+c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UaZGTR6rN8C71JpO77nr0ZCsGkjvrhtxIoAyEUPuqrirFPa13OR9wIm4cqNiXuZoN
	 /fC+VUw4MC6lh278KXZUJQqGcYXS/mt8VA8FOTlW0H64fvjN4b5EvsYcM5IPYAvT4o
	 qEo56RZnPN+quE2dtfIvMsGlmYQn5WBXTVFopWLxPwJT6lFcbWoXMDuLBFIhY9vkNi
	 oauA1FsX8ju1M4ocFokLCRqbxm3nTC/kHjHomN/SSTB4qfT5Vr6v6AWYKs0ZTzVR90
	 v00MGeb/UppvEXcEkyswdjZGDAVkKCOCGVpuuGnGoVsVddyXGjN4k+Y+Fr2utS3zJD
	 qOACwcsqKmMAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC8D3822FA4;
	Wed, 11 Sep 2024 01:40:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] rtase: Fix spelling mistake: "tx_underun" ->
 "tx_underrun"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172601883550.456797.6191643996964073452.git-patchwork-notify@kernel.org>
Date: Wed, 11 Sep 2024 01:40:35 +0000
References: <20240909134612.63912-1-colin.i.king@gmail.com>
In-Reply-To: <20240909134612.63912-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: justinlai0215@realtek.com, larry.chiu@realtek.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Sep 2024 14:46:12 +0100 you wrote:
> There is a spelling mistake in the struct field tx_underun, rename
> it to tx_underrun.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/net/ethernet/realtek/rtase/rtase_main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [next] rtase: Fix spelling mistake: "tx_underun" -> "tx_underrun"
    https://git.kernel.org/netdev/net-next/c/d59239f8a400

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



