Return-Path: <netdev+bounces-103383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBDC907CCF
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 21:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA1161C23E5D
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 19:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1BB14D2B9;
	Thu, 13 Jun 2024 19:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJzO2Xor"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313AB134407;
	Thu, 13 Jun 2024 19:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718307657; cv=none; b=uk9Suzjth/HuA9E5W7loB9yTpx1Gt73t5zpKSS/v2pY7aDkBRkELL8nFNGOorZTqozy8ptXlPA2Wk7/EtxZoYqgzzAKwg/44vG5EvU7WrkIwqcLVduJoJ/QWf2QQLStVe0m6iPVasG0F59u0pRSHRCH+Gg+PHVaNz3V2M1FW1Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718307657; c=relaxed/simple;
	bh=+pt3nA76A/CU9CVxOD1K9yvc7TS7w1gsF6YdwNas9W8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Dn/s+bUtdvl68tPew7vzPo2wp0ttvQsYBvVBsDWgMT/yIAhki1fXiQSwP9OwsjyyVt1Kp6hz1Zqfo5/730HnoCJvkPlVlGJYYlVN32rIWxgQo9HAEuASi2RayUkyP3nxC3+suhGEv8eGBe7JTWQ6NE4jbcJF9xfTFWlzJeYtqjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJzO2Xor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C196BC4AF1D;
	Thu, 13 Jun 2024 19:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718307655;
	bh=+pt3nA76A/CU9CVxOD1K9yvc7TS7w1gsF6YdwNas9W8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YJzO2XorndLtZiDUH4fyhOEvo9bIfO8LUXvlloB2QKtbeaFllmV8PqFBGkU+NOXSl
	 BTfCEzPemIwpQ2vbJdHgkEBcbIi+zG/QaLif4yxtfgtPtPlCGW2KIN/FgYTgEdjEqO
	 EQm+SyYt0fOGnlfkvkv8c78xOsDLATFMAjp6FQsOC53EyGlYqPAomngmWDbRY8Xt+5
	 4+rruY4bhXZR96ET5d71aCx0DJjtTjsOPqI0YIm+XsEWMUOlvhjmn+6N2qDAABT2im
	 p9oy4LmYjPya789KLbGVWSht73WIcM/Pbz4D3oAvxDt57aGYZQf5A7/79G56WokXB1
	 U5Br5KEhhVrAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF4B7C43619;
	Thu, 13 Jun 2024 19:40:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] Networking for v6.10-rc4
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171830765571.27125.610944644558784530.git-patchwork-notify@kernel.org>
Date: Thu, 13 Jun 2024 19:40:55 +0000
References: <20240613163542.130374-1-kuba@kernel.org>
In-Reply-To: <20240613163542.130374-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com

Hello:

This pull request was applied to netdev/net.git (main)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Thu, 13 Jun 2024 09:35:42 -0700 you wrote:
> Hi Linus!
> 
> Slim pickings this time, probably a combination of summer, DevConf.cz,
> and the end of first half of the year at corporations.
> 
> The following changes since commit d30d0e49da71de8df10bf3ff1b3de880653af562:
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] Networking for v6.10-rc4
    https://git.kernel.org/netdev/net/c/d20f6b3d747c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



