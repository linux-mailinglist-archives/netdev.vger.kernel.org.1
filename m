Return-Path: <netdev+bounces-209697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F224B106B5
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 11:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B4616C8F4
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 09:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E346823F26A;
	Thu, 24 Jul 2025 09:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/uJ8ckJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B1623D2B5;
	Thu, 24 Jul 2025 09:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349998; cv=none; b=bFfArpNlDi/tUboLxmqAuuYIt6r/8xcBC1AcmkkRX4qxEUPKPf7DfbkRQY6vV9xLr8IrhirQCGl8zcm+MWDw5/Df+aqnbpguDIqkamY3aFJVyVH2YLv7jmxigV1VIe5YFC5Z+I9IGWaKLGCzIcy5tfma/bP2VBco8EwbH7a8cpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349998; c=relaxed/simple;
	bh=DdTt1vE2ubYt6aPcyjM/zyAk42lfXUdk2rIxrkPKZnU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AfwAqzY88xQa8jrbCjoVYNkvYyMfIqwOGDDH+8MyZDL2LppqcfkTWKMV8a2YT96nFrM4cHkSUQLqbnn7omuV3QyrzvDeeW3FwaY1Y/OXGFscf4ZOzFsP8W6XUObTqoQGvvyISiisShF9gG0otBtS/pF9ANvTsDHSGsvMu2VAvEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/uJ8ckJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD4DC4CEED;
	Thu, 24 Jul 2025 09:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753349998;
	bh=DdTt1vE2ubYt6aPcyjM/zyAk42lfXUdk2rIxrkPKZnU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R/uJ8ckJIxhpKL46lwS5YzQsgjZpizPH4m/9dEmOYIZu2hzYLkUevcR62n1gXGZ3N
	 bl3lSGKWEZbDze9KFHyCTxuqkvmrm5uUDdy4whivtD4k+eY3F059VX5mGNFLskmzxm
	 9LF2c1U+4j9PEEUVb0vjeNrNHIqudFrN/ZY5O1vQ1ZIRpAuu9t0YEbLh2ZiQ56PWJx
	 6f5keirSQeXom/6tvMCwXPSevfA6wnXG2mgsNEz7amFGh2kKDY44TUGmEfqPOKo6gF
	 Cve+c2tsn3W9kTVsY5jYEYTQJ5z/2SEjEywGzeJ4RyuWAEo7Cpmu2BdBd3NxLIV86+
	 0inl4xT87JHlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 59D4E383BF4E;
	Thu, 24 Jul 2025 09:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 net 0/4] There are some bugfix for the HNS3 ethernet
 driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175335001625.2321527.7022068053969429212.git-patchwork-notify@kernel.org>
Date: Thu, 24 Jul 2025 09:40:16 +0000
References: <20250722125423.1270673-1-shaojijie@huawei.com>
In-Reply-To: <20250722125423.1270673-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shenjian15@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
 salil.mehta@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 22 Jul 2025 20:54:19 +0800 you wrote:
> There are some bugfix for the HNS3 ethernet driver
> 
> ---
> ChangeLog:
> v1 -> v2:
>   - Fix wrong Fixes tag, suggested by Simon Horman
>   - Replace min_t() with min(), suggested by Simon Horman
>   - Split patch4, omits the ethtool changes,
>     ethtool changes will be sent to net-next, suggested by Simon Horman
>   v1: https://lore.kernel.org/all/20250702130901.2879031-1-shaojijie@huawei.com/
> 
> [...]

Here is the summary with links:
  - [V2,net,1/4] net: hns3: fix concurrent setting vlan filter issue
    https://git.kernel.org/netdev/net/c/4555f8f8b6aa
  - [V2,net,2/4] net: hns3: disable interrupt when ptp init failed
    https://git.kernel.org/netdev/net/c/cde304655f25
  - [V2,net,3/4] net: hns3: fixed vf get max channels bug
    https://git.kernel.org/netdev/net/c/b3e75c0bcc53
  - [V2,net,4/4] net: hns3: default enable tx bounce buffer when smmu enabled
    https://git.kernel.org/netdev/net/c/49ade8630f36

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



