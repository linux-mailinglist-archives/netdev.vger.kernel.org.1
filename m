Return-Path: <netdev+bounces-43665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A04F7D42FB
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 01:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90C7FB20C6E
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 23:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF90241ED;
	Mon, 23 Oct 2023 23:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjtBPVP2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE300241E5
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 23:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B652C433C7;
	Mon, 23 Oct 2023 23:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698102024;
	bh=Rw0AQlcXOdxT530RTSxwtjiUC+R5IP0hNjOmubWI+RM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AjtBPVP2SIsEcKCXrFS0OMNHnHdyM6X5i9prCwll+y8dis9PvHf8kqm2mCrjkfGja
	 nm1ul1AFh7BtDkcp3kD54/Nt+668Tv6WskHNVF85wcm78M0A4JsgxbsLJf/suzGiB+
	 j/06ex4dLNS/n5X8T8Hw1xdb2soHRR8WC1J5lPYr7MeDS3vh5x1mF90fw6ROZaCMIz
	 V9VjpFq8eU6FWshiAfoyGx/yfalgSmAXf+z/64Tkqlm77PxSw78szj1Tye8tP6UyVa
	 Fr27ShKjkVUdbzg/QkDiJhn0bfyzaGTagdKGCs3bBp+LZydPPUHJJ5Zcxi/v/T5EDy
	 hzfqGBHBY1xZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 20E57E4CC11;
	Mon, 23 Oct 2023 23:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] Intel Wired LAN Driver Updates 2023-10-19
 (idpf)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169810202413.28561.2401722984753174397.git-patchwork-notify@kernel.org>
Date: Mon, 23 Oct 2023 23:00:24 +0000
References: <20231023202655.173369-1-jacob.e.keller@intel.com>
In-Reply-To: <20231023202655.173369-1-jacob.e.keller@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Oct 2023 13:26:53 -0700 you wrote:
> This series contains two fixes for the recently merged idpf driver.
> 
> Michal adds missing logic for programming the scheduling mode of completion
> queues.
> 
> Pavan fixes a call trace caused by the mailbox work item not being canceled
> properly if an error occurred during initialization.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] idpf: set scheduling mode for completion queue
    https://git.kernel.org/netdev/net-next/c/d38b4d0d95bc
  - [net-next,v2,2/2] idpf: cancel mailbox work in error path
    https://git.kernel.org/netdev/net-next/c/46d913d4800e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



