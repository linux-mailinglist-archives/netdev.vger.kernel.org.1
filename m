Return-Path: <netdev+bounces-37820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 094167B7485
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 01:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id B65761F2178D
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 23:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326073F4A7;
	Tue,  3 Oct 2023 23:10:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2244B3CCF8
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 23:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1EF4EC433C9;
	Tue,  3 Oct 2023 23:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696374625;
	bh=3dBjkOyDgLMus4Tt33UhON39XrRZc0bmBeUHALmN1Zc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hV08KYmNLgUPvsepZKf6fVmbUtJXOUiELI4UaxUvmW7oAFTnggzImB5YQmsiNDAJL
	 JakwuRxG/WFlz55VhWK3wkzgmmPQvjmtSeC4Hy5p12QU0rb/JaorwIP9kBPUWJddm7
	 lpa0aZfJd+o0wgUzBz8+bNxwiEzu//c7H3MHl8rvOykTyC9oiXAzFZA+HSXh+n7hwL
	 i7ebWDCJlna90XauYu4F7TNMb282d5I/RgllebaE8Ec75ZoYTnFyNQDiGStVqftfwa
	 0hUKiVg5E0s6hoF3I3kVCEcEVW+rV1ACw59Z+8FIlwTefZkwPCqc74l39fnVqNnzQI
	 INV3IWBHddwZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 004E8E632D0;
	Tue,  3 Oct 2023 23:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] net: add sysctl to disable rfc4862 5.5.3e
 lifetime handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169637462499.16551.1709382657790402632.git-patchwork-notify@kernel.org>
Date: Tue, 03 Oct 2023 23:10:24 +0000
References: <20230925214711.959704-1-prohr@google.com>
In-Reply-To: <20230925214711.959704-1-prohr@google.com>
To: Patrick Rohr <prohr@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, maze@google.com,
 lorenzo@google.com, furry@google.com, jiri@resnulli.us, dsahern@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 Sep 2023 14:47:11 -0700 you wrote:
> This change adds a sysctl to opt-out of RFC4862 section 5.5.3e's valid
> lifetime derivation mechanism.
> 
> RFC4862 section 5.5.3e prescribes that the valid lifetime in a Router
> Advertisement PIO shall be ignored if it less than 2 hours and to reset
> the lifetime of the corresponding address to 2 hours. An in-progress
> 6man draft (see draft-ietf-6man-slaac-renum-07 section 4.2) is currently
> looking to remove this mechanism. While this draft has not been moving
> particularly quickly for other reasons, there is widespread consensus on
> section 4.2 which updates RFC4862 section 5.5.3e.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net: add sysctl to disable rfc4862 5.5.3e lifetime handling
    https://git.kernel.org/netdev/net-next/c/473267a4911f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



