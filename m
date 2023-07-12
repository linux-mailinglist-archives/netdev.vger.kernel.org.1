Return-Path: <netdev+bounces-17028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D4A74FDB7
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 05:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3EAF281861
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 03:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4750DECD;
	Wed, 12 Jul 2023 03:30:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10897F9
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 03:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6047EC433CA;
	Wed, 12 Jul 2023 03:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689132621;
	bh=nf8s+njeK8OMoPoLEn08q8t0z0oB7UZlF/uGzfV+kxQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uxU3r6W9obyLdEo5Qg2fFf+Yr/eImZxrHX8NjSw7HPFSShWnwX+JhEpvb/5V589qT
	 jYNimClhQOiN5TLD7OasoZTeSwZYArJexemm4XQOJLCnCBsESSj1zbpt7qKn935un0
	 y/u5xlRhi3lqB57AFG13I6Hr104tf6nCWI+FwEZwXivW+gLjUybX5CRDJAONvSNBNm
	 uNzGIp8Wf//cTSX+Fb4oWHcfEWB5ukjF39qgCDIGSWtMq0Qp4O3Ooc9X43yy+avi4Z
	 GGAYMWEmsi1NvSjWaRolqaYs1pzUWcz0xaZRAJ8GmAy5TSnVnbnLsUYk3noD9oW8Y3
	 UhewL4cmnqeog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 46137E4D006;
	Wed, 12 Jul 2023 03:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] MAINTAINERS: Add another mailing list for QUALCOMM
 ETHQOS ETHERNET DRIVER
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168913262128.27250.10319125912738064702.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jul 2023 03:30:21 +0000
References: <20230710195240.197047-1-ahalaney@redhat.com>
In-Reply-To: <20230710195240.197047-1-ahalaney@redhat.com>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 mcoquelin.stm32@gmail.com, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, joabreu@synopsys.com,
 alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
 bhupesh.sharma@linaro.org, vkoul@kernel.org, linux-arm-msm@vger.kernel.org,
 andersson@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Jul 2023 14:50:57 -0500 you wrote:
> linux-arm-msm is the list most people subscribe to in order to receive
> updates about Qualcomm related drivers. Make sure changes for the
> Qualcomm ethernet driver make it there.
> 
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net-next] MAINTAINERS: Add another mailing list for QUALCOMM ETHQOS ETHERNET DRIVER
    https://git.kernel.org/netdev/net/c/e522c1bd0ab4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



