Return-Path: <netdev+bounces-35209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D209E7A79EC
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 13:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E59DB1C20A39
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 11:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E44318639;
	Wed, 20 Sep 2023 11:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7D216436
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 11:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E498FC433CD;
	Wed, 20 Sep 2023 11:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695207623;
	bh=rPiOUM5aaPiWdfVsIO/cyE3yqhenjHG0uI9o5H+GhkU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c4uykEEPwEbr8zdbbSliJKEUBvRYSJjrN5AghndhxVSToOBFQbQXaXWS/acoVkMh0
	 1dGt0z+PYTgMdyaAFwh1eoyXuLRgoYxThzE7aGUJW66AXvMczPNaiIkaRgT+Ww0Thu
	 PwyQr0UbEgfGcJbdz0xOw8WjRQq/EtkoDDOiaaBuuwxGduEmHByahc12iHhz+/tZRx
	 Zd6Ng/kWGjsx7G0SxGY2LZJFNMCF0SDfZivVx/0wls4ctLTwGQclXzsNtkJLz6tO0n
	 kgb7lBM+ZE7UjMXEo89/L+EsZqO6ychFHcQdGSMhcJxTPNzGo60joUiXY3hvPhEomB
	 5FsAlUa2dTfuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CFDF7C41671;
	Wed, 20 Sep 2023 11:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] wifi: cfg80211: make read-only array centers_80mhz
 static const
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169520762384.31903.1385774049535484165.git-patchwork-notify@kernel.org>
Date: Wed, 20 Sep 2023 11:00:23 +0000
References: <20230919095205.24949-1-colin.i.king@gmail.com>
In-Reply-To: <20230919095205.24949-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 19 Sep 2023 10:52:05 +0100 you wrote:
> Don't populate the read-only array lanes on the stack, instead make
> it static const.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  net/mac80211/tdls.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [next] wifi: cfg80211: make read-only array centers_80mhz static const
    https://git.kernel.org/netdev/net-next/c/6c0da8406382

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



