Return-Path: <netdev+bounces-91163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A96D8B1918
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 05:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45321B24AB6
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 03:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355B6134BC;
	Thu, 25 Apr 2024 03:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbhBm8vx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077F64C7B
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 03:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714014029; cv=none; b=T8OIK6+vGGQjz3dHTDdvwC29QiSPG0ZutktQFqQCEKlDGit4iY8PoTsduyiI6+M4kcghEjMfs1GoeZzHfoE/087PR0X1MEAxEpTqjsqW2M2PDQ1Kiu96L0TwEcIdMgv/4m27Ad7GaNEHrxNc8zk+YFaBVHV973d+MLW2OyTonI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714014029; c=relaxed/simple;
	bh=KXDrmsQ8gaADcvuuNPkchPjAtqQaSFFuxa8vGXqs2NY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ugvp3avrg1WT0ITOiRD+5aA6w4TtJTd2GNenmyHf3bTUQlbO2SxDT7537uPQ/Kab1+iSbSQZZU0oWCb3WUBG5yRM5IoxqXMqZtnriRwJ+SHNEfPnPwLOytl7CEoIcTL9XttAs3JoxFU/xf2WzA+hrRUfEslfSEw4EGixYZ0F/og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbhBm8vx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61F90C113CE;
	Thu, 25 Apr 2024 03:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714014028;
	bh=KXDrmsQ8gaADcvuuNPkchPjAtqQaSFFuxa8vGXqs2NY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MbhBm8vxUSGO1f42qVvH09Bjsvvmr75dLxeUWgougc8Fm80OvJQo1kAd8tkIqkopu
	 ECLVPoolXtojS3iKZIEHqVj9HP1V/uKlhPTc0o8/xZY6ZQF9q2evBxdyN9fvsLi7St
	 mP/Ur8WbT3A7+Po3vG2hcyvB8VnyjlQZYQ+xu0EU/cPc3LxrmfQ11cd1o3NgARAl2O
	 GWTj9EoB3E51L49dgzl3PT1qE/BJd9JYoRnGADQxPUkBb6gLO5bk6uUODGXbBn7iFo
	 rc+fdJJjRsO3Be3x7gzcNc7UabT4IJc3P0xHPQ8ZEZTfCVA2iKmOtcOtFGv/zuh9FV
	 QKnOB4W5ALM3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 505C7C595D2;
	Thu, 25 Apr 2024 03:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] Revert "net: txgbe: fix i2c dev name cannot match
 clkdev"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171401402832.32160.14071159006302877526.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 03:00:28 +0000
References: <20240422084109.3201-1-duanqiangwen@net-swift.com>
In-Reply-To: <20240422084109.3201-1-duanqiangwen@net-swift.com>
To: Duanqiang Wen <duanqiangwen@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 mengyuanlou@net-swift.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, maciej.fijalkowski@intel.com,
 andrew@lunn.ch

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Apr 2024 16:41:08 +0800 you wrote:
> This reverts commit c644920ce9220d83e070f575a4df711741c07f07.
> when register i2c dev, txgbe shorten "i2c_designware" to "i2c_dw",
> will cause this i2c dev can't match platfom driver i2c_designware_platform.
> 
> Signed-off-by: Duanqiang Wen <duanqiangwen@net-swift.com>
> ---
>  drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [net,1/2] Revert "net: txgbe: fix i2c dev name cannot match clkdev"
    https://git.kernel.org/netdev/net/c/8d6bf83f6740
  - [net,2/2] Revert "net: txgbe: fix clk_name exceed MAX_DEV_ID limits"
    https://git.kernel.org/netdev/net/c/edd2d250fb3b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



