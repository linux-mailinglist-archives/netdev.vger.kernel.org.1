Return-Path: <netdev+bounces-76261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E6186D067
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 18:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C92FC1F227D0
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 17:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017286CBE2;
	Thu, 29 Feb 2024 17:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCLL7zn9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D181270ACD
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 17:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227237; cv=none; b=M13xVx+LaUPMUMjTiPJ0/0wo7fjZE6/EfxTW+9UXVenRILQc8YvS8SPHYfFecnv07p6pPBUYy++bcm4GCjXaIRCtklXXae6RUiTqN+iU5o9tg9jNHHNWmCWlCWioZPlLUxkDgQQz8ZqU6IZHnYuyjazfr2T/JzLyBDf679vtXCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227237; c=relaxed/simple;
	bh=Dz8X3abmMV2+G7xgkpkfx4bvJhdk4zHhMx648bHaRdo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sEdPByaVGHAFaRdZEFELfTTwWiCDLQDfZGdr55kaPRDkahy9/tCQ+wlc/5kGs/n1Mpq7bKluaxp4fenq+9++/9oZskDsgi5ISTCXnxrpiZhAYKngXqH1JuSqZNLrxEEDnLxBiWAtBRaHSLJOpVpZWhG2zkXWI99JyvVvHAwlMPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCLL7zn9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73D7AC433F1;
	Thu, 29 Feb 2024 17:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709227237;
	bh=Dz8X3abmMV2+G7xgkpkfx4bvJhdk4zHhMx648bHaRdo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YCLL7zn9smewaXqnDOoh+fumLgRZBx7j+0FGIIOJDFXC6xbZjiqN89yKDwano2BI4
	 DQQ05oFCJHmR++AXonWBMZ+MtUz/BFnm7Pob590VgDduLvd7132szL4prBSFXre6zw
	 3AlLK3L1eMIkzywXkgDW4h99BbtExYU6XLp4D+rQqOkbuUcAwThSVFOklF8HLerYpg
	 Ap2V2ptikW7msDFqeur77Ks/e4hpMWFlJ2ILUjTICFkpzwkNW7AlNSQGV6rR8AVqvZ
	 Wzb7EKLMq5hb9xE3QI4JI5xzWbMAfK+9cg5PYN5vZ/dfpUA9bEZvuQvUFZ+W3/D3ZC
	 7DfYwunht/WKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 586C6C595D1;
	Thu, 29 Feb 2024 17:20:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] tls: a few more fixes for async decrypt
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170922723735.28034.3350874918349879660.git-patchwork-notify@kernel.org>
Date: Thu, 29 Feb 2024 17:20:37 +0000
References: <cover.1709132643.git.sd@queasysnail.net>
In-Reply-To: <cover.1709132643.git.sd@queasysnail.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, vakul.garg@nxp.com, borisp@nvidia.com,
 john.fastabend@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 28 Feb 2024 23:43:56 +0100 you wrote:
> The previous patchset [1] took care of "full async". This adds a few
> fixes for cases where only part of the crypto operations go the async
> route, found by extending my previous debug patch [2] to do N
> synchronous operations followed by M asynchronous ops (with N and M
> configurable).
> 
> [1] https://patchwork.kernel.org/project/netdevbpf/list/?series=823784&state=*
> [2] https://lore.kernel.org/all/9d664093b1bf7f47497b2c40b3a085b45f3274a2.1694021240.git.sd@queasysnail.net/
> 
> [...]

Here is the summary with links:
  - [net,1/4] tls: decrement decrypt_pending if no async completion will be called
    https://git.kernel.org/netdev/net/c/f7fa16d49837
  - [net,2/4] tls: fix peeking with sync+async decryption
    https://git.kernel.org/netdev/net/c/6caaf104423d
  - [net,3/4] tls: separate no-async decryption request handling from async
    https://git.kernel.org/netdev/net/c/41532b785e9d
  - [net,4/4] tls: fix use-after-free on failed backlog decryption
    https://git.kernel.org/netdev/net/c/13114dc55430

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



