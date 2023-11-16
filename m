Return-Path: <netdev+bounces-48275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB877EDE78
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 11:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F8DA1F23409
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 10:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8792CCDF;
	Thu, 16 Nov 2023 10:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dh/lGsOq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C82F2CCD6
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 10:29:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5ECEC433CA;
	Thu, 16 Nov 2023 10:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700130572;
	bh=nInPDQtYXvploIdFPg+yMpXjAFkyvy948yKT55Yfs0k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Dh/lGsOqekXZXqX7wLtfz6+cAvdV4t48jZ8Exlmu52X0hj7rGsvdEFPybJS9Ptn7r
	 Nhe3SBwiyLrAgAeki4OQjXWqH3J9gLBFXAYtbj5nUWT9ooO4TD9ttRfieY9716zEkT
	 wzeQIiraT/5ojz+NlbRmAEVYFxqrcdhiTmxCLLbSxW5D69kKS6COeZXs/fGwU/uHVv
	 iFY9hflXHxsSp60LJdQKvpWEdAG4fMbDsds22ng/m/21HQdcalXzo1PXQZpTgNC/O1
	 +UedB+McsCZthF+juFXJACnfp2omgLgka0nwkR0IqV5g/HD3kuKddNl/4rHCfXV+vQ
	 y+jIX6vFQeKTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AA516E1F66E;
	Thu, 16 Nov 2023 10:29:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] macvlan: Don't propagate promisc change to lower dev in
 passthru
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170013057269.29188.2450503732365574616.git-patchwork-notify@kernel.org>
Date: Thu, 16 Nov 2023 10:29:32 +0000
References: <20231114175915.1649154-1-vladbu@nvidia.com>
In-Reply-To: <20231114175915.1649154-1-vladbu@nvidia.com>
To: Vlad Buslov <vladbu@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, vyasevic@redhat.com,
 gal@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 14 Nov 2023 18:59:15 +0100 you wrote:
> Macvlan device in passthru mode sets its lower device promiscuous mode
> according to its MACVLAN_FLAG_NOPROMISC flag instead of synchronizing it to
> its own promiscuity setting. However, macvlan_change_rx_flags() function
> doesn't check the mode before propagating such changes to the lower device
> which can cause net_device->promiscuity counter overflow as illustrated by
> reproduction example [0] and resulting dmesg log [1]. Fix the issue by
> first verifying the mode in macvlan_change_rx_flags() function before
> propagating promiscuous mode change to the lower device.
> 
> [...]

Here is the summary with links:
  - [net] macvlan: Don't propagate promisc change to lower dev in passthru
    https://git.kernel.org/netdev/net/c/7e1caeace041

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



