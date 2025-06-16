Return-Path: <netdev+bounces-198295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8843ADBCD8
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 00:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483C11715C9
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 22:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B242264BB;
	Mon, 16 Jun 2025 22:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7+7pFkx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E571EF0A6;
	Mon, 16 Jun 2025 22:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750113025; cv=none; b=BxsOVd9LpYD5zJ3fWICPw5U78gG+Ps5qBEVA/pg9fwxKon+EzawfNXuDFrGOT5xbhZX6vvBs0WtqDAFYEK5XBCFP1aF+RSsJe9VV2PStuRac7XS/+ntYm+IPxIGx4cmY1ZqSTA+mvLVKQlcopDE4kiW6JBrK6vORiWOC+i3B+7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750113025; c=relaxed/simple;
	bh=wdIpxSvYZMQELkmZoO10RQF9vFKpjjPVrr/XEK4dtxQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qpkkk0TFieqg5QGKjqNIXN5U9QgjAEr50cMWQtpye1WrXgj+FjvE5fYW5jdvzUz/O+kzoqraEqtZUZK9hsDkykJ0JugKi1r9WH3fcahGIAhBZ4oATph50mwJfyZo2+1kcCrDzkUsz/8AjZmbB7SNWvezISu9IolBCSQQ3AKTIxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7+7pFkx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62CAAC4CEEA;
	Mon, 16 Jun 2025 22:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750113025;
	bh=wdIpxSvYZMQELkmZoO10RQF9vFKpjjPVrr/XEK4dtxQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l7+7pFkxHg9xHbmKTZBMWXa3yyUBSmk+3qINpwFX0RqMSay733gfE0YaI5SSyPgKX
	 wHmQDwpnVsNjuh1m782ekdpthkno35JWuBJecn2C56inM/dNWOvjhpC8vHBu1fiopA
	 puJsZxTT7ZRQQ/XbeC3OMoSd68cRvB2HmcZF2noAzAJd66QDJfDrH9iiNPRpOr8/5b
	 6o8Q6uL9773kbkiJwxxsqhK7rUOqsSC9EcZSeU0VhhhuwFZ8H0lrpvZx4B29kAEeX7
	 skdAWSxDvz9fLKPBVbEzUNvg1GV/Hgs0AJZwvZ4OmIu/b8ZDWe99qBgHbQIm163p15
	 gnmOhVPbYUBEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B6F38111D8;
	Mon, 16 Jun 2025 22:30:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ptp: Use ratelimite for freerun error message
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175011305400.2535792.11237173226777140565.git-patchwork-notify@kernel.org>
Date: Mon, 16 Jun 2025 22:30:54 +0000
References: <20250613-ptp-v1-1-ee44260ce9e2@debian.org>
In-Reply-To: <20250613-ptp-v1-1-ee44260ce9e2@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Jun 2025 10:15:46 -0700 you wrote:
> Replace pr_err() with pr_err_ratelimited() in ptp_clock_settime() to
> prevent log flooding when the physical clock is free running, which
> happens on some of my hosts. This ensures error messages are
> rate-limited and improves kernel log readability.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> [...]

Here is the summary with links:
  - [net-next] ptp: Use ratelimite for freerun error message
    https://git.kernel.org/netdev/net-next/c/e9a7795e75b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



