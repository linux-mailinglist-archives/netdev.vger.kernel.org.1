Return-Path: <netdev+bounces-50562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B018F7F61AE
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 15:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA24B1C21175
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 14:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA1D328AA;
	Thu, 23 Nov 2023 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfGrEEVU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198AE22F18
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 14:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A264BC433CB;
	Thu, 23 Nov 2023 14:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700750423;
	bh=YrbY05YNali4M5f7lssX17IgNafhryvBWwzJUJOdaco=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dfGrEEVUVyD8JW5oWh7zdQB4/cmUuMYFHA/XzMF6vmUVdSWz7Gh7/jg5O37h1UuNE
	 v5+Ga+AHLrT1oFk8mSp9+Uu7BOf6Qbb2rcOY78TIdCi6kNSjjGj/mmBrk8TUnRk2Qm
	 GLB89lsReQYu6IiY4qdeDeeWfkJAiQPow3/Jpg1BgwImXXroWfkmVgr5qHZh8qR5My
	 ZcaQbFTgrYDKbKRHiBndaNvjNHPge52e4QxJ1Fk4EQZiDXAZ5Fcu0Tmhu24knBcp6k
	 cpLYG7xnr5zrUTGgm5wAdC/DTJRbzK49gCe91OMOjNwoetwFU2c1lHv/oOeozgfFeA
	 e8dthD4zlukWA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F346C395FD;
	Thu, 23 Nov 2023 14:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3][pull request] ice: restore timestamp config after
 reset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170075042358.20154.16666948035549208193.git-patchwork-notify@kernel.org>
Date: Thu, 23 Nov 2023 14:40:23 +0000
References: <20231121211259.3348630-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20231121211259.3348630-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, jacob.e.keller@intel.com,
 richardcochran@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 21 Nov 2023 13:12:54 -0800 you wrote:
> Jake Keller says:
> 
> We recently discovered during internal validation that the ice driver has
> not been properly restoring Tx timestamp configuration after a device reset,
> which resulted in application failures after a device reset.
> 
> After some digging, it turned out this problem is two-fold. Since the
> introduction of the PTP support the driver has been clobbering the storage
> of the current timestamp configuration during reset. Thus after a reset, the
> driver will no longer perform Tx or Rx timestamps, and will report
> timestamp configuration as disabled if SIOCGHWTSTAMP ioctl is issued.
> 
> [...]

Here is the summary with links:
  - [net,1/3] ice: remove ptp_tx ring parameter flag
    https://git.kernel.org/netdev/net/c/0ffb08b1a45b
  - [net,2/3] ice: unify logic for programming PFINT_TSYN_MSK
    https://git.kernel.org/netdev/net/c/7d606a1e2d05
  - [net,3/3] ice: restore timestamp configuration after device reset
    https://git.kernel.org/netdev/net/c/7758017911a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



