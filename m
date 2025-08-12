Return-Path: <netdev+bounces-212915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C20B22815
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 15:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52C863A760B
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 13:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C593276054;
	Tue, 12 Aug 2025 13:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzrjnWcJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E15275B1C
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 13:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755004199; cv=none; b=MbIpViFxoV/J+xjBtQi47u5CmbyIDoHHSMX3TbmxwuDSWuvP5/7h1gMZtL+BSsEGpcd4uSUOxs5kjr0vwNph3Gs4rFVaZkCcsZ9sFkEn2RJMKJtDpM+EUpaY3wO0fd+d5oP7tQ7pPG4byg8RU7tsdQHsYLlaQ6d3TgcvcREEnAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755004199; c=relaxed/simple;
	bh=xLzp7C+1YcyKkVLn3xJI8mxqcEqD0Hg7MrhyqrCKHe0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Cs+hTO7EjU25hMzQBCVK+uvKfY7GwrMCHzTEeA2zyFmXads9IsU1A/DeCz/kGvsWbs3rCbEYZ5jHOPJPiSgHuXyxR0tTbgYhpg6ao2aygYsQl7jOs6LbyKjiqZBVdd7g2nQ2HaRfLE1jWaM4MSh3wx03KjaWkt4q+LGUMLZDMao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzrjnWcJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50F4C4CEF7;
	Tue, 12 Aug 2025 13:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755004198;
	bh=xLzp7C+1YcyKkVLn3xJI8mxqcEqD0Hg7MrhyqrCKHe0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BzrjnWcJ6UXw1zuLpw90INeHzeVxeqMOXn7xHOMj6sJx6WIUSIo2N5o3pUa1tVYtf
	 H8O6vkaHf1trBPwri15qNwRhRcur4+0f40pxDfmQ6sBubljPU2LX1Hz6TCcpQ6Gmjw
	 T71HQ5X8/E0QqVOy2hgu2/pIbG8N2/+KOyLkf4ealShL2nNjXQSrGellK/uYVJyxAY
	 Dem5P/2cEi7IaSxdixQ21F0SP/1OX21qPPjC9wY83cPrFGhFvCKO0bibZB8UZYQ+ik
	 XMMHwN81PD/Vkykfl0HthA2maKQUPgjTYVVltagh2ipoHxVgNqhUuhAmdpaFsMcBEa
	 H34b0DVGLT4uQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BE0383BF51;
	Tue, 12 Aug 2025 13:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/4] xfrm: flush all states in xfrm_state_fini
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175500421100.2610815.256378737986277211.git-patchwork-notify@kernel.org>
Date: Tue, 12 Aug 2025 13:10:11 +0000
References: <20250811092008.731573-2-steffen.klassert@secunet.com>
In-Reply-To: <20250811092008.731573-2-steffen.klassert@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Steffen Klassert <steffen.klassert@secunet.com>:

On Mon, 11 Aug 2025 11:19:29 +0200 you wrote:
> From: Sabrina Dubroca <sd@queasysnail.net>
> 
> While reverting commit f75a2804da39 ("xfrm: destroy xfrm_state
> synchronously on net exit path"), I incorrectly changed
> xfrm_state_flush's "proto" argument back to IPSEC_PROTO_ANY. This
> reverts some of the changes in commit dbb2483b2a46 ("xfrm: clean up
> xfrm protocol checks"), and leads to some states not being removed
> when we exit the netns.
> 
> [...]

Here is the summary with links:
  - [1/4] xfrm: flush all states in xfrm_state_fini
    https://git.kernel.org/netdev/net/c/42e42562c9cf
  - [2/4] xfrm: restore GSO for SW crypto
    https://git.kernel.org/netdev/net/c/234d1eff5d49
  - [3/4] xfrm: bring back device check in validate_xmit_xfrm
    https://git.kernel.org/netdev/net/c/65f079a6c446
  - [4/4] udp: also consider secpath when evaluating ipsec use for checksumming
    https://git.kernel.org/netdev/net/c/1118aaa3b351

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



