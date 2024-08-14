Return-Path: <netdev+bounces-118281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8AA95125D
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 04:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC0441F22AEA
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 02:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE1E182B5;
	Wed, 14 Aug 2024 02:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNCAOCuy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5971FA1;
	Wed, 14 Aug 2024 02:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723602629; cv=none; b=pxlI6PVoRlOCRmfL/xjRJvKHjrogDkUKLgqX4T3USgR/zAziOgkQW5u0DKl68ZdaxfJ0TQKF+LX5OSYDfO39tTIvS6Mvv1s0Osqtw4T2cN8J9hSi5HpllRpRCg5Ve+e1S2IA/CECrVohStEKqzi8Dbas/pszs+VVuqUKLqd/6Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723602629; c=relaxed/simple;
	bh=ehqggSi9DnlgbOGLez2+cvFWx8+K9SFjjv4gTht/Pdg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IvULYaHucI/uMVdiacXWarHOZv64iKj24JhrQ/dR62IY28vkFyFJLvV0d2qar3zQ9MpOz2R5V/uXXH3w64axvrgyVnGfEmM0cneFLMHmnsePko/TrjTNOgkZ3Li6QJcmMW6oLRvBokfGbd3Q1CsZKBkIiAQ1uudJr0qkwxW7VCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNCAOCuy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2EF8C32782;
	Wed, 14 Aug 2024 02:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723602628;
	bh=ehqggSi9DnlgbOGLez2+cvFWx8+K9SFjjv4gTht/Pdg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GNCAOCuy8axoMfQFrqsoSrRnedTQZltKVjnFBbMMS8kLJqCyGxuGNO/+ilNuzmstq
	 kqpOWlmt+QL4u5k7ToH+71RXZ9KQVTek0JU+NqR3i416KYra6LF+5exzUaE8VReQYK
	 eCtITT53wuKbIpm78h3+1Qj6QvHy9f3d50nPSytpSLaRbtCuD2xDrpTWhL1Qyi7/KF
	 WGrL5GtibgourIRoFVFhz7W1dpfWbuVXOfiA9/PbAw8t560dBsiIMMvntrM8xCA1sA
	 TXejZB5wNlUqvq9cWAxur/pPOi+4N2GyXe5LiCGt9gbneJebE4unsGzl4ZVZkO3poe
	 lAEofycXPAs5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CE43823327;
	Wed, 14 Aug 2024 02:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] mptcp: correct MPTCP_SUBFLOW_ATTR_SSN_OFFSET
 reserved size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172360262801.1842448.3529218494116542266.git-patchwork-notify@kernel.org>
Date: Wed, 14 Aug 2024 02:30:28 +0000
References: <20240812065024.GA19719@asgard.redhat.com>
In-Reply-To: <20240812065024.GA19719@asgard.redhat.com>
To: Eugene Syromiatnikov <esyr@redhat.com>
Cc: mptcp@lists.linux.dev, matttbe@kernel.org, martineau@kernel.org,
 geliang@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dcaratti@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Aug 2024 08:51:23 +0200 you wrote:
> ssn_offset field is u32 and is placed into the netlink response with
> nla_put_u32(), but only 2 bytes are reserved for the attribute payload
> in subflow_get_info_size() (even though it makes no difference
> in the end, as it is aligned up to 4 bytes).  Supply the correct
> argument to the relevant nla_total_size() call to make it less
> confusing.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] mptcp: correct MPTCP_SUBFLOW_ATTR_SSN_OFFSET reserved size
    https://git.kernel.org/netdev/net/c/655111b838cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



