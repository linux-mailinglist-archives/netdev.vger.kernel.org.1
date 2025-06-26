Return-Path: <netdev+bounces-201562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E764AE9E73
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 15:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96B3116F202
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 13:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A500295534;
	Thu, 26 Jun 2025 13:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFS8usx6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2523420FA8B;
	Thu, 26 Jun 2025 13:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750943980; cv=none; b=pnVRZHTpeMMhB31EgeilVN8mBecDhTXbgfAcRECw312DeVBAvXJp1M8jtHYlnsLMyPNXNACD9jxbBHD7Ru3ms373pDTVzNcufqbIKG46xzYr7GdlSiT4puYjjije6Ek6I72EYR9PS8cK3IqWpt31+oKUs7dhqeBGs5jZUzdeFAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750943980; c=relaxed/simple;
	bh=RKK9i3woSuc/hPkLqzG8OyyihSg5r6v+/BxW1hVqfUM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gib5AaCg6Rgd5FjEY8kl4FSnCwXW41bXe2m1wyadIS420Xaf2bLLEhqRd9PYjFoeihy6jmG0GAdWj9hRECV+k+rm87tYbU5V+Ua/rRUHrHRXft/+f9kAUTY5PRio7Mlv8759AGYqJysVRiX85/GVkWDs5DeFa4WivMhjNaIvEs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFS8usx6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B25CC4CEEB;
	Thu, 26 Jun 2025 13:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750943979;
	bh=RKK9i3woSuc/hPkLqzG8OyyihSg5r6v+/BxW1hVqfUM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hFS8usx60l3rH0a6pZPgSotwhtrPp0fq/clbb7DENhQHGzGr9HCnEck+fVQuOm48X
	 72btNVEPjvKTcKHPy2cDfOcG2rbG23rDRtJmfSNm19Mn2mC01fWiIv7JSGrOMKMgI9
	 N6LOWxuQFU+EVNNKc1WTzAT9A4uvqFWzwQHHmTSwg6gDhnEgzhVh6tJ9a5OwffLItj
	 ZM2tT4as875aPOGSHv0Xh7EBANVdDDGzfC8yPSZm78sZqS+WiDBu77hHoVj4CLKVEq
	 ZYhReGP9Viw2MOgH4+vm3gMD89h3tlohNFFQJ/WKIRwIo9Rv0Sojx1B1hhvLfZoUbL
	 Uh8gcqH1QpIgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E5F3A40FCB;
	Thu, 26 Jun 2025 13:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6] docs: net: sysctl documentation cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175094400601.1199554.14225911513900561603.git-patchwork-notify@kernel.org>
Date: Thu, 26 Jun 2025 13:20:06 +0000
References: <20250624150923.40590-1-abdelrahmanfekry375@gmail.com>
In-Reply-To: <20250624150923.40590-1-abdelrahmanfekry375@gmail.com>
To: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
Cc: corbet@lwn.net, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-doc@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 skhan@linuxfoundation.com, jacob.e.keller@intel.com,
 alok.a.tiwari@oracle.com, bagasdotme@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 24 Jun 2025 18:09:23 +0300 you wrote:
> Add missing default values for networking sysctl parameters and
> standardize documentation:
> - Use "0 (disabled)" / "1 (enabled)" format consistently
> - Fix cipso_rbm_struct_valid -> cipso_rbm_strictvalid typo
> - Convert fwmark_reflect description to enabled/disabled terminology
> - Document possible values for tcp_autocorking
> 
> [...]

Here is the summary with links:
  - [net-next,v6] docs: net: sysctl documentation cleanup
    https://git.kernel.org/netdev/net-next/c/5cfb2ac2806c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



