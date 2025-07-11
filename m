Return-Path: <netdev+bounces-206209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FEBB02229
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 18:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAC4C1CA6881
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 16:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D150C2EF9C9;
	Fri, 11 Jul 2025 16:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqwlrvwK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD69F280334
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 16:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752252603; cv=none; b=eo9njlnWqZjiqH51S1dP6Ue7/DqM+sNmIkiXqFCbQvStKpTHfXfaEc+FMIsa7I8ZkjPwv84LBW8PieUAsXVOkkAuQfmydoN7+gUd0N0mDLpk3xCNMLvVEoKGQ0viO+fitpPUIHsk7TP4P09W1kyvALI6MtY2Z6TropvCPJL4cO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752252603; c=relaxed/simple;
	bh=LVL2LMLKm4stPcqdWaJfAntuTcBJwvlylJO4to71QNg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qP4i3fUml9oVdf+hO6BxgMQmQkXbvFYJBXqvZBTrHGhzOihoklWsd0PAt54ID59g+CRTuVwqSGPJGKtln5XfHsbQhOKVNPwXSG2my0xcHQH5qtHmt+UBeDFU5ahyuxgpLRSy0HYcmtZ7fECprDVIty4ACgwimLwL3pcrE3DgRLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqwlrvwK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F5BC4CEED;
	Fri, 11 Jul 2025 16:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752252603;
	bh=LVL2LMLKm4stPcqdWaJfAntuTcBJwvlylJO4to71QNg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kqwlrvwKPXWaAB/IpVZFv2kFHNxnpyG1ItzrMZ+qRYEhvyPooamtUQCDvjG6ZyYyP
	 sTR1y09HmR0fiqEafsBq3LPT1tBvOY5N84g9K9Nd7nYkjpjgEzczGgtNkfwhky4RBo
	 Grya/aCn06f25hqAaZ2L6Bw+A+W9e2TyPYwSBJ977G/oyIxnd9CrIKpvlTMwph+gS/
	 Nh0wScWOvHXzmwoKs0rlfp6HpURGwNyI6IdZjrzDlyltSjQxymL8yScVmNZKHm6cCH
	 +d62PFvVjg8NwV1pbrjXT2YbQ264+Y/C9R4jNHSN1/2RN1+2hE+jt+14BvXoHOGlX1
	 lPT25JHqbVa7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D80383B275;
	Fri, 11 Jul 2025 16:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next 0/2] Add support for traffic class bandwidth
 configuration via devlink-rate
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175225262514.2335070.1710754902601497445.git-patchwork-notify@kernel.org>
Date: Fri, 11 Jul 2025 16:50:25 +0000
References: <20250704122753.845841-1-cjubran@nvidia.com>
In-Reply-To: <20250704122753.845841-1-cjubran@nvidia.com>
To: Carolina Jubran <cjubran@nvidia.com>
Cc: stephen@networkplumber.org, dsahern@gmail.com, jiri@nvidia.com,
 netdev@vger.kernel.org

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Fri, 4 Jul 2025 15:27:51 +0300 you wrote:
> This series adds support for configuring bandwidth allocation per
> traffic class (TC) through the devlink-rate interface. It introduces a
> new 'tc-bw' attribute, allowing users to define how bandwidth is
> distributed across up to 8 traffic classes in a single command. This
> enables fine-grained traffic shaping and supports use cases such as
> Enhanced Transmission Selection (ETS) as defined by IEEE 802.1Qaz.
> 
> [...]

Here is the summary with links:
  - [iproute2-next,1/2] devlink: Update uapi headers
    (no matching commit)
  - [iproute2-next,2/2] Add support for 'tc-bw' attribute in devlink-rate
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=c83d1477f8b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



