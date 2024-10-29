Return-Path: <netdev+bounces-140151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 029069B5638
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 00:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D41F1F23D26
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 23:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9A220B213;
	Tue, 29 Oct 2024 23:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQDqx6k1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D727820B202;
	Tue, 29 Oct 2024 23:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730242824; cv=none; b=o1jVoJ6VS88URPhNw2y+g3Tkv0KbbmJv1RCxkVAsxb3eNWPoqF6WirAUrMXmfgYHy/LbYZRx1qxohi7E/QVzaT7JAN52x1HeTFjHNXoVgzoo+wGt+pluFY7ihoMUkD691K9h0vR9jXH/Vs/UbfSGxlAGuFFt/hy+2u1DqtGWz5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730242824; c=relaxed/simple;
	bh=Rnl4bk64XIrQuEO5FAzEaA7yQsygH9w7WPCYCrwpthI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O7BsS/EErRQw88fUun2TvTvzmg/iFyPUViyoppgGzJj6C/biAb3d43C5Kv8hW4xhbMt95ToPMYUZIIlWi1fGPbXZPcIewDvx1nUTDg1ONJNIk47jgy64HL8+aFPIWTcvvNi6JKGN6oHdAy5AlPtNSGDwUoEIUHjJDRpidaxgXWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQDqx6k1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CDC6C4CECD;
	Tue, 29 Oct 2024 23:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730242824;
	bh=Rnl4bk64XIrQuEO5FAzEaA7yQsygH9w7WPCYCrwpthI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZQDqx6k1RTl8xOaW9HiqK7Ct6tglBxkXEyiKa29kIce9O11wIZkIWhLtFrIqDKD13
	 BZBGXKeIrSjubxa9HKb9znCbeADI42fmPiHEn+U5RR+hEnMGxSKfxQwFRfXyMlySIZ
	 DviKsxcYfChsi9E9AkcNfrVzFcPmo2uLpkME2CWHP1MSxTM+9EPpXFT8/UyFk/KcsQ
	 8GFrPHJbwOBiXoT3O7ggkoDJAuob9H/AcAKQdzJILDJApl8/9NrURF8tYvGfRiXHtO
	 MGsbFxcoOAOXET7LA2e76zjHy8JEsIFBIV+JRS0CT3MkiDPOvjsnXtAzA+LYQ+pQBh
	 yGgFZMdwt3RPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33AFB380AC00;
	Tue, 29 Oct 2024 23:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] amd-xgbe: use ethtool string helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173024283176.846516.1964948738729527169.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 23:00:31 +0000
References: <20241022233203.9670-1-rosenp@gmail.com>
In-Reply-To: <20241022233203.9670-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Shyam-sundar.S-k@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Oct 2024 16:32:03 -0700 you wrote:
> The latter is the preferred way to copy ethtool strings.
> 
> Avoids manually incrementing the pointer.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c | 22 ++++++++------------
>  1 file changed, 9 insertions(+), 13 deletions(-)

Here is the summary with links:
  - [net-next] amd-xgbe: use ethtool string helpers
    https://git.kernel.org/netdev/net-next/c/cf57ee160152

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



