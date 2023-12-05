Return-Path: <netdev+bounces-53888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 624A5805164
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 12:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9DFDB209A4
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 11:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA444AF9F;
	Tue,  5 Dec 2023 11:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/DfqLbp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50914D51D
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 11:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5D0EC433C9;
	Tue,  5 Dec 2023 11:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701774029;
	bh=Yae2YG26FmkDOyx3uGMCihOM19ZqkXefY/uci5OkbJQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R/DfqLbpq4JuFz8Ovq9y3GrGFLPkXYDnzFuH10enqM2b9a2p3zkwTs85HbbAJwD3l
	 0NagWjDsw5rB/ZTIL6mEGAR3qIWnIgIndk99akJgiAzDg/CdXcVfoyishHkIwEGeiE
	 jl1D0zE/2jrHoGjMQVtaKMs+oXEq9Txj7mZNXixOJKMQXu8jx3+ZXqDwN5c+fJNr5v
	 yW/2YAZCgPzZwhedCScWJnWD+XH5yAqFYRs34RU+QWepwg+y5hruToZBWZ2Ywzhi0g
	 fzbTAVv6Mno3hgeBWeAtvfINoeR417mtzPPfgkFRB+WTxz+zQ9GRjCizPKFryBUFfT
	 gbCbxYpNrpTZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 972CCC43170;
	Tue,  5 Dec 2023 11:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6][pull request] Intel Wired LAN Driver Updates
 2023-12-01 (ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170177402960.1168.10894503666411721087.git-patchwork-notify@kernel.org>
Date: Tue, 05 Dec 2023 11:00:29 +0000
References: <20231201180845.219494-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20231201180845.219494-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  1 Dec 2023 10:08:38 -0800 you wrote:
> This series contains updates to ice driver only.
> 
> Konrad provides temperature reporting via hwmon.
> 
> Arkadiusz adds reporting of Clock Generation Unit (CGU) information via
> devlink info.
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] ice: read internal temperature sensor
    https://git.kernel.org/netdev/net-next/c/4da71a77fc3b
  - [net-next,2/6] ice: add CGU info to devlink info callback
    https://git.kernel.org/netdev/net-next/c/b86455a1cbef
  - [net-next,3/6] ice: Improve logs for max ntuple errors
    https://git.kernel.org/netdev/net-next/c/e9fd08a9a7fb
  - [net-next,4/6] ice: Re-enable timestamping correctly after reset
    https://git.kernel.org/netdev/net-next/c/1cc5b6eaad92
  - [net-next,5/6] ice: periodically kick Tx timestamp interrupt
    https://git.kernel.org/netdev/net-next/c/712e876371f8
  - [net-next,6/6] ice: Rename E822 to E82X
    https://git.kernel.org/netdev/net-next/c/a39dd252d552

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



