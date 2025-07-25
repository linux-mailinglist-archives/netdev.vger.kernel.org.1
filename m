Return-Path: <netdev+bounces-210170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2A7B12398
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 20:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0EB4AE1AAA
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 18:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53CF2F0C6C;
	Fri, 25 Jul 2025 18:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebPtKcLr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8A428AAE9;
	Fri, 25 Jul 2025 18:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753467004; cv=none; b=N/dw3P8ZLMlugSx7NOB6i7yinPge36T3enHhqTyoA8iHftWnqgPrdP0ogzv9gqzf7oKbKG/LsJq2sgl6vHvrh/r2zKGEaj9a3gDnwFmueOR4PDG4lOyQdrPIBiXOSA98jdpGjDUYJb9bGNSE9pwbD+eJR21AW3AOxe/izOie7Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753467004; c=relaxed/simple;
	bh=mR8xGn/8QuIuvkT73+Ar0nsUchts2skO9yvpLNneIuc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O7BPCZrbTSwfJLmcdqrKEizXtPyglpJhL4BP686DnoYa99G/Gki7c+6hPrG+cpteIWTPU4KT/UyBbObW3zDb8iiG/EfOe2BpnFyXDvFH3/5ibsXcQcrVF+iwtsxhxe8n0pPnDLwTKbh/yv3uObMOgiztn5LFyHHV+p1Xo3tWQ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebPtKcLr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFB9C4CEE7;
	Fri, 25 Jul 2025 18:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753467004;
	bh=mR8xGn/8QuIuvkT73+Ar0nsUchts2skO9yvpLNneIuc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ebPtKcLre80O2fni/FSbWxw/FDKcuRXfUmDgyMhWsZaLRVzonkyNQY9qQ8qTSlsWy
	 KSUgZi+GMGFeELt33YNo4+3KAKpDDyrHenoV4Jd3NYElqRByvCXJzqY8SzjKmIBIUd
	 ouyOtePI7mM1gOA+1hQPO7r6g5gJfkUV/1CannPxZZ9ByE8n+yJlUNxEwxrT9X4O8v
	 wQkL1bVI13g1kQzkrsRmXBI+LE1v5BAih4L/n5XvoFuCZAz3+A1Vu66RBD6mu+qEZi
	 /WM58NR6EjO3+cujupSmMy6kMNWCV38HeXv9mfSGsPZnxdJKQT568KcnGJDH2Ei1RP
	 pP3ACfpAS5HkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACC4383BF5B;
	Fri, 25 Jul 2025 18:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: hibmcge: support for statistics of reset
 failures
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175346702175.3223523.5110525198701119445.git-patchwork-notify@kernel.org>
Date: Fri, 25 Jul 2025 18:10:21 +0000
References: <20250723074826.2756135-1-shaojijie@huawei.com>
In-Reply-To: <20250723074826.2756135-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shenjian15@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
 salil.mehta@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Jul 2025 15:48:26 +0800 you wrote:
> Add a statistical item to count the number of reset failures.
> This statistical item can be queried using ethtool -S or
> reported through diagnose information.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h   | 1 +
>  drivers/net/ethernet/hisilicon/hibmcge/hbg_diagnose.c | 1 +
>  drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c      | 2 ++
>  drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c  | 1 +
>  4 files changed, 5 insertions(+)

Here is the summary with links:
  - [net-next] net: hibmcge: support for statistics of reset failures
    https://git.kernel.org/netdev/net-next/c/15dc08fd2cac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



