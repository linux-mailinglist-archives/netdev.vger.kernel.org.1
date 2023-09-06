Return-Path: <netdev+bounces-32179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4453C7934CD
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 07:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00ED0281212
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 05:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21029809;
	Wed,  6 Sep 2023 05:20:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C2F653
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 05:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7275C433C8;
	Wed,  6 Sep 2023 05:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693977622;
	bh=p90tZ2sPqK5OQT5Ny/mdHHYWJuQJQeVb5LPNbCFAQsU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OH2OOI+lJ+SZfpOoy/4Vr9WpD6levT7nlTr3JVyO6MqCLSkhhLILUcoakrUg30H4Y
	 rXiwanrFdh4f0I1hjFlgmjZh7XkOuS94p4ycHKti1bShYU2B3YoaU5bh7OWKE71n4D
	 /eOeAphBtaa2Q6Tn69Tx7qtNCIqstOR/deIZr2ui72We6MB/RGiyOdF2a1pvChfq0/
	 Vn3Wr6UalVU10ehuH2VfcYgyp9qLJPuBqh1LLoFWeQNLBXrLu3W+hzIM35eKOkpErr
	 Ps1F21RxJh7aD2A0a3U+1GcusaJNhPMxswGx/D2T2s1vrPlNjt1DrLpsu5fBrMw7xB
	 15SEuJ0qaTANw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 91A6DC04D3F;
	Wed,  6 Sep 2023 05:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] net/mlx5e: Clear mirred devices array if the rule is
 split
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169397762259.26821.10788455717619544046.git-patchwork-notify@kernel.org>
Date: Wed, 06 Sep 2023 05:20:22 +0000
References: <20230905174846.24124-1-saeed@kernel.org>
In-Reply-To: <20230905174846.24124-1-saeed@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, saeedm@nvidia.com, netdev@vger.kernel.org,
 tariqt@nvidia.com, jianbol@nvidia.com, vladbu@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  5 Sep 2023 10:48:45 -0700 you wrote:
> From: Jianbo Liu <jianbol@nvidia.com>
> 
> In the cited commit, the mirred devices are recorded and checked while
> parsing the actions. In order to avoid system crash, the duplicate
> action in a single rule is not allowed.
> 
> But the rule is actually break down into several FTEs in different
> tables, for either mirroring, or the specified types of actions which
> use post action infrastructure.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net/mlx5e: Clear mirred devices array if the rule is split
    https://git.kernel.org/netdev/net/c/b7558a77529f
  - [net,2/2] mlx5/core: E-Switch, Create ACL FT for eswitch manager in switchdev mode
    https://git.kernel.org/netdev/net/c/344134609a56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



