Return-Path: <netdev+bounces-35375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 575367A928C
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 10:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 027701F20F7E
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 08:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4DA8F52;
	Thu, 21 Sep 2023 08:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CAE8F49
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 08:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E21EDC4160E;
	Thu, 21 Sep 2023 08:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695284423;
	bh=RJTl/RMHqkEiFK/zkwmP55ffP4ZvFJtZRYisoHNybcc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cxAiP6/G0PpEeP2WShpeyZ36x8KTrgNx4euLEM/JhzLEwYbtyLMWWFobgFpvqSWpg
	 pSsVPuS51WeaeQ8vGZfpaz2f3y+XETKRc0aMLakzZyEa1JuzYpwfG3eMJBlGFKA3vA
	 xpgpWqKaQMEFVelHnywMmd4HLjKcirkO43TuKQQ0OQCcft/OdM9U3fb5LsJrAk4/Wn
	 gWTjpFtMruCzT5yiFxvYXZ01PdATo4LID9Op6rzTS4cltwO8A1O1f9u5PcvBBl8i44
	 Uf43TWiAY4UaugUL+HSfVw+wlMwqzfnRWVUraK04hXalhd6xpM/iWQfVdnarsrBydE
	 ShnKnZzDZTVNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7FC1C41671;
	Thu, 21 Sep 2023 08:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] igc: Expose tx-usecs coalesce setting to user
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169528442281.5165.1476264155263100532.git-patchwork-notify@kernel.org>
Date: Thu, 21 Sep 2023 08:20:22 +0000
References: <20230919170331.1581031-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230919170331.1581031-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org,
 muhammad.husaini.zulkifli@intel.com, sasha.neftin@intel.com,
 vinicius.gomes@intel.com, horms@kernel.org, bcreeley@amd.com,
 naamax.meir@linux.intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 19 Sep 2023 10:03:31 -0700 you wrote:
> From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> 
> When users attempt to obtain the coalesce setting using the
> ethtool command, current code always returns 0 for tx-usecs.
> This is because I225/6 always uses a queue pair setting, hence
> tx_coalesce_usecs does not return a value during the
> igc_ethtool_get_coalesce() callback process. The pair queue
> condition checking in igc_ethtool_get_coalesce() is removed by
> this patch so that the user gets information of the value of tx-usecs.
> 
> [...]

Here is the summary with links:
  - [net,v4] igc: Expose tx-usecs coalesce setting to user
    https://git.kernel.org/netdev/net/c/1703b2e0de65

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



