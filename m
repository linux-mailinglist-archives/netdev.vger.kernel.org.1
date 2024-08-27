Return-Path: <netdev+bounces-122525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC1396193F
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 23:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1491C22D6F
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 21:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2211D461C;
	Tue, 27 Aug 2024 21:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGao4S1m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063661D4614
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 21:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724794240; cv=none; b=oF2dAlY7QUZBVA6ruG5T4NNr7A08IdZFodvfGUsL3gpXn+pWljUmV9ryM7pkQZL9Mg5PSLflW1eozbZHujNgI7GdXb7F4P/RWTuRSfKvMOmvjMsouMDpSeIIZ3ApeUWXZIBng2if9jFpYFu8tCNpuRh1l+cBxHzD32BHmBsRHhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724794240; c=relaxed/simple;
	bh=Wb0FZJQjqSpwsWdphJjDsQPzoGqGnU4z/tqaJA9GZPg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ERJvuGJtKjZfeW7gJ754Num6liDqwBq9hMF0mLuYvmmBynlfyLwik+thEz/7ZzBmgec38Ufm688IiGvpwKyR0HKP9mPJX85lRc7Yrur3n+AojZXcpNMJt4EWYkgtmkp0wLT4D1ac8qB92ZFSjMzehjFkLI4pBp5yEKxv5esCA4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGao4S1m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932E9C4AF1C;
	Tue, 27 Aug 2024 21:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724794239;
	bh=Wb0FZJQjqSpwsWdphJjDsQPzoGqGnU4z/tqaJA9GZPg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TGao4S1maEzO0eJx11p/e1yWcwEflbNRqFptM7aqrnKt7hyDmyGbwM2IpxGlYU7Hd
	 r57zSvzNiKyeNg02DJur6SHrWUjRkE7rqzgorB9VT6AEMdvLRuplulQ2HojFHM9O0p
	 f+X9uQgnT5PXe8c4swwjZbcWks02DZ1in1F+WnJqBq+M661e0JHk+CBtZNvvKPLOEZ
	 vDmPcE7HSNCzYzqnWWQsTnhstNKM+Lww13iT4f+FBAd8KESuGp31F+fn6h9L8N/Fh5
	 VWh9xt6qg4yI9nLEjyUoZefRph1rlvewAl6HD6OXMr/LaVYiWlk885HEBZq+JLWKpP
	 5Nuer7GqgcENw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE233822D6D;
	Tue, 27 Aug 2024 21:30:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next] net: txgbe: use pci_dev_id() helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172479423949.767553.17973661584756681774.git-patchwork-notify@kernel.org>
Date: Tue, 27 Aug 2024 21:30:39 +0000
References: <20240826012100.3975175-1-liaoyu15@huawei.com>
In-Reply-To: <20240826012100.3975175-1-liaoyu15@huawei.com>
To: Yu Liao <liaoyu15@huawei.com>
Cc: jiawenwu@trustnetic.com, mengyuanlou@net-swift.com, liwei391@huawei.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Aug 2024 09:21:00 +0800 you wrote:
> PCI core API pci_dev_id() can be used to get the BDF number for a PCI
> device. We don't need to compose it manually. Use pci_dev_id() to
> simplify the code a little bit.
> 
> Signed-off-by: Yu Liao <liaoyu15@huawei.com>
> ---
>  drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Here is the summary with links:
  - [-next] net: txgbe: use pci_dev_id() helper
    https://git.kernel.org/netdev/net-next/c/d76867efebcb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



