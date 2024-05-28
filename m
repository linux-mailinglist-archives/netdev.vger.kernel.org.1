Return-Path: <netdev+bounces-98353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C48CE8D10B1
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 02:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A8B1F214A4
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 00:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D810469D3C;
	Tue, 28 May 2024 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIMxX+II"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BB4241E7
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716854430; cv=none; b=Vjii/mNBkqnO+gA0429JjUijzvz2ymcJtCHxjHikYdeFrDv9mn2Z+9szpo4THyB5kSSylSiGDTTy4AAQq1vjd75qBBe3C72sIjrRe0Pfjxew0jPywF+Nh/6JxDng8aE3OqnhsR99wf7zYf/y1bszxcBBd3FI1XZANFCaXrevkU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716854430; c=relaxed/simple;
	bh=IAvWfiSqFPcgesdJhxELAyPN/0foPlQlVdIBV+ZpLCo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gLgUZOr+dWZJgnEJznXhr1DWBGcTPtnZOuDdZJPPHKhfbt63/Ayz/rQzBPyIl8kp1S8XUwXbKgHBOoGOU+ozBh7Xkl4xwQxmuEb3IFguyKEkRyMC0Mp4u6jAvb/4ts0JBhupWgYs2FAyu+F27o9o6nB/DPE4YjwdX6Zfslt2TAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIMxX+II; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62347C4AF0E;
	Tue, 28 May 2024 00:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716854430;
	bh=IAvWfiSqFPcgesdJhxELAyPN/0foPlQlVdIBV+ZpLCo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LIMxX+II10jsaZDCTkKLNri6tO/ncBPubJxyrNoWqYLf/PRXyr/LUkjlwmZBrVUMe
	 IxkDmw1QYSP6VWSWnEklgL6EgOnIpvrq20XIt6EnXO70PtBD3GPA4ZdT8M2Wc3NlLX
	 CP8eqX3plZwjdbqUs6kOyW38wz1aY0I1WD+Hofe+DZKyN07Y2nVJswSxvAbe+8VAie
	 ImHJa44fToYD+3mZQv6CPw3hmisBXgIME113nHNXwrtKUzvkQ6RhY4fep00uSv9LqU
	 eU6iDTdIhhfBKQtkR2NPkPEP1uWmNMXebvYfCet6Vnt8Ceb2qvUjwOiFiKjdnRKftQ
	 6A7X3ymcW1Xlw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5371BD40198;
	Tue, 28 May 2024 00:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: gro: initialize network_offset in network layer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171685443033.27081.14074667283288867520.git-patchwork-notify@kernel.org>
Date: Tue, 28 May 2024 00:00:30 +0000
References: <20240523141434.1752483-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20240523141434.1752483-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, richardbgobert@gmail.com,
 willemb@google.com, syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 May 2024 10:13:45 -0400 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Syzkaller was able to trigger
> 
>     kernel BUG at net/core/gro.c:424 !
>     RIP: 0010:gro_pull_from_frag0 net/core/gro.c:424 [inline]
>     RIP: 0010:gro_try_pull_from_frag0 net/core/gro.c:446 [inline]
>     RIP: 0010:dev_gro_receive+0x242f/0x24b0 net/core/gro.c:571
> 
> [...]

Here is the summary with links:
  - [net] net: gro: initialize network_offset in network layer
    https://git.kernel.org/netdev/net/c/be008726d0ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



