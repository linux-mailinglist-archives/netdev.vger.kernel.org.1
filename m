Return-Path: <netdev+bounces-32293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F8A793F78
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 16:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99EF31C20B37
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 14:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DE3101F0;
	Wed,  6 Sep 2023 14:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D74D1C36
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 14:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7FBB1C433C9;
	Wed,  6 Sep 2023 14:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694011822;
	bh=CGy1382AfqLvSqyJQoLCmItLRUvcKofG/9PtT5Y67LI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Axd19umcl82FPsKy/DPQkYAdyJD2QQcHa/8FurP7FxwPN7V97S/5Uucnfyx8vquVH
	 vvlDG45vKqTG1qxjwSHqXx+QYvrZUpcLsk1vH65Ijkx3HbRjD/7qoRrEyhtRffBi+G
	 qGSQ9UHtqrhnDKAjDxyOGtdvQtdpJvsMCqqypkHiGTeuj2Xfdq7FbKQgRvoCjeo2m2
	 P7lEFR50n2RkIAR4aHpDTak6cizFMBmX0fx7DUPA1+SXpnK5osL9TtrwtpdjDqF71X
	 hr3+6mVsQUH1/3XtmfDaSSmHyv3d9eluKr7w8NVmGoqLBMH2pmYfddMzDks/W64RHw
	 oiOPNYGe3KV2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67F91C0C3FD;
	Wed,  6 Sep 2023 14:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] iplink_bridge: fix incorrect root id dump
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169401182242.17957.5637462326730824348.git-patchwork-notify@kernel.org>
Date: Wed, 06 Sep 2023 14:50:22 +0000
References: <20230901080226.424931-1-liuhangbin@gmail.com>
In-Reply-To: <20230901080226.424931-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, stephen@networkplumber.org,
 razor@blackwall.org, idosch@nvidia.com

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Fri,  1 Sep 2023 16:02:26 +0800 you wrote:
> Fix the typo when dump root_id.
> 
> Fixes: 70dfb0b8836d ("iplink: bridge: export bridge_id and designated_root")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  ip/iplink_bridge.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [iproute2] iplink_bridge: fix incorrect root id dump
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=3181d4e14964

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



