Return-Path: <netdev+bounces-195285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EF6ACF2E6
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 17:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A7081894D36
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 15:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FB918C031;
	Thu,  5 Jun 2025 15:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvJy/rz7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FECB1C878E
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749136806; cv=none; b=WxTJ2KMbLpa28uAbA3EbcPRorHs3w8VAaZhvSnTHXGD+OsM3QKvdbtZPYn3mJHPwtIHI+IRMOnuY/pKDU3l+2BOAY0VobK2LTGSc140kNmUaPOx5E9l546z9h6jKBfKrFYx+UJba7B0I3cCSwg5fAUVMBIZUNw5cS9YGiE0hDgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749136806; c=relaxed/simple;
	bh=coWGx3NJmtzuXplL5h+AOR4dkF1WJcGIi/ORs4B2m4Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TdHAAxAdrCTFy8bipy8f7ert6I1gNfVOq912c3wgwMH+Xw9kDs7NutKXW9uRaGmc9v4LraT53K00kWEx4h7XyMkOYHWuhs0uZZwAiOBX19EpMLwYPlcC51J660F3FY12rJtrQH60WVyc1vTYOxEyCGJ5agNl0u1HW8ZJipfebec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvJy/rz7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C971BC4CEE7;
	Thu,  5 Jun 2025 15:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749136805;
	bh=coWGx3NJmtzuXplL5h+AOR4dkF1WJcGIi/ORs4B2m4Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AvJy/rz7VE12FCHmtNGX8AjQKu/TvebzIv/VwhBs6IRQgD/UZ2skc3JlXQ1XvJZkv
	 u1mv2l7no2Q2vg4c+s+sj50PLNWJTwonBSI3JWMHlanlEzMd+G05Hflad+OrVe8+0s
	 oc25OsFW0OGukMaTL2QwmDMvzXU22AaLXov4eNtZ3A2mbPaKXG4OU6uOgbAq66lEt3
	 cOunNWl+UWqbeNI7GDXRAVgrycyxcs9eSk/YjBC6ko7HEW81cJ2xSEq+n1yhcFHw8n
	 HhuTLxVXJMAlPyL7Igk9lyh91eorDqwC9kXNVEg7a9pSO5yk1wDvZVNSY5jeUax6eW
	 zUwzpPlgLgfHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF1538111D8;
	Thu,  5 Jun 2025 15:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: annotate data-races around cleanup_net_task
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174913683751.3113343.1090034205354384390.git-patchwork-notify@kernel.org>
Date: Thu, 05 Jun 2025 15:20:37 +0000
References: <20250604093928.1323333-1-edumazet@google.com>
In-Reply-To: <20250604093928.1323333-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Jun 2025 09:39:28 +0000 you wrote:
> from_cleanup_net() reads cleanup_net_task locklessly.
> 
> Add READ_ONCE()/WRITE_ONCE() annotations to avoid
> a potential KCSAN warning, even if the race is harmless.
> 
> Fixes: 0734d7c3d93c ("net: expedite synchronize_net() for cleanup_net()")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net] net: annotate data-races around cleanup_net_task
    https://git.kernel.org/netdev/net/c/535caaca921c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



