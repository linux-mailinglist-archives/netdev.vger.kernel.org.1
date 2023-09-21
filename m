Return-Path: <netdev+bounces-35376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D0A7A92D3
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 10:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC7341C208D0
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 08:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D328F5A;
	Thu, 21 Sep 2023 08:50:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A770E8F55
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 08:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 734C9C4163C;
	Thu, 21 Sep 2023 08:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695286222;
	bh=idtd5PplHRKkb0c3T0NLsqhQVXBFGZ7qFsapPOYeY4Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fmUVcMcoOZCyYl3t+8w/UhfeZihzl5y6tamWOTa+HBXld6ZeJkpPS1SmUdnkcCgc6
	 IukCtg69frwUjk4k3sBwthfPqoVaKTqE3JtChZ/a/RpfZWFqMc5b4cYc7jK6Akdc0J
	 oyH7A/Dj52I9u4fu/jKiAbLHflIVzXqy/gZJH3RIrPp4xhdqYkbIl/0FDFsaRRoi5j
	 b4Lf9w1J9AYYX8vwUMwt6YPim0zmPaI32lE71I12olCKZ5C3VDmBqXEN0yaMQs7tFm
	 CuRof/lnE958W9RxJzlTk6vs2M2P8POpvZrn2+O5WpF+kghe+mAxY3ggzpZ6ZJWa/N
	 rDlBJZibITz3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5CC2CC595C0;
	Thu, 21 Sep 2023 08:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sfc: handle error pointers returned by
 rhashtable_lookup_get_insert_fast()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169528622237.20950.7146192705850531950.git-patchwork-notify@kernel.org>
Date: Thu, 21 Sep 2023 08:50:22 +0000
References: <20230919183949.59392-1-edward.cree@amd.com>
In-Reply-To: <20230919183949.59392-1-edward.cree@amd.com>
To:  <edward.cree@amd.com>
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, ecree.xilinx@gmail.com,
 netdev@vger.kernel.org, habetsm.xilinx@gmail.com, dan.carpenter@linaro.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 19 Sep 2023 19:39:49 +0100 you wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Several places in TC offload code assumed that the return from
>  rhashtable_lookup_get_insert_fast() was always either NULL or a valid
>  pointer to an existing entry, but in fact that function can return an
>  error pointer.  In that case, perform the usual cleanup of the newly
>  created entry, then pass up the error, rather than attempting to take a
>  reference on the old entry.
> 
> [...]

Here is the summary with links:
  - [net] sfc: handle error pointers returned by rhashtable_lookup_get_insert_fast()
    https://git.kernel.org/netdev/net/c/fc21f08375db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



