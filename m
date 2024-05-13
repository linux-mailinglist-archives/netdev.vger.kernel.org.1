Return-Path: <netdev+bounces-96184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6158C49BE
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 00:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815D61F216BA
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 22:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59FB84FC3;
	Mon, 13 May 2024 22:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcKnbC1o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0D284E17;
	Mon, 13 May 2024 22:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715640629; cv=none; b=WnPv8pEGi8BhqAkTyuLbY9dYvo4s///2aQlqNxDtSs5IHjucg32x/7XyNPIWQEEPaE5U0H7ncunG9VjQQYqFY3hliBABZvS5NlO/vseW6p9GUm45cSxDrnw/psIL2aT0EpNR9WJYa8wfVZc9x9qhjzWf5zA7jbNUIMkLr09Uh7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715640629; c=relaxed/simple;
	bh=A8F0aLeTOkEVQsYb3Ruds4GUVKytrjaVyrUlAwe2LYQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rxvVf4X5JlcmcPHGHjckESlLKaxNUGBKe4+yzLmETFqfOpiwnMDkQcYJGgd/p6rpmtC9jXtcmKr/TedhajLOQm3YqESVISG5hU3xY91QwrUbDEEK+jrxasS79U2k0Yn0IDT/aGuHVYW77BtRXUVcioZ057LMRiWTEKk3en9zz20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcKnbC1o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10046C4AF0D;
	Mon, 13 May 2024 22:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715640629;
	bh=A8F0aLeTOkEVQsYb3Ruds4GUVKytrjaVyrUlAwe2LYQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hcKnbC1oCTRS2Y5rent0/h2FqHJE+HTwqroLF1381GE/8OmZHPDIUWJ3EbACtXb5K
	 EIooOm5YfEnH/X8+wZ//tvX5B/uspm4GHp4Dq08dJykKzpFPD2kZHoE6Mu46RCNlOX
	 BK4ge80PuM0z+QfXjAi9Yp7LuzLtmmTlEEfC4UrN20WqS/a4chOWzHBWsEBvc2OS2M
	 DRAGXBc1N5taW7gZ4OgkOd+yShak9IKinDF138Pq9PNvPvAAn8UKYAPdrGc5Q7EGjG
	 Wkn4biUuXc2QE3TVunNNOu2h0YjoFhTjSSbqZgXpKUU+FxTcs0CPW2hMiAqpLYyalE
	 DLBnYNzsXIF1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC85FC433F2;
	Mon, 13 May 2024 22:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] Add TX stop/wake counters
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171564062896.28873.12862899277990003394.git-patchwork-notify@kernel.org>
Date: Mon, 13 May 2024 22:50:28 +0000
References: <20240510201927.1821109-1-danielj@nvidia.com>
In-Reply-To: <20240510201927.1821109-1-danielj@nvidia.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jiri@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 10 May 2024 23:19:25 +0300 you wrote:
> Several drivers provide TX stop and wake counters via ethtool stats. Add
> those to the netdev queue stats, and use them in virtio_net.
> 
> v2:
> 	- Fixed an accidental line deletion
> 	- Enhanced documentation
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] netdev: Add queue stats for TX stop and wake
    https://git.kernel.org/netdev/net-next/c/b56035101e1c
  - [net-next,v2,2/2] virtio_net: Add TX stopped and wake counters
    https://git.kernel.org/netdev/net-next/c/c39add9b2423

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



