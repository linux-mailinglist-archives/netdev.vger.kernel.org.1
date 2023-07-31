Return-Path: <netdev+bounces-22960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAA676A319
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 23:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C2711C20D5B
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 21:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1131E51C;
	Mon, 31 Jul 2023 21:40:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3241DDD6
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 21:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88AC2C43395;
	Mon, 31 Jul 2023 21:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690839621;
	bh=at8OvNbn8Q27R+M9mv9HqbrcnGKuN9m+SxRRQi127TU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IlXmWE+cVcTJ3TH6ycNm+Z6W8jKl3i6oGSUGCLnRYN/8ikGxm0hovVeIpWh/1Po8D
	 CtaCprM1UwbKlhCZ8L+8w/bPEzgHDPsqK9m1jJ0y1i/8BTLtVfI3itkCYirtj8bPyO
	 Ecr8iTsGMGcDDmlb3Q0fCjQvtDUOeu6rhkWGlwd16m0HOmAAIZeqMq93XEAsi+nzfq
	 O/MfrcDL/7kagc/y7eJcT9pUMXnStarP35oIt9JbyCLVA4TnonY40M/i72e2/+lHFi
	 RE0jTGzT2QsWrN98O8Inz0Au4kzj+iTA33ljGjMoPc7brIGOPO8ScR5pcKkd7mL80o
	 OyVwos8UxeHcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 66C7DC595C5;
	Mon, 31 Jul 2023 21:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] i40e: remove i40e_status
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169083962141.7301.9524010244985806750.git-patchwork-notify@kernel.org>
Date: Mon, 31 Jul 2023 21:40:21 +0000
References: <20230728171336.2446156-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230728171336.2446156-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, jan.sokolowski@intel.com,
 gurucharanx.g@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Jul 2023 10:13:36 -0700 you wrote:
> From: Jan Sokolowski <jan.sokolowski@intel.com>
> 
> Replace uses of i40e_status to as equivalent as possible error codes.
> Remove enum i40e_status as it is no longer needed
> 
> Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
> Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> 
> [...]

Here is the summary with links:
  - [net-next] i40e: remove i40e_status
    https://git.kernel.org/netdev/net-next/c/230f3d53a547

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



