Return-Path: <netdev+bounces-35150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C027A7568
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 10:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF2881C209AE
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 08:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C327ED30B;
	Wed, 20 Sep 2023 08:10:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBC7C8E3
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 08:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74D43C433C7;
	Wed, 20 Sep 2023 08:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695197422;
	bh=ZvJSHPgwxEeIJ0N4CahnZwA/cwF02dK3QxgnqygSUWo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LTbvZf5mEc1vSW8RZnEmh8It6eYTvPY0V2V+c6r7GQwGQvUJSM1T0vzYZ926QhyDv
	 oIU9VtXZkJ1edrHgqtqCfeWlMT+hLGI/gR5x7xEnW/65jgxnd4BXP9j7incrn/Vn3K
	 lAF2PRrDm9GyZx7JCQ53as7FX39mZe9p0Dis0aK4Xj8AcNLQy8d4aY5LDr3ZNqA0CD
	 ofB4fBdH58b07OsX6RuQoy1oaf9BrJoe64uYDre8eJNCGDoH3WOeDLw8szYGy6spwf
	 rTPDuutPmFwKHX49hgVIUiQs0RUNtKAArINlBVBZ1oAwAd7eIgtJp6cTIOmbzzqNF2
	 nmTbooKo9ufbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5A7AEC41671;
	Wed, 20 Sep 2023 08:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vxlan: Add missing entries to vxlan_get_size()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169519742236.8735.10821506861511564714.git-patchwork-notify@kernel.org>
Date: Wed, 20 Sep 2023 08:10:22 +0000
References: <20230918154015.80722-1-bpoirier@nvidia.com>
In-Reply-To: <20230918154015.80722-1-bpoirier@nvidia.com>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, idosch@nvidia.com, razor@blackwall.org,
 horms@kernel.org, jbenc@redhat.com, gavinl@nvidia.com, liuhangbin@gmail.com,
 vladimir@nikishkin.pw, lizetao1@huawei.com, tgraf@suug.ch,
 therbert@google.com, roopa@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 18 Sep 2023 11:40:15 -0400 you wrote:
> There are some attributes added by vxlan_fill_info() which are not
> accounted for in vxlan_get_size(). Add them.
> 
> I didn't find a way to trigger an actual problem from this miscalculation
> since there is usually extra space in netlink size calculations like
> if_nlmsg_size(); but maybe I just didn't search long enough.
> 
> [...]

Here is the summary with links:
  - [net] vxlan: Add missing entries to vxlan_get_size()
    https://git.kernel.org/netdev/net/c/4e4b1798cc90

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



