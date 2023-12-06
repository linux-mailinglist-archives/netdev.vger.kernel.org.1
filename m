Return-Path: <netdev+bounces-54274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2AE806668
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 06:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D06CE1C210DB
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 05:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B4ED2F3;
	Wed,  6 Dec 2023 05:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeqcX6O2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498F62105
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 05:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D01F8C433CA;
	Wed,  6 Dec 2023 05:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701838828;
	bh=DjvNZR+2ZuPvRriM6CWd1/KpPSQ6xuNN+0AOSIQYdTA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AeqcX6O2GGND+NOngfkNXdYuqDYMkhs+sZ2/1mYFGXgfSBEEzf9TsJbYekwjql8N+
	 SWH/RNkSIeEZVz7nEdatfQUYdUC7DztnrcMMgtfXj7ia8o511zEip+tu/+Wtl0PXnY
	 ICk0vR8PViwxOPp+tdSt279vt2qp2GdT1u1ok3Xaue3WmzUat+Dq9EpYIlwe6InL6s
	 kkaryG8m3/UC+5g9jRkEBSwl93a6k9yQ6iEeO2E6RrOgGjwWh+IfruD2w/YSOWqeQg
	 Sl6VAfGcoBkfrmhOG4kgZVU2KJXEezBKcmApwwld3pHvihs1cVSRWKRuGsLtJTTFyF
	 v9yWqHX07cLUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3367C395F1;
	Wed,  6 Dec 2023 05:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: core: synchronize link-watch when carrier is queried
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170183882873.31476.13099879725465635985.git-patchwork-notify@kernel.org>
Date: Wed, 06 Dec 2023 05:00:28 +0000
References: <20231204214706.303c62768415.I1caedccae72ee5a45c9085c5eb49c145ce1c0dd5@changeid>
In-Reply-To: <20231204214706.303c62768415.I1caedccae72ee5a45c9085c5eb49c145ce1c0dd5@changeid>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, johannes.berg@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  4 Dec 2023 21:47:07 +0100 you wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> There are multiple ways to query for the carrier state: through
> rtnetlink, sysfs, and (possibly) ethtool. Synchronize linkwatch
> work before these operations so that we don't have a situation
> where userspace queries the carrier state between the driver's
> carrier off->on transition and linkwatch running and expects it
> to work, when really (at least) TX cannot work until linkwatch
> has run.
> 
> [...]

Here is the summary with links:
  - [net] net: core: synchronize link-watch when carrier is queried
    https://git.kernel.org/netdev/net-next/c/facd15dfd691

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



