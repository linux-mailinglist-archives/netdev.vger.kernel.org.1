Return-Path: <netdev+bounces-42833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FF07D053C
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 01:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 587DE1C20E44
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 23:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D88142BF7;
	Thu, 19 Oct 2023 23:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvv/EY+x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D4D4292A
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 23:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B065CC433C7;
	Thu, 19 Oct 2023 23:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697756424;
	bh=GMmASKtetAbWynN2bpXIPxiHABsrHpx6j839G0b0k04=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qvv/EY+xHre7WkV9GsKQgoYxqr6PPvqPQGFL628nSYMbqk3GcknoVEBjrxEW+DnZh
	 FAaOv9E8P4kCETHUozE5uz2NHWm2iTfVu6OuAI8zalmedYBV3hNZENR1NMKZdPYw3D
	 zf8dJa0S2ODhAOBdzJwJQUfdZ5IXd0zrWJyD6Xd6WfxMgHbeTcXr4k7MtVUz/afVbR
	 QdioOMKP9tlTB12jXbBFTe7+DoRNsiZrrRkkPseZU4YVMvheupwA/2o/WOgS5p5nIe
	 rXXDfP/JDvDR7F4EC/5JdfpE6Y8o29VYzSPo8jNowORX2n/PGLJj20tQ89QbM8Be+M
	 BjajU8Nm+1Nrg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 95D97C59A4C;
	Thu, 19 Oct 2023 23:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] tools: ynl-gen: support full range of min/max
 checks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169775642461.1542.18363155290583010468.git-patchwork-notify@kernel.org>
Date: Thu, 19 Oct 2023 23:00:24 +0000
References: <20231018163917.2514503-1-kuba@kernel.org>
In-Reply-To: <20231018163917.2514503-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, dcaratti@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Oct 2023 09:39:14 -0700 you wrote:
> YNL code gen currently supports only very simple range checks
> within the range of s16. Add support for full range of u64 / s64
> which is good to have, and will be even more important with uint / sint.
> 
> Jakub Kicinski (3):
>   tools: ynl-gen: track attribute use
>   tools: ynl-gen: support full range of min/max checks for integer
>     values
>   tools: ynl-gen: support limit names
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] tools: ynl-gen: track attribute use
    https://git.kernel.org/netdev/net-next/c/ee0a4cfcbdcc
  - [net-next,2/3] tools: ynl-gen: support full range of min/max checks for integer values
    https://git.kernel.org/netdev/net-next/c/668c1ac828fb
  - [net-next,3/3] tools: ynl-gen: support limit names
    https://git.kernel.org/netdev/net-next/c/f9bc3cbc20d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



