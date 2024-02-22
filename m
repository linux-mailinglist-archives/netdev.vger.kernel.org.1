Return-Path: <netdev+bounces-73864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 791C985EE9A
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 02:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 712BEB22F73
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 01:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAA617577;
	Thu, 22 Feb 2024 01:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJpEATUb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E15E12E49
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 01:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708564829; cv=none; b=LBm4UI4My7YI5mC1Enf/CicLgdwdcteP/BZXCKO+kQduKDr95uaZVXUknHCXeuWtby3Ldr2CuJplnLT3kT6o/aKH8lYCo1AnYfDxmuIs96UIBKYyL1FpjX4yWTnsm+nEDo7Sg172VLfNyAFYyCi+Raxtpqb7LyLzeYNGRNZfbJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708564829; c=relaxed/simple;
	bh=37r7LpPo0w5p0elvAfb3h9PNeZu1K0yK68rXg9ctWkM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xkhys1dIQbXWrzKGwNKtIoSZV1HUKXInhjbuUmkZt3SMsE7hk8zjxhBIUCGy12iw6W5IcucOI6husUfjgD0V8lLT1chsc1w2q9FBPoI7syOCgDiWb4MQ4fzaiFDMz1FozuRB3UDIydHH0QcFKszobMYQ2NVszSG9wCB+KIQFHnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJpEATUb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9F23C43609;
	Thu, 22 Feb 2024 01:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708564828;
	bh=37r7LpPo0w5p0elvAfb3h9PNeZu1K0yK68rXg9ctWkM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OJpEATUbyvqRUovh+DJYgeMeQ7YwPc7ahz+y4yIzSllBqFojmPbfMWKePcDyVURLq
	 O1Z1wQDWVXu5sDaLYpZwzix9rhwtWHPdav+BjPEKq+iQZGseYShMkSVctR7GcYZO1L
	 tVHSq+xkye0KX7RNrpva3cF/hD716rBwWUlAHuUkTWD0RstFNUFYhxp5xm1JzNVdLT
	 OiNZms2ZeUQwppaVoab7xEF215zwFRk2jFHL9FmFogwa0MBl7iNvGrLlH8AVJ5+/2j
	 qOW6Dr8ixblB+nIST+mxzwbIqHI5PPixDVmXUychuZzgtP/fzQF2ap5DLGNrjgrqLZ
	 Ou7y+MeKbQyDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B1C6FD84BD3;
	Thu, 22 Feb 2024 01:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mctp: put sock on tag allocation failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170856482872.21333.18437400650482991726.git-patchwork-notify@kernel.org>
Date: Thu, 22 Feb 2024 01:20:28 +0000
References: <ce9b61e44d1cdae7797be0c5e3141baf582d23a0.1707983487.git.jk@codeconstruct.com.au>
In-Reply-To: <ce9b61e44d1cdae7797be0c5e3141baf582d23a0.1707983487.git.jk@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: netdev@vger.kernel.org, matt@codeconstruct.com.au, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 Feb 2024 15:53:08 +0800 you wrote:
> We may hold an extra reference on a socket if a tag allocation fails: we
> optimistically allocate the sk_key, and take a ref there, but do not
> drop if we end up not using the allocated key.
> 
> Ensure we're dropping the sock on this failure by doing a proper unref
> rather than directly kfree()ing.
> 
> [...]

Here is the summary with links:
  - [net] net: mctp: put sock on tag allocation failure
    https://git.kernel.org/netdev/net/c/9990889be142

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



