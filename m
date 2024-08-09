Return-Path: <netdev+bounces-117076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8C094C8E2
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 05:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BA1CB22578
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 03:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101511BC20;
	Fri,  9 Aug 2024 03:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1HHIFES"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBD51B95B;
	Fri,  9 Aug 2024 03:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723174235; cv=none; b=YnzIyaMUgN6A6C7Ezd9CV7K02T+mCUYB/qZU9AxH1w1e+ydMRy2c6v2p7Xj7eZ5MmIauIaLqvtTgdglElyRExRXjJn4i+jmArhs/WtIK7LAAN4izlRcwl8arsY5eFASq4IhlanOjnSmoTZWgmOt70rC5UdOT4+Y+GDwxDKVllMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723174235; c=relaxed/simple;
	bh=75eyJATitdnFIBeT3EWUkJstR3i1FCQVMbYxAfQKOf4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=etpuLUrCJa4i/ckBx7iQJ7sry5spKcWPwV4W7inMJ43fZ9AfxxofpH59m/TO3eSqpeT+QoMAOHE6/iF1hJSChQ7Q0t7SNnuQwdk4rNGfoRKORlMUxRJfx1aN1ozJm7VznPC0XwdiLuBAU32SwJ2/N+KaxtHqus9svsJ0iihGCcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1HHIFES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58032C4AF10;
	Fri,  9 Aug 2024 03:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723174234;
	bh=75eyJATitdnFIBeT3EWUkJstR3i1FCQVMbYxAfQKOf4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X1HHIFESXwHhIKUjW66ADKDdtdpZHh71v1rFLE2m/7WjRAnaibcbau6q7jXcWqacA
	 BN9RLwq02MfNhaMmcPJ9h2OMZOHG3+Gog3TnrygxsdYI2ZxG+mxNjVZxZV30ONWdfK
	 h6Nxvxh/AVTwvQT1Gy88XLHbPomlR+AmRCL9i+wAb4gP+mlsFTyoKNGmFPesCFKK5Z
	 QGCv90xS0Rdqwn8KrxfLQqan42hTRl7pkk0lN8QXNB4fmlMf1I60a8u7xCYK3YgMv+
	 3WTUcZHQNYkHM9lHiyUI/RGfaLYe605pEEjpNXH52ooHQ5JDF/2ac7zOqRSrk1kqDJ
	 Rf3kRbM+EY1rA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71A4C3810938;
	Fri,  9 Aug 2024 03:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: sungem_phy: Constify struct mii_phy_def
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172317423299.3370989.7412251579421939450.git-patchwork-notify@kernel.org>
Date: Fri, 09 Aug 2024 03:30:32 +0000
References: <54c3b30930f80f4895e6fa2f4234714fdea4ef4e.1723033266.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <54c3b30930f80f4895e6fa2f4234714fdea4ef4e.1723033266.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  7 Aug 2024 14:22:26 +0200 you wrote:
> 'struct mii_phy_def' are not modified in this driver.
> 
> Constifying these structures moves some data to a read-only section, so
> increase overall security.
> 
> While at it fix the checkpatch warning related to this patch (some missing
> newlines and spaces around *)
> 
> [...]

Here is the summary with links:
  - [net-next] net: sungem_phy: Constify struct mii_phy_def
    https://git.kernel.org/netdev/net-next/c/09612576046a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



