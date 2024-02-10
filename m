Return-Path: <netdev+bounces-70789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F01AC850681
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 22:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27CA61C20CA2
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 21:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7EB53E35;
	Sat, 10 Feb 2024 21:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHX9uq0n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8746820334
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 21:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707601226; cv=none; b=XhBFhaqYia0qv4AZQaS/ASayUeojPgg1V+8D+2dGm+djlKfv8gMcWTEQuA9PlpQBgxm1Cz8x6VK+WCR2PqJ3z8AnveZUJX3F+/4ytn5kz9AvL0BXsYkpgPhrswNrnI8fEfcWzvGwCJFqKLLReT3dV384rp0OlmnNKtnh7vO0l14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707601226; c=relaxed/simple;
	bh=FAsFXN3Y7eBr9Ri758sNNmnsDy362UzI62wfM+V12lQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M+nZUkCUKZUtD7nMw/4X/p/lM83e0ytTEenIm6ZcrAt/AcKrQo5gJ5Nktq6M2vGr8zWVfK2sbTHp09sGwNtpZ1sCBSurunxgt/z4CN93UgYjwxeWgUFm9pG3fa1em/ooczLLeR42Rs5jOTqYXu0vd070c3q5QZ4TfmSNBCxuJ3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHX9uq0n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6229C433C7;
	Sat, 10 Feb 2024 21:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707601225;
	bh=FAsFXN3Y7eBr9Ri758sNNmnsDy362UzI62wfM+V12lQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RHX9uq0nZzB9FvCfarq85lH8Gs1l5KcJm99ugoynjMFT5hl3lBXjRdw7kbNC9CgnT
	 l/DjRLA3NXbmieQSJAwtgHPMMPSrkjfDZ8uw7VMFLuyyMVAkdLJpBM/bVipgW7Fxxn
	 ypgHQqpKjqO8xSp9Gat6jFj/msBbcQbxLYBa3dJWR25g1J/53FbQ2UdZ3Tra/gzjPq
	 rw2RmFwXzZQn4R+TXuNqcFpW4LcnpT2K0TIvRNxBnWGb8UobD5pzSc71BOKQyw4dcy
	 aD+a7A32gcbjXQIOAqw4gwpvpP7bvo2Ez7lATWhzgqf9K0kXxTOYdJd5WbVUikK9zU
	 ETIZXcC+iXjgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ABECCE2F30C;
	Sat, 10 Feb 2024 21:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/7] net: tls: fix some issues with async encryption
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170760122570.11365.14054733376505067895.git-patchwork-notify@kernel.org>
Date: Sat, 10 Feb 2024 21:40:25 +0000
References: <20240207011824.2609030-1-kuba@kernel.org>
In-Reply-To: <20240207011824.2609030-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, sd@queasysnail.net, vadim.fedorenko@linux.dev

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  6 Feb 2024 17:18:17 -0800 you wrote:
> Hi!
> 
> valis was reporting a race on socket close so I sat down to try to fix it.
> I used Sabrina's async crypto debug patch to test... and in the process
> run into some of the same issues, and created very similar fixes :(
> I didn't realize how many of those patches weren't applied. Once I found
> Sabrina's code [1] it turned out to be so similar in fact that I added
> her S-o-b's and Co-develop'eds in a semi-haphazard way.
> 
> [...]

Here is the summary with links:
  - [net,1/7] net: tls: factor out tls_*crypt_async_wait()
    https://git.kernel.org/netdev/net/c/c57ca512f3b6
  - [net,2/7] tls: fix race between async notify and socket close
    https://git.kernel.org/netdev/net/c/aec7961916f3
  - [net,3/7] tls: fix race between tx work scheduling and socket close
    https://git.kernel.org/netdev/net/c/e01e3934a1b2
  - [net,4/7] net: tls: handle backlogging of crypto requests
    https://git.kernel.org/netdev/net/c/859054147318
  - [net,5/7] net: tls: fix use-after-free with partial reads and async decrypt
    https://git.kernel.org/netdev/net/c/32b55c5ff910
  - [net,6/7] selftests: tls: use exact comparison in recv_partial
    https://git.kernel.org/netdev/net/c/49d821064c44
  - [net,7/7] net: tls: fix returned read length with async decrypt
    https://git.kernel.org/netdev/net/c/ac437a51ce66

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



