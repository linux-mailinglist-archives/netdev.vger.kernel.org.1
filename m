Return-Path: <netdev+bounces-240189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 35731C71483
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 23:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 027AF4E1073
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 22:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309D42D2497;
	Wed, 19 Nov 2025 22:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daBfUEVA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD2A26E6F9
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 22:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763591450; cv=none; b=JB4T17K31/HmHJ2LzDntuxZkAKRVfwb9fajnD5K5TCteHSdB9spRTgChz4Wpny3hSJhXA4DFNWO5OetRrCvBR9ZwJ3R1ETa2FDaxfpmjJMfmOxawIQPXsXm+h9wMlGj2eJ7/r03pDdpmO+CIiPlRPvvewqOV1s8Spz+80OmrU+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763591450; c=relaxed/simple;
	bh=o4N8kxBWR8h1h1G5cttRZU7067h6FouKvh62HYcl4+4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UPkAa9t2sWpMAocA5wOZkFB5LuorsQTP6HSD9XAevpWZooSHM8l7BuTSpyBUPVNIgStg9FMi9IfNrijpUSIlX2at8+m7P1C4iQx9vc63E0Dxb+jk8OZ5/EoxqcfX9qTbEtzNGFlVpkkGnmuxvd4tMe4oTnayQHfU9XPDX/xH2FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daBfUEVA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95261C4CEF5;
	Wed, 19 Nov 2025 22:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763591449;
	bh=o4N8kxBWR8h1h1G5cttRZU7067h6FouKvh62HYcl4+4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=daBfUEVAywY6ubFNn3SKkOmrXc8u74/ydTPHIfM+SZqdQFN0ODnzq1hPI3i1E4nuj
	 lhTBxUk+y9J6TrwgfTU05rLXZdPFr/ahYJTdFuFjUvHk7MBD7EPzc9hV65Cmv2PQPZ
	 KTbrXmzQTAcKWe33+Bcxz/4epzCkB/kSPNYefx2znDF3SF9bhSCVYR13FxIMljD+jr
	 lKYz3j/ZY6JtAEGcJ5n9g3dM4gk2LfxqdhE3IV/fI9B832uB35qWTTBeufa6P/EQlb
	 Y4lSOI3t9qIA9YfIzgBP0i8q/zAsiTSfAQ3F8kucPzdu9LRtzcezD38gtW8+KhfLib
	 6iunjk0RFbo6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7115D39EF952;
	Wed, 19 Nov 2025 22:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH ethtool-next v4] netlink: tsconfig: add HW time stamping
 configuration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176359141527.981342.13809132520139620716.git-patchwork-notify@kernel.org>
Date: Wed, 19 Nov 2025 22:30:15 +0000
References: <20251112172600.2162003-1-vadim.fedorenko@linux.dev>
In-Reply-To: <20251112172600.2162003-1-vadim.fedorenko@linux.dev>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: mkubecek@suse.cz, kory.maincent@bootlin.com, kuba@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to ethtool/ethtool.git (next)
by Michal Kubecek <mkubecek@suse.cz>:

On Wed, 12 Nov 2025 17:26:00 +0000 you wrote:
> The kernel supports configuring HW time stamping modes via netlink
> messages, but previous implementation added support for HW time stamping
> source configuration. Add support to configure TX/RX time stamping.
> We keep TX type and RX filter configuration as a bit value, but if we
> will need multibit value to be set in the future, there is an option to
> use "rx-filters" keyword which will be mutually exclusive with current
> "rx-filter" keyword. The same applies to "tx-type".
> 
> [...]

Here is the summary with links:
  - [ethtool-next,v4] netlink: tsconfig: add HW time stamping configuration
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=3a14b8c15fce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



