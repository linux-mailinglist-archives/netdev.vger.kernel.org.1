Return-Path: <netdev+bounces-52004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5667FCDD4
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 05:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37130281B32
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 04:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119996FA7;
	Wed, 29 Nov 2023 04:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4hWHUv0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45A363DB
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 04:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F7A9C433C9;
	Wed, 29 Nov 2023 04:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701231626;
	bh=5oclWSoAa85DmO8iZJZwA+Gg4jtvuIhh8+N9OzoE1MM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P4hWHUv0cyjIdNXl4H93MKbRbwXPcZvp3XxdGHZ7WqR2LxgGrymafn3/dC3HTnAgM
	 AqhCyUAwBz24a9jGJXlg/dOO/mb9wQvYxRHVlipjY/UO7CuwhdS/O5htkymCXMKN66
	 GFEMXJYrLXg78mYcGel0JE79nhtCfZB2bUe9DrDdJyIxiREXEfSm6WzvkHr1CnK5up
	 OOdaTXbt08af2lrWc/dhgN5Pp6afR0/4CO74cO6OGtaSafA7gep2X0wOC2DC7xY0Xy
	 Qv9At27Cub0vzXa2H0pKVcR9e+jae/H4Qh+qUtKM0ODdCidn2cWswXQ8vR2roMsThE
	 VWciTRTsq4cOA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55F3FDFAA89;
	Wed, 29 Nov 2023 04:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5][pull request] Intel Wired LAN Driver Updates
 2023-11-27 (i40e, iavf)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170123162634.8478.11479607548435665693.git-patchwork-notify@kernel.org>
Date: Wed, 29 Nov 2023 04:20:26 +0000
References: <20231127211037.1135403-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20231127211037.1135403-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon, 27 Nov 2023 13:10:30 -0800 you wrote:
> This series contains updates to i40e and iavf drivers.
> 
> Ivan Vecera performs more cleanups on i40e and iavf drivers; removing
> unused fields, defines, and unneeded fields.
> 
> Petr Oros utilizes iavf_schedule_aq_request() helper to replace open
> coded equivalents.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] i40e: Delete unused and useless i40e_pf fields
    https://git.kernel.org/netdev/net-next/c/e620d2450636
  - [net-next,2/5] i40e: Remove AQ register definitions for VF types
    https://git.kernel.org/netdev/net-next/c/64c0aad13bb8
  - [net-next,3/5] i40e: Remove queue tracking fields from i40e_adminq_ring
    https://git.kernel.org/netdev/net-next/c/4a95ce2407da
  - [net-next,4/5] iavf: Remove queue tracking fields from iavf_adminq_ring
    https://git.kernel.org/netdev/net-next/c/3d66f21552df
  - [net-next,5/5] iavf: use iavf_schedule_aq_request() helper
    https://git.kernel.org/netdev/net-next/c/95260816b489

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



