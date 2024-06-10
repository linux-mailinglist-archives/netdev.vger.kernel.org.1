Return-Path: <netdev+bounces-102264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8209021F5
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 14:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A85801F2100C
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 12:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EDA80BFC;
	Mon, 10 Jun 2024 12:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ar8J57D8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317064AEC8
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 12:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718023832; cv=none; b=Fypta21HtKwdUCEz5ngQbf0nas8+7JWzJoOs/7dihJ6T0LHcWNS/nxMBFb4R328NUEJ5pJKoL+1oRJ5SuzTKDcuokCvONxc1D0r13W2Gp2WgivBEZMra9QFBRFMUySF1HjggVtuP/RHMxEWMVgbJxchm7zyS7sbNwzTU4xctMmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718023832; c=relaxed/simple;
	bh=GfDTjs6nZF7kdFIeaDN2G5gaFUGdZ4MkZVofrgHsTu0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g3Cc+Jli09shOC60jD6bWLyyLHVpWJl8RAmUiQ88A4USeUtKfTChE/DaRDvjUq1votHLujVgrz+fb6p1f+VacuKIaueCwgsBPtttP41Yh/9GV/n3Wn+VkX9KFmBir36g+3qCytO2hofJOhWJijog7jnLYuLcvc8eZD/9MDMcqT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ar8J57D8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EAE69C4AF1D;
	Mon, 10 Jun 2024 12:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718023832;
	bh=GfDTjs6nZF7kdFIeaDN2G5gaFUGdZ4MkZVofrgHsTu0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ar8J57D8zEWOPRDkhmnZfoILXJgWH1hAUKaIiSoWveDipFW+EHvvPBYu4OrbIkEYJ
	 CQEZxHj6G61zH5Hfvxd8M7gRy2q4JVNYH3ePgypJW/axiaHiuHTfOgdKZiN6yfxQ4i
	 5lGbOiRE7KQ4L5ppC4yL/UluQxSGNag8f415ovh0WgVpZbBcSRiG+4gNsqX6m6fZve
	 jjXxlhUMLDHG2FaL/cq2Ivv1BMhnmuNu1bFnbvh9K60OR3Biai4AnW+Dd7RyotjPAs
	 hW30ugNszYe/LlJFz/hPbePVazDNLAOhXB8p0DCWFwsgmszSBkciv7Fv2s9d4NtkSD
	 DnOzA7jaPvWrA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D9F80C43168;
	Mon, 10 Jun 2024 12:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] Fix changing DSA conduit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171802383188.19319.13366661293581709528.git-patchwork-notify@kernel.org>
Date: Mon, 10 Jun 2024 12:50:31 +0000
References: <20240605133329.6304-1-kabel@kernel.org>
In-Reply-To: <20240605133329.6304-1-kabel@kernel.org>
To: =?utf-8?q?Marek_Beh=C3=BAn_=3Ckabel=40kernel=2Eorg=3E?=@codeaurora.org
Cc: netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
 olteanv@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  5 Jun 2024 15:33:27 +0200 you wrote:
> This series fixes an issue in the DSA code related to host interface UC
> address installed into port FDB and port conduit address database when
> live-changing port conduit.
> 
> The first patch refactores/deduplicates the installation/uninstallation
> of the interface's MAC address and the second patch fixes the issue.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] net: dsa: deduplicate code adding / deleting the port address to fdb
    https://git.kernel.org/netdev/net-next/c/77f7541248fc
  - [net-next,v3,2/2] net: dsa: update the unicast MAC address when changing conduit
    https://git.kernel.org/netdev/net-next/c/eef8e906aea2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



