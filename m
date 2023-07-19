Return-Path: <netdev+bounces-18792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07359758A8B
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 03:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386ED1C20F4F
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 01:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDCA15CC;
	Wed, 19 Jul 2023 01:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41538ECA
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 01:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6849C433C7;
	Wed, 19 Jul 2023 01:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689728422;
	bh=/EM1Ck0pU2ew4+uiB+AaILEDkob0HAc2vSPVlNmE1xM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rQ0vDuLrneJuaA4zlVdixP+M6x3Q5X4riTvAnSG2/0/2GwIplKxYfHx+LDEEUVLA+
	 VPRTZrqwU4Jbhg2tfGr4gHQYulGAiBcNgvdKgygYO/GWJzqA3//dYaiNN0WR3fXf0V
	 D0eQamx+C5wMX+t4Fr4v5AbW4DjSCOL5TL0id22wR4BE0G6gWNWVMsvJWJwVcbKP6T
	 Ed3h3l6vwHzCvR/hUdADGHd0KASYVuTUToJYpIthPvQOdH/X4rPPoUmQZ/0HT+7d12
	 +OVQIKXgpp3FGlSNASrIFRFcwUrI0CBJ9jd5nN7ND5oIvPcnZ1QvWcsyD8pr06NFv0
	 Xr51DzH4rFUOw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A4317E22AE5;
	Wed, 19 Jul 2023 01:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] mailmap: add entries for past lives
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168972842266.21294.876105581099007243.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jul 2023 01:00:22 +0000
References: <20230717193242.43670-1-shannon.nelson@amd.com>
In-Reply-To: <20230717193242.43670-1-shannon.nelson@amd.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Jul 2023 12:32:42 -0700 you wrote:
> Update old emails for my current work email.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> ---
>  .mailmap | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - [net] mailmap: add entries for past lives
    https://git.kernel.org/netdev/net/c/d1998e505a99

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



