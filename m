Return-Path: <netdev+bounces-38703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9567BC2D3
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 01:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59C2E281E45
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 23:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6934345F74;
	Fri,  6 Oct 2023 23:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVGIYM+A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CC344487
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 23:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA567C433C9;
	Fri,  6 Oct 2023 23:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696633826;
	bh=9Gn+pTlpi8LgtdBOyp3BNnfFiAZ/T7asi13Zl9aIcNs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DVGIYM+AfOeucTBXSaneh3aJfZaRLY0Ifgo170ky67jBnMC8nbh7wet1D+Tn4XZXj
	 SKfo4gDEewbcgA8zd/QnmmP2lZaGGh0iddIqqXMFWRC9qpLrHo+5VWtrQt9E8VPMm1
	 G1wjvVO9x7jIZi8OrJOK3l4HmMW4rxXJCjx1IrHtFg2aj0c46WOy4F1VSJAGG2p7kw
	 rOJkgsi7nCiC0Z3Lc1P/ULM7M6+GdK7LGGuaCLrSy74VDs5w8NCFujA3zatE1dClSP
	 2Q9PdXc4suQnZhPC6RxK5/0vXCWaXiSi5XAqBVj3iUfc/e13ECpN7M/XK/VUkX99dS
	 UjYS/WheEzRrA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ACFB8C595CB;
	Fri,  6 Oct 2023 23:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/9][pull request] i40e: House-keeping and clean-up
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169663382670.5705.16758100919166508442.git-patchwork-notify@kernel.org>
Date: Fri, 06 Oct 2023 23:10:26 +0000
References: <20231005162850.3218594-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20231005162850.3218594-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, przemyslaw.kitszel@intel.com,
 jesse.brandeburg@intel.com, aleksandr.loktionov@intel.com,
 jacob.e.keller@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Thu,  5 Oct 2023 09:28:41 -0700 you wrote:
> Ivan Vecera says:
> 
> The series makes some house-keeping tasks on i40e driver:
> 
> Patch 1: Removes unnecessary back pointer from i40e_hw
> Patch 2: Moves I40E_MASK macro to i40e_register.h where is used
> Patch 3: Refactors I40E_MDIO_CLAUSE* to use the common macro
> Patch 4: Add header dependencies to <linux/avf/virtchnl.h>
> Patch 5: Simplifies memory alloction functions
> Patch 6: Moves mem alloc structures to i40e_alloc.h
> Patch 7: Splits i40e_osdep.h to i40e_debug.h and i40e_io.h
> Patch 8: Removes circular header deps, fixes and cleans headers
> Patch 9: Moves DDP specific macros and structs to i40e_ddp.c
> 
> [...]

Here is the summary with links:
  - [net-next,1/9] i40e: Remove back pointer from i40e_hw structure
    https://git.kernel.org/netdev/net-next/c/39ec612acf6d
  - [net-next,2/9] i40e: Move I40E_MASK macro to i40e_register.h
    https://git.kernel.org/netdev/net-next/c/9d84f739d617
  - [net-next,3/9] i40e: Refactor I40E_MDIO_CLAUSE* macros
    https://git.kernel.org/netdev/net-next/c/8196b5fd6c73
  - [net-next,4/9] virtchnl: Add header dependencies
    https://git.kernel.org/netdev/net-next/c/7151d87a175c
  - [net-next,5/9] i40e: Simplify memory allocation functions
    https://git.kernel.org/netdev/net-next/c/d3276f928a1d
  - [net-next,6/9] i40e: Move memory allocation structures to i40e_alloc.h
    https://git.kernel.org/netdev/net-next/c/ef5d54078d45
  - [net-next,7/9] i40e: Split i40e_osdep.h
    https://git.kernel.org/netdev/net-next/c/5dfd37c37a44
  - [net-next,8/9] i40e: Remove circular header dependencies and fix headers
    https://git.kernel.org/netdev/net-next/c/56df345917c0
  - [net-next,9/9] i40e: Move DDP specific macros and structures to i40e_ddp.c
    https://git.kernel.org/netdev/net-next/c/190c3ad68f38

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



