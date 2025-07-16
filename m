Return-Path: <netdev+bounces-207643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E42B080DC
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 01:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AF761AA5D34
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 23:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557102EF678;
	Wed, 16 Jul 2025 23:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5OPLxqH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5AD19DF8D;
	Wed, 16 Jul 2025 23:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752707994; cv=none; b=USyRn4a9o+O0e7lGJGKxZZxm2NtBYcIC8Mp1wMoIPESBE2boSxHxPIj4KQVJ1Tep9Vh0oYNCuKlgOSQSF0YJYWBFGxb1URIwatEEJO7nKptXf/1KtAQ+5CKzlOiTHpSlQLCiBW0c5nxYfA2x6w7kLMC+Og65HwLzt1uISyX+prM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752707994; c=relaxed/simple;
	bh=Zw9ns3bYrLEBknvQa/6XNMJZ7ZxUJKqLt+KFDgtgS/0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EiBp87MdPYLEar4WpLV5moNImNwPWgmIc0w2WHorn7/dHlzJjjqAU/NJAoot1e6bkz+zZyI38VeI+zXTdnkjFiX6GleFUCG/Gum1E53lgDoFLH7/mmzjeiWsFejv1MtXzUAICb54BsHpdstGrlUHgfzaPmgujjRTPa4XLO38qkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5OPLxqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5259C4CEF5;
	Wed, 16 Jul 2025 23:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752707993;
	bh=Zw9ns3bYrLEBknvQa/6XNMJZ7ZxUJKqLt+KFDgtgS/0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E5OPLxqH2hnQT1iLdDelznuST+MUsVHE6FBCxobQ9BWSHtFlb1cZ7UBIWl1fnTkiL
	 pQgBwqGzG8jyUjCHbTAJt5hjpK9fKzwMousYv3irz4iTMwHM9M79+/pkQSNVKl/FAB
	 +A0851gwGm8b88unWeWC2eJegSnT9NTruNWbrUoFwzFv428YeJ9id7vFIoF7y7qWPg
	 1V4mmvxpoIryvMteqGuXNnFZ+Cn3GYB6ymrx2KWmky5FylabQjvI3fw/bimcX9laFV
	 5nXzsopFt3MyNCZuQbC+mL91AVGB/ahSAVzGn7MTpubl7Op3EKDK+xBsBSFEr+gE4G
	 TSZs0gws3nEAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EB4383BA38;
	Wed, 16 Jul 2025 23:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] ipv6: mcast: Simplify
 mld_clear_{report|query}()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175270801375.1359575.5005912919014728213.git-patchwork-notify@kernel.org>
Date: Wed, 16 Jul 2025 23:20:13 +0000
References: <20250715120709.3941510-1-yuehaibing@huawei.com>
In-Reply-To: <20250715120709.3941510-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Jul 2025 20:07:09 +0800 you wrote:
> Use __skb_queue_purge() instead of re-implementing it. Note that it uses
> kfree_skb_reason() instead of kfree_skb() internally, and pass
> SKB_DROP_REASON_QUEUE_PURGE drop reason to the kfree_skb tracepoint.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
> v2: Add drop reason note
> 
> [...]

Here is the summary with links:
  - [v2,net-next] ipv6: mcast: Simplify mld_clear_{report|query}()
    https://git.kernel.org/netdev/net-next/c/6c628ed95e1b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



