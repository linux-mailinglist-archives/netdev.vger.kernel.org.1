Return-Path: <netdev+bounces-86350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E0789E6DC
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 02:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72F52283DB7
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 00:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05363389;
	Wed, 10 Apr 2024 00:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sT9rsjDi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50E9372
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 00:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712709030; cv=none; b=SWANF29Pv1pELYn7CYCKqRT8a9+0LLdzgRA5FLOS3vuB12IlcwLLqf7cAKtCUVNL5NCoIJVbA+vl6WndG9KybATiIxn8l9K/1aI4iKoyjuGDngjtJ0pYZXXIA1QA8oi/9+Hlc/D22rMHH9bMts59X/ZMrKQ4Atwdh77yn4jKS8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712709030; c=relaxed/simple;
	bh=FHZtvwxSdLB4LBXqPbuYgkPiiFMiKi6AE6VJkYj6TN0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jQuUSxySyfPoyqmROPVnbrfAUl9Wxz0rIryq/xcgZeB/mO+CLQAwvuYSzswrTu/lF6zDNtpB1p9Lzq0DVpcObcO5c4v6WLKMhU92p68BC68OlV++Oe+0LAA5y2bIfBNzrmgJ4zzERv7+kHUb2sj0zk+Hua4lLD1PWAy2xqMLQx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sT9rsjDi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78AAFC43390;
	Wed, 10 Apr 2024 00:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712709030;
	bh=FHZtvwxSdLB4LBXqPbuYgkPiiFMiKi6AE6VJkYj6TN0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sT9rsjDiPzHC91RjbyYqNgMNQW6hhylQ82kqZnSJIDSLvNQPhWvyuVF8aL+voSCdD
	 jJKN9PMjZ2OoCvODBRO6EVqhMqpogfkccfH5sGxyv0Fnoh/kV8NXEQMVtsnaydNKdP
	 jUr0bRxHsCNq/GSgIlnYloUjoV2SPwZoHF1JZtGzowuyYj6VJmc9eaRQw6y+DHAhUj
	 hnLFre6WvLQdYRPTWyopM1zNxVPHYVWei8MqgX6m6F86hWGtdfnbCqAirlHSWZesrM
	 BabzcMvBbQvrzS+HQlfDK0lZr4fJlK7o3Cslo/b31K8oGx8T6XeC9sF6zj8Zg1cekE
	 fpOMGRnM5kgBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6701CC395F6;
	Wed, 10 Apr 2024 00:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] net: start to replace copy_from_sockptr()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171270903041.7096.1378613504797428713.git-patchwork-notify@kernel.org>
Date: Wed, 10 Apr 2024 00:30:30 +0000
References: <20240408082845.3957374-1-edumazet@google.com>
In-Reply-To: <20240408082845.3957374-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Apr 2024 08:28:42 +0000 you wrote:
> We got several syzbot reports about unsafe copy_from_sockptr()
> calls. After fixing some of them, it appears that we could
> use a new helper to factorize all the checks in one place.
> 
> This series targets net tree, we can later start converting
> many call sites in net-next.
> 
> [...]

Here is the summary with links:
  - [net,1/3] net: add copy_safe_from_sockptr() helper
    https://git.kernel.org/netdev/net/c/6309863b31dd
  - [net,2/3] mISDN: fix MISDN_TIME_STAMP handling
    https://git.kernel.org/netdev/net/c/138b787804f4
  - [net,3/3] nfc: llcp: fix nfc_llcp_setsockopt() unsafe copies
    https://git.kernel.org/netdev/net/c/7a87441c9651

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



