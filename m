Return-Path: <netdev+bounces-119956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C89F957AAD
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 03:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EE5D1C23D02
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 01:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E0522EF0;
	Tue, 20 Aug 2024 01:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZqa41/l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F91822615;
	Tue, 20 Aug 2024 01:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724115639; cv=none; b=XtKFIg0d1bXtu0mTodbey3yWGX9IFMuOvHeX36MoYyUpNo9ELGjuOJnyc/f5IXSiU/xhb9mF5pgNMa6wVccsU1UJI33orT/Z9nkioqV0W0K8hTdMOHLzN4X3fgshp4cCE0XFhskfmGRDhHHNSJHr2MUfuxnoiA9OUlDp/Gg/foo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724115639; c=relaxed/simple;
	bh=VlvfzE9Dh+iO0kVgPewf7MSEEY3t7u4dhTPvVmxwLW0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UKk92hhbhpx6yL5TRdzWujMcK/w2Yyyxb5jJfxFE8p8UbX65/Taii6z3v8c1dk/ZVx4y/hYm5rhZtRYBP/Ka6vPqA41eku5wwbmDNF86+sTJC+HA/DNHj44Oqjy0AMRqs/88QwfmiGlr06tpxZug7W92gLTqinq/ihbduaishwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZqa41/l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019F7C4AF09;
	Tue, 20 Aug 2024 01:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724115639;
	bh=VlvfzE9Dh+iO0kVgPewf7MSEEY3t7u4dhTPvVmxwLW0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LZqa41/lTeuyM80gVKw469o+4LAgnsBo3zUPG+jPwhJCyt9zfifiuvbi2G4iyi/l9
	 12Uj7Npxz4jHdZrqt0zGuQHvZ58clgC2A8XvS2TZIxasils9dsX8oL9cO1L9fbam9y
	 X72xr+O+ursKf5V2izvd+vc34Rj43uaSwonRBSlbzydElgJY87MWDC/GQ8YEYE9HaM
	 MVLRF3DqhHCRXShbStWeNdnFL3LcP0ZnMdZ4K2zvl3zJgL1JGV4LbYU0LEZahrMRGq
	 TjApZkrBV4UZbgWdNDR6BYvkdwBB53j5oXB+w/G8uQBcjkw3OFi0zNtPFeihUNPQus
	 ukzFW0lBE7qsQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF123823271;
	Tue, 20 Aug 2024 01:00:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next] mptcp: Remove unused declaration mptcp_sockopt_sync()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172411563825.698489.16044829996229738152.git-patchwork-notify@kernel.org>
Date: Tue, 20 Aug 2024 01:00:38 +0000
References: <20240816100404.879598-1-yuehaibing@huawei.com>
In-Reply-To: <20240816100404.879598-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 Aug 2024 18:04:04 +0800 you wrote:
> Commit a1ab24e5fc4a ("mptcp: consolidate sockopt synchronization")
> removed the implementation but leave declaration.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  net/mptcp/protocol.h | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [-next] mptcp: Remove unused declaration mptcp_sockopt_sync()
    https://git.kernel.org/netdev/net-next/c/af3dc0ad3167

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



