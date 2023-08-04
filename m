Return-Path: <netdev+bounces-24312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3133F76FC0A
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 10:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1EFC1C20F0B
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 08:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271899463;
	Fri,  4 Aug 2023 08:30:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AB39464
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 08:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62D3AC433C9;
	Fri,  4 Aug 2023 08:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691137820;
	bh=ZuO9HVGRybIlT2EUA3I61TFh/DYqBZHDqa00B+xYMSA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nqIyjTftpYNUjdiw+qGUgpJ62j89KSLYH3cx594x1R33nN+j89j31FmVNFmTDNgxY
	 rLrR9bf5lOSq+BuFOe7wvkxKtt/jF80jzkJgDN7YGQk7YouCdeyijE6/skIh/vbZBW
	 Sdm4p3ch0TQsBTDaZBbMrf2zNck2hHmcwYOeUwVGBNeFssS1GiZ25QlP0hrrB2NXXo
	 kxYT0uf4WZhi1zeWS0uhTTgdjuEW+vYOxBnValoEyGvMA6bfRe51w/RX/j1DtoWkYU
	 9Jy6t7Lms+rTrTCYRmB0MTSZFAzlXPW0uvlDg+oGDcn6uXvPkdS6C8+2oH3EUwj06/
	 4favYHYziJopQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43F4CC595C3;
	Fri,  4 Aug 2023 08:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp/dccp: cache line align inet_hashinfo
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169113782026.32170.17783946876020996348.git-patchwork-notify@kernel.org>
Date: Fri, 04 Aug 2023 08:30:20 +0000
References: <20230803075334.2321561-1-edumazet@google.com>
In-Reply-To: <20230803075334.2321561-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  3 Aug 2023 07:53:34 +0000 you wrote:
> I have seen tcp_hashinfo starting at a non optimal location,
> forcing input handlers to pull two cache lines instead of one,
> and sharing a cache line that was dirtied more than necessary:
> 
> ffffffff83680600 b tcp_orphan_timer
> ffffffff83680628 b tcp_orphan_cache
> ffffffff8368062c b tcp_enable_tx_delay.__tcp_tx_delay_enabled
> ffffffff83680630 B tcp_hashinfo
> ffffffff83680680 b tcp_cong_list_lock
> 
> [...]

Here is the summary with links:
  - [net-next] tcp/dccp: cache line align inet_hashinfo
    https://git.kernel.org/netdev/net-next/c/6f5ca184cbef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



