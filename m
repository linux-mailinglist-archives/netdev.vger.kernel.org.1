Return-Path: <netdev+bounces-207908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C10B08FD7
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 16:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A98256650B
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 14:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06552F85D3;
	Thu, 17 Jul 2025 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSwqYNaw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60052F85D1;
	Thu, 17 Jul 2025 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752763805; cv=none; b=sfxFaiivmd8onSvviDfrJD1pWootifIF+fiJysOeX/iqr6hO6vkHLeLQ9/PlvgZYDyZctn6oNn3hHuLVD/3OWgwE/M9bqCiM8xKd0IBagmIimeeyKj6vnuCouDFfgdNvdVkbT6cTEdAuFL3GQZbl3yNxksS2vjMv9pn3OnLe/ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752763805; c=relaxed/simple;
	bh=QAnmNUKgNLHn47abrSUtVM/9GiS0L3CE1Q3Lkr1ccbU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NMo/3+uIFFBxwRs/lflmNTPVSj7veysRHnY6+X3qy5MtIqXzDuPkb6c3q5HYN2/tadNgHM6HZ2RulaCfIq4/PP1swy7u/LNdRSbgA/7APAYgHvC8RoXgD8jjrJvni0hu9qRzbV6W14M+Io4626NDPbfcnDdb9ibnN4gFOQAEVg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSwqYNaw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DF3C4CEE3;
	Thu, 17 Jul 2025 14:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752763805;
	bh=QAnmNUKgNLHn47abrSUtVM/9GiS0L3CE1Q3Lkr1ccbU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qSwqYNaw3d3y8jPGC4zq3hZdPf6JHroqx/MKRBREtJ1mKQHL0CmrI6S4V8c59Cw0M
	 uIamhxnrLHZzUAIRYBsU9J/zVQejMNQjuS8LOiWxbw200yrXWjL6rwgKmSFzRQ2P8J
	 yEoDolxZV9Iyy4zlytHPASDe4dXVo/BVRKav1ShafdpUdx+VX19myakPq+chpKjbAE
	 e0gaoKPAYjXgaiDfg89kuem1qpqxQMV4raQTbxUYjSdxk3tvPTbBOllPnbi+tjIV+A
	 hu6b8Isd+rS2DcdEU+7X5ZZAHMGc59jwGWMsn4Ub/3ry5sGpEHNsaxHeyr7/SbIXtB
	 qGDqXryJ8W1pQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C5C383BF47;
	Thu, 17 Jul 2025 14:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] net: bridge: Do not offload IGMP/MLD messages
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175276382500.1959085.4099760417199249498.git-patchwork-notify@kernel.org>
Date: Thu, 17 Jul 2025 14:50:25 +0000
References: <20250716153551.1830255-1-Joseph.Huang@garmin.com>
In-Reply-To: <20250716153551.1830255-1-Joseph.Huang@garmin.com>
To: Joseph Huang <Joseph.Huang@garmin.com>
Cc: netdev@vger.kernel.org, joseph.huang.2024@gmail.com, razor@blackwall.org,
 idosch@nvidia.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, vladimir.oltean@nxp.com,
 f.fainelli@gmail.com, tobias@waldekranz.com, bridge@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Jul 2025 11:35:50 -0400 you wrote:
> Do not offload IGMP/MLD messages as it could lead to IGMP/MLD Reports
> being unintentionally flooded to Hosts. Instead, let the bridge decide
> where to send these IGMP/MLD messages.
> 
> Consider the case where the local host is sending out reports in response
> to a remote querier like the following:
> 
> [...]

Here is the summary with links:
  - [v3,net] net: bridge: Do not offload IGMP/MLD messages
    https://git.kernel.org/netdev/net/c/683dc24da8bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



