Return-Path: <netdev+bounces-145535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 045339CFC4F
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 03:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE4A5287CEE
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 02:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A821534E9;
	Sat, 16 Nov 2024 02:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdRgKBh3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A78017D2;
	Sat, 16 Nov 2024 02:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731722424; cv=none; b=qRUy81MFeBMtDLPxtEkdVmVbvFfbB5eVuz2XbaBn7V3IfaUA8vYvyf0v6Ib+JGvgz/trYvkD6DBIHSc7prITyMKfGG7cBmeR+Bd+sNSetHYAoEkut0EJ6nZHCoLXiBXupuU79Y1I7qiWGcu7CnY467HV/KpL4z/WPfQi3PaO1Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731722424; c=relaxed/simple;
	bh=OuPW9y1vz8Zkedk8yyVTPNEYpYm0tCUzNbwEh2SN7eI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Nu3StXa2VNsHjTQJmEx77C7g8no09EfVKLVDq0VbqK/LnzAuPE4CFlYXaQTPVXNLAHhUbuJqw2qeZugM5TwiKnFJAbmDPGGxDjLngUFmxSpFbrwArPPzuiUfBNhNC7qCtHkgMK3t0bKHKmSxDbWii2pUfm7AkOLsuhGGuoMbLMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdRgKBh3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA894C4CECF;
	Sat, 16 Nov 2024 02:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731722423;
	bh=OuPW9y1vz8Zkedk8yyVTPNEYpYm0tCUzNbwEh2SN7eI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bdRgKBh3tJByYZ8URdBvbYm0hyHEI+F/IBoFtenRyZew2MwdKlnLbW+P7IwlxfLCd
	 uDY50MZfePYior1/HwjgO7pA8subepCwVz3RYeMeXTjcHOlHok6udmXNTorSXSwimP
	 Z+a5S2Z2ix4qETvhJwvVuzAXvqXhAmUpxfKm7DIArNdgQuUOk01cxYNEbcxZp/gLVL
	 hgIitSsdcPNjrA1MzrCydiPMzYzsNvg1hCbxpV+0Cu5jaENHFG4icWCauVzi6BQdlz
	 tiTHcvJ6y5pVZaqNayfKS0zT4hWKRQX6jlvQmfprqIY5xUpvflWKo7oOOvQAzK9pKf
	 vkRW9PikwlB0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADFB3809A80;
	Sat, 16 Nov 2024 02:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] net: netpoll: Improve SKB pool management
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173172243450.2797219.17824032740789385081.git-patchwork-notify@kernel.org>
Date: Sat, 16 Nov 2024 02:00:34 +0000
References: <20241114-skb_buffers_v2-v3-0-9be9f52a8b69@debian.org>
In-Reply-To: <20241114-skb_buffers_v2-v3-0-9be9f52a8b69@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, max@kutsevol.com, davej@codemonkey.org.uk,
 vlad.wing@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 Nov 2024 03:00:10 -0800 you wrote:
> The netpoll subsystem pre-allocates 32 SKBs in a pool for emergency use
> during out-of-memory conditions. However, the current implementation has
> several inefficiencies:
> 
>  * The SKB pool, once allocated, is never freed:
> 	 * Resources remain allocated even after netpoll users are removed
> 	 * Failed initialization can leave pool populated forever
>  * The global pool design makes resource tracking difficult
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] net: netpoll: Individualize the skb pool
    https://git.kernel.org/netdev/net-next/c/221a9c1df790
  - [net-next,v3,2/2] net: netpoll: flush skb pool during cleanup
    https://git.kernel.org/netdev/net-next/c/6c59f16f1770

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



