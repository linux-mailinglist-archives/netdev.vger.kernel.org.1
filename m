Return-Path: <netdev+bounces-12923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2AA739711
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 07:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 197981C21098
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 05:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32EF5699;
	Thu, 22 Jun 2023 05:50:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20062522F
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:50:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CC5DC433CA;
	Thu, 22 Jun 2023 05:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687413029;
	bh=Deo+Tw95DFGindJjHv1dCvxfDNNt3Fo4eDFNdv9oMHI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cqRpOKKuiiSZ7RYUYgF18qGFep+5rhTW0UP0HMMeaoeWZyVCOVCx44h+Xhb22b8co
	 HRp5GKCCF0e2fvqW439pvjaw8jiYuwJFKc2qsr9S/Rurvc9i9yObFjVsx0tIH1lXrB
	 3JM/Uz0AmzYC1y2d8c0m6IJUlauaZOOtefCeKleFIL5KX+BDdj9GjW6Y5nZOzzbn06
	 di/PVudXXpO3t53eae9LaMC6orT8RgQ16HswQeLTt1bR6QqmoTw52ZlyUir2LmX0/G
	 u1QTE00sJ/GO5d1RS3FpztBqCG1bBIeLc2SYmX5MkM4Y34XGZG0oJr0gHBORvDlyi4
	 kMHN2twRLF1Zw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5DB6FE301F8;
	Thu, 22 Jun 2023 05:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: ena: Fix rst format issues in readme
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168741302937.1197.15797681864661496973.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jun 2023 05:50:29 +0000
References: <20230620133544.32584-1-darinzon@amazon.com>
In-Reply-To: <20230620133544.32584-1-darinzon@amazon.com>
To: Arinzon@codeaurora.org, David <darinzon@amazon.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 dwmw@amazon.com, zorik@amazon.com, matua@amazon.com, saeedb@amazon.com,
 msw@amazon.com, aliguori@amazon.com, nafea@amazon.com, alisaidi@amazon.com,
 benh@amazon.com, akiyano@amazon.com, ndagan@amazon.com, shayagr@amazon.com,
 itzko@amazon.com, osamaabb@amazon.com, lkp@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Jun 2023 13:35:44 +0000 you wrote:
> From: David Arinzon <darinzon@amazon.com>
> 
> This patch fixes a warning in the ena documentation
> file identified by the kernel automatic tools.
> The patch also adds a missing newline between
> sections.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: ena: Fix rst format issues in readme
    https://git.kernel.org/netdev/net-next/c/5dfbbaa208f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



