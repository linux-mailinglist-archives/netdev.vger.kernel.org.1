Return-Path: <netdev+bounces-203074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C39DCAF076C
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 02:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC31A3A9D2D
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 00:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B24D38FA6;
	Wed,  2 Jul 2025 00:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXcDhMdM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214452EAE5;
	Wed,  2 Jul 2025 00:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751417390; cv=none; b=mJjOcZucaSOrhDdneLu3gZwmkQ+UnWqPW1iZfXo4j6LscU+79siIj9R4db/WxtRoJNswM8p6FD/2+5pnAvq23pLc0Xdwd5FvVV94dvJ/lTEB5NNgbUOnETqQXk1MtGnK3WvVoKssa+ragtmZnofE5kq+Z50XF7H5w+HDQxIuKgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751417390; c=relaxed/simple;
	bh=BKHJ1ULyV/OnuO5DjJgbAsEbGJvDys+uflNsF5fE0P8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fpQWOfydHPXq3NIzdU1UYxPQZeXiIttbZECFvjXy17a2uJJTByghyih8EwO4dYdCnQT4B9LOraAgTHjv6Kr6fW1NRYhXTw4MEyGBK6Vrx/3AGSoXUqLgplFB0WwmmUY/4J1V1b0izjjd/cORGTT9byfsLj5BHh7LcWAx0fGO9kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXcDhMdM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA05C4CEF1;
	Wed,  2 Jul 2025 00:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751417390;
	bh=BKHJ1ULyV/OnuO5DjJgbAsEbGJvDys+uflNsF5fE0P8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TXcDhMdMqjLZBhodYY1vUF+ehCoy3LFioXBxSLQ2yKdUwkX1BZKdSDy3DK1vAqk47
	 YVdJkjtzsUA3iu++1iOIULvWCe4M190NYvSkeoDyKLB8Y1yH6j1AjIPdExa01oxEcs
	 a2rAZ74rDCGN8NWb/gXGNFUJw24vcecjB9XeChQdZCwwdCxWTd1Ak+7YhnuBCviFfv
	 fvxobqQ+51pcCJ5ficiS0AIBk7JwEtsyeH25ez6xQkGn+wLj0meWtyDrmf1K342oYu
	 RKiu3W33s4rzO/sqe0oCnfbO+QsHrIt4qkquHjflBiw7eQNB5R0K20P1PQqeH4BQnl
	 VUdLk72NCVtww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACFB383BA06;
	Wed,  2 Jul 2025 00:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND net-next v3] Fixed typo in netdevsim documentation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175141741475.160580.3394283240603046404.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 00:50:14 +0000
References: <20250630-netdevsim-typo-fix-v3-1-e1eae3a5f018@linux.ibm.com>
In-Reply-To: <20250630-netdevsim-typo-fix-v3-1-e1eae3a5f018@linux.ibm.com>
To: Dave Marquardt <davemarq@linux.ibm.com>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, leitao@debian.org,
 joe@dama.to

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Jun 2025 11:23:53 -0500 you wrote:
> From: Dave Marquardt <davemarq@linux.ibm.com>
> 
> Fixed a typographical error in "Rate objects" section
> 
> Reviewed-by: Joe Damato <joe@dama.to>
> Reviewed-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
> 
> [...]

Here is the summary with links:
  - [RESEND,net-next,v3] Fixed typo in netdevsim documentation
    https://git.kernel.org/netdev/net-next/c/16f87fb24302

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



