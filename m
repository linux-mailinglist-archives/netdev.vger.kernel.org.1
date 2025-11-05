Return-Path: <netdev+bounces-235681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77846C33B4A
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 02:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA35463FC4
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 01:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A821DA62E;
	Wed,  5 Nov 2025 01:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdNW4qsd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C051D0DEE;
	Wed,  5 Nov 2025 01:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762307443; cv=none; b=hQPQBYH0k/9rFupLhHPmH6I2LjI4XlS41yp+FsR2balUgxSZ257Azy4QEUqcYov7LR5riUyhHw/NZZ3//iQPy7iXjBQO6v02wxAZQVQx4Cx3cq2yPHCI9LFUThyqkF0jP4mPuIN7/nO40z4aLRBUXV7RwQnuNbPQJHGzk7kdtT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762307443; c=relaxed/simple;
	bh=ASHhIonrCPM5/ky2JbdsyULw+yMv4J8KPRyx+IvEEzo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GC4iE2hAr8IWSuEjeL04d7oulVE9b7mWfU84GLd58xJNR3V+LM9HFagZu7k4LQ5BxsuPlWorr/deVDwc0rDwVkBfJQa3psEl/+DL6NNVeV6FpX+elWAt62htiUuaeMd2KEey50ev/uf0Rm0nEFWY6r6rZO7Vataqnv9WEr58LRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdNW4qsd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7C6C116D0;
	Wed,  5 Nov 2025 01:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762307443;
	bh=ASHhIonrCPM5/ky2JbdsyULw+yMv4J8KPRyx+IvEEzo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EdNW4qsdouzjzjUsz3So80w9tlsAToCuXCN0NtD8YjZ+P80Azqyrx2Z+Ix+v6o258
	 S63LRoZzmqX7WbhBmLzgZPxEUelNpkzWK0PUi/6/KacLcjEzJ/mS7wapK6r26LexTq
	 wY47fkV/Zm/Eunr+DngNS18woJCp/teZA2eQKBZf905S+b1/Zx4pEXyYm2R4GB8JHq
	 PjajcwrHsvCBSP/rfgadS1wVAHMB78nLaK3EYDwwFdDoyj7YbSJR7mS8aUGcxTzHa5
	 kOXrOZbN0DD9+AWBm59IkaJi5s+h/P8q2abeXcGaqu65IzGxLXkQOKcAbOQss2NgIB
	 8B2EcRakiluYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1D9380AA54;
	Wed,  5 Nov 2025 01:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: devmem: Remove unused declaration
 net_devmem_bind_tx_release()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176230741649.3056420.762015477151758471.git-patchwork-notify@kernel.org>
Date: Wed, 05 Nov 2025 01:50:16 +0000
References: <20251103072046.1670574-1-yuehaibing@huawei.com>
In-Reply-To: <20251103072046.1670574-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, almasrymina@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 3 Nov 2025 15:20:46 +0800 you wrote:
> Commit bd61848900bf ("net: devmem: Implement TX path") declared this
> but never implemented it.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  net/core/devmem.h | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] net: devmem: Remove unused declaration net_devmem_bind_tx_release()
    https://git.kernel.org/netdev/net-next/c/f2143e283c6b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



