Return-Path: <netdev+bounces-132152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A543E990930
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 18:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 678CC281E6D
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3311A1C879C;
	Fri,  4 Oct 2024 16:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXGMWvdt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C01D1C3032;
	Fri,  4 Oct 2024 16:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728059432; cv=none; b=ufP9bMvmbGvRB9godGpcNEOozKG7Parsa/ZLIuK0WK+3FCW3NqilS70hU4oGyO0tyyaI34crP4b2BrocKffwSCeOVVHbVYqhfFREJg3+GTbqZCLUCh7zKjX+W7dTTHco30OwyTU4jUhHOz/xrcbl7BfUVTCZDj4GPtI9OZ+bPdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728059432; c=relaxed/simple;
	bh=5Qwq29/Tpt7XpPao6O9Mk+gWqokrH6w2WkFH5q1ROKo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VYIu2NmCE+bA9T8KvId7q3+jHdHHNAsjwfyosrYsJ3tKsZgBbk+InzCfzyxbv9bKAyCeDgh5oiIVL7fif1O1QnDYMSdfcZIjrA3xboEnEQp2BVZovvQBQ0a9rW8Lpi7x/PpoG8g0tJdAt+WT6aGv8vh9LS77moITUMWhkR+cl/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXGMWvdt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1927C4CEC6;
	Fri,  4 Oct 2024 16:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728059431;
	bh=5Qwq29/Tpt7XpPao6O9Mk+gWqokrH6w2WkFH5q1ROKo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KXGMWvdtDDYw2YDeh0384zonfYoah5rfauOkJTBe1uR2UzVkIRdHoFfVeAqcEPqsv
	 J6GM3GBa7/Go6jBK8gX4QpIxdEPiSFfRE3Ks1dX6u49nA8RHR1g2uU/MJYHO3vIONp
	 IpU/5N7S9/WLpX5Tam90wMqHnoj8kyaICvpWT7sSw19yOnMkfwKR8J1lLgFgCuWvHA
	 th5+5YPZRCcvVLh2bBI/j7eCuSzCUSb0/Ew9x3g9ppNRvwD7yUsTH/hIm66kYAwlWo
	 BMYPPlsFKPuc+0MI2apDhbibAIRKXZ3KnLvz4b2PiMhd8kjvchCnnTFjVwE4OZXtS+
	 K7BAETTwA4T6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE38239F76FF;
	Fri,  4 Oct 2024 16:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: mv643xx: devm fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172805943552.2652527.15210046375542424890.git-patchwork-notify@kernel.org>
Date: Fri, 04 Oct 2024 16:30:35 +0000
References: <20240930202951.297737-1-rosenp@gmail.com>
In-Reply-To: <20240930202951.297737-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Sep 2024 13:29:49 -0700 you wrote:
> Small simplification and a fix for a seemingly wrong function usage.
> 
> Rosen Penev (2):
>   net: mv643xx: use devm_platform_ioremap_resource
>   net: mv643xx: fix wrong devm_clk_get usage
> 
>  drivers/net/ethernet/marvell/mv643xx_eth.c | 28 ++++++----------------
>  1 file changed, 7 insertions(+), 21 deletions(-)

Here is the summary with links:
  - [net-next,1/2] net: mv643xx: use devm_platform_ioremap_resource
    https://git.kernel.org/netdev/net-next/c/4d77e88ab42f
  - [net-next,2/2] net: mv643xx: fix wrong devm_clk_get usage
    https://git.kernel.org/netdev/net-next/c/50c3a7fbaa10

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



