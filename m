Return-Path: <netdev+bounces-141770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D46539BC32A
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 03:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19E94B2180B
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 02:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F672C1A2;
	Tue,  5 Nov 2024 02:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmO/3Syf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F6E1877;
	Tue,  5 Nov 2024 02:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730773837; cv=none; b=PaZt1/sOm5ATYah1Q0FdCe6ZkhMSZWQuXDPzMtilnTwI4QSzLT1XL7jjTmvKJTvgHLNcdkQbY+VqkdqJ8yyC8z4DVjlPCEONa4+HdkejfUG1mhh6+dJV6gO3PWGC5SrXe3Ifysw4X1q04Ns3zKnasye+7zvJifPBzlJesWBDId8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730773837; c=relaxed/simple;
	bh=ezka2BDmuiRtl1yVotoQ1SfxHok8MMQAja4Khpj36dA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mSo22geyWTJR0Xk2oHes4Z5mmKkQxtKuOFYRpR6vBU5DJmj4jTNQ+Y3l2wgkWqFKB7q8oE/TcEkE4NsUVoQTx7Lst4m8HMFpP6U+5FSAL1datiXh7RhRnJpoG5B9pNlBSHp3eLYvuW99c/+xdJl2iJsNCUGnFI+OtlXxLrDrdSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmO/3Syf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1020EC4CECE;
	Tue,  5 Nov 2024 02:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730773837;
	bh=ezka2BDmuiRtl1yVotoQ1SfxHok8MMQAja4Khpj36dA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SmO/3SyfVmN/KJTdBHJyMeYrl9Y6d4xxykmK/L1+hTVqq5noKmYDp8F6ttOpTjLre
	 kfJCi9w1wHj9/4TVuj7sIv8gC5GApZTkHAZ5PB1nn02u2StVDD1Ycu71pwoP6ODjVy
	 GZz+v9VdIeztGg/qJS9q+Wztep76Q2R9zg8WE3fb6oExTOQLAL/38YyWwpD/Scj6+5
	 M5qJx2WRiZvELDkpYnL5hwr9k0mkRa0xcG4Kw+YtZP/LuFpo7gvhvkKDgjnyO0weqI
	 alNhqUFNqCZbD5QXKqc0AOkXStGdsk+EgWlRd3aQMA7amfte35iXxDzDno1eZ1BGYY
	 PoJ/xGGi7y3FQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACF63809A80;
	Tue,  5 Nov 2024 02:30:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: ena: two cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173077384548.92170.17025072705900233883.git-patchwork-notify@kernel.org>
Date: Tue, 05 Nov 2024 02:30:45 +0000
References: <20241101214828.289752-1-rosenp@gmail.com>
In-Reply-To: <20241101214828.289752-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, shayagr@amazon.com, akiyano@amazon.com,
 darinzon@amazon.com, ndagan@amazon.com, saeedb@amazon.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shenjian15@huawei.com,
 salil.mehta@huawei.com, shaojijie@huawei.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  1 Nov 2024 14:48:26 -0700 you wrote:
> Simplify some code.
> 
> Rosen Penev (2):
>   net: ena: remove devm from ethtool
>   net: ena: simplify some pointer addition
> 
>  drivers/net/ethernet/amazon/ena/ena_ethtool.c | 31 ++++++++-----------
>  1 file changed, 13 insertions(+), 18 deletions(-)

Here is the summary with links:
  - [net-next,1/2] net: ena: remove devm from ethtool
    https://git.kernel.org/netdev/net-next/c/d2068805f688
  - [net-next,2/2] net: ena: simplify some pointer addition
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



