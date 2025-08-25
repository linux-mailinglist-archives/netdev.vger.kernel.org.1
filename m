Return-Path: <netdev+bounces-216711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E51B34FBF
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 01:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6D0189E18C
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 23:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D302C08CE;
	Mon, 25 Aug 2025 23:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3XHEZo/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C3B1E991B;
	Mon, 25 Aug 2025 23:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756165200; cv=none; b=C6SsGGrCD7UZ3dh4I6Dl7WrLtis1u7pttsngGSiu7iEyHB0qeiitwW0Ntre7fngcw8OKLsOMsVKsbOpCyWpAsWyjxTVwIjT74M0RDjgSyF+oNqBtcwi+YWbFWEFsDAaiVf1Jwe5xsKW1XUQprM4s3XGXCkTN9W7b2a47hZf6c34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756165200; c=relaxed/simple;
	bh=VaV5Dp2jLjtlqZDg92neMPQ/wXbu7JAbUR85LHqA00U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=STk3S8EWjRKOd7TblsneKFkSBVGorIvGdunqtPngHhQS43fIXQ7ksSVPBJzt6k+dzNDW3TLzcFLlDaiizXYBoVMenHX4nrjQnlA4850yy1gHDv0BnrEWUx96C+oYAMwHmJWqZm0Cece2s4c8XrGLgZeWN5jrqS8cywLymU+AxwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3XHEZo/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83566C4CEED;
	Mon, 25 Aug 2025 23:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756165198;
	bh=VaV5Dp2jLjtlqZDg92neMPQ/wXbu7JAbUR85LHqA00U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c3XHEZo/rW6aa2n3REOiWqmZ7fO/4Bs7VLce2ir++MboZUuZPxqqEdNDxPSSgLaR7
	 nv1ExTYp3fezQEGw7Rka/PEW3Nlm3xvycoULyNukxIY7M8kn1Ko+QkCF6FIBSbXI5l
	 je8d+oc2McVZBfzLuNbctLQEJpqyL4qjMdbfVVQyqwa4VrDLHqX39ciXoV1YwM2r86
	 Dg13Wbt3sI2yDqBs+R/jZafhM1IpyYjJwgph520sGJ53ZmftfmpsUK4TlsFLNW9bbY
	 mrQzSDk6LoYXzC++TUBmvBYzJueYB8zOXwDZZlWoINyrrHmI5hm2KfS3eegVTe24zD
	 XZY7EH8YMG4SA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBE3383BF70;
	Mon, 25 Aug 2025 23:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] ipv6: mcast: Add ip6_mc_find_idev() helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175616520651.3596778.5635519816168457322.git-patchwork-notify@kernel.org>
Date: Mon, 25 Aug 2025 23:40:06 +0000
References: <20250822064051.2991480-1-yuehaibing@huawei.com>
In-Reply-To: <20250822064051.2991480-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dawid.osuchowski@linux.intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 22 Aug 2025 14:40:51 +0800 you wrote:
> Extract the same code logic from __ipv6_sock_mc_join() and
> ip6_mc_find_dev(), also add new helper ip6_mc_find_idev() to
> reduce redundancy and enhance readability.
> 
> No functional changes intended.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> 
> [...]

Here is the summary with links:
  - [v2,net-next] ipv6: mcast: Add ip6_mc_find_idev() helper
    https://git.kernel.org/netdev/net-next/c/60c481d4caa5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



