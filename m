Return-Path: <netdev+bounces-18583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D52AA757CB2
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 15:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12CD01C20D50
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 13:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFCB101FA;
	Tue, 18 Jul 2023 13:00:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B7910780
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 13:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3FC1BC433CB;
	Tue, 18 Jul 2023 13:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689685221;
	bh=YhcgHtzLlmVi3GHSDNyC9x/8/VLUnN1Gq6tIeq0PHBs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MKoIfJbOBdKaOVRbdMtzyRcxQs97Cy+/X0x1omDzZpeDXMAwb1JK7UXlBGGyMfSOT
	 clb1DfI1kou11LW4pBk9Kz4BRyP9/ofv18XWqqY5Z9z7NYZuRZd/UH/f3uWbt7ajMu
	 pULbfLB5gt4fC0kSgmXS8byaWz0DQl0cERiEOwuLsc/lB8VADgTSSrsWNOJrTecLFf
	 xUHUC0SC8lx2RlSSoE29dZ6iykfBggDfnZDSNlTrELiRqEJpx90BJkdtaOxSwf5ADX
	 8E+8daF79dmnReDp0N31XWsQR+2Ao0sUDkZU2MCqcvglezaYYlBAFeYPYqxVvXTSpM
	 SxNSFBKE3khCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C4CFC64458;
	Tue, 18 Jul 2023 13:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH] octeontx2-pf: Dont allocate BPIDs for LBK interfaces
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168968522117.17545.5835247146378375722.git-patchwork-notify@kernel.org>
Date: Tue, 18 Jul 2023 13:00:21 +0000
References: <20230716093741.28063-1-gakula@marvell.com>
In-Reply-To: <20230716093741.28063-1-gakula@marvell.com>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 16 Jul 2023 15:07:41 +0530 you wrote:
> Current driver enables backpressure for LBK interfaces.
> But these interfaces do not support this feature.
> Hence, this patch fixes the issue by skipping the
> backpressure configuration for these interfaces.
> 
> Fixes: 75f36270990c ("octeontx2-pf: Support to enable/disable pause frames via ethtool").
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-pf: Dont allocate BPIDs for LBK interfaces
    https://git.kernel.org/netdev/net/c/8fcd7c7b3a38

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



