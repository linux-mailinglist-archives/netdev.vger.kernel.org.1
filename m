Return-Path: <netdev+bounces-12925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA02773971C
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 08:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A0B91C21024
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 06:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852D03FDD;
	Thu, 22 Jun 2023 06:00:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E023C05
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 06:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98C98C433C9;
	Thu, 22 Jun 2023 06:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687413620;
	bh=4ycCoCeRkBDkknDeFkT/nYWCaO7H6Sz2TzFIfeHuK3M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gxuptOm/nFfVaeXfI1SjIsEKs0J/oMTi9Y93dKZaPfCh2UMPi9Q339x04N+hBZyA0
	 fgmFuIIHYNC+SlJLm5D7b5+qtG7mL/+fUtfnm3fiu35kN8U1B4+1jSFvr2C69lyXQl
	 B6jZeN7LOOeOdt2xd/+wJbaTWlF+88kafrsKw2CxfE2oZl4hcJZrv5tCqhljo3ylME
	 DIIibALaYeo+QGALwjrCS+ws/B4JoJBPZWV/TAkHoXfJa0UmTx+EIfiskxoLStghKc
	 ZbUKhDJM6nIRkHYX2aNA7wngN3Rsz8ZcHvql4mGM7gA37ffLwKkWDweQ4WikbN5lAN
	 oxCc9Z6eB6VnA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C431E2A034;
	Thu, 22 Jun 2023 06:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] wifi: mac80211: report all unusable beacon frames
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168741362050.8755.11408593794457778367.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jun 2023 06:00:20 +0000
References: <20230621120543.412920-2-johannes@sipsolutions.net>
In-Reply-To: <20230621120543.412920-2-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 benjamin.berg@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Jun 2023 14:05:44 +0200 you wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> Properly check for RX_DROP_UNUSABLE now that the new drop reason
> infrastructure is used. Without this change, the comparison will always
> be false as a more specific reason is given in the lower bits of result.
> 
> Fixes: baa951a1c177 ("mac80211: use the new drop reasons infrastructure")
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> 
> [...]

Here is the summary with links:
  - [net] wifi: mac80211: report all unusable beacon frames
    https://git.kernel.org/netdev/net/c/7f4e09700bdc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



