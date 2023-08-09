Return-Path: <netdev+bounces-26089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08475776C5D
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 00:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 397491C21334
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 22:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FE91DDFC;
	Wed,  9 Aug 2023 22:40:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EC119BC6
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 22:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0AA64C433CD;
	Wed,  9 Aug 2023 22:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691620823;
	bh=B/cyYsQzohvyJ0YTPXPPqOQbFMRLZx7J4pHhEG9e7jw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=feSqhYZyKYMqXGpbmi4xWiP+hJj5kVkoHfBxdudmvxOsqXFt+gayjldn8jdwlT+lb
	 XplYvGVAOBLKCDGCcvLqTEjeIANV+7QIgDwzPdUFw8yAl8Jfwok0+bnkq7YcJAWSxB
	 9rr+TxBoMdJfP3LhpZvsPlmnM0ebNpDN/ElLQzpYBsg4Nehkecl8plflH/j+eHFIJP
	 gJY67S2lMdOGTO1C/pUWwBHpX3aYNufmnamwfgkI/3yqwl4wpYs/WqBFfu7TCcjJHc
	 Ka6UWHadWHLKuAPG0uE8veJ01FUYdyiyg13DjV4Jsj9gbn+HtYDozBWOhpFBJkUPf/
	 fiEAgRf8yPoRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E702FE33093;
	Wed,  9 Aug 2023 22:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] mlxsw: Set port STP state on bridge enslavement
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169162082294.25117.14111987532097257605.git-patchwork-notify@kernel.org>
Date: Wed, 09 Aug 2023 22:40:22 +0000
References: <cover.1691498735.git.petrm@nvidia.com>
In-Reply-To: <cover.1691498735.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
 danieller@nvidia.com, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 8 Aug 2023 15:18:14 +0200 you wrote:
> When the first port joins a LAG that already has a bridge upper, an
> instance of struct mlxsw_sp_bridge_port is created for the LAG to keep
> track of it as a bridge port. The bridge_port's STP state is initialized to
> BR_STATE_DISABLED. This made sense previously, because mlxsw would only
> ever allow a port to join a LAG if the LAG had no uppers. Thus if a
> bridge_port was instantiated, it must have been because the LAG as such is
> joining a bridge, and the STP state is correspondingly disabled.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] mlxsw: Set port STP state on bridge enslavement
    https://git.kernel.org/netdev/net-next/c/a76ca8afd45a
  - [net-next,2/2] selftests: mlxsw: router_bridge_lag: Add a new selftest
    https://git.kernel.org/netdev/net-next/c/aae5bb8d18d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



