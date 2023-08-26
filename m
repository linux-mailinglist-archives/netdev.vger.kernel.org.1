Return-Path: <netdev+bounces-30849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 655F0789345
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 04:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 270832819ED
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 02:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C44659;
	Sat, 26 Aug 2023 02:10:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088DA393
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 02:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 728A1C433C7;
	Sat, 26 Aug 2023 02:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693015825;
	bh=9zmHjATRXHP2hN3Axh+WGU0Vvcw/g8SRN5X6ZXiUFDE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G5jaYo2D6WKfIEnMd9544JGjHYx20/IkHV9fPvyUwhrpPw91iZpHZUnQdbh6EN38M
	 NYh9aVN8+3lCwAwCHGEaURkoZ/Hz3hrErZDdOjR/YE2FYB8WlSqnoEyP9fqdMdU1vz
	 hhn3rE79bVc+fY0AWvmdQLKyx+5wveKjLRv+d+oSdQc0nAremyQqyEk/U4mvtlO3ij
	 D3kVfEFcURLBgXZgZ44WVrsSfIlEkmve58HrkkhS1wZbgSYPOWDB21FpyfwrbkQ9xy
	 fUGKLAK8A1R+J8BviPhFtAYBHW/5P4Nc8PsjF7tDxYSb2cBxIT4BGFlpwG5GzMlOhf
	 pMfzh2HXz0M7w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 593B8C595C5;
	Sat, 26 Aug 2023 02:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] pds_core: error handling fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169301582536.16053.10881626283677643734.git-patchwork-notify@kernel.org>
Date: Sat, 26 Aug 2023 02:10:25 +0000
References: <20230824161754.34264-1-shannon.nelson@amd.com>
In-Reply-To: <20230824161754.34264-1-shannon.nelson@amd.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: brett.creeley@amd.com, davem@davemloft.net, netdev@vger.kernel.org,
 kuba@kernel.org, drivers@pensando.io

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Aug 2023 09:17:49 -0700 you wrote:
> Some fixes for better handling of broken states.
> 
> Shannon Nelson (5):
>   pds_core: protect devlink callbacks from fw_down state
>   pds_core: no health reporter in VF
>   pds_core: no reset command for VF
>   pds_core: check for work queue before use
>   pds_core: pass opcode to devcmd_wait
> 
> [...]

Here is the summary with links:
  - [net,1/5] pds_core: protect devlink callbacks from fw_down state
    https://git.kernel.org/netdev/net/c/91202ce78fcd
  - [net,2/5] pds_core: no health reporter in VF
    https://git.kernel.org/netdev/net/c/e48b894a1db7
  - [net,3/5] pds_core: no reset command for VF
    https://git.kernel.org/netdev/net/c/95e383226d6f
  - [net,4/5] pds_core: check for work queue before use
    https://git.kernel.org/netdev/net/c/969cfd4c8ca5
  - [net,5/5] pds_core: pass opcode to devcmd_wait
    https://git.kernel.org/netdev/net/c/0ea064e74bc8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



