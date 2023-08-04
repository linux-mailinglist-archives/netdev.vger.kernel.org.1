Return-Path: <netdev+bounces-24596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A99DC770C03
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 00:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA0191C21786
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 22:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C751DA31;
	Fri,  4 Aug 2023 22:40:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB011DA52
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 22:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D328DC433C7;
	Fri,  4 Aug 2023 22:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691188823;
	bh=Mlx0EHCq2HKjEiX8nnvWw/FC235TywzSVsxR4WxHJjg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Nf5L+h6hJQ13W8XNVGR5ceaHJFlIVH2hODFsE1L4vYZjdkcEd7APSOfTIFA9FBSCB
	 ew78gYUh9CLN0uJOpx2XyJyHnpPBLGyMWnGip9ldApft7AVzal4PSC9aLXBZDxazfB
	 qvlxjE/cZbXzomJehVB3RHaOWLcBOJqPQ1Ban2HolzCtjGa4NDl4r6K6bsiDaR3RWt
	 nIXqm+OpSaWdyM/4SEkFi/q7i8LyT75LwSEABi8IMNVBKnGCNGYbbUV1LnFkCR7YMC
	 IzO75IFqC/rSV4Azj8pv2J814VtgLNuG+/tWX7uHjh8muTVcDq9iLsNIBPkuOjdArS
	 kIX7ourfmjxyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BCC23C395F3;
	Fri,  4 Aug 2023 22:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next] af_vsock: Remove unused declaration
 vsock_release_pending()/vsock_init_tap()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169118882376.4114.10938724911991254974.git-patchwork-notify@kernel.org>
Date: Fri, 04 Aug 2023 22:40:23 +0000
References: <20230803134507.22660-1-yuehaibing@huawei.com>
In-Reply-To: <20230803134507.22660-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, bobby.eshleman@bytedance.com,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 3 Aug 2023 21:45:07 +0800 you wrote:
> Commit d021c344051a ("VSOCK: Introduce VM Sockets") declared but never implemented
> vsock_release_pending(). Also vsock_init_tap() never implemented since introduction
> in commit 531b374834c8 ("VSOCK: Add vsockmon tap functions").
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/net/af_vsock.h | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - [-next] af_vsock: Remove unused declaration vsock_release_pending()/vsock_init_tap()
    https://git.kernel.org/netdev/net-next/c/781486e415dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



