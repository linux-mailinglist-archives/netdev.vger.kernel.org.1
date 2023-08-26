Return-Path: <netdev+bounces-30842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1976E789335
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 04:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7BC52819D5
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 02:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB8B38C;
	Sat, 26 Aug 2023 02:00:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3085037F
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 02:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84270C433C9;
	Sat, 26 Aug 2023 02:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693015224;
	bh=o46KMsO7FRfqG3p9aZ9Qw3NkDJKP2vC1xQ/IfNu91wA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D+GX/LgkwGg52Y0cNAg/CeelDAKG/yiVi98LJsMNeRMRGhddEUiIRhXQ9wmzvIxcl
	 EEp6oD//nhfUxX65Lb1eygCbWPTHPKkLiWORuTUdoXAcUgJAMEZ0zyXKRJZhKPs7YC
	 xWYumbKXfLMGrSsAZLno7teLCV0lzsxvH5T3nejpseIJWVfRD6WQCyRteRDaJPw6lY
	 GAeOhxVVrGTtHCJFR8a4v+Jyno90TGUbRlw4RbOi89BVCKHHLS3VwUBDQ3lXvxARVS
	 uvqd+Oz33odWxapuEUTEjn6yqCJwNMah1pcHfgpr8p/2LzHs2dsqN5Eeuz1ZxBVMwN
	 M4fY5ZuVbNIpg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A5F2C595C5;
	Sat, 26 Aug 2023 02:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH V4 0/3] Fix PFC related issues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169301522443.10076.12242857731455904416.git-patchwork-notify@kernel.org>
Date: Sat, 26 Aug 2023 02:00:24 +0000
References: <20230824081032.436432-1-sumang@marvell.com>
In-Reply-To: <20230824081032.436432-1-sumang@marvell.com>
To: Suman Ghosh <sumang@marvell.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, lcherian@marvell.com, jerinj@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Aug 2023 13:40:29 +0530 you wrote:
> This patchset fixes multiple PFC related issues related to Octeon.
> 
> Patch #1: octeontx2-pf: Fix PFC TX scheduler free
> 
> Patch #2: octeontx2-af: CN10KB: fix PFC configuration
> 
> Patch #3: octeonxt2-pf: Fix backpressure config for multiple PFC
> priorities to work simultaneously
> 
> [...]

Here is the summary with links:
  - [net,V4,1/3] octeontx2-pf: Fix PFC TX scheduler free
    https://git.kernel.org/netdev/net/c/a9ac2e187795
  - [net,V4,2/3] octeontx2-af: CN10KB: fix PFC configuration
    https://git.kernel.org/netdev/net/c/47bcc9c1cf6a
  - [net,V4,3/3] cteonxt2-pf: Fix backpressure config for multiple PFC priorities to work simultaneously
    https://git.kernel.org/netdev/net/c/597d0ec0e4ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



