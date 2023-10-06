Return-Path: <netdev+bounces-38524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BACD7BB4E8
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 12:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF87E2823DE
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 10:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3EE14F8D;
	Fri,  6 Oct 2023 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqpDHogy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B122714F88
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 10:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 304D2C433A9;
	Fri,  6 Oct 2023 10:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696587028;
	bh=bBWFpYfGtEFJl59aKw6OYVDdUNYv5zGgtsvWop9D6Ac=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UqpDHogycKwjKU+YhVwX+tkl7yRcIy3gL6dxPPXOCDRGAduKUr42CFFsnZiWAF1pz
	 Tr8WMx/lAFIpjUzZnD1IjIZ7K6+wUpwe892hvuE3obUFf0b+jypiSGmnP3BGvQySys
	 WqZO5OUKmpIjkbkwm234rja8pBGMFYfLv+V/ix9blGZCwYkGrBqDDQxR3oRYXxrXvm
	 pyPKIbZWW2CErsNjAgFJtAV9hHMMh26VLdcl1cP7b8tahKO6OzdtJR6LN5pDiqo6KZ
	 s/kCuAQBIKcJxQkDG1xp2NFkshp25/U4I5uJp1E/LvAy1wGowy9X/TjNtX09aufaM0
	 0vc+NdD/dpK+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B34CE632D2;
	Fri,  6 Oct 2023 10:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] sfc: conntrack offload for tunnels
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169658702810.26383.1165548433805682701.git-patchwork-notify@kernel.org>
Date: Fri, 06 Oct 2023 10:10:28 +0000
References: <cover.1696261222.git.ecree.xilinx@gmail.com>
In-Reply-To: <cover.1696261222.git.ecree.xilinx@gmail.com>
To:  <edward.cree@amd.com>
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, ecree.xilinx@gmail.com,
 netdev@vger.kernel.org, habetsm.xilinx@gmail.com,
 pieter.jansen-van-vuuren@amd.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 2 Oct 2023 16:44:40 +0100 you wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> This series adds support for offloading TC flower rules which require
>  both connection tracking and tunnel decapsulation.  Depending on the
>  match keys required, the left-hand-side rule may go in either the
>  Outer Rule table or the Action Rule table.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] sfc: support TC left-hand-side rules on foreign netdevs
    https://git.kernel.org/netdev/net-next/c/ec1dc6c88ce4
  - [net-next,2/4] sfc: offload foreign RHS rules without an encap match
    https://git.kernel.org/netdev/net-next/c/937a0feab42e
  - [net-next,3/4] sfc: ensure an extack msg from efx_tc_flower_replace_foreign EOPNOTSUPPs
    https://git.kernel.org/netdev/net-next/c/f96622fd3a74
  - [net-next,4/4] sfc: support TC rules which require OR-AR-CT-AR flow
    https://git.kernel.org/netdev/net-next/c/e447056147ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



