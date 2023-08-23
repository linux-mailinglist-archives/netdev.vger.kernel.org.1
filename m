Return-Path: <netdev+bounces-29901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8677F785187
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 09:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B662E1C20C02
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 07:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153DA8F65;
	Wed, 23 Aug 2023 07:30:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A084720EE3
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 07:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 316CDC433CA;
	Wed, 23 Aug 2023 07:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692775827;
	bh=6v+GhMntJt0mrJ9Br1H8PrmidQgfEol82yJCdilc6zM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EnzCS6nrad5C36YPc+6bHqMHiPBAC3x7T56RhUv2WNjHMM3ABYfN/5PqUxbczoVkm
	 x5e2SErYGsDcb3h6Ft5jroXg1X1LfwygxMOug/arEDjBXj4R4SQsKkOc2zKyIe+sBu
	 VHOHFAlmmtfqZockQfKAhWDdM/+9DDsMGGtZtDdMs1xnNOdIDeXOI69FVsWoCUj+7x
	 g5MaxvtoqoOV5+dBBd19wp/e9WgWMCDE5WQHmmV4YVKnOebBBWe5zNuc6eHI9XQbXY
	 v8y6S2gy118rFCj2WeM4UCSwqzyxzsBbrIB69Pb9oz0bH7Y5ih/0eQkjni1duNB3mC
	 lEOHIAfIqS7ZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16018E21EDF;
	Wed, 23 Aug 2023 07:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v4] octeontx2-pf: Use PTP HW timestamp counter atomic
 update feature
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169277582708.32405.1334423903641395753.git-patchwork-notify@kernel.org>
Date: Wed, 23 Aug 2023 07:30:27 +0000
References: <20230821103629.3799884-1-saikrishnag@marvell.com>
In-Reply-To: <20230821103629.3799884-1-saikrishnag@marvell.com>
To: Sai Krishna <saikrishnag@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, richardcochran@gmail.com,
 kalesh-anakkur.purayil@broadcom.com, leon@kernel.org, naveenm@marvell.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 21 Aug 2023 16:06:29 +0530 you wrote:
> Some of the newer silicon versions in CN10K series supports a feature
> where in the current PTP timestamp in HW can be updated atomically
> without losing any cpu cycles unlike read/modify/write register.
> This patch uses this feature so that PTP accuracy can be improved
> while adjusting the master offset in HW. There is no need for SW
> timecounter when using this feature. So removed references to SW
> timecounter wherever appropriate.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] octeontx2-pf: Use PTP HW timestamp counter atomic update feature
    https://git.kernel.org/netdev/net-next/c/bdf79b128685

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



