Return-Path: <netdev+bounces-52910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB5A800AC4
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 13:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CC961C20E68
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 12:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F3E250F2;
	Fri,  1 Dec 2023 12:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHcxvloa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D02250E1
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 12:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2AE11C43391;
	Fri,  1 Dec 2023 12:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701433224;
	bh=GxOpMes2kicKpLodY8rnfocgHs/5AC98YnYsa3etZ/A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bHcxvloa6YL4WLEjc8AlxQ/I0B8CB6Hyf1SYzLUz+KIPtwVjdkz5wM+erkMZq3FqC
	 URV75MFCRZ4bEUGEcXRFApWvc0JXXOBJrXxz5QuXejGRGQhBkI6lXkhjEu709lfscT
	 OAIELFCBsCap7Haddcb2+53IZIvFlWBw1YBjZ6BPltRteWLBjFhutsmrK9PtdYksO4
	 +SsXdPRtHDnQLbRNSWuA5P3DKtK5j43R+d//WHSdVcCpEl5GxmkgL8WzVBJF+/FqOJ
	 6pTSouY4WC/sEIWTMRowHJbjBDq1AUgJTUa0a+pV5S2cjf6UADkfCuFhnVCkxa3+kv
	 jiVg7vpjRKuhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 15A0FE11F66;
	Fri,  1 Dec 2023 12:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] octeon_ep: set backpressure watermark for RX
 queues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170143322408.17347.17756295348406257934.git-patchwork-notify@kernel.org>
Date: Fri, 01 Dec 2023 12:20:24 +0000
References: <20231129053131.2539669-1-srasheed@marvell.com>
In-Reply-To: <20231129053131.2539669-1-srasheed@marvell.com>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hgani@marvell.com,
 vimleshk@marvell.com, egallen@redhat.com, mschmidt@redhat.com,
 pabeni@redhat.com, horms@kernel.org, kuba@kernel.org, davem@davemloft.net,
 wizhao@redhat.com, konguyen@redhat.com, vburru@marvell.com,
 sedara@marvell.com, edumazet@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 28 Nov 2023 21:31:31 -0800 you wrote:
> Set backpressure watermark for hardware RX queues. Backpressure
> gets triggered when the available buffers of a hardware RX queue
> falls below the set watermark. This backpressure will propagate
> to packet processing pipeline in the OCTEON card, so that the host
> receives fewer packets and prevents packet dropping at host.
> 
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v1] octeon_ep: set backpressure watermark for RX queues
    https://git.kernel.org/netdev/net-next/c/15bc81212f59

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



