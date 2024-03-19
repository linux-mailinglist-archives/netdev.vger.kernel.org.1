Return-Path: <netdev+bounces-80581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C67287FDD2
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 13:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E0EB1C22036
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 12:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F873FBA9;
	Tue, 19 Mar 2024 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXnRuOkA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53ED7F7FE
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710852629; cv=none; b=F0Np5gWS85vEaId9ryN2w8ISHN1zjkp6bilALOg1N7zsCqR3GXp8ceeGEcmdw2I3kUNt9vHubRrcw1yNw34VpbQBQwF8qCFVaKZB7GXD0HH96H3qqv51u8CjzHdZiCIEqywwimpxQ3fqekx/r/LPPjrgcf54PvDvI5/t8EzyrX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710852629; c=relaxed/simple;
	bh=kt15eg20jl0wzbsU2OS3aToYEk7iBlPcGoN9BpUnc+U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Oa7tr4CrbMtRmnKD5O1di4IzJPZnTQeAM8E6DXsumy0ovhwSpBqrSFpRV1KEAIOXHO1/OLxZffUDsvCwKt/m15dw+e0npyYBrUlD2s8+pGDK60W2ss4DTVS7JGqItxZ2mNtnhOh9fM3Nb2d/oyRdkBpy0bm2EDmdviqqBsHUYe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXnRuOkA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 294CEC433F1;
	Tue, 19 Mar 2024 12:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710852629;
	bh=kt15eg20jl0wzbsU2OS3aToYEk7iBlPcGoN9BpUnc+U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AXnRuOkAKZ14nHbArUPwAv5FppSm+BbjfGJ2hfBm7ali8K1wayTGjDTQSbr49R7i6
	 tUBtl6qNqhJTSkS0qQXorz0o1gAr9rCdngsbO9z2VqNFpDTuzsmRGovPt1Lnbo15jK
	 4ySQ9bg9oKF70t1busx4f1RK/SO03K0lk2HwKvR4z4rYtZNsZ5Q9VdxuV2q5xk2a5c
	 KLItM6OFrXqVecVGaXjFI2c6xfaz7mEq+jpANRhdWV9xV2Gw4wtxuOrlrJkklMGtH0
	 6wpyW40oDxspecYUzL+K4k61RwwqZRm20YrrYyxIHH+R9qTI3UrDUsNfcxlydu44o5
	 Ew2pOoeb6pezg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F678D982E0;
	Tue, 19 Mar 2024 12:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ipv4: raw: Fix sending packets from raw sockets via
 IPsec tunnels
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171085262912.28386.6970587324786695855.git-patchwork-notify@kernel.org>
Date: Tue, 19 Mar 2024 12:50:29 +0000
References: <c5d9a947-eb19-4164-ac99-468ea814ce20@strongswan.org>
In-Reply-To: <c5d9a947-eb19-4164-ac99-468ea814ce20@strongswan.org>
To: Tobias Brunner <tobias@strongswan.org>
Cc: davem@davemloft.net, dsahern@kernel.org, netdev@vger.kernel.org,
 steffen.klassert@secunet.com, herbert@gondor.apana.org.au

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 15 Mar 2024 15:35:40 +0100 you wrote:
> Since the referenced commit, the xfrm_inner_extract_output() function
> uses the protocol field to determine the address family.  So not setting
> it for IPv4 raw sockets meant that such packets couldn't be tunneled via
> IPsec anymore.
> 
> IPv6 raw sockets are not affected as they already set the protocol since
> 9c9c9ad5fae7 ("ipv6: set skb->protocol on tcp, raw and ip6_append_data
> genereated skbs").
> 
> [...]

Here is the summary with links:
  - [net,v2] ipv4: raw: Fix sending packets from raw sockets via IPsec tunnels
    https://git.kernel.org/netdev/net/c/c9b3b81716c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



