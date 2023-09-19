Return-Path: <netdev+bounces-34918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C904F7A5E8F
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 11:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAEDA1C20EB1
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 09:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C12E3FB2E;
	Tue, 19 Sep 2023 09:50:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2DC538C
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 09:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA440C433C9;
	Tue, 19 Sep 2023 09:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695117022;
	bh=KqFckHRW1wemRtJKOBzu5za3YKLNJkw8oPNLBCYuEZE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GLEGCyd2BmZYiL3qzQ/quWB8FUs0WW7m8DUEccQsns7zXAnisBCnRZKEPQ0WkXer5
	 SEVjkFX951BHnn/3QXR/X6aW9wdlPty9DuveRai0DP0Sx6O6+B+4KIxrMSXdkf2cfe
	 wOH6qGFEtniT4Kb/+poONSfvWbcUZwjB9aSSqNIk+KE7ZepQCbH4LuFIqRb44bbtZX
	 UI2eJRPk0MRpWYM5O91R7rW3sPPVfediaTlA3vsnu9k4PzCam25ceEmPsnrGuNUjP8
	 rYBml52xy9OgErAPkGpid4SZCmxsriRYxekcLA+wTOSYeGqEiTIezk722Qf4gGuPRR
	 z4+9UsTFhMKhw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C01E1E11F41;
	Tue, 19 Sep 2023 09:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] octeon_ep: restructured interrupt handlers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169511702277.19851.5148115335209264246.git-patchwork-notify@kernel.org>
Date: Tue, 19 Sep 2023 09:50:22 +0000
References: <20230918065621.2165449-1-srasheed@marvell.com>
In-Reply-To: <20230918065621.2165449-1-srasheed@marvell.com>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hgani@marvell.com,
 egallen@redhat.com, mschmidt@redhat.com, vimleshk@marvell.com,
 vburru@marvell.com, sedara@marvell.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 17 Sep 2023 23:56:21 -0700 you wrote:
> Separated queue specific interrupts to register to individual msix-vectors
> instead of using a single generic interrupt handler on a single
> msix-vector.
> 
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> ---
>  .../marvell/octeon_ep/octep_cn9k_pf.c         | 158 ++++++++++----
>  .../ethernet/marvell/octeon_ep/octep_main.c   | 197 +++++++++++++++++-
>  .../ethernet/marvell/octeon_ep/octep_main.h   |  13 +-
>  3 files changed, 323 insertions(+), 45 deletions(-)

Here is the summary with links:
  - [net-next] octeon_ep: restructured interrupt handlers
    https://git.kernel.org/netdev/net-next/c/0b8ef824eede

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



