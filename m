Return-Path: <netdev+bounces-159866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72272A1737A
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 21:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3782216AC40
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 20:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFEA1F0E44;
	Mon, 20 Jan 2025 20:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnvHyhQK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A241F0E3F;
	Mon, 20 Jan 2025 20:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737403813; cv=none; b=jZ36a4UHnKcx3zLnX2pPRn8Pe2N5dUo2MDCXboxhRfdPchU37oUoYNROq2PDfkoAFtvZoZKbSY+BmfCks/GT6t9sMJMJwhJxqQK2w3ds2ZALLJGj0OWwbScNkF5K1iTP4PY04NK3mj5gnXZQYhqZmH6hhRD1rhpOvcoyTkrkUWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737403813; c=relaxed/simple;
	bh=XVeYbtDx7IN9thwdnF7jKi3jSvJYlWr7ozQlqMiSTo8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KWIiCrNJym/nlAS5cvuwhjIJmu+R/j++1HpJr8f5jrx5M7RwNhXAFRPeJHDgZW2cMKlxSff2JQsYy6SHT/U7foWlOYG4zRUvisG8wgw0JamuSj2ptjrudibZnDst0g38P5iTIEV4M46lDLalTzVVHswLTzBWIY2jbX9PfN4+hI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnvHyhQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74903C4CEE4;
	Mon, 20 Jan 2025 20:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737403812;
	bh=XVeYbtDx7IN9thwdnF7jKi3jSvJYlWr7ozQlqMiSTo8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QnvHyhQK15HgN/OSbq1HRpN7UaDTaqZChJsBLMMi7sSCkPr1IusVXCDLCT5iQrYa3
	 5rqu0czRho+p3BVCfnQDZscpXGtoZTxY6PLez2thj+1f9KwifoEWJqCJfXG52dF6at
	 F79Ch9XDXc7aoxBRnL/AQ9hKHCXC+0MWiz1rLEAp778UF3cXb494fp3KnlQXERRJfy
	 y8OHXHrS8pMkzur/WrsID0A9lTDaZowQn5x8y3sIqDgMkQ5rYrCBGNVkz3jUj2zU23
	 jjDrui7HRmEjp8wFiV9eT5c0nLWvasZa9fUdknQ2kJ1w2pdkKzNr71fEXfEFDcoMYr
	 Kiw99Z3EFHUPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE769380AA62;
	Mon, 20 Jan 2025 20:10:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] sysctl net: Remove macro checks for CONFIG_SYSCTL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173740383624.3638218.17963441343497501328.git-patchwork-notify@kernel.org>
Date: Mon, 20 Jan 2025 20:10:36 +0000
References: <20250119134254.19250-1-kirjanov@gmail.com>
In-Reply-To: <20250119134254.19250-1-kirjanov@gmail.com>
To: Denis Kirjanov <kirjanov@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 19 Jan 2025 16:42:53 +0300 you wrote:
> Since dccp and llc makefiles already check sysctl code
> compilation with xxx-$(CONFIG_SYSCTL)
> we can drop the checks
> 
> Signed-off-by: Denis Kirjanov <kirjanov@gmail.com>
> ---
> changelog:
> v2: fix the spelling mistake "witn" -> "with"
> 
> [...]

Here is the summary with links:
  - [v2,net-next] sysctl net: Remove macro checks for CONFIG_SYSCTL
    https://git.kernel.org/netdev/net-next/c/19d7750a06bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



