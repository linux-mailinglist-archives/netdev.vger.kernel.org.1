Return-Path: <netdev+bounces-59481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C6E81AFE4
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 09:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E27F31C214A1
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 08:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB5B156D6;
	Thu, 21 Dec 2023 08:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtqoPMtp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615EF156C9
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 08:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24152C433C9;
	Thu, 21 Dec 2023 08:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703145625;
	bh=p2D80JXClIHDEIQ/FRcSR3jDDS3D68gz8KZab8tO57c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YtqoPMtpJHqUMd+cw/icIho/Xjlzv4JR8pHkdwmmZdpHegTDQd5lzwwuFr+iwsvp2
	 h2Q1LlqIvg2hKU0ROvXcwXx8rviXKbCmVh5vzAxarvUlmNdvMNz+7qVMQOM2R9+Oky
	 AHsOI/8TJOwrQQ0gefLqePWiZuM29lwnlr37zEmpJmGpUIxE6tZv36egGhyu18k4Y7
	 BhfOvmRwVAwoXiTbCMRJCg1Gkrhy8f3R/sZedrYkmgTVhwhPCg1SPXghsNF3AjYkin
	 sMrmuJC2CBkAUEQesCIl+Ikc2YPchHWsJm1DECdxnzlluLUJ5KEcr2Z7STTbt60e01
	 usBirLUsd0zKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0DC40DD4EE4;
	Thu, 21 Dec 2023 08:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates
 2023-12-18 (ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170314562505.17553.12535124144795616968.git-patchwork-notify@kernel.org>
Date: Thu, 21 Dec 2023 08:00:25 +0000
References: <20231218192708.3397702-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20231218192708.3397702-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon, 18 Dec 2023 11:27:03 -0800 you wrote:
> This series contains updates to ice driver only.
> 
> Jakes stops clearing of needed aggregator information.
> 
> Dave adds a check for LAG device support before initializing the
> associated event handler.
> 
> [...]

Here is the summary with links:
  - [net,1/3] ice: stop trashing VF VSI aggregator node ID information
    https://git.kernel.org/netdev/net/c/7d881346121a
  - [net,2/3] ice: alter feature support check for SRIOV and LAG
    https://git.kernel.org/netdev/net/c/4d50fcdc2476
  - [net,3/3] ice: Fix PF with enabled XDP going no-carrier after reset
    https://git.kernel.org/netdev/net/c/f5728a418945

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



